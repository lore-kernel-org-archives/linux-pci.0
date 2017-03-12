Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/4 v5] PCI: add DT bindings for Faraday Technology PCI Host
 Bridge
Date: Sun, 12 Mar 2017 23:23:52 +0100
Message-Id: <20170312222352.2413-1-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: openwrt-devel@openwrt.org, Feng-Hsin Chiang <john453@faraday-tech.com>,
 Paulius Zaleckas <paulius.zaleckas@gmail.com>, linux-pci@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>, Greentime Hu <green.hu@gmail.com>,
 Janos Laube <janos.dev@gmail.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This adds device tree bindings for the Faraday technology PCI
Host Bridge. This IP is found in the Storlink/Storm/Cortina
Gemini SoC platform.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: Feng-Hsin Chiang <john453@faraday-tech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v4->v5:
- No changes, just resend as everything else is rebased onto
  v4.11-rc1.
ChangeLog v3->v4:
- Add Rob's ACK
ChangeLog v2->v3:
- Reinstate the specific-to-generic bindings also specifying the
  "cortina,gemini-pci" fixture for the Faraday block.
- Set compatible to "faraday,ftpci100" and "faraday,ftpci100-dual"
  this is clearly closer to or equal to what the IP blocks from
  Faraday are actually named.
- Add "dma-ranges" property, after deciphering that some hardcoded
  constants in the driver is really about this.
ChangeLog v1->v2:
- Rename from Cortina prefixes to Faraday. This is clearly
  a Faraday IP block.
- Support both the version with cascaded interrupts and the
  "dual" version with 1-to-1 mapped interrupts.
- Change bus-range to <0x00 0xff>
- Fix spelling mistake
- Write a bit about swizzling interrupts on the interrupt
  controller side
- Reasonable swizzling in the interrupt mapping example

This can be merged to the PCI tree whenever it is considered
fine for inclusion.
---
 .../devicetree/bindings/pci/faraday,ftpci100.txt   | 129 +++++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/faraday,ftpci100.txt

