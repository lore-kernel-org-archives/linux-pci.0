Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Li, Zhen-Hua" <zhen-hual@hp.com>
To: <dwmw2@infradead.org>, <indou.takao@jp.fujitsu.com>,
	<bhe@redhat.com>, <joro@8bytes.org>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>
Cc: <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <kexec@lists.infradead.org>,
	<alex.williamson@redhat.com>, <ddutile@redhat.com>,
	<ishii.hironobu@jp.fujitsu.com>, <bhelgaas@google.com>,
	<doug.hatch@hp.com>, <jerry.hoemann@hp.com>, <tom.vaden@hp.com>,
	<li.zhang6@hp.com>, <lisa.mitchell@hp.com>,
	<billsumnerlinux@gmail.com>, <zhen-hual@hp.com>, <rwright@hp.com>
Subject: [PATCH v10 10/10] iommu/vt-d: Use old irte in kdump kernel
Date: Fri, 10 Apr 2015 16:42:13 +0800
Message-Id: <1428655333-19504-11-git-send-email-zhen-hual@hp.com>
In-Reply-To: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix the intr-remapping fault.

[1.594890] dmar: DRHD: handling fault status reg 2
[1.594894] dmar: INTR-REMAP: Request device [[41:00.0] fault index 4d
[1.594894] INTR-REMAP:[fault reason 34] Present field in the IRTE entry
is clear

Use old irte in second kernel, do not disable and re-enable interrupt
remapping.

Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
---
 drivers/iommu/intel_irq_remapping.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index e6426a0..02615a6 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -197,6 +197,10 @@ static int modify_irte(int irq, struct irte *irte_modified)
 
 	set_64bit(&irte->low, irte_modified->low);
 	set_64bit(&irte->high, irte_modified->high);
+
+	if (iommu->pre_enabled_ir)
+		__iommu_update_old_irte(iommu, index);
+
 	__iommu_flush_cache(iommu, irte, sizeof(*irte));
 
 	rc = qi_flush_iec(iommu, index, 0);
@@ -258,6 +262,9 @@ static int clear_entries(struct irq_2_iommu *irq_iommu)
 	bitmap_release_region(iommu->ir_table->bitmap, index,
 			      irq_iommu->irte_mask);
 
+	if (iommu->pre_enabled_ir)
+		__iommu_update_old_irte(iommu, -1);
+
 	return qi_flush_iec(iommu, index, irq_iommu->irte_mask);
 }
 
@@ -660,11 +667,13 @@ static int __init intel_enable_irq_remapping(void)
 		 */
 		dmar_fault(-1, iommu);
 
+		iommu_check_pre_ir_status(iommu);
+
 		/*
-		 * Disable intr remapping and queued invalidation, if already
-		 * enabled prior to OS handover.
+		 * Here we do not disable intr remapping,
+		 * if already enabled prior to OS handover.
 		 */
-		iommu_disable_irq_remapping(iommu);
+		/* iommu_disable_irq_remapping(iommu); */
 
 		dmar_disable_qi(iommu);
 	}
@@ -700,7 +709,18 @@ static int __init intel_enable_irq_remapping(void)
 	 * Setup Interrupt-remapping for all the DRHD's now.
 	 */
 	for_each_iommu(iommu, drhd) {
-		iommu_set_irq_remapping(iommu, eim);
+		if (iommu->pre_enabled_ir) {
+			unsigned long long q;
+
+			q = dmar_readq(iommu->reg + DMAR_IRTA_REG);
+			iommu->ir_table->base_old_phys = q & VTD_PAGE_MASK;
+			iommu->ir_table->base_old_virt = ioremap_cache(
+				iommu->ir_table->base_old_phys,
+				INTR_REMAP_TABLE_ENTRIES*sizeof(struct irte));
+			__iommu_load_old_irte(iommu);
+		} else
+			iommu_set_irq_remapping(iommu, eim);
+
 		setup = 1;
 	}
 
-- 
2.0.0-rc0

