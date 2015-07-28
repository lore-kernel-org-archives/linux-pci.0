Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57976 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932840AbbG1Kbg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Jul 2015 06:31:36 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Russell King <linux@arm.linux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	James Morse <james.morse@arm.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH v3 2/2] ARM: pci: kill pcibios_msi_controller
Date: Tue, 28 Jul 2015 11:32:15 +0100
Message-Id: <1438079535-11956-2-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1438079535-11956-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1438079535-11956-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On ARM PCI systems relying on the pcibios API to initialize PCI host
controllers, the pcibios_msi_controller weak callback is used to look-up
the msi_controller pointer, through pci_sys_data msi_ctrl pointer.

pci_sys_data is an ARM specific structure, which prevents using the
same mechanism (so same PCI host controller drivers) on ARM64 systems.

Since the struct pci_bus already contains an msi_controller pointer and
the kernel already uses it to look-up the msi controller,
this patch converts ARM host controller and related pcibios/host bridges
initialization routines so that the msi_controller pointer look-up can be
carried out by PCI core code through the struct pci_bus msi pointer,
removing the need for the arch specific pcibios_msi_controller callback
and the related pci_sys_data msi_ctrl pointer.

To simplify the conversion, this patch adds a new function in PCI
core code (pci_scan_root_bus_msi()) that takes the msi_controller
pointer as an additional parameter wrt pci_scan_root_bus() so that
the msi controller pointer can be effectively propagated at probe time
through the augmented API.

The existing pci_scan_root_bus() API is made to rely on the newly
introduced function, by passing a NULL msi pointer to it so
that it can be used when no msi controller pointer passing is required
without additional code (and API conversions) in the core PCI layer.

ARM is the only arch relying on the pcibios_msi_controller() weak
function, hence this patch also removes its default weak implementation
from PCI core code since it becomes of no use.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Suggested-by: Russell King <linux@arm.linux.org.uk>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
v2->v3

- Added pci_scan_root_bus_msi() in core PCI code and converted ARM bios32 to
  use it

v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/359183.html

v1->v2

- Added patch to replace panic statements with WARN
- Removed unused pcibios_msi_controller() and pci_msi_controller() from
  core code
- Dropped RFT status

