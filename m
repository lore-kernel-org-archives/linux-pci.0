Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2475FC04EB8
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 10:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57272086D
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 10:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57272086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeLLKXB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:23:01 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57484 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbeLLKWG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Dec 2018 05:22:06 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B8C5820763; Wed, 12 Dec 2018 11:22:03 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id ED6B020763;
        Wed, 12 Dec 2018 11:21:44 +0100 (CET)
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
Subject: [PATCH v2 03/12] PCI: aardvark: Add PHY support
Date:   Wed, 12 Dec 2018 11:21:33 +0100
Message-Id: <20181212102142.16053-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212102142.16053-1-miquel.raynal@bootlin.com>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The IP needs its PHY to be properly configured to work. While the PHY
is usually already configured by the bootloader, we will need this
feature when adding S2RAM support. Take care of registering and
configuring the PHY from the driver itself.

Suggested-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/pci/controller/pci-aardvark.c | 62 +++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 1d31d74ddab7..da695572a2ed 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -17,6 +17,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/phy/phy.h>
 #include <linux/of_address.h>
 #include <linux/of_gpio.h>
 #include <linux/of_pci.h>
@@ -204,6 +205,7 @@ struct advk_pcie {
 	int root_bus_nr;
 	struct pci_bridge_emul bridge;
 	struct gpio_desc *reset_gpio;
+	struct phy *phy;
 };
 
 static inline void advk_writel(struct advk_pcie *pcie, u32 val, u64 reg)
@@ -1025,6 +1027,62 @@ static int advk_pcie_setup_reset_gpio(struct advk_pcie *pcie)
 	return 0;
 }
 
+static void advk_pcie_disable_phy(struct advk_pcie *pcie)
+{
+	phy_power_off(pcie->phy);
+	phy_exit(pcie->phy);
+}
+
+static int advk_pcie_enable_phy(struct advk_pcie *pcie)
+{
+	int ret;
+
+	if (!pcie->phy)
+		return 0;
+
+	ret = phy_init(pcie->phy);
+	if (ret)
+		return ret;
+
+	ret = phy_set_mode(pcie->phy, PHY_MODE_PCIE);
+	if (ret) {
+		phy_exit(pcie->phy);
+		return ret;
+	}
+
+	ret = phy_power_on(pcie->phy);
+	if (ret) {
+		phy_exit(pcie->phy);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int advk_pcie_setup_phy(struct advk_pcie *pcie)
+{
+	struct device *dev = &pcie->pdev->dev;
+	struct device_node *node = dev->of_node;
+	int ret = 0;
+
+	pcie->phy = devm_of_phy_get(dev, node, NULL);
+	if (IS_ERR(pcie->phy) && (PTR_ERR(pcie->phy) == -EPROBE_DEFER))
+		return PTR_ERR(pcie->phy);
+
+	/* Old bindings miss the PHY handle */
+	if (IS_ERR(pcie->phy)) {
+		dev_warn(dev, "PHY unavailable (%ld)\n", PTR_ERR(pcie->phy));
+		pcie->phy = NULL;
+		return 0;
+	}
+
+	ret = advk_pcie_enable_phy(pcie);
+	if (ret)
+		dev_err(dev, "Failed to initialize PHY (%d)\n", ret);
+
+	return ret;
+}
+
 static int advk_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1060,6 +1118,10 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = advk_pcie_setup_phy(pcie);
+	if (ret)
+		return ret;
+
 	ret = advk_pcie_setup_reset_gpio(pcie);
 	if (ret)
 		return ret;
-- 
2.19.1

