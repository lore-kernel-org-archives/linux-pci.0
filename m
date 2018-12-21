Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DEBC43387
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB41721903
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrBrVyti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387465AbeLUH1v (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:27:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46214 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732384AbeLUH1r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 02:27:47 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so2168143pfe.13;
        Thu, 20 Dec 2018 23:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fltZQbZSIQgUXi/Z+xP/+nOzCe8SxwJBjLTLp8RDlGA=;
        b=rrBrVytiDnat/KCHZDBMlr2Q4rK7dzYqetel/FN3IPPM07pVdKgmLf2nl+yaPN4i6h
         reGL4tQFU2bZ2oANOA6ueS9c2dh55HWlgZu+eJYLmRT+yoJI/NuEDPdgVEbbYr3z7b58
         nxs3DDTX2GiLuvPhpBByWtA/l2/F+7TZ2BxmRRt/Qpv5mkJFlQ0iSkk3imIeRrJdRmzA
         1bvBZEkw46EzOinWphj81lvnvNm3BzQxrRSAV3xEDW7IalBojTLDVV9IdQJTEhExudwK
         h6SmNPoY9y06VaT8Ed83PqIHZI7LcknkWGdqsoy6aaZIqqg9wFMsiXq45cElV9ur7Vz1
         z4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fltZQbZSIQgUXi/Z+xP/+nOzCe8SxwJBjLTLp8RDlGA=;
        b=kAnOJGLLHiV5r14TYwKzBcn7eAu0ppSyDy6jlrdpPu3rWJ/M1bzgwk6jeYPxpWb7/0
         S0y2NvZWZa1/r5GYGhMKCWMCLVaQ6Qm20VkxpzR84oQ7Nx2AMXinGxwEPJk+Mk5lehHI
         RqlxWmtiAwUR9AHcK5dvO0ExOha1G6uE6/xXN133mLxE2VbfhyfEW1/Jd/+83JsltuQZ
         V9ON/fH6kD+gMlbj/wMqGH6BmR7XxZnFnDKAWNJifwxkZUGuQiKrPytTsg+I1y+h72A0
         KUg21OiYRCZCT3PuNmjtzyIaCUOi/+p5JZl3KYSAr+qSE8AdwtPtvJ2uAqx/b3hrYl6g
         tIIQ==
X-Gm-Message-State: AJcUukdf8Pr8Fzcer6AWvisxHWQzDbOie0aP6v81BqPNAxL4Lna/0a/u
        xDmxMR1CYEZC+1CzaO+1WHQvIMAY
X-Google-Smtp-Source: ALg8bN7so8dNzKUeH8NV9oDrLTu7hCW6lX/cL+aAyLv7GoPIg1L2wuobljjFpsXFADTv8zZvuVc/Sw==
X-Received: by 2002:a63:ae01:: with SMTP id q1mr1321976pgf.402.1545377266708;
        Thu, 20 Dec 2018 23:27:46 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:27:45 -0800 (PST)
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
Subject: [PATCH 04/21] PCI: imx6: Remove duplicate macro definitions
Date:   Thu, 20 Dec 2018 23:26:59 -0800
Message-Id: <20181221072716.29017-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Both PCIE_LINK_WIDTH_SPEED_CONTROL and PORT_LOGIC_SPEED_CHANGE are
already defined in pcie-desingware.h, so drop duplicate definintion in
pci-imx6.c. No functional change intended.

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
index e990030564d8..2265f4b40e39 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -100,9 +100,6 @@ struct imx6_pcie {
 #define PCIE_PHY_STAT (PL_OFFSET + 0x110)
 #define PCIE_PHY_STAT_ACK_LOC 16
 
-#define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
-#define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
-
 /* PHY registers (not memory-mapped) */
 #define PCIE_PHY_ATEOVRD			0x10
 #define  PCIE_PHY_ATEOVRD_EN			(0x1 << 2)
-- 
2.19.1

