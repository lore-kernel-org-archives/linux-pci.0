Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36229 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbbJWFFy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:05:54 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 12/29] sh/PCI: Remove __init optimisations from IRQ mapping functions/data
Date: Fri, 23 Oct 2015 06:03:45 +0100
Message-Id: <1445576642-29624-13-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently the many IRQ mapping functions and data structures use
the __init and __initdata optimisations. These result in the
relevant functions being innacessable after boot time.

However for deferred IRQ assignment it is important to have
access to these functions at PCI device enable time.

Therefore the optimisation is removed from the relevant data
structures and functions to prepare for deferred IRQ assignment.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 arch/sh/drivers/pci/fixups-cayman.c     | 2 +-
 arch/sh/drivers/pci/fixups-dreamcast.c  | 2 +-
 arch/sh/drivers/pci/fixups-r7780rp.c    | 2 +-
 arch/sh/drivers/pci/fixups-rts7751r2d.c | 6 +++---
 arch/sh/drivers/pci/fixups-sdk7780.c    | 4 ++--
 arch/sh/drivers/pci/fixups-se7751.c     | 2 +-
 arch/sh/drivers/pci/fixups-sh03.c       | 2 +-
 arch/sh/drivers/pci/fixups-snapgear.c   | 2 +-
 arch/sh/drivers/pci/fixups-titan.c      | 4 ++--
 arch/sh/drivers/pci/pcie-sh7786.c       | 2 +-
 10 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/sh/drivers/pci/fixups-cayman.c b/arch/sh/drivers/pci/fixups-cayman.c
index edc2fb7..3246788 100644
--- a/arch/sh/drivers/pci/fixups-cayman.c
+++ b/arch/sh/drivers/pci/fixups-cayman.c
@@ -5,7 +5,7 @@
 #include <cpu/irq.h>
 #include "pci-sh5.h"
 
-int __init pcibios_map_platform_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_platform_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int result = -1;
 
diff --git a/arch/sh/drivers/pci/fixups-dreamcast.c b/arch/sh/drivers/pci/fixups-dreamcast.c
index 1d1c5a2..9d597f7 100644
--- a/arch/sh/drivers/pci/fixups-dreamcast.c
+++ b/arch/sh/drivers/pci/fixups-dreamcast.c
@@ -76,7 +76,7 @@ static void gapspci_fixup_resources(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, gapspci_fixup_resources);
 
-int __init pcibios_map_platform_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_platform_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	/*
 	 * The interrupt routing semantics here are quite trivial.
diff --git a/arch/sh/drivers/pci/fixups-r7780rp.c b/arch/sh/drivers/pci/fixups-r7780rp.c
index 57ed3f0..2c9b58f 100644
--- a/arch/sh/drivers/pci/fixups-r7780rp.c
+++ b/arch/sh/drivers/pci/fixups-r7780rp.c
@@ -15,7 +15,7 @@
 #include <linux/sh_intc.h>
 #include "pci-sh4.h"
 
-int __init pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
+int pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
 {
 	return evt2irq(0xa20) + slot;
 }
diff --git a/arch/sh/drivers/pci/fixups-rts7751r2d.c b/arch/sh/drivers/pci/fixups-rts7751r2d.c
index eaddb56..358ac10 100644
--- a/arch/sh/drivers/pci/fixups-rts7751r2d.c
+++ b/arch/sh/drivers/pci/fixups-rts7751r2d.c
@@ -20,18 +20,18 @@
 #define PCIMCR_MRSET_OFF	0xBFFFFFFF
 #define PCIMCR_RFSH_OFF		0xFFFFFFFB
 
-static u8 rts7751r2d_irq_tab[] __initdata = {
+static u8 rts7751r2d_irq_tab[] = {
 	IRQ_PCI_INTA,
 	IRQ_PCI_INTB,
 	IRQ_PCI_INTC,
 	IRQ_PCI_INTD,
 };
 
-static char lboxre2_irq_tab[] __initdata = {
+static char lboxre2_irq_tab[] = {
 	IRQ_ETH0, IRQ_ETH1, IRQ_INTA, IRQ_INTD,
 };
 
-int __init pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
+int pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
 {
 	if (mach_is_lboxre2())
 		return lboxre2_irq_tab[slot];
diff --git a/arch/sh/drivers/pci/fixups-sdk7780.c b/arch/sh/drivers/pci/fixups-sdk7780.c
index c0a015a..24e96df 100644
--- a/arch/sh/drivers/pci/fixups-sdk7780.c
+++ b/arch/sh/drivers/pci/fixups-sdk7780.c
@@ -22,7 +22,7 @@
 #define IRQ_INTD	evt2irq(0xa80)
 
 /* IDSEL [16][17][18][19][20][21][22][23][24][25][26][27][28][29][30][31] */
