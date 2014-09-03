Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:41897 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbaICEFa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Sep 2014 00:05:30 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so16375323pab.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Sep 2014 21:05:30 -0700 (PDT)
From: Tim Harvey <tharvey@gateworks.com>
To: l.stach@pengutronix.de
Cc: Fabio Estevam <festevam@gmail.com>, shawn.guo@freescale.com,
	marex@denx.de, bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: imx6: fix occasional link failure
Date: Tue,  2 Sep 2014 21:04:37 -0700
Message-Id: <1409717077-26662-1-git-send-email-tharvey@gateworks.com>
In-Reply-To: <Message-Id: <1407479800-6730-1-git-send-email-tharvey@gateworks.com>
References: <Message-Id: <1407479800-6730-1-git-send-email-tharvey@gateworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

According to the IMX6 reference manuals, REF_SSP_EN (Reference clock enable
for SS function) must remain deasserted until the reference clock is running
at the appropriate frequency.

Without this patch we find a high link failure rate (>5%) on certain
IMX6 boards at various temperatures.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Tested-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Marek Vasut <marex@denx.de>
---

v2:
 - added Tested-by Fabio Estevam
 - added Acked-by Marek Vasut

---
 drivers/pci/host/pci-imx6.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 1be6073..9b6bab9 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -256,11 +256,6 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
 	int ret;
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
-
 	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
 	if (ret) {
 		dev_err(pp->dev, "unable to enable pcie_phy clock\n");
@@ -282,6 +277,12 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 	/* allow the clocks to stabilize */
 	usleep_range(200, 500);
 
+	/* power up core phy and enable ref clock */
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
+
 	/* Some boards don't have PCIe reset GPIO. */
 	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
 		gpio_set_value(imx6_pcie->reset_gpio, 0);
-- 
1.8.3.2

