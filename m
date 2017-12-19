Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Tony Lindgren <tony@atomide.com>, <bcousson@baylibre.com>
Subject: [PATCH 2/7] ARM: dts: DRA74x: Use PCIe compatible specific to dra74
Date: Tue, 19 Dec 2017 15:01:28 +0530
Message-ID: <20171219093133.16565-3-kishon@ti.com>
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

Use dra74 specific compatible string for PCIe while preserving
the older compatible. While at that add a new label for the
2nd instance of pcie.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi   |  2 +-
 arch/arm/boot/dts/dra74x.dtsi | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 9966d82dbd7c..333f6a634ff9 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -349,7 +349,7 @@
 			ranges = <0x51800000 0x51800000 0x3000
 				  0x0	     0x30000000 0x10000000>;
 			status = "disabled";
-			pcie@51800000 {
+			pcie2_rc: pcie@51800000 {
 				compatible = "ti,dra7-pcie";
 				reg = <0x51800000 0x2000>, <0x51802000 0x14c>, <0x1000 0x2000>;
 				reg-names = "rc_dbics", "ti_conf", "config";
diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index 24e6746c5b26..a001eecf3b14 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -124,3 +124,15 @@
 		status = "disabled";
 	};
 };
+
+&pcie1_rc {
+	compatible = "ti,dra746-pcie-rc", "ti,dra7-pcie";
+};
+
+&pcie1_ep {
+	compatible = "ti,dra746-pcie-ep", "ti,dra7-pcie-ep";
+};
+
+&pcie2_rc {
+	compatible = "ti,dra746-pcie-rc", "ti,dra7-pcie";
+};
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
