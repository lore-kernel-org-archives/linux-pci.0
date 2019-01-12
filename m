Return-Path: <SRS0=29+c=PU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACB6C43387
	for <linux-pci@archiver.kernel.org>; Sat, 12 Jan 2019 21:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DAE2086C
	for <linux-pci@archiver.kernel.org>; Sat, 12 Jan 2019 21:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMz5/GBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfALV4S (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:56:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45911 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfALV4R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Jan 2019 16:56:17 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so8558600pfd.12;
        Sat, 12 Jan 2019 13:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4NEECKxkIUpvSN6zGsm7tNAQxLgNjozzJMg2Nudc0PU=;
        b=rMz5/GBy6/gc15U//9gI+99oGPz5hxi+sX0WwNphIwrNNKnOsuHz9s5EhyNZByFY1b
         kHBF63BOW1RytSJjhwuW0j2dfkMje2wY6qDw6yjw2s8rmV0JiyYravzCmkcGeM0zUcni
         /4qUoHgUXbGTNbxwCzF0buDJtZyak5rGQyKxrv9vi1B79oiOgUv7zYbr1jAP6rydeApJ
         SqqonS/bWnxvJUTlVTGJ7SDEAjujqO2DjEbMcQKRK75dkXtLEoffrN2ay/LGtQWQ8tWP
         ghHQCh57I6czhAB6KkJwR9pLpJblYZvVChBqkCSrhcftjir5uYvIOjMgQZlq1obknfkE
         Tdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4NEECKxkIUpvSN6zGsm7tNAQxLgNjozzJMg2Nudc0PU=;
        b=UEwVIlokVJzZ8rt8T0sc+8r3IBCRNh6jCiKQJm6qPv/J8IdA8+ULmwgf5N87Dwi+BN
         r1eDGqjpuLUOakuJBmzuMf2hWuSdB7snz+SuIRftopvPXLXvpwVYINFnRe+PGHp9Bn06
         yb0CTx/jCoQivjV5lgv5Awl3j1VNkLv+OQh07BM4FgnabfEt5AebuJkqBt7iO7hewCgf
         f1xOTfrcImcsTKOptlCukQyWJI2+uULAq6QOVCnPw0H2022+Stq5CG4ASpwyei0TT/kV
         eXoc//IrZd+lmebU63b0vujMk+rs6lyTKlTjeWYmaApMMzBVQXfHyYLjBHGoRpI/xvzg
         +Lng==
X-Gm-Message-State: AJcUukc+8QdTDkQ7L/r85aF1MpirFj6UUxsdgTLEJWITMkEbVAi43p2S
        zVhWKz4u2kGDhbPgrXu9C7A=
X-Google-Smtp-Source: ALg8bN7K+Jjy6MZPt9Os8t8im72vZIZwSdzAQvGDXtLmReZlS+dIMrfktxopX5vgGjoUOE0PXjHV7g==
X-Received: by 2002:a63:cf02:: with SMTP id j2mr18231120pgg.113.1547330175965;
        Sat, 12 Jan 2019 13:56:15 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i72sm122284327pfe.181.2019.01.12.13.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Jan 2019 13:56:15 -0800 (PST)
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
Subject: [PATCH v5 2/4] PCI: imx6: Mark PHY functions as i.MX6 specific
Date:   Sat, 12 Jan 2019 13:55:59 -0800
Message-Id: <20190112215601.9535-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190112215601.9535-1-andrew.smirnov@gmail.com>
References: <20190112215601.9535-1-andrew.smirnov@gmail.com>
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

