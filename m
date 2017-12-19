Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Tony Lindgren <tony@atomide.com>, <bcousson@baylibre.com>
Subject: [PATCH 4/7] ARM: dts: dra76-evm: Enable x2 PCIe lanes
Date: Tue, 19 Dec 2017 15:01:30 +0530
Message-ID: <20171219093133.16565-5-kishon@ti.com>
In-Reply-To: <20171219093133.16565-1-kishon@ti.com>
References: <20171219093133.16565-1-kishon@ti.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 kishon@ti.com, linux-pci@vger.kernel.org, nsekhar@ti.com,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

DRA76 EVM has a 4-lane PCIe connector and DRA76 can support x2 lanes.
Enable both the PCIe lanes here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra76-evm.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/dra76-evm.dts b/arch/arm/boot/dts/dra76-evm.dts
index b024a65c6e27..244e553f2247 100644
--- a/arch/arm/boot/dts/dra76-evm.dts
+++ b/arch/arm/boot/dts/dra76-evm.dts
@@ -421,3 +421,19 @@
 		spi-max-frequency = <96000000>;
 	};
 };
+
+&pcie2_phy {
+	status = "okay";
+};
+
+&pcie1_rc {
+	num-lanes = <2>;
+	phys = <&pcie1_phy>, <&pcie2_phy>;
+	phy-names = "pcie-phy0", "pcie-phy1";
+};
+
+&pcie1_ep {
+	num-lanes = <2>;
+	phys = <&pcie1_phy>, <&pcie2_phy>;
+	phy-names = "pcie-phy0", "pcie-phy1";
+};
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
