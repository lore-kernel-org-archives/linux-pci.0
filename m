Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73177C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F0D21872
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+x2Knz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfADRuJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:50:09 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36033 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbfADRuI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 12:50:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so18629875pfc.3;
        Fri, 04 Jan 2019 09:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l5Ov7DgLo0x+QhZh8MrjSzuZLAXS/elFdRJcT/iufBQ=;
        b=Z+x2Knz6I5ntkAKsqCwQ9anK0XjHjRnyoafbwABQO+I7pDLITu4um2CPX2i1Bckg6v
         29Hh89TWOMYuvDjF+SUnwxxiFpptVU8xpnaxPHB/LFhUOAEHkr37M47CbH1XyoLDokRz
         uC7TfNtUpsaZh62rmf+rmbT+IF60xhv0/FjsFgkgAYaYoY0ShTPmCis2MPCFBsvQnEd8
         gr6oPY1yKgev0dck7068HdqsS2bdNFzGKpt7Jn/Ailm+wrk/JlqWSHMI3mJ/VzaJxnSt
         HwP9NmJe/nY8wP2lhdvUBwjZKKkOMfRnLTpBUdqngwJ7ZcL4OIXFncAukcyntFifsoTK
         EuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l5Ov7DgLo0x+QhZh8MrjSzuZLAXS/elFdRJcT/iufBQ=;
        b=tMHddmEb1iyvSqEpUuZn0v+C7hW2Zt/byI/hdmW4VWmTY7PIRrHvpYfe+XIOiE3+at
         dXso55fugbSH0z/8YUxyJAf2WUXgjvRCeJEHAoxVR3i/BfVHAEq5ve0sJl4O03z2x16q
         jeL2MQWGsbxscg/SsLNfEc3nUPXmdrUh2sgkiOKh5m9nZscWTFOW3LkAznJo56A6X5IE
         WNtxtyAPlPUXYdg0BLQwK0H6FrSXflvlCKomdUsV6zRfKgMfGo5LQVfgYhn4tJGYzX2E
         mHXt2W5Z1x5LLTZoeY7spfH8eb59NiPs9qCdfyP2umdxbScHiXOAN2pBeDQ4AaaTFwHz
         6S3w==
X-Gm-Message-State: AJcUukfZljBMDAz/1eKY7XkyKlk/L8JIcIF1AIHFhwKKd/9IXrAu0BqD
        RpAHlft3baljjox4iyozbeblR+PK/EQ=
X-Google-Smtp-Source: ALg8bN7BnbCyiCZzhA0J1wCL/o1gaSR4ShCULsxdY5pRgwbfRrYr+yjjrTRBrpw6u9ccj+3j9K7Vwg==
X-Received: by 2002:a63:2c82:: with SMTP id s124mr2385458pgs.73.1546624207694;
        Fri, 04 Jan 2019 09:50:07 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 09:50:06 -0800 (PST)
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
Subject: [PATCH v2 14/20] PCI: imx6: Restrict PHY register data to 16-bit
Date:   Fri,  4 Jan 2019 09:49:19 -0800
Message-Id: <20190104174925.17153-15-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PHY registers on i.MX6 are 16-bit wide, so we can get rid of explicit
masking if we restrict pcie_phy_read/pcie_phy_write to use 'u16'
instead of 'int'. No functional change intended.

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
 drivers/pci/controller/dwc/pci-imx6.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 2a7075a9cba6..02342b1762fa 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -169,10 +169,10 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 }
 
 /* Read from the 16-bit PCIe PHY control registers (not memory-mapped) */
-static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
+static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, u16 *data)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
-	u32 val, phy_ctl;
+	u32 phy_ctl;
 	int ret;
 
 	ret = pcie_phy_wait_ack(imx6_pcie, addr);
@@ -187,8 +187,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 	if (ret)
 		return ret;
 
-	val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
-	*data = val & 0xffff;
+	*data = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
 
 	/* deassert Read signal */
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, 0x00);
@@ -196,7 +195,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 	return pcie_phy_poll_ack(imx6_pcie, 0);
 }
 
-static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
+static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	u32 var;
@@ -253,7 +252,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 
 static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
-	u32 tmp;
+	u16 tmp;
 
 	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
 		return;
@@ -620,7 +619,7 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 {
 	unsigned long phy_rate = clk_get_rate(imx6_pcie->pcie_phy);
 	int mult, div;
-	u32 val;
+	u16 val;
 
 	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
 		return 0;
-- 
2.20.1

