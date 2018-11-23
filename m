Return-Path: <SRS0=PFnE=OC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CDFC43441
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 14:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6B220664
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 14:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6B220664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436667AbeKXBDA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:03:00 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33917 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388505AbeKXBC7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Nov 2018 20:02:59 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E019D207BB; Fri, 23 Nov 2018 15:18:34 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7E06520791;
        Fri, 23 Nov 2018 15:18:34 +0100 (CET)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 01/12] PCI: aardvark: configure more registers in the configuration helper
Date:   Fri, 23 Nov 2018 15:18:20 +0100
Message-Id: <20181123141831.8214-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123141831.8214-1-miquel.raynal@bootlin.com>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Mimic U-Boot configuration to be sure all hardware registers are set
properly. This will be needed for future S2RAM operation.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/pci/controller/pci-aardvark.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 750081c1cb48..b95eb2aa00bb 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -100,6 +100,8 @@
 #define     PCIE_CORE_CTRL2_STRICT_ORDER_ENABLE	BIT(5)
 #define     PCIE_CORE_CTRL2_OB_WIN_ENABLE	BIT(6)
 #define     PCIE_CORE_CTRL2_MSI_ENABLE		BIT(10)
+#define PCIE_PHY_REFCLK				(CONTROL_BASE_ADDR + 0x14)
+#define     PCIE_PHY_REFCLK_BUF_CTRL		0x1342
 #define PCIE_MSG_LOG_REG			(CONTROL_BASE_ADDR + 0x30)
 #define PCIE_ISR0_REG				(CONTROL_BASE_ADDR + 0x40)
 #define PCIE_MSG_PM_PME_MASK			BIT(7)
@@ -243,6 +245,9 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 {
 	u32 reg;
 
+	/* Set HW Reference Clock Buffer Control */
+	advk_writel(pcie, PCIE_PHY_REFCLK_BUF_CTRL, PCIE_PHY_REFCLK);
+
 	/* Set to Direct mode */
 	reg = advk_readl(pcie, CTRL_CONFIG_REG);
 	reg &= ~(CTRL_MODE_MASK << CTRL_MODE_SHIFT);
@@ -274,6 +279,15 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 		PCIE_CORE_CTRL2_TD_ENABLE;
 	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
 
+	/* Set PCIe Device Control and Status 1 PF0 register */
+	reg = PCIE_CORE_DEV_CTRL_STATS_RELAX_ORDER_DISABLE |
+		PCIE_CORE_DEV_CTRL_STATS_SNOOP_DISABLE;
+	advk_writel(pcie, reg, PCIE_CORE_DEV_CTRL_STATS_REG);
+
+	/* Program PCIe Control 2 to disable strict ordering */
+	reg = PCIE_CORE_CTRL2_RESERVED | PCIE_CORE_CTRL2_TD_ENABLE;
+	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
+
 	/* Set GEN2 */
 	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
 	reg &= ~PCIE_GEN_SEL_MSK;
-- 
2.19.1

