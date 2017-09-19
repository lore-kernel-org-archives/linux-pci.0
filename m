Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51374 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbdISOsW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Sep 2017 10:48:22 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steve French <smfrench@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2] MIPS: Fix PCI host bridge map_irq() hook section mismatches
Date: Tue, 19 Sep 2017 15:50:42 +0100
Message-Id: <20170919145042.5875-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 04c81c7293df ("MIPS: PCI: Replace pci_fixup_irqs() call with host
bridge IRQ mapping hooks") allowed to move the PCI irq fixup to the new
host bridge map/swizzle_irq() hooks mechanism. Those hooks can also be
called after boot completed - with all __init/__initdata/__initconst
sections freed by the kernel -  therefore functions called by them (and
the data they refer to) must not be marked as
__init/__initdata/__initconst lest compilation triggers section
mismatches warnings.

Fix all the boards files map_irq() hooks by simply removing the
respective __init/__initdata/__initconst section markers and by
adding another persistent hook IRQ map for the txx9 board files.

Fixes: 04c81c7293df ("MIPS: PCI: Replace pci_fixup_irqs() call with host
bridge IRQ mapping hooks")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Steve French <smfrench@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
v1->v2:
	- Fixed typo in static txx9 map irq hook
	- Removed __init from octeon and tx4938 map irq functions

 arch/mips/ath79/pci.c           | 12 ++++++------
 arch/mips/pci/fixup-capcella.c  |  4 ++--
 arch/mips/pci/fixup-cobalt.c    |  8 ++++----
 arch/mips/pci/fixup-emma2rh.c   |  4 ++--
 arch/mips/pci/fixup-fuloong2e.c |  2 +-
 arch/mips/pci/fixup-ip32.c      |  4 ++--
 arch/mips/pci/fixup-jmr3927.c   |  2 +-
 arch/mips/pci/fixup-lantiq.c    |  2 +-
 arch/mips/pci/fixup-lemote2f.c  |  4 ++--
 arch/mips/pci/fixup-loongson3.c |  2 +-
 arch/mips/pci/fixup-malta.c     |  4 ++--
 arch/mips/pci/fixup-mpc30x.c    |  6 +++---
 arch/mips/pci/fixup-pmcmsp.c    |  8 ++++----
 arch/mips/pci/fixup-rbtx4927.c  |  2 +-
 arch/mips/pci/fixup-rbtx4938.c  |  2 +-
 arch/mips/pci/fixup-sni.c       | 12 ++++++------
 arch/mips/pci/fixup-tb0219.c    |  2 +-
 arch/mips/pci/fixup-tb0226.c    |  2 +-
 arch/mips/pci/fixup-tb0287.c    |  2 +-
 arch/mips/pci/pci-alchemy.c     |  2 +-
 arch/mips/pci/pci-bcm47xx.c     |  2 +-
 arch/mips/pci/pci-lasat.c       |  2 +-
 arch/mips/pci/pci-mt7620.c      |  2 +-
 arch/mips/pci/pci-octeon.c      |  5 ++---
 arch/mips/pci/pci-rt2880.c      |  2 +-
 arch/mips/pci/pci-rt3883.c      |  2 +-
 arch/mips/pci/pci-tx4938.c      |  2 +-
 arch/mips/pci/pci-tx4939.c      |  4 ++--
 arch/mips/pci/pci-xlp.c         |  2 +-
 arch/mips/pci/pci-xlr.c         |  2 +-
 arch/mips/pci/pcie-octeon.c     |  3 +--
 arch/mips/txx9/generic/pci.c    |  8 ++++++--
 32 files changed, 62 insertions(+), 60 deletions(-)

diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
index 730c0b0..b816cb4 100644
--- a/arch/mips/ath79/pci.c
+++ b/arch/mips/ath79/pci.c
@@ -22,10 +22,10 @@
 #include "pci.h"
 
 static int (*ath79_pci_plat_dev_init)(struct pci_dev *dev);
-static const struct ath79_pci_irq *ath79_pci_irq_map __initdata;
-static unsigned ath79_pci_nr_irqs __initdata;
+static const struct ath79_pci_irq *ath79_pci_irq_map;
+static unsigned ath79_pci_nr_irqs;
 
-static const struct ath79_pci_irq ar71xx_pci_irq_map[] __initconst = {
+static const struct ath79_pci_irq ar71xx_pci_irq_map[] = {
 	{
 		.slot	= 17,
 		.pin	= 1,
@@ -41,7 +41,7 @@ static const struct ath79_pci_irq ar71xx_pci_irq_map[] __initconst = {
 	}
 };
 
-static const struct ath79_pci_irq ar724x_pci_irq_map[] __initconst = {
+static const struct ath79_pci_irq ar724x_pci_irq_map[] = {
 	{
 		.slot	= 0,
 		.pin	= 1,
@@ -49,7 +49,7 @@ static const struct ath79_pci_irq ar724x_pci_irq_map[] __initconst = {
 	}
 };
 
-static const struct ath79_pci_irq qca955x_pci_irq_map[] __initconst = {
+static const struct ath79_pci_irq qca955x_pci_irq_map[] = {
 	{
 		.bus	= 0,
 		.slot	= 0,
@@ -64,7 +64,7 @@ static const struct ath79_pci_irq qca955x_pci_irq_map[] __initconst = {
 	},
 };
 
-int __init pcibios_map_irq(const struct pci_dev *dev, uint8_t slot, uint8_t pin)
+int pcibios_map_irq(const struct pci_dev *dev, uint8_t slot, uint8_t pin)
 {
 	int irq = -1;
 	int i;
diff --git a/arch/mips/pci/fixup-capcella.c b/arch/mips/pci/fixup-capcella.c
index 1c02f57..b4c263f 100644
--- a/arch/mips/pci/fixup-capcella.c
+++ b/arch/mips/pci/fixup-capcella.c
@@ -32,13 +32,13 @@
 #define INTC	PC104PLUS_INTC_IRQ
 #define INTD	PC104PLUS_INTD_IRQ
 
-static char irq_tab_capcella[][5] __initdata = {
+static char irq_tab_capcella[][5] = {
  [11] = { -1, INT1, INT1, INT1, INT1 },
  [12] = { -1, INT2, INT2, INT2, INT2 },
  [14] = { -1, INTA, INTB, INTC, INTD }
 };
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return irq_tab_capcella[slot][pin];
 }
diff --git a/arch/mips/pci/fixup-cobalt.c b/arch/mips/pci/fixup-cobalt.c
index b3ab593..44be65c 100644
--- a/arch/mips/pci/fixup-cobalt.c
+++ b/arch/mips/pci/fixup-cobalt.c
@@ -147,7 +147,7 @@ static void qube_raq_via_board_id_fixup(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0,
 	 qube_raq_via_board_id_fixup);
 
-static char irq_tab_qube1[] __initdata = {
+static char irq_tab_qube1[] = {
   [COBALT_PCICONF_CPU]	   = 0,
   [COBALT_PCICONF_ETH0]	   = QUBE1_ETH0_IRQ,
   [COBALT_PCICONF_RAQSCSI] = SCSI_IRQ,
@@ -156,7 +156,7 @@ static char irq_tab_qube1[] __initdata = {
   [COBALT_PCICONF_ETH1]	   = 0
 };
 
-static char irq_tab_cobalt[] __initdata = {
+static char irq_tab_cobalt[] = {
   [COBALT_PCICONF_CPU]	   = 0,
   [COBALT_PCICONF_ETH0]	   = ETH0_IRQ,
   [COBALT_PCICONF_RAQSCSI] = SCSI_IRQ,
@@ -165,7 +165,7 @@ static char irq_tab_cobalt[] __initdata = {
   [COBALT_PCICONF_ETH1]	   = ETH1_IRQ
 };
 
-static char irq_tab_raq2[] __initdata = {
+static char irq_tab_raq2[] = {
   [COBALT_PCICONF_CPU]	   = 0,
   [COBALT_PCICONF_ETH0]	   = ETH0_IRQ,
   [COBALT_PCICONF_RAQSCSI] = RAQ2_SCSI_IRQ,
@@ -174,7 +174,7 @@ static char irq_tab_raq2[] __initdata = {
   [COBALT_PCICONF_ETH1]	   = ETH1_IRQ
 };
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	if (cobalt_board_id <= COBALT_BRD_ID_QUBE1)
 		return irq_tab_qube1[slot];
diff --git a/arch/mips/pci/fixup-emma2rh.c b/arch/mips/pci/fixup-emma2rh.c
index 19caf77..c31cb6a 100644
--- a/arch/mips/pci/fixup-emma2rh.c
+++ b/arch/mips/pci/fixup-emma2rh.c
@@ -43,7 +43,7 @@
  */
 
 #define MAX_SLOT_NUM 10
-static unsigned char irq_map[][5] __initdata = {
+static unsigned char irq_map[][5] = {
 	[3] = {0, MARKEINS_PCI_IRQ_INTB, MARKEINS_PCI_IRQ_INTC,
 	       MARKEINS_PCI_IRQ_INTD, 0,},
 	[4] = {0, MARKEINS_PCI_IRQ_INTA, 0, 0, 0,},
@@ -85,7 +85,7 @@ static void emma2rh_pci_host_fixup(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_EMMA2RH,
 			 emma2rh_pci_host_fixup);
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return irq_map[slot][pin];
 }
diff --git a/arch/mips/pci/fixup-fuloong2e.c b/arch/mips/pci/fixup-fuloong2e.c
index 50da773..b47c277 100644
--- a/arch/mips/pci/fixup-fuloong2e.c
+++ b/arch/mips/pci/fixup-fuloong2e.c
@@ -19,7 +19,7 @@
 /* South bridge slot number is set by the pci probe process */
 static u8 sb_slot = 5;
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq = 0;
 
diff --git a/arch/mips/pci/fixup-ip32.c b/arch/mips/pci/fixup-ip32.c
index 133685e..c6ec18a 100644
--- a/arch/mips/pci/fixup-ip32.c
+++ b/arch/mips/pci/fixup-ip32.c
@@ -21,7 +21,7 @@
 #define INTB   MACEPCI_SHARED0_IRQ
 #define INTC   MACEPCI_SHARED1_IRQ
 #define INTD   MACEPCI_SHARED2_IRQ
-static char irq_tab_mace[][5] __initdata = {
+static char irq_tab_mace[][5] = {
       /* Dummy	INT#A  INT#B  INT#C  INT#D */
 	{0,	    0,	   0,	  0,	 0}, /* This is placeholder row - never used */
 	{0,	SCSI0, SCSI0, SCSI0, SCSI0},
@@ -39,7 +39,7 @@ static char irq_tab_mace[][5] __initdata = {
  * irqs.  I suppose a device without a pin A will thank us for doing it
  * right if there exists such a broken piece of crap.
  */
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return irq_tab_mace[slot][pin];
 }
diff --git a/arch/mips/pci/fixup-jmr3927.c b/arch/mips/pci/fixup-jmr3927.c
index 0f10695..d3102ee 100644
--- a/arch/mips/pci/fixup-jmr3927.c
+++ b/arch/mips/pci/fixup-jmr3927.c
@@ -31,7 +31,7 @@
 #include <asm/txx9/pci.h>
 #include <asm/txx9/jmr3927.h>
 
-int __init jmr3927_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int jmr3927_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	unsigned char irq = pin;
 
diff --git a/arch/mips/pci/fixup-lantiq.c b/arch/mips/pci/fixup-lantiq.c
index 2b5427d..81530a1 100644
--- a/arch/mips/pci/fixup-lantiq.c
+++ b/arch/mips/pci/fixup-lantiq.c
@@ -23,7 +23,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	return 0;
 }
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return of_irq_parse_and_map_pci(dev, slot, pin);
 }
diff --git a/arch/mips/pci/fixup-lemote2f.c b/arch/mips/pci/fixup-lemote2f.c
index 95ab9a1..20cdfdc 100644
--- a/arch/mips/pci/fixup-lemote2f.c
+++ b/arch/mips/pci/fixup-lemote2f.c
@@ -30,7 +30,7 @@
 #define PCID		7
 
 /* all the pci device has the PCIA pin, check the datasheet. */
-static char irq_tab[][5] __initdata = {
+static char irq_tab[][5] = {
 	/*	INTA	INTB	INTC	INTD */
 	{0, 0, 0, 0, 0},	/*  11: Unused */
 	{0, 0, 0, 0, 0},	/*  12: Unused */
@@ -51,7 +51,7 @@ static char irq_tab[][5] __initdata = {
 	{0, 0, 0, 0, 0},	/*  27: Unused */
 };
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int virq;
 
diff --git a/arch/mips/pci/fixup-loongson3.c b/arch/mips/pci/fixup-loongson3.c
index 2b6d5e1..8a741c2 100644
--- a/arch/mips/pci/fixup-loongson3.c
+++ b/arch/mips/pci/fixup-loongson3.c
@@ -32,7 +32,7 @@ static void print_fixup_info(const struct pci_dev *pdev)
 			pdev->vendor, pdev->device, pdev->irq);
 }
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	print_fixup_info(dev);
 	return dev->irq;
diff --git a/arch/mips/pci/fixup-malta.c b/arch/mips/pci/fixup-malta.c
index 40e920c..3ec8533 100644
--- a/arch/mips/pci/fixup-malta.c
+++ b/arch/mips/pci/fixup-malta.c
@@ -12,7 +12,7 @@
 static char pci_irq[5] = {
 };
 
-static char irq_tab[][5] __initdata = {
+static char irq_tab[][5] = {
 	/*	INTA	INTB	INTC	INTD */
 	{0,	0,	0,	0,	0 },	/*  0: GT64120 PCI bridge */
 	{0,	0,	0,	0,	0 },	/*  1: Unused */
@@ -38,7 +38,7 @@ static char irq_tab[][5] __initdata = {
 	{0,	PCID,	PCIA,	PCIB,	PCIC }	/* 21: PCI Slot 4 */
 };
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int virq;
 	virq = irq_tab[slot][pin];
diff --git a/arch/mips/pci/fixup-mpc30x.c b/arch/mips/pci/fixup-mpc30x.c
index 8e4f828..66eaf45 100644
--- a/arch/mips/pci/fixup-mpc30x.c
+++ b/arch/mips/pci/fixup-mpc30x.c
@@ -22,19 +22,19 @@
 
 #include <asm/vr41xx/mpc30x.h>
 
-static const int internal_func_irqs[] __initconst = {
+static const int internal_func_irqs[] = {
 	VRC4173_CASCADE_IRQ,
 	VRC4173_AC97_IRQ,
 	VRC4173_USB_IRQ,
 };
 
-static const int irq_tab_mpc30x[] __initconst = {
+static const int irq_tab_mpc30x[] = {
  [12] = VRC4173_PCMCIA1_IRQ,
  [13] = VRC4173_PCMCIA2_IRQ,
  [29] = MQ200_IRQ,
 };
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	if (slot == 30)
 		return internal_func_irqs[PCI_FUNC(dev->devfn)];
diff --git a/arch/mips/pci/fixup-pmcmsp.c b/arch/mips/pci/fixup-pmcmsp.c
index fab405c..4ad2ef0 100644
--- a/arch/mips/pci/fixup-pmcmsp.c
+++ b/arch/mips/pci/fixup-pmcmsp.c
@@ -47,7 +47,7 @@
 
 #if defined(CONFIG_PMC_MSP7120_GW)
 /* Garibaldi Board IRQ wiring to PCI slots */
-static char irq_tab[][5] __initdata = {
+static char irq_tab[][5] = {
 	/* INTA	   INTB	   INTC	   INTD */
 	{0,	0,	0,	0,	0 },	/*    (AD[0]): Unused */
 	{0,	0,	0,	0,	0 },	/*    (AD[1]): Unused */
@@ -86,7 +86,7 @@ static char irq_tab[][5] __initdata = {
 #elif defined(CONFIG_PMC_MSP7120_EVAL)
 
 /* MSP7120 Eval Board IRQ wiring to PCI slots */
-static char irq_tab[][5] __initdata = {
+static char irq_tab[][5] = {
 	/* INTA	   INTB	   INTC	   INTD */
 	{0,	0,	0,	0,	0 },	/*    (AD[0]): Unused */
 	{0,	0,	0,	0,	0 },	/*    (AD[1]): Unused */
@@ -125,7 +125,7 @@ static char irq_tab[][5] __initdata = {
 #else
 
 /* Unknown board -- don't assign any IRQs */
-static char irq_tab[][5] __initdata = {
+static char irq_tab[][5] = {
 	/* INTA	   INTB	   INTC	   INTD */
 	{0,	0,	0,	0,	0 },	/*    (AD[0]): Unused */
 	{0,	0,	0,	0,	0 },	/*    (AD[1]): Unused */
@@ -202,7 +202,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
  *  RETURNS:	 IRQ number
  *
  ****************************************************************************/
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 #if !defined(CONFIG_PMC_MSP7120_GW) && !defined(CONFIG_PMC_MSP7120_EVAL)
 	printk(KERN_WARNING "PCI: unknown board, no PCI IRQs assigned.\n");
diff --git a/arch/mips/pci/fixup-rbtx4927.c b/arch/mips/pci/fixup-rbtx4927.c
index 321db26..d6aaed1 100644
--- a/arch/mips/pci/fixup-rbtx4927.c
+++ b/arch/mips/pci/fixup-rbtx4927.c
@@ -36,7 +36,7 @@
 #include <asm/txx9/pci.h>
 #include <asm/txx9/rbtx4927.h>
 
-int __init rbtx4927_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int rbtx4927_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	unsigned char irq = pin;
 
diff --git a/arch/mips/pci/fixup-rbtx4938.c b/arch/mips/pci/fixup-rbtx4938.c
index a80579a..ff22a22 100644
--- a/arch/mips/pci/fixup-rbtx4938.c
+++ b/arch/mips/pci/fixup-rbtx4938.c
@@ -13,7 +13,7 @@
 #include <asm/txx9/pci.h>
 #include <asm/txx9/rbtx4938.h>
 
-int __init rbtx4938_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int rbtx4938_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq = tx4938_pcic1_map_irq(dev, slot);
 
diff --git a/arch/mips/pci/fixup-sni.c b/arch/mips/pci/fixup-sni.c
index f67ebee..adb9a58 100644
--- a/arch/mips/pci/fixup-sni.c
+++ b/arch/mips/pci/fixup-sni.c
@@ -40,7 +40,7 @@
  * seem to be a documentation error.  At least on my RM200C the Cirrus
  * Logic CL-GD5434 VGA is device 3.
  */
-static char irq_tab_rm200[8][5] __initdata = {
+static char irq_tab_rm200[8][5] = {
 	/*	 INTA  INTB  INTC  INTD */
 	{     0,    0,	  0,	0,    0 },	/* EISA bridge */
 	{  SCSI, SCSI, SCSI, SCSI, SCSI },	/* SCSI */
@@ -57,7 +57,7 @@ static char irq_tab_rm200[8][5] __initdata = {
  *
  * The VGA card is optional for RM300 systems.
  */
-static char irq_tab_rm300d[8][5] __initdata = {
+static char irq_tab_rm300d[8][5] = {
 	/*	 INTA  INTB  INTC  INTD */
 	{     0,    0,	  0,	0,    0 },	/* EISA bridge */
 	{  SCSI, SCSI, SCSI, SCSI, SCSI },	/* SCSI */
@@ -69,7 +69,7 @@ static char irq_tab_rm300d[8][5] __initdata = {
 	{     0, INTD, INTA, INTB, INTC },	/* Slot 4 */
 };
 
-static char irq_tab_rm300e[5][5] __initdata = {
+static char irq_tab_rm300e[5][5] = {
 	/*	 INTA  INTB  INTC  INTD */
 	{     0,    0,	  0,	0,    0 },	/* HOST bridge */
 	{  SCSI, SCSI, SCSI, SCSI, SCSI },	/* SCSI */
@@ -96,7 +96,7 @@ static char irq_tab_rm300e[5][5] __initdata = {
 #define INTC	PCIT_IRQ_INTC
 #define INTD	PCIT_IRQ_INTD
 
-static char irq_tab_pcit[13][5] __initdata = {
+static char irq_tab_pcit[13][5] = {
 	/*	 INTA  INTB  INTC  INTD */
 	{     0,     0,	    0,	   0,	  0 },	/* HOST bridge */
 	{ SCSI0, SCSI0, SCSI0, SCSI0, SCSI0 },	/* SCSI */
@@ -113,7 +113,7 @@ static char irq_tab_pcit[13][5] __initdata = {
 	{     0,  INTA,	 INTB,	INTC,  INTD },	/* Slot 5 */
 };
 
-static char irq_tab_pcit_cplus[13][5] __initdata = {
+static char irq_tab_pcit_cplus[13][5] = {
 	/*	 INTA  INTB  INTC  INTD */
 	{     0,     0,	    0,	   0,	  0 },	/* HOST bridge */
 	{     0,  INTB,	 INTC,	INTD,  INTA },	/* PCI Slot 9 */
@@ -130,7 +130,7 @@ static inline int is_rm300_revd(void)
 	return (csmsr & 0xa0) == 0x20;
 }
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	switch (sni_brd_type) {
 	case SNI_BRD_PCI_TOWER_CPLUS:
diff --git a/arch/mips/pci/fixup-tb0219.c b/arch/mips/pci/fixup-tb0219.c
index d0b0083..cc58153 100644
--- a/arch/mips/pci/fixup-tb0219.c
+++ b/arch/mips/pci/fixup-tb0219.c
@@ -23,7 +23,7 @@
 
 #include <asm/vr41xx/tb0219.h>
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq = -1;
 
diff --git a/arch/mips/pci/fixup-tb0226.c b/arch/mips/pci/fixup-tb0226.c
index 4196ccf..b827b5c 100644
--- a/arch/mips/pci/fixup-tb0226.c
+++ b/arch/mips/pci/fixup-tb0226.c
@@ -23,7 +23,7 @@
 #include <asm/vr41xx/giu.h>
 #include <asm/vr41xx/tb0226.h>
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq = -1;
 
diff --git a/arch/mips/pci/fixup-tb0287.c b/arch/mips/pci/fixup-tb0287.c
index 8c5039e..98f2628 100644
--- a/arch/mips/pci/fixup-tb0287.c
+++ b/arch/mips/pci/fixup-tb0287.c
@@ -22,7 +22,7 @@
 
 #include <asm/vr41xx/tb0287.h>
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	unsigned char bus;
 	int irq = -1;
diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
index e99ca77..f15ec98 100644
--- a/arch/mips/pci/pci-alchemy.c
+++ b/arch/mips/pci/pci-alchemy.c
@@ -522,7 +522,7 @@ static int __init alchemy_pci_init(void)
 arch_initcall(alchemy_pci_init);
 
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	struct alchemy_pci_context *ctx = dev->sysdata;
 	if (ctx && ctx->board_map_irq)
diff --git a/arch/mips/pci/pci-bcm47xx.c b/arch/mips/pci/pci-bcm47xx.c
index 76f16ea..230d7dd 100644
--- a/arch/mips/pci/pci-bcm47xx.c
+++ b/arch/mips/pci/pci-bcm47xx.c
@@ -28,7 +28,7 @@
 #include <linux/bcma/bcma.h>
 #include <bcm47xx.h>
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return 0;
 }
diff --git a/arch/mips/pci/pci-lasat.c b/arch/mips/pci/pci-lasat.c
index 40d2797..47f4ee6 100644
--- a/arch/mips/pci/pci-lasat.c
+++ b/arch/mips/pci/pci-lasat.c
@@ -61,7 +61,7 @@ arch_initcall(lasat_pci_setup);
 #define LASAT_IRQ_PCIC	 (LASAT_IRQ_BASE + 7)
 #define LASAT_IRQ_PCID	 (LASAT_IRQ_BASE + 8)
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	switch (slot) {
 	case 1:
diff --git a/arch/mips/pci/pci-mt7620.c b/arch/mips/pci/pci-mt7620.c
index 4e633c1..90fba9b 100644
--- a/arch/mips/pci/pci-mt7620.c
+++ b/arch/mips/pci/pci-mt7620.c
@@ -361,7 +361,7 @@ static int mt7620_pci_probe(struct platform_device *pdev)
 	return 0;
 }
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	u16 cmd;
 	u32 val;
diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index 9ee0193..3e92a06 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -59,8 +59,7 @@ union octeon_pci_address {
 	} s;
 };
 
-int __initconst (*octeon_pcibios_map_irq)(const struct pci_dev *dev,
-					 u8 slot, u8 pin);
+int (*octeon_pcibios_map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
 enum octeon_dma_bar_type octeon_dma_bar_type = OCTEON_DMA_BAR_TYPE_INVALID;
 
 /**
@@ -74,7 +73,7 @@ enum octeon_dma_bar_type octeon_dma_bar_type = OCTEON_DMA_BAR_TYPE_INVALID;
  *		 as it goes through each bridge.
  * Returns Interrupt number for the device
  */
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	if (octeon_pcibios_map_irq)
 		return octeon_pcibios_map_irq(dev, slot, pin);
diff --git a/arch/mips/pci/pci-rt2880.c b/arch/mips/pci/pci-rt2880.c
index d6360fe..711cdcc 100644
--- a/arch/mips/pci/pci-rt2880.c
+++ b/arch/mips/pci/pci-rt2880.c
@@ -181,7 +181,7 @@ static inline void rt2880_pci_write_u32(unsigned long reg, u32 val)
 	spin_unlock_irqrestore(&rt2880_pci_lock, flags);
 }
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	u16 cmd;
 	int irq = -1;
diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
index 04f8ea9..958899f 100644
--- a/arch/mips/pci/pci-rt3883.c
+++ b/arch/mips/pci/pci-rt3883.c
@@ -564,7 +564,7 @@ static int rt3883_pci_probe(struct platform_device *pdev)
 	return err;
 }
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return of_irq_parse_and_map_pci(dev, slot, pin);
 }
diff --git a/arch/mips/pci/pci-tx4938.c b/arch/mips/pci/pci-tx4938.c
index 000c0e1..a641846 100644
--- a/arch/mips/pci/pci-tx4938.c
+++ b/arch/mips/pci/pci-tx4938.c
@@ -112,7 +112,7 @@ int __init tx4938_pciclk66_setup(void)
 	return pciclk;
 }
 
-int __init tx4938_pcic1_map_irq(const struct pci_dev *dev, u8 slot)
+int tx4938_pcic1_map_irq(const struct pci_dev *dev, u8 slot)
 {
 	if (get_tx4927_pcicptr(dev->bus->sysdata) == tx4938_pcic1ptr) {
 		switch (slot) {
diff --git a/arch/mips/pci/pci-tx4939.c b/arch/mips/pci/pci-tx4939.c
index 9d6acc0..09a65f7 100644
--- a/arch/mips/pci/pci-tx4939.c
+++ b/arch/mips/pci/pci-tx4939.c
@@ -48,7 +48,7 @@ void __init tx4939_report_pci1clk(void)
 		((pciclk + 50000) / 100000) % 10);
 }
 
-int __init tx4939_pcic1_map_irq(const struct pci_dev *dev, u8 slot)
+int tx4939_pcic1_map_irq(const struct pci_dev *dev, u8 slot)
 {
 	if (get_tx4927_pcicptr(dev->bus->sysdata) == tx4939_pcic1ptr) {
 		switch (slot) {
@@ -68,7 +68,7 @@ int __init tx4939_pcic1_map_irq(const struct pci_dev *dev, u8 slot)
 	return -1;
 }
 
-int __init tx4939_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int tx4939_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq = tx4939_pcic1_map_irq(dev, slot);
 
diff --git a/arch/mips/pci/pci-xlp.c b/arch/mips/pci/pci-xlp.c
index 7babf01..9eff913 100644
--- a/arch/mips/pci/pci-xlp.c
+++ b/arch/mips/pci/pci-xlp.c
@@ -205,7 +205,7 @@ int xlp_socdev_to_node(const struct pci_dev *lnkdev)
 		return PCI_SLOT(lnkdev->devfn) / 8;
 }
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	struct pci_dev *lnkdev;
 	int lnkfunc, node;
diff --git a/arch/mips/pci/pci-xlr.c b/arch/mips/pci/pci-xlr.c
index 26d2dab..2a1c81a 100644
--- a/arch/mips/pci/pci-xlr.c
+++ b/arch/mips/pci/pci-xlr.c
@@ -315,7 +315,7 @@ static void xls_pcie_ack_b(struct irq_data *d)
 	}
 }
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return get_irq_vector(dev);
 }
diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
index ad3584d..fd28874 100644
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -1464,8 +1464,7 @@ static int cvmx_pcie_rc_initialize(int pcie_port)
  *		 as it goes through each bridge.
  * Returns Interrupt number for the device
  */
-int __init octeon_pcie_pcibios_map_irq(const struct pci_dev *dev,
-				       u8 slot, u8 pin)
+int octeon_pcie_pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	/*
 	 * The EBH5600 board with the PCI to PCIe bridge mistakenly
diff --git a/arch/mips/txx9/generic/pci.c b/arch/mips/txx9/generic/pci.c
index 0bd2a1e..fb99872 100644
--- a/arch/mips/txx9/generic/pci.c
+++ b/arch/mips/txx9/generic/pci.c
@@ -386,9 +386,10 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	return 0;
 }
 
-int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+static int (*txx9_pci_map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	return txx9_board_vec->pci_map_irq(dev, slot, pin);
+	return txx9_pci_map_irq(dev, slot, pin);
 }
 
 char * (*txx9_board_pcibios_setup)(char *str) __initdata;
@@ -424,5 +425,8 @@ char *__init txx9_pcibios_setup(char *str)
 			txx9_pci_err_action = TXX9_PCI_ERR_IGNORE;
 		return NULL;
 	}
+
+	txx9_pci_map_irq = txx9_board_vec->pci_map_irq;
+
 	return str;
 }
-- 
2.10.0
