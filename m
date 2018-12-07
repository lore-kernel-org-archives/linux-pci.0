Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4644C07E85
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 16:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A4820868
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 16:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A4820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbeLGQbq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:31:46 -0500
Received: from foss.arm.com ([217.140.101.70]:49036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbeLGQbp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Dec 2018 11:31:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0849315AD;
        Fri,  7 Dec 2018 08:31:45 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C5EED3F575;
        Fri,  7 Dec 2018 08:31:42 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de
Cc:     iommu@lists.linux-foundation.org, m.szyprowski@samsung.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dma-mapping: Factor out dummy DMA ops
Date:   Fri,  7 Dec 2018 16:31:34 +0000
Message-Id: <ba370a53dd3d68a10a6b23443a23fe192622e57b.1544199754.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
In-Reply-To: <cover.1544199754.git.robin.murphy@arm.com>
References: <cover.1544199754.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The dummy DMA ops are currently used by arm64 for any device which has
an invalid ACPI description and is thus barred from using DMA due to not
knowing whether is is cache-coherent or not. Factor these out into
general dma-mapping code so that they can be referenced from other
common code paths. In the process, we can prune all the optional
callbacks which just do the same thing as the default behaviour, and
fill in .map_resource for completeness.

CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/include/asm/dma-mapping.h |  4 +-
 arch/arm64/mm/dma-mapping.c          | 92 ----------------------------
 include/linux/dma-mapping.h          |  1 +
 kernel/dma/mapping.c                 | 54 ++++++++++++++++
 4 files changed, 56 insertions(+), 95 deletions(-)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index c41f3fb1446c..273e778f7de2 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -24,15 +24,13 @@
 #include <xen/xen.h>
 #include <asm/xen/hypervisor.h>
 
-extern const struct dma_map_ops dummy_dma_ops;
-
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	/*
 	 * We expect no ISA devices, and all other DMA masters are expected to
 	 * have someone call arch_setup_dma_ops at device creation time.
 	 */
-	return &dummy_dma_ops;
+	return &dma_dummy_ops;
 }
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index a3ac26284845..f3af6cc52fad 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -252,98 +252,6 @@ static int __init atomic_pool_init(void)
 	return -ENOMEM;
 }
 
-/********************************************
- * The following APIs are for dummy DMA ops *
- ********************************************/
-
-static void *__dummy_alloc(struct device *dev, size_t size,
-			   dma_addr_t *dma_handle, gfp_t flags,
-			   unsigned long attrs)
-{
-	return NULL;
-}
-
-static void __dummy_free(struct device *dev, size_t size,
-			 void *vaddr, dma_addr_t dma_handle,
-			 unsigned long attrs)
-{
-}
-
-static int __dummy_mmap(struct device *dev,
-			struct vm_area_struct *vma,
-			void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			unsigned long attrs)
-{
-	return -ENXIO;
-}
-
-static dma_addr_t __dummy_map_page(struct device *dev, struct page *page,
-				   unsigned long offset, size_t size,
-				   enum dma_data_direction dir,
-				   unsigned long attrs)
-{
-	return 0;
-}
-
-static void __dummy_unmap_page(struct device *dev, dma_addr_t dev_addr,
-			       size_t size, enum dma_data_direction dir,
-			       unsigned long attrs)
-{
-}
-
-static int __dummy_map_sg(struct device *dev, struct scatterlist *sgl,
-			  int nelems, enum dma_data_direction dir,
-			  unsigned long attrs)
-{
-	return 0;
-}
-
-static void __dummy_unmap_sg(struct device *dev,
-			     struct scatterlist *sgl, int nelems,
-			     enum dma_data_direction dir,
-			     unsigned long attrs)
-{
-}
-
-static void __dummy_sync_single(struct device *dev,
-				dma_addr_t dev_addr, size_t size,
-				enum dma_data_direction dir)
-{
-}
-
-static void __dummy_sync_sg(struct device *dev,
-			    struct scatterlist *sgl, int nelems,
-			    enum dma_data_direction dir)
-{
-}
-
-static int __dummy_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
-{
-	return 1;
-}
-
-static int __dummy_dma_supported(struct device *hwdev, u64 mask)
-{
-	return 0;
-}
-
-const struct dma_map_ops dummy_dma_ops = {
-	.alloc                  = __dummy_alloc,
-	.free                   = __dummy_free,
-	.mmap                   = __dummy_mmap,
-	.map_page               = __dummy_map_page,
-	.unmap_page             = __dummy_unmap_page,
-	.map_sg                 = __dummy_map_sg,
-	.unmap_sg               = __dummy_unmap_sg,
-	.sync_single_for_cpu    = __dummy_sync_single,
-	.sync_single_for_device = __dummy_sync_single,
-	.sync_sg_for_cpu        = __dummy_sync_sg,
-	.sync_sg_for_device     = __dummy_sync_sg,
-	.mapping_error          = __dummy_mapping_error,
-	.dma_supported          = __dummy_dma_supported,
-};
-EXPORT_SYMBOL(dummy_dma_ops);
-
 static int __init arm64_dma_init(void)
 {
 	WARN_TAINT(ARCH_DMA_MINALIGN < cache_line_size(),
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 15bd41447025..3a1928ea23c9 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -134,6 +134,7 @@ struct dma_map_ops {
 };
 
 extern const struct dma_map_ops dma_direct_ops;
+extern const struct dma_map_ops dma_dummy_ops;
 extern const struct dma_map_ops dma_virt_ops;
 
 #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 58dec7a92b7b..957a42ebabcf 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -346,3 +346,57 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
 	vunmap(cpu_addr);
 }
 #endif
+
+/*
+ * Dummy DMA ops always fail
+ */
+
+static int dma_dummy_mmap(struct device *dev, struct vm_area_struct *vma,
+			  void *cpu_addr, dma_addr_t dma_addr, size_t size,
+			  unsigned long attrs)
+{
+	return -ENXIO;
+}
+
+static dma_addr_t dma_dummy_map_page(struct device *dev, struct page *page,
+				     unsigned long offset, size_t size,
+				     enum dma_data_direction dir,
+				     unsigned long attrs)
+{
+	return 0;
+}
+
+static int dma_dummy_map_sg(struct device *dev, struct scatterlist *sgl,
+			    int nelems, enum dma_data_direction dir,
+			    unsigned long attrs)
+{
+	return 0;
+}
+
+static dma_addr_t dma_dummy_map_resource(struct device *dev,
+					 phys_addr_t phys_addr, size_t size,
+					 enum dma_data_direction dir,
+					 unsigned long attrs)
+{
+	return 0;
+}
+
+static int dma_dummy_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
+{
+	return 1;
+}
+
+static int dma_dummy_supported(struct device *hwdev, u64 mask)
+{
+	return 0;
+}
+
+const struct dma_map_ops dma_dummy_ops = {
+	.mmap		= dma_dummy_mmap,
+	.map_page	= dma_dummy_map_page,
+	.map_sg		= dma_dummy_map_sg,
+	.map_resource	= dma_dummy_map_resource,
+	.mapping_error	= dma_dummy_mapping_error,
+	.dma_supported	= dma_dummy_supported,
+};
+EXPORT_SYMBOL(dma_dummy_ops);
-- 
2.19.1.dirty

