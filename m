Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([45.249.212.189]:7903 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753756AbdFSKIq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2017 06:08:46 -0400
From: Xiaowei Song <songxiaowei@hisilicon.com>
To: <guodong.xu@linaro.org>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>
CC: <songxiaowei@hisilicon.com>, <suzhuangluan@hisilicon.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 1/3] PCI: hisi: Add DT binding for PCIe of Kirin SoC series
Date: Mon, 19 Jun 2017 18:08:32 +0800
Message-ID: <20170619100834.43321-2-songxiaowei@hisilicon.com>
In-Reply-To: <20170619100834.43321-1-songxiaowei@hisilicon.com>
References: <20170619100834.43321-1-songxiaowei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Cc: Guodong Xu <guodong.xu@linaro.org>
Signed-off-by: Xiaowei Song <songxiaowei@hisilicon.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/kirin-pcie.txt         | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
new file mode 100644
index 000000000000..c2be01270ec5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
@@ -0,0 +1,55 @@
+HiSilicon Kirin SoCs PCIe host DT description
+
+Kirin PCIe host controller is based on Designware PCI core.
+It shares common functions with PCIe Designware core driver
+and inherits common properties defined in
+Documentation/devicetree/bindings/pci/designware-pci.txt.
+
+Additional properties are described here:
+
+Required properties
+- compatible:
+	"hisilicon,kirin960-pcie" for PCIe of Kirin960 SoC
+- reg: Should contain rc_dbi, apb, phy, config registers location and length.
+- reg-names: Must include the following entries:
+  "dbi": controller configuration registers;
+  "apb": apb Ctrl register defined by Kirin;
+  "phy": apb PHY register defined by Kirin;
+  "config": PCIe configuration space registers.
+- reset-gpios: The gpio to generate PCIe perst assert and deassert signal.
+
+Optional properties:
+
+Example based on kirin960:
+
+	pcie@f4000000 {
+		compatible = "hisilicon,kirin960-pcie";
+		reg = <0x0 0xf4000000 0x0 0x1000>,
+		      <0x0 0xff3fe000 0x0 0x1000>,
+		      <0x0 0xf3f20000 0x0 0x40000>,
+		      <0x0 0xf4000000 0x0  0x2000>;
+		reg-names = "dbi","apb","phy", "config";
+		bus-range = <0x0  0x1>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x02000000 0x0 0x0
+			  0x0 0xf5000000
+			  0x0 0x2000000>;
+		num-lanes = <1>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0x0 0 0 1 &gic 0 282 4>,
+				<0x0 0 0 2 &gic 0 283 4>,
+				<0x0 0 0 3 &gic 0 284 4>,
+				<0x0 0 0 4 &gic 0 285 4>;
+		clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
+			 <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
+			 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
+			 <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
+			 <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
+		clock-names = "pcie_phy_ref", "pcie_aux",
+			      "pcie_apb_phy", "pcie_apb_sys",
+			      "pcie_aclk";
+		reset-gpios = <&gpio11 1 0>;
+	};
-- 
2.11.GIT
