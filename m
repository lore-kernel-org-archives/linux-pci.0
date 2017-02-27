Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58762 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751531AbdB0UYm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Feb 2017 15:24:42 -0500
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Harv Abdulhamid <harba@qti.qualcomm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shanker Donthineni <shankerd@qti.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@qti.qualcomm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nate Watterson <nwatters@qti.qualcomm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org
Subject: [RFC PATCH 12/30] iommu/arm-smmu-v3: Keep track of process address spaces
Date: Mon, 27 Feb 2017 19:54:23 +0000
Message-Id: <20170227195441.5170-13-jean-philippe.brucker@arm.com>
In-Reply-To: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Binding to a task requires the following steps:

* Pin down the mm context, and use its ASID to tag SMMU mappings. If
  the ASID is already in use by the SMMU for a domain using the DMA API,
  abort the binding. We can steal the domain's ASID since it is allocated
  by the SMMU, but this deserves a patch of its own.

* Register an MMU notifier to mirror invalidations of the system's TLBs
  with a device's ATC.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 171 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 169 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 5b4d1f265194..ab49164bf09b 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -29,6 +29,8 @@
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
+#include <linux/mmu_context.h>
+#include <linux/mmu_notifier.h>
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of.h>
@@ -761,6 +763,9 @@ struct arm_smmu_task {
 
 	struct arm_smmu_s1_cfg		s1_cfg;
 
+	struct mmu_notifier		mmu_notifier;
+	struct mm_struct		*mm;
+
 	struct kref			kref;
 };
 
@@ -1984,6 +1989,33 @@ static size_t arm_smmu_atc_invalidate_domain(struct arm_smmu_domain *smmu_domain
 	return size;
 }
 
