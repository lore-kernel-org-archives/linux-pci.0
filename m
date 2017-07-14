Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:43041 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753059AbdGNDxj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2017 23:53:39 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 6/6] dt-bindings: PCI: rockchip: convert to use per-lane PHY model
Date: Fri, 14 Jul 2017 11:52:46 +0800
Message-Id: <1500004366-241633-5-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1500004366-241633-1-git-send-email-shawn.lin@rock-chips.com>
References: <1500004101-240296-1-git-send-email-shawn.lin@rock-chips.com>
 <1500004366-241633-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Deprecate legacy PHY model and encourage to use per-lane PHY
model.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 .../devicetree/bindings/pci/rockchip-pcie.txt      | 25 ++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
index 1453a73..78d4469 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
@@ -19,8 +19,6 @@ Required properties:
 	- "pm"
 - msi-map: Maps a Requester ID to an MSI controller and associated
 	msi-specifier data. See ./pci-msi.txt
-- phys: From PHY bindings: Phandle for the Generic PHY for PCIe.
-- phy-names:  MUST be "pcie-phy".
 - interrupts: Three interrupt entries must be specified.
 - interrupt-names: Must include the following names
 	- "sys"
@@ -42,6 +40,18 @@ Required properties:
 	interrupt source. The value must be 1.
 - interrupt-map-mask and interrupt-map: standard PCI properties
 
+Required properties for legacy PHY model (deprecated):
+- phys: From PHY bindings: Phandle for the Generic PHY for PCIe.
+- phy-names:  MUST be "pcie-phy".
+
+Required properties for per-lane PHY model:
+- phys: Must contain an phandle to a PHY for each entry in phy-names.
+- phy-names: Must include an entry for each active lane. Note that the number
+  of entries does not have to (though usually will) be equal to the specified
+  number of lanes in the num-lanes property. Entries are of the form
+  "pcie-phy-N": where N ranges from 0 to the value specified of (num-lanes - 1).
+  (see example below)
+
 Optional Property:
 - aspm-no-l0s: RC won't support ASPM L0s. This property is needed if
 	using 24MHz OSC for RC's PHY.
@@ -95,6 +105,7 @@ pcie0: pcie@f8000000 {
 		 <&cru SRST_PCIE_PM>, <&cru SRST_P_PCIE>, <&cru SRST_A_PCIE>;
 	reset-names = "core", "mgmt", "mgmt-sticky", "pipe",
 		      "pm", "pclk", "aclk";
+	/* deprecated legacy PHY model */
 	phys = <&pcie_phy>;
 	phy-names = "pcie-phy";
 	pinctrl-names = "default";
@@ -111,3 +122,13 @@ pcie0: pcie@f8000000 {
 		#interrupt-cells = <1>;
 	};
 };
+
+pcie0: pcie@f8000000 {
+	...
+
+	/* preferred per-lane PHY model */
+	phys = <&pcie_phy 0>, <&pcie_phy 1>, <&pcie_phy 2>, <&pcie_phy 3>;
+	phy-names = "pcie-phy-0", "pcie-phy-1", "pcie-phy-2", "pcie-phy-3";
+
+	...
+};
-- 
1.9.1
