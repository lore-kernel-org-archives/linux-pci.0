Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Hanjie Lin <hanjie.lin@amlogic.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 1/2] dt-bindings: PCI: meson: add DT bindings for Amlogic
 Meson PCIe Phy controller
Date: Tue, 14 Aug 2018 02:12:13 -0400
Message-ID: <1534227134-151584-2-git-send-email-hanjie.lin@amlogic.com>
In-Reply-To: <1534227134-151584-1-git-send-email-hanjie.lin@amlogic.com>
References: <1534227134-151584-1-git-send-email-hanjie.lin@amlogic.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org,
 Yue Wang <yue.wang@amlogic.com>, Kevin
 Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Yue Wang <yue.wang@amlogic.com>

The Meson-PCIE-PHY controller supports the 5-Gbps data rate
of the PCI Express Gen 2 specification and is backwardcompatible
with the 2.5-Gbps Gen 1.1 specification with only
inferred idle detection supported on AMLOGIC SoCs.

Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
Signed-off-by: Yue Wang <yue.wang@amlogic.com>
---
 .../bindings/phy/amlogic,meson-pcie-phy.txt        | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt b/Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt
new file mode 100644
index 0000000..db99085
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt
@@ -0,0 +1,31 @@
+* Amlogic Meson AXG PCIE PHY binding
+
+Required properties:
+- compatible:	Should be
+	- "amlogic,axg-pcie-phy"
+- #phys-cells:	must be 0 (see phy-bindings.txt in this directory)
+- reg:		The base address and length of the registers
+- resets:	phandle to the reset lines
+- reset-names:	must contain "phy" and "peripheral"
+	- "port_a" Port A reset
+	- "port_b" Port B reset
+	- "phy"	PHY reset
+	- "apb"	APB reset
+Optional properties:
+- phy-supply:	see phy-bindings.txt in this directory
+
+Example:
+	pcie_phy: pcie-phy@ff644000 {
+		#phy-cells = <0>;
+		compatible = "amlogic,axg-pcie-phy";
+		reg = <0x0 0xff644000 0x0 0x2000>;
+		resets = <&reset RESET_PCIE_A>,
+				<&reset RESET_PCIE_B>,
+				<&reset RESET_PCIE_PHY>,
+				<&reset RESET_PCIE_APB>;
+		reset-names =
+				"port_a",
+				"port_b",
+				"phy",
+				"apb";
+	};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
