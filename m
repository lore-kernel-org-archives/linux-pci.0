Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:39398 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753476AbdGSJ6Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2017 05:58:25 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 6/7] dt-bindings: PCI: rockchip: convert to use per-lane PHY model
Date: Wed, 19 Jul 2017 17:57:57 +0800
Message-Id: <1500458278-203082-2-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1500458278-203082-1-git-send-email-shawn.lin@rock-chips.com>
References: <1500458118-139042-1-git-send-email-shawn.lin@rock-chips.com>
 <1500458278-203082-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Deprecate legacy PHY model and encourage to use per-lane PHY
model.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 .../devicetree/bindings/pci/rockchip-pcie.txt      | 25 ++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
index 1453a73..41bced4 100644
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
+Required properties for per-lane PHY model (preferred):
+- phys: Must contain an phandle to a PHY for each entry in phy-names.
+- phy-names: Must include 4 entries for all 4 lanes even if some of
+  them won't be used for your cases. Entries are of the form "pcie-phy-N":
+  where N ranges from 0 to 3.
+  (see example below and you MUST also refer to ../phy/rockchip-pcie-phy.txt
+  for changing the #phy-cells of phy node to support it)
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
