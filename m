Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Tony Lindgren <tony@atomide.com>
CC: <kishon@ti.com>, <nsekhar@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 05/10] ARM: dts: am57xx-idk: Move common MMC/SD properties to common file
Date: Wed, 16 Aug 2017 19:15:03 +0530
Message-ID: <20170816134508.8887-6-kishon@ti.com>
In-Reply-To: <20170816134508.8887-1-kishon@ti.com>
References: <20170816134508.8887-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Sekhar Nori <nsekhar@ti.com>

AM572x IDK and AM571x IDK boards have equivalent
design of how SD card and eMMC are connected.

The two EVMs mainly differ in IOdelay configuration
needed (because of difference in SoC used).

Move the common properties to am57xx-idk-common.dtsi
file which is common for both EVMs.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am571x-idk.dts         | 7 -------
 arch/arm/boot/dts/am572x-idk.dts         | 8 --------
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 8 ++++++++
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index 0c0bb4e93f25..78c5c7462fcc 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -64,13 +64,6 @@
 	};
 };
 
-&mmc1 {
-	status = "okay";
-	vmmc-supply = <&ldo1_reg>;
-	bus-width = <4>;
-	cd-gpios = <&gpio6 27 GPIO_ACTIVE_LOW>; /* gpio 219 */
-};
-
 &omap_dwc3_2 {
 	extcon = <&extcon_usb2>;
 };
diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index 604d52554eda..5b22944fedad 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -76,14 +76,6 @@
 	vbus-gpio = <&gpio3 26 GPIO_ACTIVE_HIGH>;
 };
 
-&mmc1 {
-	status = "okay";
-	vmmc-supply = <&v3_3d>;
-	vqmmc-supply = <&ldo1_reg>;
-	bus-width = <4>;
-	cd-gpios = <&gpio6 27 GPIO_ACTIVE_LOW>; /* gpio 219 */
-};
-
 &sn65hvs882 {
 	load-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
 };
diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index c536b2f5389f..97aa8e6a56da 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -399,6 +399,14 @@
 	dr_mode = "peripheral";
 };
 
+&mmc1 {
+	status = "okay";
+	vmmc-supply = <&v3_3d>;
+	vqmmc-supply = <&ldo1_reg>;
+	bus-width = <4>;
+	cd-gpios = <&gpio6 27 GPIO_ACTIVE_LOW>; /* gpio 219 */
+};
+
 &mmc2 {
 	status = "okay";
 	vmmc-supply = <&v3_3d>;
-- 
2.11.0
