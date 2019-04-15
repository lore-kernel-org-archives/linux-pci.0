Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B160C10F13
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1497820850
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlQAvIA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDOAr3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 14 Apr 2019 20:47:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43421 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfDOAr3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Apr 2019 20:47:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so7696905pfd.10;
        Sun, 14 Apr 2019 17:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ViVmupe5SgRSeZM1zRYXRJzTPlsKO2l+aVu7kqlxatY=;
        b=JlQAvIA9pt6NOCDRiqJXaJC8iDQVv4OdO9RlBdaREdFG6CBDsHikcZom6DrqoQeBY9
         U61+MQw0j2GI0J3R6JG0XfDOP3xMZBtqC/klOHysSDEriq4uPZAEvIuSRgptJg1QwNOy
         Asl6N2OvUK/oLq0wsKZ8HpsbxNM7i9XRxlG++P6sbQ4tooVnlHpMLPrRprMZ6KMOlFqs
         Tis+mmAUZyV4+2srUvxfQUQAZqcX+6dSpwnykEX4wxzhPwAIVtJ51ZrfiN26+fF9G/p1
         zG1b0zZzQeX5OcUEsORHtKB9qPjWHFNeaOwdN68sW103T+rYcptHZk74OPXw2LsMuS76
         5YLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ViVmupe5SgRSeZM1zRYXRJzTPlsKO2l+aVu7kqlxatY=;
        b=m7ipAvgNMTGKYy09ireM9XQtBAoppZUUDanNC4FrwhXughhNz7vSwHbNnYygT9l8CA
         UjAv/s2HtfijIzDq/vcueqW80wYc5R4eLKisXd2Y0d9d9aUdApTs4Fnt6HAUdVnpLQrm
         kKfy5XroNydcR6fFhOLJywCLiAioqV0SC4HlQ7dpCrvVS+Nk6H+MOrFSpJjZgr3qnQC7
         sNDvXOUIYMPx4PHAr3l2dM1TDX6mE2gL6nTGYyh5accy/OURvuZHMQHX38CtMRp5ydi7
         ow5igK1w7SYBEqcZl+CHR1q1StjOdo1/sXPS8o+aE/0/bgHlRnBy6E0bPiGzMBlRhKE5
         4yLA==
X-Gm-Message-State: APjAAAUe0gHtpwO28urXXDonr+0oLHhyOxCoEJ2LFi21Uz/zsKbIZSYY
        RAs/2rvR8A2th9osF7NqwOQ3cmze
X-Google-Smtp-Source: APXvYqx8nC0z5GM5dQYPF8OiBO2vQYfluJMtmWdbKpd3utkYSJFxrERzsojaxRaK0XqfRqCWDAyKTw==
X-Received: by 2002:a65:4108:: with SMTP id w8mr66630581pgp.236.1555289248042;
        Sun, 14 Apr 2019 17:47:28 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id u17sm66111981pfn.19.2019.04.14.17.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 17:47:26 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/11] PCI: imx6: Simplify imx7d_pcie_wait_for_phy_pll_lock()
Date:   Sun, 14 Apr 2019 17:46:22 -0700
Message-Id: <20190415004632.5907-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415004632.5907-1-andrew.smirnov@gmail.com>
References: <20190415004632.5907-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make use of regmap_read_poll_timeout() to simplify
imx7d_pcie_wait_for_phy_pll_lock(). No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-imx6.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 3d627f94a166..ea2617712a3b 100644
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