diff --git a/Documentation/devicetree/bindings/pci/faraday,ftpci100.txt b/Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
new file mode 100644
index 000000000000..35d4a979bb7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
@@ -0,0 +1,129 @@
+Faraday Technology FTPCI100 PCI Host Bridge
+
+This PCI bridge is found inside that Cortina Systems Gemini SoC platform and
+is a generic IP block from Faraday Technology. It exists in two variants:
+plain and dual PCI. The plain version embeds a cascading interrupt controller
+into the host bridge. The dual version routes the interrupts to the host
+chips interrupt controller.
+
+The host controller appear on the PCI bus with vendor ID 0x159b (Faraday
+Technology) and product ID 0x4321.
+
+Mandatory properties:
+
+- compatible: ranging from specific to generic, should be one of
+  "cortina,gemini-pci", "faraday,ftpci100"
+  "cortina,gemini-pci-dual", "faraday,ftpci100-dual"
+  "faraday,ftpci100"
+  "faraday,ftpci100-dual"
+- reg: memory base and size for the host bridge
+- #address-cells: set to <3>
+- #size-cells: set to <2>
+- #interrupt-cells: set to <1>
+- bus-range: set to <0x00 0xff>
+- device_type, set to "pci"
+- ranges: see pci.txt
+- interrupt-map-mask: see pci.txt
+- interrupt-map: see pci.txt
+- dma-ranges: three ranges for the inbound memory region. The ranges must
+  be aligned to a 1MB boundary, and may be 1MB, 2MB, 4MB, 8MB, 16MB, 32MB, 64MB,
+  128MB, 256MB, 512MB, 1GB or 2GB in size. The memory should be marked as
+  pre-fetchable.
+
+Mandatory subnodes:
+- For "faraday,ftpci100" a node representing the interrupt-controller inside the
+  host bridge is mandatory. It has the following mandatory properties:
+  - interrupt: see interrupt-controller/interrupts.txt
+  - interrupt-parent: see interrupt-controller/interrupts.txt
+  - interrupt-controller: see interrupt-controller/interrupts.txt
+  - #address-cells: set to <0>
+  - #interrupt-cells: set to <1>
+
+I/O space considerations:
+
+The plain variant has 128MiB of non-prefetchable memory space, whereas the
+"dual" variant has 64MiB. Take this into account when describing the ranges.
+
+Interrupt map considerations:
+
+The "dual" variant will get INT A, B, C, D from the system interrupt controller
+and should point to respective interrupt in that controller in its
+interrupt-map.
+
+The code which is the only documentation of how the Faraday PCI (the non-dual
+variant) interrupts assigns the default interrupt mapping/swizzling has
+typically been like this, doing the swizzling on the interrupt controller side
+rather than in the interconnect:
+
+interrupt-map-mask = <0xf800 0 0 7>;
+interrupt-map =
+	<0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
+	<0x4800 0 0 2 &pci_intc 1>,
+	<0x4800 0 0 3 &pci_intc 2>,
+	<0x4800 0 0 4 &pci_intc 3>,
+	<0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
+	<0x5000 0 0 2 &pci_intc 2>,
+	<0x5000 0 0 3 &pci_intc 3>,
+	<0x5000 0 0 4 &pci_intc 0>,
+	<0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
+	<0x5800 0 0 2 &pci_intc 3>,
+	<0x5800 0 0 3 &pci_intc 0>,
+	<0x5800 0 0 4 &pci_intc 1>,
+	<0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
+	<0x6000 0 0 2 &pci_intc 0>,
+	<0x6000 0 0 3 &pci_intc 1>,
+	<0x6000 0 0 4 &pci_intc 2>;
+
+Example:
+
+pci@50000000 {
+	compatible = "cortina,gemini-pci", "faraday,ftpci100";
+	reg = <0x50000000 0x100>;
+	interrupts = <8 IRQ_TYPE_LEVEL_HIGH>, /* PCI A */
+			<26 IRQ_TYPE_LEVEL_HIGH>, /* PCI B */
+			<27 IRQ_TYPE_LEVEL_HIGH>, /* PCI C */
+			<28 IRQ_TYPE_LEVEL_HIGH>; /* PCI D */
+	#address-cells = <3>;
+	#size-cells = <2>;
+	#interrupt-cells = <1>;
+
+	bus-range = <0x00 0xff>;
+	ranges = /* 1MiB I/O space 0x50000000-0x500fffff */
+		 <0x01000000 0 0          0x50000000 0 0x00100000>,
+		 /* 128MiB non-prefetchable memory 0x58000000-0x5fffffff */
+		 <0x02000000 0 0x58000000 0x58000000 0 0x08000000>;
+
+	/* DMA ranges */
+	dma-ranges =
+	/* 128MiB at 0x00000000-0x07ffffff */
+	<0x02000000 0 0x00000000 0x00000000 0 0x08000000>,
+	/* 64MiB at 0x00000000-0x03ffffff */
+	<0x02000000 0 0x00000000 0x00000000 0 0x04000000>,
+	/* 64MiB at 0x00000000-0x03ffffff */
+	<0x02000000 0 0x00000000 0x00000000 0 0x04000000>;
+
+	interrupt-map-mask = <0xf800 0 0 7>;
+	interrupt-map =
+		<0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
+		<0x4800 0 0 2 &pci_intc 1>,
+		<0x4800 0 0 3 &pci_intc 2>,
+		<0x4800 0 0 4 &pci_intc 3>,
+		<0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
+		<0x5000 0 0 2 &pci_intc 2>,
+		<0x5000 0 0 3 &pci_intc 3>,
+		<0x5000 0 0 4 &pci_intc 0>,
+		<0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
+		<0x5800 0 0 2 &pci_intc 3>,
+		<0x5800 0 0 3 &pci_intc 0>,
+		<0x5800 0 0 4 &pci_intc 1>,
+		<0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
+		<0x6000 0 0 2 &pci_intc 0>,
+		<0x6000 0 0 3 &pci_intc 0>,
+		<0x6000 0 0 4 &pci_intc 0>;
+	pci_intc: interrupt-controller {
+		interrupt-parent = <&intcon>;
+		interrupt-controller;
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+	};
+};
-- 
2.9.3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
