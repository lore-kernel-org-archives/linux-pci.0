Return-Path: <SRS0=29+c=PU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F08C43387
	for <linux-pci@archiver.kernel.org>; Sat, 12 Jan 2019 21:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40221206B7
	for <linux-pci@archiver.kernel.org>; Sat, 12 Jan 2019 21:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kuv7qzIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfALV4W (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:56:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43093 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfALV4S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Jan 2019 16:56:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so8369526plb.10;
        Sat, 12 Jan 2019 13:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=grv6pQHsa4pXAbDoNpvOmMqpK++yv1uYVerEQhWxFvk=;
        b=Kuv7qzIbQhre4OSksQolLwFyYTkHfGpBCjwpwKyM22grwmpKwGFrwvNSYJtVfYAZmw
         P7z5qhzC8wabLAeNVrL44/hyUil5fCvNMuteleFSCGM4s94M0cdnRkACWx4RXDKamiaP
         XW27/YZPCvn4Xar3+1NLvbifrZ0ervs/2Nc0/m0I5uzjlyD6uVsO9aHqb43cfPNUKlzP
         RvdNSXTH0hNcYhm0/sWwbz2erbvk+mE/u0T8Hqr0SjMaHnxlf6UjK7TYrusQZuHPLOAO
         BprsYn37B4JU2lINfIt3vcSbZ7rsXJPmmNF2iPqgqlRlh+N/W47XzZcBDHmujZ8F97Nl
         o7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=grv6pQHsa4pXAbDoNpvOmMqpK++yv1uYVerEQhWxFvk=;
        b=cUq204tNNgs2oXZgKIyxE/NgK1ctlt+vJ+oho9SZqE/JIWzCVKHAeWiAp/a1rRhcu9
         kvJ8lOGin3i7O+1/khKvhnuWTcyXOJ/OyUDmbzxCfyCbCMuzp+ZJr3Z126nvUKd3bLmC
         g79vmFpqPtVnKQXhkMlsMcT/2I52HVh8Bqq523Yp5A3NhirSvZpwqrquh7aKwznK0Jg6
         mmYUBueYaBDMlgoyTtFaUgTIrF5r48mXO9kvKJ1zOjBkdmyoTI1xagZrhP/MUWhuQJ3O
         j8MHCdogHxYDHtxTxiZNe7vZks1APAivpxP+AC/mg1oSXp3v+iZVVXQhLHbAjKaC+iIm
         en8A==
X-Gm-Message-State: AJcUukfw4Z43ZPdVsKsPKUM7q+DkfLQyVqqMpu7JtyxKwEkvlMGUlLJz
        +DPxxouplXqoZFmpf9iErjc=
X-Google-Smtp-Source: ALg8bN5NDmSSPpnsO+0GK//5zOzcbDBvrMWbaTodN+dIu7CJIzd5uMBguzeeFg7iO3p3LpuVM654vQ==
X-Received: by 2002:a17:902:7848:: with SMTP id e8mr20361348pln.100.1547330177586;
        Sat, 12 Jan 2019 13:56:17 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i72sm122284327pfe.181.2019.01.12.13.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Jan 2019 13:56:16 -0800 (PST)
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
Subject: [PATCH v5 3/4] PCI: imx6: Convert DIRECT_SPEED_CHANGE quirk code to use a flag
Date:   Sat, 12 Jan 2019 13:56:00 -0800
Message-Id: <20190112215601.9535-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190112215601.9535-1-andrew.smirnov@gmail.com>
References: <20190112215601.9535-1-andrew.smirnov@gmail.com>
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
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
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

