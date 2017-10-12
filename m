Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14421 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbdJLSwW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2017 14:52:22 -0400
From: Vidya Sagar <vidyas@nvidia.com>
To: <treding@nvidia.com>, <bhelgaas@google.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH 1/6] PCI: tegra: refactor config space mapping code
Date: Fri, 13 Oct 2017 00:20:06 +0530
Message-ID: <1507834211-24922-2-git-send-email-vidyas@nvidia.com>
In-Reply-To: <1507834211-24922-1-git-send-email-vidyas@nvidia.com>
References: <1507834211-24922-1-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

use only 4K space from available 1GB PCIe aperture to access
end points configuration space by dynamically moving AFI_AXI_BAR
base address and always making sure that the desired location
to be accessed for generating required config space access falls
in the 4K space reserved for this purpose. This would give more
space for mapping end point device's BARs on some of Tegra platforms

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 85 ++++++++++++--------------------------------
 1 file changed, 23 insertions(+), 62 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 9c40da54f88a..ebdcfca10e17 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -269,6 +269,8 @@ struct tegra_pcie {
 	struct list_head buses;
 	struct resource *cs;
 
+	void __iomem *cfg_va_base;
+
 	struct resource io;
 	struct resource pio;
 	struct resource mem;
@@ -317,7 +319,6 @@ struct tegra_pcie_port {
 };
 
 struct tegra_pcie_bus {
-	struct vm_struct *area;
 	struct list_head list;
 	unsigned int nr;
 };
@@ -357,34 +358,16 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
  *
  * Mapping the whole extended configuration space would require 256 MiB of
  * virtual address space, only a small part of which will actually be used.
- * To work around this, a 1 MiB of virtual addresses are allocated per bus
- * when the bus is first accessed. When the physical range is mapped, the
- * the bus number bits are hidden so that the extended register number bits
- * appear as bits [19:16]. Therefore the virtual mapping looks like this:
- *
- *    [19:16] extended register number
- *    [15:11] device number
- *    [10: 8] function number
- *    [ 7: 0] register number
- *
- * This is achieved by stitching together 16 chunks of 64 KiB of physical
- * address space via the MMU.
+ * To work around this, a 4K of region is used to generate required
+ * configuration transaction with relevant B:D:F values. This is achieved by
+ * dynamically programming base address and size of AFI_AXI_BAR used for
+ * end point config space mapping to make sure that the address (access to
+ * which generates correct config transaction) falls in this 4K region
  */
-static unsigned long tegra_pcie_conf_offset(unsigned int devfn, int where)
-{
-	return ((where & 0xf00) << 8) | (PCI_SLOT(devfn) << 11) |
-	       (PCI_FUNC(devfn) << 8) | (where & 0xfc);
-}
-
 static struct tegra_pcie_bus *tegra_pcie_bus_alloc(struct tegra_pcie *pcie,
 						   unsigned int busnr)
 {
-	struct device *dev = pcie->dev;
-	pgprot_t prot = pgprot_noncached(PAGE_KERNEL);
-	phys_addr_t cs = pcie->cs->start;
 	struct tegra_pcie_bus *bus;
-	unsigned int i;
-	int err;
 
 	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
 	if (!bus)
@@ -393,33 +376,16 @@ static struct tegra_pcie_bus *tegra_pcie_bus_alloc(struct tegra_pcie *pcie,
 	INIT_LIST_HEAD(&bus->list);
 	bus->nr = busnr;
 
-	/* allocate 1 MiB of virtual addresses */
-	bus->area = get_vm_area(SZ_1M, VM_IOREMAP);
-	if (!bus->area) {
-		err = -ENOMEM;
-		goto free;
-	}
-
-	/* map each of the 16 chunks of 64 KiB each */
-	for (i = 0; i < 16; i++) {
-		unsigned long virt = (unsigned long)bus->area->addr +
-				     i * SZ_64K;
-		phys_addr_t phys = cs + i * SZ_16M + busnr * SZ_64K;
-
-		err = ioremap_page_range(virt, virt + SZ_64K, phys, prot);
-		if (err < 0) {
-			dev_err(dev, "ioremap_page_range() failed: %d\n", err);
-			goto unmap;
+	if (!pcie->cfg_va_base) {
+		pcie->cfg_va_base = ioremap(pcie->cs->start, SZ_4K);
+		if (!pcie->cfg_va_base) {
+			dev_err(pcie->dev, "failed to ioremap config space\n");
+			kfree(bus);
+			bus = (struct tegra_pcie_bus *)-ENOMEM;
 		}
 	}
 
 	return bus;
-
-unmap:
-	vunmap(bus->area->addr);
-free:
-	kfree(bus);
-	return ERR_PTR(err);
 }
 
 static int tegra_pcie_add_bus(struct pci_bus *bus)
@@ -445,12 +411,12 @@ static void tegra_pcie_remove_bus(struct pci_bus *child)
 
 	list_for_each_entry_safe(bus, tmp, &pcie->buses, list) {
 		if (bus->nr == child->number) {
-			vunmap(bus->area->addr);
 			list_del(&bus->list);
 			kfree(bus);
 			break;
 		}
 	}
+	iounmap(pcie->cfg_va_base);
 }
 
 static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
@@ -459,8 +425,8 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(bus);
 	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
-	struct device *dev = pcie->dev;
 	void __iomem *addr = NULL;
+	u32 val = 0;
 
 	if (bus->number == 0) {
 		unsigned int slot = PCI_SLOT(devfn);
@@ -473,19 +439,14 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
 			}
 		}
 	} else {
-		struct tegra_pcie_bus *b;
-
-		list_for_each_entry(b, &pcie->buses, list)
-			if (b->nr == bus->number)
-				addr = (void __iomem *)b->area->addr;
-
-		if (!addr) {
-			dev_err(dev, "failed to map cfg. space for bus %u\n",
-				bus->number);
-			return NULL;
-		}
-
-		addr += tegra_pcie_conf_offset(devfn, where);
+		addr = pcie->cfg_va_base;
+		val = ((((u32)where & 0xf00) >> 8) << 24) |
+		      (bus->number << 16) | (PCI_SLOT(devfn) << 11) |
+		      (PCI_FUNC(devfn) << 8) | (where & 0xff);
+		addr = (val & (SZ_4K - 1)) + addr;
+		val = val & ~(SZ_4K - 1);
+		afi_writel(pcie, pcie->cs->start - val, AFI_AXI_BAR0_START);
+		afi_writel(pcie, (val + SZ_4K) >> 12, AFI_AXI_BAR0_SZ);
 	}
 
 	return addr;
-- 
2.7.4
