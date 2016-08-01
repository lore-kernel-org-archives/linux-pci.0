Return-Path: <kishon@ti.com>
Return-Path: <kishon@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@atmel.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Jean-Christophe
 Plagniol-Villard <plagnioj@jcrosoft.com>,
        Krzysztof Halasa <khalasa@piap.pl>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik
	<robert.jarzmik@free.fr>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm
	<magnus.damm@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim
	<shiraz.linux.kernel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
CC: <helgaas@kernel.org>, Benoit Cousson <bcousson@baylibre.com>,
        Rob Herring
	<robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King
	<linux@armlinux.org.uk>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Greg Ungerer
	<gerg@uclinux.org>, <linux-samsung-soc@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kishon@ti.com>, <nsekhar@ti.com>
Subject: [PATCH v2 1/3] ARM: dts: DRA7: Add "linux,pci-domain" property for pci dt nodes
Date: Mon, 1 Aug 2016 16:42:28 +0530
Message-ID: <1470049950-4697-2-git-send-email-kishon@ti.com>
In-Reply-To: <1470049950-4697-1-git-send-email-kishon@ti.com>
References: <1470049950-4697-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Since DRA7 has multiple PCIe Rootcomplex, add "linux,pci-domain"
property to assign a PCI domain number to each of the host
bridges.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 40b69a5..45e9d2d 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -301,6 +301,7 @@
 					  0x82000000 0 0x20013000 0x13000 0 0xffed000>;
 				#interrupt-cells = <1>;
 				num-lanes = <1>;
+				linux,pci-domain = <0>;
 				ti,hwmods = "pcie1";
 				phys = <&pcie1_phy>;
 				phy-names = "pcie-phy0";
@@ -336,6 +337,7 @@
 					  0x82000000 0 0x30013000 0x13000 0 0xffed000>;
 				#interrupt-cells = <1>;
 				num-lanes = <1>;
+				linux,pci-domain = <1>;
 				ti,hwmods = "pcie2";
 				phys = <&pcie2_phy>;
 				phy-names = "pcie-phy0";
-- 
1.7.9.5
