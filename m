Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C6EC43387
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 17:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325A22089F
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 17:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfAGRWb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:22:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35440 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfAGRWb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jan 2019 12:22:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DEB61596;
        Mon,  7 Jan 2019 09:22:30 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F3033F5A0;
        Mon,  7 Jan 2019 09:22:29 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: amlogic: Fix build failure due to missing gpio header
Date:   Mon,  7 Jan 2019 17:22:23 +0000
Message-Id: <20190107172223.28881-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Corentin Labbe <clabbe@baylibre.com>

Building the driver when GPIOLIB=n is not selected is causing the
following compilation failure:

drivers/pci/controller/dwc/pci-meson.c: In function 'meson_pcie_assert_reset':
drivers/pci/controller/dwc/pci-meson.c:290:2: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
  gpiod_set_value_cansleep(mp->reset_gpio, 0);
  ^~~~~~~~~~~~~~~~~~~~~~~~
  gpio_set_value_cansleep
drivers/pci/controller/dwc/pci-meson.c: In function 'meson_pcie_probe':
drivers/pci/controller/dwc/pci-meson.c:540:19: error: implicit declaration of function 'devm_gpiod_get'; did you mean 'devm_gpio_free'? [-Werror=implicit-function-declaration]
  mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
                   ^~~~~~~~~~~~~~
                   devm_gpio_free
drivers/pci/controller/dwc/pci-meson.c:540:48: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_INIT_LOW'?
  mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
                                                ^~~~~~~~~~~~~
                                                GPIOF_INIT_LOW

Add the missing linux/gpio/consumer.h header to fix it.

Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe
controller driver")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
[lorenzo.pieralisi@arm.com: commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 241ebe0c4505..e35e9eaa50ee 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -8,6 +8,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pci.h>
-- 
2.19.2

