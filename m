Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03630C65BB0
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 07:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B812520878
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 07:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjnFXN8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B812520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbeLFHf5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:35:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34149 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbeLFHf4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Dec 2018 02:35:56 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so11395327plz.1;
        Wed, 05 Dec 2018 23:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xhmO+XhPFCrEZH1UNrvz+XUznHtfpXBiia+w2KZHgv4=;
        b=UjnFXN8nfAq1misbRlHq/onwF2OICWLCOF51zSdfis73UyQ+GToJqPdY0fv+WbHQxa
         2p3+AHCDec0Scn9g4V/i3DevTv4+hCIIUlbIUbjjs5xgIyY3x3iUT2RMyV2TKlzDYMGJ
         b9rBEpgcLq5bkCks3rkLJFdC2H96alSVB5SxIm75f49vcIrZf653iC72QLLtyu01h45k
         mwW8lZihqWaIHi/HvmOcbKhQFmXFu6oAQYQck/DtSraaN0eK6LAY894B0Oujd5XC9DKw
         P5KAu/+nm30iwGDZcsnNO6fjAJtBCkbTT3pQbjo+XYAjfEdYeqcE1mtJ7omsIOElJHtt
         fy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xhmO+XhPFCrEZH1UNrvz+XUznHtfpXBiia+w2KZHgv4=;
        b=eslL6DykAikKMN8hCmvvaMAhItJlrjms17kRjAZxglsckxfPP8MEEuEjStc40nBibP
         hSimKbt5kH5i+7mU+uUpSBdhQwLV2gI51PZrLwXjusetuY0LHvZX9RbtUVofqkwLqJFt
         JXijfl3/5esNbO5sG00i43JDy30u5e/IvNQbqXw2lR7xXghLLFRe8RZMfISpGHtUVpIf
         jWlUM6U5ZyCJhr3C09pA4u1muwzy5n0WDSYHOh5I43yJUlPcYqUZGdaP4kLC+ibuonJ3
         uEf4fKFziX6wHuejpp+kmNhesAy4jcQUZWnm8lfNDclmbAmnflsngMd7zumtCyuW55BQ
         Vxcw==
X-Gm-Message-State: AA+aEWasMDuyWczS+pxtZ9JNUvPIGeQ8m2CVi9sGcGBExqKHb7n4ruhv
        AS3zO/kiSyYchBcSz6Kd5zUA5Ye8
X-Google-Smtp-Source: AFSGD/XwXi34Srl8/oY5Xn5iOrn3FO3++GlIOQegmwiONK7Hhbc3+2QRpbcHgmEGMCBHOCBtDO2+jQ==
X-Received: by 2002:a17:902:a710:: with SMTP id w16mr26670156plq.95.1544081755408;
        Wed, 05 Dec 2018 23:35:55 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id v15sm33035894pfn.94.2018.12.05.23.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 23:35:54 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>, bhelgaas@google.com,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] PCI: imx: No-op imx6_setup_phy_mpll() on i.MX7D
Date:   Wed,  5 Dec 2018 23:35:43 -0800
Message-Id: <20181206073545.10967-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206073545.10967-1-andrew.smirnov@gmail.com>
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIE PHY IP block on i.MX7D differs from the one used on i.MX6 family,
so none of the code in current implementation of imx6_setup_phy_mpll()
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
Tested-by: Trent Piepho <tpiepho@impinj.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 2cbef2d7c207..c140f7987598 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -525,6 +525,9 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 	int mult, div;
 	u32 val;
 
+	if (imx6_pcie->variant == IMX7D)
+		return 0;
+
 	switch (phy_rate) {
 	case 125000000:
 		/*
-- 
2.19.1

