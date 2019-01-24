Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DD2C282C6
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 20:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343D4218D0
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 20:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJqcCvBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbfAXUPp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:15:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46208 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730800AbfAXUPp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2019 15:15:45 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so3129941pgp.13;
        Thu, 24 Jan 2019 12:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4NEECKxkIUpvSN6zGsm7tNAQxLgNjozzJMg2Nudc0PU=;
        b=RJqcCvBgMG0Q/XC6PGvQ5QszTlMA+suu93hO/bhOexDj7OObXbuQBG1QtGs8qZ7MvZ
         F8uK+BGzNl9gAXprVwm/loJ1VoU5Dz0cXAKH2RCQ1wb5wGaL7tnHDV1JLxE9CBmrBFlH
         mXI1DjJvzF/Nu21A9+/z/c5u9diWHThTyqvNd+qFC2m/2qcmhyzQ5T4T0gM0pnnjfVgj
         +lZOUQtX32ve4QlT1ge9HMwF7VYW8KlCeXNSVrHfpBgYTwfZG0kv9ExHPVvMrC0lu3Mr
         b+3+oXybnrnIYaHqShSRRvl0XUPipWbEtYiYh50HuOQ9H3WPcQrWaVflOtK602xCqlqk
         +LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4NEECKxkIUpvSN6zGsm7tNAQxLgNjozzJMg2Nudc0PU=;
        b=HLFYHjj0xU45Ld+BYootPquCB5V7rUCct4jTCJO9vKZS+j9IcAUTbe28elky1wjg/F
         tdp8CF64c5VoIsuu7Coq+ph4d76WBSQrZ0fw+n5MBy/K+gw8wAv9nFPQcb78yeeIfM4q
         HcVCuzMaNvpOVcnAzecaiSDX93Y1vTRgd2QiVMjvvh3fqzE4uqZLf0svcwE6XkKux/n5
         ejtLf3ZIWgB9JhvozEw6iksLmMyFJR2mmY7NwkdYQKBEewwTxZ2Cfthx7F+7odK1RA6W
         IX//zS2siJig0n688TOwiwrZZCVAkKGJR5IPL/0s0POpX7MLUJ8J42kNN0J3zbtCozh3
         Mn9w==
X-Gm-Message-State: AJcUukeCKyoUIJnCrtoGlXfE6+lXrSOyvewfahcckEdtBMfxyUWjqDEx
        jELCE76SLTq7CnXfDmCZXmc=
X-Google-Smtp-Source: ALg8bN5wc8PK4BpLsVxaYdb1/pXiP2on/lOSfG0Pg5rcjdSUgjFpchPBfotz7EQbS5vfcc0YXdhbmg==
X-Received: by 2002:a63:6506:: with SMTP id z6mr707698pgb.334.1548360944257;
        Thu, 24 Jan 2019 12:15:44 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id m65sm53062646pfg.180.2019.01.24.12.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 12:15:43 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v6 2/4] PCI: imx6: Mark PHY functions as i.MX6 specific
Date:   Thu, 24 Jan 2019 12:15:20 -0800
Message-Id: <20190124201522.8973-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124201522.8973-1-andrew.smirnov@gmail.com>
References: <20190124201522.8973-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIE PHY IP block on i.MX7D differs from the one used on i.MX6 family,
so none of the code in current implementation of imx6_setup_phy_mpll()
is applicable.

Tested-by: Trent Piepho <tpiepho@impinj.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
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
---
 drivers/pci/controller/dwc/pci-imx6.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index efff3d5e9162..c55d93c1187d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -41,8 +41,11 @@ enum imx6_pcie_variants {
 	IMX7D,
 };
 
+#define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
+
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
+	u32 flags;
 };
 
 struct imx6_pcie {
@@ -256,6 +259,9 @@ static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
 	u32 tmp;
 
+	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
+		return;
+
 	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
 	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
 		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
@@ -573,6 +579,9 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 	int mult, div;
 	u32 val;
 
+	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
+		return 0;
+
 	switch (phy_rate) {
 	case 125000000:
 		/*
@@ -1088,12 +1097,15 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
 		.variant = IMX6Q,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.20.1

