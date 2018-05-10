Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 2/2] PCI: Clean up whitespace in quirks.c
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Thu, 10 May 2018 17:09:21 -0500
Message-ID: <152599016161.234504.12705634120120531142.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152599011048.234504.9006188618412032582.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152599011048.234504.9006188618412032582.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Clean up whitespace, capitalization, etc. in comments.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/quirks.c |  664 +++++++++++++++++++++++++-------------------------
 1 file changed, 329 insertions(+), 335 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0f2b117cc59c..de7c77e2ebbd 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -199,9 +199,10 @@ static void quirk_mmio_always_on(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_ANY_ID, PCI_ANY_ID,
 				PCI_CLASS_BRIDGE_HOST, 8, quirk_mmio_always_on);
 
-/* The Mellanox Tavor device gives false positive parity errors
- * Mark this device with a broken_parity_status, to allow
- * PCI scanning code to "skip" this now blacklisted device.
+/*
+ * The Mellanox Tavor device gives false positive parity errors.  Mark this
+ * device with a broken_parity_status to allow PCI scanning code to "skip"
+ * this now blacklisted device.
  */
 static void quirk_mellanox_tavor(struct pci_dev *dev)
 {
@@ -210,15 +211,19 @@ static void quirk_mellanox_tavor(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_TAVOR, quirk_mellanox_tavor);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_TAVOR_BRIDGE, quirk_mellanox_tavor);
 
-/* Deal with broken BIOSes that neglect to enable passive release,
-   which can cause problems in combination with the 82441FX/PPro MTRRs */
+/*
+ * Deal with broken BIOSes that neglect to enable passive release,
+ * which can cause problems in combination with the 82441FX/PPro MTRRs
+ */
 static void quirk_passive_release(struct pci_dev *dev)
 {
 	struct pci_dev *d = NULL;
 	unsigned char dlc;
 
-	/* We have to make sure a particular bit is set in the PIIX3
-	   ISA bridge, so we have to go out and find it. */
+	/*
+	 * We have to make sure a particular bit is set in the PIIX3
+	 * ISA bridge, so we have to go out and find it.
+	 */
 	while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371SB_0, d))) {
 		pci_read_config_byte(d, 0x82, &dlc);
 		if (!(dlc & 1<<1)) {
@@ -231,13 +236,14 @@ static void quirk_passive_release(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release);
 
-/*  The VIA VP2/VP3/MVP3 seem to have some 'features'. There may be a workaround
-    but VIA don't answer queries. If you happen to have good contacts at VIA
-    ask them for me please -- Alan
-
-    This appears to be BIOS not version dependent. So presumably there is a
-    chipset level fix */
-
+/*
+ * The VIA VP2/VP3/MVP3 seem to have some 'features'. There may be a
+ * workaround but VIA don't answer queries. If you happen to have good
+ * contacts at VIA ask them for me please -- Alan
+ *
+ * This appears to be BIOS not version dependent. So presumably there is a
+ * chipset level fix.
+ */
 static void quirk_isa_dma_hangs(struct pci_dev *dev)
 {
 	if (!isa_dma_bridge_buggy) {
@@ -245,10 +251,10 @@ static void quirk_isa_dma_hangs(struct pci_dev *dev)
 		pci_info(dev, "Activating ISA DMA hang workarounds\n");
 	}
 }
-	/*
-	 * Its not totally clear which chipsets are the problematic ones
-	 * We know 82C586 and 82C596 variants are affected.
-	 */
+/*
+ * It's not totally clear which chipsets are the problematic ones.  We know
+ * 82C586 and 82C596 variants are affected.
+ */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_0,	quirk_isa_dma_hangs);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C596,	quirk_isa_dma_hangs);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82371SB_0,  quirk_isa_dma_hangs);
@@ -277,9 +283,7 @@ static void quirk_tigerpoint_bm_sts(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGP_LPC, quirk_tigerpoint_bm_sts);
 
-/*
- *	Chipsets where PCI->PCI transfers vanish or hang
- */
+/* Chipsets where PCI->PCI transfers vanish or hang */
 static void quirk_nopcipci(struct pci_dev *dev)
 {
 	if ((pci_pci_problems & PCIPCI_FAIL) == 0) {
@@ -302,9 +306,7 @@ static void quirk_nopciamd(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8151_0,	quirk_nopciamd);
 
-/*
- *	Triton requires workarounds to be used by the drivers
- */
+/* Triton requires workarounds to be used by the drivers */
 static void quirk_triton(struct pci_dev *dev)
 {
 	if ((pci_pci_problems&PCIPCI_TRITON) == 0) {
@@ -318,53 +320,62 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82439,	quirk_tr
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82439TX,	quirk_triton);
 
 /*
- *	VIA Apollo KT133 needs PCI latency patch
- *	Made according to a windows driver based patch by George E. Breese
- *	see PCI Latency Adjust on http://www.viahardware.com/download/viatweak.shtm
- *	Also see http://www.au-ja.org/review-kt133a-1-en.phtml for
- *	the info on which Mr Breese based his work.
+ * VIA Apollo KT133 needs PCI latency patch
+ * Made according to a Windows driver-based patch by George E. Breese;
+ * see PCI Latency Adjust on http://www.viahardware.com/download/viatweak.shtm
+ * Also see http://www.au-ja.org/review-kt133a-1-en.phtml for the info on
+ * which Mr Breese based his work.
  *
- *	Updated based on further information from the site and also on
- *	information provided by VIA
+ * Updated based on further information from the site and also on
+ * information provided by VIA
  */
 static void quirk_vialatency(struct pci_dev *dev)
 {
 	struct pci_dev *p;
 	u8 busarb;
-	/* Ok we have a potential problem chipset here. Now see if we have
-	   a buggy southbridge */
 
+	/*
+	 * Ok, we have a potential problem chipset here. Now see if we have
+	 * a buggy southbridge.
+	 */
 	p = pci_get_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, NULL);
 	if (p != NULL) {
-		/* 0x40 - 0x4f == 686B, 0x10 - 0x2f == 686A; thanks Dan Hollis */
-		/* Check for buggy part revisions */
+
+		/*
+		 * 0x40 - 0x4f == 686B, 0x10 - 0x2f == 686A;
+		 * thanks Dan Hollis.
+		 * Check for buggy part revisions
+		 */
 		if (p->revision < 0x40 || p->revision > 0x42)
 			goto exit;
 	} else {
 		p = pci_get_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8231, NULL);
 		if (p == NULL)	/* No problem parts */
 			goto exit;
+
 		/* Check for buggy part revisions */
 		if (p->revision < 0x10 || p->revision > 0x12)
 			goto exit;
 	}
 
 	/*
-	 *	Ok we have the problem. Now set the PCI master grant to
-	 *	occur every master grant. The apparent bug is that under high
-	 *	PCI load (quite common in Linux of course) you can get data
-	 *	loss when the CPU is held off the bus for 3 bus master requests
-	 *	This happens to include the IDE controllers....
+	 * Ok we have the problem. Now set the PCI master grant to occur
+	 * every master grant. The apparent bug is that under high PCI load
+	 * (quite common in Linux of course) you can get data loss when the
+	 * CPU is held off the bus for 3 bus master requests.  This happens
+	 * to include the IDE controllers....
 	 *
-	 *	VIA only apply this fix when an SB Live! is present but under
-	 *	both Linux and Windows this isn't enough, and we have seen
-	 *	corruption without SB Live! but with things like 3 UDMA IDE
-	 *	controllers. So we ignore that bit of the VIA recommendation..
+	 * VIA only apply this fix when an SB Live! is present but under
+	 * both Linux and Windows this isn't enough, and we have seen
+	 * corruption without SB Live! but with things like 3 UDMA IDE
+	 * controllers. So we ignore that bit of the VIA recommendation..
 	 */
-
 	pci_read_config_byte(dev, 0x76, &busarb);
-	/* Set bit 4 and bi 5 of byte 76 to 0x01
-	   "Master priority rotation on every PCI master grant */
+
+	/*
+	 * Set bit 4 and bit 5 of byte 76 to 0x01
+	 * "Master priority rotation on every PCI master grant"
+	 */
 	busarb &= ~(1<<5);
 	busarb |= (1<<4);
 	pci_write_config_byte(dev, 0x76, busarb);
@@ -380,9 +391,7 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	quirk_vial
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8371_1,	quirk_vialatency);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,		quirk_vialatency);
 
