Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1F1ECAAD5
	for <linux-pci@archiver.kernel.org>; Mon, 29 Aug 2022 15:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiH2PQj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 29 Aug 2022 11:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiH2PQj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 11:16:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E93B79EFA
        for <linux-pci@vger.kernel.org>; Mon, 29 Aug 2022 08:16:38 -0700 (PDT)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oSgUz-0006bl-1e; Mon, 29 Aug 2022 17:16:25 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     p.zabel@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, shawnguo@kernel.org,
        vkoul@kernel.org, alexander.stein@ew.tq-group.com, marex@denx.de,
        richard.leitner@linux.dev, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH 1/2] soc: imx: imx8mp-blk-ctrl: handle PCIe PHY resets
Date:   Mon, 29 Aug 2022 17:16:22 +0200
Message-Id: <20220829151623.808344-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1661760917-9558-1-git-send-email-hongxing.zhu@nxp.com>
References: <1661760917-9558-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dessert the PHY reset when powering up the domain and put it back
into reset when the domain is powered down.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/soc/imx/imx8mp-blk-ctrl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 4ca2ede6871b..6c939d68ba9a 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -18,6 +18,8 @@
 #define GPR_REG0		0x0
 #define  PCIE_CLOCK_MODULE_EN	BIT(0)
 #define  USB_CLOCK_MODULE_EN	BIT(1)
+#define  PCIE_PHY_APB_RST	BIT(4)
+#define  PCIE_PHY_INIT_RST	BIT(5)
 
 struct imx8mp_blk_ctrl_domain;
 
@@ -75,6 +77,10 @@ static void imx8mp_hsio_blk_ctrl_power_on(struct imx8mp_blk_ctrl *bc,
 	case IMX8MP_HSIOBLK_PD_PCIE:
 		regmap_set_bits(bc->regmap, GPR_REG0, PCIE_CLOCK_MODULE_EN);
 		break;
+	case IMX8MP_HSIOBLK_PD_PCIE_PHY:
+		regmap_set_bits(bc->regmap, GPR_REG0,
+				PCIE_PHY_APB_RST | PCIE_PHY_INIT_RST);
+		break;
 	default:
 		break;
 	}
@@ -90,6 +96,10 @@ static void imx8mp_hsio_blk_ctrl_power_off(struct imx8mp_blk_ctrl *bc,
 	case IMX8MP_HSIOBLK_PD_PCIE:
 		regmap_clear_bits(bc->regmap, GPR_REG0, PCIE_CLOCK_MODULE_EN);
 		break;
+	case IMX8MP_HSIOBLK_PD_PCIE_PHY:
+		regmap_clear_bits(bc->regmap, GPR_REG0,
+				  PCIE_PHY_APB_RST | PCIE_PHY_INIT_RST);
+		break;
 	default:
 		break;
 	}
-- 
2.30.2

