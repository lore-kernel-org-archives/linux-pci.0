Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([69.164.217.139]:56348 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752383AbaJBEIE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Oct 2014 00:08:04 -0400
From: matt@masarand.com
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Matthew Minter <matt@masarand.com>
Subject: [PATCH 09/18] Delayed m68k setup of PCI IRQs to bus scan time
Date: Thu,  2 Oct 2014 05:07:37 +0100
Message-Id: <1412222866-21068-10-git-send-email-matt@masarand.com>
In-Reply-To: <1412222866-21068-1-git-send-email-matt@masarand.com>
References: <1412222866-21068-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Matthew Minter <matt@masarand.com>

Currently PCI IRQs are assigned during mcf_pci_init which is only run
at boot time, this causes devices which are connected after boot time
to not receive an IRQ, this patch set fixes this by registering an IRQ
assignment function to be run later at device enable time.

Signed-off-by: Matthew Minter <matt@masarand.com>

---
 arch/m68k/platform/coldfire/pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/platform/coldfire/pci.c b/arch/m68k/platform/coldfire/pci.c
index df96792..058ca86 100644
--- a/arch/m68k/platform/coldfire/pci.c
+++ b/arch/m68k/platform/coldfire/pci.c
@@ -316,10 +316,16 @@ static int __init mcf_pci_init(void)
 	rootbus->resource[0] = &mcf_pci_io;
 	rootbus->resource[1] = &mcf_pci_mem;
 
-	pci_fixup_irqs(pci_common_swizzle, mcf_pci_map_irq);
 	pci_bus_size_bridges(rootbus);
 	pci_bus_assign_resources(rootbus);
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
2.1.0

