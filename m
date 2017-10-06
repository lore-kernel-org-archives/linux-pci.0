Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        gabriele.paoloni@huawei.com, nwatters@codeaurora.org,
        okaya@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com
Subject: [RFCv2 PATCH 21/36] iommu/arm-smmu-v3: Implement process operations
Date: Fri,  6 Oct 2017 14:31:48 +0100
Message-Id: <20171006133203.22803-22-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hook process operations to support PASID and page table sharing with the
SMMUv3:

* process_allocate pins down its ASID and initializes the context
  descriptor fields.
* process_free releases the ASID.
* process_attach checks device capabilities and writes the context
  descriptor. More work is required to ensure that the process' ASID isn't
  being used for io-pgtables.
* process_detach clears the context descriptor and sends required
  invalidations.
* process_invalidate sends required invalidations.
* process_exit stops us of the PASID, clears the context descriptor and
  performs required invalidations.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 207 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 207 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 71fc3a2c8a95..c86a1182c137 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -29,6 +29,7 @@
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
+#include <linux/mmu_context.h>
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of.h>
@@ -37,6 +38,7 @@
 #include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/sched/mm.h>
 
 #include <linux/amba/bus.h>
 
@@ -642,6 +644,7 @@ struct arm_smmu_strtab_cfg {
 
 struct arm_smmu_asid_state {
 	struct arm_smmu_domain		*domain;
+	unsigned long			refs;
 };
 
 /* An SMMUv3 instance */
@@ -712,6 +715,9 @@ struct arm_smmu_master_data {
 	struct device			*dev;
 
 	size_t				num_ssids;
+	bool				can_fault;
+	/* Number of processes attached */
+	int				processes;
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -740,6 +746,11 @@ struct arm_smmu_domain {
 	spinlock_t			devices_lock;
 };
 
+struct arm_smmu_process {
+	struct iommu_process		process;
+	struct arm_smmu_ctx_desc	ctx_desc;
+};
+
 struct arm_smmu_option_prop {
 	u32 opt;
 	const char *prop;
@@ -766,6 +777,11 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 	return container_of(dom, struct arm_smmu_domain, domain);
 }
 
+static struct arm_smmu_process *to_smmu_process(struct iommu_process *process)
+{
+	return container_of(process, struct arm_smmu_process, process);
+}
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -2032,6 +2048,13 @@ static void arm_smmu_detach_dev(struct device *dev)
 	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
 	struct arm_smmu_domain *smmu_domain = master->domain;
 
+	/*
+	 * Core is preventing concurrent calls between attach and bind, so this
+	 * read only races with process_exit (FIXME).
+	 */
+	if (master->processes)
+		__iommu_process_unbind_dev_all(&smmu_domain->domain, dev);
+
 	if (smmu_domain) {
 		spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 		list_del(&master->list);
@@ -2143,6 +2166,184 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 	return ops->iova_to_phys(ops, iova);
 }
 
+static int arm_smmu_process_init_pgtable(struct arm_smmu_process *smmu_process,
+					 struct mm_struct *mm)
+{
+	int asid;
+
+	asid = mm_context_get(mm);
+	if (!asid)
+		return -ENOSPC;
+
+	smmu_process->ctx_desc.asid = asid;
+	/* TODO: init the rest */
+
+	return 0;
+}
+
+static struct iommu_process *arm_smmu_process_alloc(struct task_struct *task)
+{
+	int ret;
+	struct mm_struct *mm;
+	struct arm_smmu_process *smmu_process;
+
+	smmu_process = kzalloc(sizeof(*smmu_process), GFP_KERNEL);
+
+	mm = get_task_mm(task);
+	if (!mm) {
+		kfree(smmu_process);
+		return NULL;
+	}
+
+	ret = arm_smmu_process_init_pgtable(smmu_process, mm);
+	mmput(mm);
+	if (ret) {
+		kfree(smmu_process);
+		return NULL;
+	}
+
+	return &smmu_process->process;
+}
+
+static void arm_smmu_process_free(struct iommu_process *process)
+{
+	struct arm_smmu_process *smmu_process = to_smmu_process(process);
+
+	/* Unpin ASID */
+	mm_context_put(process->mm);
+
+	kfree(smmu_process);
+}
+
+static int arm_smmu_process_share(struct arm_smmu_domain *smmu_domain,
+				  struct arm_smmu_process *smmu_process)
+{
+	int asid, ret;
+	struct arm_smmu_asid_state *asid_state;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	asid = smmu_process->ctx_desc.asid;
+
+	asid_state = idr_find(&smmu->asid_idr, asid);
+	if (asid_state && asid_state->domain) {
+		return -EEXIST;
+	} else if (asid_state) {
+		asid_state->refs++;
+		return 0;
+	}
+
+	asid_state = kzalloc(sizeof(*asid_state), GFP_ATOMIC);
+	asid_state->refs = 1;
+
+	if (!asid_state)
+		return -ENOMEM;
+
+	ret = idr_alloc(&smmu->asid_idr, asid_state, asid, asid + 1, GFP_ATOMIC);
+	return ret < 0 ? ret : 0;
+}
+
+static int arm_smmu_process_attach(struct iommu_domain *domain,
+				   struct device *dev,
+				   struct iommu_process *process, bool first)
+{
+	int ret;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_process *smmu_process = to_smmu_process(process);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_SVM))
+		return -ENODEV;
+
+	/* TODO: process->no_pasid */
+	if (process->pasid >= master->num_ssids)
+		return -ENODEV;
+
+	/* TODO: process->no_need_for_pri_ill_pin_everything */
+	if (!master->can_fault)
+		return -ENODEV;
+
+	master->processes++;
+
+	if (!first)
+		return 0;
+
+	spin_lock(&smmu->asid_lock);
+	ret = arm_smmu_process_share(smmu_domain, smmu_process);
+	spin_unlock(&smmu->asid_lock);
+	if (ret)
+		return ret;
+
+	arm_smmu_write_ctx_desc(smmu_domain, process->pasid, &smmu_process->ctx_desc);
+
+	return 0;
+}
+
+static void arm_smmu_process_detach(struct iommu_domain *domain,
+				    struct device *dev,
+				    struct iommu_process *process, bool last)
+{
+	struct arm_smmu_asid_state *asid_state;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_process *smmu_process = to_smmu_process(process);
+	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	master->processes--;
+
+	if (last) {
+		spin_lock(&smmu->asid_lock);
+		asid_state = idr_find(&smmu->asid_idr, smmu_process->ctx_desc.asid);
+		if (--asid_state->refs == 0) {
+			idr_remove(&smmu->asid_idr, smmu_process->ctx_desc.asid);
+			kfree(asid_state);
+		}
+		spin_unlock(&smmu->asid_lock);
+
+		arm_smmu_write_ctx_desc(smmu_domain, process->pasid, NULL);
+	}
+
+	/* TODO: Invalidate ATC. */
+	/* TODO: Invalidate all mappings if last and not DVM. */
+}
+
+static void arm_smmu_process_invalidate(struct iommu_domain *domain,
+					struct iommu_process *process,
+					unsigned long iova, size_t size)
+{
+	/*
+	 * TODO: Invalidate ATC.
+	 * TODO: Invalidate mapping if not DVM
+	 */
+}
+
+static void arm_smmu_process_exit(struct iommu_domain *domain,
+				  struct iommu_process *process)
+{
+	struct arm_smmu_master_data *master;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	if (!domain->process_exit)
+		return;
+
+	spin_lock(&smmu_domain->devices_lock);
+	list_for_each_entry(master, &smmu_domain->devices, list) {
+		if (!master->processes)
+			continue;
+
+		master->processes--;
+		domain->process_exit(domain, master->dev, process->pasid,
+				     domain->process_exit_token);
+
+		/* TODO: inval ATC */
+	}
+	spin_unlock(&smmu_domain->devices_lock);
+
+	arm_smmu_write_ctx_desc(smmu_domain, process->pasid, NULL);
+
+	/* TODO: Invalidate all mappings if not DVM */
+}
+
 static struct platform_driver arm_smmu_driver;
 
 static int arm_smmu_match_node(struct device *dev, void *data)
@@ -2351,6 +2552,12 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_alloc		= arm_smmu_domain_alloc,
 	.domain_free		= arm_smmu_domain_free,
 	.attach_dev		= arm_smmu_attach_dev,
+	.process_alloc		= arm_smmu_process_alloc,
+	.process_free		= arm_smmu_process_free,
+	.process_attach		= arm_smmu_process_attach,
+	.process_detach		= arm_smmu_process_detach,
+	.process_invalidate	= arm_smmu_process_invalidate,
+	.process_exit		= arm_smmu_process_exit,
 	.map			= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
 	.map_sg			= default_iommu_map_sg,
-- 
2.13.3

