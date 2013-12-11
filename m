Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:38932 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab3LKKbA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 05:31:00 -0500
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
Subject: [PATCH 4/7] PCI: imx6: Split away the link up wait loop
Date: Wed, 11 Dec 2013 11:30:15 +0100
Message-Id: <1386757818-5154-4-git-send-email-marex@denx.de>
In-Reply-To: <1386757818-5154-1-git-send-email-marex@denx.de>
References: <1386757818-5154-1-git-send-email-marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Split the function that waits for the PCIe link to come up from the
rest if the host init function. We will find this change useful in
the subsequent patch, since this will be called twice then.

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
 drivers/pci/host/pci-imx6.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 478e87e..4d6f6fe 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -304,6 +304,25 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
 			IMX6Q_GPR8_TX_SWING_LOW, 127 << 25);
 }
 
+static int imx6_pcie_wait_for_link(struct pcie_port *pp)
+{
+	int count = 200;
+
+	while (!dw_pcie_link_up(pp)) {
+		usleep_range(100, 1000);
+		if (--count)
+			continue;
+
+		dev_err(pp->dev, "phy link never came up\n");
+		dev_dbg(pp->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
+			readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
+			readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void imx6_pcie_host_init(struct pcie_port *pp)
 {
 	int count = 0;
@@ -320,18 +339,7 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
 
-	while (!dw_pcie_link_up(pp)) {
-		usleep_range(100, 1000);
-		count++;
-		if (count >= 200) {
-			dev_err(pp->dev, "phy link never came up\n");
-			dev_dbg(pp->dev,
-				"DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-				readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
-				readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
-			break;
-		}
-	}
+	imx6_pcie_wait_for_link(pp);
 
 	return;
 }
-- 
1.8.4.3

