Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55082 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752281AbdGaQgN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jul 2017 12:36:13 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rich Felker <dalias@libc.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Minter <matt@masarand.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFT PATCH 2/9] sh/PCI: Replace pci_fixup_irqs() call with PCI host bridge IRQ mapping hooks
Date: Mon, 31 Jul 2017 17:37:50 +0100
Message-Id: <20170731163757.22629-3-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170731163757.22629-1-lorenzo.pieralisi@arm.com>
References: <20170731163757.22629-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pci_fixup_irqs() function allocates IRQs for all PCI devices present
in a system; those PCI devices possibly belong to different PCI bus
trees (and possibly rooted at different host bridges) and may well be
enabled (ie probed and bound to a driver) by the time pci_fixup_irqs()
is called when probing a given host bridge driver.

Furthermore, current kernel code relying on pci_fixup_irqs() to assign
legacy PCI IRQs to devices does not work at all for hotplugged devices
in that the code carrying out the IRQ fixup is called at host bridge
driver probe time, which just cannot take into account devices
hotplugged after system has booted.

The introduction of map/swizzle functions hook in struct pci_host_bridge
allows to define per-bridge map/swizzle functions, that can be used at
device probe time in PCI core code to allocate IRQs for a given device
(through pci_assign_irq()).

Convert PCI host bridge initialization code to the
pci_scan_root_bus_bridge() API (that allows to pass a struct
pci_host_bridge with initialized map/swizzle pointers) and remove the
pci_fixup_irqs() call from arch code.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rich Felker <dalias@libc.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/drivers/pci/pci.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index c99ee28..357278c 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -39,8 +39,12 @@ static void pcibios_scanbus(struct pci_channel *hose)
 	LIST_HEAD(resources);
 	struct resource *res;
 	resource_size_t offset;
-	int i;
-	struct pci_bus *bus;
+	int i, ret;
+	struct pci_host_bridge *bridge;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return;
 
 	for (i = 0; i < hose->nr_resources; i++) {
 		res = hose->resources + i;
@@ -52,19 +56,26 @@ static void pcibios_scanbus(struct pci_channel *hose)
 		pci_add_resource_offset(&resources, res, offset);
 	}
 
-	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
-				&resources);
-	hose->bus = bus;
+	list_splice_init(&resources, &bridge->windows);
+	bridge->dev.parent = NULL;
+	bridge->sysdata = hose;
+	bridge->busnr = next_busno;
+	bridge->ops = hose->pci_ops;
+	bridge->swizzle_irq = pci_common_swizzle;
+	bridge->map_irq = pcibios_map_platform_irq;
+
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret) {
+		pci_free_host_bridge(bridge);
+		return;
+	}
+
+	hose->bus = bridge->bus;
 
 	need_domain_info = need_domain_info || hose->index;
 	hose->need_domain_info = need_domain_info;
 
-	if (!bus) {
-		pci_free_resource_list(&resources);
-		return;
-	}
-
-	next_busno = bus->busn_res.end + 1;
+	next_busno = hose->bus->busn_res.end + 1;
 	/* Don't allow 8-bit bus number overflow inside the hose -
 	   reserve some space for bridges. */
 	if (next_busno > 224) {
@@ -72,9 +83,9 @@ static void pcibios_scanbus(struct pci_channel *hose)
 		need_domain_info = 1;
 	}
 
-	pci_bus_size_bridges(bus);
-	pci_bus_assign_resources(bus);
-	pci_bus_add_devices(bus);
+	pci_bus_size_bridges(hose->bus);
+	pci_bus_assign_resources(hose->bus);
+	pci_bus_add_devices(hose->bus);
 }
 
 /*
@@ -144,8 +155,6 @@ static int __init pcibios_init(void)
 	for (hose = hose_head; hose; hose = hose->next)
 		pcibios_scanbus(hose);
 
-	pci_fixup_irqs(pci_common_swizzle, pcibios_map_platform_irq);
-
 	dma_debug_add_bus(&pci_bus_type);
 
 	pci_initialized = 1;
-- 
2.10.0
