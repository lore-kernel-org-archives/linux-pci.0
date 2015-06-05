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
Subject: [PATCH 02/17] iommu/vt-d: Remove __iommu_save_to_oldmem() function
Date: Fri,  5 Jun 2015 16:10:48 +0200
Message-Id: <1433513463-19128-3-git-send-email-joro@8bytes.org>
In-Reply-To: <1433513463-19128-1-git-send-email-joro@8bytes.org>
References: <1433513463-19128-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

This function is unused and can be removed.

Tested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 36 ------------------------------------
 include/linux/intel-iommu.h |  2 --
 2 files changed, 38 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 60d5491..a061c3f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4978,42 +4978,6 @@ int __iommu_load_from_oldmem(void *to, unsigned long from, unsigned long size)
 }
 
 /*
- * Copy memory from a virtually-addressed area into a physically-addressed area
- */
-int __iommu_save_to_oldmem(unsigned long to, void *from, unsigned long size)
-{
-	unsigned long pfn;		/* Page Frame Number */
-	size_t csize = (size_t)size;	/* Num(bytes to copy) */
-	unsigned long offset;		/* Lower 12 bits of to */
-	void __iomem *virt_mem;
-	struct iommu_remapped_entry *mapped;
-
-	pfn = to >> VTD_PAGE_SHIFT;
-	offset = to & (~VTD_PAGE_MASK);
-
-	if (page_is_ram(pfn)) {
-		memcpy(pfn_to_kaddr(pfn) + offset, from, csize);
-	} else{
-		mapped = kzalloc(sizeof(struct iommu_remapped_entry),
-				GFP_KERNEL);
-		if (!mapped)
-			return -ENOMEM;
-
-		virt_mem = ioremap_cache((unsigned long)to, size);
-		if (!virt_mem) {
-			kfree(mapped);
-			return -ENOMEM;
-		}
-		memcpy(virt_mem, from, size);
-		mutex_lock(&__iommu_mem_list_lock);
-		mapped->mem = virt_mem;
-		list_add_tail(&mapped->list, &__iommu_remapped_mem);
-		mutex_unlock(&__iommu_mem_list_lock);
-	}
-	return size;
-}
-
-/*
  * Free the mapped memory for ioremap;
  */
 int __iommu_free_mapped_mem(void)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index a81ceee..9526c28 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -393,8 +393,6 @@ extern const struct attribute_group *intel_iommu_groups[];
 
 extern int __iommu_load_from_oldmem(void *to, unsigned long from,
 					unsigned long size);
-extern int __iommu_save_to_oldmem(unsigned long to, void *from,
-					unsigned long size);
 extern int __iommu_free_mapped_mem(void);
 
 #endif
-- 
1.9.1

