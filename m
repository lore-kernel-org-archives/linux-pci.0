Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4781C10F13
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869E720870
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5KiY7dS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfDOAsE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 14 Apr 2019 20:48:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42882 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfDOArh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Apr 2019 20:47:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id w25so7697914pfi.9;
        Sun, 14 Apr 2019 17:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L13IRovzl2lkh8fZqfgJAwxW5M+ezlBjSKK+Wru2o5g=;
        b=F5KiY7dSM4gv7vecZ2fbCcZYQOJacjwIm/hRetx1LiejQRgYPqo0o0qchoSXjkOag6
         18Za21/VSzaSjnPPjIvOCv4PutqILpVEqbnnzCICTS6LpLX00lpEqigVJdhlKwjaj+qV
         ToPXwYPsAB+gGIIDVTslAUMXKBnb2UFO/mIbFceTyWMI02PwuvQFVllXNCi4/Qw/k3I9
         AjQmywcPqjJp2HWykzKWgysmVl/UQEvwKQCdwUs6VYeKXgfoyoLX6Y9dAFxQ3iud/nIy
         OOh5xFpThEuKE1yf0f3CqzUurYrL8M3Q9FeKKgVl9dtydz7NFrN4r6deiIVB26LY9YrT
         hwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L13IRovzl2lkh8fZqfgJAwxW5M+ezlBjSKK+Wru2o5g=;
        b=uiBTVL9wAf6keNrxZYtbaqYdJw/eAF9egV1aECOrXtYEaPzuH8/d19ZAqSR3RUJUUm
         s/VunSmR0Wm9uhzy7cM7n5w+mPjRzh9wbqkd42k5G78rYh8STxGwWA+3ZureyA4Y3An8
         As75atvW2JLvZ1lWsQsqOaz92WeEP7oDcXSbRxBbZG4j14KIYKVoo/laNntBghpT0bcD
         ibFDXNjGwSCO5eis4PVAG4lcLkfIVJ7/MrZOdSW7BSwOpPj3791Ko/sv/hQA08YFsn+a
         Cj+8viQlDYEwKHM7R7LYZu5CtqHYOh4WYs6I23royVdOEHmW/YD4cdp+ol+Nz12CLtnd
         naEA==
X-Gm-Message-State: APjAAAUmjYzmGfzCN1f8gx0AB5fl9f1rMs8fyLalHWQ7wmYZI5EtQhFd
        AF2aTLp6kZDLxSVoY0pyyiFYXxJ1
X-Google-Smtp-Source: APXvYqwFCmOpFcgLARCUUfeJXMChD9y2YF7dFl7cDxIJAiW3WbHssRc/GFIo8x/94nfaUlYfGrNqmg==
X-Received: by 2002:aa7:928b:: with SMTP id j11mr52167548pfa.200.1555289256264;
        Sun, 14 Apr 2019 17:47:36 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id u17sm66111981pfn.19.2019.04.14.17.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 17:47:35 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/11] PCI: imx6: Simplify bit operations in PHY functions
Date:   Sun, 14 Apr 2019 17:46:28 -0700
Message-Id: <20190415004632.5907-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415004632.5907-1-andrew.smirnov@gmail.com>
References: <20190415004632.5907-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Simplify the code by incorporating left shifts into constant
defnitions as well as using FIELD_PREP/GENMASK. No functional change
intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-imx6.c | 28 +++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5650642ab248..669e01353026 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -105,11 +105,11 @@ struct imx6_pcie {
 #define PL_OFFSET 0x700
 
 #define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
-#define PCIE_PHY_CTRL_DATA_LOC 0
-#define PCIE_PHY_CTRL_CAP_ADR_LOC 16
-#define PCIE_PHY_CTRL_CAP_DAT_LOC 17
-#define PCIE_PHY_CTRL_WR_LOC 18
-#define PCIE_PHY_CTRL_RD_LOC 19
+#define PCIE_PHY_CTRL_DATA(x)		FIELD_PREP(GENMASK(15, 0), (x))
+#define PCIE_PHY_CTRL_CAP_ADR		BIT(16)
+#define PCIE_PHY_CTRL_CAP_DAT		BIT(17)
+#define PCIE_PHY_CTRL_WR		BIT(18)
+#define PCIE_PHY_CTRL_RD		BIT(19)
 
 #define PCIE_PHY_STAT (PL_OFFSET + 0x110)
 #define PCIE_PHY_STAT_ACK_LOC 16
@@ -178,17 +178,17 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 	u32 val;
 	int ret;
 
-	val = addr << PCIE_PHY_CTRL_DATA_LOC;
+	val = PCIE_PHY_CTRL_DATA(addr);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
 
-	val |= (0x1 << PCIE_PHY_CTRL_CAP_ADR_LOC);
+	val |= PCIE_PHY_CTRL_CAP_ADR;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
 		return ret;
 
-	val = addr << PCIE_PHY_CTRL_DATA_LOC;
+	val = PCIE_PHY_CTRL_DATA(addr);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
 
 	return pcie_phy_poll_ack(imx6_pcie, 0);
@@ -206,7 +206,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 		return ret;
 
 	/* assert Read signal */
-	phy_ctl = 0x1 << PCIE_PHY_CTRL_RD_LOC;
+	phy_ctl = PCIE_PHY_CTRL_RD;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, phy_ctl);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
@@ -234,11 +234,11 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 	if (ret)
 		return ret;
 
-	var = data << PCIE_PHY_CTRL_DATA_LOC;
+	var = PCIE_PHY_CTRL_DATA(data);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* capture data */
-	var |= (0x1 << PCIE_PHY_CTRL_CAP_DAT_LOC);
+	var |= PCIE_PHY_CTRL_CAP_DAT;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
@@ -246,7 +246,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 		return ret;
 
 	/* deassert cap data */
-	var = data << PCIE_PHY_CTRL_DATA_LOC;
+	var = PCIE_PHY_CTRL_DATA(data);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
@@ -255,7 +255,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 		return ret;
 
 	/* assert wr signal */
-	var = 0x1 << PCIE_PHY_CTRL_WR_LOC;
+	var = PCIE_PHY_CTRL_WR;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack */
@@ -264,7 +264,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 		return ret;
 
 	/* deassert wr signal */
-	var = data << PCIE_PHY_CTRL_DATA_LOC;
+	var = PCIE_PHY_CTRL_DATA(data);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
-- 
2.20.1

