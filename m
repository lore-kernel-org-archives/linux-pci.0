Return-Path: <SRS0=Fxx+=57=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB929C2BA19
	for <linux-pci@archiver.kernel.org>; Wed, 15 Apr 2020 16:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB66216FD
	for <linux-pci@archiver.kernel.org>; Wed, 15 Apr 2020 16:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586966647;
	bh=1YUfEX82K+60B/zqLyakfZdfKZRyfg4LKtcOqbCXQzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0zDAr7+T8K2dXarpvCoJ/lGOryl7T9NYReKRVVaI/+8jRwqdNLJ0w9AZhVeFZC5ug
	 5e1gd7DVvizvtVbr6etxwabw9g73eWGeEnr5RWsEOP2ryfPp8THUXo+vgdU+3UzraQ
	 SEPv29M2jX2VN/vryZxHnOTNF6oh0jqdCS9KaU2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410158AbgDOQEE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410149AbgDOQEB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Apr 2020 12:04:01 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5226D21569;
        Wed, 15 Apr 2020 16:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586966641;
        bh=1YUfEX82K+60B/zqLyakfZdfKZRyfg4LKtcOqbCXQzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oa/43f04xATTEKSed4AMeN63fKk4K3aKweuLUoPUwwjQkSTtSVG7VuVXkJHNZSeAs
         pYfOo6c/V3czlZsEwhc72gYlkVG5Hbr46KQot3RqHzKfm6bRPIgCIWobAcdI59aUzV
         LQZKo/WMZLMRG0/g7B43HU4habRvHXSmk8nI4bVI=
Received: by pali.im (Postfix)
        id 85BD258E; Wed, 15 Apr 2020 18:03:59 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 6/8] PCI: aardvark: Add support for issuing PERST via GPIO
Date:   Wed, 15 Apr 2020 18:03:46 +0200
Message-Id: <20200415160348.1146-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415160054.951-1-pali@kernel.org>
References: <20200415160054.951-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

bindings/pci/pci.txt defines standard DT property reset-gpios for
specifying PERST GPIO. Read this property from Device Tree via
devm_gpiod_get_from_of_node() function. As this property is optional,
function may return -ENOENT. During initialization of aardvark PCI
controller toggle supplied GPIO to issue PERST.

Some Compex ath10k cards (e.g. WLE900VX or WLE1216) are not detected after
reboot when PERST is not issued during driver initialization. And Compex
WLE1216 cards need to be in reset state for at least 1ms otherwise they are
not detected too.

Tested on Turris MOX and after this change Compex cards are detected also
after rebooting board.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 30 ++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index a83bbc86e428..6a97a3838098 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
@@ -18,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
+#include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 
 #include "../pci.h"
@@ -203,6 +205,7 @@ struct advk_pcie {
 	u16 msi_msg;
 	int root_bus_nr;
 	struct pci_bridge_emul bridge;
+	struct gpio_desc *reset_gpio;
 };
 
 static inline void advk_writel(struct advk_pcie *pcie, u32 val, u64 reg)
@@ -280,6 +283,14 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	int max_link_speed, neg_link_speed;
 	u32 reg;
 
+	if (pcie->reset_gpio) {
+		dev_info(dev, "issuing PERST via reset GPIO for 1ms\n");
+		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
+		/* Detection of some Compex WLE1216 cards needs at least 1ms */
+		mdelay(1);
+		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
+	}
+
 	/* Set to Direct mode */
 	reg = advk_readl(pcie, CTRL_CONFIG_REG);
 	reg &= ~(CTRL_MODE_MASK << CTRL_MODE_SHIFT);
@@ -358,7 +369,8 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 
 	/*
 	 * PERST# signal could have been asserted by pinctrl subsystem before
-	 * probe() callback has been called, making the endpoint going into
+	 * probe() callback has been called or issued explicitly by reset gpio
+	 * routine at beginning of this function, making the endpoint going into
 	 * fundamental reset. As required by PCI Express spec a delay for at
 	 * least 100ms after such a reset before link training is needed.
 	 */
@@ -1043,6 +1055,22 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	}
 	pcie->root_bus_nr = bus->start;
 
+	/* Returns -ENOENT if reset-gpios property is not populated */
+	pcie->reset_gpio = devm_gpiod_get_from_of_node(dev, dev->of_node,
+						       "reset-gpios", 0,
+						       GPIOD_OUT_LOW,
+						       "pcie1-reset");
+	if (IS_ERR(pcie->reset_gpio)) {
+		if (PTR_ERR(pcie->reset_gpio) == -ENOENT) {
+			pcie->reset_gpio = NULL;
+		} else {
+			if (PTR_ERR(pcie->reset_gpio) != -EPROBE_DEFER)
+				dev_err(dev, "Failed to retrieve reset GPIO (%ld)\n",
+					PTR_ERR(pcie->reset_gpio));
+			return PTR_ERR(pcie->reset_gpio);
+		}
+	}
+
 	advk_pcie_setup_hw(pcie);
 
 	advk_sw_pci_bridge_init(pcie);
-- 
2.20.1

