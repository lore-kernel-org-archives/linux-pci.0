Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753452AbeBLSdZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Feb 2018 13:33:25 -0500
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        xuzaibo@huawei.com, ilias.apalodimas@linaro.org,
        jonathan.cameron@huawei.com, shunyong.yang@hxt-semitech.com,
        nwatters@codeaurora.org, okaya@codeaurora.org,
        jcrouse@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com, christian.koenig@amd.com,
        bharatku@xilinx.com
Subject: [PATCH 25/37] iommu/arm-smmu-v3: Implement mm operations
Date: Mon, 12 Feb 2018 18:33:40 +0000
Message-Id: <20180212183352.22730-26-jean-philippe.brucker@arm.com>
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hook mm operations to support PASID and page table sharing with the
SMMUv3:

* mm_alloc allocates a context descriptor.
* mm_free releases the context descriptor.
* mm_attach checks device capabilities and writes the context descriptor.
* mm_detach clears the context descriptor and sends required
  invalidations.
* mm_invalidate sends required invalidations.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/Kconfig       |   1 +
 drivers/iommu/arm-smmu-v3.c | 131 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 4b272925ee78..d434f7085dc2 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -353,6 +353,7 @@ config ARM_SMMU_V3
 	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
 	depends on ARM64
 	select IOMMU_API
+	select IOMMU_SVA
 	select IOMMU_IO_PGTABLE_LPAE
 	select ARM_SMMU_V3_CONTEXT
 	select GENERIC_MSI_IRQ_DOMAIN
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 79bc5b5cceed..1cdeea7e22cb 100644
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
 
@@ -617,6 +619,7 @@ struct arm_smmu_master_data {
 	struct device			*dev;
 
 	size_t				ssid_bits;
+	bool				can_fault;
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -645,6 +648,13 @@ struct arm_smmu_domain {
 	spinlock_t			devices_lock;
 };
 
+struct arm_smmu_mm {
+	struct io_mm			io_mm;
+	struct iommu_pasid_entry	*cd;
+	/* Only for release ! */
+	struct iommu_pasid_table_ops	*ops;
+};
+
 struct arm_smmu_option_prop {
 	u32 opt;
 	const char *prop;
@@ -671,6 +681,11 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 	return container_of(dom, struct arm_smmu_domain, domain);
 }
 
+static struct arm_smmu_mm *to_smmu_mm(struct io_mm *io_mm)
+{
+	return container_of(io_mm, struct arm_smmu_mm, io_mm);
+}
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -1785,6 +1800,8 @@ static void arm_smmu_detach_dev(struct device *dev)
 	struct arm_smmu_domain *smmu_domain = master->domain;
 
 	if (smmu_domain) {
+		__iommu_sva_unbind_dev_all(dev);
+
 		spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 		list_del(&master->list);
 		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
@@ -1902,6 +1919,113 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 	return ops->iova_to_phys(ops, iova);
 }
 
+static int arm_smmu_sva_init(struct device *dev, unsigned long features,
+			     unsigned int *min_pasid, unsigned int *max_pasid)
+{
+	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
+
+	if (features & IOMMU_SVA_FEAT_IOPF && !master->can_fault)
+		return -EINVAL;
+
+	if (features & IOMMU_SVA_FEAT_PASID && !master->ssid_bits)
+		return -EINVAL;
+
+	if (!*max_pasid)
+		*max_pasid = 0xfffffU;
+
+	/* SSID support in the SMMU requires at least one SSID bit */
+	*min_pasid = max(*min_pasid, 1U);
+	*max_pasid = min(*max_pasid, (1U << master->ssid_bits) - 1);
+
+	return 0;
+}
+
+static void arm_smmu_sva_shutdown(struct device *dev)
+{
+}
+
+static struct io_mm *arm_smmu_mm_alloc(struct iommu_domain *domain,
+				       struct mm_struct *mm)
+{
+	struct arm_smmu_mm *smmu_mm;
+	struct iommu_pasid_entry *cd;
+	struct iommu_pasid_table_ops *ops;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return NULL;
+
+	smmu_mm = kzalloc(sizeof(*smmu_mm), GFP_KERNEL);
+	if (!smmu_mm)
+		return NULL;
+
+	smmu_mm->ops = ops = smmu_domain->s1_cfg.ops;
+	cd = ops->alloc_shared_entry(ops, mm);
+	if (IS_ERR(cd)) {
+		kfree(smmu_mm);
+		return ERR_CAST(cd);
+	}
+
+	smmu_mm->cd = cd;
+	return &smmu_mm->io_mm;
+}
+
+static void arm_smmu_mm_free(struct io_mm *io_mm)
+{
+	struct arm_smmu_mm *smmu_mm = to_smmu_mm(io_mm);
+
+	smmu_mm->ops->free_entry(smmu_mm->ops, smmu_mm->cd);
+	kfree(smmu_mm);
+}
+
+static int arm_smmu_mm_attach(struct iommu_domain *domain, struct device *dev,
+			      struct io_mm *io_mm, bool attach_domain)
+{
+	struct arm_smmu_mm *smmu_mm = to_smmu_mm(io_mm);
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct iommu_pasid_table_ops *ops = smmu_domain->s1_cfg.ops;
+	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
+
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return -EINVAL;
+
+	if (!(master->smmu->features & ARM_SMMU_FEAT_SVA))
+		return -ENODEV;
+
+	/* TODO: io_mm->no_need_for_pri_ill_pin_everything */
+	if (!master->can_fault)
+		return -ENODEV;
+
+	if (!attach_domain)
+		return 0;
+
+	return ops->set_entry(ops, io_mm->pasid, smmu_mm->cd);
+}
+
+static void arm_smmu_mm_detach(struct iommu_domain *domain, struct device *dev,
+			       struct io_mm *io_mm, bool detach_domain)
+{
+	struct arm_smmu_mm *smmu_mm = to_smmu_mm(io_mm);
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct iommu_pasid_table_ops *ops = smmu_domain->s1_cfg.ops;
+
+	if (detach_domain)
+		ops->clear_entry(ops, io_mm->pasid, smmu_mm->cd);
+
+	/* TODO: Invalidate ATC. */
+	/* TODO: Invalidate all mappings if last and not DVM. */
+}
+
+static void arm_smmu_mm_invalidate(struct iommu_domain *domain,
+				   struct device *dev, struct io_mm *io_mm,
+				   unsigned long iova, size_t size)
+{
+	/*
+	 * TODO: Invalidate ATC.
+	 * TODO: Invalidate mapping if not DVM
+	 */
+}
+
 static struct platform_driver arm_smmu_driver;
 
 static int arm_smmu_match_node(struct device *dev, void *data)
@@ -2108,6 +2232,13 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_alloc		= arm_smmu_domain_alloc,
 	.domain_free		= arm_smmu_domain_free,
 	.attach_dev		= arm_smmu_attach_dev,
+	.sva_device_init	= arm_smmu_sva_init,
+	.sva_device_shutdown	= arm_smmu_sva_shutdown,
+	.mm_alloc		= arm_smmu_mm_alloc,
+	.mm_free		= arm_smmu_mm_free,
+	.mm_attach		= arm_smmu_mm_attach,
+	.mm_detach		= arm_smmu_mm_detach,
+	.mm_invalidate		= arm_smmu_mm_invalidate,
 	.map			= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
 	.map_sg			= default_iommu_map_sg,
-- 
2.15.1
