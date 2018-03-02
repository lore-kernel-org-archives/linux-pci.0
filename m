Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43316 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163354AbeCBBMn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Mar 2018 20:12:43 -0500
Received: by mail-pl0-f67.google.com with SMTP id f23-v6so4704705plr.10
        for <linux-pci@vger.kernel.org>; Thu, 01 Mar 2018 17:12:43 -0800 (PST)
From: Shawn Guo <shawn.guo@linaro.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 2/2] PCI: histb: Add an optional regulator for PCIe port power control
Date: Fri,  2 Mar 2018 09:12:01 +0800
Message-Id: <1519953121-28218-3-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1519953121-28218-1-git-send-email-shawn.guo@linaro.org>
References: <1519953121-28218-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The power supply to PCIe port are often controlled by GPIO on some board
designs.  Let's add an optional regulator which can be backed by GPIO to
control the power.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pci/hisilicon-histb-pcie.txt           |  1 +
 drivers/pci/dwc/pcie-histb.c                        | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
index c84bc027930b..760b4d740616 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
@@ -34,6 +34,7 @@ Required properties
 
 Optional properties:
 - reset-gpios: The gpio to generate PCIe PERST# assert and deassert signal.
+- vpcie-supply: The regulator in charge of PCIe port power.
 - phys: List of phandle and phy mode specifier, should be 0.
 - phy-names: Must be "phy".
 
diff --git a/drivers/pci/dwc/pcie-histb.c b/drivers/pci/dwc/pcie-histb.c
index 17ed604f5741..4cef0a514944 100644
--- a/drivers/pci/dwc/pcie-histb.c
+++ b/drivers/pci/dwc/pcie-histb.c
@@ -61,6 +61,7 @@ struct histb_pcie {
 	struct reset_control *bus_reset;
 	void __iomem *ctrl;
 	int reset_gpio;
+	struct regulator *vpcie;
 };
 
 static u32 histb_pcie_readl(struct histb_pcie *histb_pcie, u32 reg)
@@ -227,6 +228,9 @@ static void histb_pcie_host_disable(struct histb_pcie *hipcie)
 
 	if (gpio_is_valid(hipcie->reset_gpio))
 		gpio_set_value_cansleep(hipcie->reset_gpio, 0);
+
+	if (hipcie->vpcie)
+		regulator_disable(hipcie->vpcie);
 }
 
 static int histb_pcie_host_enable(struct pcie_port *pp)
@@ -237,6 +241,14 @@ static int histb_pcie_host_enable(struct pcie_port *pp)
 	int ret;
 
 	/* power on PCIe device if have */
+	if (hipcie->vpcie) {
+		ret = regulator_enable(hipcie->vpcie);
+		if (ret) {
+			dev_err(dev, "failed to enable regulator: %d\n", ret);
+			return ret;
+		}
+	}
+
 	if (gpio_is_valid(hipcie->reset_gpio))
 		gpio_set_value_cansleep(hipcie->reset_gpio, 1);
 
@@ -282,6 +294,8 @@ static int histb_pcie_host_enable(struct pcie_port *pp)
 err_sys_clk:
 	clk_disable_unprepare(hipcie->bus_clk);
 err_bus_clk:
+	if (hipcie->vpcie)
+		regulator_disable(hipcie->vpcie);
 
 	return ret;
 }
@@ -331,6 +345,13 @@ static int histb_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pci->dbi_base);
 	}
 
+	hipcie->vpcie = devm_regulator_get_optional(dev, "vpcie");
+	if (IS_ERR(hipcie->vpcie)) {
+		if (PTR_ERR(hipcie->vpcie) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		hipcie->vpcie = NULL;
+	}
+
 	hipcie->reset_gpio = of_get_named_gpio_flags(np,
 				"reset-gpios", 0, &of_flags);
 	if (of_flags & OF_GPIO_ACTIVE_LOW)
-- 
1.9.1
