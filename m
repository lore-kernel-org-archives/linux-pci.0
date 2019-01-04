Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C339C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3416921872
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKAjY0PK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfADRtn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:49:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35682 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfADRtm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 12:49:42 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so18624653pfi.2;
        Fri, 04 Jan 2019 09:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SKJa7zEhO/trHQqEjEW1IcZtpd/PYQwbclM+tRkTBpo=;
        b=oKAjY0PKvzJmTqSAvtXWedrQvqbliB4L1vI4Hhc5nAPWIqnFLyUoscPOLjJIvzMusj
         4vdIm1sPATs5dxmZryGBlgT1rclkEmznR08UXj1BblyRl3P8bNjQElqb/jyaSSBZzXok
         ipoWetngUFR/b3oT9yLNp1UQYB9Ba7qUQB8ldTW+pU2dHJ0V9DNdAJavyz464ViB0qB5
         RvTpZzPKPUoUSxwbDHNi2iH3FM6quo7QV/zd3UAJhHj4K5cF+hErydcWKT4YApELfhSD
         0KlF/1jY5WiHsQPIBEht2JkAa2F0MLDKRNUNsbPFSffS26/BAvDxYFdY9oS4UXrU5uI/
         PPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SKJa7zEhO/trHQqEjEW1IcZtpd/PYQwbclM+tRkTBpo=;
        b=Yr7xs/u//WQc15dgDHlfeFwx30SiGRAmXPkmFEOeNq5kb7kl+ujtjrzMNNHk4b2K6a
         7S1TiRxwdTLNS9+upo7+vMiFjaU3rxAPi1gKFznJHKtD4HYUXcHIbR8Yk7lv7N8+kr/o
         IUQy7/dORHOYhRyeW2HgXQmv6S5YzuyK93UPSZdgIkqosnuCEIYs46k6R/tx2Z+URe/2
         Nu71IyP8hN9mpGiuFcxSOxnl2A/afwZYq4eYbRm8Zp9LIOYjOOOsGpRRkO7XZlqRDlNG
         5oMABNCKfFgOzExx3qoICOy/o6jPXUjVkoNg59rm/sYjTNNbGa40NbqQrd8THo1XMC/m
         aDHA==
X-Gm-Message-State: AJcUukfnmFcuE/CURy7zmM1/JaS9s552yVpLRYdaExRKinkoFqjkBXo0
        Cruio/e/hAxQWAGgGL6sYp1GGnKJE/o=
X-Google-Smtp-Source: ALg8bN5QBpDrJLeoSdKMrCQL9CbxLzeC6h/BT2qr3lg4ES+HltYQyU/0jZrnnT77QyM+EIwTAaS3KA==
X-Received: by 2002:a63:a401:: with SMTP id c1mr2443713pgf.403.1546624181277;
        Fri, 04 Jan 2019 09:49:41 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 09:49:40 -0800 (PST)
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
Subject: [PATCH v2 01/20] PCI: imx6: Simplify imx7d_pcie_wait_for_phy_pll_lock()
Date:   Fri,  4 Jan 2019 09:49:06 -0800
Message-Id: <20190104174925.17153-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make use of regmap_read_poll_timeout() to simplify
imx7d_pcie_wait_for_phy_pll_lock(). No functional change intended.

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
 drivers/pci/controller/dwc/pci-imx6.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4380ee797c04..c73c7a6a4c55 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -86,9 +86,8 @@ struct imx6_pcie {
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
-#define PHY_PLL_LOCK_WAIT_MAX_RETRIES	2000
-#define PHY_PLL_LOCK_WAIT_USLEEP_MIN	50
 #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
+#define PHY_PLL_LOCK_WAIT_TIMEOUT	(2000 * PHY_PLL_LOCK_WAIT_USLEEP_MAX)
 
 /* PCIe Root Complex registers (memory-mapped) */
 #define PCIE_RC_LCR				0x7c
@@ -459,20 +458,14 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
 {
 	u32 val;
-	unsigned int retries;
 	struct device *dev = imx6_pcie->pci->dev;
 
-	for (retries = 0; retries < PHY_PLL_LOCK_WAIT_MAX_RETRIES; retries++) {
-		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR22, &val);
-
-		if (val & IMX7D_GPR22_PCIE_PHY_PLL_LOCKED)
-			return;
-
-		usleep_range(PHY_PLL_LOCK_WAIT_USLEEP_MIN,
-			     PHY_PLL_LOCK_WAIT_USLEEP_MAX);
-	}
-
-	dev_err(dev, "PCIe PLL lock timeout\n");
+	if (regmap_read_poll_timeout(imx6_pcie->iomuxc_gpr,
+				     IOMUXC_GPR22, val,
+				     val & IMX7D_GPR22_PCIE_PHY_PLL_LOCKED,
+				     PHY_PLL_LOCK_WAIT_USLEEP_MAX,
+				     PHY_PLL_LOCK_WAIT_TIMEOUT))
+		dev_err(dev, "PCIe PLL lock timeout\n");
 }
 
 static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
-- 
2.20.1

