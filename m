Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:53623 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752554AbeDOS4Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Apr 2018 14:56:24 -0400
Date: Sun, 15 Apr 2018 20:56:21 +0200
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@axis.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: dwc: artpec6: Add reset-gpios for PERST# control
Message-ID: <20180415185621.GR16746@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some devices need an optional external gpio for controlling
the PERST# signal to bring up for example a PCIe switch
after a soft reset.

Without this, some boards (the ARTPEC-6 master devboard)
would not get the PCIe link back after a soft reset.

Signed-off-by: Jesper Nilsson <jesper.nilsson@axis.com>
---
 .../devicetree/bindings/pci/axis,artpec6-pcie.txt    |  4 ++++
 drivers/pci/dwc/pcie-artpec6.c                       | 20 +++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
index 979dc7b6cfe8..810bd461e81c 100644
--- a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
@@ -21,6 +21,10 @@ and thus inherits all the common properties defined in designware-pcie.txt.
 - axis,syscon-pcie: A phandle pointing to the ARTPEC-6 system controller,
 	used to enable and control the Synopsys IP.
 
+Optional properties:
+
+- reset-gpios: GPIO to generate PCIe PERST# assert and deassert signal.
+
 Example:
 
 	pcie@f8050000 {
diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index 93b3df9ed1b5..1eada6d1a381 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -19,6 +19,8 @@
 #include <linux/interrupt.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 
 #include "pcie-designware.h"
 
@@ -35,6 +37,7 @@ struct artpec6_pcie {
 	void __iomem		*phy_base;	/* DT phy */
 	enum artpec_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
+	struct gpio_desc	*reset;
 };
 
 struct artpec_pcie_of_data {
@@ -350,6 +353,13 @@ static void artpec6_pcie_deassert_core_reset(struct artpec6_pcie *artpec6_pcie)
 	}
 	artpec6_pcie_writel(artpec6_pcie, PCIECFG, val);
 	usleep_range(100, 200);
+
+	/* Some boards don't have PCIe reset hardwired, use a GPIO insted. */
+	if (artpec6_pcie->reset) {
+		gpiod_set_value_cansleep(artpec6_pcie->reset, 1);
+		msleep(100);
+		gpiod_set_value_cansleep(artpec6_pcie->reset, 0);
+	}
 }
 
 static void artpec6_pcie_enable_interrupts(struct artpec6_pcie *artpec6_pcie)
@@ -513,6 +523,7 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 	const struct artpec_pcie_of_data *data;
 	enum artpec_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
+	struct device_node *node = dev->of_node;
 
 	match = of_match_device(artpec6_pcie_of_match, dev);
 	if (!match)
@@ -548,11 +559,18 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(artpec6_pcie->phy_base);
 
 	artpec6_pcie->regmap =
-		syscon_regmap_lookup_by_phandle(dev->of_node,
+		syscon_regmap_lookup_by_phandle(node,
 						"axis,syscon-pcie");
 	if (IS_ERR(artpec6_pcie->regmap))
 		return PTR_ERR(artpec6_pcie->regmap);
 
+	artpec6_pcie->reset = devm_gpiod_get_optional(dev, "reset",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(artpec6_pcie->reset)) {
+		dev_err(dev, "Failed to request reset gpio\n");
+		return PTR_ERR(artpec6_pcie->reset);
+	}
+
 	platform_set_drvdata(pdev, artpec6_pcie);
 
 	switch (artpec6_pcie->mode) {
-- 
2.1.4

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
