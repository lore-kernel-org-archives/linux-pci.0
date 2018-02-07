Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:59367 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752688AbeBGCza (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Feb 2018 21:55:30 -0500
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 6/6] dt-bindings: PCI: rockchip: Add DT bindings for Rockchip PCIe endpoint controller
Date: Wed,  7 Feb 2018 10:50:26 +0800
Message-Id: <1517971826-65350-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1517971650-61555-1-git-send-email-shawn.lin@rock-chips.com>
References: <1517971650-61555-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch documents the DT bindings for the Rockchip PCIe controller
when configured in endpoint mode.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 .../devicetree/bindings/pci/rockchip-pcie-ep.txt   | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt

diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt
new file mode 100644
index 0000000..85f19d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt
@@ -0,0 +1,60 @@
+* Rockchip AXI PCIe Endpoint Controller DT description
+
+Required properties:
+- compatible: Should contain "rockchip,rk3399-pcie-ep"
+- reg: Two register ranges as listed in the reg-names property
+- reg-names: Must include the following names
+	- "axi-base"
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
+	rockchip,max-outbound-regions = <16>;
+	clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
+		 <&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
+	clock-names = "aclk", "aclk-perf",
+		      "hclk", "pm";
+	max-functions = /bits/ 8 <8>;
+	num-lanes = <4>;
+	reg = <0x0 0xf8000000 0x0 0x2000000>, <0x0 0x80000000 0x0 0x40000000>;
+	reg-names = "axi-base", "mem-base";
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
