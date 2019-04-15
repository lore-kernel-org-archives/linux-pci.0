Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F227DC10F13
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD87C20870
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DV7U3jVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfDOArn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 14 Apr 2019 20:47:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45595 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbfDOArl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Apr 2019 20:47:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so7704218pgk.12;
        Sun, 14 Apr 2019 17:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dxSuTYLON4k2Acu5zoiaFP6YKp7Q+JzqRTJrEqqzkK8=;
        b=DV7U3jVgs5Pb9ApK85mkLkstDpuk2sd2BMLX/4gbOh5xshFzFH1QwI5OscPSVAdDIA
         +cgmK+y0x5f8Hy/HsCK2gQgiRZr81FnwyxeQyUnP3Y2dw1CaRM3h69dBisVGb4kDKEX9
         uC60FVOQJIlPLKCl7N7QCPKgrKg27tAdNZtaY0vLsmg4cWkwXocrvexEdQINy8KHOGQw
         7yxVgwqL9akaugiSIwbWOtQ1qWyrN7qX0KrpyGCF0o9yljYYUAJC9ze0qrTf1r1NGRuy
         Fwm710aRlLJr4+96VeEncc5PXUW+bITng4HpWbG8ykQj+3Cpt0njkpHbe9wOtflFt0Km
         crww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dxSuTYLON4k2Acu5zoiaFP6YKp7Q+JzqRTJrEqqzkK8=;
        b=gtzV123hAi9uZgUw8Wavk7NGLDHnGa3Xa4nfInZ/I//koRN/FqlJSCynwEecfdF3Pq
         UZECIrxqQHjq3Um75hnL4gUTnz1ZgD8dd41zg1mxUgbbn+XymHXwL+Gc6toz6dbYaVRt
         8S+POSUXQRTAC9lA7lTjO4Zgw+JuIcFwJsfj9wBDklPwkkMeCZ3inSC59/91AMVHlpo1
         aiEOwvpu+KAqeW9dwH4nWLvynAlUkF3/uvf+49s+5xb6931Gjanl//zH7r/C7ssNNN1F
         EsTaGu+/gRImWkZzUCgYtLnqUALxxrm6muwNCApWEYsv00G27Kf9xg0t1JYkFDZ7C5aE
         3PkQ==
X-Gm-Message-State: APjAAAXS3KZxX9Im1YDmOC+VCJ9IjcnrNS+brQk7AlzZbZsmGOBv91PK
        hzL8eGR3b4ktwWk/M86BCtjGnORU
X-Google-Smtp-Source: APXvYqyM68Fi5qwDdQa8Pie5oUjJ3L+HG8WftuWSEtyoz46DzbGVfsG2irR1v4jjKcpHyYVW6H7wlA==
X-Received: by 2002:a62:2687:: with SMTP id m129mr70980078pfm.204.1555289260421;
        Sun, 14 Apr 2019 17:47:40 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id u17sm66111981pfn.19.2019.04.14.17.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 17:47:39 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/11] PCI: imx6: Use flags to indicate support for suspend
Date:   Sun, 14 Apr 2019 17:46:31 -0700
Message-Id: <20190415004632.5907-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415004632.5907-1-andrew.smirnov@gmail.com>
References: <20190415004632.5907-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that driver data has flags variable that can be used to indicate
quirks/features supported we can switch the code to use it instead of
having a special function that does so based on variant alone. No
functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-imx6.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 30e764b6cbcc..3e45f49b8a4f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -52,6 +52,7 @@ enum imx6_pcie_variants {
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
 #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
+#define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
 
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
@@ -965,17 +966,11 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 	}
 }
 
-static inline bool imx6_pcie_supports_suspend(struct imx6_pcie *imx6_pcie)
-{
-	return (imx6_pcie->drvdata->variant == IMX7D ||
-		imx6_pcie->drvdata->variant == IMX6SX);
-}
-
 static int imx6_pcie_suspend_noirq(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
 
-	if (!imx6_pcie_supports_suspend(imx6_pcie))
+	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
 	imx6_pcie_pm_turnoff(imx6_pcie);
@@ -991,7 +986,7 @@ static int imx6_pcie_resume_noirq(struct device *dev)
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
 	struct pcie_port *pp = &imx6_pcie->pci->pp;
 
-	if (!imx6_pcie_supports_suspend(imx6_pcie))
+	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
 	imx6_pcie_assert_core_reset(imx6_pcie);
@@ -1221,7 +1216,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX6SX] = {
 		.variant = IMX6SX,
 		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
-			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
+			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
+			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1230,6 +1226,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
-- 
2.20.1

