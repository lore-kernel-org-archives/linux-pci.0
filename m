Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35650 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbdBEKDT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Feb 2017 05:03:19 -0500
Received: by mail-wr0-f196.google.com with SMTP id o16so1093256wra.2
        for <linux-pci@vger.kernel.org>; Sun, 05 Feb 2017 02:03:18 -0800 (PST)
Date: Sun, 5 Feb 2017 11:03:14 +0100 (CET)
From: Hans Ulli Kroll <ulli.kroll@googlemail.com>
To: Linus Walleij <linus.walleij@linaro.org>
cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Janos Laube <janos.dev@gmail.com>,
        Paulius Zaleckas <paulius.zaleckas@gmail.com>,
        openwrt-devel@openwrt.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] ARM: dts: add PCI to the Gemini DTSI
In-Reply-To: <20170128204839.18330-4-linus.walleij@linaro.org>
Message-ID: <alpine.LNX.2.00.1702051101110.26313@T420s>
References: <20170128204839.18330-1-linus.walleij@linaro.org> <20170128204839.18330-4-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus

We need to the remove hwirq 26-28 from DT.
First one will print this warning while boot.

irq: type mismatch, failed to map hwirq-26 for /soc/interrupt-controller@48000000!

 arch/arm/boot/dts/gemini.dtsi | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index 11441e577058..0e2c021cd8c5 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -114,10 +114,7 @@
 		pci@50000000 {
 			compatible = "cortina,gemini-pci";
 			reg = <0x50000000 0x100>;
-			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>, /* PCI A */
-				   	<26 IRQ_TYPE_LEVEL_HIGH>, /* PCI B */
-					<27 IRQ_TYPE_LEVEL_HIGH>, /* PCI C */
-					<28 IRQ_TYPE_LEVEL_HIGH>; /* PCI D */
+			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>; /* chained irq PCI A-D */
 			#address-cells = <3>;
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
-- 
2.11.0
