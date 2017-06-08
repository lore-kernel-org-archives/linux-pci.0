Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751822AbdFHONZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jun 2017 10:13:25 -0400
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
Subject: [RFT PATCH v2 11/42] ARM: PCI: bios32: Convert PCI scan API to pci_scan_root_bus_bridge()
Date: Thu,  8 Jun 2017 15:13:11 +0100
Message-Id: <20170608141342.2018-12-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The introduction of pci_scan_root_bus_bridge() provides a PCI core
API to scan a PCI root bus backed by an already initialized
struct pci_host_bridge object, which simplifies the bus scan
interface and makes the PCI scan root bus interface easier to
generalize as members are added to the struct pci_host_bridge.

Convert ARM bios32 code to pci_scan_root_bus_bridge() to improve
the PCI root bus scanning interface.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/include/asm/mach/pci.h |  3 ++-
 arch/arm/kernel/bios32.c        | 39 +++++++++++++++++++++++++--------------
 arch/arm/mach-dove/pcie.c       | 17 ++++++++++++-----
 arch/arm/mach-iop13xx/pci.c     | 29 ++++++++++++++++++-----------
 arch/arm/mach-iop13xx/pci.h     |  3 ++-
 arch/arm/mach-mv78xx0/pcie.c    |  8 +++-----
 arch/arm/mach-orion5x/common.h  |  3 ++-
 arch/arm/mach-orion5x/pci.c     | 25 +++++++++++++++++--------
 8 files changed, 81 insertions(+), 46 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 2d88af5..233b4b5 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -16,6 +16,7 @@
 struct pci_sys_data;
 struct pci_ops;
 struct pci_bus;
