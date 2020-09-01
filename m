Return-Path: <SRS0=eouN=CK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE75C433E6
	for <linux-pci@archiver.kernel.org>; Tue,  1 Sep 2020 03:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62318207D3
	for <linux-pci@archiver.kernel.org>; Tue,  1 Sep 2020 03:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgIADHW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:07:22 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40404 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbgIADHW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Aug 2020 23:07:22 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ECF972009E1;
        Tue,  1 Sep 2020 05:07:19 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D5965200638;
        Tue,  1 Sep 2020 05:07:15 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 59FF2402EB;
        Tue,  1 Sep 2020 05:07:10 +0200 (CEST)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, shawnguo@kernel.org,
        festevam@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH] ARM: dts: imx6qp-sabresd: enable pcie
Date:   Tue,  1 Sep 2020 11:01:19 +0800
Message-Id: <1598929279-5091-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set vgen3 regulator always on to power up the external oscillator,
and enable PCIe on iMX6QP SABRESD board.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 1 +
 arch/arm/boot/dts/imx6qp-sabresd.dts   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index f824c9abd11a..5b09f1cb3cea 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -414,6 +414,7 @@
 			vgen3_reg: vgen3 {
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			vgen4_reg: vgen4 {
diff --git a/arch/arm/boot/dts/imx6qp-sabresd.dts b/arch/arm/boot/dts/imx6qp-sabresd.dts
index 480e73183f6b..f089f1347598 100644
--- a/arch/arm/boot/dts/imx6qp-sabresd.dts
+++ b/arch/arm/boot/dts/imx6qp-sabresd.dts
@@ -51,7 +51,7 @@
 };
 
 &pcie {
-	status = "disabled";
+	status = "okay";
 };
 
 &sata {
-- 
2.17.1

