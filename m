Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54580 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932242AbbCCRw7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2015 12:52:59 -0500
From: Murali Karicheri <m-karicheri2@ti.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
	<devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Grant Likely <grant.likely@linaro.org>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v8 5/7] of/pci: Add of_pci_dma_configure() to update DMA configuration
Date: Tue, 3 Mar 2015 12:52:12 -0500
Message-ID: <1425405134-24707-6-git-send-email-m-karicheri2@ti.com>
In-Reply-To: <1425405134-24707-1-git-send-email-m-karicheri2@ti.com>
References: <1425405134-24707-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add of_pci_dma_configure() to allow updating the DMA configuration of the
PCI device using the configuration from DT of the parent of the root bridge
device.  Use the newly added APIs pci_get/put_host_bridge_device() for
implementing this.

Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com> (AMD Seattle)
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Rob Herring <robh+dt@kernel.org>
Acked-by: Will Deacon <will.deacon@arm.com>
CC: Joerg Roedel <joro@8bytes.org>
CC: Grant Likely <grant.likely@linaro.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: Arnd Bergmann <arnd@arndb.de>
---
 drivers/of/of_pci.c    |   18 ++++++++++++++++++
 include/linux/of_pci.h |    3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 62426d8..86d3c38 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -2,6 +2,7 @@
 #include <linux/export.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_pci.h>
 #include <linux/slab.h>
 
@@ -116,6 +117,23 @@ int of_get_pci_domain_nr(struct device_node *node)
 }
 EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
 
+/**
+ * of_pci_dma_configure - Setup DMA configuration
+ * @dev: ptr to pci_dev struct of the pci device
+ *
+ * Function to update PCI devices's DMA configuration using the same
+ * info from the OF node of root host bridge's parent.
+ */
+void of_pci_dma_configure(struct pci_dev *pci_dev)
+{
+	struct device *dev = &pci_dev->dev;
+	struct device *bridge = pci_get_host_bridge_device(pci_dev);
+
+	of_dma_configure(dev, bridge->parent->of_node);
+	pci_put_host_bridge_device(bridge);
+}
+EXPORT_SYMBOL_GPL(of_pci_dma_configure);
+
 #if defined(CONFIG_OF_ADDRESS)
 /**
  * of_pci_get_host_bridge_resources - Parse PCI host bridge resources from DT
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index ce0e5ab..29fd3fe 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -16,6 +16,7 @@ int of_pci_get_devfn(struct device_node *np);
 int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
 int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
 int of_get_pci_domain_nr(struct device_node *node);
+void of_pci_dma_configure(struct pci_dev *pci_dev);
 #else
 static inline int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
 {
@@ -50,6 +51,8 @@ of_get_pci_domain_nr(struct device_node *node)
 {
 	return -1;
 }
+
+static inline void of_pci_dma_configure(struct pci_dev *pci_dev) { }
 #endif
 
 #if defined(CONFIG_OF_ADDRESS)
-- 
1.7.9.5

