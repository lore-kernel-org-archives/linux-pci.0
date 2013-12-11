Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:47044 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215Ab3LKKa7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 05:30:59 -0500
From: Marek Vasut <marex@denx.de>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Richard Zhu <r65037@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>, Harro Haan <hrhaan@gmail.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 6/7] PCI: imx6: Fix bugs in PCIe startup code
Date: Wed, 11 Dec 2013 11:30:17 +0100
Message-Id: <1386757818-5154-6-git-send-email-marex@denx.de>
In-Reply-To: <1386757818-5154-1-git-send-email-marex@denx.de>
References: <1386757818-5154-1-git-send-email-marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Richard Zhu <r65037@freescale.com>

- LTSSM shouldn't be set once in assert_core_reset
- Move peripheral reset just before LTSSM start

From: Richard Zhu <r65037@freescale.com>
Signed-off-by: Richard Zhu <r65037@freescale.com>
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
 drivers/pci/host/pci-imx6.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 3028f2c..38df103 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -220,18 +220,9 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
 
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
 			IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
 			IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
 
-	/* Some boards don't have PCIe reset GPIO. */
-	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
-		gpio_set_value(imx6_pcie->reset_gpio, 0);
-		msleep(100);
-		gpio_set_value(imx6_pcie->reset_gpio, 1);
-	}
-
 	return 0;
 }
 
@@ -275,6 +266,12 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 	/* allow the clocks to stabilize */
 	usleep_range(200, 500);
 
+	/* Some boards don't have PCIe reset GPIO. */
+	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
+		gpio_set_value(imx6_pcie->reset_gpio, 0);
+		msleep(100);
+		gpio_set_value(imx6_pcie->reset_gpio, 1);
+	}
 	return 0;
 
 err_pcie_axi:
-- 
1.8.4.3

