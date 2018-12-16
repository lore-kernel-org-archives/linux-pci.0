Return-Path: <SRS0=ngrz=OZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B9FC43387
	for <linux-pci@archiver.kernel.org>; Sun, 16 Dec 2018 23:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A692084A
	for <linux-pci@archiver.kernel.org>; Sun, 16 Dec 2018 23:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGIdgDb6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbeLPXJp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 16 Dec 2018 18:09:45 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35042 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbeLPXJo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Dec 2018 18:09:44 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so5185666pgs.2;
        Sun, 16 Dec 2018 15:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Ky7pgVvvF9hLcoAABtSFG13zMfTe+6ohhmnBjH727g=;
        b=tGIdgDb675KcT+PZnOTanBgWwaRyRZ8akrzY/vSuOGVM6xzj5vyScaAVotj5bZpEkE
         FVoDtXtL3k7gKaJWHU1Wq0E21vMIcZNUIHPcWwH452UDtgxX4pkbAaFCA906Abxtu30a
         Db9Iti09HC0aKdfYRLmzFKM90w3eRdmmBx2fJqoBDNvKjWufckWbDUJJuwUsdDoLctMK
         VUz8KjXSvUV09jhFTOVucBOU8bP+6Rj/qXvMSXsKM9pPCoWVTpJsptes7aHLA8QP0EGH
         Yr03NV4WKX2YCp5CECk6Bjw0nNcJ5WnlmWHMrB3RGn8DpJDgdLCFxE9uF3xG/aomtjU8
         GDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Ky7pgVvvF9hLcoAABtSFG13zMfTe+6ohhmnBjH727g=;
        b=XtyJ1bYzcuCde/f/dVj972ufMV/ClXSe0B++WkQiILEYzj7Hdz3OX5YzS0riui3hxz
         mdKxJMGwAJ+q7ZKMdTn2ZBZoTDOuIIz5bVI1wdrqHwPDqQObs6eLu4pQPSU/igTSLjyF
         KuWEFIsMuIi64IoRHU5GRnAXG7Se4scJ13g2Sz8CYRLRtdu84hKqJupF+DJPhsAHZogE
         Q/uFmN7/UwR1Zq7ZFxkQldGwaBJIrxIotao+rXq8PoLoicR83vHB52sqAEBRUc3oG5Xm
         kosn30ClPCf+2luNeNh3AlwHV9n7BLyIg5NCg5yO8eCvnYXtxio+uRSL0iO6L0UEAx/X
         z64w==
X-Gm-Message-State: AA+aEWbY8MyAhcyvk/tpeALo0aiaYHUa3IDGf97F4fAcbv4aatdQM4w8
        EdB1ggAtN1SoigWVv+Sagwg=
X-Google-Smtp-Source: AFSGD/XZNYx2ZnQ0ULXCggr6Tfm83Im0nuTyZ09O2JjFgAMUa2UbKSPGJU0RhePW3s4ea+HzH6fobg==
X-Received: by 2002:a63:1e56:: with SMTP id p22mr10128690pgm.126.1545001783805;
        Sun, 16 Dec 2018 15:09:43 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d18sm13837878pfj.47.2018.12.16.15.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 15:09:42 -0800 (PST)
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
Subject: [PATCH 3/3] PCI: imx6: Make fallthrough comments more consistent
Date:   Sun, 16 Dec 2018 15:09:16 -0800
Message-Id: <20181216230916.22982-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181216230916.22982-1-andrew.smirnov@gmail.com>
References: <20181216230916.22982-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert all fallthrough comments to say "fall through", as well as
modify their placement to the point where the "break" would normally
be.

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
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 59658577e81d..a0510e185d44 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -362,7 +362,8 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 
 	switch (imx6_pcie->variant) {
 	case IMX7D:
-	case IMX8MQ: /* FALLTHROUGH */
+		/* fall through */
+	case IMX8MQ:
 		reset_control_assert(imx6_pcie->pciephy_reset);
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
@@ -415,7 +416,8 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
 		break;
-	case IMX6QP:		/* FALLTHROUGH */
+	case IMX6QP:
+		/* fall through */
 	case IMX6Q:
 		/* power up core phy and enable ref clock */
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
@@ -607,7 +609,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
 				   IMX6SX_GPR12_PCIE_RX_EQ_2);
-		/* FALLTHROUGH */
+		/* fall through */
 	default:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
@@ -731,7 +733,8 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 				   IMX6Q_GPR12_PCIE_CTL_2);
 		break;
 	case IMX7D:
-	case IMX8MQ:		/* FALLTHROUGH */
+		/* fall through */
+	case IMX8MQ:
 		reset_control_deassert(imx6_pcie->apps_reset);
 		break;
 	}
@@ -1076,7 +1079,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		}
 		break;
 	case IMX8MQ:
-	case IMX7D:		/* FALLTHROUGH */
+		/* fall through */
+	case IMX7D:
 		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev,
 									    "pciephy");
 		if (IS_ERR(imx6_pcie->pciephy_reset)) {
-- 
2.19.1

