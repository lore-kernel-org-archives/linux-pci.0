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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876D0C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594FD21872
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbIy6QxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfADRvQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:51:16 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40971 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbfADRuH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 12:50:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so18619287pfi.8;
        Fri, 04 Jan 2019 09:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GIZtkIt7F6fxURYaK6v1S5ghisv1YvKa7oaIjfa51B4=;
        b=RbIy6QxQ4n6nLxPbvAynBbX8pf4uJ3NYcuGkNvB7KF8kscdYTdyKmRtNArPL2pDcSA
         iTQhHQ0y01l4EQ1Vi1g8EdSB2ORRoI4qVgtOEehGATgzveaMve0i3uvUkyGua+1impAp
         z7wVNs9/xNj8ZRp8BHTrPX8jVaXgc6ilSMzKjB4ME2ibriLmPWbzbnO9Xod9UH7Qp+rm
         jSFg706OlVopTyG8KdrTFVkQ1FHKblrb7x9YtVpMng5TTL5DXnpvRhjoBSk54mgJ9RxT
         gDjcfNdR41pZHNcgY0/EKccsyg0FEXnUE4Fr4FlSaHVfotexHSoyh2V5rLKFH7VaNZCa
         6jcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GIZtkIt7F6fxURYaK6v1S5ghisv1YvKa7oaIjfa51B4=;
        b=TXQizBm74AUlBurzzq8IMCk8H2w1iGUz24H6MiYsVJKQ02B9EcSI7YOGnpXUAMeRW7
         K+cuRHv7Rk6BMPsMebrqsqA6AaRfB+vj0DQGePGBc1X0Zk5R5eL2JiWL16JhFBzROLlA
         6pJIoiDOaVaminS5tqerkCZ06DM/saLUi5Kqd3NTWHDz529L6VAfRHR18PqjSGyUxe2k
         LY/EnYUSSLmYK6PNzbgwvGLdXrucYk+etqYBAAV74/w+3YtaJCXm9umZgmQ5Q/VAJ46f
         V5Nrscso2W/scTijWpOQCRV4rsp2ahAn7Y9GU+fxyrFE3msAtcklEyAHzf/7iaVIlrrz
         5KgA==
X-Gm-Message-State: AJcUukfTvf0p2HCPPzPuO4eiyu3iLeA9qtzEXL41n+CvFogfN9iiFsaM
        jTsdsBBZll11dF1a/NOsYPRPZa50bTs=
X-Google-Smtp-Source: ALg8bN5jrhYevzmE+NEUJvgXp4+NCs5ehGhkPFepwPChUleu0X3pnfm/f5l65XdV6q4QeM5GgnVf9g==
X-Received: by 2002:a63:3703:: with SMTP id e3mr2397705pga.348.1546624205986;
        Fri, 04 Jan 2019 09:50:05 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 09:50:05 -0800 (PST)
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
Subject: [PATCH v2 13/20] PCI: imx6: Simplify pcie_phy_poll_ack()
Date:   Fri,  4 Jan 2019 09:49:18 -0800
Message-Id: <20190104174925.17153-14-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
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
index 672332483324..2a7075a9cba6 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -108,7 +108,7 @@ struct imx6_pcie {
 #define PCIE_PHY_CTRL_RD		BIT(19)
 
 #define PCIE_PHY_STAT (PL_OFFSET + 0x110)
-#define PCIE_PHY_STAT_ACK_LOC 16
+#define PCIE_PHY_STAT_ACK		BIT(16)
 
 /* PHY registers (not memory-mapped) */
 #define PCIE_PHY_ATEOVRD			0x10
@@ -125,16 +125,16 @@ struct imx6_pcie {
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