-/*
- *	VIA Apollo VP3 needs ETBF on BT848/878
- */
+/* VIA Apollo VP3 needs ETBF on BT848/878 */
 static void quirk_viaetbf(struct pci_dev *dev)
 {
 	if ((pci_pci_problems&PCIPCI_VIAETBF) == 0) {
@@ -402,10 +411,9 @@ static void quirk_vsfx(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C576,	quirk_vsfx);
 
 /*
- *	Ali Magik requires workarounds to be used by the drivers
- *	that DMA to AGP space. Latency must be set to 0xA and triton
- *	workaround applied too
- *	[Info kindly provided by ALi]
+ * ALi Magik requires workarounds to be used by the drivers that DMA to AGP
+ * space. Latency must be set to 0xA and Triton workaround applied too.
+ * [Info kindly provided by ALi]
  */
 static void quirk_alimagik(struct pci_dev *dev)
 {
@@ -417,10 +425,7 @@ static void quirk_alimagik(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M1647,		quirk_alimagik);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M1651,		quirk_alimagik);
 
-/*
- *	Natoma has some interesting boundary conditions with Zoran stuff
- *	at least
- */
+/* Natoma has some interesting boundary conditions with Zoran stuff at least */
 static void quirk_natoma(struct pci_dev *dev)
 {
 	if ((pci_pci_problems&PCIPCI_NATOMA) == 0) {
@@ -436,8 +441,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82443BX_1,	quir
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82443BX_2,	quirk_natoma);
 
 /*
- *  This chip can cause PCI parity errors if config register 0xA0 is read
- *  while DMAs are occurring.
+ * This chip can cause PCI parity errors if config register 0xA0 is read
+ * while DMAs are occurring.
  */
 static void quirk_citrine(struct pci_dev *dev)
 {
@@ -477,8 +482,8 @@ static void quirk_extend_bar_to_page(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM, 0x034a, quirk_extend_bar_to_page);
 
 /*
- *  S3 868 and 968 chips report region size equal to 32M, but they decode 64M.
- *  If it's needed, re-allocate the region.
+ * S3 868 and 968 chips report region size equal to 32M, but they decode 64M.
+ * If it's needed, re-allocate the region.
  */
 static void quirk_s3_64M(struct pci_dev *dev)
 {
@@ -569,8 +574,8 @@ static void quirk_io_region(struct pci_dev *dev, int port,
 }
 
 /*
- *	ATI Northbridge setups MCE the processor if you even
- *	read somewhere between 0x3b0->0x3bb or read 0x3d3
+ * ATI Northbridge setups MCE the processor if you even read somewhere
+ * between 0x3b0->0x3bb or read 0x3d3
  */
 static void quirk_ati_exploding_mce(struct pci_dev *dev)
 {
@@ -585,6 +590,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_
  * In the AMD NL platform, this device ([1022:7912]) has a class code of
  * PCI_CLASS_SERIAL_USB_XHCI (0x0c0330), which means the xhci driver will
  * claim it.
+ *
  * But the dwc3 driver is a more specific driver for this device, and we'd
  * prefer to use it instead of xhci. To prevent xhci from claiming the
  * device, change the class code to 0x0c03fe, which the PCI r3.0 spec
@@ -604,11 +610,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
 		quirk_amd_nl_class);
 
 /*
- * Let's make the southbridge information explicit instead
- * of having to worry about people probing the ACPI areas,
- * for example.. (Yes, it happens, and if you read the wrong
- * ACPI register it will put the machine to sleep with no
- * way of waking it up again. Bummer).
+ * Let's make the southbridge information explicit instead of having to
+ * worry about people probing the ACPI areas, for example.. (Yes, it
+ * happens, and if you read the wrong ACPI register it will put the machine
+ * to sleep with no way of waking it up again. Bummer).
  *
  * ALI M7101: Two IO regions pointed to by words at
  *	0xE0 (64 bytes of ACPI registers)
@@ -664,6 +669,7 @@ static void piix4_mem_quirk(struct pci_dev *dev, const char *name, unsigned int
 			break;
 		size = bit;
 	}
+
 	/*
 	 * For now we only print it out. Eventually we'll want to
 	 * reserve it, but let's get enough confirmation reports first.
@@ -735,8 +741,7 @@ static void quirk_ich4_lpc_acpi(struct pci_dev *dev)
 	 * priority and can't tell whether the legacy device or the one created
 	 * here is really at that address.  This happens on boards with broken
 	 * BIOSes.
-	*/
-
+	 */
 	pci_read_config_byte(dev, ICH_ACPI_CNTL, &enable);
 	if (enable & ICH4_ACPI_EN)
 		quirk_io_region(dev, ICH_PMBASE, 128, PCI_BRIDGE_RESOURCES,
@@ -773,7 +778,8 @@ static void ich6_lpc_acpi_gpio(struct pci_dev *dev)
 				"ICH6 GPIO");
 }
 
-static void ich6_lpc_generic_decode(struct pci_dev *dev, unsigned reg, const char *name, int dynsize)
+static void ich6_lpc_generic_decode(struct pci_dev *dev, unsigned reg,
+				    const char *name, int dynsize)
 {
 	u32 val;
 	u32 size, base;
@@ -797,7 +803,10 @@ static void ich6_lpc_generic_decode(struct pci_dev *dev, unsigned reg, const cha
 	}
 	base &= ~(size-1);
 
-	/* Just print it out for now. We should reserve it after more debugging */
+	/*
+	 * Just print it out for now. We should reserve it after more
+	 * debugging.
+	 */
 	pci_info(dev, "%s PIO at %04x-%04x\n", name, base, base+size-1);
 }
 
@@ -813,7 +822,8 @@ static void quirk_ich6_lpc(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_0, quirk_ich6_lpc);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1, quirk_ich6_lpc);
 
-static void ich7_lpc_generic_decode(struct pci_dev *dev, unsigned reg, const char *name)
+static void ich7_lpc_generic_decode(struct pci_dev *dev, unsigned reg,
+				    const char *name)
 {
 	u32 val;
 	u32 mask, base;
@@ -824,15 +834,15 @@ static void ich7_lpc_generic_decode(struct pci_dev *dev, unsigned reg, const cha
 	if (!(val & 1))
 		return;
 
-	/*
-	 * IO base in bits 15:2, mask in bits 23:18, both
-	 * are dword-based
-	 */
+	/* IO base in bits 15:2, mask in bits 23:18, both are dword-based */
 	base = val & 0xfffc;
 	mask = (val >> 16) & 0xfc;
 	mask |= 3;
 
-	/* Just print it out for now. We should reserve it after more debugging */
+	/*
+	 * Just print it out for now. We should reserve it after more
+	 * debugging.
+	 */
 	pci_info(dev, "%s PIO at %04x (mask %04x)\n", name, base, mask);
 }
 
@@ -904,8 +914,8 @@ static void quirk_vt8235_acpi(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8235,	quirk_vt8235_acpi);
 
 /*
- * TI XIO2000a PCIe-PCI Bridge erroneously reports it supports fast back-to-back:
- *	Disable fast back-to-back on the secondary bus segment
+ * TI XIO2000a PCIe-PCI Bridge erroneously reports it supports fast
+ * back-to-back: Disable fast back-to-back on the secondary bus segment
  */
 static void quirk_xio2000a(struct pci_dev *dev)
 {
@@ -930,8 +940,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_XIO2000A,
  * VIA 686A/B: If an IO-APIC is active, we need to route all on-chip
  * devices to the external APIC.
  *
- * TODO: When we have device-specific interrupt routers,
- * this code will go away from quirks.
+ * TODO: When we have device-specific interrupt routers, this code will go
+ * away from quirks.
  */
 static void quirk_via_ioapic(struct pci_dev *dev)
 {
@@ -972,13 +982,13 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237,		quirk_via_vt
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237,		quirk_via_vt8237_bypass_apic_deassert);
 
 /*
- * The AMD io apic can hang the box when an apic irq is masked.
+ * The AMD IO-APIC can hang the box when an APIC IRQ is masked.
  * We check all revs >= B0 (yet not in the pre production!) as the bug
  * is currently marked NoFix
  *
  * We have multiple reports of hangs with this chipset that went away with
  * noapic specified. For the moment we assume it's the erratum. We may be wrong
- * of course. However the advice is demonstrably good even if so..
+ * of course. However the advice is demonstrably good even if so.
  */
 static void quirk_amd_ioapic(struct pci_dev *dev)
 {
@@ -994,7 +1004,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7410,	quirk_a
 
 static void quirk_cavium_sriov_rnm_link(struct pci_dev *dev)
 {
-	/* Fix for improper SRIOV configuration on Cavium cn88xx  RNM device */
+	/* Fix for improper SR-IOV configuration on Cavium cn88xx RNM device */
 	if (dev->subsystem_device == 0xa118)
 		dev->sriov->link = dev->devfn;
 }
@@ -1016,19 +1026,17 @@ static void quirk_amd_8131_mmrbc(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_amd_8131_mmrbc);
 
 /*
- * FIXME: it is questionable that quirk_via_acpi
- * is needed.  It shows up as an ISA bridge, and does not
- * support the PCI_INTERRUPT_LINE register at all.  Therefore
- * it seems like setting the pci_dev's 'irq' to the
- * value of the ACPI SCI interrupt is only done for convenience.
+ * FIXME: it is questionable that quirk_via_acpi() is needed.  It shows up
+ * as an ISA bridge, and does not support the PCI_INTERRUPT_LINE register
+ * at all.  Therefore it seems like setting the pci_dev's IRQ to the value
+ * of the ACPI SCI interrupt is only done for convenience.
  *	-jgarzik
  */
 static void quirk_via_acpi(struct pci_dev *d)
 {
-	/*
-	 * VIA ACPI device: SCI IRQ line in PCI config byte 0x42
-	 */
 	u8 irq;
+
+	/* VIA ACPI device: SCI IRQ line in PCI config byte 0x42 */
 	pci_read_config_byte(d, 0x42, &irq);
 	irq &= 0xf;
 	if (irq && (irq != 2))
@@ -1037,11 +1045,7 @@ static void quirk_via_acpi(struct pci_dev *d)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi);
 
-
-/*
- *	VIA bridges which have VLink
- */
-
+/* VIA bridges which have VLink */
 static int via_vlink_dev_lo = -1, via_vlink_dev_hi = 18;
 
 static void quirk_via_bridge(struct pci_dev *dev)
@@ -1049,9 +1053,11 @@ static void quirk_via_bridge(struct pci_dev *dev)
 	/* See what bridge we have and find the device ranges */
 	switch (dev->device) {
 	case PCI_DEVICE_ID_VIA_82C686:
-		/* The VT82C686 is special, it attaches to PCI and can have
-		   any device number. All its subdevices are functions of
-		   that single device. */
+		/*
+		 * The VT82C686 is special; it attaches to PCI and can have
+		 * any device number. All its subdevices are functions of
+		 * that single device.
+		 */
 		via_vlink_dev_lo = PCI_SLOT(dev->devfn);
 		via_vlink_dev_hi = PCI_SLOT(dev->devfn);
 		break;
@@ -1079,19 +1085,17 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8235,		quirk_via_b
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237,		quirk_via_bridge);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237A,	quirk_via_bridge);
 
-/**
- *	quirk_via_vlink		-	VIA VLink IRQ number update
- *	@dev: PCI device
+/*
+ * quirk_via_vlink		-	VIA VLink IRQ number update
+ * @dev: PCI device
  *
- *	If the device we are dealing with is on a PIC IRQ we need to
- *	ensure that the IRQ line register which usually is not relevant
- *	for PCI cards, is actually written so that interrupts get sent
- *	to the right place.
- *	We only do this on systems where a VIA south bridge was detected,
- *	and only for VIA devices on the motherboard (see quirk_via_bridge
- *	above).
+ * If the device we are dealing with is on a PIC IRQ we need to ensure that
+ * the IRQ line register which usually is not relevant for PCI cards, is
+ * actually written so that interrupts get sent to the right place.
+ *
+ * We only do this on systems where a VIA south bridge was detected, and
+ * only for VIA devices on the motherboard (see quirk_via_bridge above).
  */
-
 static void quirk_via_vlink(struct pci_dev *dev)
 {
 	u8 irq, new_irq;
@@ -1111,9 +1115,10 @@ static void quirk_via_vlink(struct pci_dev *dev)
 	    PCI_SLOT(dev->devfn) < via_vlink_dev_lo)
 		return;
 
-	/* This is an internal VLink device on a PIC interrupt. The BIOS
-	   ought to have set this but may not have, so we redo it */
-
+	/*
+	 * This is an internal VLink device on a PIC interrupt. The BIOS
+	 * ought to have set this but may not have, so we redo it.
+	 */
 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 	if (new_irq != irq) {
 		pci_info(dev, "VIA VLink IRQ fixup, from %d to %d\n",
@@ -1125,10 +1130,9 @@ static void quirk_via_vlink(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_vlink);
 
 /*
- * VIA VT82C598 has its device ID settable and many BIOSes
- * set it to the ID of VT82C597 for backward compatibility.
- * We need to switch it off to be able to recognize the real
- * type of the chip.
+ * VIA VT82C598 has its device ID settable and many BIOSes set it to the ID
+ * of VT82C597 for backward compatibility.  We need to switch it off to be
+ * able to recognize the real type of the chip.
  */
 static void quirk_vt82c598_id(struct pci_dev *dev)
 {
@@ -1138,10 +1142,10 @@ static void quirk_vt82c598_id(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_vt82c598_id);
 
 /*
- * CardBus controllers have a legacy base address that enables them
- * to respond as i82365 pcmcia controllers.  We don't want them to
- * do this even if the Linux CardBus driver is not loaded, because
- * the Linux i82365 driver does not (and should not) handle CardBus.
+ * CardBus controllers have a legacy base address that enables them to
+ * respond as i82365 pcmcia controllers.  We don't want them to do this
+ * even if the Linux CardBus driver is not loaded, because the Linux i82365
+ * driver does not (and should not) handle CardBus.
  */
 static void quirk_cardbus_legacy(struct pci_dev *dev)
 {
@@ -1153,11 +1157,11 @@ DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY(PCI_ANY_ID, PCI_ANY_ID,
 			PCI_CLASS_BRIDGE_CARDBUS, 8, quirk_cardbus_legacy);
 
 /*
- * Following the PCI ordering rules is optional on the AMD762. I'm not
- * sure what the designers were smoking but let's not inhale...
+ * Following the PCI ordering rules is optional on the AMD762. I'm not sure
+ * what the designers were smoking but let's not inhale...
  *
- * To be fair to AMD, it follows the spec by default, its BIOS people
- * who turn it off!
+ * To be fair to AMD, it follows the spec by default, it's BIOS people who
+ * turn it off!
  */
 static void quirk_amd_ordering(struct pci_dev *dev)
 {
@@ -1176,11 +1180,11 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_FE_GATE_700C, quirk
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_FE_GATE_700C, quirk_amd_ordering);
 
 /*
- *	DreamWorks provided workaround for Dunord I-3000 problem
+ * DreamWorks-provided workaround for Dunord I-3000 problem
  *
- *	This card decodes and responds to addresses not apparently
- *	assigned to it. We force a larger allocation to ensure that
- *	nothing gets put too close to it.
+ * This card decodes and responds to addresses not apparently assigned to
+ * it.  We force a larger allocation to ensure that nothing gets put too
+ * close to it.
  */
 static void quirk_dunord(struct pci_dev *dev)
 {
@@ -1193,10 +1197,9 @@ static void quirk_dunord(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_DUNORD,	PCI_DEVICE_ID_DUNORD_I3000,	quirk_dunord);
 
 /*
- * i82380FB mobile docking controller: its PCI-to-PCI bridge
- * is subtractive decoding (transparent), and does indicate this
- * in the ProgIf. Unfortunately, the ProgIf value is wrong - 0x80
- * instead of 0x01.
+ * i82380FB mobile docking controller: its PCI-to-PCI bridge is subtractive
+ * decoding (transparent), and does indicate this in the ProgIf.
+ * Unfortunately, the ProgIf value is wrong - 0x80 instead of 0x01.
  */
 static void quirk_transparent_bridge(struct pci_dev *dev)
 {
@@ -1206,10 +1209,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82380FB,	quirk
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA,	0x605,	quirk_transparent_bridge);
 
 /*
- * Common misconfiguration of the MediaGX/Geode PCI master that will
- * reduce PCI bandwidth from 70MB/s to 25MB/s.  See the GXM/GXLV/GX1
- * datasheets found at http://www.national.com/analog for info on what
- * these bits do.  <christer@weinigel.se>
+ * Common misconfiguration of the MediaGX/Geode PCI master that will reduce
+ * PCI bandwidth from 70MB/s to 25MB/s.  See the GXM/GXLV/GX1 datasheets
+ * found at http://www.national.com/analog for info on what these bits do.
+ * <christer@weinigel.se>
  */
 static void quirk_mediagx_master(struct pci_dev *dev)
 {
@@ -1227,9 +1230,9 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, qui
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master);
 
 /*
- *	Ensure C0 rev restreaming is off. This is normally done by
- *	the BIOS but in the odd case it is not the results are corruption
- *	hence the presence of a Linux check
+ * Ensure C0 rev restreaming is off. This is normally done by the BIOS but
+ * in the odd case it is not the results are corruption hence the presence
+ * of a Linux check.
  */
 static void quirk_disable_pxb(struct pci_dev *pdev)
 {
@@ -1273,9 +1276,7 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x7900, quirk_amd_ide_mode);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD, 0x7900, quirk_amd_ide_mode);
 
-/*
- *	Serverworks CSB5 IDE does not fully support native mode
- */
+/* Serverworks CSB5 IDE does not fully support native mode */
 static void quirk_svwks_csb5ide(struct pci_dev *pdev)
 {
 	u8 prog;
@@ -1289,9 +1290,7 @@ static void quirk_svwks_csb5ide(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, quirk_svwks_csb5ide);
 
-/*
- *	Intel 82801CAM ICH3-M datasheet says IDE modes must be the same
- */
+/* Intel 82801CAM ICH3-M datasheet says IDE modes must be the same */
 static void quirk_ide_samemode(struct pci_dev *pdev)
 {
 	u8 prog;
@@ -1307,10 +1306,7 @@ static void quirk_ide_samemode(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_samemode);
 
-/*
- * Some ATA devices break if put into D3
- */
-
+/* Some ATA devices break if put into D3 */
 static void quirk_no_ata_d3(struct pci_dev *pdev)
 {
 	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
@@ -1328,7 +1324,8 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID,
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
 				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
 
-/* This was originally an Alpha specific thing, but it really fits here.
+/*
+ * This was originally an Alpha-specific thing, but it really fits here.
  * The i82375 PCI/EISA bridge appears as non-classified. Fix that.
  */
 static void quirk_eisa_bridge(struct pci_dev *dev)
@@ -1337,7 +1334,6 @@ static void quirk_eisa_bridge(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82375,	quirk_eisa_bridge);
 
-
 /*
  * On ASUS P4B boards, the SMBus PCI Device within the ICH2/4 southbridge
  * is not activated. The myth is that Asus said that they do not want the
@@ -1554,15 +1550,19 @@ static void asus_hides_smbus_lpc_ich6_resume_early(struct pci_dev *dev)
 
 	if (likely(!asus_hides_smbus || !asus_rcba_base))
 		return;
+
 	/* read the Function Disable register, dword mode only */
 	val = readl(asus_rcba_base + 0x3418);
-	writel(val & 0xFFFFFFF7, asus_rcba_base + 0x3418); /* enable the SMBus device */
+
+	/* enable the SMBus device */
+	writel(val & 0xFFFFFFF7, asus_rcba_base + 0x3418);
 }
 
 static void asus_hides_smbus_lpc_ich6_resume(struct pci_dev *dev)
 {
 	if (likely(!asus_hides_smbus || !asus_rcba_base))
 		return;
+
 	iounmap(asus_rcba_base);
 	asus_rcba_base = NULL;
 	pci_info(dev, "Enabled ICH6/i801 SMBus device\n");
@@ -1579,9 +1579,7 @@ DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6_resume);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_lpc_ich6_resume_early);
 
-/*
- * SiS 96x south bridge: BIOS typically hides SMBus device...
- */
+/* SiS 96x south bridge: BIOS typically hides SMBus device...  */
 static void quirk_sis_96x_smbus(struct pci_dev *dev)
 {
 	u8 val = 0;
@@ -1604,7 +1602,7 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_si
  * ... This is further complicated by the fact that some SiS96x south
  * bridges pretend to be 85C503/5513 instead.  In that case see if we
  * spotted a compatible north bridge to make sure.
- * (pci_find_device doesn't work yet)
+ * (pci_find_device() doesn't work yet)
  *
  * We can also enable the sis96x bit in the discovery register..
  */
@@ -1624,9 +1622,9 @@ static void quirk_sis_503(struct pci_dev *dev)
 	}
 
 	/*
-	 * Ok, it now shows up as a 96x.. run the 96x quirk by
-	 * hand in case it has already been processed.
-	 * (depends on link order, which is apparently not guaranteed)
+	 * Ok, it now shows up as a 96x.  Run the 96x quirk by hand in case
+	 * it has already been processed.  (Depends on link order, which is
+	 * apparently not guaranteed)
 	 */
 	dev->device = devid;
 	quirk_sis_96x_smbus(dev);
@@ -1634,7 +1632,6 @@ static void quirk_sis_503(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503);
 
-
 /*
  * On ASUS A8V and A8V Deluxe boards, the onboard AC97 audio controller
  * and MC97 modem controller are disabled when a second PCI soundcard is
@@ -1671,9 +1668,8 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237, asus_h
 #if defined(CONFIG_ATA) || defined(CONFIG_ATA_MODULE)
 
 /*
- *	If we are using libata we can drive this chip properly but must
- *	do this early on to make the additional device appear during
- *	the PCI scanning.
+ * If we are using libata we can drive this chip properly but must do this
+ * early on to make the additional device appear during the PCI scanning.
  */
 static void quirk_jmicron_ata(struct pci_dev *pdev)
 {
@@ -1769,14 +1765,18 @@ static void quirk_alder_ioapic(struct pci_dev *pdev)
 	if ((pdev->class >> 8) != 0xff00)
 		return;
 
-	/* the first BAR is the location of the IO APIC...we must
+	/*
+	 * The first BAR is the location of the IO-APIC... we must
 	 * not touch this (and it's already covered by the fixmap), so
-	 * forcibly insert it into the resource tree */
+	 * forcibly insert it into the resource tree.
+	 */
 	if (pci_resource_start(pdev, 0) && pci_resource_len(pdev, 0))
 		insert_resource(&iomem_resource, &pdev->resource[0]);
 
-	/* The next five BARs all seem to be rubbish, so just clean
-	 * them out */
+	/*
+	 * The next five BARs all seem to be rubbish, so just clean
+	 * them out.
+	 */
 	for (i = 1; i < 6; i++)
 		memset(&pdev->resource[i], 0, sizeof(pdev->resource[i]));
 }
@@ -1794,8 +1794,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quir
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, PCI_CLASS_BRIDGE_PCI, 8, quirk_pcie_mch);
 
 /*
- * It's possible for the MSI to get corrupted if shpc and acpi
- * are used together on certain PXH-based systems.
+ * It's possible for the MSI to get corrupted if SHPC and ACPI are used
+ * together on certain PXH-based systems.
  */
 static void quirk_pcie_pxh(struct pci_dev *dev)
 {
@@ -1809,15 +1809,14 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXH_1,	quirk_pc
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXHV,	quirk_pcie_pxh);
 
 /*
- * Some Intel PCI Express chipsets have trouble with downstream
- * device power management.
+ * Some Intel PCI Express chipsets have trouble with downstream device
+ * power management.
  */
 static void quirk_intel_pcie_pm(struct pci_dev *dev)
 {
 	pci_pm_d3_delay = 120;
 	dev->no_d1d2 = 1;
 }
-
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x25e2, quirk_intel_pcie_pm);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x25e3, quirk_intel_pcie_pm);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x25e4, quirk_intel_pcie_pm);
@@ -1879,7 +1878,7 @@ static const struct dmi_system_id boot_interrupt_dmi_table[] = {
 
 /*
  * Boot interrupts on some chipsets cannot be turned off. For these chipsets,
- * remap the original interrupt in the linux kernel to the boot interrupt, so
+ * remap the original interrupt in the Linux kernel to the boot interrupt, so
  * that a PCI device's interrupt handler is installed on the boot interrupt
  * line instead.
  */
@@ -1916,7 +1915,7 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_80332_1,	quirk
  */
 
 /*
- * IO-APIC1 on 6300ESB generates boot interrupts, see intel order no
+ * IO-APIC1 on 6300ESB generates boot interrupts, see Intel order no
  * 300641-004US, section 5.7.3.
  */
 #define INTEL_6300_IOAPIC_ABAR		0x40
@@ -1939,9 +1938,7 @@ static void quirk_disable_intel_boot_interrupt(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_ESB_10,	quirk_disable_intel_boot_interrupt);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_ESB_10,	quirk_disable_intel_boot_interrupt);
 
-/*
- * disable boot interrupts on HT-1000
- */
+/* Disable boot interrupts on HT-1000 */
 #define BC_HT1000_FEATURE_REG		0x64
 #define BC_HT1000_PIC_REGS_ENABLE	(1<<0)
 #define BC_HT1000_MAP_IDX		0xC00
@@ -1972,9 +1969,8 @@ static void quirk_disable_broadcom_boot_interrupt(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS,   PCI_DEVICE_ID_SERVERWORKS_HT1000SB,	quirk_disable_broadcom_boot_interrupt);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SERVERWORKS,   PCI_DEVICE_ID_SERVERWORKS_HT1000SB,	quirk_disable_broadcom_boot_interrupt);
 
-/*
- * disable boot interrupts on AMD and ATI chipsets
- */
+/* Disable boot interrupts on AMD and ATI chipsets */
+
 /*
  * NOIOAMODE needs to be disabled to disable "boot interrupts". For AMD 8131
  * rev. A0 and B0, NOIOAMODE needs to be disabled anyway to fix IO-APIC mode
@@ -2050,7 +2046,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA_2,
 			 quirk_tc86c001_ide);
 
 /*
- * PLX PCI 9050 PCI Target bridge controller has an errata that prevents the
+ * PLX PCI 9050 PCI Target bridge controller has an erratum that prevents the
  * local configuration registers accessible via BAR0 (memory) or BAR1 (i/o)
  * being read correctly if bit 7 of the base address is set.
  * The BAR0 or BAR1 region may be disabled (size 0) or enabled (size 128).
@@ -2243,15 +2239,17 @@ static void quirk_p64h2_1k_io(struct pci_dev *dev)
 		dev->io_window_1k = 1;
 	}
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	0x1460,		quirk_p64h2_1k_io);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1460, quirk_p64h2_1k_io);
 
-/* Under some circumstances, AER is not linked with extended capabilities.
+/*
+ * Under some circumstances, AER is not linked with extended capabilities.
  * Force it to be linked by setting the corresponding control bit in the
  * config space.
  */
 static void quirk_nvidia_ck804_pcie_aer_ext_cap(struct pci_dev *dev)
 {
 	uint8_t b;
+
 	if (pci_read_config_byte(dev, 0xf41, &b) == 0) {
 		if (!(b & 0x20)) {
 			pci_write_config_byte(dev, 0xf41, b | 0x20);
@@ -2281,8 +2279,10 @@ static void quirk_via_cx700_pci_parking_caching(struct pci_dev *dev)
 		PCI_DEVICE_ID_VIA_8235_USB_2, NULL);
 	uint8_t b;
 
-	/* p should contain the first (internal) VT6212L -- see if we have
-	   an external one by searching again */
+	/*
+	 * p should contain the first (internal) VT6212L -- see if we have
+	 * an external one by searching again.
+	 */
 	p = pci_get_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8235_USB_2, p);
 	if (!p)
 		return;
@@ -2327,7 +2327,6 @@ static void quirk_brcm_5719_limit_mrrs(struct pci_dev *dev)
 			pcie_set_readrq(dev, 2048);
 	}
 }
-
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_BROADCOM,
 			 PCI_DEVICE_ID_TIGON3_5719,
 			 quirk_brcm_5719_limit_mrrs);
@@ -2335,14 +2334,16 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_BROADCOM,
 #ifdef CONFIG_PCIE_IPROC_PLATFORM
 static void quirk_paxc_bridge(struct pci_dev *pdev)
 {
-	/* The PCI config space is shared with the PAXC root port and the first
+	/*
+	 * The PCI config space is shared with the PAXC root port and the first
 	 * Ethernet device.  So, we need to workaround this by telling the PCI
 	 * code that the bridge is not an Ethernet device.
 	 */
 	if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
 		pdev->class = PCI_CLASS_BRIDGE_PCI << 8;
 
-	/* MPSS is not being set properly (as it is currently 0).  This is
+	/*
+	 * MPSS is not being set properly (as it is currently 0).  This is
 	 * because that area of the PCI config space is hard coded to zero, and
 	 * is not modifiable by firmware.  Set this to 2 (e.g., 512 byte MPS)
 	 * so that the MPS can be set to the real max value.
@@ -2353,10 +2354,10 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, quirk_paxc_bridge);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
 #endif
 
-/* Originally in EDAC sources for i82875P:
- * Intel tells BIOS developers to hide device 6 which
- * configures the overflow device access containing
- * the DRBs - this is where we expose device 6.
+/*
+ * Originally in EDAC sources for i82875P: Intel tells BIOS developers to
+ * hide device 6 which configures the overflow device access containing the
+ * DRBs - this is where we expose device 6.
  * http://www.x86-secret.com/articles/tweak/pat/patsecrets-2.htm
  */
 static void quirk_unhide_mch_dev6(struct pci_dev *dev)
@@ -2368,18 +2369,18 @@ static void quirk_unhide_mch_dev6(struct pci_dev *dev)
 		pci_write_config_byte(dev, 0xF4, reg | 0x02);
 	}
 }
-
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82865_HB,
 			quirk_unhide_mch_dev6);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82875_HB,
 			quirk_unhide_mch_dev6);
 
 #ifdef CONFIG_PCI_MSI
-/* Some chipsets do not support MSI. We cannot easily rely on setting
- * PCI_BUS_FLAGS_NO_MSI in its bus flags because there are actually
- * some other buses controlled by the chipset even if Linux is not
- * aware of it.  Instead of setting the flag on all buses in the
- * machine, simply disable MSI globally.
+/*
+ * Some chipsets do not support MSI. We cannot easily rely on setting
+ * PCI_BUS_FLAGS_NO_MSI in its bus flags because there are actually some
+ * other buses controlled by the chipset even if Linux is not aware of it.
+ * Instead of setting the flag on all buses in the machine, simply disable
+ * MSI globally.
  */
 static void quirk_disable_all_msi(struct pci_dev *dev)
 {
@@ -2427,8 +2428,10 @@ static void quirk_amd_780_apc_msi(struct pci_dev *host_bridge)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x9600, quirk_amd_780_apc_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x9601, quirk_amd_780_apc_msi);
 
-/* Go through the list of Hypertransport capabilities and
- * return 1 if a HT MSI capability is found and enabled */
+/*
+ * Go through the list of HyperTransport capabilities and return 1 if a HT
+ * MSI capability is found and enabled.
+ */
 static int msi_ht_cap_enabled(struct pci_dev *dev)
 {
 	int pos, ttl = PCI_FIND_CAP_TTL;
@@ -2451,7 +2454,7 @@ static int msi_ht_cap_enabled(struct pci_dev *dev)
 	return 0;
 }
 
-/* Check the hypertransport MSI mapping to know whether MSI is enabled or not */
+/* Check the HyperTransport MSI mapping to know whether MSI is enabled or not */
 static void quirk_msi_ht_cap(struct pci_dev *dev)
 {
 	if (dev->subordinate && !msi_ht_cap_enabled(dev)) {
@@ -2462,8 +2465,9 @@ static void quirk_msi_ht_cap(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT2000_PCIE,
 			quirk_msi_ht_cap);
 
-/* The nVidia CK804 chipset may have 2 HT MSI mappings.
- * MSI are supported if the MSI capability set in any of these mappings.
+/*
+ * The nVidia CK804 chipset may have 2 HT MSI mappings.  MSI is supported
+ * if the MSI capability is set in any of these mappings.
  */
 static void quirk_nvidia_ck804_msi_ht_cap(struct pci_dev *dev)
 {
@@ -2472,8 +2476,9 @@ static void quirk_nvidia_ck804_msi_ht_cap(struct pci_dev *dev)
 	if (!dev->subordinate)
 		return;
 
-	/* check HT MSI cap on this chipset and the root one.
-	 * a single one having MSI is enough to be sure that MSI are supported.
+	/*
+	 * Check HT MSI cap on this chipset and the root one.  A single one
+	 * having MSI is enough to be sure that MSI is supported.
 	 */
 	pdev = pci_get_slot(dev->bus, 0);
 	if (!pdev)
@@ -2510,13 +2515,13 @@ static void ht_enable_msi_mapping(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SERVERWORKS,
 			 PCI_DEVICE_ID_SERVERWORKS_HT1000_PXB,
 			 ht_enable_msi_mapping);
-
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8132_BRIDGE,
 			 ht_enable_msi_mapping);
 
-/* The P5N32-SLI motherboards from Asus have a problem with msi
- * for the MCP55 NIC. It is not yet determined whether the msi problem
- * also affects other devices. As for now, turn off msi for this device.
+/*
+ * The P5N32-SLI motherboards from Asus have a problem with MSI
+ * for the MCP55 NIC. It is not yet determined whether the MSI problem
+ * also affects other devices. As for now, turn off MSI for this device.
  */
 static void nvenet_msi_disable(struct pci_dev *dev)
 {
@@ -2553,16 +2558,14 @@ static void nvbridge_check_legacy_irq_routing(struct pci_dev *dev)
 	pci_read_config_dword(dev, 0x74, &cfg);
 
 	if (cfg & ((1 << 2) | (1 << 15))) {
-		printk(KERN_INFO "Rewriting irq routing register on MCP55\n");
+		printk(KERN_INFO "Rewriting IRQ routing register on MCP55\n");
 		cfg &= ~((1 << 2) | (1 << 15));
 		pci_write_config_dword(dev, 0x74, cfg);
 	}
 }
-
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
 			PCI_DEVICE_ID_NVIDIA_MCP55_BRIDGE_V0,
 			nvbridge_check_legacy_irq_routing);
-
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
 			PCI_DEVICE_ID_NVIDIA_MCP55_BRIDGE_V4,
 			nvbridge_check_legacy_irq_routing);
@@ -2572,7 +2575,7 @@ static int ht_check_msi_mapping(struct pci_dev *dev)
 	int pos, ttl = PCI_FIND_CAP_TTL;
 	int found = 0;
 
-	/* check if there is HT MSI cap or enabled on this device */
+	/* Check if there is HT MSI cap or enabled on this device */
 	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
 	while (pos && ttl--) {
 		u8 flags;
@@ -2608,7 +2611,7 @@ static int host_bridge_with_leaf(struct pci_dev *host_bridge)
 		if (!dev)
 			continue;
 
-		/* found next host bridge ?*/
+		/* found next host bridge? */
 		pos = pci_find_ht_capability(dev, HT_CAPTYPE_SLAVE);
 		if (pos != 0) {
 			pci_dev_put(dev);
@@ -2767,27 +2770,27 @@ static void nv_msi_ht_cap_quirk_all(struct pci_dev *dev)
 {
 	return __nv_msi_ht_cap_quirk(dev, 1);
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_cap_quirk_all);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_cap_quirk_all);
 
 static void nv_msi_ht_cap_quirk_leaf(struct pci_dev *dev)
 {
 	return __nv_msi_ht_cap_quirk(dev, 0);
 }
-
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, nv_msi_ht_cap_quirk_leaf);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, nv_msi_ht_cap_quirk_leaf);
 
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_cap_quirk_all);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_cap_quirk_all);
-
 static void quirk_msi_intx_disable_bug(struct pci_dev *dev)
 {
 	dev->dev_flags |= PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
 }
