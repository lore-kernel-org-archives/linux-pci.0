Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <bcousson@baylibre.com>, <tony@atomide.com>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
	<linux@armlinux.org.uk>, <linux-omap@vger.kernel.org>,
	<devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<kishon@ti.com>, <nsekhar@ti.com>
Subject: [PATCH 1/2] ARM: dts: DRA7: Add "linux,pci-domain" property for pci dt nodes
Date: Thu, 21 Jul 2016 17:27:55 +0530
Message-ID: <1469102276-14777-2-git-send-email-kishon@ti.com>
In-Reply-To: <1469102276-14777-1-git-send-email-kishon@ti.com>
References: <1469102276-14777-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since DRA7 has multiple PCIe Rootcomplex, add "linux,pci-domain"
property to assign a PCI domain number to each of the host
bridges.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 3a8f397..b275f80 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -253,6 +253,7 @@
 					  0x82000000 0 0x20013000 0x13000 0 0xffed000>;
 				#interrupt-cells = <1>;
 				num-lanes = <1>;
+				linux,pci-domain = <0>;
 				ti,hwmods = "pcie1";
 				phys = <&pcie1_phy>;
 				phy-names = "pcie-phy0";
@@ -288,6 +289,7 @@
 					  0x82000000 0 0x30013000 0x13000 0 0xffed000>;
 				#interrupt-cells = <1>;
 				num-lanes = <1>;
+				linux,pci-domain = <1>;
 				ti,hwmods = "pcie2";
 				phys = <&pcie2_phy>;
 				phy-names = "pcie-phy0";
-- 
1.7.9.5
