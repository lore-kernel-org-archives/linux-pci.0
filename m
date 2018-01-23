Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34421 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751721AbeAWPqF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jan 2018 10:46:05 -0500
Received: by mail-pg0-f67.google.com with SMTP id r19so549705pgn.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2018 07:46:05 -0800 (PST)
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        project-aspen-dev@linaro.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 2/2] PCI: histb: add an optional regulator for PCIe port power control
Date: Tue, 23 Jan 2018 23:45:37 +0800
Message-Id: <1516722337-1533-3-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1516722337-1533-1-git-send-email-shawn.guo@linaro.org>
References: <1516722337-1533-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The power supply to PCIe port are often controlled by GPIO on some board
designs.  Let's add an optional regulator which can be backed by GPIO to
control the power.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../bindings/pci/hisilicon-histb-pcie.txt           |  1 +
 drivers/pci/dwc/pcie-histb.c                        | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
index c84bc027930b..f995664e6d7f 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
@@ -34,6 +34,7 @@ Required properties
 
 Optional properties:
 - reset-gpios: The gpio to generate PCIe PERST# assert and deassert signal.
+- vpcie-supply: Should specify the regulator in charge of PCIe port power.
 - phys: List of phandle and phy mode specifier, should be 0.
 - phy-names: Must be "phy".
 
diff --git a/drivers/pci/dwc/pcie-histb.c b/drivers/pci/dwc/pcie-histb.c
index 6395394be5b4..8eb3028432b3 100644
--- a/drivers/pci/dwc/pcie-histb.c
+++ b/drivers/pci/dwc/pcie-histb.c
@@ -64,6 +64,7 @@ struct histb_pcie {
 	struct reset_control *bus_reset;
 	void __iomem *ctrl;
 	int reset_gpio;
+	struct regulator *vpcie;
 };
 
 static u32 histb_pcie_readl(struct histb_pcie *histb_pcie, u32 reg)
@@ -230,6 +231,9 @@ static void histb_pcie_host_disable(struct histb_pcie *hipcie)
 
 	if (gpio_is_valid(hipcie->reset_gpio))
 		gpio_set_value_cansleep(hipcie->reset_gpio, 0);
+
+	if (hipcie->vpcie)
+		regulator_disable(hipcie->vpcie);
 }
 
 static int histb_pcie_host_enable(struct pcie_port *pp)
@@ -240,6 +244,14 @@ static int histb_pcie_host_enable(struct pcie_port *pp)
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
 
@@ -285,6 +297,8 @@ static int histb_pcie_host_enable(struct pcie_port *pp)
 err_sys_clk:
 	clk_disable_unprepare(hipcie->bus_clk);
 err_bus_clk:
+	if (hipcie->vpcie)
+		regulator_disable(hipcie->vpcie);
 
 	return ret;
 }
@@ -334,6 +348,13 @@ static int histb_pcie_probe(struct platform_device *pdev)
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
