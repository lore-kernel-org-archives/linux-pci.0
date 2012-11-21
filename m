Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:46307 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756377Ab2KUUfD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Nov 2012 15:35:03 -0500
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 9/9] PCI: Remove __dev* markings
Date: Wed, 21 Nov 2012 15:35:00 -0500
Message-Id: <1353530100-728-10-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
References: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CONFIG_HOTPLUG is going away as an option so __devexit_p, __devint,
__devinitdata, __devinitconst, and _devexit are no longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/cpcihp_zt5550.c |   4 +-
 drivers/pci/ioapic.c                |   6 +-
 drivers/pci/pci.c                   |   4 +-
 drivers/pci/pcie/aer/aerdrv.c       |   4 +-
 drivers/pci/pcie/portdrv_pci.c      |   2 +-
 drivers/pci/probe.c                 |  18 ++---
 drivers/pci/quirks.c                | 134 ++++++++++++++++++------------------
 drivers/pci/xen-pcifront.c          |  10 +--
 include/linux/pci.h                 |   6 +-
 9 files changed, 94 insertions(+), 94 deletions(-)

diff --git a/drivers/pci/hotplug/cpcihp_zt5550.c b/drivers/pci/hotplug/cpcihp_zt5550.c
index 6bf8d2a..449b4bb 100644
--- a/drivers/pci/hotplug/cpcihp_zt5550.c
+++ b/drivers/pci/hotplug/cpcihp_zt5550.c
@@ -271,7 +271,7 @@ init_hc_error:
 
 }
 
-static void __devexit zt5550_hc_remove_one(struct pci_dev *pdev)
+static void zt5550_hc_remove_one(struct pci_dev *pdev)
 {
 	cpci_hp_stop();
 	cpci_hp_unregister_bus(bus0);
@@ -290,7 +290,7 @@ static struct pci_driver zt5550_hc_driver = {
 	.name		= "zt5550_hc",
 	.id_table	= zt5550_hc_pci_tbl,
 	.probe		= zt5550_hc_init_one,
-	.remove		= __devexit_p(zt5550_hc_remove_one),
+	.remove		= zt5550_hc_remove_one,
 };
 
 static int __init zt5550_init(void)
diff --git a/drivers/pci/ioapic.c b/drivers/pci/ioapic.c
index 22436f7..3c6bbdd 100644
--- a/drivers/pci/ioapic.c
+++ b/drivers/pci/ioapic.c
@@ -27,7 +27,7 @@ struct ioapic {
 	u32		gsi_base;
 };
 
-static int __devinit ioapic_probe(struct pci_dev *dev, const struct pci_device_id *ent)
+static int ioapic_probe(struct pci_dev *dev, const struct pci_device_id *ent)
 {
 	acpi_handle handle;
 	acpi_status status;
@@ -88,7 +88,7 @@ exit_free:
 	return -ENODEV;
 }
 
-static void __devexit ioapic_remove(struct pci_dev *dev)
+static void ioapic_remove(struct pci_dev *dev)
 {
 	struct ioapic *ioapic = pci_get_drvdata(dev);
 
@@ -110,7 +110,7 @@ static struct pci_driver ioapic_driver = {
 	.name		= "ioapic",
 	.id_table	= ioapic_devices,
 	.probe		= ioapic_probe,
-	.remove		= __devexit_p(ioapic_remove),
+	.remove		= ioapic_remove,
 };
 
 static int __init ioapic_init(void)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 05a510d..68f0f40 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -86,7 +86,7 @@ enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_TUNE_OFF;
  * the dfl or actual value as it sees fit.  Don't forget this is
  * measured in 32-bit words, not bytes.
  */
-u8 pci_dfl_cache_line_size __devinitdata = L1_CACHE_BYTES >> 2;
+u8 pci_dfl_cache_line_size = L1_CACHE_BYTES >> 2;
 u8 pci_cache_line_size;
 
 /*
@@ -3835,7 +3835,7 @@ static int __init pci_resource_alignment_sysfs_init(void)
 
 late_initcall(pci_resource_alignment_sysfs_init);
 
-static void __devinit pci_no_domains(void)
+static void pci_no_domains(void)
 {
 #ifdef CONFIG_PCI_DOMAINS
 	pci_domains_supported = 0;
diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 030cf12..76ef634 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -41,7 +41,7 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
-static int __devinit aer_probe(struct pcie_device *dev);
+static int aer_probe(struct pcie_device *dev);
 static void aer_remove(struct pcie_device *dev);
 static pci_ers_result_t aer_error_detected(struct pci_dev *dev,
 	enum pci_channel_state error);
@@ -300,7 +300,7 @@ static void aer_remove(struct pcie_device *dev)
  *
  * Invoked when PCI Express bus loads AER service driver.
  */
-static int __devinit aer_probe(struct pcie_device *dev)
+static int aer_probe(struct pcie_device *dev)
 {
 	int status;
 	struct aer_rpc *rpc;
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 0761d90..d4824cb 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -182,7 +182,7 @@ static const struct pci_device_id port_runtime_pm_black_list[] = {
  * this port device.
  *
  */
-static int __devinit pcie_portdrv_probe(struct pci_dev *dev,
+static int pcie_portdrv_probe(struct pci_dev *dev,
 					const struct pci_device_id *id)
 {
 	int status;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3d17641..edc3d12 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -305,7 +305,7 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 	}
 }
 
-static void __devinit pci_read_bridge_io(struct pci_bus *child)
+static void pci_read_bridge_io(struct pci_bus *child)
 {
 	struct pci_dev *dev = child->self;
 	u8 io_base_lo, io_limit_lo;
@@ -345,7 +345,7 @@ static void __devinit pci_read_bridge_io(struct pci_bus *child)
 	}
 }
 
-static void __devinit pci_read_bridge_mmio(struct pci_bus *child)
+static void pci_read_bridge_mmio(struct pci_bus *child)
 {
 	struct pci_dev *dev = child->self;
 	u16 mem_base_lo, mem_limit_lo;
@@ -367,7 +367,7 @@ static void __devinit pci_read_bridge_mmio(struct pci_bus *child)
 	}
 }
 
-static void __devinit pci_read_bridge_mmio_pref(struct pci_bus *child)
+static void pci_read_bridge_mmio_pref(struct pci_bus *child)
 {
 	struct pci_dev *dev = child->self;
 	u16 mem_base_lo, mem_limit_lo;
@@ -417,7 +417,7 @@ static void __devinit pci_read_bridge_mmio_pref(struct pci_bus *child)
 	}
 }
 
-void __devinit pci_read_bridge_bases(struct pci_bus *child)
+void pci_read_bridge_bases(struct pci_bus *child)
 {
 	struct pci_dev *dev = child->self;
 	struct resource *res;
@@ -705,7 +705,7 @@ static void pci_fixup_parent_subordinate_busnr(struct pci_bus *child, int max)
  * them, we proceed to assigning numbers to the remaining buses in
  * order to avoid overlaps between old and new bus numbers.
  */
-int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
+int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 {
 	struct pci_bus *child;
 	int is_cardbus = (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS);
@@ -1587,7 +1587,7 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
 }
 EXPORT_SYMBOL_GPL(pcie_bus_configure_settings);
 
-unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus)
+unsigned int pci_scan_child_bus(struct pci_bus *bus)
 {
 	unsigned int devfn, pass, max = bus->busn_res.start;
 	struct pci_dev *dev;
@@ -1791,7 +1791,7 @@ void pci_bus_release_busn_res(struct pci_bus *b)
 			res, ret ? "can not be" : "is");
 }
 
