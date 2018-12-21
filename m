Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BA4C43387
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DFB21903
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRg0NhYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388280AbeLUH2J (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:28:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37449 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388220AbeLUH2I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 02:28:08 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so2187394pfb.4;
        Thu, 20 Dec 2018 23:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eae5kd40WjRlq9zOByiDPPD319NoPNuivhFx9H6fzrQ=;
        b=GRg0NhYFHUyygYkVSFXYtmsieJ+LveULDsOkgKglG8BJJVcPiWV9qMrCq31CoAFk1Z
         MHM8v/PiYCKo7w1Tb7m3EkmnXdDNh9ZvIDRY/F8Wz5C5VgeCxaCnU12kvw/jGjmhnSzO
         wtYt+YK0q45NjRE/ywjsiAayK5YQAD+xUIC1t7Mue9nhZSqSpmqYRvyEcabxZwhqfnYA
         lT6e8u/Vm11g2k9LfxAQLE55+6O0LX8AulBPIKLDJIi19qYvNZ0H2MSeAY9RAKbvifqS
         kmkX5c4t4XCA1yU4oeTdqUyPOPGEDm937Mwk7tu4XyuT/m/VMXNCoutY1/CZCtZjUHYi
         Z2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eae5kd40WjRlq9zOByiDPPD319NoPNuivhFx9H6fzrQ=;
        b=uks/i5fj0egDeptWv8HHlZkT9i9YbNPyld8Eygrb4nXziWsIMmNVzMzh9f7SHOzbO1
         vhQVHsoZtBqPaiKfgNv7YGnFewttRFLFgvtgV5U7Lamz/enCKeP4Z8iN9JtLXN7BGuZU
         8S7rlwzOSst8wiPakrXZc3i6wmwWH8ZniCkQS+zBgAIIkf3IlLPe70D7be0fL6Rjcxw+
         i2MWh+ALNMPahT/LST0FiesLQKmJOU2b6QidGc8S2bnwBOvVckeuRf3Mf/iohCtr0LGZ
         shgA6wBjKvV1Jw8cp6LQU5C7IaWYSE08bMOoLOu4ovcdQAFa9tQZ+o0DH73s72pU8jD6
         I40A==
X-Gm-Message-State: AJcUukc7rsZfvITEk9zFWSZ8fgs6Mq4YlbHpADLe39HjzCpUx6kvy4j6
        uwBrEfU7G4/h5LicNnx9DbNXMoxA
X-Google-Smtp-Source: ALg8bN4Apu6v2hERGWDIotDPk7xa48XrCB98F2x4qGIaU6XU06Q/pdE8/BPYRN79uXOW1j3j9qBvIA==
X-Received: by 2002:a63:20e:: with SMTP id 14mr1327440pgc.161.1545377287259;
        Thu, 20 Dec 2018 23:28:07 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:28:06 -0800 (PST)
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
Subject: [PATCH 15/21] PCI: imx6: Restrict PHY register data to 16-bit
Date:   Thu, 20 Dec 2018 23:27:10 -0800
Message-Id: <20181221072716.29017-16-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PHY registers on i.MX6 are 16-bit wide, so we can get rid of explicit
masking if we restrict pcie_phy_read/pcie_phy_write to use 'u16'
instead of 'int'. No functional change intended.

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
 drivers/pci/controller/dwc/pci-imx6.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index ddab1859a07e..98e3730e75fa 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -152,10 +152,10 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
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
@@ -170,8 +170,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 	if (ret)
 		return ret;
 
-	val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
-	*data = val & 0xffff;
+	*data = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
 
 	/* deassert Read signal */
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, 0x00);
@@ -179,7 +178,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 	return pcie_phy_poll_ack(imx6_pcie, 0);
 }
 
-static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
+static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	u32 var;
@@ -236,7 +235,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 
 static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
-	u32 tmp;
+	u16 tmp;
 
 	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
 	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
@@ -547,7 +546,7 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 {
 	unsigned long phy_rate = clk_get_rate(imx6_pcie->pcie_phy);
 	int mult, div;
-	u32 val;
+	u16 val;
 
 	switch (phy_rate) {
 	case 125000000:
-- 
2.19.1

