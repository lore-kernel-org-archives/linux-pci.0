Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33983 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933771AbcECB0X (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2016 21:26:23 -0400
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	bhelgaas@google.com, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/2] Documentation: DT: bindings: Add Broadcom STB PCIe bindings
Date: Mon,  2 May 2016 18:25:48 -0700
Message-Id: <1462238749-19715-2-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1462238749-19715-1-git-send-email-f.fainelli@gmail.com>
References: <1462238749-19715-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jim Quinlan <jim2101024@gmail.com>

This patchs adds the Device Tree bindings for the Broadcom STB PCIe root
complex hardware.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/pci/brcm,brcmstb-pcie.txt  | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/brcm,brcmstb-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/brcm,brcmstb-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,brcmstb-pcie.txt
new file mode 100644
index 000000000000..922317969ab5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/brcm,brcmstb-pcie.txt
@@ -0,0 +1,81 @@
+Brcmstb PCIe Host Controller Device Tree Bindings
+
+Introduction:
+
+The brcmstb host controller closely follows the example set in
+
+	[1] http://devicetree.org/Device_Tree_Usage#PCI_Host_Bridge
+
+The rest of this document explains some added customizations and
+offers an example Brcmstb PCIe host controller DT node.
+
+Required Properties:
+  reg -- the register start address and length for the PCIe block.
+      Additional start,length pairs may be specified for clock addresses.
+  interrupts -- this must be specified but it is used indirectly.  Interrupt
+      zero must be specified; the Brcmstb driver code uses this interrupt
+      to determine the offset used for all interrupts, specifically, those
+      listed in interrupt-map.
+  compatible -- must be one of: "brcm,bcm7425-pcie", "brcm,bcm7435-pcie" or
+      "brcm,bcm7445-pcie".
+  #address-cells -- the number of address cells for PCI-space.
+  #size-cells -- the number of size cells for PCI-space.
+  ranges -- See [1]; a specification of the outbound windows for the host
+      controller.  Each outbound window is described by a 7-tuple:
+          (3 entries) -- PCIe space start address (0th entry is ignored).
+          (2 entries) -- CPU/System start address
+          (2 entries) -- Size of region.
+      Due to hardware limitations, there may be a maximum of four windows
+      specified.
+  #interrupt-cells -- number of cells used to describe the interrupt.
+  interrupt-map -- See [1]; each interrupt requires 7 entries, and
+      currently all but the fifth entry (order 0) -- the interrupt
+      number -- is ignored.  There must be four interrupts specified
+      for the PCI's INTA, INTB, INTC, and INTD.
+
+Optional Properties:
+  interrupt-names -- names of the interrupts listed in the interrupt map.
+  clocks -- list of clock phandles.  If specified, this should list one
+      clock.
+  clock-names -- the "local" names of the clocks specified in 'clocks'.  Note
+      that if the 'clocks' property is given, 'clock-names' is mandatory,
+      and the name of the clock is expected to be "sw_pcie".
+  brcm,ssc -- (boolean) indicates usage of spread-spectrum clocking.
+  brcm,gen --  (integer) indicates desired generation of link:
+      1 => 2.5 Gbps, 2 => 5.0 Gbps, 3 => 8.0 Gbps.
+  supply-names -- the names of voltage regulators that the root
+      complex should turn off/on/on on suspend/resume/boot.  This
+      is a string list.
+  supplies -- A collection of phandles to a regulator nodes, see
+	Documentation/devicetree/bindings/regulator/ for specific
+	bindings. The number and order of phandles must match
+	exactly the number of strings in the "supply-names" property.
+
+Example Node:
+
+	pcie@f0460000 {
+		reg = <0x0 0xf0460000 0x0 0x9310>;
+		interrupts = <0x0 0x0 0x4>;
+		compatible = "brcm,pci-plat-dev";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x02000000 0x00000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x08000000
+			  0x02000000 0x00000000 0x08000000 0x00000000 0xc8000000 0x00000000 0x08000000>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0 0 0 1 &intc 47 3
+				 0 0 0 2 &intc 48 3
+				 0 0 0 3 &intc 49 3
+				 0 0 0 4 &intc 50 3>;
+		interrupt-names = "pcie_0_inta",
+				  "pcie_0_intb",
+				  "pcie_0_intc",
+				  "pcie_0_intd";
+		clocks = <&sw_pcie0>;
+		clock-names = "sw_pcie";
+		brcm,ssc;
+		brcm,gen = <1>;
+		supply-names = "vreg-wifi-pwr";
+		supplies = <&vreg-wifi-pwr>;
+
+	};
-- 
2.1.0

