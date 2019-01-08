Return-Path: <SRS0=3dpc=PQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC3FC43612
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 16:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1457B214C6
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 16:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfAHQYu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:24:50 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44884 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728211AbfAHQYu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jan 2019 11:24:50 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CFCE720A13; Tue,  8 Jan 2019 17:24:46 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id 74101209C2;
        Tue,  8 Jan 2019 17:24:46 +0100 (CET)
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
Subject: [PATCH v3 05/15] PCI: aardvark: Add PCIe warm reset support
Date:   Tue,  8 Jan 2019 17:24:30 +0100
Message-Id: <20190108162441.5278-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108162441.5278-1-miquel.raynal@bootlin.com>
References: <20190108162441.5278-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make use of the 'warm reset' register to ensure every peace of
hardware (core, phy, endpoint card) are in a known state before doing
the hardware setup.

The Aardvark IP can trigger a reset signal upon hot reset or link
failure that will only reach the components on the board without
affecting the entire device (eg. only the endpoint card). This line is
multiplexed on MPPs so if it is not used as PCI reset and multiplexed
for instance as a GPIO, the signals produced by the PCIe IP during the
warm reset operation won't affect the state of the line.

As usual, hardware designers can implement a card reset wired to a
GPIO. Support for such reset GPIO will be added in another patch.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/pci/controller/pci-aardvark.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 27ec79defa57..cfe48e553bca 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -139,6 +139,10 @@
 #define     CTRL_MODE_MASK			0x1
 #define     PCIE_CORE_MODE_DIRECT		0x0
 #define     PCIE_CORE_MODE_COMMAND		0x1
+#define CTRL_WARM_RESET_REG			(CTRL_CORE_BASE_ADDR + 0x4)
+#define     CTRL_PCIE_CORE_WARM_RESET		BIT(0)
+#define     CTRL_PHY_CORE_WARM_RESET		BIT(1)
+#define     CTRL_PERSTN_GPIO_EN			BIT(3)
 
 /* PCIe Central Interrupts Registers */
 #define CENTRAL_INT_BASE_ADDR			0x1b000
@@ -249,6 +253,19 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 {
 	u32 reg;
 
+	/* Warm reset */
+	reg = advk_readl(pcie, CTRL_WARM_RESET_REG);
+	reg |= CTRL_PCIE_CORE_WARM_RESET | CTRL_PHY_CORE_WARM_RESET |
+	       CTRL_PERSTN_GPIO_EN;
+	advk_writel(pcie, reg, CTRL_WARM_RESET_REG);
+	reg = advk_readl(pcie, CTRL_WARM_RESET_REG);
+	mdelay(1);
+	reg &= ~(CTRL_PCIE_CORE_WARM_RESET | CTRL_PHY_CORE_WARM_RESET |
+		 CTRL_PERSTN_GPIO_EN);
+	advk_writel(pcie, reg, CTRL_WARM_RESET_REG);
+	reg = advk_readl(pcie, CTRL_WARM_RESET_REG);
+	mdelay(10);
+
 	/* Set HW Reference Clock Buffer Control */
 	advk_writel(pcie, PCIE_PHY_REFCLK_BUF_CTRL, PCIE_PHY_REFCLK);
 
-- 
2.19.1

