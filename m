Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Gavin Guo <gavinguo@andestech.com>, Macpaul Lin <macpaul@andestech.com>
Subject: [PATCH 3/4] ARM: gemini: select MIGHT_HAVE_PCI
Date: Sat, 11 Feb 2017 13:52:19 +0100
Message-Id: <20170211125220.10273-3-linus.walleij@linaro.org>
In-Reply-To: <20170211125220.10273-1-linus.walleij@linaro.org>
References: <20170211125220.10273-1-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: openwrt-devel@openwrt.org, Feng-Hsin Chiang <john453@faraday-tech.com>,
 Paulius Zaleckas <paulius.zaleckas@gmail.com>, linux-pci@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>, Janos Laube <janos.dev@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

As we have a PCI driver for the Gemini, we should select
MIGHT_HAVE_PCI.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Gavin Guo <gavinguo@andestech.com>
Cc: Macpaul Lin <macpaul@andestech.com>
Cc: Feng-Hsin Chiang <john453@faraday-tech.com>
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


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
