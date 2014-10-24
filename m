Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0117.outbound.protection.outlook.com ([65.55.169.117]:58808
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751507AbaJXDG5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 23 Oct 2014 23:06:57 -0400
From: Richard Zhu <richard.zhu@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <shawn.guo@freescale.com>, <festevam@gmail.com>,
	<l.stach@pengutronix.de>, <tharvey@gateworks.com>,
	<m-karicheri2@ti.com>, Richard Zhu <r65037@freescale.com>,
	Richard Zhu <richard.zhu@freescale.com>
Subject: [PATCH V2] PCI: imx6: Wait the clocks to stabilize after ref_en
Date: Fri, 24 Oct 2014 10:36:40 +0800
Message-ID: <1414118200-2018-2-git-send-email-richard.zhu@freescale.com>
In-Reply-To: <1414118200-2018-1-git-send-email-richard.zhu@freescale.com>
References: <1414118200-2018-1-git-send-email-richard.zhu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Richard Zhu <r65037@freescale.com>

For boards without a reset GPIO we skip the delay between enabling the
pcie_ref_clk and touching the RC registers for configuration.
This hangs the system if there isn't a proper delay to ensure the clocks
are settled in the DW PCIe core.

Also iMX6Q always needs an additional 10us delay to make sure the reset
is propagated through the core, as we don't have an explicitly
controlled reset input on this SoC.

Signed-off-by: Richard Zhu <richard.zhu@freescale.com>
Tested-by: Tim Harvey <tharvey@gateworks.com>
Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
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

