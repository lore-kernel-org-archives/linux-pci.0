Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([69.164.217.139]:56323 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbaJBD7Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Oct 2014 23:59:24 -0400
From: matt@masarand.com
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Vality <matt@masarand.com>
Subject: [PATCH 06/18] Delayed alpha setup of PCI IRQs to bus scan time
Date: Thu,  2 Oct 2014 04:50:25 +0100
Message-Id: <1412221837-17452-7-git-send-email-matt@masarand.com>
In-Reply-To: <1412221837-17452-1-git-send-email-matt@masarand.com>
References: <1412221837-17452-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Vality <matt@masarand.com>

PCI IRQ initialisation is currently run during the boot code on alpha,
this has the issue that firstly an extra pass over the PCI bus is
required and second hot-plugged devices which are added after boot have
no way to be assigned an IRQ. This patch set fixes this by defering the
assignment of PCI IRQs untill device enable time which should solve
both of these issues.

---
 arch/alpha/kernel/pci.c          | 16 ++++++++++------
 arch/alpha/kernel/sys_nautilus.c |  1 -
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 076c35c..338537c 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -28,7 +28,7 @@
 
 
 /*
- * Some string constants used by the various core logics. 
+ * Some string constants used by the various core logics.
  */
 
 const char *const pci_io_names[] = {
@@ -247,7 +247,7 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 	if (pci_has_flag(PCI_PROBE_ONLY) && dev &&
  		   (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
  		pci_read_bridge_bases(bus);
-	} 
+	}
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		pdev_save_srm_config(dev);
@@ -338,7 +338,7 @@ common_init_pci(void)
 		hose->need_domain_info = need_domain_info;
 		next_busno = bus->busn_res.end + 1;
 		/* Don't allow 8-bit bus number overflow inside the hose -
-		   reserve some space for bridges. */ 
+		   reserve some space for bridges. */
 		if (next_busno > 224) {
 			next_busno = 0;
 			need_domain_info = 1;
@@ -346,11 +346,15 @@ common_init_pci(void)
 	}
 
 	pcibios_claim_console_setup();
-
 	pci_assign_unassigned_resources();
-	pci_fixup_irqs(alpha_mv.pci_swizzle, alpha_mv.pci_map_irq);
 }
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->swizzle_irq = alpha_mv.pci_swizzle;
+	bridge->map_irq = alpha_mv.pci_map_irq;
+	return 0;
+}
 
 struct pci_controller * __init
 alloc_pci_controller(void)
@@ -387,7 +391,7 @@ sys_pciconfig_iobase(long which, unsigned long bus, unsigned long dfn)
 
 	/* from hose or from bus.devfn */
 	if (which & IOBASE_FROM_HOSE) {
-		for(hose = hose_head; hose; hose = hose->next) 
+		for(hose = hose_head; hose; hose = hose->next)
 			if (hose->index == bus) break;
 		if (!hose) return -ENODEV;
 	} else {
diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
index 837c0fa..7fb4d51 100644
--- a/arch/alpha/kernel/sys_nautilus.c
+++ b/arch/alpha/kernel/sys_nautilus.c
@@ -252,7 +252,6 @@ nautilus_init_pci(void)
 	/* pci_common_swizzle() relies on bus->self being NULL
 	   for the root bus, so just clear it. */
 	bus->self = NULL;
-	pci_fixup_irqs(alpha_mv.pci_swizzle, alpha_mv.pci_map_irq);
 }
 
 /*
-- 
2.1.0

