Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751526AbdFHOOw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jun 2017 10:14:52 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Matthew Minter <matt@masarand.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [RFT PATCH v2 29/42] ARM: PCI: Remove pci_fixup_irqs() call for bios32 host controllers
Date: Thu,  8 Jun 2017 15:13:29 +0100
Message-Id: <20170608141342.2018-30-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Legacy PCI host controllers (ie host controllers that set-up the PCI bus
through the ARM pci_common_init() API) are currently relying on
pci_fixup_irqs() to assign legacy PCI irqs to devices. This is not ideal
in that pci_fixup_irqs() assign IRQs for all PCI devices present in a
given system some of which may well be enabled by the time
pci_fixup_irqs() is called (ie a system with multiple host controllers).
With the introduction of struct pci_host_bridge.(*map_irq) pointer it is
possible to assign IRQs for all devices originating from a PCI host
bridge at probe time; this is implemented through pci_assign_irq() that
relies on the struct pci_host_bridge.map_irq pointer to map IRQ for a
given device.

The benefits this brings are twofold:

- the IRQ for a device is assigned once at probe time
- the IRQ assignment works also for hotplugged devices

Remove pci_fixup_irqs() call from bios32 code and rely on
pci_assign_irq() to carry out the IRQ mapping at device probe
time.

The map_irq() and swizzle_irq() struct pci_host_bridge callbacks are
set-up in the struct pci_host_bridge created in the bios32
pcibios_init_hw() function and mach-* code paths (for PCI mach
implementations that require a specific struct hw_pci.(*scan) function
callback).

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/kernel/bios32.c    |  4 ++--
 arch/arm/mach-dove/pcie.c   | 18 ++++++++++--------
 arch/arm/mach-iop13xx/pci.c |  2 ++
 arch/arm/mach-orion5x/pci.c | 28 +++++++++++++++-------------
 4 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 4c7621a..da201a2 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -494,6 +494,8 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 				bridge->busnr = sys->busnr;
 				bridge->ops = hw->ops;
 				bridge->msi = hw->msi_ctrl;
+				bridge->map_irq = pcibios_map_irq;
+				bridge->swizzle_irq = pcibios_swizzle;
 				bridge->align_resource =
 						hw->align_resource;
 
@@ -530,8 +532,6 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
 	if (hw->postinit)
 		hw->postinit();
 
-	pci_fixup_irqs(pcibios_swizzle, pcibios_map_irq);
-
 	list_for_each_entry(sys, &head, node) {
 		struct pci_bus *bus = sys->bus;
 
diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index dfb62f3..8d54a67 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -152,6 +152,14 @@ static void rc_pci_fixup(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL, PCI_ANY_ID, rc_pci_fixup);
 
+static int __init dove_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	struct pci_sys_data *sys = dev->sysdata;
+	struct pcie_port *pp = sys->private_data;
+
+	return pp->index ? IRQ_DOVE_PCIE1 : IRQ_DOVE_PCIE0;
+}
+
 static int __init
 dove_pcie_scan_bus(int nr, struct pci_host_bridge *bridge)
 {
@@ -167,18 +175,12 @@ dove_pcie_scan_bus(int nr, struct pci_host_bridge *bridge)
 	bridge->sysdata = sys;
 	bridge->busnr = sys->busnr;
 	bridge->ops = &pcie_ops;
+	bridge->map_irq = dove_pcie_map_irq;
+	bridge->swizzle_irq = pci_common_swizzle;
 
 	return pci_scan_root_bus_bridge(bridge);
 }
 
-static int __init dove_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	struct pci_sys_data *sys = dev->sysdata;
-	struct pcie_port *pp = sys->private_data;
-
-	return pp->index ? IRQ_DOVE_PCIE1 : IRQ_DOVE_PCIE0;
-}
-
 static struct hw_pci dove_pci __initdata = {
 	.nr_controllers	= 2,
 	.setup		= dove_pcie_setup,
diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
index 4babf15..b97879b 100644
--- a/arch/arm/mach-iop13xx/pci.c
+++ b/arch/arm/mach-iop13xx/pci.c
@@ -532,6 +532,7 @@ int iop13xx_scan_bus(int nr, struct pci_host_bridge *bridge)
 	bridge->dev.parent = NULL;
 	bridge->sysdata = sys;
 	bridge->busnr = sys->busnr;
+	bridge->swizzle_irq = pci_common_swizzle;
 
 	switch (which_atu) {
 	case IOP13XX_INIT_ATU_ATUX:
@@ -547,6 +548,7 @@ int iop13xx_scan_bus(int nr, struct pci_host_bridge *bridge)
 		break;
 	case IOP13XX_INIT_ATU_ATUE:
 		bridge->ops = &iop13xx_atue_ops;
+		bridge->map_irq = iop13xx_pcie_map_irq;
 		ret = pci_scan_root_bus_bridge(bridge);
 		if (!ret)
 			pci_bus_atue = bridge->bus;
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 76951bf..0f1c343 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -555,6 +555,19 @@ int __init orion5x_pci_sys_setup(int nr, struct pci_sys_data *sys)
 	return 0;
 }
 
+int __init orion5x_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	int bus = dev->bus->number;
+
+	/*
+	 * PCIe endpoint?
+	 */
+	if (orion5x_pci_disabled || bus < orion5x_pci_local_bus_nr())
+		return IRQ_ORION5X_PCIE0_INT;
+
+	return -1;
+}
+
 int __init orion5x_pci_sys_scan_bus(int nr, struct pci_host_bridge *bridge)
 {
 	struct pci_sys_data *sys = pci_host_bridge_priv(bridge);
@@ -563,6 +576,8 @@ int __init orion5x_pci_sys_scan_bus(int nr, struct pci_host_bridge *bridge)
 	bridge->dev.parent = NULL;
 	bridge->sysdata = sys;
 	bridge->busnr = sys->busnr;
+	bridge->map_irq = orion5x_pci_map_irq;
+	bridge->swizzle_irq = pci_common_swizzle;
 
 	if (nr == 0) {
 		bridge->ops = &pcie_ops;
@@ -577,16 +592,3 @@ int __init orion5x_pci_sys_scan_bus(int nr, struct pci_host_bridge *bridge)
 	BUG();
 	return -ENODEV;
 }
-
-int __init orion5x_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	int bus = dev->bus->number;
-
-	/*
-	 * PCIe endpoint?
-	 */
-	if (orion5x_pci_disabled || bus < orion5x_pci_local_bus_nr())
-		return IRQ_ORION5X_PCIE0_INT;
-
-	return -1;
-}
-- 
2.10.0
