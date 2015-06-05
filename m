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
Subject: [PATCH 07/17] iommu/vt-d: Copy context-tables outside of spin_lock
Date: Fri,  5 Jun 2015 16:10:53 +0200
Message-Id: <1433513463-19128-8-git-send-email-joro@8bytes.org>
In-Reply-To: <1433513463-19128-1-git-send-email-joro@8bytes.org>
References: <1433513463-19128-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

This allows to to ioremap_nocache and iounmap in the same
path, so we don't need to collect all pointers returned from
ioremap to free them after the spinlock is released.

Tested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 127 +++++++++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 61 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c0b72e8..2602b33 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -380,17 +380,11 @@ struct iommu_remapped_entry {
 	void __iomem *mem;
 };
 static LIST_HEAD(__iommu_remapped_mem);
-static DEFINE_MUTEX(__iommu_mem_list_lock);
 
-/* ========================================================================
+/*
  * Copy iommu translation tables from old kernel into new  kernel.
  * Entry to this set of functions is: intel_iommu_load_translation_tables()
- * ------------------------------------------------------------------------
  */
-
-static int copy_root_entry_table(struct intel_iommu *iommu,
-				 struct root_entry *old_re);
-
 static int intel_iommu_load_translation_tables(struct intel_iommu *iommu);
 
 static void unmap_device_dma(struct dmar_domain *domain,
@@ -4958,68 +4952,41 @@ static struct context_entry *device_to_existing_context_entry(
 /*
  * Copy memory from a physically-addressed area into a virtually-addressed area
  */
-static int __iommu_load_from_oldmem(void *to, unsigned long from,
-				    unsigned long size)
+static int copy_from_oldmem_phys(void *to, phys_addr_t from, size_t size)
 {
-	unsigned long pfn;		/* Page Frame Number */
-	size_t csize = (size_t)size;	/* Num(bytes to copy) */
-	unsigned long offset;		/* Lower 12 bits of to */
 	void __iomem *virt_mem;
-	struct iommu_remapped_entry *mapped;
+	unsigned long offset;
+	unsigned long pfn;
 
-	pfn = from >> VTD_PAGE_SHIFT;
+	pfn    = from >> VTD_PAGE_SHIFT;
 	offset = from & (~VTD_PAGE_MASK);
 
 	if (page_is_ram(pfn)) {
-		memcpy(to, pfn_to_kaddr(pfn) + offset, csize);
-	} else{
-
-		mapped = kzalloc(sizeof(struct iommu_remapped_entry),
-				GFP_KERNEL);
-		if (!mapped)
-			return -ENOMEM;
-
+		memcpy(to, pfn_to_kaddr(pfn) + offset, size);
+	} else {
 		virt_mem = ioremap_cache((unsigned long)from, size);
-		if (!virt_mem) {
-			kfree(mapped);
+		if (!virt_mem)
 			return -ENOMEM;
-		}
+
 		memcpy(to, virt_mem, size);
 
-		mutex_lock(&__iommu_mem_list_lock);
-		mapped->mem = virt_mem;
-		list_add_tail(&mapped->list, &__iommu_remapped_mem);
-		mutex_unlock(&__iommu_mem_list_lock);
+		iounmap(virt_mem);
 	}
-	return size;
-}
 
-/*
- * Free the mapped memory for ioremap;
- */
-static int __iommu_free_mapped_mem(void)
-{
-	struct iommu_remapped_entry *mem_entry, *tmp;
-
-	mutex_lock(&__iommu_mem_list_lock);
-	list_for_each_entry_safe(mem_entry, tmp, &__iommu_remapped_mem, list) {
-		iounmap(mem_entry->mem);
-		list_del(&mem_entry->list);
-		kfree(mem_entry);
-	}
-	mutex_unlock(&__iommu_mem_list_lock);
-	return 0;
+	return size;
 }
 
 /*
- * Load root entry tables from old kernel.
+ * Load context entry tables from old kernel.
  */
-static int copy_root_entry_table(struct intel_iommu *iommu,
-				 struct root_entry *old_re)
+static int copy_context_tables(struct intel_iommu *iommu,
+			       struct context_entry **tbl,
+			       struct root_entry *old_re)
 {
 	struct context_entry *context_new_virt;
-	unsigned long context_old_phys;
+	phys_addr_t context_old_phys;
 	u32 bus;
+	int ret;
 
 	for (bus = 0; bus < 256; bus++, old_re++) {
 		if (!root_present(old_re))
@@ -5030,22 +4997,48 @@ static int copy_root_entry_table(struct intel_iommu *iommu,
 		if (!context_old_phys)
 			continue;
 
+		ret = -ENOMEM;
 		context_new_virt = alloc_pgtable_page(iommu->node);
-
 		if (!context_new_virt)
-			return -ENOMEM;
-
-		__iommu_load_from_oldmem(context_new_virt,
-					 context_old_phys,
-					 VTD_PAGE_SIZE);
+			goto out_err;
+
+		ret = copy_from_oldmem_phys(context_new_virt, context_old_phys,
+					    VTD_PAGE_SIZE);
+		if (ret != VTD_PAGE_SIZE) {
+			pr_err("Failed to copy context table for bus %d from physical address 0x%llx\n",
+			       bus, context_old_phys);
+			free_pgtable_page(context_new_virt);
+			continue;
+		}
 
 		__iommu_flush_cache(iommu, context_new_virt, VTD_PAGE_SIZE);
 
-		set_root_value(&iommu->root_entry[bus],
-			       virt_to_phys(context_new_virt));
+		tbl[bus] = context_new_virt;
 	}
 
 	return 0;
+
+out_err:
+	for (bus = 0; bus < 256; bus++) {
+		free_pgtable_page(tbl[bus]);
+		tbl[bus] = NULL;
+	}
+
+	return ret;
+}
+
+static void update_root_entry_table(struct intel_iommu *iommu,
+				    struct context_entry **tbl)
+{
+	struct root_entry *re = iommu->root_entry;
+	u32 bus;
+
+	for (bus = 0; bus < 256; bus++, re++) {
+		if (!tbl[bus])
+			continue;
+
+		set_root_value(re, virt_to_phys(tbl[bus]));
+	}
 }
 
 /*
@@ -5054,6 +5047,7 @@ static int copy_root_entry_table(struct intel_iommu *iommu,
  */
 static int intel_iommu_load_translation_tables(struct intel_iommu *iommu)
 {
+	struct context_entry **ctxt_tbls;
 	struct root_entry *old_re;
 	phys_addr_t old_re_phys;
 	unsigned long flags;
@@ -5074,16 +5068,27 @@ static int intel_iommu_load_translation_tables(struct intel_iommu *iommu)
 		return -ENOMEM;
 	}
 
+	ret = -ENOMEM;
+	ctxt_tbls = kzalloc(256 * sizeof(void *), GFP_KERNEL);
+	if (!ctxt_tbls)
+		goto out_unmap;
+
+	ret = copy_context_tables(iommu, ctxt_tbls, old_re);
+	if (ret)
+		goto out_free;
+
 	spin_lock_irqsave(&iommu->lock, flags);
 
-	ret = copy_root_entry_table(iommu, old_re);
+	update_root_entry_table(iommu, ctxt_tbls);
 	__iommu_flush_cache(iommu, iommu->root_entry, PAGE_SIZE);
 
 	spin_unlock_irqrestore(&iommu->lock, flags);
 
-	iounmap(old_re);
+out_free:
+	kfree(ctxt_tbls);
 
-	__iommu_free_mapped_mem();
+out_unmap:
+	iounmap(old_re);
 
 	return ret;
 }
-- 
1.9.1

