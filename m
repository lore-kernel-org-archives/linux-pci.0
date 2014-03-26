Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<bhelgaas@google.com>, <mohit.kumar@st.com>, <jg1.han@samsung.com>
CC: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<rob@landley.net>, <linux@arm.linux.org.uk>, <tony@atomide.com>,
	<rnayak@ti.com>, <paul@pwsan.com>, <kishon@ti.com>
Subject: [RFC PATCH 09/12] ARM: dts: dra7: Add dt data for PCIe PHY control module
Date: Wed, 26 Mar 2014 19:27:49 +0530
Message-ID: <1395842272-15267-10-git-send-email-kishon@ti.com>
In-Reply-To: <1395842272-15267-1-git-send-email-kishon@ti.com>
References: <1395842272-15267-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Added dt data for PCIe PHY control module used by PCIe PHY.
The documention for this node can be found @ ../bindings/phy/ti-phy.txt

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index f3565ac..73c61d0 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -656,6 +656,14 @@
 			clock-names = "sysclk";
 		};
 
+		omap_control_pcie1phy: omap-control-pciephy@0x4a003c40 {
+			compatible = "ti,control-phy-pipe3";
+			reg = <0x4a003c40 0x4>;
+			reg-names = "power";
+			clocks = <&sys_clkin1>;
+			clock-names = "sysclk";
+		};
+
 		/* OCP2SCP3 */
 		ocp2scp@4a090000 {
 			compatible = "ti,omap-ocp2scp";
-- 
1.7.9.5

