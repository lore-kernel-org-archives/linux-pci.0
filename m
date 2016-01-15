Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36474 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752542AbcAOS4y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2016 13:56:54 -0500
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Zhu <Richard.Zhu@freescale.com>, linux-pci@vger.kernel.org,
	kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: [PATCH 3/4] PCI: imx6: remove broken Gen2 workaround
Date: Fri, 15 Jan 2016 19:56:49 +0100
Message-Id: <1452884210-11359-4-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1452884210-11359-1-git-send-email-l.stach@pengutronix.de>
References: <1452884210-11359-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This removes the remnants of the workaround for erratum ERR005184
which was never completely implemented. The checks alone don't
carry any value as we don't act properly on the result.

A proper implementation of the workaround should be added to
the lane speed change in establish_link later.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pci-imx6.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 3bb8ccc68792..f38aa7678868 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -467,7 +467,7 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 
 static int imx6_pcie_link_up(struct pcie_port *pp)
 {
-	u32 rc, debug_r0, rx_valid;
+	u32 rc;
 	int count = 5;
 
 	/*
@@ -501,21 +501,6 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
 		 */
 		usleep_range(1000, 2000);
 	}
-	/*
-	 * From L0, initiate MAC entry to gen2 if EP/RC supports gen2.
-	 * Wait 2ms (LTSSM timeout is 24ms, PHY lock is ~5us in gen2).
-	 * If (MAC/LTSSM.state == Recovery.RcvrLock)
-	 * && (PHY/rx_valid==0) then pulse PHY/rx_reset. Transition
-	 * to gen2 is stuck
-	 */
-	pcie_phy_read(pp->dbi_base, PCIE_PHY_RX_ASIC_OUT, &rx_valid);
-	debug_r0 = readl(pp->dbi_base + PCIE_PHY_DEBUG_R0);
-
-	if (rx_valid & PCIE_PHY_RX_ASIC_OUT_VALID)
-		return 0;
-
-	if ((debug_r0 & 0x3f) != 0x0d)
-		return 0;
 
 	return 0;
 }
-- 
2.6.4

