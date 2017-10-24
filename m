Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9935 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdJXGqT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Oct 2017 02:46:19 -0400
From: Vidya Sagar <vidyas@nvidia.com>
To: <treding@nvidia.com>, <bhelgaas@google.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH V3 1/2] PCI: tegra: refactor config space mapping code
Date: Tue, 24 Oct 2017 12:14:48 +0530
Message-ID: <1508827489-10842-2-git-send-email-vidyas@nvidia.com>
In-Reply-To: <1508827489-10842-1-git-send-email-vidyas@nvidia.com>
References: <1508827489-10842-1-git-send-email-vidyas@nvidia.com>
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
V3:
* added a new soc_data entry 'use_4k_conf_space' to decide whether to use first 4K chunk (T20, T186)
* or last 4K chunk (T30, T124, T132 and T210) of the available 256MB region
V2:
* restored tegra_pcie_conf_offset() after extending it to include bus number
* removed tegra_pcie_bus_alloc() and merged some of its contents with tegra_pcie_add_bus()
* replaced ioremap() with devm_ioremap()

 drivers/pci/host/pci-tegra.c | 125 ++++++++++++++-----------------------------
 1 file changed, 40 insertions(+), 85 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index af8b05614f87..aac484518fb8 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -257,6 +257,7 @@ struct tegra_pcie_soc {
 	bool has_gen2;
 	bool force_pca_enable;
 	bool program_uphy;
+	bool use_4k_conf_space;
 };
 
 static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
@@ -274,6 +275,8 @@ struct tegra_pcie {
 	struct list_head buses;
 	struct resource *cs;
 
+	void __iomem *cfg_va_base;
+
 	struct resource io;
 	struct resource pio;
 	struct resource mem;
@@ -322,7 +325,6 @@ struct tegra_pcie_port {
 };
 
 struct tegra_pcie_bus {
-	struct vm_struct *area;
 	struct list_head list;
 	unsigned int nr;
 };
@@ -362,69 +364,17 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
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
-static struct tegra_pcie_bus *tegra_pcie_bus_alloc(struct tegra_pcie *pcie,
-						   unsigned int busnr)
+static unsigned long tegra_pcie_conf_offset(unsigned char b, unsigned int devfn,
+					    int where)
 {
-	struct device *dev = pcie->dev;
-	pgprot_t prot = pgprot_noncached(PAGE_KERNEL);
-	phys_addr_t cs = pcie->cs->start;
-	struct tegra_pcie_bus *bus;
-	unsigned int i;
-	int err;
-
-	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
-	if (!bus)
-		return ERR_PTR(-ENOMEM);
-
-	INIT_LIST_HEAD(&bus->list);
-	bus->nr = busnr;
-
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
-		}
-	}
-
-	return bus;
-
-unmap:
-	vunmap(bus->area->addr);
-free:
-	kfree(bus);
-	return ERR_PTR(err);
+	return (b << 16) | (PCI_SLOT(devfn) << 11) | (PCI_FUNC(devfn) << 8) |
+	       (((where & 0xf00) >> 8) << 24) | (where & 0xff);
 }
 
 static int tegra_pcie_add_bus(struct pci_bus *bus)
@@ -433,10 +383,13 @@ static int tegra_pcie_add_bus(struct pci_bus *bus)
 	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
 	struct tegra_pcie_bus *b;
 
-	b = tegra_pcie_bus_alloc(pcie, bus->number);
-	if (IS_ERR(b))
+	b = kzalloc(sizeof(*b), GFP_KERNEL);
+	if (!b)
 		return PTR_ERR(b);
 
+	INIT_LIST_HEAD(&b->list);
+	b->nr = bus->number;
+
 	list_add_tail(&b->list, &pcie->buses);
 
 	return 0;
