Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48B5C43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9552420870
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKGvunNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfDAE0a (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:26:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35315 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731714AbfDAE0P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 00:26:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id g8so4078636pgf.2
        for <linux-pci@vger.kernel.org>; Sun, 31 Mar 2019 21:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kKSmgFelw3p2OWL+OlwzOpWPsYOlwS6LbJMo8debjJI=;
        b=nKGvunNgcjxkrbzEsS0HcWRlKMa8rRjj6bwXWIo15bS1CYeXKnW9iico1gkc1fHUXa
         dAcGOZIfIvIHTc/IGf9B0cvT4kUKmT9geMVanP1UOy6GBdLS0+luqJ510cE0jCo2cqpj
         W0GQc8tumq/hFeJAk3DV9P/BOEIC4WOe+zvF24N666ruxLKQ7WtKrGHUgmXVvOTLg7H1
         SbYI6xmcG2pkPOxcsGzAnvgaHk2V/rv7UrHn+z2B0WiuhK5e8BPDPQelyfwsyarPXKMP
         JJNvm82Nn32OlotKTKepFWSyLsCbTNCO4d14iLuVj1sjxF6N0NNEFiOIv2W3A1M30EUH
         t1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kKSmgFelw3p2OWL+OlwzOpWPsYOlwS6LbJMo8debjJI=;
        b=GBzrWsZ0GqC7dn2pXZbRhdqpxrR1OpOp+kDE/q/KMevS+MOB+ePz2Lls6ASF+s49Zd
         E0kDjgjHd02fPLDgJChMP8G2G+AXp48m/sqbA6HgJzR8b7xIDzfQqlh+p+0BaSdbMCYR
         1p7md9guVpW4A2zKcWLchTccFHZ/ZEdDYwpKF6LCAAQUDDfoM/aZkLfnWGWYGqLJ2db4
         vwYRMC74/7So7/+JG+eTN7bkH/756nTqx42WwIORDgrRxtm+Kjf47DEaRss0aqkZVG37
         hC3Vg6pcIM4uJnKvbYaKNPGQBUrRTHDxiMIFYv9s6s/0ThQHHdPaCU+8gi68f27KIxx3
         w8WQ==
X-Gm-Message-State: APjAAAXN+3PYt+RSunxDMLavt/hBCzIb+0s/WnGi9SUDjnf9ieS1KfJi
        j2s7hOsEP18By1LXNvMI6oxlptPO
X-Google-Smtp-Source: APXvYqwmYXY/pA9858rM19p3WyyMpHO9Jd4Br1UZc1rPhzb+U7OOWitWPbUaNQavUGs18GRyekClpQ==
X-Received: by 2002:aa7:91c8:: with SMTP id z8mr49683054pfa.110.1554092773792;
        Sun, 31 Mar 2019 21:26:13 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t22sm10996829pgu.45.2019.03.31.21.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:26:13 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v3 10/11] PCI: imx6: Use flags to indicate support for suspend
Date:   Sun, 31 Mar 2019 21:25:46 -0700
Message-Id: <20190401042547.14067-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401042547.14067-1-andrew.smirnov@gmail.com>
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
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
---
 drivers/pci/controller/dwc/pci-imx6.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 9c658ef55aa4..c9431a8a7ca1 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -52,6 +52,7 @@ enum imx6_pcie_variants {
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
 #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
+#define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
 
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
@@ -973,17 +974,11 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
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
@@ -999,7 +994,7 @@ static int imx6_pcie_resume_noirq(struct device *dev)
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
 	struct pcie_port *pp = &imx6_pcie->pci->pp;
 
-	if (!imx6_pcie_supports_suspend(imx6_pcie))
+	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
 	imx6_pcie_assert_core_reset(imx6_pcie);
@@ -1229,7 +1224,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX6SX] = {
 		.variant = IMX6SX,
 		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
-			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
+			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
+			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1238,6 +1234,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
-- 
2.20.1

