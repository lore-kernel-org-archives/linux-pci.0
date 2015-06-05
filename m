Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Cc: zhen-hual@hp.com, bhe@redhat.com, dwmw2@infradead.org,
	vgoyal@redhat.com, dyoung@redhat.com, alex.williamson@redhat.com,
	ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com,
	indou.takao@jp.fujitsu.com, bhelgaas@google.com, doug.hatch@hp.com,
	jerry.hoemann@hp.com, tom.vaden@hp.com, li.zhang6@hp.com,
	lisa.mitchell@hp.com, billsumnerlinux@gmail.com, rwright@hp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, joro@8bytes.org, jroedel@suse.de
Subject: [PATCH 17/17] iommu/vt-d: Remove update code for old ir-table
Date: Fri,  5 Jun 2015 16:11:03 +0200
Message-Id: <1433513463-19128-18-git-send-email-joro@8bytes.org>
In-Reply-To: <1433513463-19128-1-git-send-email-joro@8bytes.org>
References: <1433513463-19128-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

The code to update the irq remapping table of the old kernel
is not necessary anymore because we switch immidiatly to the
new table after we copied the data over.

Tested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel_irq_remapping.c | 44 -------------------------------------
 include/linux/intel-iommu.h         |  2 --
 2 files changed, 46 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 07a8e82..b49aa8c 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -22,7 +22,6 @@
 #include "irq_remapping.h"
 
 static int iommu_load_old_irte(struct intel_iommu *iommu);
-static int __iommu_update_old_irte(struct intel_iommu *iommu, int index);
 static void iommu_check_pre_ir_status(struct intel_iommu *iommu);
 static void iommu_disable_irq_remapping(struct intel_iommu *iommu);
 
@@ -202,9 +201,6 @@ static int modify_irte(int irq, struct irte *irte_modified)
 	set_64bit(&irte->low, irte_modified->low);
 	set_64bit(&irte->high, irte_modified->high);
 
-	if (iommu->pre_enabled_ir)
-		__iommu_update_old_irte(iommu, index);
-
 	__iommu_flush_cache(iommu, irte, sizeof(*irte));
 
 	rc = qi_flush_iec(iommu, index, 0);
@@ -266,9 +262,6 @@ static int clear_entries(struct irq_2_iommu *irq_iommu)
 	bitmap_release_region(iommu->ir_table->bitmap, index,
 			      irq_iommu->irte_mask);
 
-	if (iommu->pre_enabled_ir)
-		__iommu_update_old_irte(iommu, -1);
-
 	return qi_flush_iec(iommu, index, irq_iommu->irte_mask);
 }
 
@@ -1327,9 +1320,6 @@ static int iommu_load_old_irte(struct intel_iommu *iommu)
 
 	__iommu_flush_cache(iommu, iommu->ir_table->base, size);
 
-	iommu->ir_table->base_old_phys = irt_phys;
-	iommu->ir_table->base_old_virt = old_ir_table;
-
 	/*
 	 * Now check the table for used entries and mark those as
 	 * allocated in the bitmap
@@ -1342,40 +1332,6 @@ static int iommu_load_old_irte(struct intel_iommu *iommu)
 	return 0;
 }
 
-static int __iommu_update_old_irte(struct intel_iommu *iommu, int index)
-{
-	int start;
-	unsigned long size;
-	void __iomem *to;
-void *from;
-
-	if ((!iommu)
-		|| (!iommu->ir_table)
-		|| (!iommu->ir_table->base)
-		|| (!iommu->ir_table->base_old_phys)
-		|| (!iommu->ir_table->base_old_virt))
-		return -1;
-
-	if (index < -1 || index >= INTR_REMAP_TABLE_ENTRIES)
-		return -1;
-
-	if (index == -1) {
-		start = 0;
-		size = INTR_REMAP_TABLE_ENTRIES * sizeof(struct irte);
-	} else {
-		start = index * sizeof(struct irte);
-		size = sizeof(struct irte);
-	}
-
-	to = iommu->ir_table->base_old_virt;
-	from = iommu->ir_table->base;
-	memcpy(to + start, from + start, size);
-
-	__iommu_flush_cache(iommu, to + start, size);
-
-	return 0;
-}
-
 static void iommu_check_pre_ir_status(struct intel_iommu *iommu)
 {
 	u32 sts;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 5aa8834..9fcdd9a 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -302,8 +302,6 @@ struct q_inval {
 struct ir_table {
 	struct irte *base;
 	unsigned long *bitmap;
-	void __iomem *base_old_virt;
-	unsigned long base_old_phys;
 };
 #endif
 
-- 
1.9.1

