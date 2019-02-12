Return-Path: <SRS0=P0ok=QT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D909BC282D7
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 01:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28592186A
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 01:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1JnCf7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfBLBv1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:51:27 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42701 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfBLBvZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Feb 2019 20:51:25 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so444549pga.9;
        Mon, 11 Feb 2019 17:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XhYeWLJELbBbIY+70J27USkrt28o/PdkHlXxy2828Aw=;
        b=e1JnCf7wRHTPnhwqCvYmVDpF+ygXKWJ2X9sU1PuTUICG57IYl/wersw6LE1ZZfRoSP
         z0vNsZmaF0uvzQlUM2wVJrDWPDDYEAiw1hsgZqeA2Jz48FjbGU06Mf5XA3BLgaJYfwyU
         O4qKgpjJY21YjRjaIDHYPgE5rnbltPt3d1eUj8DFG22XmG1JDUkpfU1+rw3UrZLDyVub
         FFc5dKMDXIYwWazjMLiipCd4n/ZqGlUGo1GZAg0F9mdlhAdkVPL0iHa5AJ8FENM70Yuq
         Cg7yl6zbTGWWU7EFD9lvhVC2wAfMAfG5rp62ik/Q9AIkqWMG3jdp4mDthl589sdp9N8O
         a37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhYeWLJELbBbIY+70J27USkrt28o/PdkHlXxy2828Aw=;
        b=d88LZT8MggwxXidY7VJ+rVbJ3h9befDwtkP1zthZIZwPqFho8wmxzUP8wy1a5RYwB5
         agcJLPcAcvEp7dfHcoIbK7gYBE2QzqH+U+IbH0XFvjXKWNd7C+XadbWqqk1/0kOuHNEl
         ccAWCYC0KhA4LCAy48S0pnwSGXYJhEV5zYy2e19zadKoX21iJ7v8S2rBP1HlUEAS8HFa
         hWfYtMQEw4HkbBHmtQnbhs2PlGZjEan1kenOwfUSxU6+ptxxAbvl8paQ2PDAfvTo2X5S
         qXohO7rC4LItmUmuJN4UpD3zhwx0xfVSUPCx5h/gPQ9AHGzaVMIBvQHuKuVNbfG3TgN4
         Dhzw==
X-Gm-Message-State: AHQUAuYutpVJ1hobhz0a2f5k0kMH1TK7TUC+P4bs+X2DzhRLDyHUEb/Q
        DHQxoitCkPuoeV+b8Tnd5Pg=
X-Google-Smtp-Source: AHgI3IbTde5HeivFm3ljicLP4d2ZWPVCAiISH6/qQT+zjCtH9wnU2D75DjAI9R26IehpTVqfat5T6Q==
X-Received: by 2002:a63:2bc4:: with SMTP id r187mr1282560pgr.306.1549936284040;
        Mon, 11 Feb 2019 17:51:24 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h64sm17146941pfc.142.2019.02.11.17.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 17:51:23 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: imx6q-pcie: Add "pcie_aux" clock for imx8mq
Date:   Mon, 11 Feb 2019 17:51:07 -0800
Message-Id: <20190212015108.16952-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212015108.16952-1-andrew.smirnov@gmail.com>
References: <20190212015108.16952-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a binding for an extra clock required on i.MX8MQ.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
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
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 920ca93870a8..933d98328e07 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -55,6 +55,10 @@ Additional required properties for imx7d-pcie and imx8mq-pcie:
 	       - "apps"
 	       - "turnoff"
 
+Additional required properties for imx8mq-pcie:
+- clock-names: Must include the following additional entries:
+	- "pcie_aux"
+
 Example:
 
 	pcie@01000000 {
-- 
2.20.1

