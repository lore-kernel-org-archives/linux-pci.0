Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
To: <bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
	<catalin.marinas@arm.com>, <will.deacon@arm.com>
CC: <hanjun.guo@linaro.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Rob Herring <robh+dt@kernel.org>,
	"Murali Karicheri" <m-karicheri2@ti.com>
Subject: [PATCH V3 4/4] PCI: ACPI: Add support for PCI device DMA coherency
Date: Wed, 26 Aug 2015 20:54:39 +0700
Message-ID: <1440597279-11802-5-git-send-email-Suravee.Suthikulpanit@amd.com>
In-Reply-To: <1440597279-11802-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1440597279-11802-1-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds support for setting up PCI device DMA coherency from
ACPI _CCA object that should normally be specified in the DSDT node
of its PCI host bridge.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Will Deacon <will.deacon@arm.com>
CC: Rafael J. Wysocki <rjw@rjwysocki.net>
CC: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/pci/probe.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4de6594..7cfd8e2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1551,17 +1551,25 @@ static void pci_init_capabilities(struct pci_dev *dev)
  * @dev: ptr to pci_dev struct of the PCI device
  *
  * Function to update PCI devices's DMA configuration using the same
- * info from the OF node of host bridge's parent (if any).
+ * info from the OF node or ACPI node of host bridge's parent (if any).
  */
 static void pci_dma_configure(struct pci_dev *dev)
 {
 	struct device *bridge = pci_get_host_bridge_device(dev);
 
 	if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {
-		if (!bridge->parent)
-			return;
-
-		of_dma_configure(&dev->dev, bridge->parent->of_node);
+		if (bridge->parent)
+			of_dma_configure(&dev->dev,
+					 bridge->parent->of_node);
+	} else if (has_acpi_companion(bridge)) {
+		struct acpi_device *adev = to_acpi_node(bridge->fwnode);
+		int ret = acpi_check_dma_coherency(adev);
+
+		if (ret < 0)
+			WARN(1, FW_BUG "PCI device %s fail to setup DMA.\n",
+			     pci_name(dev));
+		else
+			arch_setup_dma_ops(&dev->dev, 0, 0, NULL, ret);
 	}
 
 	pci_put_host_bridge_device(bridge);
-- 
2.1.0

