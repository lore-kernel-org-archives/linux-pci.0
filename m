Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:59208 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423038AbbFEOLS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Jun 2015 10:11:18 -0400
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
Subject: [PATCH 06/17] iommu/vt-d: Rework loading of old root-entry table
Date: Fri,  5 Jun 2015 16:10:52 +0200
Message-Id: <1433513463-19128-7-git-send-email-joro@8bytes.org>
In-Reply-To: <1433513463-19128-1-git-send-email-joro@8bytes.org>
References: <1433513463-19128-1-git-send-email-joro@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Instead of keeping pointers to the old data structures
around forever, just map the old root entry table to copy
the context entries and make the new table immidiatly
visible to the hardware.

Tested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 216 +++++++++++++++-----------------------------
 include/linux/intel-iommu.h |   3 -
 2 files changed, 74 insertions(+), 145 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index cda0901..c0b72e8 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -371,10 +371,6 @@ static struct context_entry *device_to_existing_context_entry(
 				struct intel_iommu *iommu,
 				u8 bus, u8 devfn);
 
-static void __iommu_load_old_root_entry(struct intel_iommu *iommu);
-
-static void __iommu_update_old_root_entry(struct intel_iommu *iommu, int index);
-
 /*
  * A structure used to store the address allocated by ioremap();
  * The we need to call iounmap() to free them out of spin_lock_irqsave/unlock;
@@ -392,7 +388,8 @@ static DEFINE_MUTEX(__iommu_mem_list_lock);
  * ------------------------------------------------------------------------
  */
 
-static int copy_root_entry_table(struct intel_iommu *iommu);
+static int copy_root_entry_table(struct intel_iommu *iommu,
+				 struct root_entry *old_re);
 
 static int intel_iommu_load_translation_tables(struct intel_iommu *iommu);
 
@@ -798,9 +795,6 @@ static inline struct context_entry *iommu_context_addr(struct intel_iommu *iommu
 		phy_addr = virt_to_phys((void *)context);
 		*entry = phy_addr | 1;
 		__iommu_flush_cache(iommu, entry, sizeof(*entry));
-
-		if (iommu->pre_enabled_trans)
-			__iommu_update_old_root_entry(iommu, bus);
 	}
 	return &context[devfn];
 }
@@ -918,12 +912,6 @@ static void free_context_table(struct intel_iommu *iommu)
 
 	}
 
-	if (iommu->pre_enabled_trans) {
-		iommu->root_entry_old_phys = 0;
-		root = iommu->root_entry_old_virt;
-		iommu->root_entry_old_virt = NULL;
-	}
-
 	free_pgtable_page(iommu->root_entry);
 	iommu->root_entry = NULL;
 
@@ -2942,6 +2930,20 @@ static int __init init_dmars(void)
 		if (ret)
 			goto free_iommu;
 
+		if (!ecap_pass_through(iommu->ecap))
+			hw_pass_through = 0;
+
+		intel_iommu_init_qi(iommu);
+
+		/*
+		 * TBD:
+		 * We could share the same root & context tables
+		 * among all IOMMU's. Need to Split it later.
+		 */
+		ret = iommu_alloc_root_entry(iommu);
+		if (ret)
+			goto free_iommu;
+
 		iommu_check_pre_te_status(iommu);
 
 		/*
@@ -2957,35 +2959,43 @@ static int __init init_dmars(void)
 		}
 
 		if (iommu->pre_enabled_trans) {
-			pr_info("IOMMU Copying translate tables from panicked kernel\n");
 			ret = intel_iommu_load_translation_tables(iommu);
 			if (ret) {
-				pr_err("IOMMU: Copy translate tables failed\n");
+				/*
+				 * We found the IOMMU with translation
+				 * enabled - but failed to copy over the
+				 * old root-entry table. Try to proceed
+				 * by disabling translation now and
+				 * allocating a clean root-entry table.
+				 * This might cause DMAR faults, but
+				 * probably the dump will still succeed.
+				 */
+				pr_err("Failed to copy translation tables from previous kernel for %s\n",
+						iommu->name);
 
-				/* Best to stop trying */
-				goto free_iommu;
+				iommu_disable_translation(iommu);
+				iommu->pre_enabled_trans = 0;
+			} else {
+				pr_info("Copied translation tables from previous kernel for %s\n",
+					iommu->name);
 			}
