Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53059 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751448AbcAOS4y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2016 13:56:54 -0500
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Zhu <Richard.Zhu@freescale.com>, linux-pci@vger.kernel.org,
	kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: [PATCH 2/4] PCI: imx6: move PHY reset into establish_link
Date: Fri, 15 Jan 2016 19:56:48 +0100
Message-Id: <1452884210-11359-3-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1452884210-11359-1-git-send-email-l.stach@pengutronix.de>
References: <1452884210-11359-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds the PHY reset into a common error path of the
establish_link function, deduplicating some of the debug
prints. Also reduce the severity of the "no-link" message
in the one place where it is expected to be hit when no
peripheral is attached.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pci-imx6.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 48ee2ed26be3..3bb8ccc68792 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -355,10 +355,6 @@ static int imx6_pcie_wait_for_link(struct pcie_port *pp)
 		usleep_range(100, 1000);
 	}
 
-	dev_err(pp->dev, "phy link never came up\n");
-	dev_dbg(pp->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-		readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
-		readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
 	return -EINVAL;
 }
 
@@ -407,8 +403,10 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
 			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
 
 	ret = imx6_pcie_wait_for_link(pp);
-	if (ret)
-		return ret;
+	if (ret) {
+		dev_info(pp->dev, "Link never came up\n");
+		goto err_reset_phy;
+	}
 
 	/* Allow Gen2 mode after the link is up. */
 	tmp = readl(pp->dbi_base + PCIE_RC_LCR);
@@ -427,19 +425,28 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
 	ret = imx6_pcie_wait_for_speed_change(pp);
 	if (ret) {
 		dev_err(pp->dev, "Failed to bring link up!\n");
-		return ret;
+		goto err_reset_phy;
 	}
 
 	/* Make sure link training is finished as well! */
 	ret = imx6_pcie_wait_for_link(pp);
 	if (ret) {
 		dev_err(pp->dev, "Failed to bring link up!\n");
-		return ret;
+		goto err_reset_phy;
 	}
 
 	tmp = readl(pp->dbi_base + PCIE_RC_LCSR);
 	dev_dbg(pp->dev, "Link up, Gen=%i\n", (tmp >> 16) & 0xf);
+
 	return 0;
+
+err_reset_phy:
+	dev_dbg(pp->dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
+		readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
+		readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
+	imx6_pcie_reset_phy(pp);
+
+	return ret;
 }
 
 static void imx6_pcie_host_init(struct pcie_port *pp)
@@ -510,11 +517,6 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
 	if ((debug_r0 & 0x3f) != 0x0d)
 		return 0;
 
-	dev_err(pp->dev, "transition to gen2 is stuck, reset PHY!\n");
-	dev_dbg(pp->dev, "debug_r0=%08x debug_r1=%08x\n", debug_r0, rc);
-
-	imx6_pcie_reset_phy(pp);
-
 	return 0;
 }
 
-- 
2.6.4

