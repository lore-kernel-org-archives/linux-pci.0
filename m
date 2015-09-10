Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36174 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbbIJXnt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2015 19:43:49 -0400
Received: by ykdt18 with SMTP id t18so54898373ykd.3
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2015 16:43:48 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: l.stach@pengutronix.de, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 2/2] PCI: imx6: Add some defines for improving code readability
Date: Thu, 10 Sep 2015 20:43:29 -0300
Message-Id: <1441928609-21921-2-git-send-email-festevam@gmail.com>
In-Reply-To: <1441928609-21921-1-git-send-email-festevam@gmail.com>
References: <1441928609-21921-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

Instead of having some hardcoded values, it is preferred to use
defines when possible.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/pci/host/pci-imx6.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 2d0d0fe..f7a3951 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -55,6 +55,7 @@ struct imx6_pcie {
 #define PCIE_PL_PFLR_LINK_STATE_MASK		(0x3f << 16)
 #define PCIE_PL_PFLR_FORCE_LINK			(1 << 15)
 #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
+#define PCIE_PHY_DEBUG_R0_LTSSM_MASK		0x3f
 #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
 #define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING	(1 << 29)
 #define PCIE_PHY_DEBUG_R1_XMLH_LINK_UP		(1 << 4)
@@ -74,6 +75,7 @@ struct imx6_pcie {
 
 /* PHY registers (not memory-mapped) */
 #define PCIE_PHY_RX_ASIC_OUT 0x100D
+#define PCIE_PHY_RX_ASIC_OUT_VALID	1
 
 #define PHY_RX_OVRD_IN_LO 0x1005
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
@@ -503,10 +505,10 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
 	pcie_phy_read(pp->dbi_base, PCIE_PHY_RX_ASIC_OUT, &rx_valid);
 	debug_r0 = readl(pp->dbi_base + PCIE_PHY_DEBUG_R0);
 
-	if (rx_valid & 0x01)
+	if (rx_valid & PCIE_PHY_RX_ASIC_OUT_VALID)
 		return 0;
 
-	if ((debug_r0 & 0x3f) != 0x0d)
+	if ((debug_r0 & PCIE_PHY_DEBUG_R0_LTSSM_MASK) != 0x0d)
 		return 0;
 
 	dev_err(pp->dev, "transition to gen2 is stuck, reset PHY!\n");
-- 
1.9.1

