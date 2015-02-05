Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57082 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570AbbBEVx4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 5 Feb 2015 16:53:56 -0500
From: Murali Karicheri <m-karicheri2@ti.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
	<devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: Murali Karicheri <m-karicheri2@ti.com>,
	Joerg Roedel <joro@8bytes.org>,
	Grant Likely <grant.likely@linaro.org>,
	Will Deacon <will.deacon@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH v6 5/7] of/pci: add of_pci_dma_configure() update dma configuration
Date: Thu, 5 Feb 2015 16:52:57 -0500
Message-ID: <1423173179-10227-6-git-send-email-m-karicheri2@ti.com>
In-Reply-To: <1423173179-10227-1-git-send-email-m-karicheri2@ti.com>
References: <1423173179-10227-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add of_pci_dma_configure() to allow updating the dma configuration
of the pci device using the configuration from DT of the parent of
the root bridge device. Use the newly added APIs
pci_get/put_host_bridge_device() for implementing this.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/of/of_pci.c    |   19 +++++++++++++++++++
 include/linux/of_pci.h |    5 +++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 88471d3..0f1dd0b 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -2,6 +2,7 @@
 #include <linux/export.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_pci.h>
 #include <linux/slab.h>
 
@@ -229,6 +230,24 @@ parse_failed:
 	return err;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
+
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
 #endif /* CONFIG_OF_ADDRESS */
 
 #ifdef CONFIG_PCI_MSI
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index ce0e5ab..8f1741f 100644
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
@@ -50,6 +51,10 @@ of_get_pci_domain_nr(struct device_node *node)
 {
 	return -1;
 }
+
+static inline void of_pci_dma_configure(struct pci_dev *pci_dev)
+{
+}
 #endif
 
 #if defined(CONFIG_OF_ADDRESS)
-- 
1.7.9.5

