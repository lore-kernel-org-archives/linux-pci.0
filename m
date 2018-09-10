Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shell.v3.sk ([90.176.6.54]:36033 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbeIJQxq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Sep 2018 12:53:46 -0400
From: Lubomir Rintel <lkundrak@v3.sk>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 1/5] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI Controller
Date: Mon, 10 Sep 2018 13:59:31 +0200
Message-Id: <20180910115935.163121-2-lkundrak@v3.sk>
In-Reply-To: <20180910115935.163121-1-lkundrak@v3.sk>
References: <20180910115935.163121-1-lkundrak@v3.sk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is the SPI controller found on Marvel MMP2 and perhaps more
platforms.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../devicetree/bindings/spi/spi-pxa2xx.txt    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-pxa2xx.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
new file mode 100644
index 000000000000..75be87cf9909
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
@@ -0,0 +1,24 @@
+PXA2xx SSP SPI Controller
+
+Required properties:
+- compatible: Must be "marvell,mmp2-ssp".
+- reg: Offset and length of the device's register set.
+- interrupts: Should be the interrupt number.
+- clocks: Should contain a single entry describing the clock input.
+- #address-cells:  Number of cells required to define a chip select address.
+- #size-cells: Should be zero.
+
+Optional properties:
+- cs-gpios: list of GPIO chip selects. See the SPI bus bindings,
+  Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Child nodes represent devices on the SPI bus
+  See ../spi/spi-bus.txt
+
+Example:
+	ssp1: ssp@d4035000 {
+		compatible = "marvell,mmp2-ssp";
+		reg = <0xd4035000 0x1000>;
+		clocks = <&soc_clocks MMP2_CLK_SSP0>;
+		interrupts = <0>;
+	};
-- 
2.17.1
