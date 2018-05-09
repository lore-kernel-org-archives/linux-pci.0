Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@linaro.org>
To: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-pci@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom-apq8064: use correct pci address for address translation
Date: Wed,  9 May 2018 14:01:34 +0200
Message-Id: <20180509120135.25940-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For PCI, the second and third cell in ranges specifies the upper and
lower target address for address translation. This target address will
be used to program the internal address translation unit (iATU).

The current device tree configuration will program the iATU to translate
CPU accesses to 0x08000000 to PCI address 0x0 (with TLP type MEM).
The device tree configuration also specifies that CPU acesses to
0x0fe00000 will be translated to PCI address 0x0 (with TLP type I/O).

We cannot have both I/O space and memory space at PCI address 0x0.

The PCI code already uses the CPU address when assigning addresses to
memory BARs, so for memory space the PCI address should be the same as
the CPU address. This also matches how all other device trees using
snps,dw-pcie are configured.

The existing configuration appears to work, even if it is incorrect.
For some reason the iATU doesn't obey the existing configuration,
and doesn't translate CPU accesses from 0x08000000 to PCI address 0x0.

The reason why the existing configuration works at all is probably
because the default behavior, when there is no match, is to use the
untranslated address. This happens to work for memory space, since
it's a 1:1 mapping. However, instead of relying on this behavior,
let's configure the iATU correctly.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 5341a39c0392..148cf7e565f6 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -1417,7 +1417,7 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 			ranges = <0x81000000 0 0 0x0fe00000 0 0x00100000   /* I/O */
-				  0x82000000 0 0 0x08000000 0 0x07e00000>; /* memory */
+				  0x82000000 0 0x08000000 0x08000000 0 0x07e00000>; /* memory */
 			interrupts = <GIC_SPI 238 IRQ_TYPE_NONE>;
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
-- 
2.17.0
