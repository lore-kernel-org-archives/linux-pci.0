Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7FFC43444
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A947021906
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laDZnjBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbeLUH3b (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:29:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46606 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388056AbeLUH2E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 02:28:04 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so2096063ply.13;
        Thu, 20 Dec 2018 23:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UyXZTOk3menKB/t8eFutGA3nZkIu5JphmYQKvkOh16M=;
        b=laDZnjBh2J4T2ev7D1FV58fMa8r4adUyojMiRp0SJ3Ugh4ByRxvLrmgvzHWUCdP+kD
         mD1gRJiYoLmAzhMcwt6Q03hCiDyV/qW96AZlDDhpVhRpxnYMxqgeOaLX2YNB6cy7qX68
         TTyAMHhlheu060Br6rSsPccyVgh4nLgyxU+xuxZqZ6hK2K8gZF1+iDulI9qnGsijAPtc
         R3Kj+rEsW9PcLgh37LiM+kb4hIGUMf3UV/Z7Syw5lXYdcWXDd37/St4InI+jAILu/ILP
         xUr9TB+GWOCaW7gUoK+wvKBT7IM/zWRDjzTY+gxVpGwsYWRd+PKrKVAgvDdJPGgs3eIB
         Tekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UyXZTOk3menKB/t8eFutGA3nZkIu5JphmYQKvkOh16M=;
        b=lym7d2tmLy0ueUSLZ3CSaifYkSXxPvHwgQuuugf3g1wc8OqzZd7KyBJICdIVUIDa36
         GTgCceKEryvv0A34RjSQBR32EuMBRYP7W/yhY7zKtXtYOFQjLfL/mR9FM+bZW+X4OW8N
         QZnh4p+ZBbcrBggaN2W3HGhSh/I2R2/U872XD5PD0+8g5hG3nlXGatc9hqujAfP324jU
         CT8t+ylHND32RdmYMmhBTruGTgDiIHBiNDWb1NR0P1v3KszrI+VxzWcTk/FkEt0iKz+D
         1UdHoJuiLxdZBQqogO9z8DmeEgH/xN0rt2eyj1C4C3W27UXDl9f1qzzKLRGm235IhFMv
         SAgw==
X-Gm-Message-State: AJcUukfgeN38K6KI8txEsjqSBLb70yC40D/8qYVshE/bA++OaDW8in0C
        uNCXrGAIgxf194bSpCMFnvDvpn+C
X-Google-Smtp-Source: ALg8bN4woDopvm84fXXLBZIgM5gLLHjUS68sG/W844AnAlmgZsycDcfGBv5dKNpXSO98w/5WbH1sbA==
X-Received: by 2002:a17:902:e002:: with SMTP id ca2mr1438205plb.103.1545377283510;
        Thu, 20 Dec 2018 23:28:03 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:28:02 -0800 (PST)
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
Subject: [PATCH 13/21] PCI: imx6: Simplify bit operations in PHY functions
Date:   Thu, 20 Dec 2018 23:27:08 -0800
Message-Id: <20181221072716.29017-14-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
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
index 2737526158fa..40d348bb9a2b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -84,11 +84,11 @@ struct imx6_pcie {
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
@@ -135,17 +135,17 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
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
@@ -163,7 +163,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 		return ret;
 
 	/* assert Read signal */
-	phy_ctl = 0x1 << PCIE_PHY_CTRL_RD_LOC;
+	phy_ctl = PCIE_PHY_CTRL_RD;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, phy_ctl);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
@@ -191,11 +191,11 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
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
@@ -203,7 +203,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 		return ret;
 
 	/* deassert cap data */
-	var = data << PCIE_PHY_CTRL_DATA_LOC;
+	var = PCIE_PHY_CTRL_DATA(data);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
@@ -212,7 +212,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 		return ret;
 
 	/* assert wr signal */
-	var = 0x1 << PCIE_PHY_CTRL_WR_LOC;
+	var = PCIE_PHY_CTRL_WR;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack */
@@ -221,7 +221,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 		return ret;
 
 	/* deassert wr signal */
-	var = data << PCIE_PHY_CTRL_DATA_LOC;
+	var = PCIE_PHY_CTRL_DATA(data);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
-- 
2.19.1