-			pr_info("IOMMU: root_cache:0x%12.12llx phys:0x%12.12llx\n",
-				(u64)iommu->root_entry,
-				(u64)iommu->root_entry_old_phys);
-		} else {
-			/*
-			 * TBD:
-			 * we could share the same root & context tables
-			 * among all IOMMU's. Need to Split it later.
-			 */
-			ret = iommu_alloc_root_entry(iommu);
-			if (ret)
-				goto free_iommu;
 		}
 
-		if (!ecap_pass_through(iommu->ecap))
-			hw_pass_through = 0;
+		/*
+		 * Make the new root entry visible. If IOMMU was
+		 * disabled before we are safe because translation is
+		 * not enabled yet, so any DMA access to RMRR regions
+		 * still works.
+		 * If we are in a kdump kernel and IOMMU was enabled
+		 * before, we must make sure that the hardware uses the
+		 * new root entry table from now on.
+		 */
+		iommu_flush_write_buffer(iommu);
+		iommu_set_root_entry(iommu);
+		iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
+		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
 	}
 
-	for_each_active_iommu(iommu, drhd)
-		intel_iommu_init_qi(iommu);
-
 	if (iommu_pass_through)
 		iommu_identity_mapping |= IDENTMAP_ALL;
 
@@ -3063,21 +3073,14 @@ skip_new_domains_for_si_rmrr_isa:;
 			continue;
 		}
 
-		iommu_flush_write_buffer(iommu);
-
 		ret = dmar_set_interrupt(iommu);
 		if (ret)
 			goto free_iommu;
 
-		iommu_set_root_entry(iommu);
-
 		iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
 		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
 
-		if (iommu->pre_enabled_trans) {
-			if (!(iommu->gcmd & DMA_GCMD_TE))
-				iommu_enable_translation(iommu);
-		} else
+		if (!iommu->pre_enabled_trans)
 			iommu_enable_translation(iommu);
 
 		iommu_disable_protect_mem_regions(iommu);
@@ -5009,94 +5012,37 @@ static int __iommu_free_mapped_mem(void)
 }
 
 /*
- * Load the old root entry table to new root entry table.
- */
-static void __iommu_load_old_root_entry(struct intel_iommu *iommu)
-{
-	if ((!iommu)
-		|| (!iommu->root_entry)
-		|| (!iommu->root_entry_old_virt)
-		|| (!iommu->root_entry_old_phys))
-		return;
-	memcpy(iommu->root_entry, iommu->root_entry_old_virt, PAGE_SIZE);
-
-	__iommu_flush_cache(iommu, iommu->root_entry, PAGE_SIZE);
-}
-
-/*
- * When the data in new root entry table is changed, this function
- * must be called to save the updated data to old root entry table.
- */
-static void __iommu_update_old_root_entry(struct intel_iommu *iommu, int index)
-{
-	u8 start;
-	unsigned long size;
-	void __iomem *to;
-	void *from;
-
-	if ((!iommu)
-		|| (!iommu->root_entry)
-		|| (!iommu->root_entry_old_virt)
-		|| (!iommu->root_entry_old_phys))
-		return;
-
-	if (index < -1 || index >= ROOT_ENTRY_NR)
-		return;
-
-	if (index == -1) {
-		start = 0;
-		size = ROOT_ENTRY_NR * sizeof(struct root_entry);
-	} else {
-		start = index * sizeof(struct root_entry);
-		size = sizeof(struct root_entry);
-	}
-	to = iommu->root_entry_old_virt;
-	from = iommu->root_entry;
-	memcpy(to + start, from + start, size);
-
-	__iommu_flush_cache(iommu, to + start, size);
-}
-
-/*
  * Load root entry tables from old kernel.
  */
