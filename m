Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34571 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbaBLH2Q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2014 02:28:16 -0500
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-pci@vger.kernel.org
Cc: kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>,
	Richard Zhu <r65037@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>
Subject: [PATCH] PCI: imx6: Fix link_up detection
Date: Wed, 12 Feb 2014 08:27:55 +0100
Message-Id: <1392190075-23204-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is broken since:

| commit e6daf4a5e1b813bc7f85507ec83b8c2452c121e6
| Author: Marek Vasut <marex@denx.de>
| Date:   Thu Dec 12 22:49:59 2013 +0100
|
|     PCI: imx6: Report "link up" only after link training completes
|
|     While waiting for the PHY to report the PCIe link is up, we might hit a
|     situation where the link training is still in progress, while the PHY
|     already reports the link is up.  Add additional check for this condition.
|
|     Signed-off-by: Marek Vasut <marex@denx.de>
|     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
|     Acked-by: Shawn Guo <shawn.guo@linaro.org>

The problem is: Before the above commit only the PCIE_PHY_DEBUG_R1_XMLH_LINK_UP
bit was used to determine whether the link is up or not. Since the above commit
also the PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING is used. This means a link
still being trained is as link down.
The designware driver changes the PORT_LOGIC_SPEED_CHANGE bit in
dw_pcie_host_init() which causes the link to be retrained. During the next call
to dw_pcie_rd_conf() the link is then reported being down and the function
returns PCIBIOS_DEVICE_NOT_FOUND resulting in nonfunctioning PCIe.

This patch fixes this by waiting until the link training has finished before
testing the PCIE_PHY_DEBUG_R1_XMLH_LINK_UP bit. This is hardly the correct
solution, but I don't know what should be done instead.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Zhu <r65037@freescale.com> (maintainer:PCI DRIVER FOR IMX6)
Cc: Shawn Guo <shawn.guo@linaro.org> (maintainer:PCI DRIVER FOR IMX6)
Cc: Bjorn Helgaas <bhelgaas@google.com> (supporter:PCI SUBSYSTEM)
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marex@denx.de>
---
 drivers/pci/host/pci-imx6.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 866bdc7..9b6b501 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -449,6 +449,7 @@ static void imx6_pcie_reset_phy(struct pcie_port *pp)
 static int imx6_pcie_link_up(struct pcie_port *pp)
 {
 	u32 rc, ltssm, rx_valid;
+	int count = 1000;
 
 	/*
 	 * Test if the PHY reports that the link is up and also that
@@ -458,8 +459,13 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
 	 * as well here.
 	 */
 	rc = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
-	if ((rc & PCIE_PHY_DEBUG_R1_XMLH_LINK_UP) &&
-	    !(rc & PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING))
+	while (rc & PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING) {
+		if (!count--)
+			return 0;
+		rc = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
+	}
+
+	if (rc & PCIE_PHY_DEBUG_R1_XMLH_LINK_UP)
 		return 1;
 
 	/*
-- 
1.8.5.3

