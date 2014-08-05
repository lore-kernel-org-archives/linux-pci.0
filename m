Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:52914 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005AbaHEQMJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Aug 2014 12:12:09 -0400
Received: by mail-wi0-f180.google.com with SMTP id n3so1629063wiv.13
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2014 09:12:07 -0700 (PDT)
From: matthew_minter@xyratex.com
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: matthew_minter <matthew_minter@xyratex.com>
Subject: [PATCH 14/22] Added (untested) support to alpha architecture to accomodate new irq init code
Date: Tue,  5 Aug 2014 17:11:15 +0100
Message-Id: <1407255083-9356-15-git-send-email-matthew_minter@xyratex.com>
In-Reply-To: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
References: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: matthew_minter <matthew_minter@xyratex.com>

---
 arch/alpha/kernel/pci.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

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
-- 
2.0.4

