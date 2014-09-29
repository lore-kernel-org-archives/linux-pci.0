Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0114.outbound.protection.outlook.com ([207.46.100.114]:25952
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751439AbaI2FdU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 29 Sep 2014 01:33:20 -0400
From: Richard Zhu <r65037@freescale.com>
To: <linux-pci-owner@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <shawn.guo@freescale.com>,
	<festevam@gmail.com>, <l.stach@pengutronix.de>,
	<tharvey@gateworks.com>, Richard Zhu <r65037@freescale.com>
Subject: [PATCH v3 1/9] PCI: imx6: wait the clocks to stabilize after ref_en
Date: Mon, 29 Sep 2014 13:03:09 +0800
Message-ID: <1411966997-27118-2-git-send-email-r65037@freescale.com>
In-Reply-To: <1411966997-27118-1-git-send-email-r65037@freescale.com>
References: <1411966997-27118-1-git-send-email-r65037@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For boards without a reset gpio we skip the delay between enabling
the pcie_ref_clk and touching the RC registers for configuration.
System would be hangs when the clocks are not yet settled in the DW
PCIe core. So we need to make sure that there is always an
appropriate delay between those two actions.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 drivers/pci/host/pci-imx6.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 233fe8a..eac96fb 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -275,15 +275,22 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 		goto err_pcie;
 	}
 
-	/* allow the clocks to stabilize */
-	usleep_range(200, 500);
-
 	/* power up core phy and enable ref clock */
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
 			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
+	/*
+	 * the async reset input need ref clock to sync internally,
+	 * when the ref clock comes after reset, internal synced
+	 * reset time is too short , cannot meet the requirement.
+	 * add one ~10us delay here.
+	 */
+	udelay(10);
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
 			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
 
+	/* allow the clocks to stabilize */
+	usleep_range(200, 500);
+
 	/* Some boards don't have PCIe reset GPIO. */
 	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
 		gpio_set_value(imx6_pcie->reset_gpio, 0);
-- 
1.9.1

