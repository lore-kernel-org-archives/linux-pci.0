Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D939C43444
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4994C21903
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0FQH0vp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbeLUH2M (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:28:12 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36708 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388341AbeLUH2L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 02:28:11 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so2112548plo.3;
        Thu, 20 Dec 2018 23:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t+Ph+iIWzFZpNu9UO0nka2W/68YLTAo65CCi/cOl030=;
        b=j0FQH0vp+t6h9imxvu+6dBbyxK3d4Ipy5RIH8JbEGIqHCo8P81v3vgw2YU2UpunsOS
         Fo+msqpMgIKuVOXKJJg0M4q2lLh7vdIJj0mx4eF4scSJAYpEotocf4aVc5Eojw53LC/Z
         mAsKiH3OGVkJ6vc90Wnz50ZWgMB5ZowlpGOVmoiqKORVay+S9L/F3PZ3/Ks+Ih9kg0Hb
         gkDFAafLkxizxQyd/zjfmOTpxkaTGxlmLuZTJ52QBwkfxcxNcH2udLXl0ZhWZDlBA3yx
         hyCQICAPgGHyPVo8JDKxgDjxv8/jDulwG+a2jXSbC76KGqfUeVZ/c0og3vuQcqRF6gjM
         ZgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t+Ph+iIWzFZpNu9UO0nka2W/68YLTAo65CCi/cOl030=;
        b=oE0LphgI0H3RYhI/6WR+8ovOni0Yb2dmFmhvmX2ExvyX14nKvtDBg4xBQp8Q8yuoJa
         SgL+37BDBdWxMSqfOpHnAELoCQxQLoNyQt+0WTpAMo9CE82xtylQcmZoZz+0E06i8wYU
         2CF5fl2jIloR+q2rkrnVsVvQgkhgSNeLo50qlmdN9/lBxCQFrkAEQajrFdXpVdw4SeyP
         Ec7gDB/YJ0eTtOmnGbTXd4ya2v66rNHfEXFLXQm90JlJrH4Q6G+rJ4toBLKX8PcFmdR2
         eiNLjjC1br3Os8GX4qZH7IWxT9lCl4eN4HAIXtO5wSH9KNp7yjVrm7NO5F1CRZjP+U+8
         ALNw==
X-Gm-Message-State: AJcUukfmh5KlJoqq77vMR9bQlgcu3ORuV11bRGTHgOBwtVQj86rfnINi
        PQ+cQyYwWi+oZCwPCGlD8g5XZHKq
X-Google-Smtp-Source: ALg8bN71+thEST0OsUXu3TFyPC+dUURS3WkuHuuBEe7LNF1pOVQoxUDkkNhtWIxNF1diH4o8CzIqag==
X-Received: by 2002:a17:902:8641:: with SMTP id y1mr1406449plt.159.1545377289324;
        Thu, 20 Dec 2018 23:28:09 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:28:08 -0800 (PST)
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
Subject: [PATCH 16/21] PCI: imx6: Pass data to dw_pcie_writel_dbi() directly
Date:   Thu, 20 Dec 2018 23:27:11 -0800
Message-Id: <20181221072716.29017-17-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Save a couple of lines of code by dropping assignement to 'var' and
passing constants as via function arguments directly. No functional
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
 drivers/pci/controller/dwc/pci-imx6.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 98e3730e75fa..bade9d608605 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -155,7 +155,6 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, u16 *data)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
-	u32 phy_ctl;
 	int ret;
 
 	ret = pcie_phy_wait_ack(imx6_pcie, addr);
@@ -163,8 +162,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, u16 *data)
 		return ret;
 
 	/* assert Read signal */
-	phy_ctl = PCIE_PHY_CTRL_RD;
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, phy_ctl);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, PCIE_PHY_CTRL_RD);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
@@ -202,8 +200,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 		return ret;
 
 	/* deassert cap data */
-	var = PCIE_PHY_CTRL_DATA(data);
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, PCIE_PHY_CTRL_DATA(data));
 
 	/* wait for ack de-assertion */
 	ret = pcie_phy_poll_ack(imx6_pcie, 0);
@@ -211,8 +208,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 		return ret;
 
 	/* assert wr signal */
-	var = PCIE_PHY_CTRL_WR;
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, PCIE_PHY_CTRL_WR);
 
 	/* wait for ack */
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
@@ -220,8 +216,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 		return ret;
 
 	/* deassert wr signal */
-	var = PCIE_PHY_CTRL_DATA(data);
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, PCIE_PHY_CTRL_DATA(data));
 
 	/* wait for ack de-assertion */
 	ret = pcie_phy_poll_ack(imx6_pcie, 0);
-- 
2.19.1

