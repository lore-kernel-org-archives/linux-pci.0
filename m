Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:33752 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932612Ab3KZVLW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2013 16:11:22 -0500
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
Subject: [PATCH 6/7] PCI: imx6: Fix link start operation
Date: Tue, 26 Nov 2013 22:10:47 +0100
Message-Id: <1385500248-6551-6-git-send-email-marex@denx.de>
In-Reply-To: <1385500248-6551-1-git-send-email-marex@denx.de>
References: <1385500248-6551-1-git-send-email-marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch first forces the link into Gen1 mode before starting up
the link and only after the link is up requests the link to start
negotiating possible Gen2 mode operation. This is because without
such sequence, some PCIe switches are not detected at all.

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
 drivers/pci/host/pci-imx6.c | 78 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 5d85fc2..ea1a222 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -44,6 +44,12 @@ struct imx6_pcie {
 	void __iomem		*mem_base;
 };
 
+/* PCIe Root Complex registers (memory-mapped) */
+#define PCIE_RC_LCR				0x7c
+#define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1	0x1
+#define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2	0x2
+#define PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK	0xf
+
 /* PCIe Port Logic registers (memory-mapped) */
 #define PL_OFFSET 0x700
 #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
@@ -61,6 +67,9 @@ struct imx6_pcie {
 #define PCIE_PHY_STAT (PL_OFFSET + 0x110)
 #define PCIE_PHY_STAT_ACK_LOC 16
 
+#define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
+#define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
+
 /* PHY registers (not memory-mapped) */
 #define PCIE_PHY_RX_ASIC_OUT 0x100D
 
@@ -323,11 +332,71 @@ static int imx6_pcie_wait_for_link(struct pcie_port *pp)
 	return 0;
 }
 
-static void imx6_pcie_host_init(struct pcie_port *pp)
+static int imx6_pcie_start_link(struct pcie_port *pp)
 {
-	int count = 0;
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+	uint32_t tmp;
+	int ret, count;
+
+	/*
+	 * Force Gen1 operation when starting the link. In case the link is
+	 * started in Gen2 mode, there is a possibility the devices on the
+	 * bus will not be detected at all. This happens with PCIe switches.
+	 */
+	tmp = readl(pp->dbi_base + PCIE_RC_LCR);
+	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
+	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
+	writel(tmp, pp->dbi_base + PCIE_RC_LCR);
+
+	/* Start LTSSM. */
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
+
+	ret = imx6_pcie_wait_for_link(pp);
+	if (ret)
+		return ret;
+
+	/* Allow Gen2 mode after the link is up. */
+	tmp = readl(pp->dbi_base + PCIE_RC_LCR);
+	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
+	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2;
+	writel(tmp, pp->dbi_base + PCIE_RC_LCR);
+
+	/*
+	 * Start Directed Speed Change so the best possible speed both link
+	 * partners support can be negotiated.
+	 */
+	tmp = readl(pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
+	tmp |= PORT_LOGIC_SPEED_CHANGE;
+	writel(tmp, pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
+
+	count = 200;
+	while (count--) {
+		tmp = readl(pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
+		/* Test if the speed change finished. */
+		if (!(tmp & PORT_LOGIC_SPEED_CHANGE))
+			break;
+		usleep_range(100, 1000);
+	}
+
+	/* Make sure link training is finished as well! */
+	if (count)
+		ret = imx6_pcie_wait_for_link(pp);
+	else
+		ret = -EINVAL;
 
+	if (ret) {
+		dev_err(pp->dev, "Failed to bring link up!\n");
+	} else {
+		tmp = readl(pp->dbi_base + 0x80);
+		dev_err(pp->dev, "Link up, Gen=%i\n", (tmp >> 16) & 0xf);
+	}
+
+	return ret;
+}
+
+static void imx6_pcie_host_init(struct pcie_port *pp)
+{
 	imx6_pcie_assert_core_reset(pp);
 
 	imx6_pcie_init_phy(pp);
@@ -336,10 +405,7 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
-
-	imx6_pcie_wait_for_link(pp);
+	imx6_pcie_start_link(pp);
 
 	return;
 }
-- 
1.8.4.3