@@ -450,7 +403,6 @@ static void tegra_pcie_remove_bus(struct pci_bus *child)
 
 	list_for_each_entry_safe(bus, tmp, &pcie->buses, list) {
 		if (bus->nr == child->number) {
-			vunmap(bus->area->addr);
 			list_del(&bus->list);
 			kfree(bus);
 			break;
@@ -464,8 +416,9 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(bus);
 	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
-	struct device *dev = pcie->dev;
 	void __iomem *addr = NULL;
+	u32 val = 0;
+	u32 offset = 0;
 
 	if (bus->number == 0) {
 		unsigned int slot = PCI_SLOT(devfn);
@@ -478,19 +431,11 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
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
+		offset = tegra_pcie_conf_offset(bus->number, devfn, where);
+		addr = pcie->cfg_va_base + (offset & (SZ_4K - 1));
+		val = offset & ~(SZ_4K - 1);
+		afi_writel(pcie, pcie->cs->start - val, AFI_AXI_BAR0_START);
+		afi_writel(pcie, (val + SZ_4K) >> 12, AFI_AXI_BAR0_SZ);
 	}
 
 	return addr;
@@ -724,10 +669,6 @@ static void tegra_pcie_setup_translations(struct tegra_pcie *pcie)
 
 	/* Bar 0: type 1 extended configuration space */
 	fpci_bar = 0xfe100000;
-	size = resource_size(pcie->cs);
-	axi_address = pcie->cs->start;
-	afi_writel(pcie, axi_address, AFI_AXI_BAR0_START);
-	afi_writel(pcie, size >> 12, AFI_AXI_BAR0_SZ);
 	afi_writel(pcie, fpci_bar, AFI_FPCI_BAR0);
 
 	/* Bar 1: downstream IO bar */
@@ -1284,6 +1225,7 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *pads, *afi, *res;
 	const struct tegra_pcie_soc *soc = pcie->soc;
+	u32 axi_addr = 0;
 	int err;
 
 	err = tegra_pcie_clocks_get(pcie);
@@ -1333,13 +1275,21 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 		goto poweroff;
 	}
 
-	pcie->cs = devm_request_mem_region(dev, res->start,
-					   resource_size(res), res->name);
+	axi_addr = pcie->soc->use_4k_conf_space ?
+		   res->start : res->end - SZ_4K + 1;
+	pcie->cs = devm_request_mem_region(dev, axi_addr, SZ_4K, res->name);
 	if (!pcie->cs) {
 		err = -EADDRNOTAVAIL;
 		goto poweroff;
 	}
 
+	pcie->cfg_va_base = devm_ioremap(dev, pcie->cs->start, SZ_4K);
+	if (!pcie->cfg_va_base) {
+		dev_err(pcie->dev, "failed to ioremap config space\n");
+		err = -EADDRNOTAVAIL;
+		goto poweroff;
+	}
+
 	/* request interrupt */
 	err = platform_get_irq_byname(pdev, "intr");
 	if (err < 0) {
@@ -2130,6 +2080,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.has_gen2 = false,
 	.force_pca_enable = false,
 	.program_uphy = true,
+	.use_4k_conf_space = true,
 };
 
 static const struct tegra_pcie_soc tegra30_pcie = {
@@ -2146,6 +2097,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.has_gen2 = false,
 	.force_pca_enable = false,
 	.program_uphy = true,
+	.use_4k_conf_space = false,
 };
 
 static const struct tegra_pcie_soc tegra124_pcie = {
@@ -2161,6 +2113,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = false,
 	.program_uphy = true,
+	.use_4k_conf_space = false,
 };
 
 static const struct tegra_pcie_soc tegra210_pcie = {
@@ -2176,6 +2129,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = true,
 	.program_uphy = true,
+	.use_4k_conf_space = false,
 };
 
 static const struct tegra_pcie_soc tegra186_pcie = {
@@ -2192,6 +2146,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = false,
 	.program_uphy = false,
+	.use_4k_conf_space = true,
 };
 
 static const struct of_device_id tegra_pcie_of_match[] = {
-- 
2.7.4
