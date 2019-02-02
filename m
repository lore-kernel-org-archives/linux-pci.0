Return-Path: <SRS0=cvZd=QJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D5FC282D8
	for <linux-pci@archiver.kernel.org>; Sat,  2 Feb 2019 00:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7956E21872
	for <linux-pci@archiver.kernel.org>; Sat,  2 Feb 2019 00:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpRe5Kqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfBBAPm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:15:42 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35905 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfBBAPk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2019 19:15:40 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so3691977pgm.3;
        Fri, 01 Feb 2019 16:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yd2+XR0UA7pRXNwABMnDIgYdZjl0Ef+YMaD3CGi30fw=;
        b=QpRe5KqqiD85JDv27e4U53jb/4XchwvvgEezZfwQAoKV2ZeatiFmCrOEgBmIAu9XnY
         2TYEHB9KGZQEhV72QR4C5/UnSovwFwEHa18raZUuO0/L+jPHEOLNj2OOCYdISv+rGJYh
         xhWYfg5trel7TlWLKMovEU69hPZvGUAJJIxZqaL/SjFe2nTPilg3o7WJ82Lcx7rYjpFt
         v1sOk7c4GFCFajLMssrYLgv/+UCk1R16xQItZT5YyCXhEDzh5CQc7v9PZD1vEUQzbHyt
         3F7vW103YP97IQ8G8DLbPeSadMqNtq46wRdYTogXExdzM5QK1h1JZLEeWeVay7W89CkB
         Ox2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yd2+XR0UA7pRXNwABMnDIgYdZjl0Ef+YMaD3CGi30fw=;
        b=oa6EV2zsnJL2JoFVVjDuqPq+200tW3YLO/ARGxGSNyCYPdcC1rtCUW/89tDCQ775TK
         80UDke3E+ZiyRSELzN3ibCn86qUzGFfUdxan6e1rEiviW+Vsmg+8S4CNyrCZQL913wjS
         WfKxUnyGZImYgfVm6yZGJFNGw2YhERAtex28vhXFVA+bq/pOk9IK9MMmNwk9xWD3xyrk
         J1ho/bhTyLYjgCXu51bV87euYUadTc+DG7drw+1jp00SrPAjwM30/Gu43dM3iAEslir6
         /3TZk3laAJbj2oo7gKaCJ9SiRXudUYFKqNxmC4UwiijucujnnbQKgKQ6Y/NdTC5OevKd
         gbWg==
X-Gm-Message-State: AHQUAuYPnTfxFgfntJ1ojF/wwaXjDGTLqhE+AFWFsq5EsFRT48n6Epx6
        +r3mziEEuxV7YSW8vxXYGZw=
X-Google-Smtp-Source: AHgI3Ialmns9vf81P5vAzECyruePRiN7VmO1ORw9BhKVifPxgaRTc7BbAtwe5QHFhHliNwHdy6KwGA==
X-Received: by 2002:a63:5455:: with SMTP id e21mr4439654pgm.316.1549066539641;
        Fri, 01 Feb 2019 16:15:39 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id w6sm28374545pga.72.2019.02.01.16.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 16:15:38 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v7 3/4] PCI: imx6: Convert DIRECT_SPEED_CHANGE quirk code to use a flag
Date:   Fri,  1 Feb 2019 16:15:22 -0800
Message-Id: <20190202001523.12517-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190202001523.12517-1-andrew.smirnov@gmail.com>
References: <20190202001523.12517-1-andrew.smirnov@gmail.com>
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
 drivers/pci/controller/dwc/pci-imx6.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 26e1e974b0dd..11b73d733dae 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -42,6 +42,7 @@ enum imx6_pcie_variants {
 };
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
+#define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
 
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
@@ -710,7 +711,8 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 		tmp |= PORT_LOGIC_SPEED_CHANGE;
 		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
 
-		if (imx6_pcie->drvdata->variant != IMX7D) {
+		if (imx6_pcie->drvdata->flags &
+		    IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE) {
 			/*
 			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
 			 * from i.MX6 family when no link speed transition
@@ -1099,15 +1101,18 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
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

