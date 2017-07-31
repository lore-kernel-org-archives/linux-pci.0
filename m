Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751978AbdGaQgQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jul 2017 12:36:16 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Minter <matt@masarand.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFT PATCH 3/9] alpha/PCI: Replace pci_fixup_irqs() call with PCI host bridge IRQ mapping hooks
Date: Mon, 31 Jul 2017 17:37:51 +0100
Message-Id: <20170731163757.22629-4-lorenzo.pieralisi@arm.com>
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
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
---
 arch/alpha/kernel/pci.c          | 27 ++++++++++++++++++++-------
 arch/alpha/kernel/sys_nautilus.c | 31 +++++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 5f387ee..d558287 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -312,8 +312,9 @@ common_init_pci(void)
 {
 	struct pci_controller *hose;
 	struct list_head resources;
+	struct pci_host_bridge *bridge;
 	struct pci_bus *bus;
-	int next_busno;
+	int ret, next_busno;
 	int need_domain_info = 0;
 	u32 pci_mem_end;
 	u32 sg_base;
@@ -336,11 +337,25 @@ common_init_pci(void)
 		pci_add_resource_offset(&resources, hose->mem_space,
 					hose->mem_space->start);
 
-		bus = pci_scan_root_bus(NULL, next_busno, alpha_mv.pci_ops,
-					hose, &resources);
-		if (!bus)
+		bridge = pci_alloc_host_bridge(0);
+		if (!bridge)
 			continue;
-		hose->bus = bus;
+
+		list_splice_init(&resources, &bridge->windows);
+		bridge->dev.parent = NULL;
+		bridge->sysdata = hose;
+		bridge->busnr = next_busno;
+		bridge->ops = alpha_mv.pci_ops;
+		bridge->swizzle_irq = alpha_mv.pci_swizzle;
+		bridge->map_irq = alpha_mv.pci_map_irq;
+
+		ret = pci_scan_root_bus_bridge(bridge);
+		if (ret) {
+			pci_free_host_bridge(bridge);
+			continue;
+		}
+
+		bus = hose->bus = bridge->bus;
 		hose->need_domain_info = need_domain_info;
 		next_busno = bus->busn_res.end + 1;
 		/* Don't allow 8-bit bus number overflow inside the hose -
@@ -354,7 +369,6 @@ common_init_pci(void)
 	pcibios_claim_console_setup();
 
 	pci_assign_unassigned_resources();
-	pci_fixup_irqs(alpha_mv.pci_swizzle, alpha_mv.pci_map_irq);
 	for (hose = hose_head; hose; hose = hose->next) {
 		bus = hose->bus;
 		if (bus)
@@ -362,7 +376,6 @@ common_init_pci(void)
 	}
 }
 
-
 struct pci_controller * __init
 alloc_pci_controller(void)
 {
diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
index 2cfaa0e..8ae04a1 100644
--- a/arch/alpha/kernel/sys_nautilus.c
+++ b/arch/alpha/kernel/sys_nautilus.c
@@ -194,22 +194,46 @@ static struct resource irongate_mem = {
 	.name	= "Irongate PCI MEM",
 	.flags	= IORESOURCE_MEM,
 };
+static struct resource busn_resource = {
+	.name	= "PCI busn",
+	.start	= 0,
+	.end	= 255,
+	.flags	= IORESOURCE_BUS,
+};
 
 void __init
 nautilus_init_pci(void)
 {
 	struct pci_controller *hose = hose_head;
+	struct pci_host_bridge *bridge;
 	struct pci_bus *bus;
 	struct pci_dev *irongate;
 	unsigned long bus_align, bus_size, pci_mem;
 	unsigned long memtop = max_low_pfn << PAGE_SHIFT;
+	int ret;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return;
+
+	pci_add_resource(&bridge->windows, &ioport_resource);
+	pci_add_resource(&bridge->windows, &iomem_resource);
+	pci_add_resource(&bridge->windows, &busn_resource);
+	bridge->dev.parent = NULL;
+	bridge->sysdata = hose;
+	bridge->busnr = 0;
+	bridge->ops = alpha_mv.pci_ops;
+	bridge->swizzle_irq = alpha_mv.pci_swizzle;
+	bridge->map_irq = alpha_mv.pci_map_irq;
 
 	/* Scan our single hose.  */
-	bus = pci_scan_bus(0, alpha_mv.pci_ops, hose);
-	if (!bus)
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret) {
+		pci_free_host_bridge(bridge);
 		return;
+	}
 
-	hose->bus = bus;
+	bus = hose->bus = bridge->bus;
 	pcibios_claim_one_bus(bus);
 
 	irongate = pci_get_bus_and_slot(0, 0);
@@ -254,7 +278,6 @@ nautilus_init_pci(void)
 	/* pci_common_swizzle() relies on bus->self being NULL
 	   for the root bus, so just clear it. */
 	bus->self = NULL;
-	pci_fixup_irqs(alpha_mv.pci_swizzle, alpha_mv.pci_map_irq);
 	pci_bus_add_devices(bus);
 }
 
-- 
2.10.0
