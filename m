Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938859AbcJGQjy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:39:54 -0400
Subject: [PATCH 09/10] PCI: imx6: Remove redundant of_node pointer
To: Richard Zhu <Richard.Zhu@freescale.com>,
        Lucas Stach <l.stach@pengutronix.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:39:50 -0500
Message-ID: <20161007163950.25776.62880.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163839.25776.2512.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163839.25776.2512.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

"node" is a redundant copy of the "np" of_node pointer.  Remove "node" and
use "np" instead.  Replace the "fsl,max-link-speed" use with "np" as well.
No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-imx6.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 2d9ccbb..9f35f3a 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -612,7 +612,6 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	struct pcie_port *pp;
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *dbi_base;
-	struct device_node *node = pdev->dev.of_node;
 	int ret;
 
 	imx6 = devm_kzalloc(&pdev->dev, sizeof(*imx6), GFP_KERNEL);
@@ -691,29 +690,26 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	}
 
 	/* Grab PCIe PHY Tx Settings */
-	if (of_property_read_u32(node, "fsl,tx-deemph-gen1",
+	if (of_property_read_u32(np, "fsl,tx-deemph-gen1",
 				 &imx6->tx_deemph_gen1))
 		imx6->tx_deemph_gen1 = 0;
 
-	if (of_property_read_u32(node, "fsl,tx-deemph-gen2-3p5db",
+	if (of_property_read_u32(np, "fsl,tx-deemph-gen2-3p5db",
 				 &imx6->tx_deemph_gen2_3p5db))
 		imx6->tx_deemph_gen2_3p5db = 0;
 
-	if (of_property_read_u32(node, "fsl,tx-deemph-gen2-6db",
+	if (of_property_read_u32(np, "fsl,tx-deemph-gen2-6db",
 				 &imx6->tx_deemph_gen2_6db))
 		imx6->tx_deemph_gen2_6db = 20;
 
-	if (of_property_read_u32(node, "fsl,tx-swing-full",
-				 &imx6->tx_swing_full))
+	if (of_property_read_u32(np, "fsl,tx-swing-full", &imx6->tx_swing_full))
 		imx6->tx_swing_full = 127;
 
-	if (of_property_read_u32(node, "fsl,tx-swing-low",
-				 &imx6->tx_swing_low))
+	if (of_property_read_u32(np, "fsl,tx-swing-low", &imx6->tx_swing_low))
 		imx6->tx_swing_low = 127;
 
 	/* Limit link speed */
-	ret = of_property_read_u32(pp->dev->of_node, "fsl,max-link-speed",
-				   &imx6->link_gen);
+	ret = of_property_read_u32(np, "fsl,max-link-speed", &imx6->link_gen);
 	if (ret)
 		imx6->link_gen = 1;
 

