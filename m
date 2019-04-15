Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DEEC10F14
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE33F2070D
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vT4TzE4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfDOArm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 14 Apr 2019 20:47:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45462 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfDOArk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Apr 2019 20:47:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id bf11so7676128plb.12;
        Sun, 14 Apr 2019 17:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5efM5EhjjdhBc/uhVsC3qJkDClRcXkF57SZv54KM6uw=;
        b=vT4TzE4MdQ5povk2xRlVpiKcthkKK8NtYQt5xE00W+j7zFxTHJnnt44ScNwmJ2x49C
         fENHkrMpwrVtupwiCzhlGJbY7PlsziVx+WkfgTjrExYTChn5/lyic+Ppz0mqM1JgtJF7
         MuHgVeseu/cGDZCRYKzMs3GqU8S0WF0H4U043d9NWo7ZYlfFOS1TBJe0Adh4QCdKPpcX
         Mo4g6t3j/l0T4NhOxFIWdy71arNGQ3aWGOky8KywdzlbmMJYKFvHQpEs7sHaxH5r+jgK
         xhVxCA7PAULngefyHYvZvaycNVQ51BMXpYbkseLdd70dP5K8ignNYQrC8aMzGk5hoYKo
         ry1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5efM5EhjjdhBc/uhVsC3qJkDClRcXkF57SZv54KM6uw=;
        b=QwdfrqKm++cdd6/ujvgLY+XMCXlhK4RDdCKNlVU+0XpgTCQI/EJSoSa4vor+48WHQs
         FmjKFFNMX18gVPbriCYS0ybuXYvGzLSqomYrgEcyWL1R1MfR/VOs/z5j00/IwyHkaNvy
         jLvMfVo5ciEpKWveb2XweXmkbPXD8iunDpkkeUzsRI5aL3PJql6GxjREH8KDGXSXCRCL
         Gs9kGa6n4YrBZnv7OE3cBlVcvpNCJc9hD9LhN9xKn+U3A+E6+UfCs8j3nXmx59huFOj8
         9ZmAdZiFwZFbzmFI0WMAqoLmV0NuEKqd9b3aIFIGCd1UsOQ502aQNOnMlTMb1ShHaIT/
         W5Dg==
X-Gm-Message-State: APjAAAU3M4ebIBo5KEkGFoX8/vIymejAM9/EdNbn6nr9DcE4ebqXLKNk
        sA8tQQ/w9MtN4RGnKkARyDk3/vre
X-Google-Smtp-Source: APXvYqx1CfuQQh2h1tN/SfdIAKdJTnxG14U4dUQbOGhbaKkAbRKJWNShouYLs4PG44fh+AHwPeFjTA==
X-Received: by 2002:a17:902:a5ca:: with SMTP id t10mr69668931plq.234.1555289259247;
        Sun, 14 Apr 2019 17:47:39 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id u17sm66111981pfn.19.2019.04.14.17.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 17:47:38 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/11] PCI: imx6: Restrict PHY register data to 16-bit
Date:   Sun, 14 Apr 2019 17:46:30 -0700
Message-Id: <20190415004632.5907-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415004632.5907-1-andrew.smirnov@gmail.com>
References: <20190415004632.5907-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PHY registers on i.MX6 are 16-bit wide, so we can get rid of explicit
masking if we restrict pcie_phy_read/pcie_phy_write to use 'u16'
instead of 'int'. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-imx6.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 3fd084357488..30e764b6cbcc 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -195,10 +195,10 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 }
 
 /* Read from the 16-bit PCIe PHY control registers (not memory-mapped) */
-static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
+static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, u16 *data)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
-	u32 val, phy_ctl;
+	u32 phy_ctl;
 	int ret;
 
 	ret = pcie_phy_wait_ack(imx6_pcie, addr);
@@ -213,8 +213,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 	if (ret)
 		return ret;
 
-	val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
-	*data = val & 0xffff;
+	*data = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
 
 	/* deassert Read signal */
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, 0x00);
@@ -222,7 +221,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 	return pcie_phy_poll_ack(imx6_pcie, false);
 }
 
-static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
+static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	u32 var;
@@ -279,7 +278,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 
 static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
-	u32 tmp;
+	u16 tmp;
 
 	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
 		return;
@@ -675,7 +674,7 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 {
 	unsigned long phy_rate = clk_get_rate(imx6_pcie->pcie_phy);
 	int mult, div;
-	u32 val;
+	u16 val;
 
 	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
 		return 0;
-- 
2.20.1

