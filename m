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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0C0C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E605421872
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub8qeaY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfADRvY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:51:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37711 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbfADRuF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 12:50:05 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so17736185plr.4;
        Fri, 04 Jan 2019 09:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w9KU/W4CQap2RK2hsRI+gNohsIozdtadfTJIN88KMTs=;
        b=Ub8qeaY7l5BX2LdG1ZfhbYVBmhPQMPROSTMWAoNKmswTP6VRDypf41vEOf9/56STcq
         Anh+omXnyVcUeLEIrOfIWiQOpWL3u2qSB6G99UYvPn8trxp217l6WKeCVGV0pxlsF8tj
         QSoBShRy22VYH5FAkjasJKoeqz4BM/GTA8uc6af0eYf9da0FswdPOz2tXikRe7CQ4eJR
         CUiWdp9rKeB9ZIrE+6Xb+o3OH5LTNkvI9k5S2mXTHcNHgHsxQUtz/DOYhK+uvWPzkZmD
         gsVhWgB3stIYSY7EDMWD6ilSne+FzxTdywtd3xV/fhXmnI/+1jcAgA8eys/0t4NhdWzI
         1i/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w9KU/W4CQap2RK2hsRI+gNohsIozdtadfTJIN88KMTs=;
        b=rVn7N2qYEX6AKuzeTt1BuMzKyHpBfBn9DJ77yz9HBC9BoaW6/PP5Acv8ym2E6BD4Om
         R6vzEh6joqPSMd49VuZQgeMTlG4pOA1Yjs1BpgY8XGCAt6u2+h61H/515hKA4JQGQk5n
         Wko59L7zsZBST6EUutKLxkOnZ1vAKJ97KWxyoRBThQ3GvYqWAvX4tSi7+WdfAt7hAXun
         8yxFIDnnM/60W+OQfeq+uLkc+JzssnpZvxgsFcEyeGKN9UtXyF2brLHwmAVC5F1b8Tyn
         Vxg7JppyZJ2hnD1oVUO9D1/KvJu8nFOCT3S9ert5oR6zRASfEXV8crKJA1xVijUsuzYj
         JHpQ==
X-Gm-Message-State: AJcUukeLKARFJ+j75nZAS1AyyVsE+Vujnj3Yv7S9pHiRxdj0O6d9y2G7
        2aqbXGrnmdY1XI8vGKhWeSkEGPzp8vs=
X-Google-Smtp-Source: ALg8bN6gxG1OAvAuFAEIXqh5twg6wRoU+lumMTfjKcijYxQpWYiI8n+XqMJIwBM8BgFO/2q8sdi8JQ==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr52373171plb.52.1546624204331;
        Fri, 04 Jan 2019 09:50:04 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 09:50:03 -0800 (PST)
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
Subject: [PATCH v2 12/20] PCI: imx6: Simplify bit operations in PHY functions
Date:   Fri,  4 Jan 2019 09:49:17 -0800
Message-Id: <20190104174925.17153-13-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Simplify the code by incorporating left shifts into constant
defnitions as well as using FIELD_PREP/GENMASK. No functional change
intended.

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
 drivers/pci/controller/dwc/pci-imx6.c | 28 +++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 180ba57da4e8..672332483324 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -101,11 +101,11 @@ struct imx6_pcie {
 #define PL_OFFSET 0x700
 
 #define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
-#define PCIE_PHY_CTRL_DATA_LOC 0
-#define PCIE_PHY_CTRL_CAP_ADR_LOC 16
-#define PCIE_PHY_CTRL_CAP_DAT_LOC 17
-#define PCIE_PHY_CTRL_WR_LOC 18
-#define PCIE_PHY_CTRL_RD_LOC 19
+#define PCIE_PHY_CTRL_DATA(x)		FIELD_PREP(GENMASK(15, 0), (x))
+#define PCIE_PHY_CTRL_CAP_ADR		BIT(16)
+#define PCIE_PHY_CTRL_CAP_DAT		BIT(17)
+#define PCIE_PHY_CTRL_WR		BIT(18)
+#define PCIE_PHY_CTRL_RD		BIT(19)
 
 #define PCIE_PHY_STAT (PL_OFFSET + 0x110)
 #define PCIE_PHY_STAT_ACK_LOC 16
@@ -152,17 +152,17 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 	u32 val;
 	int ret;
 
-	val = addr << PCIE_PHY_CTRL_DATA_LOC;
+	val = PCIE_PHY_CTRL_DATA(addr);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
 
-	val |= (0x1 << PCIE_PHY_CTRL_CAP_ADR_LOC);
+	val |= PCIE_PHY_CTRL_CAP_ADR;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
 		return ret;
 
-	val = addr << PCIE_PHY_CTRL_DATA_LOC;
+	val = PCIE_PHY_CTRL_DATA(addr);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
 
 	return pcie_phy_poll_ack(imx6_pcie, 0);
@@ -180,7 +180,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 		return ret;
 
 	/* assert Read signal */
-	phy_ctl = 0x1 << PCIE_PHY_CTRL_RD_LOC;
+	phy_ctl = PCIE_PHY_CTRL_RD;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, phy_ctl);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
@@ -208,11 +208,11 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 	if (ret)
 		return ret;
 
-	var = data << PCIE_PHY_CTRL_DATA_LOC;
+	var = PCIE_PHY_CTRL_DATA(data);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* capture data */
-	var |= (0x1 << PCIE_PHY_CTRL_CAP_DAT_LOC);
+	var |= PCIE_PHY_CTRL_CAP_DAT;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
@@ -220,7 +220,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 		return ret;
 
 	/* deassert cap data */
-	var = data << PCIE_PHY_CTRL_DATA_LOC;
+	var = PCIE_PHY_CTRL_DATA(data);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
@@ -229,7 +229,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 		return ret;
 
 	/* assert wr signal */
-	var = 0x1 << PCIE_PHY_CTRL_WR_LOC;
+	var = PCIE_PHY_CTRL_WR;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack */
@@ -238,7 +238,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 		return ret;
 
 	/* deassert wr signal */
-	var = data << PCIE_PHY_CTRL_DATA_LOC;
+	var = PCIE_PHY_CTRL_DATA(data);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
-- 
2.20.1

