Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0041.outbound.protection.outlook.com ([104.47.38.41]:6512
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751128AbcHaGuz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Aug 2016 02:50:55 -0400
From: Po Liu <po.liu@nxp.com>
To: <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        Rob Herring <robh@kernel.org>, Roy Zang <roy.zang@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Stuart Yoder <stuart.yoder@nxp.com>,
        Yang-Leo Li <leoyang.li@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Minghuan Lian <minghuan.lian@nxp.com>,
        Murali Karicheri <m-karicheri2@ti.com>, Po Liu <po.liu@nxp.com>
Subject: [PATCH v4 2/2] pci:aer: add support aer interrupt with none MSI/MSI-X/INTx mode
Date: Wed, 31 Aug 2016 14:37:22 +0800
Message-ID: <1472625442-23309-2-git-send-email-po.liu@nxp.com>
In-Reply-To: <1472625442-23309-1-git-send-email-po.liu@nxp.com>
References: <1465892645-32381-2-git-send-email-po.liu@nxp.com>
 <1472625442-23309-1-git-send-email-po.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On some platforms, root port doesn't support MSI/MSI-X/INTx in RC mode.
When chip support the aer interrupt with none MSI/MSI-X/INTx mode,
maybe there is interrupt line for aer pme etc. Search the interrupt
number in the fdt file. Then fixup the dev->irq with it.

Signed-off-by: Po Liu <po.liu@nxp.com>
---
Changes for v4:
	- re-use the patch changes in the root port driver;
	- add binding information;

 .../devicetree/bindings/pci/layerscape-pci.txt     |  4 +--
 drivers/pci/pcie/portdrv_core.c                    | 31 +++++++++++++++++++---
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index 41e9f55..1dfb1da 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -19,7 +19,7 @@ Required properties:
 - interrupts: A list of interrupt outputs of the controller. Must contain an
   entry for each entry in the interrupt-names property.
 - interrupt-names: Must include the following entries:
-  "intr": The interrupt that is asserted for controller interrupts
+  "aer": The interrupt that is asserted for aer interrupts
 - fsl,pcie-scfg: Must include two entries.
   The first entry must be a link to the SCFG device node
   The second entry must be '0' or '1' based on physical PCIe controller index.
@@ -36,7 +36,7 @@ Example:
 		       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 		reg-names = "regs", "config";
 		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
-		interrupt-names = "intr";
+		interrupt-names = "aer";
 		fsl,pcie-scfg = <&scfg 0>;
 		#address-cells = <3>;
 		#size-cells = <2>;
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e9270b4..7c4943d 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/pcieport_if.h>
 #include <linux/aer.h>
+#include <linux/of_irq.h>
 
 #include "../pci.h"
 #include "portdrv.h"
@@ -200,6 +201,28 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *vectors, int mask)
 static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 {
 	int i, irq = -1;
+	int ret;
+	struct device_node *np = NULL;
+
+	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
+		irqs[i] = 0;
+
+	if (dev->bus->dev.of_node)
+		np = dev->bus->dev.of_node;
+
+	/* If root port doesn't support MSI/MSI-X/INTx in RC mode,
+	 * request irq for aer
+	 */
+	if (IS_ENABLED(CONFIG_OF_IRQ) && np &&
+			(mask & PCIE_PORT_SERVICE_PME)) {
+		ret = of_irq_get_byname(np, "aer");
+		if (ret > 0) {
+			irqs[PCIE_PORT_SERVICE_AER_SHIFT] = ret;
+			if (dev->irq)
+				irq = dev->irq;
+			goto no_msi;
+		}
+	}
 
 	/*
 	 * If MSI cannot be used for PCIe PME or hotplug, we have to use
@@ -225,11 +248,13 @@ static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 		irq = dev->irq;
 
  no_msi:
-	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
-		irqs[i] = irq;
+	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
+		if (!irqs[i])
+			irqs[i] = irq;
+	}
 	irqs[PCIE_PORT_SERVICE_VC_SHIFT] = -1;
 
-	if (irq < 0)
+	if (irq < 0 && irqs[PCIE_PORT_SERVICE_AER_SHIFT] < 0)
 		return -ENODEV;
 	return 0;
 }
-- 
2.1.0.27.g96db324

