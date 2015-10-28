Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
To: <bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
	<catalin.marinas@arm.com>, <will.deacon@arm.com>
CC: <hanjun.guo@linaro.org>, <thomas.lendacky@amd.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH V5 8/9] PCI: OF: Move of_pci_dma_configure() to pci_dma_configure()
Date: Wed, 28 Oct 2015 15:50:53 -0700
Message-ID: <1446072654-5608-9-git-send-email-Suravee.Suthikulpanit@amd.com>
In-Reply-To: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch move of_pci_dma_configure() to a more generic
pci_dma_configure(), which can be extended by non-OF code (e.g. ACPI).

This has no functional change.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Acked-by: Rob Herring <robh+dt@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
CC: Rafael J. Wysocki <rjw@rjwysocki.net>
---
 drivers/of/of_pci.c    | 19 -------------------
 drivers/pci/probe.c    | 23 +++++++++++++++++++++--
 include/linux/of_pci.h |  3 ---
 3 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index a2f510c..b66ee4e 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -117,25 +117,6 @@ int of_get_pci_domain_nr(struct device_node *node)
 }
 EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
 
-/**
- * of_pci_dma_configure - Setup DMA configuration
- * @dev: ptr to pci_dev struct of the PCI device
- *
- * Function to update PCI devices's DMA configuration using the same
- * info from the OF node of host bridge's parent (if any).
- */
-void of_pci_dma_configure(struct pci_dev *pci_dev)
-{
-	struct device *dev = &pci_dev->dev;
-	struct device *bridge = pci_get_host_bridge_device(pci_dev);
-
-	if (bridge->parent)
-		of_dma_configure(dev, bridge->parent->of_node);
-
-	pci_put_host_bridge_device(bridge);
-}
-EXPORT_SYMBOL_GPL(of_pci_dma_configure);
-
 #if defined(CONFIG_OF_ADDRESS)
 /**
  * of_pci_get_host_bridge_resources - Parse PCI host bridge resources from DT
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8361d27..31e3eef 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -6,7 +6,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/of_pci.h>
+#include <linux/of_device.h>
 #include <linux/pci_hotplug.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -1633,6 +1633,25 @@ static void pci_set_msi_domain(struct pci_dev *dev)
 				   dev_get_msi_domain(&dev->bus->dev));
 }
 
+/**
+ * pci_dma_configure - Setup DMA configuration
+ * @dev: ptr to pci_dev struct of the PCI device
+ *
+ * Function to update PCI devices's DMA configuration using the same
+ * info from the OF node of host bridge's parent (if any).
+ */
+static void pci_dma_configure(struct pci_dev *dev)
+{
+	struct device *bridge = pci_get_host_bridge_device(dev);
+
+	if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {
+		if (bridge->parent)
+			of_dma_configure(&dev->dev, bridge->parent->of_node);
+	}
+
+	pci_put_host_bridge_device(bridge);
+}
+
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 {
 	int ret;
@@ -1646,7 +1665,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	dev->dev.dma_mask = &dev->dma_mask;
 	dev->dev.dma_parms = &dev->dma_parms;
 	dev->dev.coherent_dma_mask = 0xffffffffull;
-	of_pci_dma_configure(dev);
+	pci_dma_configure(dev);
 
 	pci_set_dma_max_seg_size(dev, 65536);
 	pci_set_dma_seg_boundary(dev, 0xffffffff);
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 29fd3fe..ce0e5ab 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -16,7 +16,6 @@ int of_pci_get_devfn(struct device_node *np);
 int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
 int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
 int of_get_pci_domain_nr(struct device_node *node);
-void of_pci_dma_configure(struct pci_dev *pci_dev);
 #else
 static inline int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
 {
@@ -51,8 +50,6 @@ of_get_pci_domain_nr(struct device_node *node)
 {
 	return -1;
 }
-
-static inline void of_pci_dma_configure(struct pci_dev *pci_dev) { }
 #endif
 
 #if defined(CONFIG_OF_ADDRESS)
-- 
2.1.0