+
 static void quirk_msi_intx_disable_ati_bug(struct pci_dev *dev)
 {
 	struct pci_dev *p;
 
-	/* SB700 MSI issue will be fixed at HW level from revision A21,
+	/*
+	 * SB700 MSI issue will be fixed at HW level from revision A21;
 	 * we need check PCI REVISION ID of SMBus controller to get SB700
 	 * revision.
 	 */
@@ -2800,6 +2803,7 @@ static void quirk_msi_intx_disable_ati_bug(struct pci_dev *dev)
 		dev->dev_flags |= PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
 	pci_dev_put(p);
 }
+
 static void quirk_msi_intx_disable_qca_bug(struct pci_dev *dev)
 {
 	/* AR816X/AR817X/E210X MSI is fixed at HW level from revision 0x18 */
@@ -2869,55 +2873,56 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0xe091,
 			quirk_msi_intx_disable_qca_bug);
 #endif /* CONFIG_PCI_MSI */
 
-/* Allow manual resource allocation for PCI hotplug bridges
- * via pci=hpmemsize=nnM and pci=hpiosize=nnM parameters. For
- * some PCI-PCI hotplug bridges, like PLX 6254 (former HINT HB6),
- * kernel fails to allocate resources when hotplug device is
- * inserted and PCI bus is rescanned.
+/*
+ * Allow manual resource allocation for PCI hotplug bridges via
+ * pci=hpmemsize=nnM and pci=hpiosize=nnM parameters. For some PCI-PCI
+ * hotplug bridges, like PLX 6254 (former HINT HB6), kernel fails to
+ * allocate resources when hotplug device is inserted and PCI bus is
+ * rescanned.
  */
 static void quirk_hotplug_bridge(struct pci_dev *dev)
 {
 	dev->is_hotplug_bridge = 1;
 }
