Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7376C433EF
	for <linux-pci@archiver.kernel.org>; Tue,  8 Feb 2022 04:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240420AbiBHEGG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Feb 2022 23:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242112AbiBHEGD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 23:06:03 -0500
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF41C0401E5;
        Mon,  7 Feb 2022 20:06:03 -0800 (PST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 737862006CC;
        Tue,  8 Feb 2022 04:57:00 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 39EDF200667;
        Tue,  8 Feb 2022 04:57:00 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 98424183ACDE;
        Tue,  8 Feb 2022 11:56:58 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com, festevam@gmail.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v6 4/8] PCI: imx6: Disable imx6qdl pcie ref clk
Date:   Tue,  8 Feb 2022 11:25:31 +0800
Message-Id: <1644290735-3797-5-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644290735-3797-1-git-send-email-hongxing.zhu@nxp.com>
References: <1644290735-3797-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When disable PCIe clocks, disable i.MX6QDL PCIe REF clock too.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e157f0bec37e..0aca762d88a3 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -540,6 +540,14 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 	clk_disable_unprepare(imx6_pcie->pcie_bus);
 
 	switch (imx6_pcie->drvdata->variant) {
+	case IMX6Q:
+	case IMX6QP:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_TEST_PD,
+				IMX6Q_GPR1_PCIE_TEST_PD);
+		break;
 	case IMX6SX:
 		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
 		break;
-- 
2.25.1

