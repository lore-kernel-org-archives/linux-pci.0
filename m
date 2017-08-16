Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Tony Lindgren <tony@atomide.com>
Subject: [PATCH v2 06/10] ARM: dts: am571x-idk: Add pinmux configuration for
 MMC
Date: Wed, 16 Aug 2017 19:15:04 +0530
Message-ID: <20170816134508.8887-7-kishon@ti.com>
In-Reply-To: <20170816134508.8887-1-kishon@ti.com>
References: <20170816134508.8887-1-kishon@ti.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, kishon@ti.com, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Include dra72x-mmc-iodelay.dtsi which has pinmux and IODelay
configuration values for the various MMC modes for dra72 SoC
and use it in the pinctrl properties of MMC devicetree
nodes present in am571x-idk.dts.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am571x-idk.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index 78c5c7462fcc..debf9464403e 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -11,6 +11,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include "am57xx-idk-common.dtsi"
+#include "dra72x-mmc-iodelay.dtsi"
 
 / {
 	model = "TI AM5718 IDK";
@@ -98,3 +99,21 @@
 &pcie1_ep {
 	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
 };
+
+&mmc1 {
+	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50", "sdr104";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_hs>;
+	pinctrl-2 = <&mmc1_pins_sdr12>;
+	pinctrl-3 = <&mmc1_pins_sdr25>;
+	pinctrl-4 = <&mmc1_pins_sdr50>;
+	pinctrl-5 = <&mmc1_pins_ddr50_rev20 &mmc1_iodelay_ddr50_conf>;
+	pinctrl-6 = <&mmc1_pins_sdr104 &mmc1_iodelay_sdr104_rev20_conf>;
+};
+
+&mmc2 {
+	pinctrl-names = "default", "hs", "ddr_1_8v";
+	pinctrl-0 = <&mmc2_pins_default>;
+	pinctrl-1 = <&mmc2_pins_hs>;
+	pinctrl-2 = <&mmc2_pins_ddr_rev20 &mmc2_iodelay_ddr_conf>;
+};
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
