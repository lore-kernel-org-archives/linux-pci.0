Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-omap@vger.kernel.org>, <tony@atomide.com>
CC: <bcousson@baylibre.com>, <kishon@ti.com>, <robh+dt@kernel.org>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linux@arm.linux.org.uk>, <rogerq@ti.com>, <nsekhar@ti.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<t-kristo@ti.com>
Subject: [PATCH v3 1/4] ARM: dts: dra7: Add dt node for the sycon pcie
Date: Tue, 15 Dec 2015 15:09:03 +0530
Message-ID: <1450172346-11890-2-git-send-email-kishon@ti.com>
In-Reply-To: <1450172346-11890-1-git-send-email-kishon@ti.com>
References: <1450172346-11890-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add new device tree node for the control module register space where
PCIe registers are present.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index fe99231..e38f63f 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -155,6 +155,11 @@
 					compatible = "syscon";
 					reg = <0x1c04 0x0020>;
 				};
+
+				scm_conf_pcie: tisyscon@1c24 {
+					compatible = "syscon";
+					reg = <0x1c24 0x0024>;
+				};
 			};
 
 			cm_core_aon: cm_core_aon@5000 {
-- 
1.7.9.5

