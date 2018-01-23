Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43232 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbeAWBE6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jan 2018 20:04:58 -0500
Received: by mail-pg0-f66.google.com with SMTP id n17so8459142pgf.10
        for <linux-pci@vger.kernel.org>; Mon, 22 Jan 2018 17:04:58 -0800 (PST)
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, project-aspen-dev@linaro.org,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] PCI: histb: add power control GPIO for PCIe slot
Date: Tue, 23 Jan 2018 09:04:37 +0800
Message-Id: <1516669477-20151-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jianguo Sun <sunjianguo1@huawei.com>

Besides the GPIO for controlling reset, there is also possibly another
GPIO for turning on/off the power of PCIe slot.  Let's add the support
for that with another optional device tree property 'power-gpios'.

Signed-off-by: Jianguo Sun <sunjianguo1@huawei.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../bindings/pci/hisilicon-histb-pcie.txt          |  1 +
 drivers/pci/dwc/pcie-histb.c                       | 28 +++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
index c84bc027930b..597397a048f8 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
@@ -33,6 +33,7 @@ Required properties
   "bus": bus reset.
 
 Optional properties:
+- power-gpios: The gpio to control the power of PCIe slot.
 - reset-gpios: The gpio to generate PCIe PERST# assert and deassert signal.
 - phys: List of phandle and phy mode specifier, should be 0.
 - phy-names: Must be "phy".
diff --git a/drivers/pci/dwc/pcie-histb.c b/drivers/pci/dwc/pcie-histb.c
index 33b01b734d7d..2a6b18619b25 100644
--- a/drivers/pci/dwc/pcie-histb.c
+++ b/drivers/pci/dwc/pcie-histb.c
@@ -63,6 +63,7 @@ struct histb_pcie {
 	struct reset_control *sys_reset;
 	struct reset_control *bus_reset;
 	void __iomem *ctrl;
+	int power_gpio;
 	int reset_gpio;
 };
 
@@ -230,6 +231,8 @@ static void histb_pcie_host_disable(struct histb_pcie *hipcie)
 
 	if (gpio_is_valid(hipcie->reset_gpio))
 		gpio_set_value_cansleep(hipcie->reset_gpio, 0);
+	if (gpio_is_valid(hipcie->power_gpio))
+		gpio_set_value_cansleep(hipcie->power_gpio, 0);
 }
 
 static int histb_pcie_host_enable(struct pcie_port *pp)
@@ -240,8 +243,14 @@ static int histb_pcie_host_enable(struct pcie_port *pp)
 	int ret;
 
 	/* power on PCIe device if have */
-	if (gpio_is_valid(hipcie->reset_gpio))
+	if (gpio_is_valid(hipcie->power_gpio))
+		gpio_set_value_cansleep(hipcie->power_gpio, 1);
+
+	if (gpio_is_valid(hipcie->reset_gpio)) {
+		gpio_set_value_cansleep(hipcie->reset_gpio, 0);
+		mdelay(10);
 		gpio_set_value_cansleep(hipcie->reset_gpio, 1);
+	}
 
 	ret = clk_prepare_enable(hipcie->bus_clk);
 	if (ret) {
@@ -335,15 +344,28 @@ static int histb_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pci->dbi_base);
 	}
 
+	hipcie->power_gpio = of_get_named_gpio_flags(np,
+				"power-gpios", 0, &of_flags);
+	if (of_flags & OF_GPIO_ACTIVE_LOW)
+		flag |= GPIOF_ACTIVE_LOW;
+	if (gpio_is_valid(hipcie->power_gpio)) {
+		ret = devm_gpio_request_one(dev, hipcie->power_gpio,
+				flag, "PCIe device power control");
+		if (ret) {
+			dev_err(dev, "unable to request power gpio\n");
+			return ret;
+		}
+	}
+
 	hipcie->reset_gpio = of_get_named_gpio_flags(np,
 				"reset-gpios", 0, &of_flags);
 	if (of_flags & OF_GPIO_ACTIVE_LOW)
 		flag |= GPIOF_ACTIVE_LOW;
 	if (gpio_is_valid(hipcie->reset_gpio)) {
 		ret = devm_gpio_request_one(dev, hipcie->reset_gpio,
-				flag, "PCIe device power control");
+				flag, "PCIe device reset control");
 		if (ret) {
-			dev_err(dev, "unable to request gpio\n");
+			dev_err(dev, "unable to request reset gpio\n");
 			return ret;
 		}
 	}
-- 
1.9.1
