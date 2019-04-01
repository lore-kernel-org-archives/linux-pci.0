Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6F1C4360F
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A2320879
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OffdOUSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbfDAE0P (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:26:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34792 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731700AbfDAE0O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 00:26:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so4084316pgq.1;
        Sun, 31 Mar 2019 21:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zo7YY9RlZFhjrvNNH/TAsWEOA9xZ2TYMIrq7kVWYlhI=;
        b=OffdOUSanEiUxIJd7PSU2U6oXzGltjOS8gf7Dtzb6CuutkuQRCwje9coS7rXJcFSyn
         QObonRcDyhfvI3OxeMm1/kcWC7/xfd8Y4gWoUqfR6oX/WZs4KuJuD214QfvDpitlrdM5
         acPi92z28qSAxUmrxnVXLAUGbXYaqRmF42UOWalxNaxr5ytElLkaFGBD4xGRKm/EXMEX
         1Jwwkl9b/IjtO6pP/gbhhaoGwci9XCUxjiaWpVsSAFbymhYQHBcvymmePAIvR8S2OawN
         2cj8vEqzf99MK7O3IpvJW/LVRNHayf8gc7zXZpS6COqJMR/o6yRgy19kFCxqva0cm1HY
         /ncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zo7YY9RlZFhjrvNNH/TAsWEOA9xZ2TYMIrq7kVWYlhI=;
        b=cmF8DOpb39r1I2+wEp+Cn2Vv2fZvLT63pJ10FcYmFflexMVJY92MkMlq1xqIz76hBR
         uXpJ4FGjdTdQAozYRbnaMFam1rSpdrX1RFXcBOMyzI2j6NcCSisVnOVETphcnY0Q5tvg
         c25LfqZ+PjZc9yIeFEV4vkfbJufz5y37a5j6l/ddVumgQGmxAxkGEuZBR9vt3Y8yXtdE
         iFpOBbrDWqA6hJouoZAJ4E62Y5AVOxrLpJh+DxmoF2GLTX45eJXNS4sSvyfe2/6B4qRc
         jZhf2BU6A4WSh21oUwelLeuqbR+f7y7ZWkBurYs3IgvgLf7suCh4GTRbmQC/0gzPzKIU
         SXBg==
X-Gm-Message-State: APjAAAU/46196+6pj4WihWPxCi/3x0pvQbP5s85HRsfyaMwnRDJZF2vW
        Me7WjiCNoIZAySkW4DQa6T9b9Ooi
X-Google-Smtp-Source: APXvYqwMa6Q4rl8JVXlTJS0o6bbwUSeH9MZAjfNv6K8hbtJj8Zr9NyuFIgHFImzQhkbieODuBeKwLQ==
X-Received: by 2002:a62:ed08:: with SMTP id u8mr60360752pfh.200.1554092773027;
        Sun, 31 Mar 2019 21:26:13 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t22sm10996829pgu.45.2019.03.31.21.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:26:12 -0700 (PDT)
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
Subject: [PATCH v3 09/11] PCI: imx6: Restrict PHY register data to 16-bit
Date:   Sun, 31 Mar 2019 21:25:45 -0700
Message-Id: <20190401042547.14067-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401042547.14067-1-andrew.smirnov@gmail.com>
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
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
index 7c3ffb751002..9c658ef55aa4 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -195,10 +195,10 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
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
@@ -213,8 +213,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 	if (ret)
 		return ret;
 
-	val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
-	*data = val & 0xffff;
+	*data = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
 
 	/* deassert Read signal */
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, 0x00);
@@ -222,7 +221,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 	return pcie_phy_poll_ack(imx6_pcie, 0);
 }
 
-static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
+static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	u32 var;
@@ -279,7 +278,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 
 static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
-	u32 tmp;
+	u16 tmp;
 
 	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
 		return;
@@ -675,7 +674,7 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 {
 	unsigned long phy_rate = clk_get_rate(imx6_pcie->pcie_phy);
 	int mult, div;
-	u32 val;
+	u16 val;
 
 	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
 		return 0;
-- 
2.20.1

