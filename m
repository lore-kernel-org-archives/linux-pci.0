Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36274 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbbJWFGF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:06:05 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 23/29] tile: pci: Defer IRQ assignment to device enable time
Date: Fri, 23 Oct 2015 06:03:56 +0100
Message-Id: <1445576642-29624-24-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently pcibios_init is running pci_fixup_irqs in order to assign
IRQs to PCI devices, this is only done once at boot-time and causes
devices hot-plugged after boot time to not be allocated an IRQ.
This is fixed in this patch-set by delaying the allocation untill
device enable time by registering the function to be called later.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 arch/tile/kernel/pci.c    | 10 +++++++---
 arch/tile/kernel/pci_gx.c | 10 +++++++---
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/tile/kernel/pci.c b/arch/tile/kernel/pci.c
index 9475a74..e151d80 100644
--- a/arch/tile/kernel/pci.c
+++ b/arch/tile/kernel/pci.c
@@ -313,9 +313,6 @@ int __init pcibios_init(void)
 		}
 	}
 
-	/* Do machine dependent PCI interrupt routing */
-	pci_fixup_irqs(pci_common_swizzle, tile_map_irq);
-
 	/*
 	 * This comes from the generic Linux PCI driver.
 	 *
@@ -369,6 +366,13 @@ int __init pcibios_init(void)
 }
 subsys_initcall(pcibios_init);
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->swizzle_irq = pci_common_swizzle;
+	bridge->map_irq = tile_map_irq;
+	return 0;
+}
+
 /*
  * No bus fixups needed.
  */
diff --git a/arch/tile/kernel/pci_gx.c b/arch/tile/kernel/pci_gx.c
index 4c017d0..7eb3e2b 100644
--- a/arch/tile/kernel/pci_gx.c
+++ b/arch/tile/kernel/pci_gx.c
@@ -887,9 +887,6 @@ int __init pcibios_init(void)
 		next_busno = bus->busn_res.end + 1;
 	}
 
-	/* Do machine dependent PCI interrupt routing */
-	pci_fixup_irqs(pci_common_swizzle, tile_map_irq);
-
 	/*
 	 * This comes from the generic Linux PCI driver.
 	 *
@@ -1038,6 +1035,13 @@ alloc_mem_map_failed:
 }
 subsys_initcall(pcibios_init);
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->swizzle_irq = pci_common_swizzle;
+	bridge->map_irq = tile_map_irq;
+	return 0;
+}
+
 /* No bus fixups needed. */
 void pcibios_fixup_bus(struct pci_bus *bus)
 {
-- 
2.6.2