-
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HINT, 0x0020, quirk_hotplug_bridge);
 
 /*
- * This is a quirk for the Ricoh MMC controller found as a part of
- * some mulifunction chips.
-
+ * This is a quirk for the Ricoh MMC controller found as a part of some
+ * multifunction chips.
+ *
  * This is very similar and based on the ricoh_mmc driver written by
  * Philip Langdale. Thank you for these magic sequences.
  *
- * These chips implement the four main memory card controllers (SD, MMC, MS, xD)
- * and one or both of cardbus or firewire.
+ * These chips implement the four main memory card controllers (SD, MMC,
+ * MS, xD) and one or both of CardBus or FireWire.
  *
- * It happens that they implement SD and MMC
- * support as separate controllers (and PCI functions). The linux SDHCI
- * driver supports MMC cards but the chip detects MMC cards in hardware
- * and directs them to the MMC controller - so the SDHCI driver never sees
- * them.
+ * It happens that they implement SD and MMC support as separate
+ * controllers (and PCI functions). The Linux SDHCI driver supports MMC
+ * cards but the chip detects MMC cards in hardware and directs them to the
+ * MMC controller - so the SDHCI driver never sees them.
  *
- * To get around this, we must disable the useless MMC controller.
- * At that point, the SDHCI controller will start seeing them
- * It seems to be the case that the relevant PCI registers to deactivate the
- * MMC controller live on PCI function 0, which might be the cardbus controller
- * or the firewire controller, depending on the particular chip in question
+ * To get around this, we must disable the useless MMC controller.  At that
+ * point, the SDHCI controller will start seeing them.  It seems to be the
+ * case that the relevant PCI registers to deactivate the MMC controller
+ * live on PCI function 0, which might be the CardBus controller or the
+ * FireWire controller, depending on the particular chip in question
  *
  * This has to be done early, because as soon as we disable the MMC controller
- * other pci functions shift up one level, e.g. function #2 becomes function
- * #1, and this will confuse the pci core.
+ * other PCI functions shift up one level, e.g. function #2 becomes function
+ * #1, and this will confuse the PCI core.
  */
