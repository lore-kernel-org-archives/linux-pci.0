Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751978AbdGaQgT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jul 2017 12:36:19 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Minter <matt@masarand.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFT PATCH 4/9] m68k/PCI: Replace pci_fixup_irqs() call with PCI host bridge IRQ mapping hooks
Date: Mon, 31 Jul 2017 17:37:52 +0100
Message-Id: <20170731163757.22629-5-lorenzo.pieralisi@arm.com>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/coldfire/pci.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/coldfire/pci.c b/arch/m68k/coldfire/pci.c
index 6a640be..3097fa2 100644
--- a/arch/m68k/coldfire/pci.c
+++ b/arch/m68k/coldfire/pci.c
@@ -243,6 +243,13 @@ static struct resource mcf_pci_io = {
 	.flags	= IORESOURCE_IO,
 };
 
+static struct resource busn_resource = {
+	.name	= "PCI busn",
+	.start	= 0,
+	.end	= 255,
+	.flags	= IORESOURCE_BUS,
+};
+
 /*
  * Interrupt mapping and setting.
  */
@@ -258,6 +265,13 @@ static int mcf_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 static int __init mcf_pci_init(void)
 {
+	struct pci_host_bridge *bridge;
+	int ret;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return -ENOMEM;
+
 	pr_info("ColdFire: PCI bus initialization...\n");
 
 	/* Reset the external PCI bus */
@@ -312,14 +326,28 @@ static int __init mcf_pci_init(void)
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(msecs_to_jiffies(200));
 
-	rootbus = pci_scan_bus(0, &mcf_pci_ops, NULL);
-	if (!rootbus)
-		return -ENODEV;
+
+	pci_add_resource(&bridge->windows, &ioport_resource);
+	pci_add_resource(&bridge->windows, &iomem_resource);
+	pci_add_resource(&bridge->windows, &busn_resource);
+	bridge->dev.parent = NULL;
+	bridge->sysdata = NULL;
+	bridge->busnr = 0;
+	bridge->ops = &mcf_pci_ops;
+	bridge->swizzle_irq = pci_common_swizzle;
+	bridge->map_irq = mcf_pci_map_irq;
+
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret) {
+		pci_free_host_bridge(bridge);
+		return ret;
+	}
+
+	rootbus = bridge->bus;
 
 	rootbus->resource[0] = &mcf_pci_io;
 	rootbus->resource[1] = &mcf_pci_mem;
 
-	pci_fixup_irqs(pci_common_swizzle, mcf_pci_map_irq);
 	pci_bus_size_bridges(rootbus);
 	pci_bus_assign_resources(rootbus);
 	pci_bus_add_devices(rootbus);
-- 
2.10.0
