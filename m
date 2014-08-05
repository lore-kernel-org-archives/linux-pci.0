Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:38124 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755138AbaHEQML (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Aug 2014 12:12:11 -0400
Received: by mail-we0-f175.google.com with SMTP id t60so1235361wes.6
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2014 09:12:09 -0700 (PDT)
From: matthew_minter@xyratex.com
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: matthew_minter <matthew_minter@xyratex.com>
Subject: [PATCH 16/22] Added (untested) support to tile architecture to accomodate new irq init code
Date: Tue,  5 Aug 2014 17:11:17 +0100
Message-Id: <1407255083-9356-17-git-send-email-matthew_minter@xyratex.com>
In-Reply-To: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
References: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: matthew_minter <matthew_minter@xyratex.com>

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
2.0.4

