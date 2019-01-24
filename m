Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF32C282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 21:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E1B218A6
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 21:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfAXVoC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:44:02 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:53484 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfAXVoC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jan 2019 16:44:02 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 6438744087E;
        Thu, 24 Jan 2019 23:43:59 +0200 (IST)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Baruch Siach <baruch@tkos.co.il>,
        Sven Auhagen <sven.auhagen@voleatech.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH v2] Revert "PCI: armada8k: Add support for gpio controlled reset signal"
Date:   Thu, 24 Jan 2019 23:42:45 +0200
Message-Id: <fac224459214193f89bbfdc0d058879ace50fe2c.1548366165.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit 3d71746c420c1c1c27cf5c4e48f8fa0a6cfdc185.

That commit breaks boot on Macchiatobin when a Mellanox NIC is in the
PCIe slot.

It turns out that full reset cycle requires first comphy serdes
initialization. Reset signal toggle without comphy initialization makes
access to PCI configuration registers stall indefinitely. U-Boot toggles
the Macchiatobin PCIe reset line already at boot, after initializing the
comphy serdes.

So while commit 3d71746c42 ("PCI: armada8k: Add support for gpio
controlled reset signal") enables PCIe on platforms that U-Boot does
not (yet) touch the reset line (like Clearfog GT-8K), it breaks PCIe
(and boot) on the Macchiatobin.

Revert commit 3d71746c42 ("PCI: armada8k: Add support for gpio
controlled reset signal") entirely for now to fix the Macchaitobin
regression. Proper PCIe reset support would require PCIe comphy setup
support. That must wait for another kernel release.

Reported-by: Sven Auhagen <sven.auhagen@voleatech.de>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v2: Add commit title to commit id mentions
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index b171b6bc15c8..0c389a30ef5d 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -22,7 +22,6 @@
 #include <linux/resource.h>
 #include <linux/of_pci.h>
 #include <linux/of_irq.h>
-#include <linux/gpio/consumer.h>
 
 #include "pcie-designware.h"
 
@@ -30,7 +29,6 @@ struct armada8k_pcie {
 	struct dw_pcie *pci;
 	struct clk *clk;
 	struct clk *clk_reg;
-	struct gpio_desc *reset_gpio;
 };
 
 #define PCIE_VENDOR_REGS_OFFSET		0x8000
@@ -139,12 +137,6 @@ static int armada8k_pcie_host_init(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct armada8k_pcie *pcie = to_armada8k_pcie(pci);
 
-	if (pcie->reset_gpio) {
-		/* assert and then deassert the reset signal */
-		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
-		msleep(100);
-		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
-	}
 	dw_pcie_setup_rc(pp);
 	armada8k_pcie_establish_link(pcie);
 
@@ -257,14 +249,6 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 		goto fail_clkreg;
 	}
 
-	/* Get reset gpio signal and hold asserted (logically high) */
-	pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset",
-						   GPIOD_OUT_HIGH);
-	if (IS_ERR(pcie->reset_gpio)) {
-		ret = PTR_ERR(pcie->reset_gpio);
-		goto fail_clkreg;
-	}
-
 	platform_set_drvdata(pdev, pcie);
 
 	ret = armada8k_add_pcie_port(pcie, pdev);
-- 
2.20.1