-
 #ifdef CONFIG_MMC_RICOH_MMC
 static void ricoh_mmc_fixup_rl5c476(struct pci_dev *dev)
 {
-	/* disable via cardbus interface */
 	u8 write_enable;
 	u8 write_target;
 	u8 disable;
 
-	/* disable must be done via function #0 */
+	/*
+	 * Disable via CardBus interface
+	 *
+	 * This must be done via function #0
+	 */
 	if (PCI_FUNC(dev->devfn))
 		return;
 
@@ -2933,7 +2938,7 @@ static void ricoh_mmc_fixup_rl5c476(struct pci_dev *dev)
 	pci_write_config_byte(dev, 0x8E, write_enable);
 	pci_write_config_byte(dev, 0x8D, write_target);
 
-	pci_notice(dev, "proprietary Ricoh MMC controller disabled (via cardbus function)\n");
+	pci_notice(dev, "proprietary Ricoh MMC controller disabled (via CardBus function)\n");
 	pci_notice(dev, "MMC cards are now supported by standard SDHCI controller\n");
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_RL5C476, ricoh_mmc_fixup_rl5c476);
@@ -2941,17 +2946,20 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_RL5C476,
 
 static void ricoh_mmc_fixup_r5c832(struct pci_dev *dev)
 {
-	/* disable via firewire interface */
 	u8 write_enable;
 	u8 disable;
 
-	/* disable must be done via function #0 */
+	/*
+	 * Disable via FireWire interface
+	 *
+	 * This must be done via function #0
+	 */
 	if (PCI_FUNC(dev->devfn))
 		return;
 	/*
 	 * RICOH 0xe822 and 0xe823 SD/MMC card readers fail to recognize
-	 * certain types of SD/MMC cards. Lowering the SD base
-	 * clock frequency from 200Mhz to 50Mhz fixes this issue.
+	 * certain types of SD/MMC cards. Lowering the SD base clock
+	 * frequency from 200Mhz to 50Mhz fixes this issue.
 	 *
 	 * 0x150 - SD2.0 mode enable for changing base clock
 	 *	   frequency to 50Mhz
@@ -2982,7 +2990,7 @@ static void ricoh_mmc_fixup_r5c832(struct pci_dev *dev)
 	pci_write_config_byte(dev, 0xCB, disable | 0x02);
 	pci_write_config_byte(dev, 0xCA, write_enable);
 
-	pci_notice(dev, "proprietary Ricoh MMC controller disabled (via firewire function)\n");
+	pci_notice(dev, "proprietary Ricoh MMC controller disabled (via FireWire function)\n");
 	pci_notice(dev, "MMC cards are now supported by standard SDHCI controller\n");
 
 }
@@ -2998,13 +3006,13 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_R5CE823,
 #define VTUNCERRMSK_REG	0x1ac
 #define VTD_MSK_SPEC_ERRORS	(1 << 31)
 /*
- * This is a quirk for masking vt-d spec defined errors to platform error
- * handling logic. With out this, platforms using Intel 7500, 5500 chipsets
+ * This is a quirk for masking VT-d spec-defined errors to platform error
+ * handling logic. Without this, platforms using Intel 7500, 5500 chipsets
  * (and the derivative chipsets like X58 etc) seem to generate NMI/SMI (based
- * on the RAS config settings of the platform) when a vt-d fault happens.
+ * on the RAS config settings of the platform) when a VT-d fault happens.
  * The resulting SMI caused the system to hang.
  *
- * VT-d spec related errors are already handled by the VT-d OS code, so no
+ * VT-d spec-related errors are already handled by the VT-d OS code, so no
  * need to report the same error through other channels.
  */
 static void vtd_mask_spec_errors(struct pci_dev *dev)
@@ -3030,7 +3038,8 @@ static void fixup_ti816x_class(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_TI, 0xb800,
 			      PCI_CLASS_NOT_DEFINED, 8, fixup_ti816x_class);
 
-/* Some PCIe devices do not work reliably with the claimed maximum
+/*
+ * Some PCIe devices do not work reliably with the claimed maximum
  * payload size supported.
  */
 static void fixup_mpss_256(struct pci_dev *dev)
@@ -3044,9 +3053,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SOLARFLARE,
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SOLARFLARE,
 			 PCI_DEVICE_ID_SOLARFLARE_SFC4000B, fixup_mpss_256);
 
