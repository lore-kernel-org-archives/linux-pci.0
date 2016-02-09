Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37165 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932328AbcBIOax (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2016 09:30:53 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 2/2] PCI: tegra: Implement ->{add,remove}_bus() callbacks
Date: Tue,  9 Feb 2016 15:30:48 +0100
Message-Id: <1455028248-1950-2-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1455028248-1950-1-git-send-email-thierry.reding@gmail.com>
References: <1455028248-1950-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

The configuration space mapping on Tegra is somewhat special, and in
order to avoid wasting virtual address space the configuration space
for each bus needs to be stitched together from several blocks which
form a single continuous virtual address range for accessors.

Currently the configuration space is mapped upon the first access to
one of its registers. However, the mapping operation may sleep under
certain circumstances, so doing it from the configuration space
accessors (they are protected by a spin lock) will trigger a warning.

To avoid the warning, use the ->add_bus() callback to perform the
mapping at enumeration time when the operation is allowed to sleep.
Also add an implementation of ->remove_bus() that undoes the mapping
established by the ->add_bus() callback. While it isn't currently
possible to unload the module, there is work underway to remedy this,
and this code will come in handy when that happens.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- add ->remove_bus() callback implementation

 drivers/pci/host/pci-tegra.c | 54 ++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 30323114c53c..75c55265ca73 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -426,31 +426,38 @@ free:
 	return ERR_PTR(err);
 }
 
-/*
- * Look up a virtual address mapping for the specified bus number. If no such
- * mapping exists, try to create one.
- */
-static void __iomem *tegra_pcie_bus_map(struct tegra_pcie *pcie,
-					unsigned int busnr)
+static int tegra_pcie_add_bus(struct pci_bus *bus)
 {
-	struct tegra_pcie_bus *bus;
+	struct tegra_pcie *pcie = sys_to_pcie(bus->sysdata);
+	struct tegra_pcie_bus *b;
 
-	list_for_each_entry(bus, &pcie->buses, list)
-		if (bus->nr == busnr)
-			return (void __iomem *)bus->area->addr;
+	b = tegra_pcie_bus_alloc(pcie, bus->number);
+	if (IS_ERR(b))
+		return PTR_ERR(b);
 
-	bus = tegra_pcie_bus_alloc(pcie, busnr);
-	if (IS_ERR(bus))
-		return NULL;
+	list_add_tail(&b->list, &pcie->buses);
 
-	list_add_tail(&bus->list, &pcie->buses);
+	return 0;
+}
 
-	return (void __iomem *)bus->area->addr;
+static void tegra_pcie_remove_bus(struct pci_bus *child)
+{
+	struct tegra_pcie *pcie = sys_to_pcie(child->sysdata);
+	struct tegra_pcie_bus *bus, *tmp;
+
+	list_for_each_entry_safe(bus, tmp, &pcie->buses, list) {
+		if (bus->nr == child->number) {
+			vunmap(bus->area->addr);
+			list_del(&bus->list);
+			kfree(bus);
+			break;
+		}
+	}
 }
 
-static void __iomem *tegra_pcie_conf_address(struct pci_bus *bus,
-					     unsigned int devfn,
-					     int where)
+static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
+					unsigned int devfn,
+					int where)
 {
 	struct tegra_pcie *pcie = sys_to_pcie(bus->sysdata);
 	void __iomem *addr = NULL;
@@ -466,7 +473,12 @@ static void __iomem *tegra_pcie_conf_address(struct pci_bus *bus,
 			}
 		}
 	} else {
-		addr = tegra_pcie_bus_map(pcie, bus->number);
+		struct tegra_pcie_bus *b;
+
+		list_for_each_entry(b, &pcie->buses, list)
+			if (b->nr == bus->number)
+				addr = (void __iomem *)b->area->addr;
+
 		if (!addr) {
 			dev_err(pcie->dev,
 				"failed to map cfg. space for bus %u\n",
@@ -481,7 +493,9 @@ static void __iomem *tegra_pcie_conf_address(struct pci_bus *bus,
 }
 
 static struct pci_ops tegra_pcie_ops = {
-	.map_bus = tegra_pcie_conf_address,
+	.add_bus = tegra_pcie_add_bus,
+	.remove_bus = tegra_pcie_remove_bus,
+	.map_bus = tegra_pcie_map_bus,
 	.read = pci_generic_config_read32,
 	.write = pci_generic_config_write32,
 };
-- 
2.7.1

