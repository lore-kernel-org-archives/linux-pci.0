Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4EFC43387
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708DD21903
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIAPuSL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388484AbeLUH2P (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:28:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44230 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388415AbeLUH2O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 02:28:14 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so2172378pfh.11;
        Thu, 20 Dec 2018 23:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ARpz9jknH5H4OT3/qhVId8qmQoNOpINqmDP2FaaZjU=;
        b=NIAPuSL/hJ9VQhEPvORXCppBEwzMPcpOj+Yz1GdpGMptpcWx6R/lfmtmqP52n7x6NE
         Y/jNRWGJhUvcF0oks69JriSQNc4Q6xDTQT6Fjn/VsLFiL+sYTznDXO4g4p27zWTzfudR
         ItnCJqyGMARxqtTyEOSOVdi4pfnje11fMcLawX3vBpuKhfQBlIbmSlcrW/RXPD0xdapR
         I5oFZvehmIFXXCyOFEpl4FbGq7UDdC+bB3/jomelhAUpNK7YMv53b7wV6vsnbMPFqcXJ
         tUM0upyMAiRySpzkZeTtBu6ngv7iKvq5euUG9Fg9pEOWWVtvYw+OGcak7W6Ln9Nhtu2g
         C3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ARpz9jknH5H4OT3/qhVId8qmQoNOpINqmDP2FaaZjU=;
        b=n/7vH4gSIwa6mhyf+SsnV4Dc2aA+N2edmy5AoO1ojQm74ME8KpacPMuqVezw4vd+pX
         /6jgOhUS4EKsKrzZk1q+9J/axgnyGGSS3ag8Rk/AayfmN5YpxGzTzdf8kE7zvDlYSaRG
         dMPuHTD5Xmom8Zvck4bZVw+xbfuW9NSEwyAwUW4UlnoW7xwUiot/7d+6P8vXCNuTY6ta
         pOZafmqBYy4N+8BGNLuFrYwV28KnTT+JKrfxgryUCVQrWSr3r2onQawjoJWjhqgC8lWA
         HqpcbEvbYsVenJqJqV+o5N2+LDa48ni+vWMI4yNqh8IVAukGdmAUcqMmq6a6Phz02CKa
         A2uw==
X-Gm-Message-State: AA+aEWbkuM4I3BbOzehEnuSz3sb0ORY+scFQydHfxM83tTRwmtQj27bA
        h8XYDXjyHGpLK2inkVxgxx4kWrx0
X-Google-Smtp-Source: AFSGD/WHbfSdl51UrygLkZMS8SUXS+WuEQRRNZr7+xB+nhOhArYgwZi+iDHx+rhFP2zfPhYRg/P9+w==
X-Received: by 2002:a62:35c7:: with SMTP id c190mr1466498pfa.76.1545377293403;
        Thu, 20 Dec 2018 23:28:13 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.28.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:28:12 -0800 (PST)
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
Subject: [PATCH 18/21] PCI: imx6: Simplify bit operations in imx6_setup_phy_mpll()
Date:   Thu, 20 Dec 2018 23:27:13 -0800
Message-Id: <20181221072716.29017-19-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Simplify bit operations in imx6_setup_phy_mpll() by using
GENMASK/FIELD_PREP. No functional change intended.

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
 drivers/pci/controller/dwc/pci-imx6.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 38c8e8baa077..678f5fa85e12 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -96,12 +96,10 @@ struct imx6_pcie {
 /* PHY registers (not memory-mapped) */
 #define PCIE_PHY_ATEOVRD			0x10
 #define  PCIE_PHY_ATEOVRD_EN			BIT(2)
-#define  PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT	0
-#define  PCIE_PHY_ATEOVRD_REF_CLKDIV_MASK	0x1
+#define  PCIE_PHY_ATEOVRD_REF_CLKDIV		BIT(0)
 
 #define PCIE_PHY_MPLL_OVRD_IN_LO		0x11
-#define  PCIE_PHY_MPLL_MULTIPLIER_SHIFT		2
-#define  PCIE_PHY_MPLL_MULTIPLIER_MASK		0x7f
+#define  PCIE_PHY_MPLL_MULTIPLIER		GENMASK(8, 2)
 #define  PCIE_PHY_MPLL_MULTIPLIER_OVRD		BIT(9)
 
 #define PHY_RX_OVRD_IN_LO 0x1005
@@ -565,16 +563,14 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 	}
 
 	pcie_phy_read(imx6_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, &val);
-	val &= ~(PCIE_PHY_MPLL_MULTIPLIER_MASK <<
-		 PCIE_PHY_MPLL_MULTIPLIER_SHIFT);
-	val |= mult << PCIE_PHY_MPLL_MULTIPLIER_SHIFT;
+	val &= ~PCIE_PHY_MPLL_MULTIPLIER;
+	val |= FIELD_PREP(PCIE_PHY_MPLL_MULTIPLIER, mult);
 	val |= PCIE_PHY_MPLL_MULTIPLIER_OVRD;
 	pcie_phy_write(imx6_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, val);
 
 	pcie_phy_read(imx6_pcie, PCIE_PHY_ATEOVRD, &val);
-	val &= ~(PCIE_PHY_ATEOVRD_REF_CLKDIV_MASK <<
-		 PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT);
-	val |= div << PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT;
+	val &= ~PCIE_PHY_ATEOVRD_REF_CLKDIV;
+	val |= FIELD_PREP(PCIE_PHY_ATEOVRD_REF_CLKDIV, div);
 	val |= PCIE_PHY_ATEOVRD_EN;
 	pcie_phy_write(imx6_pcie, PCIE_PHY_ATEOVRD, val);
 
-- 
2.19.1

