Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751978AbdGaQgW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jul 2017 12:36:22 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Minter <matt@masarand.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFT PATCH 5/9] MIPS/PCI: Replace pci_fixup_irqs() call with PCI host bridge IRQ mapping hooks
Date: Mon, 31 Jul 2017 17:37:53 +0100
Message-Id: <20170731163757.22629-6-lorenzo.pieralisi@arm.com>
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
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/pci/pci-legacy.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index 71d62f8..fc77260 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -78,6 +78,12 @@ static void pcibios_scanbus(struct pci_controller *hose)
 	static int need_domain_info;
 	LIST_HEAD(resources);
 	struct pci_bus *bus;
+	struct pci_host_bridge *bridge;
+	int ret;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return;
 
 	if (hose->get_busno && pci_has_flag(PCI_PROBE_ONLY))
 		next_busno = (*hose->get_busno)();
@@ -87,14 +93,20 @@ static void pcibios_scanbus(struct pci_controller *hose)
 	pci_add_resource_offset(&resources,
 				hose->io_resource, hose->io_offset);
 	pci_add_resource(&resources, hose->busn_resource);
-	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
-				&resources);
-	if (!bus) {
-		pci_free_resource_list(&resources);
+	list_splice_init(&resources, &bridge->windows);
+	bridge->dev.parent = NULL;
+	bridge->sysdata = hose;
+	bridge->busnr = next_busno;
+	bridge->ops = hose->pci_ops;
+	bridge->swizzle_irq = pci_common_swizzle;
+	bridge->map_irq = pcibios_map_irq;
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret) {
+		pci_free_host_bridge(bridge);
 		return;
 	}
 
-	hose->bus = bus;
+	hose->bus = bus = bridge->bus;
 
 	need_domain_info = need_domain_info || pci_domain_nr(bus);
 	set_pci_need_domain_info(hose, need_domain_info);
@@ -224,8 +236,6 @@ static int __init pcibios_init(void)
 	list_for_each_entry(hose, &controllers, list)
 		pcibios_scanbus(hose);
 
-	pci_fixup_irqs(pci_common_swizzle, pcibios_map_irq);
-
 	pci_initialized = 1;
 
 	return 0;
-- 
2.10.0