-/* Intel 5000 and 5100 Memory controllers have an errata with read completion
+/*
+ * Intel 5000 and 5100 Memory controllers have an erratum with read completion
  * coalescing (which is enabled by default on some BIOSes) and MPS of 256B.
- * Since there is no way of knowing what the PCIE MPS on each fabric will be
+ * Since there is no way of knowing what the PCIe MPS on each fabric will be
  * until all of the devices are discovered and buses walked, read completion
  * coalescing must be disabled.  Unfortunately, it cannot be re-enabled because
  * it is possible to hotplug a device with MPS of 256B.
@@ -3060,9 +3070,10 @@ static void quirk_intel_mc_errata(struct pci_dev *dev)
 	    pcie_bus_config == PCIE_BUS_DEFAULT)
 		return;
 
-	/* Intel errata specifies bits to change but does not say what they are.
-	 * Keeping them magical until such time as the registers and values can
-	 * be explained.
+	/*
+	 * Intel erratum specifies bits to change but does not say what
+	 * they are.  Keeping them magical until such time as the registers
+	 * and values can be explained.
 	 */
 	err = pci_read_config_word(dev, 0x48, &rcc);
 	if (err) {
@@ -3081,7 +3092,7 @@ static void quirk_intel_mc_errata(struct pci_dev *dev)
 		return;
 	}
 
