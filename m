Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jim Quinlan <jim2101024@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] PCI: host: brcmstb: add DT docs for Brcmstb PCIe device
Date: Wed, 11 Oct 2017 18:34:22 -0400
Message-Id: <1507761269-7017-3-git-send-email-jim2101024@gmail.com>
In-Reply-To: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
 Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>,
 Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>,
 Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 Gregory Fong <gregory.0xf0@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jim Quinlan <jim2101024@gmail.com>, Brian Norris <computersforpeace@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The DT bindings description of the Brcmstb PCIe device is described.  This
node can be used by almost all Broadcom settop box chips, using
ARM, ARM64, or MIPS CPU architectures.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 .../devicetree/bindings/pci/brcmstb-pci.txt        | 106 +++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/brcmstb-pci.txt

diff --git a/Documentation/devicetree/bindings/pci/brcmstb-pci.txt b/Documentation/devicetree/bindings/pci/brcmstb-pci.txt
new file mode 100644
index 0000000..2f699da
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/brcmstb-pci.txt
@@ -0,0 +1,106 @@
+Brcmstb PCIe Host Controller Device Tree Bindings
+
+Introduction:
+  The brcmstb host controller closely follows the example set in
+
+	[1] http://devicetree.org/Device_Tree_Usage#PCI_Host_Bridge
+
+  The rest of this document explains some added customizations and
+  offers an example Brcmstb PCIe host controller DT node.
+
+Required Properties:
+  reg -- the register start address and length for the PCIe block.
+      Additional start,length pairs may be specified for clock addresses.
+  interrupts -- two interrupts are specified; the first interrupt is for
+      the PCI host controller and the second is for MSI if the built-in
+      MSI controller is to be used.
+  interrupt-names -- names of the interrupts (above): "pcie" and "msi".
+  compatible -- must be one of: "brcm,bcm7425-pcie", "brcm,bcm7435-pcie",
+      or "brcm,bcm7278-pcie".
+  #address-cells -- the number of address cells for PCI-space.
+  #size-cells -- the number of size cells for PCI-space.
+  ranges -- See [1]; a specification of the outbound windows for the host
+      controller.  Each outbound window is described by a n-tuple:
+          (3 cells) -- PCIe space start address; one cell for attributes
+                       and two cells for the 64-bit PCIe address.
+          (x cells) -- CPU/System start address, number of cells is determined
+                       by the parent node's #address-cells.
+          (y cells) -- Size of region, number of cells determined by the
+                       parent node's #size-cells.
+      Due to hardware limitations, there may be a maximum of four
+      non-contiguous ranges specified.
+  #interrupt-cells -- number of cells used to describe the interrupt.
+  interrupt-map-mask -- see [1]; four cells, the first three are zero
+      for our uses and the fourth cell is the mask (val = 0x7) for
+      the legacy interrupt number [1..4].
+  interrupt-map -- See [1]; there are four interrupts (INTA, INTB,
+      INTC, and INTD) to be mapped; each interrupt requires 5 cells
+      plus the size of the interrupt specifier.
+  linux,pci-domain -- the domain of the host controller.
+
+Optional Properties:
+  clocks -- list of clock phandles.  If specified, this should list one
+      clock.
+  clock-names -- the "local" names of the clocks specified in 'clocks'.  Note
+      that if the 'clocks' property is given, 'clock-names' is mandatory,
+      and the name of the clock is expected to be "sw_pcie".
+  dma-ranges -- Similar in structure to ranges, each dma region is
+      specified with a n-tuple.  Dma-regions describe the inbound
+      accesses from EP to RC; it translates the pci address that the
+      EP "sees" to the CPU address in memory.  This property is needed
+      because the design of the Brcmstb memory subsystem often precludes
+      idenity-mapping between CPU address space and PCIe address space.
+      Each range is described by a n-tuple:
+          (3 cells) -- PCIe space start address; one cell for attributes
+                       and two cells for the 64-bit PCIe address.
+          (x cells) -- CPU/System start address, number of cells is determined
+                       by the parent node's #address-cells.
+          (y cells) -- Size of region, number of cells determined by the
+                       parent node's #size-cells.
+  msi-parent -- if MSI is to be used, this must be a phandle to the
+      msi-parent.  If this prop is set to the phandle of the PCIe
+      node, or if the msi-parent prop is missing, the PCIE controller
+      will attempt to use its built in MSI controller.
+  msi-controller -- this property should only be specified if the
+      PCIe controller is using its internal MSI controller.
+  brcm,ssc -- (boolean) indicates usage of spread-spectrum clocking.
+  brcm,gen --  (integer) indicates desired generation of link:
+      1 => 2.5 Gbps, 2 => 5.0 Gbps, 3 => 8.0 Gbps.
+  supply-names -- the names of voltage regulators that the root
+      complex should turn off/on/on on suspend/resume/boot.  This
+      is a string list.
+  supplies -- A collection of phandles to a regulator nodes, see
+      Documentation/devicetree/bindings/regulator/ for specific
+      bindings. The number and order of phandles must match
+      exactly the number of strings in the "supply-names" property.
+
+Example Node:
+
+pcie0:	pcie@f0460000 {
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
+		interrupt-names = "pcie_0_inta",
+				  "pcie_0_intb",
+				  "pcie_0_intc",
+				  "pcie_0_intd";
+		clocks = <&sw_pcie0>;
+		clock-names = "sw_pcie";
+		msi-parent = <&pcie0>;  /* use PCIe's internal MSI controller */
+		msi-controller;         /* use PCIe's internal MSI controller */
+		brcm,ssc;
+		brcm,gen = <1>;
+		supply-names = "vreg-wifi-pwr";
+		supplies = <&vreg-wifi-pwr>;
+		linux,pci-domain = <0>;
+	};
-- 
1.9.0.138.g2de3478


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
