Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([80.244.247.6]:47053 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754360Ab2FCT05 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 Jun 2012 15:26:57 -0400
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: linux-pci@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Michal Marek <mmarek@suse.cz>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 7/9] mips: move PCI fixup hooks from __init to __devinit
Date: Sun,  3 Jun 2012 20:48:23 +0200
Message-Id: <1338749305-22558-8-git-send-email-sebastian@breakpoint.cc>
In-Reply-To: <1338749305-22558-1-git-send-email-sebastian@breakpoint.cc>
References: <1338749305-22558-1-git-send-email-sebastian@breakpoint.cc>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The fixups are executed once the pci-device is found which is during
boot process so __init seems fine as long as the platform does not
support hotplug.
However it is possible to remove the PCI bus at run time and have it
rediscovered again via "echo 1 > /sys/bus/pci/rescan" and this will call
the fixups again.

Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 arch/mips/mti-malta/malta-pci.c |    2 +-
 arch/mips/pci/fixup-fuloong2e.c |   12 ++++++------
 arch/mips/pci/fixup-lemote2f.c  |   12 ++++++------
 arch/mips/pci/fixup-malta.c     |    4 ++--
 arch/mips/pci/fixup-sb1250.c    |    6 +++---
 arch/mips/pci/ops-tx4927.c      |    2 +-
 arch/mips/pci/pci-ip27.c        |    2 +-
 arch/mips/txx9/generic/pci.c    |    2 +-
 8 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/mips/mti-malta/malta-pci.c b/arch/mips/mti-malta/malta-pci.c
index bf80921..b663402 100644
--- a/arch/mips/mti-malta/malta-pci.c
+++ b/arch/mips/mti-malta/malta-pci.c
@@ -253,7 +253,7 @@ void __init mips_pcibios_init(void)
 }
 
 /* Enable PCI 2.1 compatibility in PIIX4 */
-static void __init quirk_dlcsetup(struct pci_dev *dev)
+static void __devinit quirk_dlcsetup(struct pci_dev *dev)
 {
 	u8 odlc, ndlc;
 	(void) pci_read_config_byte(dev, 0x82, &odlc);
diff --git a/arch/mips/pci/fixup-fuloong2e.c b/arch/mips/pci/fixup-fuloong2e.c
index d5d4c01..0857ab8 100644
--- a/arch/mips/pci/fixup-fuloong2e.c
+++ b/arch/mips/pci/fixup-fuloong2e.c
@@ -48,7 +48,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	return 0;
 }
 
-static void __init loongson2e_nec_fixup(struct pci_dev *pdev)
+static void __devinit loongson2e_nec_fixup(struct pci_dev *pdev)
 {
 	unsigned int val;
 
@@ -60,7 +60,7 @@ static void __init loongson2e_nec_fixup(struct pci_dev *pdev)
 	pci_write_config_dword(pdev, 0xe4, 1 << 5);
 }
 
-static void __init loongson2e_686b_func0_fixup(struct pci_dev *pdev)
+static void __devinit loongson2e_686b_func0_fixup(struct pci_dev *pdev)
 {
 	unsigned char c;
 
@@ -135,7 +135,7 @@ static void __init loongson2e_686b_func0_fixup(struct pci_dev *pdev)
 	printk(KERN_INFO"via686b fix: ISA bridge done\n");
 }
 
-static void __init loongson2e_686b_func1_fixup(struct pci_dev *pdev)
+static void __devinit loongson2e_686b_func1_fixup(struct pci_dev *pdev)
 {
 	printk(KERN_INFO"via686b fix: IDE\n");
 
@@ -168,19 +168,19 @@ static void __init loongson2e_686b_func1_fixup(struct pci_dev *pdev)
 	printk(KERN_INFO"via686b fix: IDE done\n");
 }
 
-static void __init loongson2e_686b_func2_fixup(struct pci_dev *pdev)
+static void __devinit loongson2e_686b_func2_fixup(struct pci_dev *pdev)
 {
 	/* irq routing */
 	pci_write_config_byte(pdev, PCI_INTERRUPT_LINE, 10);
 }
 
