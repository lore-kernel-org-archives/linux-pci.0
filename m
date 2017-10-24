Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:45670 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751514AbdJXSQn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Oct 2017 14:16:43 -0400
From: Jim Quinlan <jim2101024@gmail.com>
To: linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jim Quinlan <jim2101024@gmail.com>
Subject: [PATCH 2/8] PCI: host: brcmstb: add DT docs for Brcmstb PCIe device
Date: Tue, 24 Oct 2017 14:15:43 -0400
Message-Id: <1508868949-16652-3-git-send-email-jim2101024@gmail.com>
In-Reply-To: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
References: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The DT bindings description of the Brcmstb PCIe device is described.  This
node can be used by almost all Broadcom settop box chips, using
ARM, ARM64, or MIPS CPU architectures.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 .../devicetree/bindings/pci/brcmstb-pci.txt        | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/brcmstb-pci.txt

diff --git a/Documentation/devicetree/bindings/pci/brcmstb-pci.txt b/Documentation/devicetree/bindings/pci/brcmstb-pci.txt
new file mode 100644
index 0000000..49f9852
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/brcmstb-pci.txt
@@ -0,0 +1,63 @@
+Brcmstb PCIe Host Controller Device Tree Bindings
+
+Required Properties:
+- compatible
+  "brcm,bcm7425-pcie" -- for 7425 family MIPS-based SOCs.
+  "brcm,bcm7435-pcie" -- for 7435 family MIPS-based SOCs.
+  "brcm,bcm7445-pcie" -- for 7445 and later ARM based SOCs (not including
+      the 7278).
+  "brcm,bcm7278-pcie"  -- for 7278 family ARM-based SOCs.
+
+- reg -- the register start address and length for the PCIe reg block.
+- interrupts -- two interrupts are specified; the first interrupt is for
+     the PCI host controller and the second is for MSI if the built-in
+     MSI controller is to be used.
+- interrupt-names -- names of the interrupts (above): "pcie" and "msi".
+- #address-cells -- set to <3>.
+- #size-cells -- set to <2>.
+- #interrupt-cells: set to <1>.
+- interrupt-map-mask and interrupt-map, standard PCI properties to define the
+     mapping of the PCIe interface to interrupt numbers.
+- ranges: ranges for the PCI memory and I/O regions.
+- linux,pci-domain -- should be unique per host controller.
+
+Optional Properties:
+- clocks -- phandle of pcie clock.
+- clock-names -- set to "sw_pcie" if clocks is used.
+- dma-ranges -- Specifies the inbound memory mapping regions when
+     an "identity map" is not possible.
+- msi-controller -- this property is typically specified to have the
+     PCIe controller use its internal MSI controller.
+- msi-parent -- set to use an external MSI interrupt controller.
+- brcm,ssc -- (boolean) indicates usage of spread-spectrum clocking.
+- max-link-speed --  (integer) indicates desired generation of link:
+     1 => 2.5 Gbps (gen1), 2 => 5.0 Gbps (gen2), 3 => 8.0 Gbps (gen3).
+- xyz-supply -- set to a voltage regulator phandle  that the root
+     complex should turn off/on/on on suspend/resume/boot.  Any property
+     matching '-supply' will be added to an internal list of phandles.
+
+
+Example Node:
+
+pcie0: pcie@f0460000 {
+		reg = <0x0 0xf0460000 0x0 0x9310>;
+		interrupts = <0x0 0x0 0x4>;
+		compatible = "brcm,pci-plat-dev";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x02000000 0x00000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x08000000
+			  0x02000000 0x00000000 0x08000000 0x00000000 0xc8000000 0x00000000 0x08000000>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &intc 0 47 3
+				 0 0 0 2 &intc 0 48 3
+				 0 0 0 3 &intc 0 49 3
+				 0 0 0 4 &intc 0 50 3>;
+		clocks = <&sw_pcie0>;
+		clock-names = "sw_pcie";
+		msi-parent = <&pcie0>;  /* use PCIe's internal MSI controller */
+		msi-controller;         /* use PCIe's internal MSI controller */
+		brcm,ssc;
+		max-link-speed = <1>;
+		linux,pci-domain = <0>;
+	};
-- 
1.9.0.138.g2de3478