-static char sdk7780_irq_tab[4][16] __initdata = {
+static char sdk7780_irq_tab[4][16] = {
 	/* INTA */
 	{ IRQ_INTA, IRQ_INTD, IRQ_INTC, IRQ_INTD, -1, -1, -1, -1, -1, -1,
 	  -1, -1, -1, -1, -1, -1 },
@@ -37,7 +37,7 @@ static char sdk7780_irq_tab[4][16] __initdata = {
 	  -1, -1, -1 },
 };
 
-int __init pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
+int pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
 {
        return sdk7780_irq_tab[pin-1][slot];
 }
diff --git a/arch/sh/drivers/pci/fixups-se7751.c b/arch/sh/drivers/pci/fixups-se7751.c
index 84a88ca..1cb8d0a 100644
--- a/arch/sh/drivers/pci/fixups-se7751.c
+++ b/arch/sh/drivers/pci/fixups-se7751.c
@@ -7,7 +7,7 @@
 #include <linux/sh_intc.h>
 #include "pci-sh4.h"
 
-int __init pcibios_map_platform_irq(const struct pci_dev *, u8 slot, u8 pin)
+int pcibios_map_platform_irq(const struct pci_dev *, u8 slot, u8 pin)
 {
         switch (slot) {
         case 0: return evt2irq(0x3a0);
diff --git a/arch/sh/drivers/pci/fixups-sh03.c b/arch/sh/drivers/pci/fixups-sh03.c
index 16207be..55ac1ba 100644
--- a/arch/sh/drivers/pci/fixups-sh03.c
+++ b/arch/sh/drivers/pci/fixups-sh03.c
@@ -4,7 +4,7 @@
 #include <linux/pci.h>
 #include <linux/sh_intc.h>
 
-int __init pcibios_map_platform_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int pcibios_map_platform_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq;
 
diff --git a/arch/sh/drivers/pci/fixups-snapgear.c b/arch/sh/drivers/pci/fixups-snapgear.c
index 6e33ba4..a931e59 100644
--- a/arch/sh/drivers/pci/fixups-snapgear.c
+++ b/arch/sh/drivers/pci/fixups-snapgear.c
@@ -19,7 +19,7 @@
 #include <linux/sh_intc.h>
 #include "pci-sh4.h"
 
-int __init pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
+int pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
 {
 	int irq = -1;
 
diff --git a/arch/sh/drivers/pci/fixups-titan.c b/arch/sh/drivers/pci/fixups-titan.c
index bd1addb..a9d563e 100644
--- a/arch/sh/drivers/pci/fixups-titan.c
+++ b/arch/sh/drivers/pci/fixups-titan.c
@@ -19,7 +19,7 @@
 #include <mach/titan.h>
 #include "pci-sh4.h"
 
-static char titan_irq_tab[] __initdata = {
+static char titan_irq_tab[] = {
 	TITAN_IRQ_WAN,
 	TITAN_IRQ_LAN,
 	TITAN_IRQ_MPCIA,
@@ -27,7 +27,7 @@ static char titan_irq_tab[] __initdata = {
 	TITAN_IRQ_USB,
 };
 
-int __init pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
+int pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
 {
 	int irq = titan_irq_tab[slot];
 
diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
index a162a7f..0167a73 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -467,7 +467,7 @@ static int __init pcie_init(struct sh7786_pcie_port *port)
 	return 0;
 }
 
-int __init pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
+int pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
 {
         return evt2irq(0xae0);
 }
-- 
2.6.2