-static void __init loongson2e_686b_func3_fixup(struct pci_dev *pdev)
+static void __devinit loongson2e_686b_func3_fixup(struct pci_dev *pdev)
 {
 	/* irq routing */
 	pci_write_config_byte(pdev, PCI_INTERRUPT_LINE, 11);
 }
 
-static void __init loongson2e_686b_func5_fixup(struct pci_dev *pdev)
+static void __devinit loongson2e_686b_func5_fixup(struct pci_dev *pdev)
 {
 	unsigned int val;
 	unsigned char c;
diff --git a/arch/mips/pci/fixup-lemote2f.c b/arch/mips/pci/fixup-lemote2f.c
index 4b9768d..a7b917dcf 100644
--- a/arch/mips/pci/fixup-lemote2f.c
+++ b/arch/mips/pci/fixup-lemote2f.c
@@ -96,21 +96,21 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 }
 
 /* CS5536 SPEC. fixup */
-static void __init loongson_cs5536_isa_fixup(struct pci_dev *pdev)
+static void __devinit loongson_cs5536_isa_fixup(struct pci_dev *pdev)
 {
 	/* the uart1 and uart2 interrupt in PIC is enabled as default */
 	pci_write_config_dword(pdev, PCI_UART1_INT_REG, 1);
 	pci_write_config_dword(pdev, PCI_UART2_INT_REG, 1);
 }
 
-static void __init loongson_cs5536_ide_fixup(struct pci_dev *pdev)
+static void __devinit loongson_cs5536_ide_fixup(struct pci_dev *pdev)
 {
 	/* setting the mutex pin as IDE function */
 	pci_write_config_dword(pdev, PCI_IDE_CFG_REG,
 			       CS5536_IDE_FLASH_SIGNATURE);
 }
 
-static void __init loongson_cs5536_acc_fixup(struct pci_dev *pdev)
+static void __devinit loongson_cs5536_acc_fixup(struct pci_dev *pdev)
 {
 	/* enable the AUDIO interrupt in PIC  */
 	pci_write_config_dword(pdev, PCI_ACC_INT_REG, 1);
@@ -118,14 +118,14 @@ static void __init loongson_cs5536_acc_fixup(struct pci_dev *pdev)
 	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0xc0);
 }
 
-static void __init loongson_cs5536_ohci_fixup(struct pci_dev *pdev)
+static void __devinit loongson_cs5536_ohci_fixup(struct pci_dev *pdev)
 {
 	/* enable the OHCI interrupt in PIC */
 	/* THE OHCI, EHCI, UDC, OTG are shared with interrupt in PIC */
 	pci_write_config_dword(pdev, PCI_OHCI_INT_REG, 1);
 }
 
-static void __init loongson_cs5536_ehci_fixup(struct pci_dev *pdev)
+static void __devinit loongson_cs5536_ehci_fixup(struct pci_dev *pdev)
 {
 	u32 hi, lo;
 
@@ -137,7 +137,7 @@ static void __init loongson_cs5536_ehci_fixup(struct pci_dev *pdev)
 	pci_write_config_dword(pdev, PCI_EHCI_FLADJ_REG, 0x2000);
 }
 
-static void __init loongson_nec_fixup(struct pci_dev *pdev)
+static void __devinit loongson_nec_fixup(struct pci_dev *pdev)
 {
 	unsigned int val;
 
diff --git a/arch/mips/pci/fixup-malta.c b/arch/mips/pci/fixup-malta.c
index 0f48498..59cfbc8 100644
--- a/arch/mips/pci/fixup-malta.c
+++ b/arch/mips/pci/fixup-malta.c
@@ -49,7 +49,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	return 0;
 }
 
