Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C11C43387
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98AF21906
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9Auu21d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388032AbeLUH2D (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:28:03 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41649 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387982AbeLUH2C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 02:28:02 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so2104920plm.8;
        Thu, 20 Dec 2018 23:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TqYCFphTE89qwX5r9RN/jgIceUrAGJyLboLH1gjiqTU=;
        b=T9Auu21dO+fPpRqohnW/C+5tSklOBK/DUBX20FiVnu8xHc0T/An1rBo5B2i+ENO0+N
         gipONMVohHBbWbt4wqeDEZa4gB0NGELCRQZA4INafJ7EntVQy4Kf5WIb54oCOT+Ct3yI
         pu2UFPnDwqLo2DgBb1qi9z1wmJ+1sUbJtsCCeROo4OC4DrB3Y8iwJqiEvshv5sg/sxvG
         XOy3AuJ6oDQwNGR9hm3NmGGspi4kgJP4lPAMfnB/ZunBOlmuoX+cC4M32WlLoeYOAGPd
         swEszRp5rZxwIRTzF5N81LYeL4jiPmy0shs30vcTC9bqaYnp3DZ2DmfkY3uH3/DrY0iF
         fgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TqYCFphTE89qwX5r9RN/jgIceUrAGJyLboLH1gjiqTU=;
        b=C/uQo3rgUDsdex5Q3RtNQ5EiVYF/Wpcnl7zRcW/rT9MFKSbZZW8t2sOllyxT09pXa4
         FQWLI3jyyaQpM0zc2jVj6tYCwGEKZ1239rv81UDChg4YJ5nADxqjTWIzzZxtDiPila5B
         UiMb5KB39OcACNJkYj21ZTiWa9oEvFGjl1pqwDbXkgNX00hL76+cxLiDiDBBnT66icjk
         AGzkO8IBubaS0a3Q56ZktDCpxniY7oe4hue6gbKH3HuZ35HGq4R33GRU6COx5mTK24uq
         3mnN6Wxhhu+6Vykc9BmO2WY8nfPyHytc/NFyXCT5Js7GMjvm4ymeUJ8NFhqn/T2nbsa8
         Mhfw==
X-Gm-Message-State: AJcUukdxB4ajHYT6sj1tJmwsmp0Ycec19QlwQZ5QM5RcngRacSuMH1+G
        4pw+aLkvHR/WM+kYXW4tj5tv5e9u
X-Google-Smtp-Source: ALg8bN7VFNOfyipcRVN4uHadck2NF4rcy2dCIULEnDmBnNnp6tn/CxUmIVmP48c7+xPdGJUmJd7jdg==
X-Received: by 2002:a17:902:9b93:: with SMTP id y19mr1437738plp.336.1545377281678;
        Thu, 20 Dec 2018 23:28:01 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:28:00 -0800 (PST)
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
Subject: [PATCH 12/21] PCI: imx6: Make use of BIT() in constant definitions
Date:   Thu, 20 Dec 2018 23:27:07 -0800
Message-Id: <20181221072716.29017-13-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
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
index c0b073cf20c0..2737526158fa 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -95,18 +95,18 @@ struct imx6_pcie {
 
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
2.19.1

