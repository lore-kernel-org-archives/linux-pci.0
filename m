Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Subject: [RFC/RFT PATCH 18/18] ARM/ARM64: PCI: Drop pci_fixup_irqs() usage for
 DT based host controllers
Date: Wed, 26 Apr 2017 12:18:09 +0100
Message-Id: <20170426111809.19922-19-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Pratyush Anand <pratyush.anand@gmail.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Matthew Minter <matt@masarand.com>, Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Wenrui Li <wenrui.li@rock-chips.com>, Michal Simek <michal.simek@xilinx.com>,
 Murali Karicheri <m-karicheri2@ti.com>, Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Ray Jui <rjui@broadcom.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@freescale.com>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Simon Horman <horms@verge.net.au>,
 Ley Foon Tan <lftan@altera.com>, Roy Zang <tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

DT based PCI host controllers are currently relying on
pci_fixup_irqs() to assign legacy PCI irqs to devices. This is
broken in that pci_fixup_irqs() assign IRQs for all PCI devices
present in a given system some of which may well be enabled by
the time pci_fixup_irqs() is called (ie a system with multiple
host controllers). With the introduction of
struct pci_host_bridge.map_irq pointer it is possible to assign IRQs
for all devices originating from a PCI host bridge at probe time;
this is implemented through pci_assign_irq() that relies on the
struct pci_host_bridge.map_irq pointer to map IRQ for a given device.

The benefits this brings are twofold:

- the IRQ for a device is assigned once at probe time
- the IRQ assignment works also for hotplugged devices

Remove pci_fixup_irqs() call from all DT based PCI host controller
drivers. The map_irq() and swizzle_irq() struct pci_host_bridge callbacks
are either set-up in the respective PCI host controller driver or
delegated to ARM/ARM64 pcibios_root_bridge_prepare() implementations,
where, upon DT probe detection, the functions are set to DT defaults (ie
of_irq_parse_and_map_pci() and pci_common_swizzle() respectively.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Simon Horman <horms@verge.net.au>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Ley Foon Tan <lftan@altera.com>
---
 arch/arm/kernel/bios32.c               | 25 ++++++++++++++++++++
 arch/arm64/kernel/pci.c                | 32 ++++++++++++++++++++-----
 drivers/pci/dwc/pcie-designware-host.c |  5 ----
 drivers/pci/host/pci-host-common.c     |  4 ----
 drivers/pci/host/pci-tegra.c           |  3 ++-
 drivers/pci/host/pci-versatile.c       |  1 -
 drivers/pci/host/pcie-altera.c         |  1 -
 drivers/pci/host/pcie-iproc.c          | 43 ++++++++++++++++++++++------------
 drivers/pci/host/pcie-rcar.c           |  2 --
 drivers/pci/host/pcie-xilinx.c         |  3 ---
 10 files changed, 81 insertions(+), 38 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index a5b6d4f..09b2278 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/of_pci.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -527,6 +528,30 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 	}
 }
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	/*
+	 * Set-up IRQ mapping/swizzingly functions.
+	 * If the either function pointer is already set,
+	 * do not override any of them since it is a host
+	 * controller specific mapping/swizzling function.
+	 */
+	if (!bridge->map_irq && !bridge->swizzle_irq) {
+		struct device *parent = bridge->dev.parent;
+		/*
+		 * If we have a parent pointer with a valid
+		 * OF node this means we are probing a PCI host
+		 * controller configured through DT firmware.
+		 */
+		if (IS_ENABLED(CONFIG_OF) && parent && parent->of_node) {
+			bridge->map_irq = of_irq_parse_and_map_pci;
+			bridge->swizzle_irq = pci_common_swizzle;
+		}
+	}
+
+	return 0;
+}
+
 void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
 {
 	struct pci_sys_data *sys;
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 4f0e3eb..a680dcc 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -39,20 +39,18 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	return res->start;
 }
 
+#ifdef CONFIG_ACPI
 /*
  * Try to assign the IRQ number when probing a new device
  */
 int pcibios_alloc_irq(struct pci_dev *dev)
 {
-	if (acpi_disabled)
-		dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
-#ifdef CONFIG_ACPI
-	else
-		return acpi_pci_irq_enable(dev);
-#endif
+	if (!acpi_disabled)
+		acpi_pci_irq_enable(dev);
 
 	return 0;
 }