-static void __init malta_piix_func0_fixup(struct pci_dev *pdev)
+static void __devinit malta_piix_func0_fixup(struct pci_dev *pdev)
 {
 	unsigned char reg_val;
 	static int piixirqmap[16] __initdata = {  /* PIIX PIRQC[A:D] irq mappings */
@@ -83,7 +83,7 @@ static void __init malta_piix_func0_fixup(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0,
 	 malta_piix_func0_fixup);
 
-static void __init malta_piix_func1_fixup(struct pci_dev *pdev)
+static void __devinit malta_piix_func1_fixup(struct pci_dev *pdev)
 {
 	unsigned char reg_val;
 
diff --git a/arch/mips/pci/fixup-sb1250.c b/arch/mips/pci/fixup-sb1250.c
index f0bb914..d02900a 100644
--- a/arch/mips/pci/fixup-sb1250.c
+++ b/arch/mips/pci/fixup-sb1250.c
@@ -15,7 +15,7 @@
  * Set the BCM1250, etc. PCI host bridge's TRDY timeout
  * to the finite max.
  */
-static void __init quirk_sb1250_pci(struct pci_dev *dev)
+static void __devinit quirk_sb1250_pci(struct pci_dev *dev)
 {
 	pci_write_config_byte(dev, 0x40, 0xff);
 }
@@ -25,7 +25,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIBYTE, PCI_DEVICE_ID_BCM1250_PCI,
 /*
  * The BCM1250, etc. PCI/HT bridge reports as a host bridge.
  */
-static void __init quirk_sb1250_ht(struct pci_dev *dev)
+static void __devinit quirk_sb1250_ht(struct pci_dev *dev)
 {
 	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
 }
@@ -35,7 +35,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIBYTE, PCI_DEVICE_ID_BCM1250_HT,
 /*
  * Set the SP1011 HT/PCI bridge's TRDY timeout to the finite max.
  */
-static void __init quirk_sp1011(struct pci_dev *dev)
+static void __devinit quirk_sp1011(struct pci_dev *dev)
 {
 	pci_write_config_byte(dev, 0x64, 0xff);
 }
diff --git a/arch/mips/pci/ops-tx4927.c b/arch/mips/pci/ops-tx4927.c
index a1e7e6d..bc13e29 100644
--- a/arch/mips/pci/ops-tx4927.c
+++ b/arch/mips/pci/ops-tx4927.c
@@ -495,7 +495,7 @@ irqreturn_t tx4927_pcierr_interrupt(int irq, void *dev_id)
 }
 
 #ifdef CONFIG_TOSHIBA_FPCIB0
-static void __init tx4927_quirk_slc90e66_bridge(struct pci_dev *dev)
+static void __devinit tx4927_quirk_slc90e66_bridge(struct pci_dev *dev)
 {
 	struct tx4927_pcic_reg __iomem *pcicptr = pci_bus_to_pcicptr(dev->bus);
 
diff --git a/arch/mips/pci/pci-ip27.c b/arch/mips/pci/pci-ip27.c
index 0fbe4c0..fdc2444 100644
--- a/arch/mips/pci/pci-ip27.c
+++ b/arch/mips/pci/pci-ip27.c
@@ -212,7 +212,7 @@ static inline void pci_enable_swapping(struct pci_dev *dev)
 	bridge->b_widget.w_tflush;	/* Flush */
 }
 
-static void __init pci_fixup_ioc3(struct pci_dev *d)
+static void __devinit pci_fixup_ioc3(struct pci_dev *d)
 {
 	pci_disable_swapping(d);
 }
diff --git a/arch/mips/txx9/generic/pci.c b/arch/mips/txx9/generic/pci.c
index 682efb0..64eb71b 100644
--- a/arch/mips/txx9/generic/pci.c
+++ b/arch/mips/txx9/generic/pci.c
@@ -269,7 +269,7 @@ txx9_i8259_irq_setup(int irq)
 	return err;
 }
 
-static void __init quirk_slc90e66_bridge(struct pci_dev *dev)
+static void __devinit quirk_slc90e66_bridge(struct pci_dev *dev)
 {
 	int irq;	/* PCI/ISA Bridge interrupt */
 	u8 reg_64;
-- 
1.7.10

