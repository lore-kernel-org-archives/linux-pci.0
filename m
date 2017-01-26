Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34307 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbdAZN1P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2017 08:27:15 -0500
Received: by mail-lf0-f43.google.com with SMTP id v186so145450185lfa.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Jan 2017 05:27:14 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] pci: host: dra7xx: use GPIO descriptor
Date: Thu, 26 Jan 2017 14:27:07 +0100
Message-Id: <20170126132707.23249-1-linus.walleij@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Instead of parsing around in the device tree and determine
polarity for the GPIO line and whatnot: utilize the GPIO
library's intrinsic handling of OF GPIOs and polarity.

If the line is flagged active low, gpiolib will deal with
this.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Would be nice if someone with the hardware could test this
and see if it works.
---
 drivers/pci/host/pci-dra7xx.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 9595fad63f6f..85ac2856c80f 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -16,7 +16,7 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -320,9 +320,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	char name[10];
-	int gpio_sel;
-	enum of_gpio_flags flags;
-	unsigned long gpio_flags;
+	struct gpio_desc *gpiod;
 
 	dra7xx = devm_kzalloc(dev, sizeof(*dra7xx), GFP_KERNEL);
 	if (!dra7xx)
@@ -388,19 +386,9 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
-	gpio_sel = of_get_gpio_flags(dev->of_node, 0, &flags);
-	if (gpio_is_valid(gpio_sel)) {
-		gpio_flags = (flags & OF_GPIO_ACTIVE_LOW) ?
-				GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH;
-		ret = devm_gpio_request_one(dev, gpio_sel, gpio_flags,
-					    "pcie_reset");
-		if (ret) {
-			dev_err(dev, "gpio%d request failed, ret %d\n",
-				gpio_sel, ret);
-			goto err_gpio;
-		}
-	} else if (gpio_sel == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
+	gpiod = devm_gpiod_get(dev, "pcie_reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod)) {
+		ret = PTR_ERR(gpiod);
 		goto err_gpio;
 	}
 
-- 
2.9.3

