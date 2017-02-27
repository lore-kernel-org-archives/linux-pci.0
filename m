Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36574 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbdB0TJx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2017 14:09:53 -0500
Received: by mail-lf0-f45.google.com with SMTP id y193so9302088lfd.3
        for <linux-pci@vger.kernel.org>; Mon, 27 Feb 2017 11:08:01 -0800 (PST)
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
Subject: [PATCH 4/4 v3] ARM: dts: add PCI to the Gemini device trees
Date: Mon, 27 Feb 2017 20:07:20 +0100
Message-Id: <20170227190720.31409-4-linus.walleij@linaro.org>
In-Reply-To: <20170227190720.31409-1-linus.walleij@linaro.org>
References: <20170227190720.31409-1-linus.walleij@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Cortina Gemini has an internal PCI root bus, add this to
the device tree, and add interrupt mapping (swizzling) to the
relevant systems device trees.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Feng-Hsin Chiang <john453@faraday-tech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Change compatible string to "cortina,gemini-pci", "faraday,ftpci100";
- Add "dma-ranges" property, after deciphering that some hardcoded
  constants in the driver is really about this.
ChangeLog v1->v2:
- Change bus-range to <0x00 0xff>
- Drop the three extra IRQs that are unused
- Implement the right interrupt mapping/swizzling
- Push the interrupt mapping down to each affected system, only
  SQ201 for now.

PCI maintainers: this is FYI only, I will funnel this to the ARM
SoC tree once we are done with the PCI driver.
---
 arch/arm/boot/dts/gemini-sq201.dts | 22 ++++++++++++++++++++
 arch/arm/boot/dts/gemini.dtsi      | 42 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/arch/arm/boot/dts/gemini-sq201.dts b/arch/arm/boot/dts/gemini-sq201.dts
index dae2a70d8fbc..46309e79cc7b 100644
--- a/arch/arm/boot/dts/gemini-sq201.dts
+++ b/arch/arm/boot/dts/gemini-sq201.dts
@@ -92,5 +92,27 @@
 				read-only;
 			};
 		};
+
+		pci@50000000 {
+			status = "okay";
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map =
+				<0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
+				<0x4800 0 0 2 &pci_intc 1>,
+				<0x4800 0 0 3 &pci_intc 2>,
+				<0x4800 0 0 4 &pci_intc 3>,
+				<0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
+				<0x5000 0 0 2 &pci_intc 2>,
+				<0x5000 0 0 3 &pci_intc 3>,
+				<0x5000 0 0 4 &pci_intc 0>,
+				<0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
+				<0x5800 0 0 2 &pci_intc 3>,
+				<0x5800 0 0 3 &pci_intc 0>,
+				<0x5800 0 0 4 &pci_intc 1>,
+				<0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
+				<0x6000 0 0 2 &pci_intc 0>,
+				<0x6000 0 0 3 &pci_intc 1>,
+				<0x6000 0 0 4 &pci_intc 2>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index 3876feefc9d9..918e46546823 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -104,5 +104,47 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		pci@50000000 {
+			compatible = "cortina,gemini-pci", "faraday,ftpci100";
+			/*
+			 * The first 256 bytes in the IO range is actually used
+			 * to configure the host bridge.
+			 */
+			reg = <0x50000000 0x100>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			status = "disabled";
+
+			bus-range = <0x00 0xff>;
+			/* PCI ranges mappings */
+			ranges =
+			/* 1MiB I/O space 0x50000000-0x500fffff */
+			<0x01000000 0 0          0x50000000 0 0x00100000>,
+			/* 128MiB non-prefetchable memory 0x58000000-0x5fffffff */
+			<0x02000000 0 0x58000000 0x58000000 0 0x08000000>;
+
+			/* DMA ranges */
+			dma-ranges =
+			/* 128MiB at 0x00000000-0x07ffffff */
+			<0x02000000 0 0x00000000 0x00000000 0 0x08000000>,
+			/* 64MiB at 0x00000000-0x03ffffff */
+			<0x02000000 0 0x00000000 0x00000000 0 0x04000000>,
+			/* 64MiB at 0x00000000-0x03ffffff */
+			<0x02000000 0 0x00000000 0x00000000 0 0x04000000>;
+
+			/*
+			 * This PCI host bridge variant has a cascaded interrupt
+			 * controller embedded in the host bridge.
+			 */
+			pci_intc: interrupt-controller {
+				interrupt-parent = <&intcon>;
+				interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
 	};
 };
-- 
2.9.3