+struct pci_host_bridge;
 struct device;
 
 struct hw_pci {
@@ -25,7 +26,7 @@ struct hw_pci {
 	unsigned int	io_optional:1;
 	void		**private_data;
 	int		(*setup)(int nr, struct pci_sys_data *);
-	struct pci_bus *(*scan)(int nr, struct pci_sys_data *);
+	int		(*scan)(int nr, struct pci_host_bridge *);
 	void		(*preinit)(void);
 	void		(*postinit)(void);
 	u8		(*swizzle)(struct pci_dev *dev, u8 *pin);
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index b259956..4c7621a 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -458,10 +458,14 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 	int nr, busnr;
 
 	for (nr = busnr = 0; nr < hw->nr_controllers; nr++) {
-		sys = kzalloc(sizeof(struct pci_sys_data), GFP_KERNEL);
-		if (WARN(!sys, "PCI: unable to allocate sys data!"))
+		struct pci_host_bridge *bridge;
+
+		bridge = pci_alloc_host_bridge(sizeof(struct pci_sys_data));
+		if (WARN(!bridge, "PCI: unable to allocate bridge!"))
 			break;
 
+		sys = pci_host_bridge_priv(bridge);
+
 		sys->busnr   = busnr;
 		sys->swizzle = hw->swizzle;
 		sys->map_irq = hw->map_irq;
@@ -473,7 +477,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 		ret = hw->setup(nr, sys);
 
 		if (ret > 0) {
-			struct pci_host_bridge *host_bridge;
 
 			ret = pcibios_init_resource(nr, sys, hw->io_optional);
 			if (ret)  {
@@ -482,25 +485,33 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 			}
 
 			if (hw->scan)
-				sys->bus = hw->scan(nr, sys);
-			else
-				sys->bus = pci_scan_root_bus_msi(parent,
-					sys->busnr, hw->ops, sys,
-					&sys->resources, hw->msi_ctrl);
+				ret = hw->scan(nr, bridge);
+			else {
+				list_splice_init(&sys->resources,
+						 &bridge->windows);
+				bridge->dev.parent = parent;
+				bridge->sysdata = sys;
+				bridge->busnr = sys->busnr;
+				bridge->ops = hw->ops;
+				bridge->msi = hw->msi_ctrl;
+				bridge->align_resource =
+						hw->align_resource;
+
+				ret = pci_scan_root_bus_bridge(bridge);
+			}
 
-			if (WARN(!sys->bus, "PCI: unable to scan bus!")) {
-				kfree(sys);
+			if (WARN(ret < 0, "PCI: unable to scan bus!")) {
+				pci_free_host_bridge(bridge);
 				break;
 			}
 
+			sys->bus = bridge->bus;
+
 			busnr = sys->bus->busn_res.end + 1;
 
 			list_add(&sys->node, head);
-
-			host_bridge = pci_find_host_bridge(sys->bus);
-			host_bridge->align_resource = hw->align_resource;
 		} else {
-			kfree(sys);
+			pci_free_host_bridge(bridge);
 			if (ret < 0)
 				break;
 		}
diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index 91fe971..dfb62f3 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -152,16 +152,23 @@ static void rc_pci_fixup(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL, PCI_ANY_ID, rc_pci_fixup);
 
-static struct pci_bus __init *
-dove_pcie_scan_bus(int nr, struct pci_sys_data *sys)
+static int __init
+dove_pcie_scan_bus(int nr, struct pci_host_bridge *bridge)
 {
+	struct pci_sys_data *sys = pci_host_bridge_priv(bridge);
+
 	if (nr >= num_pcie_ports) {
 		BUG();
-		return NULL;
+		return -EINVAL;
 	}
 
-	return pci_scan_root_bus(NULL, sys->busnr, &pcie_ops, sys,
-				 &sys->resources);
+	list_splice_init(&sys->resources, &bridge->windows);
+	bridge->dev.parent = NULL;
+	bridge->sysdata = sys;
+	bridge->busnr = sys->busnr;
+	bridge->ops = &pcie_ops;
+
+	return pci_scan_root_bus_bridge(bridge);
 }
 
 static int __init dove_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
index 204eb44..4babf15 100644
--- a/arch/arm/mach-iop13xx/pci.c
+++ b/arch/arm/mach-iop13xx/pci.c
@@ -504,10 +504,10 @@ iop13xx_pci_abort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 /* Scan an IOP13XX PCI bus.  nr selects which ATU we use.
  */
-struct pci_bus *iop13xx_scan_bus(int nr, struct pci_sys_data *sys)
+int iop13xx_scan_bus(int nr, struct pci_host_bridge *bridge)
 {
-	int which_atu;
-	struct pci_bus *bus = NULL;
+	int which_atu, ret;
+	struct pci_sys_data *sys = pci_host_bridge_priv(bridge);
 
 	switch (init_atu) {
 	case IOP13XX_INIT_ATU_ATUX:
@@ -525,9 +525,14 @@ struct pci_bus *iop13xx_scan_bus(int nr, struct pci_sys_data *sys)
 
 	if (!which_atu) {
 		BUG();
-		return NULL;
+		return -ENODEV;
 	}
 
+	list_splice_init(&sys->resources, &bridge->windows);
+	bridge->dev.parent = NULL;
+	bridge->sysdata = sys;
+	bridge->busnr = sys->busnr;
+
 	switch (which_atu) {
 	case IOP13XX_INIT_ATU_ATUX:
 		if (time_after_eq(jiffies + msecs_to_jiffies(1000),
@@ -535,18 +540,20 @@ struct pci_bus *iop13xx_scan_bus(int nr, struct pci_sys_data *sys)
 			while(time_before(jiffies, atux_trhfa_timeout))
 				udelay(100);
 
-		bus = pci_bus_atux = pci_scan_root_bus(NULL, sys->busnr,
-						       &iop13xx_atux_ops,
-						       sys, &sys->resources);
+		bridge->ops = &iop13xx_atux_ops;
+		ret = pci_scan_root_bus_bridge(bridge);
+		if (!ret)
+			pci_bus_atux = bridge->bus;
 		break;
 	case IOP13XX_INIT_ATU_ATUE:
-		bus = pci_bus_atue = pci_scan_root_bus(NULL, sys->busnr,
-						       &iop13xx_atue_ops,
-						       sys, &sys->resources);
+		bridge->ops = &iop13xx_atue_ops;
+		ret = pci_scan_root_bus_bridge(bridge);
+		if (!ret)
+			pci_bus_atue = bridge->bus;
 		break;
 	}
 
-	return bus;
+	return ret;
 }
 
 /* This function is called from iop13xx_pci_init() after assigning valid
diff --git a/arch/arm/mach-iop13xx/pci.h b/arch/arm/mach-iop13xx/pci.h
index 71b9c57..8dc343c 100644
--- a/arch/arm/mach-iop13xx/pci.h
+++ b/arch/arm/mach-iop13xx/pci.h
@@ -11,9 +11,10 @@ extern size_t iop13xx_atue_mem_size;
 extern size_t iop13xx_atux_mem_size;
 
 struct pci_sys_data;
+struct pci_host_bridge;
 struct hw_pci;
 int iop13xx_pci_setup(int nr, struct pci_sys_data *sys);
-struct pci_bus *iop13xx_scan_bus(int nr, struct pci_sys_data *);
+int iop13xx_scan_bus(int nr, struct pci_host_bridge *bridge);
 void iop13xx_atu_select(struct hw_pci *plat_pci);
 void iop13xx_pci_init(void);
 void iop13xx_map_pci_memory(void);
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index 81ff432..2b406e9 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -194,16 +194,14 @@ static void rc_pci_fixup(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL, PCI_ANY_ID, rc_pci_fixup);
 
-static struct pci_bus __init *
-mv78xx0_pcie_scan_bus(int nr, struct pci_sys_data *sys)
+static int __init mv78xx0_pcie_scan_bus(int nr, struct pci_host_bridge *bridge)
 {
 	if (nr >= num_pcie_ports) {
 		BUG();
-		return NULL;
+		return -EINVAL;
 	}
 
-	return pci_scan_root_bus(NULL, sys->busnr, &pcie_ops, sys,
-				 &sys->resources);
+	return pci_scan_root_bus_bridge(bridge);
 }
 
 static int __init mv78xx0_pcie_map_irq(const struct pci_dev *dev, u8 slot,
diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion5x/common.h
index efeffc6..4c0c7de 100644
--- a/arch/arm/mach-orion5x/common.h
+++ b/arch/arm/mach-orion5x/common.h
@@ -54,6 +54,7 @@ void orion5x_restart(enum reboot_mode, const char *);
  * PCIe/PCI functions.
  */
 struct pci_bus;
+struct pci_host_bridge;
 struct pci_sys_data;
 struct pci_dev;
 
@@ -61,7 +62,7 @@ void orion5x_pcie_id(u32 *dev, u32 *rev);
 void orion5x_pci_disable(void);
 void orion5x_pci_set_cardbus_mode(void);
 int orion5x_pci_sys_setup(int nr, struct pci_sys_data *sys);
-struct pci_bus *orion5x_pci_sys_scan_bus(int nr, struct pci_sys_data *sys);
+int orion5x_pci_sys_scan_bus(int nr, struct pci_host_bridge *bridge);
 int orion5x_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
 
 struct tag;
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index ecb998e..76951bf 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -555,18 +555,27 @@ int __init orion5x_pci_sys_setup(int nr, struct pci_sys_data *sys)
 	return 0;
 }
 
-struct pci_bus __init *orion5x_pci_sys_scan_bus(int nr, struct pci_sys_data *sys)
+int __init orion5x_pci_sys_scan_bus(int nr, struct pci_host_bridge *bridge)
 {
-	if (nr == 0)
-		return pci_scan_root_bus(NULL, sys->busnr, &pcie_ops, sys,
-					 &sys->resources);
+	struct pci_sys_data *sys = pci_host_bridge_priv(bridge);
 
-	if (nr == 1 && !orion5x_pci_disabled)
-		return pci_scan_root_bus(NULL, sys->busnr, &pci_ops, sys,
-					 &sys->resources);
+	list_splice_init(&sys->resources, &bridge->windows);
+	bridge->dev.parent = NULL;
+	bridge->sysdata = sys;
+	bridge->busnr = sys->busnr;
+
+	if (nr == 0) {
+		bridge->ops = &pcie_ops;
+		return pci_scan_root_bus_bridge(bridge);
+	}
+
+	if (nr == 1 && !orion5x_pci_disabled) {
+		bridge->ops = &pci_ops;
+		return pci_scan_root_bus_bridge(bridge);
+	}
 
 	BUG();
-	return NULL;
+	return -ENODEV;
 }
 
 int __init orion5x_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-- 
2.10.0
