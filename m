Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:39738 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeAUVQc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Jan 2018 16:16:32 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992604AbeAUVQbD8pcG (ORCPT <rfc822;linux-pci@vger.kernel.org>
        + 1 other); Sun, 21 Jan 2018 22:16:31 +0100
Date: Sun, 21 Jan 2018 22:16:29 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/5] devres: Add devm_ioremap_shared_resource()
Message-ID: <20180121211629.GE15151@lenoch>
References: <20180121211432.GA15151@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180121211432.GA15151@lenoch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Implement managed ioremap function for shared resources.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 include/linux/device.h |  9 ++++++++-
 lib/devres.c           | 22 ++++++++++++++--------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index e99d41a6190b..a35247a5f578 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -731,7 +731,14 @@ void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
 				   resource_size_t size);
 void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
 				   resource_size_t size);
-void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
+
+#define devm_ioremap_resource(dev, res) \
+	__devm_ioremap_resource(dev, res, false)
+#define devm_ioremap_shared_resource(dev, res) \
+	__devm_ioremap_resource(dev, res, true)
+
+void __iomem *__devm_ioremap_resource(struct device *dev, struct resource *res,
+				      bool shared);
 
 void devm_iounmap(struct device *dev, void __iomem *addr);
 
diff --git a/lib/devres.c b/lib/devres.c
index e9aad136f667..9fa15816cb83 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -22,6 +22,9 @@ static int devm_ioremap_match(struct device *dev, void *res, void *match_data)
  * @size: Size of map
  *
  * Managed ioremap().  Map is automatically unmapped on driver detach.
+ *
+ * When possible, use devm_ioremap_resource() or
+ * devm_ioremap_shared_resource() instead.
  */
 void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
 			   resource_size_t size)
@@ -116,13 +119,14 @@ void devm_iounmap(struct device *dev, void __iomem *addr)
 EXPORT_SYMBOL(devm_iounmap);
 
 /**
- * devm_ioremap_resource() - check, request region, and ioremap resource
+ * __devm_ioremap_resource() - check, request region, and ioremap resource
  * @dev: generic device to handle the resource for
  * @res: resource to be handled
+ * @shared: region is not requested when true
  *
- * Checks that a resource is a valid memory region, requests the memory
- * region and ioremaps it. All operations are managed and will be undone
- * on driver detach.
+ * Checks that a resource is a valid memory region, eventually requests the
+ * memory region and ioremaps it. All operations are managed and will be
+ * undone on driver detach.
  *
  * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
  * on failure. Usage example:
@@ -132,7 +136,8 @@ EXPORT_SYMBOL(devm_iounmap);
  *	if (IS_ERR(base))
  *		return PTR_ERR(base);
  */
-void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
+void __iomem *__devm_ioremap_resource(struct device *dev, struct resource *res,
+				      bool shared)
 {
 	resource_size_t size;
 	const char *name;
@@ -148,7 +153,7 @@ void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
 	size = resource_size(res);
 	name = res->name ?: dev_name(dev);
 
-	if (!devm_request_mem_region(dev, res->start, size, name)) {
+	if (!shared && !devm_request_mem_region(dev, res->start, size, name)) {
 		dev_err(dev, "can't request region for resource %pR\n", res);
 		return IOMEM_ERR_PTR(-EBUSY);
 	}
@@ -156,13 +161,14 @@ void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
 	dest_ptr = devm_ioremap(dev, res->start, size);
 	if (!dest_ptr) {
 		dev_err(dev, "ioremap failed for resource %pR\n", res);
-		devm_release_mem_region(dev, res->start, size);
+		if (!shared)
+			devm_release_mem_region(dev, res->start, size);
 		dest_ptr = IOMEM_ERR_PTR(-ENOMEM);
 	}
 
 	return dest_ptr;
 }
-EXPORT_SYMBOL(devm_ioremap_resource);
+EXPORT_SYMBOL(__devm_ioremap_resource);
 
 #ifdef CONFIG_HAS_IOPORT_MAP
 /*
-- 
2.15.1
