Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E76C43387
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE7121903
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0RQ48qV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732661AbeLUH1o (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:27:44 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44531 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732605AbeLUH1o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 02:27:44 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so2099655pgr.11;
        Thu, 20 Dec 2018 23:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ztf5h/VWPT7ArQCZI10FTS3FX1Is4iZLXtzrxnewglA=;
        b=Z0RQ48qVC17QilVa8yi3aGpnZwguKR/WyE+4MBjNXYtoiFkEn3DbOkzl8eTrDH8SrC
         hJxXDFDktmaS/zbBB7u4k4n89JoZKkbpYgQpZ0x8yEWuP+8XT9bZudbtFTtRBq1Nj4k4
         q98upDxxo743ASCAc0YT6fzWT6US+YxYF/TmvELJXb1oNidOjrDrU9sDCceGlgxfThCw
         RePdxCZi4zJC+0ftJoX8+WDBYlZ23u8Z3mt/pA0mLyqp7DHFWYYzRmUWTHmYPZZuPvNk
         diXoM5kSofwsbhYNkV8FmyIQzIhmnu7lH0P/NhWmVTh+RP56PJtGN5SwEohDLdQgYU7g
         hp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ztf5h/VWPT7ArQCZI10FTS3FX1Is4iZLXtzrxnewglA=;
        b=rYwIKNHezRtQP6lPpw4QDcgrJPfKU3/AHfoPgBs0kb6F6dgG2jnvATT155kBrfXRos
         t2yMy1IGl7RV3ufZlk9T3WspfbSB2XM7Y/mU6AMLVEk7uCF57nM9CK2C7SwHqhTa4/Ab
         NNHBXmxRliPwHOXUL3kFO9U7WEZ/htQAYyCNjsQKD7rN7VyyJ1IwIOVGho9ZrcufTZAI
         IRjrK4NaRfwE8lCuN5pTkyA4hE5lcNSW/SnNpByldivhMBj9w/qNCzYyhqhrZFLcumHo
         ws1z8Mi4GwgMhQmOOC9/jQOTc/zmCT3zHxdTowzLkvgRetjBHKisDN/idxs0u/Hi0sH8
         8BVA==
X-Gm-Message-State: AJcUukdQhkdFS4R8UfjCH03FyldL7+zM+4Hpjqy1WRNDiYU25ri/LiDH
        CiSWXyFjz4hlEf1hUazAacpbmIh5
X-Google-Smtp-Source: ALg8bN4kuEkoNrTKNB0wpF/5vWQcMC7fRyxDCmjDgx2qgcgkIg7lFa/THiq5EvaaYM5XXMW22MMbpQ==
X-Received: by 2002:a63:9712:: with SMTP id n18mr1307291pge.295.1545377262911;
        Thu, 20 Dec 2018 23:27:42 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:27:42 -0800 (PST)
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
Subject: [PATCH 02/21] PCI: imx6: Remove redundant debug tracing
Date:   Thu, 20 Dec 2018 23:26:57 -0800
Message-Id: <20181221072716.29017-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All calls to imx6_pcie_wait_for_link() share the same error path and
the state of PHY debug registers will already be printed there.

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
 drivers/pci/controller/dwc/pci-imx6.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c87ecc305dc7..6ffadc29d21b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -603,16 +603,9 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 static int imx6_pcie_wait_for_link(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
-	struct device *dev = pci->dev;
 
 	/* check if the link is up or not */
-	if (!dw_pcie_wait_for_link(pci))
-		return 0;
-
-	dev_dbg(dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R0),
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1));
-	return -ETIMEDOUT;
+	return dw_pcie_wait_for_link(pci);
 }
 
 static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
-- 
2.19.1

