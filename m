Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49166 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753473AbbLDU7O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Dec 2015 15:59:14 -0500
Date: Fri, 4 Dec 2015 14:59:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <Richard.Zhu@freescale.com>
Subject: Re: [PATCH v3] PCI: imx6: Fix reset-gpio to work with active low GPIO
Message-ID: <20151204205906.GG20125@localhost>
References: <1448620464.3689.94.camel@pengutronix.de>
 <1448621794-19916-1-git-send-email-ynezz@true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1448621794-19916-1-git-send-email-ynezz@true.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 27, 2015 at 11:56:34AM +0100, Petr Štetiar wrote:
> It's currently not possible to use reset-gpio on board where the GPIO is
> active low as the code incorrectly assumes, that reset-gpio will be
> always active high.
> 
> In my case the broken behavior was observed on Toradex Apalis SoM with
> Ixora base board.
> 
> Signed-off-by: Petr Štetiar <ynezz@true.cz>

Applied as follows with Lucas' reviewed-by to pci/host-imx6 for v4.5,
thanks!


commit 5c5fb40de8f14391a1238db05cef88754faf9229
Author: Petr Štetiar <ynezz@true.cz>
Date:   Fri Nov 27 11:56:34 2015 +0100

    PCI: imx6: Add support for active-low reset GPIO
    
    We previously used of_get_named_gpio(), which ignores the OF flags cell, so
    the reset GPIO defaulted to "active high." This doesn't work on the Toradex
    Apalis SoM with Ixora base board, which has an active-low reset GPIO.
    
    Use devm_gpiod_get_optional() instead so we pay attention to the active
    high/low flag.  This also adds support for GPIOs described via ACPI.
    
    [bhelgaas: changelog]
    Signed-off-by: Petr Štetiar <ynezz@true.cz>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 3c3b37f..8e9afa5 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -32,7 +32,7 @@
 #define to_imx6_pcie(x)	container_of(x, struct imx6_pcie, pp)
 
 struct imx6_pcie {
-	int			reset_gpio;
+	struct gpio_desc	*reset_gpio;
 	struct clk		*pcie_bus;
 	struct clk		*pcie_phy;
 	struct clk		*pcie;
@@ -287,10 +287,10 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 	usleep_range(200, 500);
 
 	/* Some boards don't have PCIe reset GPIO. */
-	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
-		gpio_set_value_cansleep(imx6_pcie->reset_gpio, 0);
+	if (imx6_pcie->reset_gpio) {
+		gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 0);
 		msleep(100);
-		gpio_set_value_cansleep(imx6_pcie->reset_gpio, 1);
+		gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 1);
 	}
 	return 0;
 
@@ -560,7 +560,6 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 {
 	struct imx6_pcie *imx6_pcie;
 	struct pcie_port *pp;
-	struct device_node *np = pdev->dev.of_node;
 	struct resource *dbi_base;
 	int ret;
 
@@ -581,15 +580,8 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pp->dbi_base);
 
 	/* Fetch GPIOs */
-	imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
-	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
-		ret = devm_gpio_request_one(&pdev->dev, imx6_pcie->reset_gpio,
-					    GPIOF_OUT_INIT_LOW, "PCIe reset");
-		if (ret) {
-			dev_err(&pdev->dev, "unable to get reset gpio\n");
-			return ret;
-		}
-	}
+	imx6_pcie->reset_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
+							GPIOD_OUT_LOW);
 
 	/* Fetch clocks */
 	imx6_pcie->pcie_phy = devm_clk_get(&pdev->dev, "pcie_phy");
