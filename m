Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85140C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5896F21872
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxm6kEFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfADRuL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:50:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42780 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbfADRuK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 12:50:10 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so17723712plp.9;
        Fri, 04 Jan 2019 09:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ynqU9RdFevJBXRMN2+g/v2PRS5HmTSTnfcgRpzk4u8=;
        b=Yxm6kEFjm2RkQF9s49Wl9lpLEKQaWCgrgGzJK5R9UHJS1UVgwCfVpbBNj348R2XrVH
         vCKcWseU0/+SDTW0SZCIQnfpwsLSPhFicU+1miWDTDv2N66o0oUW66Exns97ffW+qrfw
         RMf4fsveTwbB6IsQfIdhNAXuG6oduKU6iSd+XRY7PHg7obcSUgVAuy0yZbDag9KtjSWI
         +St4d34B1pyzcoTEqfExqV6SL8H4dXFEe+Yv66NljD3ZMlSUIpGTv0/l0B8NjVXA6vmB
         O+trOHSZ+k+E8Bzm7hX8+fd+d5A4GoWUzwwnWqL4aIxl0VMuts8wPyWmv55CRMoWYIan
         yM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ynqU9RdFevJBXRMN2+g/v2PRS5HmTSTnfcgRpzk4u8=;
        b=XZl6X68qlhqdyGS4yqXvhSvx57eWOd2FY6cFdbcH/VlhAZRrQnodtC0PaWMOUL1V2t
         /Llj/aGOQAtjbu1dO5UKlwH+T5WBujRw+oGuhg2JH9PFn1+EMI1La27kQ6w4wDAr6QG9
         DRpb0MHxqmQD8FoTr75l3HWk2hLsfz2w6F7p+sA0qmFp19jEh5Sk12O4F71zwYJOn+if
         gTPGipYMfwEpZ2xgf72zg6NDYdl21V/x0qtpmx+27RjZOBD9GBKRYhNO5FY+I0h02edT
         4L4vBUsw+BRNKBiSDesJgLFhYXIqEtVLfatINItphCsRXIFsodXUYm7A/Hih1Vk6h/oZ
         2NkA==
X-Gm-Message-State: AJcUukdOBba8othGwRxIYjOguVuV32YHVQ2KZwT3iU6a21nMTBjpEOAP
        Zn3aooH59E33dyWHSKdD06An2jxmxYE=
X-Google-Smtp-Source: ALg8bN74f+KdjZLhDwczdKTH2whSmV69SzJxJ0xGAw4m/5SP+7k3rouC0lpqbaMiEbcPeqt+HnovEA==
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr51889493plc.57.1546624209871;
        Fri, 04 Jan 2019 09:50:09 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 09:50:09 -0800 (PST)
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
Subject: [PATCH v2 15/20] PCI: imx6: Pass data to dw_pcie_writel_dbi() directly
Date:   Fri,  4 Jan 2019 09:49:20 -0800
Message-Id: <20190104174925.17153-16-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
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
index 02342b1762fa..befbc09c9c41 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -172,7 +172,6 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, u16 *data)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
-	u32 phy_ctl;
 	int ret;
 
 	ret = pcie_phy_wait_ack(imx6_pcie, addr);
@@ -180,8 +179,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, u16 *data)
 		return ret;
 
 	/* assert Read signal */
-	phy_ctl = PCIE_PHY_CTRL_RD;
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, phy_ctl);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, PCIE_PHY_CTRL_RD);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
@@ -219,8 +217,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 		return ret;
 
 	/* deassert cap data */
-	var = PCIE_PHY_CTRL_DATA(data);
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, PCIE_PHY_CTRL_DATA(data));
 
 	/* wait for ack de-assertion */
 	ret = pcie_phy_poll_ack(imx6_pcie, 0);
@@ -228,8 +225,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 		return ret;
 
 	/* assert wr signal */
-	var = PCIE_PHY_CTRL_WR;
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, PCIE_PHY_CTRL_WR);
 
 	/* wait for ack */
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
@@ -237,8 +233,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 		return ret;
 
 	/* deassert wr signal */
-	var = PCIE_PHY_CTRL_DATA(data);
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, PCIE_PHY_CTRL_DATA(data));
 
 	/* wait for ack de-assertion */
 	ret = pcie_phy_poll_ack(imx6_pcie, 0);
-- 
2.20.1

