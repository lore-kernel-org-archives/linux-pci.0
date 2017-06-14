Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33179 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932104AbdFNI0E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jun 2017 04:26:04 -0400
Received: by mail-pg0-f50.google.com with SMTP id f185so72606030pgc.0
        for <linux-pci@vger.kernel.org>; Wed, 14 Jun 2017 01:25:59 -0700 (PDT)
From: Guodong Xu <guodong.xu@linaro.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        wangkefeng.wang@huawei.com, xuejiancheng@hisilicon.com,
        peter.griffin@linaro.org, puck.chen@hisilicon.com,
        lee.jones@linaro.org, ulf.hansson@linaro.org, bhelgaas@google.com,
        arnd@arndb.de
Cc: zhangfei.gao@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org,
        Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH v3 18/21] arm64: dts: hikey960: add device node for pmic and regulators
Date: Wed, 14 Jun 2017 16:23:35 +0800
Message-Id: <20170614082338.15673-19-guodong.xu@linaro.org>
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>

add device node for hi6421 pmic core and hi6421v530
voltage regulator,include LDO(1,3,9,11,15,16)

Signed-off-by: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 46 +++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index ca448f0..e579333 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -97,6 +97,52 @@
 			default-state = "off";
 		};
 	};
+
+	pmic: pmic@fff34000 {
+		compatible = "hisilicon,hi6421v530-pmic";
+		reg = <0x0 0xfff34000 0x0 0x1000>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		regulators {
+			ldo3: LDO3 { /* HDMI */
+				regulator-name = "VOUT3_1V85";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <2200000>;
+				regulator-enable-ramp-delay = <120>;
+			};
+
+			ldo9: LDO9 { /* SDCARD I/O */
+				regulator-name = "VOUT9_1V8_2V95";
+				regulator-min-microvolt = <1750000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <240>;
+			};
+
+			ldo11: LDO11 { /* Low Speed Connector */
+				regulator-name = "VOUT11_1V8_2V95";
+				regulator-min-microvolt = <1750000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <240>;
+			};
+
+			ldo15: LDO15 { /* UFS VCC */
+				regulator-name = "VOUT15_3V0";
+				regulator-min-microvolt = <1750000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-enable-ramp-delay = <120>;
+			};
+
+			ldo16: LDO16 { /* SD VDD */
+				regulator-name = "VOUT16_2V95";
+				regulator-min-microvolt = <1750000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-enable-ramp-delay = <360>;
+			};
+		};
+	};
 };
 
 &i2c0 {
-- 
2.10.2
