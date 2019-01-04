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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D67EC43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD3A21872
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIQDFnbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfADRtx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:49:53 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46376 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbfADRtw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 12:49:52 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so17760159pgp.13;
        Fri, 04 Jan 2019 09:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3VOwOJYTEi9UR4UgeiKLcvLz0osJ4eyuFQfv798N0kw=;
        b=cIQDFnbbZQ7zun0bPoYcKlx4CAsV3EdWh8sQLP0WqF9Y45of71SulNq2FVC8xni2F0
         NW7GmTzooeTKpkIuN/g2s879lKeRldJQNhRxB0FpP7j+m9mBmZSSyHklkczn+yfZI6Xz
         BWjQl6TtJNNh964Grs9JFAUqrD7oAmW5nRJ2vasVyDn0pnMm4PgKlkEXdSLibNVdsi8w
         9xQEhxC6V6KwlpXt+wbL7QbIigPIGkuTpl8zWtYUvmupl+q4L2ENNZE7OMPHDlWdDH+7
         Ekno1l0RTMm69qLLs6FPaiUl5Zamvg+3jST6R9lJMWCOY0AGyEIR4DZahVRmpH7z1jlw
         Ww+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3VOwOJYTEi9UR4UgeiKLcvLz0osJ4eyuFQfv798N0kw=;
        b=Wf0ZmAqFNOlb0ADZX9nJ+59HSrMG+PdHTFlXp+VUZHfoh0OGyJ2bfWuIzjpPkfeluE
         ZXGwBp9/VtG7I2rImPH7qFLwO2+v4fQgg+1jgbyGzAssMpdtvAsTpqsQlufMLUhUSkVZ
         Nve+5TSE38oiUwei6h1tPHnQa/6LSnrx7vP/9h+WxHX4/r14PBMA3KYrTNV+Fj+5U58n
         WZHSKQ66dFhBYZ+d/fpFMj5nkM19mMdVakHpt8tSOcQ7XLEkeZZLZ+N7kTf4R1v+OtDy
         8ElVT9nkpORAP3Y1BE+IKKaPIZqOVZPq79ASUXQpSLHbsIyq10H8PuXKEUH6ybRVX/Yg
         Z/YQ==
X-Gm-Message-State: AJcUuke5cXHH+bFDZwDL7q04PlapwJjCmpq3DNBZ6DeB3NS9DIZoXDOV
        Ey9vloWQlTqX/OIvLrHoKWhwoZND+8A=
X-Google-Smtp-Source: ALg8bN63AGT6KHsPf4+9iTaT+C2aMgpdrT4E6ZaEu9GWtQHOwSDB5//W1Fa3tk9pOsUCFndg/m44ow==
X-Received: by 2002:a63:1904:: with SMTP id z4mr2364785pgl.135.1546624191241;
        Fri, 04 Jan 2019 09:49:51 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 09:49:50 -0800 (PST)
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
Subject: [PATCH v2 06/20] PCI: imx6: Remove PCIE_PHY_RX_ASIC_OUT* constants
Date:   Fri,  4 Jan 2019 09:49:11 -0800
Message-Id: <20190104174925.17153-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Code using these constants was removed in commit a77c5422d758 ("PCI:
imx6: Remove broken Gen2 workaround"). No functional change intended.

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
 drivers/pci/controller/dwc/pci-imx6.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index a7192b9e0e71..282b09076fea 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -123,9 +123,6 @@ struct imx6_pcie {
 #define  PCIE_PHY_MPLL_MULTIPLIER_MASK		0x7f
 #define  PCIE_PHY_MPLL_MULTIPLIER_OVRD		(0x1 << 9)
 
-#define PCIE_PHY_RX_ASIC_OUT 0x100D
-#define PCIE_PHY_RX_ASIC_OUT_VALID	(1 << 0)
-
 #define PHY_RX_OVRD_IN_LO 0x1005
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
-- 
2.20.1

