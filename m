Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:41496 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751778AbeD3FtQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Apr 2018 01:49:16 -0400
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 06/10] PCI: Introduce devm_of_pci_get_host_bridge_resources()
Date: Mon, 30 Apr 2018 07:48:40 +0200
Message-Id: <215a020abbafc599bda18463db6818fcb0d198c7.1525067324.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1525067324.git.jan.kiszka@siemens.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1525067324.git.jan.kiszka@siemens.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

of_pci_get_host_bridge_resources() allocates the resource structures it
fills dynamically, but none of its callers care to release them so far.
Rather than requiring everyone to do this explicitly, introduce a
managed version of that service. This differs API-wise only in taking a
reference to the associated device, rather than to the device tree node.

As of_pci_get_host_bridge_resources() is an exported interface, we
cannot simply drop it at this point. After converting all in-tree users
to the new API, we will phase out the unmanaged one.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/pci/of.c       | 28 ++++++++++++++++++++++++++++
 include/linux/of_pci.h | 10 ++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 8f6cbf13e18d..f16b343d3b85 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -378,6 +378,34 @@ int of_pci_get_host_bridge_resources(struct device_node *dev_node,
 						  bus_max, resources, io_base);
 }
 EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
+
+/**
+ * of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI host
+ *                                      bridge resources from DT
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
+			unsigned char busno, unsigned char bus_max,
+			struct list_head *resources, resource_size_t *io_base)
+{
+	return __of_pci_get_host_bridge_resources(dev, dev->of_node, busno,
+						  bus_max, resources, io_base);
+}
+EXPORT_SYMBOL_GPL(devm_of_pci_get_host_bridge_resources);
+
 #endif /* CONFIG_OF_ADDRESS */
 
 /**
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 74eec1943ad2..08b8f02426a5 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -74,6 +74,9 @@ of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 int of_pci_get_host_bridge_resources(struct device_node *dev_node,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base);
+int devm_of_pci_get_host_bridge_resources(struct device *dev,
+			unsigned char busno, unsigned char bus_max,
+			struct list_head *resources, resource_size_t *io_base);
 #else
 static inline int of_pci_get_host_bridge_resources(struct device_node *dev_node,
 			unsigned char busno, unsigned char bus_max,
@@ -81,6 +84,13 @@ static inline int of_pci_get_host_bridge_resources(struct device_node *dev_node,
 {
 	return -EINVAL;
 }
+
+static inline int devm_of_pci_get_host_bridge_resources(struct device *dev,
+			unsigned char busno, unsigned char bus_max,
+			struct list_head *resources, resource_size_t *io_base)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif
-- 
2.13.6
