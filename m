Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36254 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbbJWFF7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:05:59 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 17/29] m68k/pci: Defer IRQ assignment to device enable time
Date: Fri, 23 Oct 2015 06:03:50 +0100
Message-Id: <1445576642-29624-18-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently PCI IRQs are assigned during mcf_pci_init which is only run
at boot time, this causes devices which are connected after boot time
to not receive an IRQ, this patch set fixes this by registering an IRQ
assignment function to be run later at device enable time.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 arch/m68k/coldfire/pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/coldfire/pci.c b/arch/m68k/coldfire/pci.c
index 821de92..86661cd 100644
--- a/arch/m68k/coldfire/pci.c
+++ b/arch/m68k/coldfire/pci.c
@@ -319,11 +319,17 @@ static int __init mcf_pci_init(void)
 	rootbus->resource[0] = &mcf_pci_io;
 	rootbus->resource[1] = &mcf_pci_mem;
 
-	pci_fixup_irqs(pci_common_swizzle, mcf_pci_map_irq);
 	pci_bus_size_bridges(rootbus);
 	pci_bus_assign_resources(rootbus);
 	pci_bus_add_devices(rootbus);
 	return 0;
 }
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->swizzle_irq = pci_common_swizzle;
+	bridge->map_irq = mcf_pci_map_irq;
+	return 0;
+}
+
 subsys_initcall(mcf_pci_init);
-- 
2.6.2

