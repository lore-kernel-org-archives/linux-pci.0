Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:20386 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755776Ab3CDKXr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Mar 2013 05:23:47 -0500
From: Jingoo Han <jg1.han@samsung.com>
To: 'Kukjin Kim' <kgene.kim@samsung.com>,
	linux-samsung-soc@vger.kernel.org
Cc: linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <016b01ce18c2$2c366f10$84a34d30$%han@samsung.com>
In-reply-to: <016b01ce18c2$2c366f10$84a34d30$%han@samsung.com>
Subject: [PATCH 2/2] ARM: dts: Add pcie controller node for Samsung EXYNOS5440
 SoC
Date: Mon, 04 Mar 2013 19:23:44 +0900
Message-id: <016c01ce18c2$59bf89d0$0d3e9d70$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Exynos5440 has two PCIe controllers which can be used as root complex
for PCIe interface.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm/boot/dts/exynos5440-ssdk5440.dts |    8 +++++++
 arch/arm/boot/dts/exynos5440.dtsi         |   32 +++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440-ssdk5440.dts b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
index 81e2c96..ecf6906 100644
--- a/arch/arm/boot/dts/exynos5440-ssdk5440.dts
+++ b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
@@ -43,4 +43,12 @@
 	rtc {
 		status = "disabled";
 	};
+
+	pcie0@40000000 {
+		reset-gpio = <5>;
+	};
+
+	pcie1@60000000 {
+		reset-gpio = <22>;
+	};
 };
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 0bde96d..16bb994 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -151,4 +151,36 @@
 		reg = <0x130000 0x1000>;
 		interrupts = <0 17 0>, <0 16 0>;
 	};
+
+	pcie0@40000000 {
+		compatible = "samsung,pcie-host";
+		reg = <0x40000000 0x4000
+			0x290000 0x1000
+			0x270000 0x1000
+			0x271000 0x40>;
+		interrupts = <0 20 0>, <0 21 0>, <0 22 0>;
+		pcie-host,io_size = <0x4000>;
+		pcie-host,cfg0_size = <0x100000>;
+		pcie-host,cfg1_size = <0x100000>;
+		pcie-host,mem_size = <0x10000000>;
+		pcie-host,in_mem_size = <0x8000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	pcie1@60000000 {
+		compatible = "samsung,pcie-host";
+		reg = <0x60000000 0x4000
+			0x2a0000 0x1000
+			0x272000 0x1000
+			0x271040 0x40>;
+		interrupts = <0 23 0>, <0 24 0>, <0 25 0>;
+		pcie-host,io_size = <0x4000>;
+		pcie-host,cfg0_size = <0x100000>;
+		pcie-host,cfg1_size = <0x100000>;
+		pcie-host,mem_size = <0x10000000>;
+		pcie-host,in_mem_size = <0x8000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
 };
-- 
1.7.2.5


