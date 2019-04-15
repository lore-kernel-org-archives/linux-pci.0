Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD713C10F14
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADA620870
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqTlaS+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfDOArl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 14 Apr 2019 20:47:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39593 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfDOArj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Apr 2019 20:47:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id a96so7695580pla.6;
        Sun, 14 Apr 2019 17:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FLKtt3LlDBDSGbMrQM4p98Qt+1OhZn2fyX94k9jG/fo=;
        b=eqTlaS+iTu3DOILGraxqeMTT+Y7opvdJSYWxe3Rb5Eu9Vdrz+X7pBZAnlid4lMBD2/
         TqVliGy/QVfufSWRcTllfua2s45RUoK/ELf7l/22gwMPyiiTJgfCOg7cfUzGiDWLE1AU
         psS8bXHA1gc6moXOKq4GmDLfXx7m+hnQ7hrytYTIg3FhvXCDd6Da5ACWPcZL7ZGXafsQ
         2VzVUbXQKZ+6DeEy1rhjcad/1SgPlZB56XzcFSZQLRqkMO/CixRLNAq726Ji77P9j9dt
         lwIy34yISeAoXiOeUw2xB2kKvjdMYDt7urjQD1jLQHbrY/Lwgf0PAH2GL1AhVQBALA3p
         PMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FLKtt3LlDBDSGbMrQM4p98Qt+1OhZn2fyX94k9jG/fo=;
        b=V0RU+b3kL2huuwtXhoqC9KRAwuJhumQDQZfIhzceFbUokpGxpDoS1lvvdyI5NCIeXj
         UK1d9mbr81EaBffXzEW/xloHMCcpNmr/NyhA6olnZFPPMbWNEpHheSkzsXjioxNsLCYy
         GMOebsm2omEraQ9F/4gad63XBCo8XlTu0iZWiweYSGQAqCxLcTE1EFWje8x++oASfUiz
         N1ZfcGDpHSM8L8zV9GhOj7Ayr5vjM32viOgdLsvT47TuRzcr09t8ls6ZZmtL036g43ik
         SFyFS6HA4fROMJCCmG6LYjGTJtdCIhyovxrR4vQqn23iEB3E4XfbXLMFX10XwF8G+nqP
         59GQ==
X-Gm-Message-State: APjAAAV8L6n+3Q+gnM1/FbtB0RTx1Z9f48dXYGSsgX7hT3NxXj/PopUI
        blVDPJ0AYHQT+6VcVs9jKJTaZPW7
X-Google-Smtp-Source: APXvYqwOQVgh2IXAFyjAaSUoUa40KDdm+pAp80DOXteQ5VevKXjpRZEzcpIAREThPLScqFfB2xbnfw==
X-Received: by 2002:a17:902:e683:: with SMTP id cn3mr71254696plb.115.1555289257844;
        Sun, 14 Apr 2019 17:47:37 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id u17sm66111981pfn.19.2019.04.14.17.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 17:47:36 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/11] PCI: imx6: Simplify pcie_phy_poll_ack()
Date:   Sun, 14 Apr 2019 17:46:29 -0700
Message-Id: <20190415004632.5907-9-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415004632.5907-1-andrew.smirnov@gmail.com>
References: <20190415004632.5907-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Simplify pcie_phy_poll_ack() by incorporating shifting into constant
definition and convert the code to use 'bool'. No functional change
intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-imx6.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 669e01353026..3fd084357488 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -112,7 +112,7 @@ struct imx6_pcie {
 #define PCIE_PHY_CTRL_RD		BIT(19)
 
 #define PCIE_PHY_STAT (PL_OFFSET + 0x110)
-#define PCIE_PHY_STAT_ACK_LOC 16
+#define PCIE_PHY_STAT_ACK		BIT(16)
 
 #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
 
@@ -151,16 +151,16 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
 
-static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
+static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
-	u32 val;
+	bool val;
 	u32 max_iterations = 10;
 	u32 wait_counter = 0;
 
 	do {
-		val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
-		val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
+		val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT) &
+			PCIE_PHY_STAT_ACK;
 		wait_counter++;
 
 		if (val == exp_val)
@@ -184,14 +184,14 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 	val |= PCIE_PHY_CTRL_CAP_ADR;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
 
-	ret = pcie_phy_poll_ack(imx6_pcie, 1);
+	ret = pcie_phy_poll_ack(imx6_pcie, true);
 	if (ret)
 		return ret;
 
 	val = PCIE_PHY_CTRL_DATA(addr);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
 
-	return pcie_phy_poll_ack(imx6_pcie, 0);
+	return pcie_phy_poll_ack(imx6_pcie, false);
 }
 
 /* Read from the 16-bit PCIe PHY control registers (not memory-mapped) */
@@ -209,7 +209,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 	phy_ctl = PCIE_PHY_CTRL_RD;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, phy_ctl);
 
-	ret = pcie_phy_poll_ack(imx6_pcie, 1);
+	ret = pcie_phy_poll_ack(imx6_pcie, true);
 	if (ret)
 		return ret;
 
@@ -219,7 +219,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 	/* deassert Read signal */
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, 0x00);
 
-	return pcie_phy_poll_ack(imx6_pcie, 0);
+	return pcie_phy_poll_ack(imx6_pcie, false);
 }
 
 static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
@@ -241,7 +241,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 	var |= PCIE_PHY_CTRL_CAP_DAT;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
-	ret = pcie_phy_poll_ack(imx6_pcie, 1);
+	ret = pcie_phy_poll_ack(imx6_pcie, true);
 	if (ret)
 		return ret;
 
@@ -250,7 +250,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
-	ret = pcie_phy_poll_ack(imx6_pcie, 0);
+	ret = pcie_phy_poll_ack(imx6_pcie, false);
 	if (ret)
 		return ret;
 
@@ -259,7 +259,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack */
-	ret = pcie_phy_poll_ack(imx6_pcie, 1);
+	ret = pcie_phy_poll_ack(imx6_pcie, true);
 	if (ret)
 		return ret;
 
@@ -268,7 +268,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
-	ret = pcie_phy_poll_ack(imx6_pcie, 0);
+	ret = pcie_phy_poll_ack(imx6_pcie, false);
 	if (ret)
 		return ret;
 
-- 
2.20.1

