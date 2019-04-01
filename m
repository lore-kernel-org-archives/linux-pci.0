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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDC4C43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D45B20879
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk/se5en"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDAE0e (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:26:34 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46571 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731623AbfDAE0M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 00:26:12 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so3807334pll.13;
        Sun, 31 Mar 2019 21:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M15SSsqswOiwxhWnX177mGnZWvforApyHb7iTG1lMyk=;
        b=Kk/se5en2Sz3Z9ozRJsvt0DDkH163RP+1KxrChuxNkDXtcI+ornsyrIb4FUeqE38mk
         3lyTAPSM7qKKdFLKAy2FDY0jCGNenhwMhQDXUBbli59hxBATipLzGsqFgFYiylgcocJ6
         mPd5s6jXuTiQeRx7+Jox1XXFa8lKRLECwvaF8ZVRsoccXRnyClyMQMasd/v+dGVWkeSn
         HzN+ivz8pEH8LnwbAwmjn0rqNW8Hy3jCXibBk66JbSrRdx47x2vLsjzrMnUgw9wHN0EC
         8BUPNdiqlgJsxZprTWRa7lpU/2yxEfZ4j5gNvnJmFjj/MV6WJTAwdfDpilhOMTsgyFKs
         lyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M15SSsqswOiwxhWnX177mGnZWvforApyHb7iTG1lMyk=;
        b=Y+V3mwO2fd5O/IOxBTr+IpS1VQZfpW4j4wDC+UJps+qDOL0nbOMPHkN3oE0aaLIjr6
         DlPfs0lT/vtvIefGNuMT+LxkJ7IdXrWSE64peWkkqpHZsyECSYQ5buJYrYoRWIuPVTDo
         3K2q+iMpChwa99D8gZavRGhjZgF91a9HB6keaZ0XEG/CrcNHBlT/H6hCSh/Yoeaw5pZU
         gPyc92a7OornfAyVTp7wj1p80ZXSWz8UxK377Mmhm3VOs47C2g0l0DGnJtqt69c+8rSi
         0tF1jhnlpu4YO5BBjxUQ6kx5Du+xwLBcgXHxTxTHf7LZHXv7qt2RQSJ9WL9C/w0eYDjn
         8dtw==
X-Gm-Message-State: APjAAAWTxcrgftskZ+VARzCGfN4011zETSl4LDp+yCY1l/HZWI06U7NA
        vNIMe/FRyN6ejsDlDSdMklDQRS82
X-Google-Smtp-Source: APXvYqwq3u5r+Nbh207nAuIiYhD64NsYeBWNELTtxBIqjDwvuAxTG6ibbn9YVdv+6ZQQsuUtGcbK9A==
X-Received: by 2002:a17:902:e90b:: with SMTP id cs11mr3464210plb.243.1554092771562;
        Sun, 31 Mar 2019 21:26:11 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t22sm10996829pgu.45.2019.03.31.21.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:26:10 -0700 (PDT)
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
Subject: [PATCH v3 08/11] PCI: imx6: Simplify pcie_phy_poll_ack()
Date:   Sun, 31 Mar 2019 21:25:44 -0700
Message-Id: <20190401042547.14067-9-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401042547.14067-1-andrew.smirnov@gmail.com>
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Simplify pcie_phy_poll_ack() by incorporating shifting into constant
definition and convert the code to use 'bool'. No functional change
intended.

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
 drivers/pci/controller/dwc/pci-imx6.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index a49e5e491e12..7c3ffb751002 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -112,7 +112,7 @@ struct imx6_pcie {
 #define PCIE_PHY_CTRL_RD		BIT(19)
 
 #define PCIE_PHY_STAT (PL_OFFSET + 0x110)
-#define PCIE_PHY_STAT_ACK_LOC 16
+#define PCIE_PHY_STAT_ACK		BIT(16)
 
 #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
 
@@ -151,16 +151,16 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
 
-static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
+static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
-	u32 val;
+	bool val;
 	u32 max_iterations = 10;
 	u32 wait_counter = 0;
 
 	do {
-		val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
-		val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
+		val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT) &
+			PCIE_PHY_STAT_ACK;
 		wait_counter++;
 
 		if (val == exp_val)
-- 
2.20.1

