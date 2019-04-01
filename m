Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23283C43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AF320870
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkFyuQqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfDAE0C (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:26:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45168 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfDAE0C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 00:26:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id bf11so3804930plb.12;
        Sun, 31 Mar 2019 21:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9lh2H/6g5jBbi6IngiMFn0hLKnDUr/9F5dB06DXbVl8=;
        b=mkFyuQqc67MMHTIgJJyZ3+5FCf97MK+MCJJde3c4fvPP9R0wzD+WU09igJNyqLJbpE
         NQkiNtUCciSKNlCdFMGz9H8OOfxMjI3g9aSyczXB0WLVY+NbY5HBvTg0NTZbWsX8xHhi
         a2bxAa+mfh8L8CHdOYaqhfJnaBtJUJzHGpBxZyG4h72JFLoorc0YB8nWnA/2VuV9ADq3
         bTu6HJZ2AVu2ufGtJGI2xdmBobTXb35zMfTxXzshkhyoX1bArrvrGJsw5EVa/iTEGqvp
         5DoE5AyvbN3HQbrx2R2ucoKKhVQbpDmiMiozWO7FNN63cA+nOm/ScbBzRNWn+KoDV+H9
         AyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9lh2H/6g5jBbi6IngiMFn0hLKnDUr/9F5dB06DXbVl8=;
        b=cvkLG5kDQ65I9ijG/3g7oX81YacsIy2VxlGkPAZWMobnZJLwmUCzhs40EgmACj6tZG
         FgmyD9SG7WpLbq64/R40zU6YRWK8Cqrv90NJjx3S+1Odev7cAURk0x1swh4rfIQD7N47
         dW7ueEc4EQNZPZS/NoZOw4Sa+nvuEzZ/caKaPEGPw/dj8ttDofXPZHZYYD0uI1DeleLG
         XZaSqlSQ8LP+vSLJyx1edNtQj0XM5XJhGRWSRsifpbxpXpWtZalWNM1cjHfsTxc4/NJ9
         ryJr8GSyklwbk3Mtp7d8E8sGKpwXHfeqtQaMCEBRlOjC9GsscKhH9RoHRaXkK4JZUdN5
         fm9Q==
X-Gm-Message-State: APjAAAVI3BVmkmjJZlUyzY2VXDfFcIshUnQvu+lBbJEWMbx8Brzlx6Lk
        LvqZ+qrhhXdYlUn5HZlWSR1G+GR0
X-Google-Smtp-Source: APXvYqxSB7+e3gFaCzu0rvu02ORh1qy0wI09Zfrn2l5rMxegtyN5WyS5gC7XMT60Ya2Epy0acP9aow==
X-Received: by 2002:a17:902:a513:: with SMTP id s19mr10169288plq.97.1554092760719;
        Sun, 31 Mar 2019 21:26:00 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t22sm10996829pgu.45.2019.03.31.21.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:25:59 -0700 (PDT)
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
Subject: [PATCH v3 01/11] PCI: imx6: Simplify imx7d_pcie_wait_for_phy_pll_lock()
Date:   Sun, 31 Mar 2019 21:25:37 -0700
Message-Id: <20190401042547.14067-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401042547.14067-1-andrew.smirnov@gmail.com>
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
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
index 2eb39d5de4f6..fb0b29e5b1f0 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -89,9 +89,8 @@ struct imx6_pcie {
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
-#define PHY_PLL_LOCK_WAIT_MAX_RETRIES	2000
-#define PHY_PLL_LOCK_WAIT_USLEEP_MIN	50
 #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
+#define PHY_PLL_LOCK_WAIT_TIMEOUT	(2000 * PHY_PLL_LOCK_WAIT_USLEEP_MAX)
 
 /* PCIe Root Complex registers (memory-mapped) */
 #define PCIE_RC_IMX6_MSI_CAP			0x50
@@ -488,20 +487,14 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
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

