Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35798 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbdA1Ute (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 Jan 2017 15:49:34 -0500
Received: by mail-lf0-f43.google.com with SMTP id n124so177285781lfd.2
        for <linux-pci@vger.kernel.org>; Sat, 28 Jan 2017 12:49:14 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Janos Laube <janos.dev@gmail.com>,
        Paulius Zaleckas <paulius.zaleckas@gmail.com>,
        openwrt-devel@openwrt.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/4] ARM: dts: add PCI to the Gemini DTSI
Date: Sat, 28 Jan 2017 21:48:39 +0100
Message-Id: <20170128204839.18330-4-linus.walleij@linaro.org>
In-Reply-To: <20170128204839.18330-1-linus.walleij@linaro.org>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Cortina Gemini has an internal PCI root bus, add this to
the device tree.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
PCI maintainers: this is FYI only, I will funnel this to the ARM
SoC tree once we are done with the PCI driver.
---
 arch/arm/boot/dts/gemini.dtsi | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index 405d6cedf409..df5630958038 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -99,4 +99,49 @@
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
+
+	pci@50000000 {
+		compatible = "cortina,gemini-pci";
+		reg = <0x50000000 0x100>;
+		interrupts = <8 IRQ_TYPE_LEVEL_HIGH>, /* PCI A */
+				<26 IRQ_TYPE_LEVEL_HIGH>, /* PCI B */
+				<27 IRQ_TYPE_LEVEL_HIGH>, /* PCI C */
+				<28 IRQ_TYPE_LEVEL_HIGH>; /* PCI D */
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+
+		bus-range = <0x00 0x00>; /* Only root bus */
+		/* PCI ranges mappings */
+		ranges = /* 1MiB I/O space 0x50000000-0x500fffff */
+			 <0x01000000 0 0          0x50000000 0 0x00100000>,
+			 /* 128MiB non-prefetchable memory 0x58000000-0x5fffffff */
+			 <0x02000000 0 0x58000000 0x58000000 0 0x08000000>;
+
+		interrupt-map-mask = <0xff00 0 0 7>;
+		/*
+		 * The interrupt map is done by sub-device and per-slot.
+		 */
+		interrupt-map = <0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
+				<0x4900 0 0 2 &pci_intc 1>,
+				<0x4a00 0 0 3 &pci_intc 2>,
+				<0x4b00 0 0 4 &pci_intc 3>,
+				<0x5000 0 0 1 &pci_intc 0>, /* Slot 10 */
+				<0x5100 0 0 2 &pci_intc 1>,
+				<0x5200 0 0 3 &pci_intc 2>,
+				<0x5300 0 0 4 &pci_intc 3>,
+				<0x5800 0 0 1 &pci_intc 0>, /* Slot 11 */
+				<0x5900 0 0 2 &pci_intc 1>,
+				<0x5a00 0 0 3 &pci_intc 2>,
+				<0x5b00 0 0 4 &pci_intc 3>,
+				<0x6000 0 0 1 &pci_intc 0>, /* Slot 12 */
+				<0x6100 0 0 2 &pci_intc 1>,
+				<0x6200 0 0 3 &pci_intc 2>,
+				<0x6300 0 0 4 &pci_intc 3>;
+		pci_intc: interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+		};
+	};
 };
-- 
2.9.3

