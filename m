Return-Path: <SRS0=yfZz=N4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26C3C43441
	for <linux-pci@archiver.kernel.org>; Sat, 17 Nov 2018 18:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBB220817
	for <linux-pci@archiver.kernel.org>; Sat, 17 Nov 2018 18:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U15FXuPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBB220817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbeKREaE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 17 Nov 2018 23:30:04 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35200 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeKREaE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Nov 2018 23:30:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id 32-v6so12010273pgu.2;
        Sat, 17 Nov 2018 10:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CoWFU1/M/sA4Uua5q8QjmehvJJkUh/dgmdZgvo6IB4o=;
        b=U15FXuPyYjgm74usoStLKy0hs6jJwJvgfqtfFuDvP/TckaFJPVhw6ZDGuKGdfGgcl7
         OCqyIE+elzhziy/3/rcKgCwqXUQXNNt1dylLTJlPcCWdLoPHWYzD76JTHpvVebbHyBXG
         VAzmYnwkkl8Ck4zRjwYpECAHVCYrzYUQH2Jx5FRmcSqxg2QNITziQhxJlyAkjU/GocX7
         PVhpsRqGmzB0QXuh36se/DHqZUxvnAavZGXP5YNju/l9FT4kknSbbcmkLp7kHgiFoEOY
         gQ4l6OIRZMk3QKXMxswsd9IEWmAixpDhxGXvFyramGlQdhCeWwvRv8G5DmuQTSPdNxLB
         49bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CoWFU1/M/sA4Uua5q8QjmehvJJkUh/dgmdZgvo6IB4o=;
        b=pMf9I2IbInn8m55xkZwTQBQjGRjxqY9G45dM5NUxKMZ+1OpmrdlidJv/fYFcblukSj
         FNx21yN6A8gXP65NrU+gtHEJkmsTf3BbqJ4z3CUbX7E5WZ/o6Y2a++73yzNDY8rgsoG/
         7+pI9TMVQWwPSQfYjiGCAeSYQm7xVarofk6sOWPiHwtxGE2YB1DzL7KdW7UM9BFxSDEe
         oScyDUs/DGo7QdYMn+ulO2cJipAVUWIlfo7XeO6HiY4s8gXzkl/7P/ooIVwC47VU0vez
         bUptmMq7tJWISr2l5GsrbqS08QR5Ukxafg0DzTfl7+nzPD0Jh7KSsO/RbX/UFaTkkkGz
         Rdwg==
X-Gm-Message-State: AGRZ1gIa/Bj88kdqU/yzdTKgLz/YIIvAl0up9ldfvJxIqSEwF00+7nBw
        495ohFvcKafLs5VFTdOicwqPG2ddPJY=
X-Google-Smtp-Source: AJdET5fM/iP+NFCY8lZwmVr07B9Ax31Kxyn0cj5vonUZ+0XPeS++u1xDpnuQEs1nxnB53ovmLPgoGQ==
X-Received: by 2002:a63:8043:: with SMTP id j64mr14596108pgd.405.1542478354918;
        Sat, 17 Nov 2018 10:12:34 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t2sm13868196pfm.32.2018.11.17.10.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 10:12:34 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>, bhelgaas@google.com,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH 2/3] PCI: imx: No-op imx6_pcie_reset_phy() on i.MX7D
Date:   Sat, 17 Nov 2018 10:12:24 -0800
Message-Id: <20181117181225.10737-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181117181225.10737-1-andrew.smirnov@gmail.com>
References: <20181117181225.10737-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIE PHY IP block on i.MX7D differs from the one used on i.MX6 family,
so none of the code in current implementation of imx6_pcie_reset_phy()
is applicable.

Cc: bhelgaas@google.com
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy@gmail.com
Cc: l.stach@pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c140f7987598..3c3002861d25 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -245,6 +245,9 @@ static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
 	u32 tmp;
 
+	if (imx6_pcie->variant == IMX7D)
+		return;
+
 	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
 	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
 		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
-- 
2.19.1

