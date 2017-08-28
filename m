Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51771 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751859AbdH1OXN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2017 10:23:13 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        patchwork-lst@pengutronix.de, kernel@pengutronix.de
Subject: [PATCH 2/3] PCI: imx6: allow MSI irq to be absent
Date: Mon, 28 Aug 2017 16:23:06 +0200
Message-Id: <20170828142307.30061-3-l.stach@pengutronix.de>
In-Reply-To: <20170828142307.30061-1-l.stach@pengutronix.de>
References: <20170828142307.30061-1-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The host can fall back to PCIe legacy IRQ only operation if the MSI irq is
missing, thus allowing systems to work with peripherals that don't support
MSI irqs.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  8 ++++----
 drivers/pci/dwc/pci-imx6.c                         | 23 +++++++++++-----------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index cf92d3ba5a26..d85db21503f4 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -10,14 +10,14 @@ Required properties:
 	- "fsl,imx6qp-pcie"
 	- "fsl,imx7d-pcie"
 - reg: base address and length of the PCIe controller
-- interrupts: A list of interrupt outputs of the controller. Must contain an
-  entry for each entry in the interrupt-names property.
-- interrupt-names: Must include the following entries:
-	- "msi": The interrupt that is asserted when an MSI is received
 - clock-names: Must include the following additional entries:
 	- "pcie_phy"
 
 Optional properties:
+- interrupts: A list of interrupt outputs of the controller. Must contain an
+  entry for each entry in the interrupt-names property.
+- interrupt-names: Must include the following entries:
+        - "msi": The interrupt that is asserted when an MSI is received
 - fsl,tx-deemph-gen1: Gen1 De-emphasis value. Default: 0
 - fsl,tx-deemph-gen2-3p5db: Gen2 (3.5db) De-emphasis value. Default: 0
 - fsl,tx-deemph-gen2-6db: Gen2 (6db) De-emphasis value. Default: 20
diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index bf5c3616e344..d2507272b3ab 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -671,18 +671,17 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
-		if (pp->msi_irq <= 0) {
-			dev_err(dev, "failed to get MSI irq\n");
-			return -ENODEV;
-		}
-
-		ret = devm_request_irq(dev, pp->msi_irq,
-				       imx6_pcie_msi_handler,
-				       IRQF_SHARED | IRQF_NO_THREAD,
-				       "mx6-pcie-msi", imx6_pcie);
-		if (ret) {
-			dev_err(dev, "failed to request MSI irq\n");
-			return ret;
+		if (pp->msi_irq > 0) {
+			ret = devm_request_irq(dev, pp->msi_irq,
+					       imx6_pcie_msi_handler,
+					       IRQF_SHARED | IRQF_NO_THREAD,
+					       "mx6-pcie-msi", imx6_pcie);
+			if (ret) {
+				dev_err(dev, "failed to request MSI irq\n");
+				return ret;
+			}
+		} else {
+			dev_info(dev, "missing MSI irq, MSI support unavailable\n");
 		}
 	}
 
-- 
2.11.0