+static size_t arm_smmu_atc_invalidate_task(struct arm_smmu_task *smmu_task,
+					   unsigned long iova, size_t size)
+{
+	struct arm_smmu_cmdq_ent cmd;
+	struct arm_smmu_context *smmu_context;
+	struct arm_smmu_device *smmu = smmu_task->smmu;
+	struct arm_smmu_cmdq_ent sync_cmd = {
+		.opcode = CMDQ_OP_CMD_SYNC,
+	};
+
+	arm_smmu_atc_invalidate_to_cmd(smmu, iova, size, &cmd);
+	cmd.substream_valid = true;
+
+	spin_lock(&smmu->contexts_lock);
+
+	list_for_each_entry(smmu_context, &smmu_task->contexts, task_head) {
+		cmd.atc.ssid = smmu_context->ssid;
+		arm_smmu_atc_invalidate_master(smmu_context->master, &cmd);
+	}
+
+	spin_unlock(&smmu->contexts_lock);
+
+	arm_smmu_cmdq_issue_cmd(smmu, &sync_cmd);
+
+	return size;
+}
+
 /* IOMMU API */
 static bool arm_smmu_capable(enum iommu_cap cap)
 {
@@ -2105,26 +2137,148 @@ static void arm_smmu_put_context(struct arm_smmu_device *smmu,
 	spin_unlock(&smmu->contexts_lock);
 }
 
+static struct arm_smmu_task *mn_to_task(struct mmu_notifier *mn)
+{
+	return container_of(mn, struct arm_smmu_task, mmu_notifier);
+}
+
+static void arm_smmu_notifier_invalidate_range(struct mmu_notifier *mn,
+					       struct mm_struct *mm,
+					       unsigned long start,
+					       unsigned long end)
+{
+	struct arm_smmu_task *smmu_task = mn_to_task(mn);
+
+	arm_smmu_atc_invalidate_task(smmu_task, start, end - start);
+}
+
+static void arm_smmu_notifier_invalidate_page(struct mmu_notifier *mn,
+					      struct mm_struct *mm,
+					      unsigned long address)
+{
+	arm_smmu_notifier_invalidate_range(mn, mm, address, address + PAGE_SIZE);
+}
+
+static int arm_smmu_notifier_clear_flush_young(struct mmu_notifier *mn,
+					       struct mm_struct *mm,
+					       unsigned long start,
+					       unsigned long end)
+{
+	arm_smmu_notifier_invalidate_range(mn, mm, start, end);
+
+	return 0;
+}
+
+static const struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
+	.invalidate_page	= arm_smmu_notifier_invalidate_page,
+	.invalidate_range	= arm_smmu_notifier_invalidate_range,
+	.clear_flush_young	= arm_smmu_notifier_clear_flush_young,
+};
+
+static int arm_smmu_context_share(struct arm_smmu_task *smmu_task, int asid)
+{
+	int ret = 0;
+	struct arm_smmu_device *smmu = smmu_task->smmu;
+
+	if (test_and_set_bit(asid, smmu->asid_map))
+		/* ASID is already used for a domain */
+		return -EEXIST;
+
+	return ret;
+}
+
+static int arm_smmu_init_task_pgtable(struct arm_smmu_task *smmu_task)
+{
+	int ret;
+	int asid;
+
+	/* Pin ASID on the CPU side */
+	asid = mm_context_get(smmu_task->mm);
+	if (!asid)
+		return -ENOSPC;
+
+	ret = arm_smmu_context_share(smmu_task, asid);
+	if (ret) {
+		mm_context_put(smmu_task->mm);
+		return ret;
+	}
+
+	/* TODO: Initialize the rest of s1_cfg */
+	smmu_task->s1_cfg.asid = asid;
+
+	return 0;
+}
+
+static void arm_smmu_free_task_pgtable(struct arm_smmu_task *smmu_task)
+{
+	struct arm_smmu_device *smmu = smmu_task->smmu;
+
+	mm_context_put(smmu_task->mm);
+
+	arm_smmu_bitmap_free(smmu->asid_map, smmu_task->s1_cfg.asid);
+}
+
 __maybe_unused
 static struct arm_smmu_task *arm_smmu_alloc_task(struct arm_smmu_device *smmu,
 						 struct task_struct *task)
 {
+	int ret;
+	struct mm_struct *mm;
 	struct arm_smmu_task *smmu_task;
 
+	mm = get_task_mm(task);
+	if (!mm)
+		return ERR_PTR(-EINVAL);
+
 	smmu_task = kzalloc(sizeof(*smmu_task), GFP_KERNEL);
-	if (!smmu_task)
-		return ERR_PTR(-ENOMEM);
+	if (!smmu_task) {
+		ret = -ENOMEM;
+		goto err_put_mm;
+	}
 
 	smmu_task->smmu = smmu;
 	smmu_task->pid = get_task_pid(task, PIDTYPE_PID);
+	smmu_task->mmu_notifier.ops = &arm_smmu_mmu_notifier_ops;
+	smmu_task->mm = mm;
 	INIT_LIST_HEAD(&smmu_task->contexts);
 	kref_init(&smmu_task->kref);
 
+	ret = arm_smmu_init_task_pgtable(smmu_task);
+	if (ret)
+		goto err_free_task;
+
+	/*
+	 * TODO: check conflicts between task mappings and reserved HW
+	 * mappings. It is unclear which reserved mappings might be affected
+	 * because, for instance, devices are unlikely to send MSIs tagged with
+	 * PASIDs so we (probably) don't need to carve out MSI regions from the
+	 * task address space. Clarify this.
+	 */
+
+	ret = mmu_notifier_register(&smmu_task->mmu_notifier, mm);
+	if (ret)
+		goto err_free_pgtable;
+
 	spin_lock(&smmu->contexts_lock);
 	list_add(&smmu_task->smmu_head, &smmu->tasks);
 	spin_unlock(&smmu->contexts_lock);
 
+	/* A reference to mm is kept by the notifier */
+	mmput(mm);
+
 	return smmu_task;
+
+err_free_pgtable:
+	arm_smmu_free_task_pgtable(smmu_task);
+
+err_free_task:
+	put_pid(smmu_task->pid);
+	kfree(smmu_task);
+
+err_put_mm:
+	mmput(mm);
+
+	return ERR_PTR(ret);
 }
 
 /* Caller must hold contexts_lock */
@@ -2151,8 +2305,21 @@ static void arm_smmu_free_task(struct kref *kref)
 
 	list_del(&smmu_task->smmu_head);
 
+	/*
+	 * Release the lock temporarily to unregister the notifier. This is safe
+	 * because the task is not accessible anymore.
+	 */
+	spin_unlock(&smmu->contexts_lock);
+
+	/* Unpin ASID */
+	arm_smmu_free_task_pgtable(smmu_task);
+
+	mmu_notifier_unregister(&smmu_task->mmu_notifier, smmu_task->mm);
+
 	put_pid(smmu_task->pid);
 	kfree(smmu_task);
+
+	spin_lock(&smmu->contexts_lock);
 }
 
 static void _arm_smmu_put_task(struct arm_smmu_task *smmu_task)
-- 
2.11.0
