Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33026 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755149AbdIGLok (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Sep 2017 07:44:40 -0400
Received: by mail-lf0-f42.google.com with SMTP id c80so1853788lfh.0
        for <linux-pci@vger.kernel.org>; Thu, 07 Sep 2017 04:44:39 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc: linux-pci@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2 v3] PCI: v3: Update the device tree bindings
Date: Thu,  7 Sep 2017 13:44:30 +0200
Message-Id: <20170907114431.4748-1-linus.walleij@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The bindings for the V3 Semiconductor PCI bridge are a tad bit outdated
and predates the more formal format we have adopted for the bindings.

Update them a bit so it is easier to read, and add the Integrator AP-
specific compatible so we can detect that we are running on that specific
platform.

Add a second register bank for the configuration memory area. The
device tree specs does specify a memory range for configuration
space but it is not applicable to custom accessors like this. Instead
follow the pattern from the Versatile PCI adapter and simply add
a second register bank for this memory.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Add a second register bank for the config space.
- Mention that nonpre and pre memory must be 256MB and adjacent
- Make the prefetched and non-prefetched memory mapped 1:1 to
  the PCI address space so that local bus 0x40000000 and
  0x50000000 maps to the *same* local (CPU) bus addresses.
- Add reference to dma-ranges and that this is required.
- Add an example from the ARM Integrator/AP
- Rob ACKed an earlier version, he might want to have a glance
  at this before merging.
ChangeLog v1->v2:
- Added Rob's ACK.

Bjorn: please merge this when you feel confident with it.
---
 .../devicetree/bindings/pci/v3-v360epc-pci.txt     | 73 +++++++++++++++++++---
 1 file changed, 66 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt b/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
index 30b364e504ba..7729295506f5 100644
--- a/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
+++ b/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
@@ -2,14 +2,73 @@ V3 Semiconductor V360 EPC PCI bridge
 
 This bridge is found in the ARM Integrator/AP (Application Platform)
 
-Integrator-specific notes:
+Required properties:
+- compatible: should be one of:
+  "v3,v360epc-pci"
+  "arm,integrator-ap-pci", "v3,v360epc-pci"
+- reg: should contain two register areas:
+  first the base address of the V3 host bridge controller, 64KB
+  second the configuration area register space, 16MB
+- interrupts: should contain a reference to the V3 error interrupt
+  as routed on the system.
+- ranges: this follows the standard PCI bindings in the IEEE Std
+  1275-1994 (see pci.txt) with the following restriction:
+  - The non-prefetchable and prefetchable memory windows must
+    each be exactly 256MB (0x10000000) in size.
+  - The prefetchable memory window must be immediately adjacent
+    to the non-prefetcable memory window
+- dma-ranges: three ranges for the inbound memory region. The ranges must
+  be aligned to a 1MB boundary, and may be 1MB, 2MB, 4MB, 8MB, 16MB, 32MB,
+  64MB, 128MB, 256MB, 512MB, 1GB or 2GB in size. The memory should be marked
+  as pre-fetchable. Two ranges are supported by the hardware.
 
-- syscon: should contain a link to the syscon device node (since
+Integrator-specific required properties:
+- syscon: should contain a link to the syscon device node, since
   on the Integrator, some registers in the syscon are required to
-  operate the V3).
+  operate the V3 host bridge.
 
-V360 EPC specific notes:
+Example:
 
-- reg: should contain the base address of the V3 adapter.
-- interrupts: should contain a reference to the V3 error interrupt
-  as routed on the system.
+pci: pciv3@62000000 {
+	compatible = "arm,integrator-ap-pci", "v3,v360epc-pci";
+	#interrupt-cells = <1>;
+	#size-cells = <2>;
+	#address-cells = <3>;
+	reg = <0x62000000 0x10000>, <0x61000000 0x01000000>;
+	interrupt-parent = <&pic>;
+	interrupts = <17>; /* Bus error IRQ */
+	clocks = <&pciclk>;
+	ranges = 0x01000000 0 0x00000000 /* I/O space @00000000 */
+		0x60000000 0 0x01000000 /* 16 MiB @ LB 60000000 */
+		0x02000000 0 0x40000000 /* non-prefectable memory @40000000 */
+		0x40000000 0 0x10000000 /* 256 MiB @ LB 40000000 1:1 */
+		0x42000000 0 0x50000000 /* prefetchable memory @50000000 */
+		0x50000000 0 0x10000000>; /* 256 MiB @ LB 50000000 1:1 */
+	dma-ranges = <0x02000000 0 0x20000000 /* EBI memory space */
+		0x20000000 0 0x20000000 /* 512 MB @ LB 20000000 1:1 */
+		0x02000000 0 0x80000000 /* Core module alias memory */
+		0x80000000 0 0x40000000>; /* 1GB @ LB 80000000 */
+	interrupt-map-mask = <0xf800 0 0 0x7>;
+	interrupt-map = <
+	/* IDSEL 9 */
+	0x4800 0 0 1 &pic 13 /* INT A on slot 9 is irq 13 */
+	0x4800 0 0 2 &pic 14 /* INT B on slot 9 is irq 14 */
+	0x4800 0 0 3 &pic 15 /* INT C on slot 9 is irq 15 */
+	0x4800 0 0 4 &pic 16 /* INT D on slot 9 is irq 16 */
+	/* IDSEL 10 */
+	0x5000 0 0 1 &pic 14 /* INT A on slot 10 is irq 14 */
+	0x5000 0 0 2 &pic 15 /* INT B on slot 10 is irq 15 */
+	0x5000 0 0 3 &pic 16 /* INT C on slot 10 is irq 16 */
+	0x5000 0 0 4 &pic 13 /* INT D on slot 10 is irq 13 */
+	/* IDSEL 11 */
+	0x5800 0 0 1 &pic 15 /* INT A on slot 11 is irq 15 */
+	0x5800 0 0 2 &pic 16 /* INT B on slot 11 is irq 16 */
+	0x5800 0 0 3 &pic 13 /* INT C on slot 11 is irq 13 */
+	0x5800 0 0 4 &pic 14 /* INT D on slot 11 is irq 14 */
+	/* IDSEL 12 */
+	0x6000 0 0 1 &pic 16 /* INT A on slot 12 is irq 16 */
+	0x6000 0 0 2 &pic 13 /* INT B on slot 12 is irq 13 */
+	0x6000 0 0 3 &pic 14 /* INT C on slot 12 is irq 14 */
+	0x6000 0 0 4 &pic 15 /* INT D on slot 12 is irq 15 */
+	>;
+};
-- 
2.13.5
