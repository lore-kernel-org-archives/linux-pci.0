Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:32823 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbbKWMke (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Nov 2015 07:40:34 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 2/2] PCI: tegra: Implement ->add_bus() callback
Date: Mon, 23 Nov 2015 13:40:26 +0100
Message-Id: <1448282426-2642-2-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1448282426-2642-1-git-send-email-thierry.reding@gmail.com>
References: <1448282426-2642-1-git-send-email-thierry.reding@gmail.com>
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

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 3018ae52e092..c3666f9d7ef1 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -426,31 +426,23 @@ free:
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
-
-	return (void __iomem *)bus->area->addr;
+	return 0;
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
@@ -466,7 +458,12 @@ static void __iomem *tegra_pcie_conf_address(struct pci_bus *bus,
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
@@ -481,7 +478,8 @@ static void __iomem *tegra_pcie_conf_address(struct pci_bus *bus,
 }
 
 static struct pci_ops tegra_pcie_ops = {
-	.map_bus = tegra_pcie_conf_address,
+	.add_bus = tegra_pcie_add_bus,
+	.map_bus = tegra_pcie_map_bus,
 	.read = pci_generic_config_read32,
 	.write = pci_generic_config_write32,
 };
-- 
2.5.0

