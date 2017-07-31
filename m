Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Minter <matt@masarand.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFT PATCH 6/9] tile/PCI: Replace pci_fixup_irqs() call with PCI host bridge IRQ mapping hooks
Date: Mon, 31 Jul 2017 17:37:54 +0100
Message-Id: <20170731163757.22629-7-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170731163757.22629-1-lorenzo.pieralisi@arm.com>
References: <20170731163757.22629-1-lorenzo.pieralisi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
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
pci_host_bridge with initializedmap/swizzle pointers) and remove the
pci_fixup_irqs() call from arch code.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
---
 arch/tile/kernel/pci.c    | 21 ++++++++++++++++-----
 arch/tile/kernel/pci_gx.c | 21 ++++++++++++++++-----
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/arch/tile/kernel/pci.c b/arch/tile/kernel/pci.c
index bc6656b..8848261 100644
--- a/arch/tile/kernel/pci.c
+++ b/arch/tile/kernel/pci.c
@@ -274,6 +274,7 @@ static void fixup_read_and_payload_sizes(void)
  */
 int __init pcibios_init(void)
 {
+	struct pci_host_bridge *bridge;
 	int i;
 
 	pr_info("PCI: Probing PCI hardware\n");
@@ -306,16 +307,26 @@ int __init pcibios_init(void)
 
 			pci_add_resource(&resources, &ioport_resource);
 			pci_add_resource(&resources, &iomem_resource);
-			bus = pci_scan_root_bus(NULL, 0, controller->ops,
-						controller, &resources);
+
+			bridge = pci_alloc_host_bridge(0);
+			if (!bridge)
+				break;
+
+			list_splice_init(&resources, &bridge->windows);
+			bridge->dev.parent = NULL;
+			bridge->sysdata = controller;
+			bridge->busnr = 0;
+			bridge->ops = controller->ops;
+			bridge->swizzle_irq = pci_common_swizzle;
+			bridge->map_irq = tile_map_irq;
+
+			pci_scan_root_bus_bridge(bridge);
+			bus = bridge->bus;
 			controller->root_bus = bus;
 			controller->last_busno = bus->busn_res.end;
 		}
 	}
 
-	/* Do machine dependent PCI interrupt routing */
-	pci_fixup_irqs(pci_common_swizzle, tile_map_irq);
-
 	/*
 	 * This comes from the generic Linux PCI driver.
 	 *
diff --git a/arch/tile/kernel/pci_gx.c b/arch/tile/kernel/pci_gx.c
index b554a68..e683170 100644
--- a/arch/tile/kernel/pci_gx.c
+++ b/arch/tile/kernel/pci_gx.c
@@ -669,6 +669,7 @@ int __init pcibios_init(void)
 	resource_size_t offset;
 	LIST_HEAD(resources);
 	int next_busno;
+	struct pci_host_bridge *bridge;
 	int i;
 
 	tile_pci_init();
@@ -881,15 +882,25 @@ int __init pcibios_init(void)
 					controller->mem_offset);
 		pci_add_resource(&resources, &controller->io_space);
 		controller->first_busno = next_busno;
-		bus = pci_scan_root_bus(NULL, next_busno, controller->ops,
-					controller, &resources);
+
+		bridge = pci_alloc_host_bridge(0);
+		if (!bridge)
+			break;
+
+		list_splice_init(&resources, &bridge->windows);
+		bridge->dev.parent = NULL;
+		bridge->sysdata = controller;
+		bridge->busnr = next_busno;
+		bridge->ops = controller->ops;
+		bridge->swizzle_irq = pci_common_swizzle;
+		bridge->map_irq = tile_map_irq;
+
+		pci_scan_root_bus_bridge(bridge);
+		bus = bridge->bus;
 		controller->root_bus = bus;
 		next_busno = bus->busn_res.end + 1;
 	}
 
-	/* Do machine dependent PCI interrupt routing */
-	pci_fixup_irqs(pci_common_swizzle, tile_map_irq);
-
 	/*
 	 * This comes from the generic Linux PCI driver.
 	 *
-- 
2.10.0
