Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:39738 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeAUVPM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Jan 2018 16:15:12 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992618AbeAUVPLAueDG (ORCPT <rfc822;linux-pci@vger.kernel.org>
        + 1 other); Sun, 21 Jan 2018 22:15:11 +0100
Date: Sun, 21 Jan 2018 22:15:08 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/5] devres: Move managed io function declarations into
 device.h
Message-ID: <20180121211508.GB15151@lenoch>
References: <20180121211432.GA15151@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180121211432.GA15151@lenoch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Moving managed io function declarations into device.h allows
removing forward struct device and resource definitions from
io(port).h

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 include/linux/device.h | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/io.h     | 39 ----------------------------------
 include/linux/ioport.h | 23 --------------------
 3 files changed, 57 insertions(+), 62 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 4d88b6b9cda9..91f508edb266 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -683,8 +683,65 @@ extern unsigned long devm_get_free_pages(struct device *dev,
 					 gfp_t gfp_mask, unsigned int order);
 extern void devm_free_pages(struct device *dev, unsigned long addr);
 
+/* managed resource interface */
+extern int devm_request_resource(struct device *dev, struct resource *root,
+				 struct resource *new);
+extern void devm_release_resource(struct device *dev, struct resource *new);
+
+#define devm_request_region(dev,start,n,name) \
+	__devm_request_region(dev, &ioport_resource, (start), (n), (name))
+#define devm_request_mem_region(dev,start,n,name) \
+	__devm_request_region(dev, &iomem_resource, (start), (n), (name))
+
+extern struct resource * __devm_request_region(struct device *dev,
+				struct resource *parent, resource_size_t start,
+				resource_size_t n, const char *name);
+
+#define devm_release_region(dev, start, n) \
+	__devm_release_region(dev, &ioport_resource, (start), (n))
+#define devm_release_mem_region(dev, start, n) \
+	__devm_release_region(dev, &iomem_resource, (start), (n))
+
+extern void __devm_release_region(struct device *dev, struct resource *parent,
+				  resource_size_t start, resource_size_t n);
+
+/* managed iomap interface */
+#ifdef CONFIG_HAS_IOPORT_MAP
+void __iomem * devm_ioport_map(struct device *dev, unsigned long port,
+			       unsigned int nr);
+void devm_ioport_unmap(struct device *dev, void __iomem *addr);
+#else
+static inline void __iomem *devm_ioport_map(struct device *dev,
+					     unsigned long port,
+					     unsigned int nr)
+{
+	return NULL;
+}
+
+static inline void devm_ioport_unmap(struct device *dev, void __iomem *addr)
+{
+}
+#endif
+
+#define IOMEM_ERR_PTR(err) (__force void __iomem *)ERR_PTR(err)
+
+void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
+			   resource_size_t size);
+void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
+				   resource_size_t size);
+void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
+				   resource_size_t size);
 void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
 
+void devm_iounmap(struct device *dev, void __iomem *addr);
+void devm_ioremap_release(struct device *dev, void *res);
+
+void *devm_memremap(struct device *dev, resource_size_t offset,
+		size_t size, unsigned long flags);
+void devm_memunmap(struct device *dev, void *addr);
+
+void *__devm_memremap_pages(struct device *dev, struct resource *res);
+
 /* allows to add/remove a custom action to devres stack */
 int devm_add_action(struct device *dev, void (*action)(void *), void *data);
 void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
diff --git a/include/linux/io.h b/include/linux/io.h
index 32e30e8fb9db..58554147ccdb 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -25,9 +25,6 @@
 #include <asm/io.h>
 #include <asm/page.h>
 
-struct device;
-struct resource;
-
 __visible void __iowrite32_copy(void __iomem *to, const void *from, size_t count);
 void __ioread32_copy(void *to, const void __iomem *from, size_t count);
 void __iowrite64_copy(void __iomem *to, const void *from, size_t count);
@@ -51,44 +48,8 @@ int arch_ioremap_pmd_supported(void);
 static inline void ioremap_huge_init(void) { }
 #endif
 
-/*
- * Managed iomap interface
- */
-#ifdef CONFIG_HAS_IOPORT_MAP
-void __iomem * devm_ioport_map(struct device *dev, unsigned long port,
-			       unsigned int nr);
-void devm_ioport_unmap(struct device *dev, void __iomem *addr);
-#else
-static inline void __iomem *devm_ioport_map(struct device *dev,
-					     unsigned long port,
-					     unsigned int nr)
-{
-	return NULL;
-}
-
-static inline void devm_ioport_unmap(struct device *dev, void __iomem *addr)
-{
-}
-#endif
-
-#define IOMEM_ERR_PTR(err) (__force void __iomem *)ERR_PTR(err)
-
-void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
-			   resource_size_t size);
-void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
-				   resource_size_t size);
-void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
-				   resource_size_t size);
-void devm_iounmap(struct device *dev, void __iomem *addr);
 int check_signature(const volatile void __iomem *io_addr,
 			const unsigned char *signature, int length);
-void devm_ioremap_release(struct device *dev, void *res);
-
-void *devm_memremap(struct device *dev, resource_size_t offset,
-		size_t size, unsigned long flags);
-void devm_memunmap(struct device *dev, void *addr);
-
-void *__devm_memremap_pages(struct device *dev, struct resource *res);
 
 #ifdef CONFIG_PCI
 /*
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index da0ebaec25f0..dc43f2f52416 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -241,29 +241,6 @@ extern int release_mem_region_adjustable(struct resource *, resource_size_t,
 				resource_size_t);
 #endif
 
-/* Wrappers for managed devices */
-struct device;
-
-extern int devm_request_resource(struct device *dev, struct resource *root,
-				 struct resource *new);
-extern void devm_release_resource(struct device *dev, struct resource *new);
-
-#define devm_request_region(dev,start,n,name) \
-	__devm_request_region(dev, &ioport_resource, (start), (n), (name))
-#define devm_request_mem_region(dev,start,n,name) \
-	__devm_request_region(dev, &iomem_resource, (start), (n), (name))
-
-extern struct resource * __devm_request_region(struct device *dev,
-				struct resource *parent, resource_size_t start,
-				resource_size_t n, const char *name);
-
-#define devm_release_region(dev, start, n) \
-	__devm_release_region(dev, &ioport_resource, (start), (n))
-#define devm_release_mem_region(dev, start, n) \
-	__devm_release_region(dev, &iomem_resource, (start), (n))
-
-extern void __devm_release_region(struct device *dev, struct resource *parent,
-				  resource_size_t start, resource_size_t n);
 extern int iomem_map_sanity_check(resource_size_t addr, unsigned long size);
 extern bool iomem_is_exclusive(u64 addr);
 
-- 
2.15.1
