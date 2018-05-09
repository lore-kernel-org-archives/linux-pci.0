Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40131 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934820AbeEIRBw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 May 2018 13:01:52 -0400
Received: by mail-qk0-f194.google.com with SMTP id h138so27325934qke.7
        for <linux-pci@vger.kernel.org>; Wed, 09 May 2018 10:01:52 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: lorenzo.pieralisi@arm.com
Cc: l.stach@pengutronix.de, linux-pci@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] PCI: imx6: Remove space before tabs
Date: Wed,  9 May 2018 14:01:48 -0300
Message-Id: <1525885308-7824-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove space before tabs to fix the following checkpatch
warning:

WARNING: please, no space before tabs
#341: FILE: drivers/pci/dwc/pci-imx6.c:341:
+^Icase IMX6QP: ^I^I/* FALLTHROUGH */$

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/pci/dwc/pci-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index 4818ef8..80f6046 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -338,7 +338,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
 		break;
-	case IMX6QP: 		/* FALLTHROUGH */
+	case IMX6QP:		/* FALLTHROUGH */
 	case IMX6Q:
 		/* power up core phy and enable ref clock */
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-- 
2.7.4
