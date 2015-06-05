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
Subject: [PATCH 03/17] iommu/vt-d: Make two functions static
Date: Fri,  5 Jun 2015 16:10:49 +0200
Message-Id: <1433513463-19128-4-git-send-email-joro@8bytes.org>
In-Reply-To: <1433513463-19128-1-git-send-email-joro@8bytes.org>
References: <1433513463-19128-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

These functions are only used in intel-iommu.c and can be
static:

	* __iommu_load_from_oldmem()
	* __iommu_free_mapped_mem()

Tested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 5 +++--
 include/linux/intel-iommu.h | 4 ----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a061c3f..982b8c8 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4942,7 +4942,8 @@ static struct context_entry *device_to_existing_context_entry(
 /*
  * Copy memory from a physically-addressed area into a virtually-addressed area
  */
-int __iommu_load_from_oldmem(void *to, unsigned long from, unsigned long size)
+static int __iommu_load_from_oldmem(void *to, unsigned long from,
+				    unsigned long size)
 {
 	unsigned long pfn;		/* Page Frame Number */
 	size_t csize = (size_t)size;	/* Num(bytes to copy) */
@@ -4980,7 +4981,7 @@ int __iommu_load_from_oldmem(void *to, unsigned long from, unsigned long size)
 /*
  * Free the mapped memory for ioremap;
  */
-int __iommu_free_mapped_mem(void)
+static int __iommu_free_mapped_mem(void)
 {
 	struct iommu_remapped_entry *mem_entry, *tmp;
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 9526c28..7e771c2 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -391,8 +391,4 @@ extern int dmar_ir_support(void);
 
 extern const struct attribute_group *intel_iommu_groups[];
 
-extern int __iommu_load_from_oldmem(void *to, unsigned long from,
-					unsigned long size);
-extern int __iommu_free_mapped_mem(void);
-
 #endif
-- 
1.9.1

