Return-Path: <SRS0=9OyC=PS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A90C43612
	for <linux-pci@archiver.kernel.org>; Thu, 10 Jan 2019 12:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D3A21773
	for <linux-pci@archiver.kernel.org>; Thu, 10 Jan 2019 12:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfAJM17 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:27:59 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:52784 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbfAJM17 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jan 2019 07:27:59 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 806E544087E;
        Thu, 10 Jan 2019 14:27:55 +0200 (IST)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Sven Auhagen <sven.auhagen@voleatech.de>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH 2/2] PCI: armada8k: don't toggle reset twice
Date:   Thu, 10 Jan 2019 14:26:22 +0200
Message-Id: <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 3d71746c42 ("PCI: armada8k: Add support for gpio controlled reset
signal") added reset signal support. Reset is unconditionally asserted
and deasserted.

Unfortunately, that commit breaks boot on Macchiatobin when a Mellanox
NIC is in the PCIe slot.

It turns out that you can toggle the reset signal only once. Another
reset signal toggle makes access to PCI configuration registers stall
indefinitely. U-Boot toggles the Macchiatobin PCIe reset line already at
boot.

Detect whether the bootloader changed the reset signal state using the
get_direction operation. If direction is output don't touch the reset
signal again. Otherwise, set direction to output and keep the reset
asserted.

Reported-by: Sven Auhagen <sven.auhagen@voleatech.de>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---

This patch depends on the mvebu get_direction implementation in the
patch #1 of this series. Since get_direction implementation is not a
pure fix it might be considered unfit for v5.0. In that case I'm OK with
reverting 3d71746c42 in v5.0 to fix the Macchiatobin regression, and
postpone this series to v5.1.
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index b171b6bc15c8..132a86a1e1e7 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -257,12 +257,23 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 		goto fail_clkreg;
 	}
 
-	/* Get reset gpio signal and hold asserted (logically high) */
+	/* Get reset gpio signal, don't change its setting */
 	pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset",
-						   GPIOD_OUT_HIGH);
+						   GPIOD_ASIS);
 	if (IS_ERR(pcie->reset_gpio)) {
 		ret = PTR_ERR(pcie->reset_gpio);
 		goto fail_clkreg;
+	} else if (pcie->reset_gpio &&
+			gpiod_get_direction(pcie->reset_gpio) == 0) {
+		/* Reset signal is output. The bootloader has deasserted reset
+		 * signal already. Don't do it again.
+		 */
+		dev_info(dev, "%s: leave reset signal unchanged\n", __func__);
+		devm_gpiod_put(dev, pcie->reset_gpio);
+		pcie->reset_gpio = NULL;
+	} else if (pcie->reset_gpio) {
+		/* Assert reset */
+		gpiod_direction_output(pcie->reset_gpio, 1);
 	}
 
 	platform_set_drvdata(pdev, pcie);
-- 
2.20.1

