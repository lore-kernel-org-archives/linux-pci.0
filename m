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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40C1C43441
	for <linux-pci@archiver.kernel.org>; Sat, 17 Nov 2018 18:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFD820815
	for <linux-pci@archiver.kernel.org>; Sat, 17 Nov 2018 18:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRk/FBmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFD820815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeKREaC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 17 Nov 2018 23:30:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35909 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeKREaC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Nov 2018 23:30:02 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so6080315pfc.3;
        Sat, 17 Nov 2018 10:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AHMjBXV+tZeSxvUQvlaaMP7K5FV8BZph/ua16Vl6Z4g=;
        b=jRk/FBmz57Cjg2rHbL8eTwN16Wte8exPdg/zqO7/RxtO1XmaO132ojAp4YrKoxkQoW
         vprza5Yh8gBNuXppWb1quyXiGDFEQKt7EXMZBSwLCC1dibd2nUuvY2k4H0mWgXTgKd7O
         tMwi5rdXcnlJqFo3e/hGSu0aO804qj8X6sX2Xjj19uFtH2JKCgpyTFMEHCKZxDBQRih4
         A8+oCS0v0+W5Iel8mPtj2A6V/W8/Y0V3Zmc+ppaK3tTYwmqyNhoNlvdotH+yyp0jRn2J
         EdFMVLqL8pkduB+wBaBQVxiwpQnKzZ+ckoZ6YSEi9CtB1jlSacALAKxvEI+J6n7XbrWi
         Mc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AHMjBXV+tZeSxvUQvlaaMP7K5FV8BZph/ua16Vl6Z4g=;
        b=bMMsQR7e1IPEDjKX57BcrL80xyJOXrmdkYew6tSlR+E698W4KyJmCvtWK3+EqOf6hT
         yfxoHfv8a2DTbUr3sj1u77aGGdb4lqPGq2tbmLR3O40a6fWfueC8H5qBl5njogonAm/A
         nT/0akkRNX7d4DmzK7Qx4te6/UnyK53Qbc3gV+0FaWkdBPGzWqgEGsYHPEmZUnR7fzww
         YwmjayJP+K8zhVQsAnBDaI7+hWLmXnfOkri8tSijIHMidf0kYLggH0ZV9bjhzwZBVOHx
         2jZ9ljXZqwwJuBoTIHSb2ilmRiwz2gGdhJs9Zy4156488EDLWw6A7mRbFWGScF9cMWnQ
         X+hA==
X-Gm-Message-State: AGRZ1gLIo9yjvITNkZzSQ/ugmZq1fRamXVJPCAuJZFhfgJKvSJ7PScp5
        sv+YYbsR4gKR5TgxynWesKOJKsPcNyI=
X-Google-Smtp-Source: AJdET5feNuTysNZsW12ctaii8G7xgO/LM/NexVDVWuk452DtrAj7XbF/bryczoPTv633dmWipEemmA==
X-Received: by 2002:a63:7a5b:: with SMTP id j27mr14416020pgn.112.1542478352963;
        Sat, 17 Nov 2018 10:12:32 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t2sm13868196pfm.32.2018.11.17.10.12.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 10:12:32 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>, bhelgaas@google.com,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH 1/3] PCI: imx: No-op imx6_setup_phy_mpll() on i.MX7D
Date:   Sat, 17 Nov 2018 10:12:23 -0800
Message-Id: <20181117181225.10737-2-andrew.smirnov@gmail.com>
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

