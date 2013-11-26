Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:46426 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932544Ab3KZVLU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2013 16:11:20 -0500
From: Marek Vasut <marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-pci@vger.kernel.org, Marek Vasut <marex@denx.de>,
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
Subject: [PATCH 4/7] PCI: imx6: Split away the PHY reset
Date: Tue, 26 Nov 2013 22:10:45 +0100
Message-Id: <1385500248-6551-4-git-send-email-marex@denx.de>
In-Reply-To: <1385500248-6551-1-git-send-email-marex@denx.de>
References: <1385500248-6551-1-git-send-email-marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Split the PCIe PHY reset from the link up function to make
the code a little more structured.

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
 drivers/pci/host/pci-imx6.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 4d5be4e..a9781e7 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -336,6 +336,23 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 	return;
 }
 
+static void imx6_pcie_reset_phy(struct pcie_port *pp)
+{
+	uint32_t temp;
+
+	pcie_phy_read(pp->dbi_base, PHY_RX_OVRD_IN_LO, &temp);
+	temp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
+		 PHY_RX_OVRD_IN_LO_RX_PLL_EN);
+	pcie_phy_write(pp->dbi_base, PHY_RX_OVRD_IN_LO, temp);
+
+	usleep_range(2000, 3000);
+
+	pcie_phy_read(pp->dbi_base, PHY_RX_OVRD_IN_LO, &temp);
+	temp &= ~(PHY_RX_OVRD_IN_LO_RX_DATA_EN |
+		  PHY_RX_OVRD_IN_LO_RX_PLL_EN);
+	pcie_phy_write(pp->dbi_base, PHY_RX_OVRD_IN_LO, temp);
+}
+
 static int imx6_pcie_link_up(struct pcie_port *pp)
 {
 	u32 rc, ltssm, rx_valid, temp;
@@ -370,21 +387,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
 
 	dev_err(pp->dev, "transition to gen2 is stuck, reset PHY!\n");
 
-	pcie_phy_read(pp->dbi_base,
-		PHY_RX_OVRD_IN_LO, &temp);
-	temp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN
-		| PHY_RX_OVRD_IN_LO_RX_PLL_EN);
-	pcie_phy_write(pp->dbi_base,
-		PHY_RX_OVRD_IN_LO, temp);
-
-	usleep_range(2000, 3000);
-
-	pcie_phy_read(pp->dbi_base,
-		PHY_RX_OVRD_IN_LO, &temp);
-	temp &= ~(PHY_RX_OVRD_IN_LO_RX_DATA_EN
-		| PHY_RX_OVRD_IN_LO_RX_PLL_EN);
-	pcie_phy_write(pp->dbi_base,
-		PHY_RX_OVRD_IN_LO, temp);
+	imx6_pcie_reset_phy(pp);
 
 	return 0;
 }
-- 
1.8.4.3

