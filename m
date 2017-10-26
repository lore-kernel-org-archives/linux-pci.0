Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47882 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932246AbdJZOyN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Oct 2017 10:54:13 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Meelis Roos <mroos@linux.ee>, Matt Turner <mattst88@gmail.com>
Subject: [PATCH] alpha/pci: Fix pci_map_irq()/pci_swizzle() functions section markers
Date: Thu, 26 Oct 2017 15:54:15 +0100
Message-Id: <1509029655-30493-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The introduction of {map/swizzle}_irq() hooks in the
struct pci_host_bridge allowed to replace the pci_fixup_irqs()
PCI IRQ allocation in alpha arch PCI code with per-bridge
map/swizzle functions with commit 0e4c2eeb758a ("alpha/PCI: Replace
pci_fixup_irqs() call with host bridge IRQ mapping hooks").

As a side effect of converting PCI IRQ allocation to the struct
pci_host_bridge {map/swizzle}_irq() hooks mechanism, the actual PCI IRQ
allocation function (ie pci_assign_irq()) is carried out per-device in
pci_device_probe() that is called when a PCI device driver is about to
be probed.

This means that, for drivers compiled as loadable modules, the actual
PCI device IRQ allocation can now happen after the system has booted so the
struct pci_host_bridge {map/swizzle}_irq() hooks pci_assign_irq() relies
on must stay valid after the system has booted so that PCI core can
carry out PCI IRQ allocation correctly.

Most of the alpha board structures pci_map_irq() and pci_swizzle() hooks
(that are used to initialize their struct pci_host_bridge equivalent
through the alpha_mv global variable - that represents the struct
alpha_machine_vector of the running kernel) are marked as
__init/__initdata; this causes freed memory dereferences when PCI IRQ
allocation is carried out after the kernel has booted (ie when loading
PCI drivers as loadable module) because when the kernel tries to bind
the PCI device to its (module) driver, the function pci_assign_irq() is
called, that in turn retrieves the struct pci_host_bridge
{map/swizzle}_irq() hooks to carry out PCI IRQ allocation; if those
hooks are marked as __init code/__initdata they point at freed/invalid
memory.

Fix the issue by removing the __init/__initdata markers from all subarch
struct alpha_machine_vector.pci_map_irq()/pci_swizzle() functions (and
data).

Fixes: 0e4c2eeb758a ("alpha/PCI: Replace pci_fixup_irqs() call with host bridge IRQ mapping hooks")
Link: http://lkml.kernel.org/r/alpine.LRH.2.21.1710251043170.7098@math.ut.ee
Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Meelis Roos <mroos@linux.ee>
Cc: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/kernel/sys_alcor.c     |  4 ++--
 arch/alpha/kernel/sys_cabriolet.c | 12 ++++++------
 arch/alpha/kernel/sys_dp264.c     | 20 ++++++++++----------
 arch/alpha/kernel/sys_eb64p.c     |  4 ++--
 arch/alpha/kernel/sys_eiger.c     |  4 ++--
 arch/alpha/kernel/sys_miata.c     |  6 +++---
 arch/alpha/kernel/sys_mikasa.c    |  4 ++--
 arch/alpha/kernel/sys_nautilus.c  |  2 +-
 arch/alpha/kernel/sys_noritake.c  |  6 +++---
 arch/alpha/kernel/sys_rawhide.c   |  4 ++--
 arch/alpha/kernel/sys_ruffian.c   |  6 +++---
 arch/alpha/kernel/sys_rx164.c     |  4 ++--
 arch/alpha/kernel/sys_sable.c     | 10 +++++-----
 arch/alpha/kernel/sys_sio.c       |  8 ++++----
 arch/alpha/kernel/sys_sx164.c     |  4 ++--
 arch/alpha/kernel/sys_takara.c    |  6 +++---
 arch/alpha/kernel/sys_wildfire.c  |  4 ++--
 17 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/arch/alpha/kernel/sys_alcor.c b/arch/alpha/kernel/sys_alcor.c
index 118dc6a..7ad074f 100644
--- a/arch/alpha/kernel/sys_alcor.c
+++ b/arch/alpha/kernel/sys_alcor.c
@@ -181,10 +181,10 @@ alcor_init_irq(void)
  * comes in on.  This makes interrupt processing much easier.
  */
 
-static int __init
+static int
 alcor_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static char irq_tab[7][5] __initdata = {
+	static char irq_tab[7][5] = {
 		/*INT    INTA   INTB   INTC   INTD */
 		/* note: IDSEL 17 is XLT only */
 		{16+13, 16+13, 16+13, 16+13, 16+13},	/* IdSel 17,  TULIP  */
diff --git a/arch/alpha/kernel/sys_cabriolet.c b/arch/alpha/kernel/sys_cabriolet.c
index 4c50f8f4..c0fa1fe 100644
--- a/arch/alpha/kernel/sys_cabriolet.c
+++ b/arch/alpha/kernel/sys_cabriolet.c
@@ -173,10 +173,10 @@ pc164_init_irq(void)
  * because it is the Saturn IO (SIO) PCI/ISA Bridge Chip.
  */
 
-static inline int __init
+static inline int
 eb66p_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static char irq_tab[5][5] __initdata = {
+	static char irq_tab[5][5] = {
 		/*INT  INTA  INTB  INTC   INTD */
 		{16+0, 16+0, 16+5,  16+9, 16+13},  /* IdSel 6,  slot 0, J25 */
 		{16+1, 16+1, 16+6, 16+10, 16+14},  /* IdSel 7,  slot 1, J26 */
@@ -203,10 +203,10 @@ eb66p_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
  * because it is the Saturn IO (SIO) PCI/ISA Bridge Chip.
  */
 
-static inline int __init
+static inline int
 cabriolet_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static char irq_tab[5][5] __initdata = {
+	static char irq_tab[5][5] = {
 		/*INT   INTA  INTB  INTC   INTD */
 		{ 16+2, 16+2, 16+7, 16+11, 16+15}, /* IdSel 5,  slot 2, J21 */
 		{ 16+0, 16+0, 16+5,  16+9, 16+13}, /* IdSel 6,  slot 0, J19 */
@@ -287,10 +287,10 @@ cia_cab_init_pci(void)
  * 
  */
 
-static inline int __init
+static inline int
 alphapc164_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static char irq_tab[7][5] __initdata = {
+	static char irq_tab[7][5] = {
 		/*INT   INTA  INTB   INTC   INTD */
 		{ 16+2, 16+2, 16+9,  16+13, 16+17}, /* IdSel  5, slot 2, J20 */
 		{ 16+0, 16+0, 16+7,  16+11, 16+15}, /* IdSel  6, slot 0, J29 */
diff --git a/arch/alpha/kernel/sys_dp264.c b/arch/alpha/kernel/sys_dp264.c
index 6c35159..9e1e40e 100644
--- a/arch/alpha/kernel/sys_dp264.c
+++ b/arch/alpha/kernel/sys_dp264.c
@@ -356,7 +356,7 @@ clipper_init_irq(void)
  *  10	 64 bit PCI option slot 3 (not bus 0)
  */
 
-static int __init
+static int
 isa_irq_fixup(const struct pci_dev *dev, int irq)
 {
 	u8 irq8;
@@ -372,10 +372,10 @@ isa_irq_fixup(const struct pci_dev *dev, int irq)
 	return irq8 & 0xf;
 }
 
-static int __init
+static int
 dp264_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static char irq_tab[6][5] __initdata = {
+	static char irq_tab[6][5] = {
 		/*INT    INTA   INTB   INTC   INTD */
 		{    -1,    -1,    -1,    -1,    -1}, /* IdSel 5 ISA Bridge */
 		{ 16+ 3, 16+ 3, 16+ 2, 16+ 2, 16+ 2}, /* IdSel 6 SCSI builtin*/
@@ -394,10 +394,10 @@ dp264_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return isa_irq_fixup(dev, irq);
 }
 
-static int __init
+static int
 monet_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static char irq_tab[13][5] __initdata = {
+	static char irq_tab[13][5] = {
 		/*INT    INTA   INTB   INTC   INTD */
 		{    45,    45,    45,    45,    45}, /* IdSel 3 21143 PCI1 */
 		{    -1,    -1,    -1,    -1,    -1}, /* IdSel 4 unused */
@@ -423,7 +423,7 @@ monet_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return isa_irq_fixup(dev, COMMON_TABLE_LOOKUP);
 }
 
-static u8 __init
+static u8
 monet_swizzle(struct pci_dev *dev, u8 *pinp)
 {
 	struct pci_controller *hose = dev->sysdata;
@@ -456,10 +456,10 @@ monet_swizzle(struct pci_dev *dev, u8 *pinp)
 	return slot;
 }
 
-static int __init
+static int
 webbrick_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static char irq_tab[13][5] __initdata = {
+	static char irq_tab[13][5] = {
 		/*INT    INTA   INTB   INTC   INTD */
 		{    -1,    -1,    -1,    -1,    -1}, /* IdSel 7 ISA Bridge */
 		{    -1,    -1,    -1,    -1,    -1}, /* IdSel 8 unused */
@@ -478,10 +478,10 @@ webbrick_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return isa_irq_fixup(dev, COMMON_TABLE_LOOKUP);
 }
 
-static int __init
+static int
 clipper_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static char irq_tab[7][5] __initdata = {
+	static char irq_tab[7][5] = {
 		/*INT    INTA   INTB   INTC   INTD */
 		{ 16+ 8, 16+ 8, 16+ 9, 16+10, 16+11}, /* IdSel 1 slot 1 */
 		{ 16+12, 16+12, 16+13, 16+14, 16+15}, /* IdSel 2 slot 2 */
diff --git a/arch/alpha/kernel/sys_eb64p.c b/arch/alpha/kernel/sys_eb64p.c
index ad40a42..372661c 100644
--- a/arch/alpha/kernel/sys_eb64p.c
+++ b/arch/alpha/kernel/sys_eb64p.c
@@ -167,10 +167,10 @@ eb64p_init_irq(void)
  * comes in on.  This makes interrupt processing much easier.
  */
 
-static int __init
+static int
 eb64p_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static char irq_tab[5][5] __initdata = {
+	static char irq_tab[5][5] = {
 		/*INT  INTA  INTB  INTC   INTD */
 		{16+7, 16+7, 16+7, 16+7,  16+7},  /* IdSel 5,  slot ?, ?? */
 		{16+0, 16+0, 16+2, 16+4,  16+9},  /* IdSel 6,  slot ?, ?? */
diff --git a/arch/alpha/kernel/sys_eiger.c b/arch/alpha/kernel/sys_eiger.c
index 15f4208..2731738 100644
--- a/arch/alpha/kernel/sys_eiger.c
+++ b/arch/alpha/kernel/sys_eiger.c
@@ -141,7 +141,7 @@ eiger_init_irq(void)
 	}
 }
 
-static int __init
+static int
 eiger_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	u8 irq_orig;
@@ -158,7 +158,7 @@ eiger_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq_orig - 0x80;
 }
 
-static u8 __init
+static u8
 eiger_swizzle(struct pci_dev *dev, u8 *pinp)
 {
 	struct pci_controller *hose = dev->sysdata;
diff --git a/arch/alpha/kernel/sys_miata.c b/arch/alpha/kernel/sys_miata.c
index d5b9776..731d693f 100644
--- a/arch/alpha/kernel/sys_miata.c
+++ b/arch/alpha/kernel/sys_miata.c
@@ -149,10 +149,10 @@ miata_init_irq(void)
  * comes in on.  This makes interrupt processing much easier.
  */
 
-static int __init
+static int
 miata_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-        static char irq_tab[18][5] __initdata = {
+        static char irq_tab[18][5] = {
 		/*INT    INTA   INTB   INTC   INTD */
 		{16+ 8, 16+ 8, 16+ 8, 16+ 8, 16+ 8},  /* IdSel 14,  DC21142 */
 		{   -1,    -1,    -1,    -1,    -1},  /* IdSel 15,  EIDE    */
@@ -196,7 +196,7 @@ miata_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return COMMON_TABLE_LOOKUP;
 }
 
-static u8 __init
+static u8
 miata_swizzle(struct pci_dev *dev, u8 *pinp)
 {
 	int slot, pin = *pinp;
diff --git a/arch/alpha/kernel/sys_mikasa.c b/arch/alpha/kernel/sys_mikasa.c
index 5e82dc1..350ec9c 100644
--- a/arch/alpha/kernel/sys_mikasa.c
+++ b/arch/alpha/kernel/sys_mikasa.c
@@ -145,10 +145,10 @@ mikasa_init_irq(void)
  * comes in on.  This makes interrupt processing much easier.
  */
 
-static int __init
+static int
 mikasa_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static char irq_tab[8][5] __initdata = {
+	static char irq_tab[8][5] = {
 		/*INT    INTA   INTB   INTC   INTD */
 		{16+12, 16+12, 16+12, 16+12, 16+12},	/* IdSel 17,  SCSI */
 		{   -1,    -1,    -1,    -1,    -1},	/* IdSel 18,  PCEB */
diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
index 8ae04a1..d019e4c 100644
--- a/arch/alpha/kernel/sys_nautilus.c
+++ b/arch/alpha/kernel/sys_nautilus.c
@@ -62,7 +62,7 @@ nautilus_init_irq(void)
 	common_init_isa_dma();
 }
 
-static int __init
+static int
 nautilus_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	/* Preserve the IRQ set up by the console.  */
diff --git a/arch/alpha/kernel/sys_noritake.c b/arch/alpha/kernel/sys_noritake.c
index 063e594..2301678 100644
--- a/arch/alpha/kernel/sys_noritake.c
+++ b/arch/alpha/kernel/sys_noritake.c
@@ -193,10 +193,10 @@ noritake_init_irq(void)
  * comes in on.  This makes interrupt processing much easier.
  */
 
-static int __init
+static int
 noritake_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static char irq_tab[15][5] __initdata = {
+	static char irq_tab[15][5] = {
 		/*INT    INTA   INTB   INTC   INTD */
 		/* note: IDSELs 16, 17, and 25 are CORELLE only */
 		{ 16+1,  16+1,  16+1,  16+1,  16+1},  /* IdSel 16,  QLOGIC */
@@ -221,7 +221,7 @@ noritake_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return COMMON_TABLE_LOOKUP;
 }
 
-static u8 __init
+static u8
 noritake_swizzle(struct pci_dev *dev, u8 *pinp)
 {
 	int slot, pin = *pinp;
diff --git a/arch/alpha/kernel/sys_rawhide.c b/arch/alpha/kernel/sys_rawhide.c
index dfd510a..546822d 100644
--- a/arch/alpha/kernel/sys_rawhide.c
+++ b/arch/alpha/kernel/sys_rawhide.c
@@ -221,10 +221,10 @@ rawhide_init_irq(void)
  * 
  */
 
-static int __init
+static int
 rawhide_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static char irq_tab[5][5] __initdata = {
+	static char irq_tab[5][5] = {
 		/*INT    INTA   INTB   INTC   INTD */
 		{ 16+16, 16+16, 16+16, 16+16, 16+16}, /* IdSel 1 SCSI PCI 1 */
 		{ 16+ 0, 16+ 0, 16+ 1, 16+ 2, 16+ 3}, /* IdSel 2 slot 2 */
diff --git a/arch/alpha/kernel/sys_ruffian.c b/arch/alpha/kernel/sys_ruffian.c
index a3f4852..3b35e19 100644
--- a/arch/alpha/kernel/sys_ruffian.c
+++ b/arch/alpha/kernel/sys_ruffian.c
@@ -117,10 +117,10 @@ ruffian_kill_arch (int mode)
  *
  */
 
-static int __init
+static int
 ruffian_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-        static char irq_tab[11][5] __initdata = {
+        static char irq_tab[11][5] = {
 	      /*INT  INTA INTB INTC INTD */
 		{-1,  -1,  -1,  -1,  -1},  /* IdSel 13,  21052	     */
 		{-1,  -1,  -1,  -1,  -1},  /* IdSel 14,  SIO	     */
@@ -139,7 +139,7 @@ ruffian_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return COMMON_TABLE_LOOKUP;
 }
 
-static u8 __init
+static u8
 ruffian_swizzle(struct pci_dev *dev, u8 *pinp)
 {
 	int slot, pin = *pinp;
diff --git a/arch/alpha/kernel/sys_rx164.c b/arch/alpha/kernel/sys_rx164.c
index 08ee737..e178007 100644
--- a/arch/alpha/kernel/sys_rx164.c
+++ b/arch/alpha/kernel/sys_rx164.c
@@ -142,7 +142,7 @@ rx164_init_irq(void)
  * 
  */
 
-static int __init
+static int
 rx164_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 #if 0
@@ -156,7 +156,7 @@ rx164_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	  { 16+1, 16+1, 16+6, 16+11, 16+16},      /* IdSel 10, slot 4 */
 	};
 #else
-	static char irq_tab[6][5] __initdata = {
+	static char irq_tab[6][5] = {
 	  /*INT   INTA  INTB  INTC   INTD */
 	  { 16+0, 16+0, 16+6, 16+11, 16+16},      /* IdSel 5,  slot 0 */
 	  { 16+1, 16+1, 16+7, 16+12, 16+17},      /* IdSel 6,  slot 1 */
diff --git a/arch/alpha/kernel/sys_sable.c b/arch/alpha/kernel/sys_sable.c
index 8a0aa6d..86d259c 100644
--- a/arch/alpha/kernel/sys_sable.c
+++ b/arch/alpha/kernel/sys_sable.c
@@ -192,10 +192,10 @@ sable_init_irq(void)
  * with the values in the irq swizzling tables above.
  */
 
-static int __init
+static int
 sable_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static char irq_tab[9][5] __initdata = {
+	static char irq_tab[9][5] = {
 		/*INT    INTA   INTB   INTC   INTD */
 		{ 32+0,  32+0,  32+0,  32+0,  32+0},  /* IdSel 0,  TULIP  */
 		{ 32+1,  32+1,  32+1,  32+1,  32+1},  /* IdSel 1,  SCSI   */
@@ -374,10 +374,10 @@ lynx_init_irq(void)
  * with the values in the irq swizzling tables above.
  */
 
-static int __init
+static int
 lynx_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static char irq_tab[19][5] __initdata = {
+	static char irq_tab[19][5] = {
 		/*INT    INTA   INTB   INTC   INTD */
 		{   -1,    -1,    -1,    -1,    -1},  /* IdSel 13,  PCEB   */
 		{   -1,    -1,    -1,    -1,    -1},  /* IdSel 14,  PPB    */
@@ -404,7 +404,7 @@ lynx_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return COMMON_TABLE_LOOKUP;
 }
 
-static u8 __init
+static u8
 lynx_swizzle(struct pci_dev *dev, u8 *pinp)
 {
 	int slot, pin = *pinp;
diff --git a/arch/alpha/kernel/sys_sio.c b/arch/alpha/kernel/sys_sio.c
index febd24e..9fd2895 100644
--- a/arch/alpha/kernel/sys_sio.c
+++ b/arch/alpha/kernel/sys_sio.c
@@ -144,7 +144,7 @@ sio_fixup_irq_levels(unsigned int level_bits)
 	outb((level_bits >> 8) & 0xff, 0x4d1);
 }
 
-static inline int __init
+static inline int
 noname_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	/*
@@ -165,7 +165,7 @@ noname_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	 * that they use the default INTA line, if they are interrupt
 	 * driven at all).
 	 */
-	static char irq_tab[][5] __initdata = {
+	static char irq_tab[][5] = {
 		/*INT A   B   C   D */
 		{ 3,  3,  3,  3,  3}, /* idsel  6 (53c810) */ 
 		{-1, -1, -1, -1, -1}, /* idsel  7 (SIO: PCI/ISA bridge) */
@@ -183,10 +183,10 @@ noname_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq >= 0 ? tmp : -1;
 }
 
-static inline int __init
+static inline int
 p2k_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static char irq_tab[][5] __initdata = {
+	static char irq_tab[][5] = {
 		/*INT A   B   C   D */
 		{ 0,  0, -1, -1, -1}, /* idsel  6 (53c810) */
 		{-1, -1, -1, -1, -1}, /* idsel  7 (SIO: PCI/ISA bridge) */
diff --git a/arch/alpha/kernel/sys_sx164.c b/arch/alpha/kernel/sys_sx164.c
index d063b36..23eee54 100644
--- a/arch/alpha/kernel/sys_sx164.c
+++ b/arch/alpha/kernel/sys_sx164.c
@@ -94,10 +94,10 @@ sx164_init_irq(void)
  *   9  32 bit PCI option slot 3
  */
 
-static int __init
+static int
 sx164_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static char irq_tab[5][5] __initdata = {
+	static char irq_tab[5][5] = {
 		/*INT    INTA   INTB   INTC   INTD */
 		{ 16+ 9, 16+ 9, 16+13, 16+17, 16+21}, /* IdSel 5 slot 2 J17 */
 		{ 16+11, 16+11, 16+15, 16+19, 16+23}, /* IdSel 6 slot 0 J19 */
diff --git a/arch/alpha/kernel/sys_takara.c b/arch/alpha/kernel/sys_takara.c
index dd0f1ea..9101f2b 100644
--- a/arch/alpha/kernel/sys_takara.c
+++ b/arch/alpha/kernel/sys_takara.c
@@ -155,10 +155,10 @@ takara_init_irq(void)
  * assign it whatever the hell IRQ we like and it doesn't matter.
  */
 
-static int __init
+static int
 takara_map_irq_srm(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static char irq_tab[15][5] __initdata = {
+	static char irq_tab[15][5] = {
 		{ 16+3, 16+3, 16+3, 16+3, 16+3},   /* slot  6 == device 3 */
 		{ 16+2, 16+2, 16+2, 16+2, 16+2},   /* slot  7 == device 2 */
 		{ 16+1, 16+1, 16+1, 16+1, 16+1},   /* slot  8 == device 1 */
@@ -210,7 +210,7 @@ takara_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return COMMON_TABLE_LOOKUP;
 }
 
-static u8 __init
+static u8
 takara_swizzle(struct pci_dev *dev, u8 *pinp)
 {
 	int slot = PCI_SLOT(dev->devfn);
diff --git a/arch/alpha/kernel/sys_wildfire.c b/arch/alpha/kernel/sys_wildfire.c
index ee18748..c3f8b79 100644
--- a/arch/alpha/kernel/sys_wildfire.c
+++ b/arch/alpha/kernel/sys_wildfire.c
@@ -288,10 +288,10 @@ wildfire_device_interrupt(unsigned long vector)
  *   7	 64 bit PCI 1 option slot 7
  */
 
-static int __init
+static int
 wildfire_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static char irq_tab[8][5] __initdata = {
+	static char irq_tab[8][5] = {
 		/*INT    INTA   INTB   INTC   INTD */
 		{ -1,    -1,    -1,    -1,    -1}, /* IdSel 0 ISA Bridge */
 		{ 36,    36,    36+1, 36+2, 36+3}, /* IdSel 1 SCSI builtin */
-- 
2.4.12
