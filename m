Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:43581 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841AbaE1Ov4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 May 2014 10:51:56 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 1/5] PCI: tegra: Overhaul regulator usage
Date: Wed, 28 May 2014 16:49:11 +0200
Message-Id: <1401288555-24197-2-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1401288555-24197-1-git-send-email-thierry.reding@gmail.com>
References: <1401288555-24197-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

The current usage of regulators for the Tegra PCIe block is wrong. It
doesn't accurately reflect the actual supply inputs of the IP block and
therefore isn't as flexible as it should be. Rectify this by describing
all possible supply inputs in the device tree binding documentation and
deprecate the old supply properties.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- fix power rail assignment on Tegra30

 .../bindings/pci/nvidia,tegra20-pcie.txt           | 35 ++++++++++++++++++++--
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
index c300391e8d3e..f56d89998a44 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
@@ -14,9 +14,6 @@ Required properties:
 - interrupt-names: Must include the following entries:
   "intr": The Tegra interrupt that is asserted for controller interrupts
   "msi": The Tegra interrupt that is asserted when an MSI is received
-- pex-clk-supply: Supply voltage for internal reference clock
-- vdd-supply: Power supply for controller (1.05V)
-- avdd-supply: Power supply for controller (1.05V) (not required for Tegra20)
 - bus-range: Range of bus numbers associated with this controller
 - #address-cells: Address representation for root ports (must be 3)
   - cell 0 specifies the bus and device numbers of the root port:
@@ -60,6 +57,38 @@ Required properties:
   - afi
   - pcie_x
 
+Power supplies for Tegra20:
+- avdd-pex-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
+- vdd-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
+- avdd-pex-pll-supply: Power supply for dedicated (internal) PCIe PLL. Must
+  supply 1.05 V.
+- avdd-plle-supply: Power supply for PLLE, which is shared with SATA. Must
+  supply 1.05 V.
+- vddio-pex-clk-supply: Power supply for PCIe clock. Must supply 3.3 V.
+
+Power supplies for Tegra30:
+- Required:
+  - avdd-pex-pll-supply: Power supply for dedicated (internal) PCIe PLL. Must
+    supply 1.05 V.
+  - avdd-plle-supply: Power supply for PLLE, which is shared with SATA. Must
+    supply 1.05 V.
+  - vddio-pex-ctl-supply: Power supply for PCIe control I/O partition. Must
+    supply 1.8 V.
+  - hvdd-pex-supply: High-voltage supply for PCIe I/O and PCIe output clocks.
+    Must supply 3.3 V.
+- Optional:
+  - If lanes 0 to 3 are used:
+    - avdd-pexa-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
+    - vdd-pexa-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
+  - If lanes 4 or 5 are used:
+    - avdd-pexb-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
+    - vdd-pexb-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
+
+Deprecated supplies:
+- pex-clk-supply: Supply voltage for internal reference clock
+- vdd-supply: Power supply for controller (1.05V)
+- avdd-supply: Power supply for controller (1.05V) (not required for Tegra20)
+
 Root ports are defined as subnodes of the PCIe controller node.
 
 Required properties:
-- 
1.9.2

