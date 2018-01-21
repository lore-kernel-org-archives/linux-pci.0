Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992521AbeAUVPlsh6xG (ORCPT <rfc822;linux-pci@vger.kernel.org>
        + 1 other); Sun, 21 Jan 2018 22:15:41 +0100
Date: Sun, 21 Jan 2018 22:15:39 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/5] PCI: Move managed resource alloc to devres
Message-ID: <20180121211538.GC15151@lenoch>
References: <20180121211432.GA15151@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180121211432.GA15151@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

devm_pci_remap_cfgspace() is using devm_ioremap_release()
devres release function. Move it to devres along with
similar PCI functions to allow hiding devm_ioremap_release()
from public.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/pci/pci.c | 82 -------------------------------------------------------
 lib/devres.c      | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 82 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 764ca7b8840d..fcf5cc2c91de 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3533,88 +3533,6 @@ void pci_unmap_iospace(struct resource *res)
 }
 EXPORT_SYMBOL(pci_unmap_iospace);
 
-/**
- * devm_pci_remap_cfgspace - Managed pci_remap_cfgspace()
- * @dev: Generic device to remap IO address for
- * @offset: Resource address to map
- * @size: Size of map
- *
- * Managed pci_remap_cfgspace().  Map is automatically unmapped on driver
- * detach.
- */
-void __iomem *devm_pci_remap_cfgspace(struct device *dev,
-				      resource_size_t offset,
-				      resource_size_t size)
-{
-	void __iomem **ptr, *addr;
-
-	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return NULL;
-
-	addr = pci_remap_cfgspace(offset, size);
-	if (addr) {
-		*ptr = addr;
-		devres_add(dev, ptr);
-	} else
-		devres_free(ptr);
-
-	return addr;
-}
-EXPORT_SYMBOL(devm_pci_remap_cfgspace);
-
-/**
- * devm_pci_remap_cfg_resource - check, request region and ioremap cfg resource
- * @dev: generic device to handle the resource for
- * @res: configuration space resource to be handled
- *
- * Checks that a resource is a valid memory region, requests the memory
- * region and ioremaps with pci_remap_cfgspace() API that ensures the
- * proper PCI configuration space memory attributes are guaranteed.
- *
- * All operations are managed and will be undone on driver detach.
- *
- * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
- * on failure. Usage example::
- *
- *	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
- *	base = devm_pci_remap_cfg_resource(&pdev->dev, res);
- *	if (IS_ERR(base))
- *		return PTR_ERR(base);
- */
-void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
-					  struct resource *res)
-{
-	resource_size_t size;
-	const char *name;
-	void __iomem *dest_ptr;
-
-	BUG_ON(!dev);
-
-	if (!res || resource_type(res) != IORESOURCE_MEM) {
-		dev_err(dev, "invalid resource\n");
-		return IOMEM_ERR_PTR(-EINVAL);
-	}
-
-	size = resource_size(res);
-	name = res->name ?: dev_name(dev);
-
-	if (!devm_request_mem_region(dev, res->start, size, name)) {
-		dev_err(dev, "can't request region for resource %pR\n", res);
-		return IOMEM_ERR_PTR(-EBUSY);
-	}
-
-	dest_ptr = devm_pci_remap_cfgspace(dev, res->start, size);
-	if (!dest_ptr) {
-		dev_err(dev, "ioremap failed for resource %pR\n", res);
-		devm_release_mem_region(dev, res->start, size);
-		dest_ptr = IOMEM_ERR_PTR(-ENOMEM);
-	}
-
-	return dest_ptr;
-}
-EXPORT_SYMBOL(devm_pci_remap_cfg_resource);
-
 static void __pci_set_master(struct pci_dev *dev, bool enable)
 {
 	u16 old_cmd, cmd;
diff --git a/lib/devres.c b/lib/devres.c
index 5f2aedd58bc5..f2f80c233aa4 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -428,4 +428,86 @@ void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
 	}
 }
 EXPORT_SYMBOL(pcim_iounmap_regions);
+
+/**
+ * devm_pci_remap_cfgspace - Managed pci_remap_cfgspace()
+ * @dev: Generic device to remap IO address for
+ * @offset: Resource address to map
+ * @size: Size of map
+ *
+ * Managed pci_remap_cfgspace().  Map is automatically unmapped on driver
+ * detach.
+ */
+void __iomem *devm_pci_remap_cfgspace(struct device *dev,
+				      resource_size_t offset,
+				      resource_size_t size)
+{
+	void __iomem **ptr, *addr;
+
+	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	addr = pci_remap_cfgspace(offset, size);
+	if (addr) {
+		*ptr = addr;
+		devres_add(dev, ptr);
+	} else
+		devres_free(ptr);
+
+	return addr;
+}
+EXPORT_SYMBOL(devm_pci_remap_cfgspace);
+
+/**
+ * devm_pci_remap_cfg_resource - check, request region and ioremap cfg resource
+ * @dev: generic device to handle the resource for
+ * @res: configuration space resource to be handled
+ *
+ * Checks that a resource is a valid memory region, requests the memory
+ * region and ioremaps with pci_remap_cfgspace() API that ensures the
+ * proper PCI configuration space memory attributes are guaranteed.
+ *
+ * All operations are managed and will be undone on driver detach.
+ *
+ * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
+ * on failure. Usage example::
+ *
+ *	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+ *	base = devm_pci_remap_cfg_resource(&pdev->dev, res);
+ *	if (IS_ERR(base))
+ *		return PTR_ERR(base);
+ */
+void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
+					  struct resource *res)
+{
+	resource_size_t size;
+	const char *name;
+	void __iomem *dest_ptr;
+
+	BUG_ON(!dev);
+
+	if (!res || resource_type(res) != IORESOURCE_MEM) {
+		dev_err(dev, "invalid resource\n");
+		return IOMEM_ERR_PTR(-EINVAL);
+	}
+
+	size = resource_size(res);
+	name = res->name ?: dev_name(dev);
+
+	if (!devm_request_mem_region(dev, res->start, size, name)) {
+		dev_err(dev, "can't request region for resource %pR\n", res);
+		return IOMEM_ERR_PTR(-EBUSY);
+	}
+
+	dest_ptr = devm_pci_remap_cfgspace(dev, res->start, size);
+	if (!dest_ptr) {
+		dev_err(dev, "ioremap failed for resource %pR\n", res);
+		devm_release_mem_region(dev, res->start, size);
+		dest_ptr = IOMEM_ERR_PTR(-ENOMEM);
+	}
+
+	return dest_ptr;
+}
+EXPORT_SYMBOL(devm_pci_remap_cfg_resource);
 #endif /* CONFIG_PCI */
-- 
2.15.1