v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/356028.html

 arch/arm/include/asm/mach/pci.h    |  5 -----
 arch/arm/kernel/bios32.c           | 17 +++--------------
 drivers/pci/host/pcie-designware.c |  9 +++++++--
 drivers/pci/host/pcie-xilinx.c     | 12 ++++++++++--
 drivers/pci/msi.c                  | 17 +----------------
 drivers/pci/probe.c                | 15 +++++++++++++--
 include/linux/pci.h                |  4 ++++
 7 files changed, 38 insertions(+), 41 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 28b9bb3..8857d28 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -19,9 +19,7 @@ struct pci_bus;
 struct device;
 
 struct hw_pci {
-#ifdef CONFIG_PCI_MSI
 	struct msi_controller *msi_ctrl;
-#endif
 	struct pci_ops	*ops;
 	int		nr_controllers;
 	void		**private_data;
@@ -42,9 +40,6 @@ struct hw_pci {
  * Per-controller structure
  */
 struct pci_sys_data {
-#ifdef CONFIG_PCI_MSI
-	struct msi_controller *msi_ctrl;
-#endif
 	struct list_head node;
 	int		busnr;		/* primary bus number			*/
 	u64		mem_offset;	/* bus->cpu memory mapping offset	*/
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index a5c782c..1a20076 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -18,15 +18,6 @@
 
 static int debug_pci;
 
-#ifdef CONFIG_PCI_MSI
-struct msi_controller *pcibios_msi_controller(struct pci_dev *dev)
-{
-	struct pci_sys_data *sysdata = dev->bus->sysdata;
-
-	return sysdata->msi_ctrl;
-}
-#endif
-
 /*
  * We can't use pci_get_device() here since we are
  * called from interrupt context.
@@ -462,9 +453,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 		if (WARN(!sys, "PCI: unable to allocate sys data!"))
 			break;
 
-#ifdef CONFIG_PCI_MSI
-		sys->msi_ctrl = hw->msi_ctrl;
-#endif
 		sys->busnr   = busnr;
 		sys->swizzle = hw->swizzle;
 		sys->map_irq = hw->map_irq;
@@ -486,8 +474,9 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 			if (hw->scan)
 				sys->bus = hw->scan(nr, sys);
 			else
-				sys->bus = pci_scan_root_bus(parent, sys->busnr,
-						hw->ops, sys, &sys->resources);
+				sys->bus = pci_scan_root_bus_msi(parent,
+					sys->busnr, hw->ops, sys,
+					&sys->resources, hw->msi_ctrl);
 
 			if (WARN(!sys->bus, "PCI: unable to scan bus!")) {
 				kfree(sys);
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 69486be..e584dfa 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -526,7 +526,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 #ifdef CONFIG_PCI_MSI
 	dw_pcie_msi_chip.dev = pp->dev;
-	dw_pci.msi_ctrl = &dw_pcie_msi_chip;
 #endif
 
 	dw_pci.nr_controllers = 1;
@@ -708,11 +707,17 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 	struct pcie_port *pp = sys_to_pcie(sys);
 
 	pp->root_bus_nr = sys->busnr;
-	bus = pci_scan_root_bus(pp->dev, sys->busnr,
+	bus = pci_create_root_bus(pp->dev, sys->busnr,
 				  &dw_pcie_ops, sys, &sys->resources);
 	if (!bus)
 		return NULL;
 
+#ifdef CONFIG_PCI_MSI
+	bus->msi = &dw_pcie_msi_chip;
+#endif
+
+	pci_scan_child_bus(bus);
+
 	if (bus && pp->ops->scan_bus)
 		pp->ops->scan_bus(pp);
 
diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index f1a06a0..b21eb7d 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -647,9 +647,18 @@ static struct pci_bus *xilinx_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 	struct pci_bus *bus;
 
 	port->root_busno = sys->busnr;
-	bus = pci_scan_root_bus(port->dev, sys->busnr, &xilinx_pcie_ops,
+	bus = pci_create_root_bus(port->dev, sys->busnr, &xilinx_pcie_ops,
 				sys, &sys->resources);
 
+	if (!bus)
+		return NULL;
+
+#ifdef CONFIG_PCI_MSI
+	bus->msi = &xilinx_pcie_msi_chip;
+#endif
+
+	pci_scan_child_bus(bus);
+
 	return bus;
 }
 
@@ -847,7 +856,6 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_PCI_MSI
 	xilinx_pcie_msi_chip.dev = port->dev;
-	hw.msi_ctrl = &xilinx_pcie_msi_chip;
 #endif
 	pci_common_init_dev(dev, &hw);
 
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index f66be86..0d20142 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -77,24 +77,9 @@ static void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
 
 /* Arch hooks */
 
-struct msi_controller * __weak pcibios_msi_controller(struct pci_dev *dev)
-{
-	return NULL;
-}
-
-static struct msi_controller *pci_msi_controller(struct pci_dev *dev)
-{
-	struct msi_controller *msi_ctrl = dev->bus->msi;
-
-	if (msi_ctrl)
-		return msi_ctrl;
-
-	return pcibios_msi_controller(dev);
-}
-
 int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 {
-	struct msi_controller *chip = pci_msi_controller(dev);
+	struct msi_controller *chip = dev->bus->msi;
 	int err;
 
 	if (!chip || !chip->setup_irq)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cefd636..4915c6d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2096,8 +2096,9 @@ void pci_bus_release_busn_res(struct pci_bus *b)
 			res, ret ? "can not be" : "is");
 }
 
-struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata,
+		struct list_head *resources, struct msi_controller *msi)
 {
 	struct resource_entry *window;
 	bool found = false;
@@ -2114,6 +2115,8 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 	if (!b)
 		return NULL;
 
+	b->msi = msi;
+
 	if (!found) {
 		dev_info(&b->dev,
 		 "No busn resource found for root bus, will use [bus %02x-ff]\n",
@@ -2128,6 +2131,14 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 
 	return b;
 }
+EXPORT_SYMBOL(pci_scan_root_bus_msi);
+
+struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	return pci_scan_root_bus_msi(parent, bus, ops, sysdata, resources,
+				     NULL);
+}
 EXPORT_SYMBOL(pci_scan_root_bus);
 
 struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8a0321a..4d4f9d2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -787,6 +787,10 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
 void pci_bus_release_busn_res(struct pci_bus *b);
+struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
+				      struct pci_ops *ops, void *sysdata,
+				      struct list_head *resources,
+				      struct msi_controller *msi);
 struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 					     struct pci_ops *ops, void *sysdata,
 					     struct list_head *resources);
-- 
2.2.1

