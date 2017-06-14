Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Guodong Xu <guodong.xu@linaro.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com,
 catalin.marinas@arm.com, will.deacon@arm.com, wangkefeng.wang@huawei.com,
 xuejiancheng@hisilicon.com, peter.griffin@linaro.org,
 puck.chen@hisilicon.com, lee.jones@linaro.org, ulf.hansson@linaro.org,
 bhelgaas@google.com, arnd@arndb.de
Subject: [PATCH v3 10/21] arm64: dts: hi3660: add power key dts node
Date: Wed, 14 Jun 2017 16:23:27 +0800
Message-Id: <20170614082338.15673-11-guodong.xu@linaro.org>
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Guodong Xu <guodong.xu@linaro.org>,
 linux-pci@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
 Chen Jun <chenjun14@huawei.com>, zhangfei.gao@linaro.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Chen Jun <chenjun14@huawei.com>

We use gpio_034 as power key on hikey960, and set gpio with pull-up
state, when key press the voltage on the gpio will come to lower, and
power key event will be reported.

Signed-off-by: Chen Jun <chenjun14@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index c25fff9..7aac35b 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -10,6 +10,8 @@
 #include "hi3660.dtsi"
 #include "hikey960-pinctrl.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "HiKey960";
@@ -34,6 +36,19 @@
 		/* rewrite this at bootloader */
 		reg = <0x0 0x0 0x0 0x0>;
 	};
+
+	keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwr_key_pmx_func &pwr_key_cfg_func>;
+
+		power {
+			wakeup-source;
+			gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
+			label = "GPIO Power";
+			linux,code = <KEY_POWER>;
+		};
+	};
 };
 
 &i2c0 {
-- 
2.10.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