-struct pci_bus * __devinit pci_scan_root_bus(struct device *parent, int bus,
+struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 		struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
 	struct pci_host_bridge_window *window;
@@ -1827,7 +1827,7 @@ struct pci_bus * __devinit pci_scan_root_bus(struct device *parent, int bus,
 EXPORT_SYMBOL(pci_scan_root_bus);
 
 /* Deprecated; use pci_scan_root_bus() instead */
-struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent,
+struct pci_bus *pci_scan_bus_parented(struct device *parent,
 		int bus, struct pci_ops *ops, void *sysdata)
 {
 	LIST_HEAD(resources);
@@ -1845,7 +1845,7 @@ struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent,
 }
 EXPORT_SYMBOL(pci_scan_bus_parented);
 
-struct pci_bus * __devinit pci_scan_bus(int bus, struct pci_ops *ops,
+struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
 					void *sysdata)
 {
 	LIST_HEAD(resources);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0c59f7a..8f7a634 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -37,7 +37,7 @@
  * key system devices. For devices that need to have mmio decoding always-on,
  * we need to set the dev->mmio_always_on bit.
  */
-static void __devinit quirk_mmio_always_on(struct pci_dev *dev)
+static void quirk_mmio_always_on(struct pci_dev *dev)
 {
 	dev->mmio_always_on = 1;
 }
@@ -48,7 +48,7 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_ANY_ID, PCI_ANY_ID,
  * Mark this device with a broken_parity_status, to allow
  * PCI scanning code to "skip" this now blacklisted device.
  */
-static void __devinit quirk_mellanox_tavor(struct pci_dev *dev)
+static void quirk_mellanox_tavor(struct pci_dev *dev)
 {
 	dev->broken_parity_status = 1;	/* This device gives false positives */
 }
@@ -83,7 +83,7 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_p
     This appears to be BIOS not version dependent. So presumably there is a 
     chipset level fix */
     
-static void __devinit quirk_isa_dma_hangs(struct pci_dev *dev)
+static void quirk_isa_dma_hangs(struct pci_dev *dev)
 {
 	if (!isa_dma_bridge_buggy) {
 		isa_dma_bridge_buggy=1;
@@ -106,7 +106,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_3,	quirk_isa_d
  * Intel NM10 "TigerPoint" LPC PM1a_STS.BM_STS must be clear
  * for some HT machines to use C4 w/o hanging.
  */
-static void __devinit quirk_tigerpoint_bm_sts(struct pci_dev *dev)
+static void quirk_tigerpoint_bm_sts(struct pci_dev *dev)
 {
 	u32 pmbase;
 	u16 pm1a;
@@ -125,7 +125,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGP_LPC, quirk
 /*
  *	Chipsets where PCI->PCI transfers vanish or hang
  */
-static void __devinit quirk_nopcipci(struct pci_dev *dev)
+static void quirk_nopcipci(struct pci_dev *dev)
 {
 	if ((pci_pci_problems & PCIPCI_FAIL)==0) {
 		dev_info(&dev->dev, "Disabling direct PCI/PCI transfers\n");
@@ -135,7 +135,7 @@ static void __devinit quirk_nopcipci(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		quirk_nopcipci);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_496,		quirk_nopcipci);
 
-static void __devinit quirk_nopciamd(struct pci_dev *dev)
+static void quirk_nopciamd(struct pci_dev *dev)
 {
 	u8 rev;
 	pci_read_config_byte(dev, 0x08, &rev);
@@ -150,7 +150,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8151_0,	quirk_nopci
 /*
  *	Triton requires workarounds to be used by the drivers
  */
-static void __devinit quirk_triton(struct pci_dev *dev)
+static void quirk_triton(struct pci_dev *dev)
 {
 	if ((pci_pci_problems&PCIPCI_TRITON)==0) {
 		dev_info(&dev->dev, "Limiting direct PCI/PCI transfers\n");
@@ -229,7 +229,7 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,		quirk_viala
 /*
  *	VIA Apollo VP3 needs ETBF on BT848/878
  */
-static void __devinit quirk_viaetbf(struct pci_dev *dev)
+static void quirk_viaetbf(struct pci_dev *dev)
 {
 	if ((pci_pci_problems&PCIPCI_VIAETBF)==0) {
 		dev_info(&dev->dev, "Limiting direct PCI/PCI transfers\n");
@@ -238,7 +238,7 @@ static void __devinit quirk_viaetbf(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_viaetbf);
 
-static void __devinit quirk_vsfx(struct pci_dev *dev)
+static void quirk_vsfx(struct pci_dev *dev)
 {
 	if ((pci_pci_problems&PCIPCI_VSFX)==0) {
 		dev_info(&dev->dev, "Limiting direct PCI/PCI transfers\n");
@@ -253,7 +253,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C576,	quirk_vsfx)
  *	workaround applied too
  *	[Info kindly provided by ALi]
  */	
-static void __devinit quirk_alimagik(struct pci_dev *dev)
+static void quirk_alimagik(struct pci_dev *dev)
 {
 	if ((pci_pci_problems&PCIPCI_ALIMAGIK)==0) {
 		dev_info(&dev->dev, "Limiting direct PCI/PCI transfers\n");
@@ -267,7 +267,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 	PCI_DEVICE_ID_AL_M1651, 	quirk_alimag
  *	Natoma has some interesting boundary conditions with Zoran stuff
  *	at least
  */
-static void __devinit quirk_natoma(struct pci_dev *dev)
+static void quirk_natoma(struct pci_dev *dev)
 {
 	if ((pci_pci_problems&PCIPCI_NATOMA)==0) {
 		dev_info(&dev->dev, "Limiting direct PCI/PCI transfers\n");
@@ -285,7 +285,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443BX_2, 	qu
  *  This chip can cause PCI parity errors if config register 0xA0 is read
  *  while DMAs are occurring.
  */
-static void __devinit quirk_citrine(struct pci_dev *dev)
+static void quirk_citrine(struct pci_dev *dev)
 {
 	dev->cfg_size = 0xA0;
 }
@@ -295,7 +295,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CITRINE,	quirk_cit
  *  S3 868 and 968 chips report region size equal to 32M, but they decode 64M.
  *  If it's needed, re-allocate the region.
  */
-static void __devinit quirk_s3_64M(struct pci_dev *dev)
+static void quirk_s3_64M(struct pci_dev *dev)
 {
 	struct resource *r = &dev->resource[0];
 
@@ -313,7 +313,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_968,		quirk_s3_64M);
  * BAR0 should be 8 bytes; instead, it may be set to something like 8k
  * (which conflicts w/ BAR1's memory range).
  */
-static void __devinit quirk_cs5536_vsa(struct pci_dev *dev)
+static void quirk_cs5536_vsa(struct pci_dev *dev)
 {
 	if (pci_resource_len(dev, 0) != 8) {
 		struct resource *res = &dev->resource[0];
@@ -324,7 +324,7 @@ static void __devinit quirk_cs5536_vsa(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA, quirk_cs5536_vsa);
 
-static void __devinit quirk_io_region(struct pci_dev *dev, unsigned region,
+static void quirk_io_region(struct pci_dev *dev, unsigned region,
 	unsigned size, int nr, const char *name)
 {
 	region &= ~(size-1);
@@ -352,7 +352,7 @@ static void __devinit quirk_io_region(struct pci_dev *dev, unsigned region,
  *	ATI Northbridge setups MCE the processor if you even
  *	read somewhere between 0x3b0->0x3bb or read 0x3d3
  */
-static void __devinit quirk_ati_exploding_mce(struct pci_dev *dev)
+static void quirk_ati_exploding_mce(struct pci_dev *dev)
 {
 	dev_info(&dev->dev, "ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb\n");
 	/* Mae rhaid i ni beidio ag edrych ar y lleoliadiau I/O hyn */
@@ -372,7 +372,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_
  *	0xE0 (64 bytes of ACPI registers)
  *	0xE2 (32 bytes of SMB registers)
  */
-static void __devinit quirk_ali7101_acpi(struct pci_dev *dev)
+static void quirk_ali7101_acpi(struct pci_dev *dev)
 {
 	u16 region;
 
@@ -440,7 +440,7 @@ static void piix4_mem_quirk(struct pci_dev *dev, const char *name, unsigned int
  *	0x90 (16 bytes of SMB registers)
  * and a few strange programmable PIIX4 device resources.
  */
-static void __devinit quirk_piix4_acpi(struct pci_dev *dev)
+static void quirk_piix4_acpi(struct pci_dev *dev)
 {
 	u32 region, res_a;
 
@@ -489,7 +489,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82443MX_3,	qui
  *	0x40 (128 bytes of ACPI, GPIO & TCO registers)
  *	0x58 (64 bytes of GPIO I/O space)
  */
-static void __devinit quirk_ich4_lpc_acpi(struct pci_dev *dev)
+static void quirk_ich4_lpc_acpi(struct pci_dev *dev)
 {
 	u32 region;
 	u8 enable;
@@ -531,7 +531,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801DB_12,
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801EB_0,		quirk_ich4_lpc_acpi);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_ESB_1,		quirk_ich4_lpc_acpi);
 
-static void __devinit ich6_lpc_acpi_gpio(struct pci_dev *dev)
+static void ich6_lpc_acpi_gpio(struct pci_dev *dev)
 {
 	u32 region;
 	u8 enable;
@@ -555,7 +555,7 @@ static void __devinit ich6_lpc_acpi_gpio(struct pci_dev *dev)
 	}
 }
 
-static void __devinit ich6_lpc_generic_decode(struct pci_dev *dev, unsigned reg, const char *name, int dynsize)
+static void ich6_lpc_generic_decode(struct pci_dev *dev, unsigned reg, const char *name, int dynsize)
 {
 	u32 val;
 	u32 size, base;
@@ -583,7 +583,7 @@ static void __devinit ich6_lpc_generic_decode(struct pci_dev *dev, unsigned reg,
 	dev_info(&dev->dev, "%s PIO at %04x-%04x\n", name, base, base+size-1);
 }
 
-static void __devinit quirk_ich6_lpc(struct pci_dev *dev)
+static void quirk_ich6_lpc(struct pci_dev *dev)
 {
 	/* Shared ACPI/GPIO decode with all ICH6+ */
 	ich6_lpc_acpi_gpio(dev);
@@ -595,7 +595,7 @@ static void __devinit quirk_ich6_lpc(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_0, quirk_ich6_lpc);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1, quirk_ich6_lpc);
 
-static void __devinit ich7_lpc_generic_decode(struct pci_dev *dev, unsigned reg, const char *name)
+static void ich7_lpc_generic_decode(struct pci_dev *dev, unsigned reg, const char *name)
 {
 	u32 val;
 	u32 mask, base;
@@ -619,7 +619,7 @@ static void __devinit ich7_lpc_generic_decode(struct pci_dev *dev, unsigned reg,
 }
 
 /* ICH7-10 has the same common LPC generic IO decode registers */
-static void __devinit quirk_ich7_lpc(struct pci_dev *dev)
+static void quirk_ich7_lpc(struct pci_dev *dev)
 {
 	/* We share the common ACPI/GPIO decode with ICH6 */
 	ich6_lpc_acpi_gpio(dev);
@@ -648,7 +648,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_ICH10_1, qui
  * VIA ACPI: One IO region pointed to by longword at
  *	0x48 or 0x20 (256 bytes of ACPI registers)
  */
-static void __devinit quirk_vt82c586_acpi(struct pci_dev *dev)
+static void quirk_vt82c586_acpi(struct pci_dev *dev)
 {
 	u32 region;
 
@@ -666,7 +666,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_vt
  *	0x70 (128 bytes of hardware monitoring register)
  *	0x90 (16 bytes of SMB registers)
  */
-static void __devinit quirk_vt82c686_acpi(struct pci_dev *dev)
+static void quirk_vt82c686_acpi(struct pci_dev *dev)
 {
 	u16 hm;
 	u32 smb;
@@ -688,7 +688,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_vt
  *	0x88 (128 bytes of power management registers)
  *	0xd0 (16 bytes of SMB registers)
  */
-static void __devinit quirk_vt8235_acpi(struct pci_dev *dev)
+static void quirk_vt8235_acpi(struct pci_dev *dev)
 {
 	u16 pm, smb;
 
@@ -706,7 +706,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8235,	quirk_vt8235
  * TI XIO2000a PCIe-PCI Bridge erroneously reports it supports fast back-to-back:
  *	Disable fast back-to-back on the secondary bus segment
  */
-static void __devinit quirk_xio2000a(struct pci_dev *dev)
+static void quirk_xio2000a(struct pci_dev *dev)
 {
 	struct pci_dev *pdev;
 	u16 command;
@@ -780,7 +780,7 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237,		quirk
  * noapic specified. For the moment we assume it's the erratum. We may be wrong
  * of course. However the advice is demonstrably good even if so..
  */
-static void __devinit quirk_amd_ioapic(struct pci_dev *dev)
+static void quirk_amd_ioapic(struct pci_dev *dev)
 {
 	if (dev->revision >= 0x02) {
 		dev_warn(&dev->dev, "I/O APIC: AMD Erratum #22 may be present. In the event of instability try\n");
@@ -789,7 +789,7 @@ static void __devinit quirk_amd_ioapic(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7410,	quirk_amd_ioapic);
 
-static void __devinit quirk_ioapic_rmw(struct pci_dev *dev)
+static void quirk_ioapic_rmw(struct pci_dev *dev)
 {
 	if (dev->devfn == 0 && dev->bus->number == 0)
 		sis_apic_bug = 1;
@@ -801,7 +801,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_ANY_ID,			quirk_ioapic_rmw);
  * Some settings of MMRBC can lead to data corruption so block changes.
  * See AMD 8131 HyperTransport PCI-X Tunnel Revision Guide
  */
-static void __devinit quirk_amd_8131_mmrbc(struct pci_dev *dev)
+static void quirk_amd_8131_mmrbc(struct pci_dev *dev)
 {
 	if (dev->subordinate && dev->revision <= 0x12) {
 		dev_info(&dev->dev, "AMD8131 rev %x detected; "
@@ -819,7 +819,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_
  * value of the ACPI SCI interrupt is only done for convenience.
  *	-jgarzik
  */
-static void __devinit quirk_via_acpi(struct pci_dev *d)
+static void quirk_via_acpi(struct pci_dev *d)
 {
 	/*
 	 * VIA ACPI device: SCI IRQ line in PCI config byte 0x42
@@ -926,7 +926,7 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_vlink);
  * We need to switch it off to be able to recognize the real
  * type of the chip.
  */
-static void __devinit quirk_vt82c598_id(struct pci_dev *dev)
+static void quirk_vt82c598_id(struct pci_dev *dev)
 {
 	pci_write_config_byte(dev, 0xfc, 0);
 	pci_read_config_word(dev, PCI_DEVICE_ID, &dev->device);
@@ -978,7 +978,7 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_FE_GATE_700C
  *	assigned to it. We force a larger allocation to ensure that
  *	nothing gets put too close to it.
  */
-static void __devinit quirk_dunord ( struct pci_dev * dev )
+static void quirk_dunord(struct pci_dev *dev)
 {
 	struct resource *r = &dev->resource [1];
 	r->start = 0;
@@ -992,7 +992,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_DUNORD,	PCI_DEVICE_ID_DUNORD_I3000,	quirk
  * in the ProgIf. Unfortunately, the ProgIf value is wrong - 0x80
  * instead of 0x01.
  */
-static void __devinit quirk_transparent_bridge(struct pci_dev *dev)
+static void quirk_transparent_bridge(struct pci_dev *dev)
 {
 	dev->transparent = 1;
 }
@@ -1066,7 +1066,7 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA
 /*
  *	Serverworks CSB5 IDE does not fully support native mode
  */
-static void __devinit quirk_svwks_csb5ide(struct pci_dev *pdev)
+static void quirk_svwks_csb5ide(struct pci_dev *pdev)
 {
 	u8 prog;
 	pci_read_config_byte(pdev, PCI_CLASS_PROG, &prog);
@@ -1082,7 +1082,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB
 /*
  *	Intel 82801CAM ICH3-M datasheet says IDE modes must be the same
  */
-static void __devinit quirk_ide_samemode(struct pci_dev *pdev)
+static void quirk_ide_samemode(struct pci_dev *pdev)
 {
 	u8 prog;
 
@@ -1101,7 +1101,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, qui
  * Some ATA devices break if put into D3
  */
 
-static void __devinit quirk_no_ata_d3(struct pci_dev *pdev)
+static void quirk_no_ata_d3(struct pci_dev *pdev)
 {
 	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
 }
@@ -1121,7 +1121,7 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
 /* This was originally an Alpha specific thing, but it really fits here.
  * The i82375 PCI/EISA bridge appears as non-classified. Fix that.
  */
-static void __devinit quirk_eisa_bridge(struct pci_dev *dev)
+static void quirk_eisa_bridge(struct pci_dev *dev)
 {
 	dev->class = PCI_CLASS_BRIDGE_EISA << 8;
 }
@@ -1155,7 +1155,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82375,	quirk_e
  */
 static int asus_hides_smbus;
 
-static void __devinit asus_hides_smbus_hostbridge(struct pci_dev *dev)
+static void asus_hides_smbus_hostbridge(struct pci_dev *dev)
 {
 	if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_ASUSTEK)) {
 		if (dev->device == PCI_DEVICE_ID_INTEL_82845_HB)
@@ -1538,7 +1538,7 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB3
 #endif
 
 #ifdef CONFIG_X86_IO_APIC
-static void __devinit quirk_alder_ioapic(struct pci_dev *pdev)
+static void quirk_alder_ioapic(struct pci_dev *pdev)
 {
 	int i;
 
@@ -1561,7 +1561,7 @@ static void __devinit quirk_alder_ioapic(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_EESSC,	quirk_alder_ioapic);
 #endif
 
-static void __devinit quirk_pcie_mch(struct pci_dev *pdev)
+static void quirk_pcie_mch(struct pci_dev *pdev)
 {
 	pci_msi_off(pdev);
 	pdev->no_msi = 1;
@@ -1575,7 +1575,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quir
  * It's possible for the MSI to get corrupted if shpc and acpi
  * are used together on certain PXH-based systems.
  */
-static void __devinit quirk_pcie_pxh(struct pci_dev *dev)
+static void quirk_pcie_pxh(struct pci_dev *dev)
 {
 	pci_msi_off(dev);
 	dev->no_msi = 1;
@@ -1777,7 +1777,7 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD,   PCI_DEVICE_ID_AMD_8111_SMBUS, 	qui
  * but the PIO transfers won't work if BAR0 falls at the odd 8 bytes.
  * Re-allocate the region if needed...
  */
-static void __devinit quirk_tc86c001_ide(struct pci_dev *dev)
+static void quirk_tc86c001_ide(struct pci_dev *dev)
 {
 	struct resource *r = &dev->resource[0];
 
@@ -1797,7 +1797,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA_2,
  * The BAR0 or BAR1 region may be disabled (size 0) or enabled (size 128).
  * Re-allocate the regions to a 256-byte boundary if necessary.
  */
-static void __devinit quirk_plx_pci9050(struct pci_dev *dev)
+static void quirk_plx_pci9050(struct pci_dev *dev)
 {
 	unsigned int bar;
 
@@ -1829,7 +1829,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
 DECLARE_PCI_FIXUP_HEADER(0x1402, 0x2000, quirk_plx_pci9050);
 DECLARE_PCI_FIXUP_HEADER(0x1402, 0x2600, quirk_plx_pci9050);
 
-static void __devinit quirk_netmos(struct pci_dev *dev)
+static void quirk_netmos(struct pci_dev *dev)
 {
 	unsigned int num_parallel = (dev->subsystem_device & 0xf0) >> 4;
 	unsigned int num_serial = dev->subsystem_device & 0xf;
@@ -1867,7 +1867,7 @@ static void __devinit quirk_netmos(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_NETMOS, PCI_ANY_ID,
 			 PCI_CLASS_COMMUNICATION_SERIAL, 8, quirk_netmos);
 
-static void __devinit quirk_e100_interrupt(struct pci_dev *dev)
+static void quirk_e100_interrupt(struct pci_dev *dev)
 {
 	u16 command, pmcsr;
 	u8 __iomem *csr;
@@ -1940,7 +1940,7 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
  * The 82575 and 82598 may experience data corruption issues when transitioning
  * out of L0S.  To prevent this we need to disable L0S on the pci-e link
  */
-static void __devinit quirk_disable_aspm_l0s(struct pci_dev *dev)
+static void quirk_disable_aspm_l0s(struct pci_dev *dev)
 {
 	dev_info(&dev->dev, "Disabling L0s\n");
 	pci_disable_link_state(dev, PCIE_LINK_STATE_L0S);
@@ -1960,7 +1960,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10f1, quirk_disable_aspm_l0s);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10f4, quirk_disable_aspm_l0s);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1508, quirk_disable_aspm_l0s);
 
-static void __devinit fixup_rev1_53c810(struct pci_dev* dev)
+static void fixup_rev1_53c810(struct pci_dev *dev)
 {
 	/* rev 1 ncr53c810 chips don't set the class at all which means
 	 * they don't get their resources remapped. Fix that here.
@@ -1974,7 +1974,7 @@ static void __devinit fixup_rev1_53c810(struct pci_dev* dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C810, fixup_rev1_53c810);
 
 /* Enable 1k I/O space granularity on the Intel P64H2 */
-static void __devinit quirk_p64h2_1k_io(struct pci_dev *dev)
+static void quirk_p64h2_1k_io(struct pci_dev *dev)
 {
 	u16 en1k;
 
@@ -2007,7 +2007,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA,  PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_NVIDIA,  PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
 			quirk_nvidia_ck804_pcie_aer_ext_cap);
 
-static void __devinit quirk_via_cx700_pci_parking_caching(struct pci_dev *dev)
+static void quirk_via_cx700_pci_parking_caching(struct pci_dev *dev)
 {
 	/*
 	 * Disable PCI Bus Parking and PCI Master read caching on CX700
@@ -2070,7 +2070,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, 0x324e, quirk_via_cx700_pci_parking_c
  * We believe that it is legal to read beyond the end tag and
  * therefore the solution is to limit the read/write length.
  */
-static void __devinit quirk_brcm_570x_limit_vpd(struct pci_dev *dev)
+static void quirk_brcm_570x_limit_vpd(struct pci_dev *dev)
 {
 	/*
 	 * Only disable the VPD capability for 5706, 5706S, 5708,
@@ -2130,7 +2130,7 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_BROADCOM,
  * the DRBs - this is where we expose device 6.
  * http://www.x86-secret.com/articles/tweak/pat/patsecrets-2.htm
  */
-static void __devinit quirk_unhide_mch_dev6(struct pci_dev *dev)
+static void quirk_unhide_mch_dev6(struct pci_dev *dev)
 {
 	u8 reg;
 
@@ -2154,7 +2154,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82875_HB,
  * supports link speed auto negotiation, but falsely sets
  * the link speed to 5GT/s.
  */
-static void __devinit quirk_tile_plx_gen1(struct pci_dev *dev)
+static void quirk_tile_plx_gen1(struct pci_dev *dev)
 {
 	if (tile_plx_gen1) {
 		pci_write_config_dword(dev, 0x98, 0x1);
@@ -2171,7 +2171,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PLX, 0x8624, quirk_tile_plx_gen1);
  * aware of it.  Instead of setting the flag on all busses in the
  * machine, simply disable MSI globally.
  */
-static void __devinit quirk_disable_all_msi(struct pci_dev *dev)
+static void quirk_disable_all_msi(struct pci_dev *dev)
 {
 	pci_no_msi();
 	dev_warn(&dev->dev, "MSI quirk detected; MSI disabled\n");
@@ -2185,7 +2185,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VT3364, quirk_disab
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8380_0, quirk_disable_all_msi);
 
 /* Disable MSI on chipsets that are known to not support it */
-static void __devinit quirk_disable_msi(struct pci_dev *dev)
+static void quirk_disable_msi(struct pci_dev *dev)
 {
 	if (dev->subordinate) {
 		dev_warn(&dev->dev, "MSI quirk detected; "
@@ -2203,7 +2203,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x5a3f, quirk_disable_msi);
  * we use the possible vendor/device IDs of the host bridge for the
  * declared quirk, and search for the APC bridge by slot number.
  */
-static void __devinit quirk_amd_780_apc_msi(struct pci_dev *host_bridge)
+static void quirk_amd_780_apc_msi(struct pci_dev *host_bridge)
 {
 	struct pci_dev *apc_bridge;
 
@@ -2311,7 +2311,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8132_BRIDGE,
  * for the MCP55 NIC. It is not yet determined whether the msi problem
  * also affects other devices. As for now, turn off msi for this device.
  */
-static void __devinit nvenet_msi_disable(struct pci_dev *dev)
+static void nvenet_msi_disable(struct pci_dev *dev)
 {
 	const char *board_name = dmi_get_system_info(DMI_BOARD_NAME);
 
@@ -2337,7 +2337,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
  * we have it set correctly.
  * Note this is an undocumented register.
  */
-static void __devinit nvbridge_check_legacy_irq_routing(struct pci_dev *dev)
+static void nvbridge_check_legacy_irq_routing(struct pci_dev *dev)
 {
 	u32 cfg;
 
@@ -2573,11 +2573,11 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, nv_msi_ht_cap_q
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_cap_quirk_all);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_cap_quirk_all);
 
-static void __devinit quirk_msi_intx_disable_bug(struct pci_dev *dev)
+static void quirk_msi_intx_disable_bug(struct pci_dev *dev)
 {
 	dev->dev_flags |= PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
 }
-static void __devinit quirk_msi_intx_disable_ati_bug(struct pci_dev *dev)
+static void quirk_msi_intx_disable_ati_bug(struct pci_dev *dev)
 {
 	struct pci_dev *p;
 
@@ -2651,7 +2651,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x1083,
  * kernel fails to allocate resources when hotplug device is 
  * inserted and PCI bus is rescanned.
  */
-static void __devinit quirk_hotplug_bridge(struct pci_dev *dev)
+static void quirk_hotplug_bridge(struct pci_dev *dev)
 {
 	dev->is_hotplug_bridge = 1;
 }
@@ -2791,7 +2791,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x342e, vtd_mask_spec_errors);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x3c28, vtd_mask_spec_errors);
 #endif
 
-static void __devinit fixup_ti816x_class(struct pci_dev* dev)
+static void fixup_ti816x_class(struct pci_dev *dev)
 {
 	/* TI 816x devices do not have class code set when in PCIe boot mode */
 	dev_info(&dev->dev, "Setting PCI class for 816x PCIe device\n");
@@ -2803,7 +2803,7 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_TI, 0xb800,
 /* Some PCIe devices do not work reliably with the claimed maximum
  * payload size supported.
  */
-static void __devinit fixup_mpss_256(struct pci_dev *dev)
+static void fixup_mpss_256(struct pci_dev *dev)
 {
 	dev->pcie_mpss = 1; /* 256 bytes */
 }
@@ -2821,7 +2821,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SOLARFLARE,
  * coalescing must be disabled.  Unfortunately, it cannot be re-enabled because
  * it is possible to hotplug a device with MPS of 256B.
  */
-static void __devinit quirk_intel_mc_errata(struct pci_dev *dev)
+static void quirk_intel_mc_errata(struct pci_dev *dev)
 {
 	int err;
 	u16 rcc;
@@ -2927,7 +2927,7 @@ static void fixup_debug_report(struct pci_dev *dev, ktime_t calltime,
  * This resolves crashes often seen on monitor unplug.
  */
 #define I915_DEIER_REG 0x4400c
-static void __devinit disable_igfx_irq(struct pci_dev *dev)
+static void disable_igfx_irq(struct pci_dev *dev)
 {
 	void __iomem *regs = pci_iomap(dev, 0, 0);
 	if (regs == NULL) {
@@ -2953,7 +2953,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x010a, disable_igfx_irq);
  * PCI_COMMAND_INTX_DISABLE works though they actually do not properly
  * support this feature.
  */
-static void __devinit quirk_broken_intx_masking(struct pci_dev *dev)
+static void quirk_broken_intx_masking(struct pci_dev *dev)
 {
 	dev->broken_intx_masking = 1;
 }
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 0aab85a..db542f4 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -412,7 +412,7 @@ static int pcifront_claim_resource(struct pci_dev *dev, void *data)
 	return 0;
 }
 
-static int __devinit pcifront_scan_bus(struct pcifront_device *pdev,
+static int pcifront_scan_bus(struct pcifront_device *pdev,
 				unsigned int domain, unsigned int bus,
 				struct pci_bus *b)
 {
@@ -441,7 +441,7 @@ static int __devinit pcifront_scan_bus(struct pcifront_device *pdev,
 	return 0;
 }
 
-static int __devinit pcifront_scan_root(struct pcifront_device *pdev,
+static int pcifront_scan_root(struct pcifront_device *pdev,
 				 unsigned int domain, unsigned int bus)
 {
 	struct pci_bus *b;
@@ -503,7 +503,7 @@ err_out:
 	return err;
 }
 
-static int __devinit pcifront_rescan_root(struct pcifront_device *pdev,
+static int pcifront_rescan_root(struct pcifront_device *pdev,
 				   unsigned int domain, unsigned int bus)
 {
 	int err;
@@ -834,7 +834,7 @@ out:
 	return err;
 }
 
-static int __devinit pcifront_try_connect(struct pcifront_device *pdev)
+static int pcifront_try_connect(struct pcifront_device *pdev)
 {
 	int err = -EFAULT;
 	int i, num_roots, len;
@@ -924,7 +924,7 @@ out:
 	return err;
 }
 
-static int __devinit pcifront_attach_devices(struct pcifront_device *pdev)
+static int pcifront_attach_devices(struct pcifront_device *pdev)
 {
 	int err = -EFAULT;
 	int i, num_roots, len;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9f99c59..ea9533b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -589,7 +589,7 @@ struct pci_driver {
  * in a generic manner.
  */
 #define DEFINE_PCI_DEVICE_TABLE(_table) \
-	const struct pci_device_id _table[] __devinitconst
+	const struct pci_device_id _table[]
 
 /**
  * PCI_DEVICE - macro used to describe a specific pci device
@@ -687,7 +687,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
 void pci_bus_release_busn_res(struct pci_bus *b);
-struct pci_bus * __devinit pci_scan_root_bus(struct device *parent, int bus,
+struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 					     struct pci_ops *ops, void *sysdata,
 					     struct list_head *resources);
 struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
@@ -1582,7 +1582,7 @@ extern int pci_pci_problems;
 
 extern unsigned long pci_cardbus_io_size;
 extern unsigned long pci_cardbus_mem_size;
-extern u8 __devinitdata pci_dfl_cache_line_size;
+extern u8 pci_dfl_cache_line_size;
 extern u8 pci_cache_line_size;
 
 extern unsigned long pci_hotplug_io_size;
-- 
1.8.0

