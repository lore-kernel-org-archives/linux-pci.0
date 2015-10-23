Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36239 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbbJWFF4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:05:56 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 14/29] alpha/PCI: Defer IRQ assignment to device enable time
Date: Fri, 23 Oct 2015 06:03:47 +0100
Message-Id: <1445576642-29624-15-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI IRQ initialisation is currently run during the boot code on alpha,
this has the issue that firstly an extra pass over the PCI bus is
required and second hot-plugged devices which are added after boot have
no way to be assigned an IRQ. This patch set fixes this by defering the
assignment of PCI IRQs untill device enable time which should solve
both of these issues.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 arch/alpha/kernel/pci.c          | 7 ++++++-
 arch/alpha/kernel/sys_nautilus.c | 1 -
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 5f387ee..1c3c513 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -354,7 +354,6 @@ common_init_pci(void)
 	pcibios_claim_console_setup();
 
 	pci_assign_unassigned_resources();
-	pci_fixup_irqs(alpha_mv.pci_swizzle, alpha_mv.pci_map_irq);
 	for (hose = hose_head; hose; hose = hose->next) {
 		bus = hose->bus;
 		if (bus)
@@ -362,6 +361,12 @@ common_init_pci(void)
 	}
 }
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->swizzle_irq = alpha_mv.pci_swizzle;
+	bridge->map_irq = alpha_mv.pci_map_irq;
+	return 0;
+}
 
 struct pci_controller * __init
 alloc_pci_controller(void)
diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
index 2cfaa0e..a3086dc 100644
--- a/arch/alpha/kernel/sys_nautilus.c
+++ b/arch/alpha/kernel/sys_nautilus.c
@@ -254,7 +254,6 @@ nautilus_init_pci(void)
 	/* pci_common_swizzle() relies on bus->self being NULL
 	   for the root bus, so just clear it. */
 	bus->self = NULL;
-	pci_fixup_irqs(alpha_mv.pci_swizzle, alpha_mv.pci_map_irq);
 	pci_bus_add_devices(bus);
 }
 
-- 
2.6.2

