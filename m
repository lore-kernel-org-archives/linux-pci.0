Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3051 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590AbaDDOuO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Apr 2014 10:50:14 -0400
From: Thierry Reding <treding@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>
Subject: [RFC 1/5] PCI: tegra: Overhaul regulator usage
Date: Fri, 4 Apr 2014 16:49:25 +0200
Message-ID: <1396622969-17837-2-git-send-email-treding@nvidia.com>
In-Reply-To: <1396622969-17837-1-git-send-email-treding@nvidia.com>
References: <1396622969-17837-1-git-send-email-treding@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The current usage of regulators for the Tegra PCIe block is wrong. It
doesn't accurately reflect the actual supply inputs of the IP block and
therefore isn't as flexible as it should be. Rectify this by describing
all possible supply inputs in the device tree binding documentation and
deprecate the old supply properties.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/pci/nvidia,tegra20-pcie.txt           | 35 ++++++++++++++++++++--
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
index c300391e8d3e..66e8aca4aef0 100644
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
+  - If port 0 is enabled:
+    - avdd-pexa-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
+    - vdd-pexa-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
+  - If at least one of ports 1 and 2 is enabled:
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
1.9.1

