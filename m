Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35792 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdA1Ute (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 Jan 2017 15:49:34 -0500
Received: by mail-lf0-f53.google.com with SMTP id n124so177285530lfd.2
        for <linux-pci@vger.kernel.org>; Sat, 28 Jan 2017 12:49:06 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Janos Laube <janos.dev@gmail.com>,
        Paulius Zaleckas <paulius.zaleckas@gmail.com>,
        openwrt-devel@openwrt.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/4] ARM: gemini: select MIGHT_HAVE_PCI
Date: Sat, 28 Jan 2017 21:48:38 +0100
Message-Id: <20170128204839.18330-3-linus.walleij@linaro.org>
In-Reply-To: <20170128204839.18330-1-linus.walleij@linaro.org>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As we have a PCI driver for the Gemini, we should select
MIGHT_HAVE_PCI.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
PCI maintainers: this is FYI only, I will funnel this to the ARM
SoC tree once we are done with the PCI driver.
---
 arch/arm/mach-gemini/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-gemini/Kconfig b/arch/arm/mach-gemini/Kconfig
index 798abb16bb88..91ea52ccf13c 100644
--- a/arch/arm/mach-gemini/Kconfig
+++ b/arch/arm/mach-gemini/Kconfig
@@ -5,6 +5,7 @@ menuconfig ARCH_GEMINI
 	select GEMINI_TIMER
 	select GPIO_GEMINI
 	select GPIOLIB
+	select MIGHT_HAVE_PCI
 	select POWER_RESET
 	select POWER_RESET_SYSCON
 	select SERIAL_OF_PLATFORM
-- 
2.9.3

