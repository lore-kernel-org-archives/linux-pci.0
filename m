Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7E9C43444
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A94C21906
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9+tbe7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388415AbeLUH2R (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:28:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37872 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388601AbeLUH2R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 02:28:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so2115489pgb.4;
        Thu, 20 Dec 2018 23:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TOnTTJb5k0hJqk9drUFS28Vo1VkvNAjAcTVESkJjprE=;
        b=a9+tbe7CR5UO46XozmMgmDfw5gfEdE1Cgh/dugA1o/gngbng/PNMICEPKMOiEGVoE/
         S0Ury7jhXQ3IZSU3XOlfgsUgm3Gm+r8Y+T9uVMR0xWRL3q11dZRUJOauZzRLcULGHUDT
         GpL0O2KCZ5lokYMl7OSIMwYg3ON5jlbc0hYt1mPV854yc7ORVA2U7BrX2O2Ygl15xElB
         KG5R7F6pXhg1WnrRHBZX+ZeX6Jqp6JTXxB5Ze8oqeWbYGxS90UMK7DbyjxWWs0yV8CQd
         xqSncCapvzUcfhyzzvyqVR+ZpsNwczR1ZHh/6rZbf++CF2o6d/rgeCQd2yNlpaPcsYd1
         Gqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TOnTTJb5k0hJqk9drUFS28Vo1VkvNAjAcTVESkJjprE=;
        b=jXCgzulPJqLJKYxM+6zSyCqOyl1NwPdWb6DdVFrLWr9UqgCzdLZmUTaLU2rPOlGzZv
         16eI06qfTTy0c8A9gxv7IBW+Yv8ZZzIz9TZ7GDgegc11Ijhay2sNqUwnBJGHEI8D+bsu
         43aczfADV0wwhcMcn9SB2E+/d0q9odHF/9M8DjPNaJp82rsdotu+HEEecCWeFV7yhr+l
         XcPH1QGcSwSBRM/yivaFNqdKJTgJQgsfHMS5SxwVAmlqK29nBWCiDSYvsQBremBu0oRO
         elwQ3L5ud7tnDEZh575Y1fsCpy135YxBJVshGwU9xsZYuUatFsvgPoKPwMQ3EWBzcV6E
         Ne2w==
X-Gm-Message-State: AA+aEWY2eJKBZ7pl9QvVfvi9K4z9HPGlKWO/dYkJpGT+WMKx6hinfr94
        KA3eIP7Z+6r57qZcJWLelA5hE8h7
X-Google-Smtp-Source: ALg8bN50gFFgY3nBEzPGNZnloJzl5Z8OSiIYjw1gQKEwJYi3/td0fh6QxZjdAqqMWVWlHBHpzlhj2A==
X-Received: by 2002:a62:15d5:: with SMTP id 204mr1421947pfv.103.1545377295233;
        Thu, 20 Dec 2018 23:28:15 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:28:14 -0800 (PST)
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
Subject: [PATCH 19/21] PCI: imx6: Remove magic numbers from imx6_pcie_establish_link()
Date:   Thu, 20 Dec 2018 23:27:14 -0800
Message-Id: <20181221072716.29017-20-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Explicitly define PCIE_RC_LCSR_LINK_SPEED and remove magic numbers
from imx6_pcie_establish_link(). No functional change intended.

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
 drivers/pci/controller/dwc/pci-imx6.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 678f5fa85e12..2b312f287fd7 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -79,6 +79,7 @@ struct imx6_pcie {
 #define PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK	0xf
 
 #define PCIE_RC_LCSR				0x80
+#define PCIE_RC_LCSR_LINK_SPEED			GENMASK(19, 16)
 
 /* PCIe Port Logic registers (memory-mapped) */
 #define PL_OFFSET 0x700
@@ -688,8 +689,9 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 		dev_info(dev, "Link: Gen2 disabled\n");
 	}
 
-	tmp = dw_pcie_readl_dbi(pci, PCIE_RC_LCSR);
-	dev_info(dev, "Link up, Gen%i\n", (tmp >> 16) & 0xf);
+	tmp = FIELD_GET(PCIE_RC_LCSR_LINK_SPEED,
+			dw_pcie_readl_dbi(pci, PCIE_RC_LCSR));
+	dev_info(dev, "Link up, Gen%i\n", tmp);
 	return 0;
 
 err_reset_phy:
-- 
2.19.1

