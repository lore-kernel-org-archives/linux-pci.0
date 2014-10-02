Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([69.164.217.139]:56363 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752383AbaJBEIH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Oct 2014 00:08:07 -0400
From: matt@masarand.com
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Matthew Minter <matt@masarand.com>
Subject: [PATCH 14/18] Delayed tile setup of PCI IRQs to bus scan time
Date: Thu,  2 Oct 2014 05:07:42 +0100
Message-Id: <1412222866-21068-15-git-send-email-matt@masarand.com>
In-Reply-To: <1412222866-21068-1-git-send-email-matt@masarand.com>
References: <1412222866-21068-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Matthew Minter <matt@masarand.com>

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
index 1f80a88..6dc0bd8 100644
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
@@ -367,6 +364,13 @@ int __init pcibios_init(void)
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
index e39f9c5..7d1b5bf 100644
--- a/arch/tile/kernel/pci_gx.c
+++ b/arch/tile/kernel/pci_gx.c
@@ -893,9 +893,6 @@ int __init pcibios_init(void)
 		next_busno = bus->busn_res.end + 1;
 	}
 
-	/* Do machine dependent PCI interrupt routing */
-	pci_fixup_irqs(pci_common_swizzle, tile_map_irq);
-
 	/*
 	 * This comes from the generic Linux PCI driver.
 	 *
@@ -1048,6 +1045,13 @@ alloc_mem_map_failed:
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
2.1.0

