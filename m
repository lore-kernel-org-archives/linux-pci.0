Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:10807 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726AbbGNBjS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2015 21:39:18 -0400
From: Ray Jui <rjui@broadcom.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
CC: <linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, Ray Jui <rjui@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>
Subject: [PATCH 4/4] arm64: dts: Add Broadcom North Star 2 support
Date: Mon, 13 Jul 2015 18:39:15 -0700
Message-ID: <1436837955-26279-5-git-send-email-rjui@broadcom.com>
In-Reply-To: <1436837955-26279-1-git-send-email-rjui@broadcom.com>
References: <1436837955-26279-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add Broadcom NS2 device tree binding document. Also add initial device
tree dtsi for Broadcom North Star 2 (NS2) SoC and board support for NS2
SVK board

Signed-off-by: Jon Mason <jonmason@broadcom.com>
Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 Documentation/devicetree/bindings/arm/bcm/ns2.txt |    9 ++
 arch/arm64/boot/dts/Makefile                      |    1 +
 arch/arm64/boot/dts/broadcom/Makefile             |    5 ++
 arch/arm64/boot/dts/broadcom/ns2-svk.dts          |   55 ++++++++++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi             |   95 +++++++++++++++++++++
 5 files changed, 165 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/ns2.txt
 create mode 100644 arch/arm64/boot/dts/broadcom/Makefile
 create mode 100644 arch/arm64/boot/dts/broadcom/ns2-svk.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/ns2.dtsi

diff --git a/Documentation/devicetree/bindings/arm/bcm/ns2.txt b/Documentation/devicetree/bindings/arm/bcm/ns2.txt
new file mode 100644
index 0000000..35f056f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/ns2.txt
@@ -0,0 +1,9 @@
+Broadcom North Star 2 (NS2) device tree bindings
+------------------------------------------------
+
+Boards with NS2 shall have the following properties:
+
+Required root node property:
+
+NS2 SVK board
+compatible = "brcm,ns2-svk", "brcm,ns2";
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 38913be..9f95941 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -1,6 +1,7 @@
 dts-dirs += amd
 dts-dirs += apm
 dts-dirs += arm
+dts-dirs += broadcom
 dts-dirs += cavium
 dts-dirs += exynos
 dts-dirs += freescale
diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
new file mode 100644
index 0000000..9fda762
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -0,0 +1,5 @@
+dtb-$(CONFIG_ARCH_BCM_NS2) += ns2-svk.dtb
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
new file mode 100644
index 0000000..08a7816
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
@@ -0,0 +1,55 @@
+/*
+ *  BSD LICENSE
+ *
+ *  Copyright(c) 2015 Broadcom Corporation.  All rights reserved.
+ *
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *
+ *    * Redistributions of source code must retain the above copyright
+ *      notice, this list of conditions and the following disclaimer.
+ *    * Redistributions in binary form must reproduce the above copyright
+ *      notice, this list of conditions and the following disclaimer in
+ *      the documentation and/or other materials provided with the
+ *      distribution.
+ *    * Neither the name of Broadcom Corporation nor the names of its
+ *      contributors may be used to endorse or promote products derived
+ *      from this software without specific prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/dts-v1/;
+
+#include "ns2.dtsi"
+
+/ {
+	model = "Broadcom NS2 SVK";
+	compatible = "brcm,ns2-svk", "brcm,ns2";
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlycon=uart8250,mmio32,0x66130000";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x000000000 0x80000000 0x00000000 0x40000000>;
+	};
+
+	soc: soc {
+		uart3: serial@66130000 {
+			status = "ok";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
new file mode 100644
index 0000000..9d34fe4
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -0,0 +1,95 @@
+/*
+ *  BSD LICENSE
+ *
+ *  Copyright(c) 2015 Broadcom Corporation.  All rights reserved.
+ *
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *
+ *    * Redistributions of source code must retain the above copyright
+ *      notice, this list of conditions and the following disclaimer.
+ *    * Redistributions in binary form must reproduce the above copyright
+ *      notice, this list of conditions and the following disclaimer in
+ *      the documentation and/or other materials provided with the
+ *      distribution.
+ *    * Neither the name of Broadcom Corporation nor the names of its
+ *      contributors may be used to endorse or promote products derived
+ *      from this software without specific prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/memreserve/ 0x84b00000 0x00000008;
+
+/ {
+	compatible = "brcm,ns2";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0 0>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0x84b00000>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(0xff) |
+			      IRQ_TYPE_EDGE_RISING)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(0xff) |
+			      IRQ_TYPE_EDGE_RISING)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(0xff) |
+			      IRQ_TYPE_EDGE_RISING)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(0xff) |
+			      IRQ_TYPE_EDGE_RISING)>;
+		clock-frequency = <25000000>;
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0xffffffff>;
+
+		gic: interrupt-controller@65210000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x65210000 0x1000>,
+			      <0x65220000 0x1000>,
+			      <0x65240000 0x2000>,
+			      <0x65260000 0x1000>;
+		};
+
+		uart3: serial@66130000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x66130000 0x100>;
+			interrupts = <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <23961600>;
+			status = "disabled";
+		};
+	};
+};
-- 
1.7.9.5

