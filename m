Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 08/10] PCI: Deprecate of_pci_get_host_bridge_resources()
Date: Mon, 30 Apr 2018 07:48:42 +0200
Message-Id: <aca0d89cd8c1551a83b87ffab29fcd6e1d59a61c.1525067324.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1525067324.git.jan.kiszka@siemens.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1525067324.git.jan.kiszka@siemens.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

There are no in-tree users remaining, all are converted to the managed
variant. And it is unlikely that any out-of-tree user got the resource
management right as well. So deprecate the interface and push users to
the managed version instead.

To avoid raising a warning when exporting a deprecated symbol, wrap the
API with an inline and export an internal name.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/pci/of.c       | 23 ++---------------------
 include/linux/of_pci.h | 36 ++++++++++++++++++++++++++++++++----
 2 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 5a88d46a41b7..ccf8c7544e10 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -351,33 +351,14 @@ static int __of_pci_get_host_bridge_resources(struct device *dev,
 	return err;
 }
 
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
+int __of_pci_get_host_bridge_resources_deprecated(struct device_node *dev_node,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base)
 {
 	return __of_pci_get_host_bridge_resources(NULL, dev_node, busno,
 						  bus_max, resources, io_base);
 }
-EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
+EXPORT_SYMBOL_GPL(__of_pci_get_host_bridge_resources_deprecated);
 
 /**
  * of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI host
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 08b8f02426a5..c6408bd6f862 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -71,26 +71,54 @@ of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 #endif
 
 #if defined(CONFIG_OF_ADDRESS)
-int of_pci_get_host_bridge_resources(struct device_node *dev_node,
+int __of_pci_get_host_bridge_resources_deprecated(struct device_node *dev_node,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base);
 int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base);
 #else
-static inline int of_pci_get_host_bridge_resources(struct device_node *dev_node,
+static inline int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base)
 {
 	return -EINVAL;
 }
+#endif
 
-static inline int devm_of_pci_get_host_bridge_resources(struct device *dev,
+/**
+ * of_pci_get_host_bridge_resources() - Parse PCI host bridge resources from DT
+ * @dev_node: device node of the host bridge having the range property
+ * @busno: bus number associated with the bridge root bus
+ * @bus_max: maximum number of buses for this bridge
+ * @resources: list where the range of resources will be added after DT parsing
+ * @io_base: pointer to a variable that will contain on return the physical
+ * address for the start of the I/O range. Can be NULL if the caller doesn't
+ * expect I/O ranges to be present in the device tree.
+ *
+ * It is the caller's job to free the @resources list.
+ *
+ * This function will parse the "ranges" property of a PCI host bridge device
+ * node and setup the resource mapping based on its content. It is expected
+ * that the property conforms with the Power ePAPR document.
+ *
+ * It returns zero if the range parsing has been successful or a standard error
+ * value if it failed.
+ *
+ * Note: This function is deprecated and will eventually be removed. Use
+ * devm_of_pci_get_host_bridge_resources() instead.
+ */
+static inline int __deprecated of_pci_get_host_bridge_resources(
+			struct device_node *dev_node,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base)
 {
+#if defined(CONFIG_OF_ADDRESS)
+	return __of_pci_get_host_bridge_resources_deprecated(dev_node, busno,
+			bus_max, resources, io_base);
+#else
 	return -EINVAL;
-}
 #endif
+}
 
 #endif
-- 
2.13.6
