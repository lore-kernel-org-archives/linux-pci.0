Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <rogerq@ti.com>, <balajitk@ti.com>, Keerthy <j-keerthy@ti.com>,
	Rajendra Nayak <rnayak@ti.com>, Tero Kristo <t-kristo@ti.com>,
	Paul Walmsley <paul@pwsan.com>,
	Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 07/17] ARM: dts: DRA7: Add divider table to optfclk_pciephy_div clock
Date: Tue, 6 May 2014 19:03:53 +0530
Message-ID: <1399383244-14556-8-git-send-email-kishon@ti.com>
In-Reply-To: <1399383244-14556-1-git-send-email-kishon@ti.com>
References: <1399383244-14556-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Keerthy <j-keerthy@ti.com>

Add divider table to optfclk_pciephy_div clock. The Documentation
for divider clock can be found at ../clock/ti/divider.txt

Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index c767687..55e95c5 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1170,6 +1170,7 @@
 		clocks = <&apll_pcie_ck>;
 		#clock-cells = <0>;
 		reg = <0x021c>;
+		ti,dividers = <2>, <1>;
 		ti,bit-shift = <8>;
 		ti,max-div = <2>;
 	};
-- 
1.7.9.5

