Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC649C282C5
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 20:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78181217D7
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 20:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7NB915u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfAXUQE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:16:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41989 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbfAXUPq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2019 15:15:46 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so3390691plp.9;
        Thu, 24 Jan 2019 12:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AHjS+evz3QVh0MBkELR/jdoUFNfkoRz6aszyBU+n3Ec=;
        b=a7NB915uX5EMB2WZFfUNQlqGBBzd52MUuqoxtUdJ4psueraTW/VTAOXeNDTSzjTTS7
         i4vQM/tYEnWhpoQAQFzpP+vsETX9CiS8ofTFeIjJqhHqP/j9LQ+6Tse1M1IDozc4Ki2O
         IUwZysbxauLPMQgaqZHiVtu4o68O0oH9A2JaaC5fzF6/7Sy1iFGq8NIMsijsZxqrN8cp
         f3nLHdQME3v/oYYo7Z4Se1j0QdDwmoP7h8UOO7KGDU8KzXt6ckxRid0jO4dbtiKP1K74
         6CXpO3tlsWjH2xKiTIgS8E6N8v7qmc3U8//fHjANP4hfSpwC20btW47/eiWsBB+vqimH
         3dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AHjS+evz3QVh0MBkELR/jdoUFNfkoRz6aszyBU+n3Ec=;
        b=Fe293I6y36SKbLeqgGWR1+WnuK/kLC8WiTjlomTfZIHapkM6hsC2qIxIZTCJq19G4b
         mVmccY8WiO167N0oSmT2gkrbPk4zR5QyL8qFR9Yq8D4l7854taGw+da9HEXitoPbi/Wm
         H//EQVG2I9+mi5jcY+o8n4EHDxDRkZhS6oRFBvY6TnufPwWf4alhJ3eUnC2QbQaVXUYD
         X7jzZKeKV/NHRN0h6BlKwDI2BMxJAJLa5UFh4zFzO2lXJtG63EhBc71wwiNgns2pLE8A
         QlJbbPYuf5sNmRxkA65qEZItWilfNQuUajgGAPHlwel+yXCdrrn2NhxB2ybuGzin/Y0Y
         pQzg==
X-Gm-Message-State: AJcUukeV896Yva13/FVyIAhTHqm/1FuNjpPMv5aEVBgq6Kz9tz1SjIAt
        TEf+SEwMS97oWLjucBvnBhE=
X-Google-Smtp-Source: ALg8bN4z8wkfPm1/MV8LPDhriPtnOPHgVUtD2pkb5FEbosg2yEnFk+nMqeCUK8uwLUB9owhgfqQO/A==
X-Received: by 2002:a17:902:830a:: with SMTP id bd10mr7971769plb.321.1548360945884;
        Thu, 24 Jan 2019 12:15:45 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id m65sm53062646pfg.180.2019.01.24.12.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 12:15:45 -0800 (PST)
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
Subject: [PATCH v6 3/4] PCI: imx6: Convert DIRECT_SPEED_CHANGE quirk code to use a flag
Date:   Thu, 24 Jan 2019 12:15:21 -0800
Message-Id: <20190124201522.8973-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124201522.8973-1-andrew.smirnov@gmail.com>
References: <20190124201522.8973-1-andrew.smirnov@gmail.com>
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

