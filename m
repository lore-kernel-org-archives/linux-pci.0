Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:42529 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933151AbeB1Qfp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Feb 2018 11:35:45 -0500
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Shadi Ammouri <shadi@marvell.com>,
        Omri Itach <omrii@marvell.com>,
        Hanna Hawa <hannah@marvell.com>,
        Igal Liberman <igall@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v2 2/2] PCI: armada8k: Fix clock resource by adding a register clock
Date: Wed, 28 Feb 2018 17:35:30 +0100
Message-Id: <20180228163530.25389-3-gregory.clement@bootlin.com>
In-Reply-To: <20180228163530.25389-1-gregory.clement@bootlin.com>
References: <20180228163530.25389-1-gregory.clement@bootlin.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Armada 7K/8K we need to explicitly enable the register clock. This
clock is optional because not all the SoCs using this IP need it but at
least for Armada 7K/8K it is actually mandatory.

The binding documentation is updated accordingly.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 Documentation/devicetree/bindings/pci/pci-armada8k.txt |  5 ++++-
 drivers/pci/dwc/pcie-armada8k.c                        | 18 ++++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-armada8k.txt b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
index c1e4c3d10a74..9e3fc15e1af8 100644
--- a/Documentation/devicetree/bindings/pci/pci-armada8k.txt
+++ b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
@@ -12,7 +12,10 @@ Required properties:
    - "ctrl" for the control register region
    - "config" for the config space region
 - interrupts: Interrupt specifier for the PCIe controler
-- clocks: reference to the PCIe controller clock
+- clocks: reference to the PCIe controller clocks
+- clock-names: mandatory if there is a second clock, in this case the
+   name must be "core" for the first clock and "reg" for the second
+   one
 
 Example:
 
diff --git a/drivers/pci/dwc/pcie-armada8k.c b/drivers/pci/dwc/pcie-armada8k.c
index f9b1aec25c5c..072fd7ecc29f 100644
--- a/drivers/pci/dwc/pcie-armada8k.c
+++ b/drivers/pci/dwc/pcie-armada8k.c
@@ -28,6 +28,7 @@
 struct armada8k_pcie {
 	struct dw_pcie *pci;
 	struct clk *clk;
+	struct clk *clk_reg;
 };
 
 #define PCIE_VENDOR_REGS_OFFSET		0x8000
@@ -229,23 +230,36 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pcie->clk_reg = devm_clk_get(dev, "reg");
+	if (pcie->clk_reg == ERR_PTR(-EPROBE_DEFER)) {
+		ret = -EPROBE_DEFER;
+		goto fail;
+	}
+	if (!IS_ERR(pcie->clk_reg)) {
+		ret = clk_prepare_enable(pcie->clk_reg);
+		if (ret)
+			goto fail_clkreg;
+	}
+
 	/* Get the dw-pcie unit configuration/control registers base. */
 	base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
 	pci->dbi_base = devm_pci_remap_cfg_resource(dev, base);
 	if (IS_ERR(pci->dbi_base)) {
 		dev_err(dev, "couldn't remap regs base %p\n", base);
 		ret = PTR_ERR(pci->dbi_base);
-		goto fail;
+		goto fail_clkreg;
 	}
 
 	platform_set_drvdata(pdev, pcie);
 
 	ret = armada8k_add_pcie_port(pcie, pdev);
 	if (ret)
-		goto fail;
+		goto fail_clkreg;
 
 	return 0;
 
+fail_clkreg:
+	clk_disable_unprepare(pcie->clk_reg);
 fail:
 	clk_disable_unprepare(pcie->clk);
 
-- 
2.16.1
