Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33850 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbcCHPsU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Mar 2016 10:48:20 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: pci: tegra: Update for per-lane PHYs
Date: Tue,  8 Mar 2016 16:48:13 +0100
Message-Id: <1457452094-5409-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

Changes to the pad controller device tree binding have required that
each lane be associated with a separate PHY. Update the PCI host bridge
device tree binding to allow each root port to define the list of PHYs
required to drive the lanes associated with it.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../devicetree/bindings/pci/nvidia,tegra20-pcie.txt    | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
index 75321ae23c08..033fe4b5afac 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
@@ -60,11 +60,14 @@ Required properties:
   - afi
   - pcie_x
 
-Required properties on Tegra124 and later:
+Required properties on Tegra124 and later (deprecated):
 - phys: Must contain an entry for each entry in phy-names.
 - phy-names: Must include the following entries:
   - pcie
 
+These properties are deprecated in favour of per-lane PHYs define in each of
+the root ports (see below).
+
 Power supplies for Tegra20:
 - avdd-pex-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
 - vdd-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
@@ -122,6 +125,13 @@ Required properties:
   - Root port 0 uses 4 lanes, root port 1 is unused.
   - Both root ports use 2 lanes.
 
+Required properties for Tegra124 and later:
+- phys: Must contain an phandle to a PHY for each entry in phy-names.
+- phy-names: Must include an entry for each active lane. Note that the number
+  of entries does not have to (though usually will) be equal to the specified
+  number of lanes in the nvidia,num-lanes property. Entries are of the form
+  "pcie-N": where N ranges from 0 to the value specified in nvidia,num-lanes.
+
 Example:
 
 SoC DTSI:
@@ -169,6 +179,9 @@ SoC DTSI:
 			ranges;
 
 			nvidia,num-lanes = <2>;
+
+			phys = <&{/padctl@0,7009f000/pads/pcie/pcie-4}>;
+			phy-names = "pcie-0";
 		};
 
 		pci@2,0 {
@@ -183,6 +196,9 @@ SoC DTSI:
 			ranges;
 
 			nvidia,num-lanes = <2>;
+
+			phys = <&{/padctl@0,7009f000/pads/pcie/pcie-2}>;
+			phy-names = "pcie-0";
 		};
 	};
 
-- 
2.7.1

