Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:37657 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbeCFCuT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Mar 2018 21:50:19 -0500
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 6/6] dt-bindings: PCI: rockchip: Add DT bindings for Rockchip PCIe endpoint controller
Date: Tue,  6 Mar 2018 10:44:16 +0800
Message-Id: <1520304256-235121-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1520304173-231081-1-git-send-email-shawn.lin@rock-chips.com>
References: <1520304173-231081-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch documents the DT bindings for the Rockchip PCIe controller
when configured in endpoint mode.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v3: None
Changes in v2: None

 .../devicetree/bindings/pci/rockchip-pcie-ep.txt   | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt

diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt
new file mode 100644
index 0000000..77846730
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt
@@ -0,0 +1,62 @@
+* Rockchip AXI PCIe Endpoint Controller DT description
+
+Required properties:
+- compatible: Should contain "rockchip,rk3399-pcie-ep"
+- reg: Two register ranges as listed in the reg-names property
+- reg-names: Must include the following names
+	- "apb-base"
+	- "mem-base"
+- clocks: Must contain an entry for each entry in clock-names.
+		See ../clocks/clock-bindings.txt for details.
+- clock-names: Must include the following entries:
+	- "aclk"
+	- "aclk-perf"
+	- "hclk"
+	- "pm"
+- resets: Must contain seven entries for each entry in reset-names.
+	   See ../reset/reset.txt for details.
+- reset-names: Must include the following names
+	- "core"
+	- "mgmt"
+	- "mgmt-sticky"
+	- "pipe"
+	- "pm"
+	- "aclk"
+	- "pclk"
+- pinctrl-names : The pin control state names
+- pinctrl-0: The "default" pinctrl state
+- phys: Must contain an phandle to a PHY for each entry in phy-names.
+- phy-names: Must include 4 entries for all 4 lanes even if some of
+  them won't be used for your cases. Entries are of the form "pcie-phy-N":
+  where N ranges from 0 to 3.
+  (see example below and you MUST also refer to ../phy/rockchip-pcie-phy.txt
+  for changing the #phy-cells of phy node to support it)
+- rockchip,max-outbound-regions: Maximum number of outbound regions
+
+Optional Property:
+- num-lanes: number of lanes to use
+- max-functions: Maximum number of functions that can be configured (default 1).
+
+pcie0-ep: pcie@f8000000 {
+	compatible = "rockchip,rk3399-pcie-ep";
+	#address-cells = <3>;
+	#size-cells = <2>;
+	rockchip,max-outbound-regions = <16>;
+	clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
+		 <&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
+	clock-names = "aclk", "aclk-perf",
+		      "hclk", "pm";
+	max-functions = /bits/ 8 <8>;
+	num-lanes = <4>;
+	reg = <0x0 0xfd000000 0x0 0x1000000>, <0x0 0x80000000 0x0 0x20000>;
+	reg-names = "apb-base", "mem-base";
+	resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
+		 <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE> ,
+		 <&cru SRST_PCIE_PM>, <&cru SRST_P_PCIE>, <&cru SRST_A_PCIE>;
+	reset-names = "core", "mgmt", "mgmt-sticky", "pipe",
+		      "pm", "pclk", "aclk";
+	phys = <&pcie_phy 0>, <&pcie_phy 1>, <&pcie_phy 2>, <&pcie_phy 3>;
+	phy-names = "pcie-phy-0", "pcie-phy-1", "pcie-phy-2", "pcie-phy-3";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_clkreq>;
+};
-- 
1.9.1
