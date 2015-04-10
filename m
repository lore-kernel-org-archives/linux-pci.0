Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53]:6582 "EHLO
	g4t3425.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932494AbbDJIny (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2015 04:43:54 -0400
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
Subject: [PATCH v10 06/10] iommu/vt-d: datatypes and functions used for kdump
Date: Fri, 10 Apr 2015 16:42:09 +0800
Message-Id: <1428655333-19504-7-git-send-email-zhen-hual@hp.com>
In-Reply-To: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Populate it with support functions to copy iommu translation tables from
from the panicked kernel into the kdump kernel in the event of a crash.

Functions:
    Use old root entry table, and load the old data to root_entry as cache.
    Malloc new context table and copy old context table to the new one.

Bill Sumner:
    Original version, the creation of the data types and functions.

Li, Zhenhua:
    Create new function iommu_check_pre_te_status() to check status.
    Update the caller of context_get_* and context_put*, use context_*
        and context_set_* for replacement.
    Update the name of the function that loads root entry table.
    Use new function to copy old context entry tables and page tables.
    Use "unsigned long" for physical address.
    Remove the functions to copy page table in Bill's version.
    Remove usage of dve and ppap in Bill's version.

Signed-off-by: Bill Sumner <billsumnerlinux@gmail.com>
Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
---
 drivers/iommu/intel-iommu.c | 121 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |   3 ++
 2 files changed, 124 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ef8a99c..78c1d65 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -388,6 +388,18 @@ struct iommu_remapped_entry {
 static LIST_HEAD(__iommu_remapped_mem);
 static DEFINE_MUTEX(__iommu_mem_list_lock);
 
+/* ========================================================================
+ * Copy iommu translation tables from old kernel into new  kernel.
+ * Entry to this set of functions is: intel_iommu_load_translation_tables()
+ * ------------------------------------------------------------------------
+ */
+
+static int copy_root_entry_table(struct intel_iommu *iommu);
+
+static int intel_iommu_load_translation_tables(struct intel_iommu *iommu);
+
+static void iommu_check_pre_te_status(struct intel_iommu *iommu);
+
 /*
  * This domain is a statically identity mapping domain.
  *	1. This domain creats a static 1:1 mapping to all usable memory.
@@ -4971,3 +4983,112 @@ static void __iommu_update_old_root_entry(struct intel_iommu *iommu, int index)
 	__iommu_flush_cache(iommu, to + start, size);
 }
 
+/*
+ * Load root entry tables from old kernel.
+ */
+static int copy_root_entry_table(struct intel_iommu *iommu)
+{
+	u32 bus;				/* Index: root-entry-table */
+	struct root_entry  *re;			/* Virt(iterator: new table) */
+	unsigned long context_old_phys;		/* Phys(context table entry) */
+	struct context_entry *context_new_virt;	/* Virt(new context_entry) */
+
+	/*
+	 * A new root entry table has been allocated ,
+	 * we need copy re from old kernel to the new allocated one.
+	 */
+
+	if (!iommu->root_entry_old_phys)
+		return -ENOMEM;
+
+	for (bus = 0, re = iommu->root_entry; bus < 256; bus += 1, re += 1) {
+		if (!root_present(re))
+			continue;
+
+		context_old_phys = get_context_phys_from_root(re);
+
+		if (!context_old_phys)
+			continue;
+
+		context_new_virt =
+			(struct context_entry *)alloc_pgtable_page(iommu->node);
+
+		if (!context_new_virt)
+			return -ENOMEM;
+
+		__iommu_load_from_oldmem(context_new_virt,
+					context_old_phys,
+					VTD_PAGE_SIZE);
+
+		__iommu_flush_cache(iommu, context_new_virt, VTD_PAGE_SIZE);
+
+		set_root_value(re, virt_to_phys(context_new_virt));
+	}
+
+	return 0;
+}
+
+/*
+ * Interface to the "load translation tables" set of functions
+ * from mainline code.
+ */
+static int intel_iommu_load_translation_tables(struct intel_iommu *iommu)
+{
+	unsigned long long q;		/* quadword scratch */
+	int ret = 0;			/* Integer return code */
+	unsigned long flags;
+
+	q = dmar_readq(iommu->reg + DMAR_RTADDR_REG);
+	if (!q)
+		return -1;
+
+	spin_lock_irqsave(&iommu->lock, flags);
+
+	/* Load the root-entry table from the old kernel
+	 * foreach context_entry_table in root_entry
+	 *   Copy each entry table from old kernel
+	 */
+	if (!iommu->root_entry) {
+		iommu->root_entry =
+			(struct root_entry *)alloc_pgtable_page(iommu->node);
+		if (!iommu->root_entry) {
+			spin_unlock_irqrestore(&iommu->lock, flags);
+			return -ENOMEM;
+		}
+	}
+
+	iommu->root_entry_old_phys = q & VTD_PAGE_MASK;
+	if (!iommu->root_entry_old_phys) {
+		pr_err("Could not read old root entry address.");
+		return -1;
+	}
+
+	iommu->root_entry_old_virt = ioremap_cache(iommu->root_entry_old_phys,
+						VTD_PAGE_SIZE);
+	if (!iommu->root_entry_old_virt) {
+		pr_err("Could not map the old root entry.");
+		return -ENOMEM;
+	}
+
+	__iommu_load_old_root_entry(iommu);
+	ret = copy_root_entry_table(iommu);
+	__iommu_flush_cache(iommu, iommu->root_entry, PAGE_SIZE);
+	__iommu_update_old_root_entry(iommu, -1);
+
+	spin_unlock_irqrestore(&iommu->lock, flags);
+
+	__iommu_free_mapped_mem();
+
+	return ret;
+}
+
+static void iommu_check_pre_te_status(struct intel_iommu *iommu)
+{
+	u32 sts;
+
+	sts = readl(iommu->reg + DMAR_GSTS_REG);
+	if (sts & DMA_GSTS_TES) {
+		pr_info("Translation is enabled prior to OS.\n");
+		iommu->pre_enabled_trans = 1;
+	}
+}
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 6fa0804..9ca025a 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -328,6 +328,9 @@ struct intel_iommu {
 	spinlock_t	lock; /* protect context, domain ids */
 	struct root_entry *root_entry; /* virtual address */
 
+	/* whether translation is enabled prior to OS*/
+	u8		pre_enabled_trans;
+
 	void __iomem	*root_entry_old_virt; /* mapped from old root entry */
 	unsigned long	root_entry_old_phys; /* root entry in old kernel */
 
-- 
2.0.0-rc0

