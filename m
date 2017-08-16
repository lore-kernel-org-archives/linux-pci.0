Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Tony Lindgren <tony@atomide.com>
Subject: [PATCH v2 03/10] ARM: dts: dra7-evm: Add pinmux configuration for MMC
Date: Wed, 16 Aug 2017 19:15:01 +0530
Message-ID: <20170816134508.8887-4-kishon@ti.com>
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

Include dra74x-mmc-iodelay.dtsi which has pinmux and IODelay
configuration values for the various MMC modes for dra74 SoC
and use it in the pinctrl properties of MMC devicetree
nodes present in dra7-evm.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 5e3f9ba861f0..aa426dabb6c3 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -9,6 +9,7 @@
 
 #include "dra74x.dtsi"
 #include "dra7-evm-common.dtsi"
+#include "dra74x-mmc-iodelay.dtsi"
 
 / {
 	model = "TI DRA742";
@@ -326,8 +327,6 @@
 
 &mmc1 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_default>;
 	vmmc-supply = <&evm_3v3_sd>;
 	vqmmc-supply = <&ldo1_reg>;
 	bus-width = <4>;
@@ -336,14 +335,29 @@
 	 * is always hardwired.
 	 */
 	cd-gpios = <&gpio6 27 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50-rev11", "sdr104-rev11", "ddr50", "sdr104";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_hs>;
+	pinctrl-2 = <&mmc1_pins_sdr12>;
+	pinctrl-3 = <&mmc1_pins_sdr25>;
+	pinctrl-4 = <&mmc1_pins_sdr50>;
+	pinctrl-5 = <&mmc1_pins_ddr50 &mmc1_iodelay_ddr_rev11_conf>;
+	pinctrl-6 = <&mmc1_pins_sdr104 &mmc1_iodelay_sdr104_rev11_conf>;
+	pinctrl-7 = <&mmc1_pins_ddr50 &mmc1_iodelay_ddr_rev20_conf>;
+	pinctrl-8 = <&mmc1_pins_sdr104 &mmc1_iodelay_sdr104_rev20_conf>;
 };
 
 &mmc2 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins_default>;
 	vmmc-supply = <&evm_1v8_sw>;
 	bus-width = <8>;
+	pinctrl-names = "default", "hs", "ddr_1_8v-rev11", "ddr_1_8v", "hs200_1_8v-rev11", "hs200_1_8v";
+	pinctrl-0 = <&mmc2_pins_default>;
+	pinctrl-1 = <&mmc2_pins_hs>;
+	pinctrl-2 = <&mmc2_pins_ddr_1_8v_rev11 &mmc2_iodelay_ddr_1_8v_rev11_conf>;
+	pinctrl-3 = <&mmc2_pins_ddr_rev20>;
+	pinctrl-4 = <&mmc2_pins_hs200 &mmc2_iodelay_hs200_rev11_conf>;
+	pinctrl-5 = <&mmc2_pins_hs200 &mmc2_iodelay_hs200_rev20_conf>;
 };
 
 &cpu0 {
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
