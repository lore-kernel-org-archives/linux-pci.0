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
Subject: [PATCH V5 9/9] PCI: ACPI: Add support for PCI device DMA coherency
Date: Wed, 28 Oct 2015 15:50:54 -0700
Message-ID: <1446072654-5608-10-git-send-email-Suravee.Suthikulpanit@amd.com>
In-Reply-To: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds support for setting up PCI device DMA coherency from
ACPI _CCA object that should normally be specified in the DSDT node
of its PCI host bridge.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
CC: Rafael J. Wysocki <rjw@rjwysocki.net>
---
 drivers/pci/probe.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 31e3eef..40eed54 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/cpumask.h>
 #include <linux/pci-aspm.h>
+#include <linux/acpi.h>
 #include <asm-generic/pci-bridge.h>
 #include "pci.h"
 
@@ -1638,7 +1639,7 @@ static void pci_set_msi_domain(struct pci_dev *dev)
  * @dev: ptr to pci_dev struct of the PCI device
  *
  * Function to update PCI devices's DMA configuration using the same
- * info from the OF node of host bridge's parent (if any).
+ * info from the OF node or ACPI node of host bridge's parent (if any).
  */
 static void pci_dma_configure(struct pci_dev *dev)
 {
@@ -1647,6 +1648,15 @@ static void pci_dma_configure(struct pci_dev *dev)
 	if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {
 		if (bridge->parent)
 			of_dma_configure(&dev->dev, bridge->parent->of_node);
+	} else if (has_acpi_companion(bridge)) {
+		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
+		enum dev_dma_attr attr = acpi_get_dma_attr(adev);
+
+		if (attr == DEV_DMA_NOT_SUPPORTED)
+			dev_warn(&dev->dev, "DMA not supported.\n");
+		else
+			arch_setup_dma_ops(&dev->dev, 0, 0, NULL,
+					   attr == DEV_DMA_COHERENT);
 	}
 
 	pci_put_host_bridge_device(bridge);
-- 
2.1.0

