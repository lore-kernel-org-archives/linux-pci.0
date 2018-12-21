Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC7DC43387
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B98921903
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqnJTIu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387982AbeLUH2I (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:28:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46353 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388202AbeLUH2H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 02:28:07 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so2096731pgp.13;
        Thu, 20 Dec 2018 23:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aOG8CavLyhRq8sCBntFikyTFeErNCHKkbYlORQ4DvNg=;
        b=TqnJTIu8I0HdwEONz46eJlxXRn76Mr445orVTvClpARztJpH9rMAlTuv7nejWztxyn
         DuMPpfio0T351PMzmI+JIDxpUqJsiWPVC/QDukseBDLsA7uJY4y9LSMuF/IMeZ79aT0U
         lQXDVgEfsi3IRrmrokm3pzsC4PeiIGKamsMv4usncYvREexnQavMulx6JA1tol6q/3Fi
         jh433KJiMmH7h7fqz1mg6ep0gl2nVGYJywEucavYIlLpYn8UlM05roCmyguNr/4l1DWB
         y8ml5bt790P5FCicXFp41bFm9uhRBD1+oSpE7Tn6x938/gVurnxl77erxV+Yc4kW8Cce
         Ce+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aOG8CavLyhRq8sCBntFikyTFeErNCHKkbYlORQ4DvNg=;
        b=h0kCKJZoJIFuOejY8F7T0bxWtirioMzBWMhT8+/GCVXa9uvmM6PetRV0PpzUt9TGkc
         8cyRLfRXsPgUakreYLHHkIkV/6EJN06CHAFw7TJU4HDtuTsdIfqwSXDWMf9V+bQBPKvr
         5Lhl4NE+BCcCOnrQNm0nOv9Lj89iXBrgNZ22HwAggKKLLZ7WBWubLzYpozgRisQOAZrG
         +YXeX778gwOuDQWx3iRcHJsVn77n8gkqxqyRXV+0IPmYt8Q383hY1j9JeTdgryfUGTzI
         s2P/6HS08hIPMSExCsmcX6dPgA5/2vJJJcZHXSaI0QgCMRgf3xmFEyrkgFHD4Iu/JB3O
         cuzQ==
X-Gm-Message-State: AJcUuke3hmI0t0/LZEVD0YrqB/0wDdC4dPT+V1Z2pnrfdyBCVnagJDrc
        I/XkkAnwCohIrKcxbq5Ub5IhZJjH
X-Google-Smtp-Source: ALg8bN7yhNSbFck0nnNIRDg47AJKYuZqq6R/Ffo/4KF2NT1W+iFq6lGG7eFQhBRw7NMV971VW8LGHg==
X-Received: by 2002:a63:4002:: with SMTP id n2mr1316312pga.137.1545377285389;
        Thu, 20 Dec 2018 23:28:05 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:28:04 -0800 (PST)
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
Subject: [PATCH 14/21] PCI: imx6: Simplify pcie_phy_poll_ack()
Date:   Thu, 20 Dec 2018 23:27:09 -0800
Message-Id: <20181221072716.29017-15-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Simplify pcie_phy_poll_ack() by incorporating shifting into constant
definition and convert the code to use 'bool'. No functional change
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
 drivers/pci/controller/dwc/pci-imx6.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 40d348bb9a2b..ddab1859a07e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -91,7 +91,7 @@ struct imx6_pcie {
 #define PCIE_PHY_CTRL_RD		BIT(19)
 
 #define PCIE_PHY_STAT (PL_OFFSET + 0x110)
-#define PCIE_PHY_STAT_ACK_LOC 16
+#define PCIE_PHY_STAT_ACK		BIT(16)
 
 /* PHY registers (not memory-mapped) */
 #define PCIE_PHY_ATEOVRD			0x10
@@ -108,16 +108,16 @@ struct imx6_pcie {
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
-- 
2.19.1

