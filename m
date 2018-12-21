Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CB3C43387
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692A821906
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWKr5iYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbeLUH1p (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:27:45 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33279 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730788AbeLUH1m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 02:27:42 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so2121723plo.0;
        Thu, 20 Dec 2018 23:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hVVP0IYzly0vMq5I85m0FEXZqGuHFqhL3TgllfB/KdA=;
        b=jWKr5iYU9+2g6DtIQu8snbJTc9PNoAsCGi1RT8t3Pz7KQSHl6HNF77Qo21gyyeLUng
         AzPkU3n6zaQZyTEzdTbDl+pcsFL9TPECklIiWSpFMr1vxEfP1g3SttLUV5/cN1nRJVcp
         5v4prI5j6rTWUwhyemQ/VTQGYRRw7iap1KO/CXAt+NxDA90L6OF0f808MsGtEJe+YKMS
         UP7hbezFpqaOEvKo7zz2VaXqpnF7lKdrLD4Do6Hj3nYMIe4nMu2wi1ijsBzE2xu6fJC/
         gpTCv62SYB173S5alFQFat7CMOKIB7USTR/0E4W9olZuLCh8xffJu+hYo4YlxH8dxk3k
         UTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hVVP0IYzly0vMq5I85m0FEXZqGuHFqhL3TgllfB/KdA=;
        b=ofr/KLexvbn5JYTQ90zwbWb31IzEr3UHWL+t2uqrIN2STrZ4MBSbBkBvvEdFClMloY
         sQRN/VhliSDBxLvbZLv2k0jD52XykQtlWuLIEjWO0UT3AFhmORNLhEDRoPQrcsZvAHyQ
         tyrU4ee0yu5dh0HeYXbGXYhmU+2r+GGuikDhxlmimhyKkZ9BrClT9rRGk0XoK1AFy19n
         SSniX9DQ7GN8oW1c8L14ogAGvdcvNwBDwcXsc8v7geagNZYiJGyjL0GZHg5SDrNS3ZwX
         UjLimwI7eIYrS1OYKx4+KPatDXI33Z43PJFzikwDbJU/sEyKouIQwlr+aPAnT+cttOPn
         mAyg==
X-Gm-Message-State: AJcUukcJMsNkkjbOKDXsdn0HBYTigaG2vLJCbLQbihVKJNH1/p0Cilce
        bKM6pyvgkJsNXTrld7iFnWk/eovA
X-Google-Smtp-Source: ALg8bN6J5cKmyuuAHi7yPnlOzdegH1xGaUvuu41+zv9Bkm4p3XWirADGk2+fC1OIgNE/+wBOtr3hAQ==
X-Received: by 2002:a17:902:654a:: with SMTP id d10mr1401337pln.324.1545377261015;
        Thu, 20 Dec 2018 23:27:41 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:27:40 -0800 (PST)
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
Subject: [PATCH 01/21] PCI: imx6: Simplify imx7d_pcie_wait_for_phy_pll_lock()
Date:   Thu, 20 Dec 2018 23:26:56 -0800
Message-Id: <20181221072716.29017-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
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
index 26087b3da590..c87ecc305dc7 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -69,9 +69,8 @@ struct imx6_pcie {
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
-#define PHY_PLL_LOCK_WAIT_MAX_RETRIES	2000
-#define PHY_PLL_LOCK_WAIT_USLEEP_MIN	50
 #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
+#define PHY_PLL_LOCK_WAIT_TIMEOUT	(2000 * PHY_PLL_LOCK_WAIT_USLEEP_MAX)
 
 /* PCIe Root Complex registers (memory-mapped) */
 #define PCIE_RC_LCR				0x7c
@@ -418,20 +417,14 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
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
2.19.1

