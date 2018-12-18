Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC21C43444
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 04:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CDE2086C
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 04:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbtoYbhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbeLREHY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 23:07:24 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42941 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeLREHY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Dec 2018 23:07:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so7162467plp.9;
        Mon, 17 Dec 2018 20:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3LZ1B+w3Ow4FWhJuytlSum7SxBX6UGqso+sY25998rQ=;
        b=UbtoYbhvv9Eat1kVm+2FjWSgyz0/4weKMUa8yG19BwMQEB4ViL5SFei/0PB7OGQe+Q
         eCju7Q/j3RbzRgrUzm1BK5qBnH0RXObx4tcDitYhFcKoMoQNdVNwlMFnMArWEjcteH4u
         Tbx74m5Sw1nCu8g15NgGF0PMG+vXKRTyWg5JDe6bZoy+7YmoNtw48gtSgBlZGcJicETg
         CTLBUUSCWFJOJ7KUOBGUfYTAkkJl2sxFkriueg+9J8lE/gV3ZFxzmbT7Rz2n27zfh45K
         YnS1hPdarCGXXuCugwJZpLP7yrsehgy5kmFnPDR1VqSlAq7fxneRroca2Z/JsVab3I2K
         jWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3LZ1B+w3Ow4FWhJuytlSum7SxBX6UGqso+sY25998rQ=;
        b=T9QFhk4+ztZOjrCp7tie1VsIF3QPdz4mZSIwGI1dbZbB2RkPXDImDuo6nZy5jHg0xl
         Kr+zvdOhzwnDQT+K8BDFSwd86vSxcTPZdQ0kTPaK30wmM5j6U47ybAJwkLrALQdbKFRu
         sqmmxJGh9io5jAdouMTcynZQ7UOBH9IBLyn5oxeDunbOsRt1qLjcUprauBY5tItiaNcy
         eczWrJ+X22m264nhqKrwk7or2iw6Shq3OnbnLOAMFS59G9ZoAWI0cmmM6loz6QU5+qPc
         50jKCB5oK97yHy7BW3WCldSjH4CZkJDKPy2xNVKktTWPcPhHPBx+W0SLwItMHQ99D7ER
         zldQ==
X-Gm-Message-State: AA+aEWYg00h65LFVwS5v/DlBna3yrmcz5qkvCKK9+CmUcOHefcD+tOFo
        qLC/tdm09zF56g66A90k+XQ=
X-Google-Smtp-Source: AFSGD/Ua52Z5zAHH8nLUrok70WRVujqXWbh4Jp92bVqx216petiG5KQSvh0IVekhJZf+nIWavAoACw==
X-Received: by 2002:a17:902:b592:: with SMTP id a18mr15046487pls.293.1545106043679;
        Mon, 17 Dec 2018 20:07:23 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id m67sm18538837pfm.73.2018.12.17.20.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 20:07:22 -0800 (PST)
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
Subject: [PATCH v3 2/3] PCI: imx6: Mark PHY functions as i.MX6 specific
Date:   Mon, 17 Dec 2018 20:07:01 -0800
Message-Id: <20181218040702.29231-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181218040702.29231-1-andrew.smirnov@gmail.com>
References: <20181218040702.29231-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIE PHY IP block on i.MX7D differs from the one used on i.MX6 family,
so none of the code in current implementation of imx6_setup_phy_mpll() and 
imx6_pcie_reset_phy() is applicable.

Tested-by: Trent Piepho <tpiepho@impinj.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
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
---
 drivers/pci/controller/dwc/pci-imx6.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index d50ed69e7a57..caa05104b90b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -41,8 +41,11 @@ enum imx6_pcie_variants {
 	IMX7D,
 };
 
+#define IMX6_PCIE_FLAG_IMX6_PHY		BIT(0)
+
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
+	u32 flags;
 };
 
 struct imx6_pcie {
@@ -256,6 +259,9 @@ static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
 	u32 tmp;
 
+	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
+		return;
+
 	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
 	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
 		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
@@ -573,6 +579,9 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 	int mult, div;
 	u32 val;
 
+	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
+		return 0;
+
 	switch (phy_rate) {
 	case 125000000:
 		/*
@@ -1088,12 +1097,15 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
 		.variant = IMX6Q,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.19.1

