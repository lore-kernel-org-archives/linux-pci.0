Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36236 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbbJWFFz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:05:55 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 13/29] sh/PCI: Defer IRQ assignment to device enable time
Date: Fri, 23 Oct 2015 06:03:46 +0100
Message-Id: <1445576642-29624-14-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently platform specific PCI device IRQ assignment is run during
the boot code, this results in a wide array of differing code paths
and causes hot-plugged PCI devices to not be assigned IRQs, this
patch removes the boot time initialisation of such IRQs and instead
registers assignment functions to be run during the PCI device enable
path.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 arch/sh/drivers/pci/pci.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index d5462b7..28f8c90 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -144,16 +144,20 @@ static int __init pcibios_init(void)
 	for (hose = hose_head; hose; hose = hose->next)
 		pcibios_scanbus(hose);
 
-	pci_fixup_irqs(pci_common_swizzle, pcibios_map_platform_irq);
-
 	dma_debug_add_bus(&pci_bus_type);
-
 	pci_initialized = 1;
 
 	return 0;
 }
 subsys_initcall(pcibios_init);
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->swizzle_irq = pci_common_swizzle;
+	bridge->map_irq = pcibios_map_platform_irq;
+	return 0;
+}
+
 /*
  *  Called after each bus is probed, but before its children
  *  are examined.
-- 
2.6.2