-	pr_info_once("Read completion coalescing disabled due to hardware errata relating to 256B MPS\n");
+	pr_info_once("Read completion coalescing disabled due to hardware erratum relating to 256B MPS\n");
 }
 /* Intel 5000 series memory controllers and ports 2-7 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x25c0, quirk_intel_mc_errata);
@@ -3111,11 +3122,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65f8, quirk_intel_mc_errata);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65f9, quirk_intel_mc_errata);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65fa, quirk_intel_mc_errata);
 
-
 /*
- * Ivytown NTB BAR sizes are misreported by the hardware due to an erratum.  To
- * work around this, query the size it should be configured to by the device and
- * modify the resource end to correspond to this new size.
+ * Ivytown NTB BAR sizes are misreported by the hardware due to an erratum.
+ * To work around this, query the size it should be configured to by the
+ * device and modify the resource end to correspond to this new size.
  */
 static void quirk_intel_ntb(struct pci_dev *dev)
 {
@@ -3138,16 +3148,16 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0e08, quirk_intel_ntb);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0e0d, quirk_intel_ntb);
 
 /*
- * Some BIOS implementations leave the Intel GPU interrupts enabled,
- * even though no one is handling them (f.e. i915 driver is never loaded).
- * Additionally the interrupt destination is not set up properly
+ * Some BIOS implementations leave the Intel GPU interrupts enabled, even
+ * though no one is handling them (e.g., if the i915 driver is never
+ * loaded).  Additionally the interrupt destination is not set up properly
  * and the interrupt ends up -somewhere-.
  *
- * These spurious interrupts are "sticky" and the kernel disables
- * the (shared) interrupt line after 100.000+ generated interrupts.
+ * These spurious interrupts are "sticky" and the kernel disables the
+ * (shared) interrupt line after 100,000+ generated interrupts.
  *
- * Fix it by disabling the still enabled interrupts.
- * This resolves crashes often seen on monitor unplug.
+ * Fix it by disabling the still enabled interrupts.  This resolves crashes
+ * often seen on monitor unplug.
  */
 #define I915_DEIER_REG 0x4400c
 static void disable_igfx_irq(struct pci_dev *dev)
@@ -3235,38 +3245,22 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, 0x8169,
  * Intel i40e (XL710/X710) 10/20/40GbE NICs all have broken INTx masking,
  * DisINTx can be set but the interrupt status bit is non-functional.
  */
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1572,
-			quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1574,
-			quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1580,
-			quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1581,
-			quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1583,
-			quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1584,
-			quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1585,
-			quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1586,
-			quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1587,
-			quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1588,
-			quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1589,
-			quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x158a,
-			quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x158b,
-			quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d0,
-			quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d1,
-			quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d2,
-			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1572, quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1574, quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1580, quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1581, quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1583, quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1584, quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1585, quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1586, quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1587, quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1588, quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1589, quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x158a, quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x158b, quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d0, quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d1, quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d2, quirk_broken_intx_masking);
 
 static u16 mellanox_broken_intx_devs[] = {
 	PCI_DEVICE_ID_MELLANOX_HERMON_SDR,
@@ -3311,7 +3305,8 @@ static void mellanox_check_broken_intx_masking(struct pci_dev *pdev)
 		}
 	}
 
