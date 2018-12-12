Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76044C65BAF
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 10:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C9B20880
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 10:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C9B20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeLLKV6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:21:58 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57462 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbeLLKV5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Dec 2018 05:21:57 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 073A620734; Wed, 12 Dec 2018 11:21:55 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id 905FB2073D;
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
Subject: [PATCH v2 02/12] PCI: aardvark: Add reset GPIO support
Date:   Wed, 12 Dec 2018 11:21:32 +0100
Message-Id: <20181212102142.16053-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212102142.16053-1-miquel.raynal@bootlin.com>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The IP supports a reset GPIO. When S2RAM will be added, we must ensure
the reset line (if any) is deasserted when resuming. Add support for
it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/pci/controller/pci-aardvark.c | 57 +++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index b95eb2aa00bb..1d31d74ddab7 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
@@ -17,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
+#include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 
 #include "../pci.h"
@@ -201,6 +203,7 @@ struct advk_pcie {
 	u16 msi_msg;
 	int root_bus_nr;
 	struct pci_bridge_emul bridge;
+	struct gpio_desc *reset_gpio;
 };
 
 static inline void advk_writel(struct advk_pcie *pcie, u32 val, u64 reg)
@@ -973,6 +976,55 @@ static int advk_pcie_parse_request_of_pci_ranges(struct advk_pcie *pcie)
 	return err;
 }
 
+static int advk_pcie_hard_reset(struct advk_pcie *pcie)
+{
+	if (!pcie->reset_gpio)
+		return -EINVAL;
+
+	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
+	msleep(1);
+	gpiod_set_value_cansleep(pcie->reset_gpio, 1);
+
+	return 0;
+}
+
+static int advk_pcie_setup_reset_gpio(struct advk_pcie *pcie)
+{
+	struct device *dev = &pcie->pdev->dev;
+	enum of_gpio_flags of_flags;
+	unsigned long gpio_flags;
+	int gpio_nb;
+	int ret;
+
+	gpio_nb = of_get_named_gpio_flags(dev->of_node, "reset-gpios", 0,
+					  &of_flags);
+	if (gpio_nb == -EPROBE_DEFER)
+		return gpio_nb;
+
+	/* Old bindings miss the reset GPIO handle */
+	if (!gpio_is_valid(gpio_nb)) {
+		dev_warn(dev, "Reset GPIO unavailable\n");
+		return 0;
+	}
+
+	if (of_flags & OF_GPIO_ACTIVE_LOW)
+		gpio_flags = GPIOF_ACTIVE_LOW |
+			     GPIOF_OUT_INIT_LOW;
+	else
+		gpio_flags = GPIOF_OUT_INIT_HIGH;
+
+	ret = devm_gpio_request_one(dev, gpio_nb, gpio_flags,
+				    "pcie-aardvark-reset");
+	if (ret) {
+		dev_err(dev, "Failed to retrieve reset GPIO (%d)\n", ret);
+		return ret;
+	}
+
+	pcie->reset_gpio = gpio_to_desc(gpio_nb);
+
+	return 0;
+}
+
 static int advk_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1008,6 +1060,11 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = advk_pcie_setup_reset_gpio(pcie);
+	if (ret)
+		return ret;
+
+	advk_pcie_hard_reset(pcie);
 	advk_pcie_setup_hw(pcie);
 
 	advk_sw_pci_bridge_init(pcie);
-- 
2.19.1

