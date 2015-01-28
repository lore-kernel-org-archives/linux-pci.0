Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:41141 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbbA1UNa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jan 2015 15:13:30 -0500
Received: by mail-oi0-f43.google.com with SMTP id z81so19671594oif.2
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2015 12:13:30 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/3] dts: versatile: add PCI controller binding
Date: Wed, 28 Jan 2015 10:16:17 -0600
Message-Id: <1422461778-6769-3-git-send-email-robh@kernel.org>
In-Reply-To: <1422461778-6769-1-git-send-email-robh@kernel.org>
References: <1422461778-6769-1-git-send-email-robh@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add the PCI controller node for the Versatile/PB board.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/versatile-pb.dts | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/versatile-pb.dts b/arch/arm/boot/dts/versatile-pb.dts
index e36c1e8..b83137f 100644
--- a/arch/arm/boot/dts/versatile-pb.dts
+++ b/arch/arm/boot/dts/versatile-pb.dts
@@ -29,6 +29,43 @@
 			clock-names = "apb_pclk";
 		};
 
+		pci-controller@10001000 {
+			compatible = "arm,versatile-pci";
+			device_type = "pci";
+			reg = <0x10001000 0x1000
+			       0x41000000 0x10000
+			       0x42000000 0x100000>;
+			bus-range = <0 0xff>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+
+			ranges = <0x01000000 0 0x00000000 0x43000000 0 0x00010000   /* downstream I/O */
+				  0x02000000 0 0x50000000 0x50000000 0 0x10000000   /* non-prefetchable memory */
+				  0x42000000 0 0x60000000 0x60000000 0 0x10000000>; /* prefetchable memory */
+
+			interrupt-map-mask = <0x1800 0 0 7>;
+			interrupt-map = <0x1800 0 0 1 &sic 28
+					 0x1800 0 0 2 &sic 29
+					 0x1800 0 0 3 &sic 30
+					 0x1800 0 0 4 &sic 27
+
+					 0x1000 0 0 1 &sic 27
+					 0x1000 0 0 2 &sic 28
+					 0x1000 0 0 3 &sic 29
+					 0x1000 0 0 4 &sic 30
+
+					 0x0800 0 0 1 &sic 30
+					 0x0800 0 0 2 &sic 27
+					 0x0800 0 0 3 &sic 28
+					 0x0800 0 0 4 &sic 29
+
+					 0x0000 0 0 1 &sic 29
+					 0x0000 0 0 2 &sic 30
+					 0x0000 0 0 3 &sic 27
+					 0x0000 0 0 4 &sic 28>;
+		};
+
 		fpga {
 			uart@9000 {
 				compatible = "arm,pl011", "arm,primecell";
-- 
2.1.0

