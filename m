Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54808 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752535AbcAOS4y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2016 13:56:54 -0500
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Zhu <Richard.Zhu@freescale.com>, linux-pci@vger.kernel.org,
	kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: [PATCH 4/4] PCI: imx6: move link up check into establish link path
Date: Fri, 15 Jan 2016 19:56:50 +0100
Message-Id: <1452884210-11359-5-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1452884210-11359-1-git-send-email-l.stach@pengutronix.de>
References: <1452884210-11359-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Instead of calling dw_pcie_link_up(), which just reflects into
our link_up() function, inline the relevant checks into the
wait_for_link() function.

This simplifies the code a lot and moves out any possible
sleeping waits from the link_up() hotpath, which may be called
with the config spinlock held, leaving only a lightweight
register read in this path.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pci-imx6.c | 60 +++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 38 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index f38aa7678868..6ab4657dee57 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -349,10 +349,28 @@ static int imx6_pcie_wait_for_link(struct pcie_port *pp)
 {
 	unsigned int retries;
 
+	/*
+	 * Test if the PHY reports that the link is up and also that the LTSSM
+	 * training finished. There are three possible states of the link when
+	 * this code is called:
+	 * 1) The link is DOWN (unlikely)
+	 *    The link didn't come up yet for some reason. This usually means
+	 *    we have a real problem somewhere, if it happens with a peripheral
+	 *    connected. This state calls for inspection of the DEBUG registers.
+	 * 2) The link is UP, but still in LTSSM training
+	 *    Wait for the training to finish, which should take a very short
+	 *    time. If the training does not finish, we have a problem and we
+	 *    need to inspect the DEBUG registers. If the training does finish,
+	 *    the link is up and operating correctly.
+	 * 3) The link is UP and no longer in LTSSM training
+	 *    The link is up and operating correctly.
+	 */
 	for (retries = 0; retries < 200; retries++) {
-		if (dw_pcie_link_up(pp))
+		u32 reg = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
+		if ((reg & PCIE_PHY_DEBUG_R1_XMLH_LINK_UP) &&
+		    !(reg & PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING))
 			return 0;
-		usleep_range(100, 1000);
+		usleep_range(1000, 2000);
 	}
 
 	return -EINVAL;
@@ -467,42 +485,8 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 
 static int imx6_pcie_link_up(struct pcie_port *pp)
 {
-	u32 rc;
-	int count = 5;
-
-	/*
-	 * Test if the PHY reports that the link is up and also that the LTSSM
-	 * training finished. There are three possible states of the link when
-	 * this code is called:
-	 * 1) The link is DOWN (unlikely)
-	 *     The link didn't come up yet for some reason. This usually means
-	 *     we have a real problem somewhere. Reset the PHY and exit. This
-	 *     state calls for inspection of the DEBUG registers.
-	 * 2) The link is UP, but still in LTSSM training
-	 *     Wait for the training to finish, which should take a very short
-	 *     time. If the training does not finish, we have a problem and we
-	 *     need to inspect the DEBUG registers. If the training does finish,
-	 *     the link is up and operating correctly.
-	 * 3) The link is UP and no longer in LTSSM training
-	 *     The link is up and operating correctly.
-	 */
-	while (1) {
-		rc = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
-		if (!(rc & PCIE_PHY_DEBUG_R1_XMLH_LINK_UP))
-			break;
-		if (!(rc & PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING))
-			return 1;
-		if (!count--)
-			break;
-		dev_dbg(pp->dev, "Link is up, but still in training\n");
-		/*
-		 * Wait a little bit, then re-check if the link finished
-		 * the training.
-		 */
-		usleep_range(1000, 2000);
-	}
-
-	return 0;
+	return readl(pp->dbi_base + PCIE_PHY_DEBUG_R1) &
+			PCIE_PHY_DEBUG_R1_XMLH_LINK_UP;
 }
 
 static struct pcie_host_ops imx6_pcie_host_ops = {
-- 
2.6.4

