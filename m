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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA0FC43444
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A2B21872
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEoo1a/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfADRuN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:50:13 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46553 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbfADRuN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 12:50:13 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so17718730ply.13;
        Fri, 04 Jan 2019 09:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wgbDW5dpUQt98rEUFIyBYJEI6ndB9gcDqUzY7mel/6s=;
        b=iEoo1a/OKkKJZtfMoSTJBNRwLRmxHYiy5BELr0ZahkEJGPUnWHwAwbGSGWVnA2K3N8
         DWThaSV1BEmfcBxiAl1ghAgv91foOjqkSX4pMTvTNUCjzCLNrdOz1weDJPulXHqesjzh
         eo5y6w4t7zvPtU5sktiCfCu1pXpsRxMjWppuO9SHLgmgKT9gXL2SX8Wfj6adxuE+Rugt
         GNg31n1h4+XGXfq7q7scRS3JKuR0gATy2gkluOWZDDgVBnj+gkDP79Tcl6mcoJ0SV7QR
         2uJGVeXBm/wDHSiTwgvW5dPiDfSObElXccqjn1ADPmRyVU/oijZ3B9efIS2HA31eCYsK
         FvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wgbDW5dpUQt98rEUFIyBYJEI6ndB9gcDqUzY7mel/6s=;
        b=r15BFLgmVEGcWausMZX0/AtVHYZoYD4kTVZ+nfr8DHD5g5nc/588u6UTI2StSQeIQt
         Z38Y5awggrIFr0EkcboJm1vT4cv5/MEhx19UOZebMqP1KWxXtSPcS/ST4+X8bH3jOm6G
         0k05mcVwEPLvzV+IFZatxMY9u8tD+VCOtooM3ankRwSCmQKoMD1Qhh3eSvErnj3lBin3
         OomUyoe0sPPGAJ/1d0mFP44uGgbj8hvhY3MEq7ADzRfUCM3am08TPpHdWXkUApbHT2vc
         OvLpw+y+apa9lcNtD4GZX4MVw+pb27f5ghjgIJOVasxmQKolsNQaY4nFohVMNOGE3fgO
         mdDw==
X-Gm-Message-State: AJcUukegV9vrZvO1H62dJ63i1lEbAvGqQRnz9drOCR9ZfZ6EnpXhNqbY
        Q0Y0ucqt65uCQxKPpF4Ri3S1mW0/Ztw=
X-Google-Smtp-Source: ALg8bN7DWXymiFDJPJKMM8BjkzXwfxTzSSAkZlFhar78VPcv/On4+5l+ipcw6E2WWjhb9eRrCzZmFw==
X-Received: by 2002:a17:902:2a66:: with SMTP id i93mr50874325plb.113.1546624211721;
        Fri, 04 Jan 2019 09:50:11 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 09:50:11 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/20] PCI: imx6: Use common mask in imx6_pcie_reset_phy()
Date:   Fri,  4 Jan 2019 09:49:21 -0800
Message-Id: <20190104174925.17153-17-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Simplify imx6_pcie_reset_phy() by using common mask. No functional
change intended.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
 drivers/pci/controller/dwc/pci-imx6.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index befbc09c9c41..130f577670c8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -247,21 +247,21 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 
 static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
+	const u16 mask = PHY_RX_OVRD_IN_LO_RX_DATA_EN |
+			 PHY_RX_OVRD_IN_LO_RX_PLL_EN;
 	u16 tmp;
 
 	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
 		return;
 
 	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
-	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
-		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
+	tmp |= mask;
 	pcie_phy_write(imx6_pcie, PHY_RX_OVRD_IN_LO, tmp);
 
 	usleep_range(2000, 3000);
 
 	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
-	tmp &= ~(PHY_RX_OVRD_IN_LO_RX_DATA_EN |
-		  PHY_RX_OVRD_IN_LO_RX_PLL_EN);
+	tmp &= ~mask;
 	pcie_phy_write(imx6_pcie, PHY_RX_OVRD_IN_LO, tmp);
 }
 
-- 
2.20.1