+#endif
 
 /*
  * raw_pci_read/write - Platform-specific PCI config space access.
@@ -105,12 +103,34 @@ int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
 
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
+	struct device *parent = bridge->dev.parent;
+
 	if (!acpi_disabled) {
 		struct pci_config_window *cfg = bridge->bus->sysdata;
 		struct acpi_device *adev = to_acpi_device(cfg->parent);
 		ACPI_COMPANION_SET(&bridge->dev, adev);
 	}
 
+	/*
+	 * DT and ACPI systems use different mechanism to set-up legacy
+	 * IRQs. Through the bridge map_irq and swizzle_irq function
+	 * pointer we are capable of setting up legacy IRQs on DT systems,
+	 * check if we are probing a DT based host controller and initialize
+	 * the host bridge mapping/swizzling IRQ function accordingly.
+	 */
+	if (parent && parent->of_node) {
+		/*
+		 * Set-up IRQ mapping/swizzingly functions.
+		 * If the either function pointer is already set,
+		 * do not override any of them since it is a host
+		 * controller specific mapping/swizzling function.
+		 */
+		if (!bridge->map_irq && !bridge->swizzle_irq) {
+			bridge->map_irq = of_irq_parse_and_map_pci;
+			bridge->swizzle_irq = pci_common_swizzle;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index e43c21a..8eeddb9 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -421,11 +421,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (pp->ops->scan_bus)
 		pp->ops->scan_bus(pp);
 
-#ifdef CONFIG_ARM
-	/* support old dtbs that incorrectly describe IRQs */
-	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
-#endif
-
 	pci_bus_size_bridges(bus);
 	pci_bus_assign_resources(bus);
 
diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
index e9a53ba..3e8fb57 100644
--- a/drivers/pci/host/pci-host-common.c
+++ b/drivers/pci/host/pci-host-common.c
@@ -145,10 +145,6 @@ int pci_host_common_probe(struct platform_device *pdev,
 		return -ENODEV;
 	}
 
-#ifdef CONFIG_ARM
-	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
-#endif
-
 	/*
 	 * We insert PCI resources into the iomem_resource and
 	 * ioport_resource trees in either pci_bus_claim_resources()
diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index ed8a93f..0527a89 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -2284,6 +2284,8 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	host->busnr = pcie->busn.start;
 	host->dev.parent = &pdev->dev;
 	host->ops = &tegra_pcie_ops;
+	host->map_irq = tegra_pcie_map_irq;
+	host->swizzle_irq = pci_common_swizzle;
 
 	err = pci_register_host_bridge(host);
 	if (err < 0) {
@@ -2293,7 +2295,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 
 	pci_scan_child_bus(host->bus);
 
-	pci_fixup_irqs(pci_common_swizzle, tegra_pcie_map_irq);
 	pci_bus_size_bridges(host->bus);
 	pci_bus_assign_resources(host->bus);
 
diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
index 5ebee7d..c364b6a8 100644
--- a/drivers/pci/host/pci-versatile.c
+++ b/drivers/pci/host/pci-versatile.c
@@ -202,7 +202,6 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	if (!bus)
 		return -ENOMEM;
 
-	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
 	pci_assign_unassigned_bus_resources(bus);
 	list_for_each_entry(child, &bus->children, node)
 		pcie_bus_configure_settings(child);
diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 75ec5ce..0550f9d 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -618,7 +618,6 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	if (!bus)
 		return -ENOMEM;
 
-	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
 	pci_assign_unassigned_bus_resources(bus);
 
 	/* Configure PCI Express setting. */
diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 0f39bd2..bc9e36a 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -1205,7 +1205,8 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 	struct device *dev;
 	int ret;
 	void *sysdata;
-	struct pci_bus *bus, *child;
+	struct pci_bus *child;
+	struct pci_host_bridge *host;
 
 	dev = pcie->dev;
 
@@ -1252,15 +1253,30 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 	sysdata = pcie;
 #endif
 
-	bus = pci_create_root_bus(dev, 0, &iproc_pcie_ops, sysdata, res);
-	if (!bus) {
-		dev_err(dev, "unable to create PCI root bus\n");
+	host = pci_alloc_host_bridge(0);
+	if (!host) {
+		dev_err(dev, "unable to allocate PCI host bridge\n");
 		ret = -ENOMEM;
 		goto err_power_off_phy;
 	}
-	pcie->root_bus = bus;
 
-	ret = iproc_pcie_check_link(pcie, bus);
+	list_splice_init(res, &host->windows);
+	host->busnr = 0;
+	host->dev.parent = dev;
+	host->ops = &iproc_pcie_ops;
+	host->sysdata = sysdata;
+	host->map_irq = pcie->map_irq;
+	host->swizzle_irq = pci_common_swizzle;
+
+	ret = pci_register_host_bridge(host);
+	if (ret < 0) {
+		dev_err(dev, "failed to register host: %d\n", ret);
+		goto err_power_off_phy;
+	}
+
+	pcie->root_bus = host->bus;
+
+	ret = iproc_pcie_check_link(pcie, host->bus);
 	if (ret) {
 		dev_err(dev, "no PCIe EP device detected\n");
 		goto err_rm_root_bus;
@@ -1272,22 +1288,19 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 		if (iproc_pcie_msi_enable(pcie))
 			dev_info(dev, "not using iProc MSI\n");
 
-	pci_scan_child_bus(bus);
-	pci_assign_unassigned_bus_resources(bus);
-
-	if (pcie->map_irq)
-		pci_fixup_irqs(pci_common_swizzle, pcie->map_irq);
+	pci_scan_child_bus(host->bus);
+	pci_assign_unassigned_bus_resources(host->bus);
 
-	list_for_each_entry(child, &bus->children, node)
+	list_for_each_entry(child, &host->bus->children, node)
 		pcie_bus_configure_settings(child);
 
-	pci_bus_add_devices(bus);
+	pci_bus_add_devices(host->bus);
 
 	return 0;
 
 err_rm_root_bus:
-	pci_stop_root_bus(bus);
-	pci_remove_root_bus(bus);
+	pci_stop_root_bus(host->bus);
+	pci_remove_root_bus(host->bus);
 
 err_power_off_phy:
 	phy_power_off(pcie->phy);
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 051b4db..d8b3679 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -480,8 +480,6 @@ static int rcar_pcie_enable(struct rcar_pcie *pcie)
 
 	bus = bridge->bus;
 
-	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
-
 	pci_bus_size_bridges(bus);
 	pci_bus_assign_resources(bus);
 
diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 7f030f5..22e7f61 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -683,9 +683,6 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 #endif
 	pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
-#ifndef CONFIG_MICROBLAZE
-	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
-#endif
 	list_for_each_entry(child, &bus->children, node)
 		pcie_bus_configure_settings(child);
 	pci_bus_add_devices(bus);
-- 
2.10.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
