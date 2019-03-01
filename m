Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0483EC43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 08:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2912087E
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 08:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GafHS9ec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfCAI4Q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Mar 2019 03:56:16 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36300 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfCAI4P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Mar 2019 03:56:15 -0500
Received: by mail-pl1-f195.google.com with SMTP id k2so11168959plt.3;
        Fri, 01 Mar 2019 00:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RTJhdzszh+3e5Q1RkYoiwnZzWya7sTas3a2TjMKw8sA=;
        b=GafHS9ecvConHGU3Y1sqZh6lFfqN+8yYX3GWUAMxoQIzoUKtDD24IPTUZ1KAu6JJ6v
         gsZFm9zZOxCpXAbr0dUYZ7j3v3Do5ysd2eoi2rYi6Zceg4kazrsWmT7PsApeWW4TG3Rs
         +KfhUdbyuIVKWJ+3BI5QvdElkG6JTx6zkTgFaA5GOQveZNEuDhjg9rhjsQ50ZOiSlyVv
         b/alEvVeoXyui7fwtAs52cWut3X4goySxDZ8R5CKltTMifq1GuhGH+EkjG5XOBxdBPbM
         f1o/CLK1mrh6camUJMI6aPFt/q9m84rQIDrFrmKZVSVkMutknM0oHAunE74i4JtRT3m5
         3o0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RTJhdzszh+3e5Q1RkYoiwnZzWya7sTas3a2TjMKw8sA=;
        b=X9NZCJCChqWnsXiZjBzNhJ4JuF6m6Eh/tcP7GXkCKH/8zp1fDYPDqiuh+4GnX2BEpE
         jxVH2GNTbPnNfjjErFj+59y9o4YPTLJ+Sr3pQhFEZf/wYQY9QV9QkoI3Q8NLC0Na4fxb
         YZYoiDx9fDNN46mnkmS3BEcsP84D3SOJ3izRN55t83MbwijkKaUuAAANDSVSELXNLovb
         zK9G2R0M3FIufNHKsDQ7gAFXUC4FXR5WQayoLWGW24Z3mHKSs+1sFdeccYUgmcO6Xp1k
         bNV5IlZ8EllcrcuYWp+geB51c6iARzBTJFQ6c2WzS/CvM8UC4ty2V9TQRddpPUFbO2/0
         c0hw==
X-Gm-Message-State: APjAAAUVYDjCttbTTCYoZ8tp4KxoSLES40rnLHrb2nj2LIwzl82r7vVb
        4Dx14zzYa20/hq6EJ352g+0=
X-Google-Smtp-Source: APXvYqyLn4WdG5MxDWwh+rwgd8wpE7sEgJ/+hRr/adqaX/l7WPpagexAA3ZLdQxaVGFecqs4/SKOlw==
X-Received: by 2002:a17:902:586:: with SMTP id f6mr4299378plf.185.1551430574894;
        Fri, 01 Mar 2019 00:56:14 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id u26sm28049553pfn.166.2019.03.01.00.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 00:56:13 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: imx6: Don't request "pci_aux" clock on i.MX7
Date:   Fri,  1 Mar 2019 00:55:59 -0800
Message-Id: <20190301085559.18736-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The clock in question is not present on i.MX7, so move the code
requesting it into i.MX8MQ-only path.

Fixes: eeb61c4e8530 ("PCI: imx6: Add code to request/control
"pcie_aux" clock for i.MX8MQ")
Reported-by: Trent Piepho <tpiepho@impinj.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Trent Piepho <tpiepho@impinj.com>
Cc: linux-imx@nxp.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-imx6.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 08f1ee050c73..5fe364a9959d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1100,8 +1100,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
 		}
 		break;
-	case IMX7D:
 	case IMX8MQ:
+		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
+		if (IS_ERR(imx6_pcie->pcie_aux)) {
+			dev_err(dev, "pcie_aux clock source missing or invalid\n");
+			return PTR_ERR(imx6_pcie->pcie_aux);
+		}
+		/* fall through */
+	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx6_pcie->controller_id = 1;
 
@@ -1118,12 +1124,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			dev_err(dev, "Failed to get PCIE APPS reset control\n");
 			return PTR_ERR(imx6_pcie->apps_reset);
 		}
-
-		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
-		if (IS_ERR(imx6_pcie->pcie_aux)) {
-			dev_err(dev, "pcie_aux clock source missing or invalid\n");
-			return PTR_ERR(imx6_pcie->pcie_aux);
-		}
 		break;
 	default:
 		break;
-- 
2.20.1

