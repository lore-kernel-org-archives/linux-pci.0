Return-Path: <SRS0=xh6H=H4=siemens.com=jan.kiszka@kernel.org>
Return-Path: <SRS0=xh6H=H4=siemens.com=jan.kiszka@kernel.org>
Subject: [PATCH v3 08/10] PCI: Remove of_pci_get_host_bridge_resources()
To: Bjorn Helgaas <helgaas@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <cover.1525067324.git.jan.kiszka@siemens.com>
 <aca0d89cd8c1551a83b87ffab29fcd6e1d59a61c.1525067324.git.jan.kiszka@siemens.com>
 <20180502123923.GA10783@infradead.org>
 <b13dd4b5-61c4-3acb-c194-3e448cb8b3d2@siemens.com>
 <20180508132930.GL161390@bhelgaas-glaptop.roam.corp.google.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <49036380-5962-2db2-aa34-d37ea47eef1d@siemens.com>
Date: Wed, 9 May 2018 21:03:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180508132930.GL161390@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

There are no in-tree users remaining, all are converted to the managed
variant. And it is unlikely that any out-of-tree user got the resource
management right as well. So remove the interface.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This replaces "PCI: Deprecate of_pci_get_host_bridge_resources()" from
the round v2.

 drivers/pci/of.c       | 88 +++++++++++++-------------------------------------
 include/linux/of_pci.h | 10 ------
 2 files changed, 22 insertions(+), 76 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 5a88d46a41b7..38469ffd1d7e 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -243,11 +243,29 @@ void of_pci_check_probe_only(void)
 EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
 
 #if defined(CONFIG_OF_ADDRESS)
-static int __of_pci_get_host_bridge_resources(struct device *dev,
-			struct device_node *dev_node,
+/**
+ * devm_of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI
+ *                                           host bridge resources from DT
+ * @dev: host bridge device
+ * @busno: bus number associated with the bridge root bus
+ * @bus_max: maximum number of buses for this bridge
+ * @resources: list where the range of resources will be added after DT parsing
+ * @io_base: pointer to a variable that will contain on return the physical
+ * address for the start of the I/O range. Can be NULL if the caller doesn't
+ * expect I/O ranges to be present in the device tree.
+ *
+ * This function will parse the "ranges" property of a PCI host bridge device
+ * node and setup the resource mapping based on its content. It is expected
+ * that the property conforms with the Power ePAPR document.
+ *
+ * It returns zero if the range parsing has been successful or a standard error
+ * value if it failed.
+ */
+int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base)
 {
+	struct device_node *dev_node = dev->of_node;
 	struct resource_entry *window;
 	struct resource *res;
 	struct resource *bus_range;
@@ -259,10 +277,7 @@ static int __of_pci_get_host_bridge_resources(struct device *dev,
 	if (io_base)
 		*io_base = (resource_size_t)OF_BAD_ADDR;
 
-	if (dev)
-		bus_range = devm_kzalloc(dev,sizeof(*bus_range), GFP_KERNEL);
-	else
-		bus_range = kzalloc(sizeof(*bus_range), GFP_KERNEL);
+	bus_range = devm_kzalloc(dev,sizeof(*bus_range), GFP_KERNEL);
 	if (!bus_range)
 		return -ENOMEM;
 
@@ -306,11 +321,7 @@ static int __of_pci_get_host_bridge_resources(struct device *dev,
 		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
 			continue;
 
-		if (dev)
-			res = devm_kzalloc(dev, sizeof(struct resource),
-					   GFP_KERNEL);
-		else
-			res = kzalloc(sizeof(struct resource), GFP_KERNEL);
+		res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
 		if (!res) {
 			err = -ENOMEM;
 			goto parse_failed;
@@ -350,62 +361,7 @@ static int __of_pci_get_host_bridge_resources(struct device *dev,
 	pci_free_resource_list(resources);
 	return err;
 }
-
-/**
- * of_pci_get_host_bridge_resources() - Parse PCI host bridge resources from DT
- * @dev_node: device node of the host bridge having the range property
- * @busno: bus number associated with the bridge root bus
- * @bus_max: maximum number of buses for this bridge
- * @resources: list where the range of resources will be added after DT parsing
- * @io_base: pointer to a variable that will contain on return the physical
- * address for the start of the I/O range. Can be NULL if the caller doesn't
- * expect I/O ranges to be present in the device tree.
- *
- * It is the caller's job to free the @resources list.
- *
- * This function will parse the "ranges" property of a PCI host bridge device
- * node and setup the resource mapping based on its content. It is expected
- * that the property conforms with the Power ePAPR document.
- *
- * It returns zero if the range parsing has been successful or a standard error
- * value if it failed.
- */
-int of_pci_get_host_bridge_resources(struct device_node *dev_node,
-			unsigned char busno, unsigned char bus_max,
-			struct list_head *resources, resource_size_t *io_base)
-{
-	return __of_pci_get_host_bridge_resources(NULL, dev_node, busno,
-						  bus_max, resources, io_base);
-}
-EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
-
-/**
- * of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI host
- *                                      bridge resources from DT
- * @dev: host bridge device
- * @busno: bus number associated with the bridge root bus
- * @bus_max: maximum number of buses for this bridge
- * @resources: list where the range of resources will be added after DT parsing
- * @io_base: pointer to a variable that will contain on return the physical
- * address for the start of the I/O range. Can be NULL if the caller doesn't
- * expect I/O ranges to be present in the device tree.
- *
- * This function will parse the "ranges" property of a PCI host bridge device
- * node and setup the resource mapping based on its content. It is expected
- * that the property conforms with the Power ePAPR document.
- *
- * It returns zero if the range parsing has been successful or a standard error
- * value if it failed.
- */
-int devm_of_pci_get_host_bridge_resources(struct device *dev,
-			unsigned char busno, unsigned char bus_max,
-			struct list_head *resources, resource_size_t *io_base)
-{
-	return __of_pci_get_host_bridge_resources(dev, dev->of_node, busno,
-						  bus_max, resources, io_base);
-}
 EXPORT_SYMBOL_GPL(devm_of_pci_get_host_bridge_resources);
-
 #endif /* CONFIG_OF_ADDRESS */
 
 /**
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 08b8f02426a5..fa4463a52900 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -71,20 +71,10 @@ of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 #endif
 
 #if defined(CONFIG_OF_ADDRESS)
-int of_pci_get_host_bridge_resources(struct device_node *dev_node,
-			unsigned char busno, unsigned char bus_max,
-			struct list_head *resources, resource_size_t *io_base);
 int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base);
 #else
-static inline int of_pci_get_host_bridge_resources(struct device_node *dev_node,
-			unsigned char busno, unsigned char bus_max,
-			struct list_head *resources, resource_size_t *io_base)
-{
-	return -EINVAL;
-}
-
 static inline int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base)
-- 
2.13.6