-static int copy_root_entry_table(struct intel_iommu *iommu)
+static int copy_root_entry_table(struct intel_iommu *iommu,
+				 struct root_entry *old_re)
 {
-	u32 bus;				/* Index: root-entry-table */
-	struct root_entry  *re;			/* Virt(iterator: new table) */
-	unsigned long context_old_phys;		/* Phys(context table entry) */
-	struct context_entry *context_new_virt;	/* Virt(new context_entry) */
+	struct context_entry *context_new_virt;
+	unsigned long context_old_phys;
+	u32 bus;
 
-	/*
-	 * A new root entry table has been allocated ,
-	 * we need copy re from old kernel to the new allocated one.
-	 */
-
-	if (!iommu->root_entry_old_phys)
-		return -ENOMEM;
-
-	for (bus = 0, re = iommu->root_entry; bus < 256; bus += 1, re += 1) {
-		if (!root_present(re))
+	for (bus = 0; bus < 256; bus++, old_re++) {
+		if (!root_present(old_re))
 			continue;
 
-		context_old_phys = get_context_phys_from_root(re);
+		context_old_phys = get_context_phys_from_root(old_re);
 
 		if (!context_old_phys)
 			continue;
 
-		context_new_virt =
-			(struct context_entry *)alloc_pgtable_page(iommu->node);
+		context_new_virt = alloc_pgtable_page(iommu->node);
 
 		if (!context_new_virt)
 			return -ENOMEM;
 
 		__iommu_load_from_oldmem(context_new_virt,
-					context_old_phys,
-					VTD_PAGE_SIZE);
+					 context_old_phys,
+					 VTD_PAGE_SIZE);
 
 		__iommu_flush_cache(iommu, context_new_virt, VTD_PAGE_SIZE);
 
-		set_root_value(re, virt_to_phys(context_new_virt));
+		set_root_value(&iommu->root_entry[bus],
+			       virt_to_phys(context_new_virt));
 	}
 
 	return 0;
@@ -5108,49 +5054,35 @@ static int copy_root_entry_table(struct intel_iommu *iommu)
  */
 static int intel_iommu_load_translation_tables(struct intel_iommu *iommu)
 {
-	unsigned long long q;		/* quadword scratch */
-	int ret = 0;			/* Integer return code */
+	struct root_entry *old_re;
+	phys_addr_t old_re_phys;
 	unsigned long flags;
+	int ret = 0;
+	u64 q;
 
 	q = dmar_readq(iommu->reg + DMAR_RTADDR_REG);
 	if (!q)
 		return -1;
 
-	spin_lock_irqsave(&iommu->lock, flags);
-
-	/* Load the root-entry table from the old kernel
-	 * foreach context_entry_table in root_entry
-	 *   Copy each entry table from old kernel
-	 */
-	if (!iommu->root_entry) {
-		iommu->root_entry =
-			(struct root_entry *)alloc_pgtable_page(iommu->node);
-		if (!iommu->root_entry) {
-			spin_unlock_irqrestore(&iommu->lock, flags);
-			return -ENOMEM;
-		}
-	}
-
-	iommu->root_entry_old_phys = q & VTD_PAGE_MASK;
-	if (!iommu->root_entry_old_phys) {
-		pr_err("Could not read old root entry address.");
-		return -1;
-	}
+	old_re_phys = q & VTD_PAGE_MASK;
+	if (!old_re_phys)
+		return -ENODEV;
 
-	iommu->root_entry_old_virt = ioremap_cache(iommu->root_entry_old_phys,
-						VTD_PAGE_SIZE);
-	if (!iommu->root_entry_old_virt) {
-		pr_err("Could not map the old root entry.");
+	old_re = ioremap_cache(old_re_phys, PAGE_SIZE);
+	if (!old_re) {
+		pr_err("Could not map old root entry\n");
 		return -ENOMEM;
 	}
 
-	__iommu_load_old_root_entry(iommu);
-	ret = copy_root_entry_table(iommu);
+	spin_lock_irqsave(&iommu->lock, flags);
+
+	ret = copy_root_entry_table(iommu, old_re);
 	__iommu_flush_cache(iommu, iommu->root_entry, PAGE_SIZE);
-	__iommu_update_old_root_entry(iommu, -1);
 
 	spin_unlock_irqrestore(&iommu->lock, flags);
 
+	iounmap(old_re);
+
 	__iommu_free_mapped_mem();
 
 	return ret;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 7e771c2..6c37de9 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -345,9 +345,6 @@ struct intel_iommu {
 	/* whether translation is enabled prior to OS*/
 	u8		pre_enabled_trans;
 
-	void __iomem	*root_entry_old_virt; /* mapped from old root entry */
-	unsigned long	root_entry_old_phys; /* root entry in old kernel */
-
 	struct iommu_flush flush;
 #endif
 	struct q_inval  *qi;            /* Queued invalidation info */
-- 
1.9.1

