Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:57560 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757748Ab3FTMp7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2013 08:45:59 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Kukjin Kim' <kgene.kim@samsung.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	'Grant Likely' <grant.likely@secretlab.ca>,
	'Andrew Murray' <andrew.murray@arm.com>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Thierry Reding' <thierry.reding@avionic-design.de>,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'Thomas Abraham' <thomas.abraham@linaro.org>,
	'Tomasz Figa' <t.figa@samsung.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Mohit KUMAR' <Mohit.KUMAR@st.com>,
	Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH V8 4/4] ARM: dts: Add pcie controller node for
 exynos5440-ssdk5440
Date: Thu, 20 Jun 2013 21:45:57 +0900
Message-id: <00de01ce6db4$1c2b8c80$5482a580$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds pcie controller node for exynos5440-ssdk5440,
and also adds a phandle for pin controller node.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/exynos5440-ssdk5440.dts |    8 ++++++++
 arch/arm/boot/dts/exynos5440.dtsi         |    2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5440-ssdk5440.dts b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
index f32cd77..ede7727 100644
--- a/arch/arm/boot/dts/exynos5440-ssdk5440.dts
+++ b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
@@ -65,4 +65,12 @@
 			clock-frequency = <50000000>;
 		};
 	};
+
+	pcie@290000 {
+		reset-gpio = <&pin_ctrl 5 0>;
+	};
+
+	pcie@2a0000 {
+		reset-gpio = <&pin_ctrl 22 0>;
+	};
 };
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 68d05e9..de31f0c 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -126,7 +126,7 @@
 		clock-names = "spi", "spi_busclk0";
 	};
 
-	pinctrl {
+	pin_ctrl: pinctrl {
 		compatible = "samsung,exynos5440-pinctrl";
 		reg = <0xE0000 0x1000>;
 		interrupts = <0 37 0>, <0 38 0>, <0 39 0>, <0 40 0>,
-- 
1.7.10.4


