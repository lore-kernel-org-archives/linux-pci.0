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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB25C43612
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F2921872
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMiOwlSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfADRuE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:50:04 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37383 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbfADRuD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 12:50:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id c25so17786682pgb.4;
        Fri, 04 Jan 2019 09:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xAm2jIq52pUhEC2sZCasu0hrDgVXQMY4yfjOEAVqYOg=;
        b=mMiOwlSG4DC/Fg65Au78ypOcmntahyb2RvO65PwPALy3W5u+zIqvl1kRo6cjfSVzAG
         C8XGHCWqRYNl3tZReBRxpTWxJHsgA9FDYpLUwN0j/Sb2anz6hfNVplUdlig/rOvq1SaF
         DcCmtLyUiT4k6779xkqnyIFkUNVCu7DnRqHBi1fUBaON/B59O0FHd3m/jvmUv/E68SEL
         v9xEyegM2PTVmL9v1vujXnMfHAM5HEE7lLrxKov2muITiK3+hjPAO/6FpgjgqgwlND65
         Ap9cV8/YvBH1RqnWF0uaaWTbUE/l/HvA/HVnmvPSIG2LKC+D2RBMU4UOtLoN8om3XTKs
         WYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xAm2jIq52pUhEC2sZCasu0hrDgVXQMY4yfjOEAVqYOg=;
        b=ud3HPRizDZFvVf2h71NSwD2uB7ydBO/Yc5+fQsgTtQxW93Tvv0rjpUhwXhI3B+sAZG
         SKQC55TWSCdmZWY3zcOFjocnfPtvStPXMkRAvCSMQ7SIvwLGQBl6vM6wvROwjbU/YONv
         xB9Okl7xUG1mecviXCKEPb7p9m0Vvn8a4gzaFLcNVr8OWSEa0OuN2pjpmIkd0/gCYCfZ
         fwOVqQ1F2aTKRcCffuMTBz6v1aRcj2K2us6nyHslIVz57WxgA4ab2fSBPW1iIs5aSR14
         ZQm5/fhLkJrZbUxV7yfuWnk5QdDzUMBF18Z59mL+q/K0yxmuLmhueTAVkSTelcr+Bc3T
         ukeg==
X-Gm-Message-State: AJcUukf5cPJEpyA+NaVflT2lnxwJeDkciDov2eUyq1Ym+5o4WKS+pvfA
        99Uht1zJY7St51xqDWMRAFRTmT1lttk=
X-Google-Smtp-Source: AFSGD/U8/aliG21Hl9OPuMY8e2lEDtbWolIemfd93+t+jlOoz3jIbHM1T819Xm5vLncIZ0Lj8YKbXA==
X-Received: by 2002:a62:6f88:: with SMTP id k130mr52806398pfc.234.1546624202196;
        Fri, 04 Jan 2019 09:50:02 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 09:50:01 -0800 (PST)
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
Subject: [PATCH v2 11/20] PCI: imx6: Make use of BIT() in constant definitions
Date:   Fri,  4 Jan 2019 09:49:16 -0800
Message-Id: <20190104174925.17153-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Avoid using explicit left shifts and convert various definitions to
use BIT() instead. No functional change intended.

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
 drivers/pci/controller/dwc/pci-imx6.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5e7fab089bde..180ba57da4e8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -112,18 +112,18 @@ struct imx6_pcie {
 
 /* PHY registers (not memory-mapped) */
 #define PCIE_PHY_ATEOVRD			0x10
-#define  PCIE_PHY_ATEOVRD_EN			(0x1 << 2)
+#define  PCIE_PHY_ATEOVRD_EN			BIT(2)
 #define  PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT	0
 #define  PCIE_PHY_ATEOVRD_REF_CLKDIV_MASK	0x1
 
 #define PCIE_PHY_MPLL_OVRD_IN_LO		0x11
 #define  PCIE_PHY_MPLL_MULTIPLIER_SHIFT		2
 #define  PCIE_PHY_MPLL_MULTIPLIER_MASK		0x7f
-#define  PCIE_PHY_MPLL_MULTIPLIER_OVRD		(0x1 << 9)
+#define  PCIE_PHY_MPLL_MULTIPLIER_OVRD		BIT(9)
 
 #define PHY_RX_OVRD_IN_LO 0x1005
-#define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
-#define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
+#define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
+#define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
 
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
 {
-- 
2.20.1

