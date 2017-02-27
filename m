Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34353 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbdB0TJx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2017 14:09:53 -0500
Received: by mail-lf0-f50.google.com with SMTP id k202so23734481lfe.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Feb 2017 11:07:57 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Janos Laube <janos.dev@gmail.com>,
        Paulius Zaleckas <paulius.zaleckas@gmail.com>,
        openwrt-devel@openwrt.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Feng-Hsin Chiang <john453@faraday-tech.com>,
        Greentime Hu <green.hu@gmail.com>
Subject: [PATCH 3/4 v3] ARM: gemini: select MIGHT_HAVE_PCI
Date: Mon, 27 Feb 2017 20:07:19 +0100
Message-Id: <20170227190720.31409-3-linus.walleij@linaro.org>
In-Reply-To: <20170227190720.31409-1-linus.walleij@linaro.org>
References: <20170227190720.31409-1-linus.walleij@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As we have a PCI driver for the Gemini, we should select
MIGHT_HAVE_PCI.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Feng-Hsin Chiang <john453@faraday-tech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2->v3:
- No changes

PCI maintainers: this is FYI only, I will funnel this to the ARM
SoC tree once we are done with the PCI driver.
---
 arch/arm/mach-gemini/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-gemini/Kconfig b/arch/arm/mach-gemini/Kconfig
index a5ee5fbab796..21f89a4c16fe 100644
--- a/arch/arm/mach-gemini/Kconfig
+++ b/arch/arm/mach-gemini/Kconfig
@@ -6,6 +6,7 @@ menuconfig ARCH_GEMINI
 	select FTTMR010_TIMER
 	select GPIO_GEMINI
 	select GPIOLIB
+	select MIGHT_HAVE_PCI
 	select POWER_RESET
 	select POWER_RESET_SYSCON
 	select SERIAL_OF_PLATFORM
-- 
2.9.3
