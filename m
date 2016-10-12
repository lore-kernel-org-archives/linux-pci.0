Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754998AbcJLNsO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:48:14 -0400
Subject: [PATCH v2 2/8] PCI: imx6: Remove redundant of_node pointer
To: Richard Zhu <Richard.Zhu@freescale.com>,
        Lucas Stach <l.stach@pengutronix.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:47:48 -0500
Message-ID: <20161012134748.28919.61148.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012134335.28919.64137.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012134335.28919.64137.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

"np" and "node" are redundant copies of the of_node pointer.  Remove "np"
and use "node" instead.  Replace the "fsl,max-link-speed" use with "node"
as well.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-imx6.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 0838176..e20e9e8 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -618,7 +618,6 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct imx6_pcie *imx6_pcie;
 	struct pcie_port *pp;
-	struct device_node *np = dev->of_node;
 	struct resource *dbi_base;
 	struct device_node *node = dev->of_node;
 	int ret;
@@ -643,8 +642,8 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pp->dbi_base);
 
 	/* Fetch GPIOs */
-	imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
-	imx6_pcie->gpio_active_high = of_property_read_bool(np,
+	imx6_pcie->reset_gpio = of_get_named_gpio(node, "reset-gpio", 0);
+	imx6_pcie->gpio_active_high = of_property_read_bool(node,
 						"reset-gpio-active-high");
 	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
 		ret = devm_gpio_request_one(dev, imx6_pcie->reset_gpio,
@@ -717,7 +716,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		imx6_pcie->tx_swing_low = 127;
 
 	/* Limit link speed */
-	ret = of_property_read_u32(pp->dev->of_node, "fsl,max-link-speed",
+	ret = of_property_read_u32(node, "fsl,max-link-speed",
 				   &imx6_pcie->link_gen);
 	if (ret)
 		imx6_pcie->link_gen = 1;

