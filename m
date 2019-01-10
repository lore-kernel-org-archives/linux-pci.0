Return-Path: <SRS0=9OyC=PS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DBBC43387
	for <linux-pci@archiver.kernel.org>; Thu, 10 Jan 2019 12:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006BD2177B
	for <linux-pci@archiver.kernel.org>; Thu, 10 Jan 2019 12:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfAJM17 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:27:59 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:52769 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727214AbfAJM16 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jan 2019 07:27:58 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id D820B44011A;
        Thu, 10 Jan 2019 14:27:54 +0200 (IST)
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
Subject: [PATCH 1/2] gpio: mvebu: implement get_direction
Date:   Thu, 10 Jan 2019 14:26:21 +0200
Message-Id: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

struct gpio_chip documentation recommends to always implement this
callback function.

A more concrete motivation is to be able (in combination with
GPIOD_ASIS) to detect whether the bootloader has changed the state of a
GPIO signal.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/gpio/gpio-mvebu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 7d5c55494ccd..f97ed32b8beb 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -376,6 +376,16 @@ static int mvebu_gpio_direction_output(struct gpio_chip *chip, unsigned int pin,
 	return 0;
 }
 
+static int mvebu_gpio_get_direction(struct gpio_chip *chip, unsigned int pin)
+{
+	struct mvebu_gpio_chip *mvchip = gpiochip_get_data(chip);
+	u32 u;
+
+	regmap_read(mvchip->regs, GPIO_IO_CONF_OFF + mvchip->offset, &u);
+
+	return !!(u & BIT(pin));
+}
+
 static int mvebu_gpio_to_irq(struct gpio_chip *chip, unsigned int pin)
 {
 	struct mvebu_gpio_chip *mvchip = gpiochip_get_data(chip);
@@ -1130,6 +1140,7 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	mvchip->chip.parent = &pdev->dev;
 	mvchip->chip.request = gpiochip_generic_request;
 	mvchip->chip.free = gpiochip_generic_free;
+	mvchip->chip.get_direction = mvebu_gpio_get_direction;
 	mvchip->chip.direction_input = mvebu_gpio_direction_input;
 	mvchip->chip.get = mvebu_gpio_get;
 	mvchip->chip.direction_output = mvebu_gpio_direction_output;
-- 
2.20.1

