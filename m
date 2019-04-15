Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCE3C10F14
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB1A20870
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5xfeGdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfDOArg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 14 Apr 2019 20:47:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34758 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfDOArg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Apr 2019 20:47:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so7738637pgq.1;
        Sun, 14 Apr 2019 17:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8E2fKSZnUayyuhXz36lAvp2hLXuQRX96+mjdaNJTzGQ=;
        b=G5xfeGdrcw3arL+TlZ6a++5LDBaK3cSD4NmRGzIyetme2kmjcoie8vW/VU4TGZqTdG
         vTHiG0OcB1Lk1OUuNyyB9aK3aYipsQGMRkmLIT1IYb2vFkuJ03VqyD5HFO2sTipl5ntb
         x700F9TRb8G8KiRjvuLjf2O+9cmosn4bL8Z7VoGAm2VJRmnARUgmxQZ4yk+yg42QHVM8
         fP/+NesX/4jI7mshJThbYu1ZMqCwuvqRldtYc0bZ128AiVraMTA1oqsN4JkxerG+4gkU
         onNklqq9KA/TcAZM5T3rH5XF5pjzjbwXanzi0S9OZdgeeQm249FfxhIzDquhrpDJCqmn
         wY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8E2fKSZnUayyuhXz36lAvp2hLXuQRX96+mjdaNJTzGQ=;
        b=qk4LEHNNPEZUb3qgsnvRHcLonrvECmlRzH0x07CU9evEz6IuZHqTz3u4UkNhGcRwhS
         TXHy64BAY2dB08CDYtUdd7begfFyysNBXl+GdjLZAcGzBzCrf7Aa2Lrc4dDHWJzdD9E0
         v6ep3sgpWo2Zl36jhsaqWS7kS5gEN5d2aokJ3v6JElpkcu9r9V+bMY/IF2ddNL0w3Fre
         ilTtptZ1ED1noUeJ/FnTTsida6L24prfbjbwK5BjDfvPRBk2kMBk5E+CeWgZ5maA1YmK
         w5Z5YQScTsUA1I1pQaeLNuAPhfFTt57NwZBX5qKLK/i3aoyIfqBm4nJCrvBH36z/QdGP
         3k4A==
X-Gm-Message-State: APjAAAVhrl5jGStV3R7dvspdKp3mxbaYMR8EsHhO4q5fRV4vu8hZ+MU+
        khlQNrLwt9xo/+VUNzV8FUvLfCZZ
X-Google-Smtp-Source: APXvYqyDzAo+3+R5otG7RS48KEnbSWMCudgZ/WtqQvqUYkhKGmYoC1bmhbkzIolnAiCraWtJ7ibwQg==
X-Received: by 2002:a62:b61a:: with SMTP id j26mr72645015pff.203.1555289254763;
        Sun, 14 Apr 2019 17:47:34 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id u17sm66111981pfn.19.2019.04.14.17.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 17:47:33 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/11] PCI: imx6: Make use of BIT() in constant definitions
Date:   Sun, 14 Apr 2019 17:46:27 -0700
Message-Id: <20190415004632.5907-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415004632.5907-1-andrew.smirnov@gmail.com>
References: <20190415004632.5907-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Avoid using explicit left shifts and convert various definitions to
use BIT() instead. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-imx6.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index eeacdebd9b50..5650642ab248 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -118,14 +118,14 @@ struct imx6_pcie {
 
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
 
 #define PCIE_PHY_RX_ASIC_OUT 0x100D
 #define PCIE_PHY_RX_ASIC_OUT_VALID	(1 << 0)
@@ -148,8 +148,8 @@ struct imx6_pcie {
 #define PCIE_PHY_CMN_REG26_ATT_MODE	0xBC
 
 #define PHY_RX_OVRD_IN_LO 0x1005
-#define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
-#define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
+#define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
+#define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
 
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
 {
-- 
2.20.1

