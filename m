Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD84C43444
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 16:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1CF218CD
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 16:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FePXJ2vy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfADQyD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:54:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37686 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfADQyD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 11:54:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id c25so17730311pgb.4;
        Fri, 04 Jan 2019 08:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wen/FB8xaUFRJwJXXt0R071jVcMb73q9WaXaVpXXDfA=;
        b=FePXJ2vyM0DPkriOlPZTp3kGEMXUHOGovkdT6hC8rn+HKoNeujx++uYJMfMzgBBvDp
         w5XToiAKE9P7QsjAklDWWhRt+NvmubYgPXDCznK7vsTcZRXROEUsWb6vATZXvPJY0ySj
         I7CKvojal83UJMbnVs9pHzSuDOCo8EGQtcsnpfdhKnFa+Tgo2hYHP5DGL+lLwZV1/SvK
         /bd0QgFNH6yjd15uQfgTgpWcsnAYzDHgZF4l2plr8lajr3+UBM/KDTQUB6J7Hl2byY+2
         B3t09mRJhpi80/wqD+zcIlJmhVy349ZQObFmXRYzgJpjrN8bdc+pOsswHjPuH4yITtc/
         ku/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wen/FB8xaUFRJwJXXt0R071jVcMb73q9WaXaVpXXDfA=;
        b=h6Afq14oM88KcqIBUcGieDPScrwgQxSD76dKPtBRquOS9p3m3f2c5lMJzumau/WI9D
         z1K62sf0x0JJgD/Z+8v8tBZPdMW/U0O9NrpLMARtyBhWKfuvobPsP+ploe+E+9oWcqpX
         bHKGMF/V+QliNtLLRN3FPa72+4fcAScRI8nljg/EQuLsSlLkFiQS5PQaeRohlwagCBhn
         bV3jJDXxDKNCGraeMJUjJeyJIfVlhH1FTAhjYlRCBOYVfeNOxvG90LFg2SjsrBhRAWC4
         xh42EfQY17xYw3FCCll+nRFi3AS7vbJHMMlBpu3kGR8rev4PX7sXgVH2aBY+b3noDpfM
         cM9g==
X-Gm-Message-State: AJcUukd0OU6xn26cOH1G9VP9BH+7vAws2JBxI+Bszsn4Ab1zpZ/J4lVe
        I9UlV6EBGrtJxxA51kUUMXk=
X-Google-Smtp-Source: ALg8bN6axIlHUN8YBoIZXHGhmJez6SO7ebOJKVW8lj+LNj2C7gYLbQAgjUtkWDm5S1tno2aj3Y9X7A==
X-Received: by 2002:a63:1013:: with SMTP id f19mr2283258pgl.38.1546620841974;
        Fri, 04 Jan 2019 08:54:01 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id p67sm101900564pfg.44.2019.01.04.08.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 08:54:01 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v4 3/4] PCI: imx6: Convert DIRECT_SPEED_CHANGE quirk code to use a flag
Date:   Fri,  4 Jan 2019 08:53:34 -0800
Message-Id: <20190104165335.13205-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104165335.13205-1-andrew.smirnov@gmail.com>
References: <20190104165335.13205-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Both i.MX7D and i.MX8MQ have the same behaviour when it comes to
clearing DIRECT_SPEED_CHANGE bit when no speed change occur. To
account for that change the code handling that to use a generic flag
instead of checking IP block variant.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c55d93c1187d..75ee0cd7af3b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -42,6 +42,7 @@ enum imx6_pcie_variants {
 };
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
+#define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
 
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
@@ -711,7 +712,8 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 		tmp |= PORT_LOGIC_SPEED_CHANGE;
 		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
 
-		if (imx6_pcie->drvdata->variant != IMX7D) {
+		if (imx6_pcie->drvdata->flags &
+		    IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE) {
 			/*
 			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
 			 * from i.MX6 family when no link speed transition
@@ -1097,15 +1099,18 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
 		.variant = IMX6Q,
-		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
+			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
-		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
+			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
-		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
+			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.20.1

