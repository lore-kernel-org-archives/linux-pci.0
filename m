Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:50416 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623Ab3LLVu2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Dec 2013 16:50:28 -0500
From: Marek Vasut <marex@denx.de>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>, Harro Haan <hrhaan@gmail.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 2/7] PCI: imx6: Fix waiting for link up
Date: Thu, 12 Dec 2013 22:49:59 +0100
Message-Id: <1386885004-10252-2-git-send-email-marex@denx.de>
In-Reply-To: <1386885004-10252-1-git-send-email-marex@denx.de>
References: <1386885004-10252-1-git-send-email-marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

While waiting for the PHY to report the PCIe link is up, we might
hit a situation where the link training is still in progress, while
the PHY already reports the link is up. Add additional check for
this condition.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <lznuaa@gmail.com>
Cc: Harro Haan <hrhaan@gmail.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
Cc: Pratyush Anand <pratyush.anand@st.com>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Sean Cross <xobs@kosagi.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/host/pci-imx6.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index c247602..f5541c3 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -48,6 +48,8 @@ struct imx6_pcie {
 #define PL_OFFSET 0x700
 #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
 #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
+#define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING	(1 << 29)
+#define PCIE_PHY_DEBUG_R1_XMLH_LINK_UP		(1 << 4)
 
 #define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
 #define PCIE_PHY_CTRL_DATA_LOC 0
@@ -338,10 +340,17 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
 {
 	u32 rc, ltssm, rx_valid, temp;
 
-	/* link is debug bit 36, debug register 1 starts at bit 32 */
-	rc = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1) & (0x1 << (36 - 32));
-	if (rc)
-		return -EAGAIN;
+	/*
+	 * Test if the PHY reports that the link is up and also that
+	 * the link training finished. It might happen that the PHY
+	 * reports the link is already up, but the link training bit
+	 * is still set, so make sure to check the training is done
+	 * as well here.
+	 */
+	rc = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
+	if ((rc & PCIE_PHY_DEBUG_R1_XMLH_LINK_UP) &&
+	    !(rc & PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING))
+		return 1;
 
 	/*
 	 * From L0, initiate MAC entry to gen2 if EP/RC supports gen2.
-- 
1.8.4.3