-	/* Getting here means Connect-IB cards and up. Connect-IB has no INTx
+	/*
+	 * Getting here means Connect-IB cards and up. Connect-IB has no INTx
 	 * support so shouldn't be checked further
 	 */
 	if (pdev->device == PCI_DEVICE_ID_MELLANOX_CONNECTIB)
@@ -3431,8 +3426,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PORT_RIDGE,
  * shutdown before suspend. Otherwise the native host interface (NHI) will not
  * be present after resume if a device was plugged in before suspend.
  *
- * The thunderbolt controller consists of a pcie switch with downstream
- * bridges leading to the NHI and to the tunnel pci bridges.
+ * The Thunderbolt controller consists of a PCIe switch with downstream
+ * bridges leading to the NHI and to the tunnel PCI bridges.
  *
  * This quirk cuts power to the whole chip. Therefore we have to apply it
  * during suspend_noirq of the upstream bridge.
@@ -3450,17 +3445,19 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
 	bridge = ACPI_HANDLE(&dev->dev);
 	if (!bridge)
 		return;
+
 	/*
 	 * SXIO and SXLV are present only on machines requiring this quirk.
-	 * TB bridges in external devices might have the same device id as those
-	 * on the host, but they will not have the associated ACPI methods. This
-	 * implicitly checks that we are at the right bridge.
+	 * Thunderbolt bridges in external devices might have the same
+	 * device ID as those on the host, but they will not have the
+	 * associated ACPI methods. This implicitly checks that we are at
+	 * the right bridge.
 	 */
 	if (ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXIO", &SXIO))
 	    || ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXFP", &SXFP))
 	    || ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXLV", &SXLV)))
 		return;
-	pci_info(dev, "quirk: cutting power to thunderbolt controller...\n");
+	pci_info(dev, "quirk: cutting power to Thunderbolt controller...\n");
 
 	/* magic sequence */
 	acpi_execute_simple_method(SXIO, NULL, 1);
@@ -3475,9 +3472,9 @@ DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
 			       quirk_apple_poweroff_thunderbolt);
 
 /*
- * Apple: Wait for the thunderbolt controller to reestablish pci tunnels.
+ * Apple: Wait for the Thunderbolt controller to reestablish PCI tunnels
  *
- * During suspend the thunderbolt controller is reset and all pci
+ * During suspend the Thunderbolt controller is reset and all PCI
  * tunnels are lost. The NHI driver will try to reestablish all tunnels
  * during resume. We have to manually wait for the NHI since there is
  * no parent child relationship between the NHI and the tunneled
@@ -3492,9 +3489,10 @@ static void quirk_apple_wait_for_thunderbolt(struct pci_dev *dev)
 		return;
 	if (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)
 		return;
+
 	/*
-	 * Find the NHI and confirm that we are a bridge on the tb host
-	 * controller and not on a tb endpoint.
+	 * Find the NHI and confirm that we are a bridge on the Thunderbolt
+	 * host controller and not on a Thunderbolt endpoint.
 	 */
 	sibling = pci_get_slot(dev->bus, 0x0);
 	if (sibling == dev)
@@ -3511,7 +3509,7 @@ static void quirk_apple_wait_for_thunderbolt(struct pci_dev *dev)
 			nhi->device != PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI)
 		    || nhi->class != PCI_CLASS_SYSTEM_OTHER << 8)
 		goto out;
-	pci_info(dev, "quirk: waiting for thunderbolt to reestablish PCI tunnels...\n");
+	pci_info(dev, "quirk: waiting for Thunderbolt to reestablish PCI tunnels...\n");
 	device_pm_wait_for_dev(&dev->dev, &nhi->dev);
 out:
 	pci_dev_put(nhi);
@@ -3600,9 +3598,7 @@ static int reset_ivb_igd(struct pci_dev *dev, int probe)
 	return 0;
 }
 
-/*
- * Device-specific reset method for Chelsio T4-based adapters.
- */
+/* Device-specific reset method for Chelsio T4-based adapters */
 static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
 {
 	u16 old_command;
@@ -3885,7 +3881,7 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6869, PCI_CLASS_NOT_DEFINED, 8,
 /*
  * Some devices have problems with Transaction Layer Packets with the Relaxed
  * Ordering Attribute set.  Such devices should mark themselves and other
- * Device Drivers should check before sending TLPs with RO set.
+ * device drivers should check before sending TLPs with RO set.
  */
 static void quirk_relaxedordering_disable(struct pci_dev *dev)
 {
@@ -3895,7 +3891,7 @@ static void quirk_relaxedordering_disable(struct pci_dev *dev)
 
 /*
  * Intel Xeon processors based on Broadwell/Haswell microarchitecture Root
- * Complex has a Flow Control Credit issue which can cause performance
+ * Complex have a Flow Control Credit issue which can cause performance
  * problems with Upstream Transaction Layer Packets with Relaxed Ordering set.
  */
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, 0x6f01, PCI_CLASS_NOT_DEFINED, 8,
@@ -3956,7 +3952,7 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, 0x2f0e, PCI_CLASS_NOT_DEFINED
 			      quirk_relaxedordering_disable);
 
 /*
- * The AMD ARM A1100 (AKA "SEATTLE") SoC has a bug in its PCIe Root Complex
+ * The AMD ARM A1100 (aka "SEATTLE") SoC has a bug in its PCIe Root Complex
  * where Upstream Transaction Layer Packets with the Relaxed Ordering
  * Attribute clear are allowed to bypass earlier TLPs with Relaxed Ordering
  * set.  This is a violation of the PCIe 3.0 Transaction Ordering Rules
@@ -4020,7 +4016,7 @@ static void quirk_chelsio_T5_disable_root_port_attributes(struct pci_dev *pdev)
 	 * This mask/compare operation selects for Physical Function 4 on a
 	 * T5.  We only need to fix up the Root Port once for any of the
 	 * PFs.  PF[0..3] have PCI Device IDs of 0x50xx, but PF4 is uniquely
-	 * 0x54xx so we use that one,
+	 * 0x54xx so we use that one.
 	 */
 	if ((pdev->device & 0xff00) == 0x5400)
 		quirk_disable_root_port_attributes(pdev);
@@ -4111,7 +4107,7 @@ static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
 static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
 {
 	/*
-	 * X-Gene root matching this quirk do not allow peer-to-peer
+	 * X-Gene Root Ports matching this quirk do not allow peer-to-peer
 	 * transactions with others, allowing masking out these bits as if they
 	 * were unimplemented in the ACS capability.
 	 */
@@ -4434,7 +4430,7 @@ static int pci_quirk_enable_intel_lpc_acs(struct pci_dev *dev)
 	/*
 	 * Read the RCBA register from the LPC (D31:F0).  PCH root ports
 	 * are D28:F* and therefore get probed before LPC, thus we can't
-	 * use pci_get_slot/pci_read_config_dword here.
+	 * use pci_get_slot()/pci_read_config_dword() here.
 	 */
 	pci_bus_read_config_dword(dev->bus, PCI_DEVFN(31, 0),
 				  INTEL_LPC_RCBA_REG, &rcba);
@@ -4567,7 +4563,7 @@ int pci_dev_specific_enable_acs(struct pci_dev *dev)
 }
 
 /*
- * The PCI capabilities list for Intel DH895xCC VFs (device id 0x0443) with
+ * The PCI capabilities list for Intel DH895xCC VFs (device ID 0x0443) with
  * QuickAssist Technology (QAT) is prematurely terminated in hardware.  The
  * Next Capability pointer in the MSI Capability Structure should point to
  * the PCIe Capability Structure but is incorrectly hardwired as 0 terminating
@@ -4628,9 +4624,7 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 		if (pci_find_saved_cap(pdev, PCI_CAP_ID_EXP))
 			return;
 
-		/*
-		 * Save PCIE cap
-		 */
+		/* Save PCIe cap */
 		state = kzalloc(sizeof(*state) + size, GFP_KERNEL);
 		if (!state)
 			return;
@@ -4651,7 +4645,7 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
 
-/* FLR may cause some 82579 devices to hang. */
+/* FLR may cause some 82579 devices to hang */
 static void quirk_intel_no_flr(struct pci_dev *dev)
 {
 	dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;
