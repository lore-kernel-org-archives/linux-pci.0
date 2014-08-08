Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:38043 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755870AbaHHGgt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Aug 2014 02:36:49 -0400
Received: by mail-pd0-f176.google.com with SMTP id y10so6477800pdj.7
        for <linux-pci@vger.kernel.org>; Thu, 07 Aug 2014 23:36:49 -0700 (PDT)
From: Tim Harvey <tharvey@gateworks.com>
To: l.stach@pengutronix.de
Cc: Fabio Estevam <festevam@gmail.com>, shawn.guo@freescale.com,
	stable@vger.kernel.org, marex@denx.de, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: imx6: fix occasional link failure
Date: Thu,  7 Aug 2014 23:36:40 -0700
Message-Id: <1407479800-6730-1-git-send-email-tharvey@gateworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

According to the IMX6 reference manuals, REF_SSP_EN (Reference clock enable
for SS function) must remain deasserted until the reference clock is running
at the appropriate frequency.

Without this patch we find a high link failure rate (>5%) on certain
IMX6 boards at various temperatures.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
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

