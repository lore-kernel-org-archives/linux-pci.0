Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:55290 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755176Ab2FKPFe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jun 2012 11:05:34 -0400
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-tegra@vger.kernel.org
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH v2 05/10] ARM: tegra: Rewrite PCIe support as a driver
Date: Mon, 11 Jun 2012 17:05:13 +0200
Message-Id: <1339427118-32263-6-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds a platform device driver for the PCIe controller on
Tegra SOCs. Current users of the old code (TrimSlice and Harmony) are
converted and now initialize and register a corresponding platform
device.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

---
Changes in v2:
- use struct hw_pci's new private_data field
- fix DT initialization for TrimSlice
---
 arch/arm/mach-tegra/board-dt-tegra20.c       |   15 +-
 arch/arm/mach-tegra/board-harmony-pcie.c     |   38 +-
 arch/arm/mach-tegra/board-harmony.c          |    1 +
 arch/arm/mach-tegra/board-harmony.h          |    1 +
 arch/arm/mach-tegra/board-trimslice.c        |   18 +-
 arch/arm/mach-tegra/board.h                  |    2 +-
 arch/arm/mach-tegra/devices.c                |   25 ++
 arch/arm/mach-tegra/devices.h                |    1 +
 arch/arm/mach-tegra/include/mach/iomap.h     |    6 +
 arch/arm/mach-tegra/include/mach/pci-tegra.h |   29 ++
 arch/arm/mach-tegra/pcie.c                   |  514 ++++++++++++++++----------
 11 files changed, 419 insertions(+), 231 deletions(-)
 create mode 100644 arch/arm/mach-tegra/include/mach/pci-tegra.h

diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index 9c444a0..0f29c05 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -40,6 +40,7 @@
 
 #include <mach/iomap.h>
 #include <mach/irqs.h>
+#include <mach/pci-tegra.h>
 
 #include "board.h"
 #include "board-harmony.h"
@@ -116,13 +117,17 @@ static void __init tegra_dt_init(void)
 }
 
 #ifdef CONFIG_MACH_TRIMSLICE
+static struct tegra_pcie_pdata trimslice_pcie_pdata = {
+	.enable_ports = {
+		[0] = true,
+		[1] = true,
+	},
+};
+
 static void __init trimslice_init(void)
 {
-	int ret;
-
-	ret = tegra_pcie_init(true, true);
-	if (ret)
-		pr_err("tegra_pci_init() failed: %d\n", ret);
+	tegra_pcie_device.dev.platform_data = &trimslice_pcie_pdata;
+	platform_device_register(&tegra_pcie_device);
 }
 #endif
 
diff --git a/arch/arm/mach-tegra/board-harmony-pcie.c b/arch/arm/mach-tegra/board-harmony-pcie.c
index e8c3fda..8373271 100644
--- a/arch/arm/mach-tegra/board-harmony-pcie.c
+++ b/arch/arm/mach-tegra/board-harmony-pcie.c
@@ -22,12 +22,14 @@
 
 #include <asm/mach-types.h>
 
+#include <mach/pci-tegra.h>
+
 #include "board.h"
+#include "devices.h"
 #include "board-harmony.h"
 
 #ifdef CONFIG_TEGRA_PCI
-
-int __init harmony_pcie_init(void)
+static int harmony_pcie_board_init(struct platform_device *pdev)
 {
 	struct regulator *regulator = NULL;
 	int err;
@@ -44,30 +46,32 @@ int __init harmony_pcie_init(void)
 
 	regulator_enable(regulator);
 
-	err = tegra_pcie_init(true, true);
-	if (err)
-		goto err_pcie;
-
 	return 0;
 
-err_pcie:
-	regulator_disable(regulator);
-	regulator_put(regulator);
 err_reg:
 	gpio_free(TEGRA_GPIO_EN_VDD_1V05_GPIO);
 
 	return err;
 }
 
-static int __init harmony_pcie_initcall(void)
+static struct tegra_pcie_pdata harmony_pcie_pdata = {
+	.init = harmony_pcie_board_init,
+	.enable_ports = {
+		[0] = true,
+		[1] = true,
+	},
+};
+
+int __init harmony_pcie_init(void)
 {
-	if (!machine_is_harmony())
-		return 0;
+	tegra_pcie_device.dev.platform_data = &harmony_pcie_pdata;
+	platform_device_register(&tegra_pcie_device);
 
-	return harmony_pcie_init();
+	return 0;
+}
+#else
+int __init harmony_pcie_init(void)
+{
+	return 0;
 }
-
-/* PCI should be initialized after I2C, mfd and regulators */
-subsys_initcall_sync(harmony_pcie_initcall);
-
 #endif
diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index e5f3352..063c7d5 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -204,6 +204,7 @@ static void __init tegra_harmony_init(void)
 	pwm_add_table(harmony_pwm_lookup, ARRAY_SIZE(harmony_pwm_lookup));
 	harmony_i2c_init();
 	harmony_regulator_init();
+	harmony_pcie_init();
 }
 
 MACHINE_START(HARMONY, "harmony")
diff --git a/arch/arm/mach-tegra/board-harmony.h b/arch/arm/mach-tegra/board-harmony.h
index 139d96c..afa68e2 100644
--- a/arch/arm/mach-tegra/board-harmony.h
+++ b/arch/arm/mach-tegra/board-harmony.h
@@ -37,5 +37,6 @@
 
 void harmony_pinmux_init(void);
 int harmony_regulator_init(void);
+int harmony_pcie_init(void);
 
 #endif
diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
index 776aa95..30246d2 100644
--- a/arch/arm/mach-tegra/board-trimslice.c
+++ b/arch/arm/mach-tegra/board-trimslice.c
@@ -34,6 +34,7 @@
 #include <asm/setup.h>
 
 #include <mach/iomap.h>
+#include <mach/pci-tegra.h>
 #include <mach/sdhci.h>
 
 #include "board.h"
@@ -145,14 +146,20 @@ static __initdata struct tegra_clk_init_table trimslice_clk_init_table[] = {
 	{ NULL,		NULL,		0,		0},
 };
 
-static int __init tegra_trimslice_pci_init(void)
+static struct tegra_pcie_pdata trimslice_pcie_pdata = {
+	.enable_ports = {
+		[0] = true,
+		[1] = true,
+	},
+};
+
+static int __init trimslice_pci_init(void)
 {
-	if (!machine_is_trimslice())
-		return 0;
+	tegra_pcie_device.dev.platform_data = &trimslice_pcie_pdata;
+	platform_device_register(&tegra_pcie_device);
 
-	return tegra_pcie_init(true, true);
+	return 0;
 }
-subsys_initcall(tegra_trimslice_pci_init);
 
 static void __init tegra_trimslice_init(void)
 {
@@ -167,6 +174,7 @@ static void __init tegra_trimslice_init(void)
 
 	trimslice_i2c_init();
 	trimslice_usb_init();
+	trimslice_pci_init();
 }
 
 MACHINE_START(TRIMSLICE, "trimslice")
diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h
index f88e514..3a2a7e9 100644
--- a/arch/arm/mach-tegra/board.h
+++ b/arch/arm/mach-tegra/board.h
@@ -30,7 +30,6 @@ void __init tegra30_init_early(void);
 void __init tegra_map_common_io(void);
 void __init tegra_init_irq(void);
 void __init tegra_dt_init_irq(void);
-int __init tegra_pcie_init(bool init_port0, bool init_port1);
 
 void tegra_init_late(void);
 
@@ -56,4 +55,5 @@ static inline int harmony_pcie_init(void) { return 0; }
 void __init tegra_paz00_wifikill_init(void);
 
 extern struct sys_timer tegra_timer;
+
 #endif
diff --git a/arch/arm/mach-tegra/devices.c b/arch/arm/mach-tegra/devices.c
index 4529561..de4aef9 100644
--- a/arch/arm/mach-tegra/devices.c
+++ b/arch/arm/mach-tegra/devices.c
@@ -735,3 +735,28 @@ struct platform_device tegra_nand_device = {
 	.num_resources = ARRAY_SIZE(tegra_nand_resources),
 	.resource = tegra_nand_resources,
 };
+
+static struct resource tegra_pcie_resources[] = {
+	[0] = {
+		.start = TEGRA_PCIE_BASE,
+		.end = TEGRA_PCIE_BASE + TEGRA_PCIE_SIZE - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = TEGRA_PCIE_MMIO_BASE,
+		.end = TEGRA_PCIE_MMIO_BASE + TEGRA_PCIE_MMIO_SIZE - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[2] = {
+		.start = INT_PCIE_INTR,
+		.end = INT_PCIE_INTR,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device tegra_pcie_device = {
+	.name = "tegra-pcie",
+	.id = -1,
+	.resource = tegra_pcie_resources,
+	.num_resources = ARRAY_SIZE(tegra_pcie_resources),
+};
diff --git a/arch/arm/mach-tegra/devices.h b/arch/arm/mach-tegra/devices.h
index f054d10..b2caed4 100644
--- a/arch/arm/mach-tegra/devices.h
+++ b/arch/arm/mach-tegra/devices.h
@@ -57,5 +57,6 @@ extern struct platform_device tegra_i2s_device1;
 extern struct platform_device tegra_i2s_device2;
 extern struct platform_device tegra_das_device;
 extern struct platform_device tegra_pwm_device;
+extern struct platform_device tegra_pcie_device;
 
 #endif
diff --git a/arch/arm/mach-tegra/include/mach/iomap.h b/arch/arm/mach-tegra/include/mach/iomap.h
index 3e80f3f..aee9d27 100644
--- a/arch/arm/mach-tegra/include/mach/iomap.h
+++ b/arch/arm/mach-tegra/include/mach/iomap.h
@@ -248,6 +248,12 @@
 #define TEGRA_CSITE_BASE		0x70040000
 #define TEGRA_CSITE_SIZE		SZ_256K
 
+#define TEGRA_PCIE_BASE			0x80000000
+#define TEGRA_PCIE_SIZE			SZ_4M
+
+#define TEGRA_PCIE_MMIO_BASE		0x80400000
+#define TEGRA_PCIE_MMIO_SIZE		SZ_64K
+
 #define TEGRA_USB_BASE			0xC5000000
 #define TEGRA_USB_SIZE			SZ_16K
 
diff --git a/arch/arm/mach-tegra/include/mach/pci-tegra.h b/arch/arm/mach-tegra/include/mach/pci-tegra.h
new file mode 100644
index 0000000..348a68a
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/pci-tegra.h
@@ -0,0 +1,29 @@
+/*
+ * arch/arm/mach-tegra/include/mach/tegra-pcie.h
+ *
+ * Copyright (C) 2012 Avionic Design GmbH
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __MACH_TEGRA_PCIE_H
+#define __MACH_TEGRA_PCIE_H
+
+#include <linux/platform_device.h>
+
+#define TEGRA_PCIE_MAX_PORTS 2
+
+struct tegra_pcie_pdata {
+	int (*init)(struct platform_device *pdev);
+	int (*exit)(struct platform_device *pdev);
+	bool enable_ports[TEGRA_PCIE_MAX_PORTS];
+};
+
+#endif
diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index fcdf8bc..291d55d 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -27,7 +27,9 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/pci.h>
+#include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/clk.h>
@@ -40,8 +42,8 @@
 #include <mach/iomap.h>
 #include <mach/clk.h>
 #include <mach/powergate.h>
+#include <mach/pci-tegra.h>
 
-#include "board.h"
 #include "pmc.h"
 
 /* register definitions */
@@ -161,17 +163,12 @@
  * 0x90000000 - 0x9fffffff - non-prefetchable memory
  * 0xa0000000 - 0xbfffffff - prefetchable memory
  */
-#define TEGRA_PCIE_BASE		0x80000000
-
 #define PCIE_REGS_SZ		SZ_16K
 #define PCIE_CFG_OFF		PCIE_REGS_SZ
 #define PCIE_CFG_SZ		SZ_1M
 #define PCIE_EXT_CFG_OFF	(PCIE_CFG_SZ + PCIE_CFG_OFF)
 #define PCIE_EXT_CFG_SZ		SZ_1M
-#define PCIE_IOMAP_SZ		(PCIE_REGS_SZ + PCIE_CFG_SZ + PCIE_EXT_CFG_SZ)
 
-#define MMIO_BASE		(TEGRA_PCIE_BASE + SZ_4M)
-#define MMIO_SIZE		SZ_64K
 #define MEM_BASE_0		(TEGRA_PCIE_BASE + SZ_256M)
 #define MEM_SIZE_0		SZ_128M
 #define MEM_BASE_1		(MEM_BASE_0 + MEM_SIZE_0)
@@ -201,11 +198,14 @@ struct tegra_pcie_port {
 };
 
 struct tegra_pcie_info {
-	struct tegra_pcie_port	port[2];
+	struct device		*dev;
+
+	struct tegra_pcie_port	port[TEGRA_PCIE_MAX_PORTS];
 	int			num_ports;
 
 	void __iomem		*regs;
-	struct resource		res_mmio;
+	void __iomem		*mmio;
+	int			irq;
 
 	struct clk		*pex_clk;
 	struct clk		*afi_clk;
@@ -213,55 +213,53 @@ struct tegra_pcie_info {
 	struct clk		*pll_e;
 };
 
-static struct tegra_pcie_info tegra_pcie = {
-	.res_mmio = {
-		.name = "PCI IO",
-		.start = MMIO_BASE,
-		.end = MMIO_BASE + MMIO_SIZE - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
+static inline struct tegra_pcie_info *sys_to_pcie(struct pci_sys_data *sys)
+{
+	return sys->private_data;
+}
 
 void __iomem *tegra_pcie_io_base;
 EXPORT_SYMBOL(tegra_pcie_io_base);
 
-static inline void afi_writel(u32 value, unsigned long offset)
+static inline void afi_writel(struct tegra_pcie_info *pcie, u32 value, unsigned long offset)
 {
-	writel(value, offset + AFI_OFFSET + tegra_pcie.regs);
+	writel(value, offset + AFI_OFFSET + pcie->regs);
 }
 
-static inline u32 afi_readl(unsigned long offset)
+static inline u32 afi_readl(struct tegra_pcie_info *pcie, unsigned long offset)
 {
-	return readl(offset + AFI_OFFSET + tegra_pcie.regs);
+	return readl(offset + AFI_OFFSET + pcie->regs);
 }
 
-static inline void pads_writel(u32 value, unsigned long offset)
+static inline void pads_writel(struct tegra_pcie_info *pcie, u32 value, unsigned long offset)
 {
-	writel(value, offset + PADS_OFFSET + tegra_pcie.regs);
+	writel(value, offset + PADS_OFFSET + pcie->regs);
 }
 
-static inline u32 pads_readl(unsigned long offset)
+static inline u32 pads_readl(struct tegra_pcie_info *pcie, unsigned long offset)
 {
-	return readl(offset + PADS_OFFSET + tegra_pcie.regs);
+	return readl(offset + PADS_OFFSET + pcie->regs);
 }
 
-static struct tegra_pcie_port *bus_to_port(int bus)
+static struct tegra_pcie_port *bus_to_port(struct pci_bus *bus)
 {
+	struct tegra_pcie_info *pcie = sys_to_pcie(bus->sysdata);
 	int i;
 
-	for (i = tegra_pcie.num_ports - 1; i >= 0; i--) {
-		int rbus = tegra_pcie.port[i].root_bus_nr;
-		if (rbus != -1 && rbus == bus)
+	for (i = pcie->num_ports - 1; i >= 0; i--) {
+		int rbus = pcie->port[i].root_bus_nr;
+		if (rbus != -1 && rbus == bus->number)
 			break;
 	}
 
-	return i >= 0 ? tegra_pcie.port + i : NULL;
+	return i >= 0 ? pcie->port + i : NULL;
 }
 
 static int tegra_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 				int where, int size, u32 *val)
 {
-	struct tegra_pcie_port *pp = bus_to_port(bus->number);
+	struct tegra_pcie_info *pcie = sys_to_pcie(bus->sysdata);
+	struct tegra_pcie_port *pp = bus_to_port(bus);
 	void __iomem *addr;
 
 	if (pp) {
@@ -272,10 +270,10 @@ static int tegra_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 
 		addr = pp->base + (where & ~0x3);
 	} else {
-		addr = tegra_pcie.regs + (PCIE_CONF_BUS(bus->number) +
-					  PCIE_CONF_DEV(PCI_SLOT(devfn)) +
-					  PCIE_CONF_FUNC(PCI_FUNC(devfn)) +
-					  PCIE_CONF_REG(where));
+		addr = pcie->regs + (PCIE_CONF_BUS(bus->number) +
+				     PCIE_CONF_DEV(PCI_SLOT(devfn)) +
+				     PCIE_CONF_FUNC(PCI_FUNC(devfn)) +
+				     PCIE_CONF_REG(where));
 	}
 
 	*val = readl(addr);
@@ -291,7 +289,8 @@ static int tegra_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 static int tegra_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 				 int where, int size, u32 val)
 {
-	struct tegra_pcie_port *pp = bus_to_port(bus->number);
+	struct tegra_pcie_info *pcie = sys_to_pcie(bus->sysdata);
+	struct tegra_pcie_port *pp = bus_to_port(bus);
 	void __iomem *addr;
 
 	u32 mask;
@@ -303,10 +302,10 @@ static int tegra_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 
 		addr = pp->base + (where & ~0x3);
 	} else {
-		addr = tegra_pcie.regs + (PCIE_CONF_BUS(bus->number) +
-					  PCIE_CONF_DEV(PCI_SLOT(devfn)) +
-					  PCIE_CONF_FUNC(PCI_FUNC(devfn)) +
-					  PCIE_CONF_REG(where));
+		addr = pcie->regs + (PCIE_CONF_BUS(bus->number) +
+				     PCIE_CONF_DEV(PCI_SLOT(devfn)) +
+				     PCIE_CONF_FUNC(PCI_FUNC(devfn)) +
+				     PCIE_CONF_REG(where));
 	}
 
 	if (size == 4) {
@@ -373,12 +372,13 @@ DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, tegra_pcie_relax_enable);
 
 static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 {
+	struct tegra_pcie_info *pcie = sys_to_pcie(sys);
 	struct tegra_pcie_port *pp;
 
-	if (nr >= tegra_pcie.num_ports)
+	if (nr >= pcie->num_ports)
 		return 0;
 
-	pp = tegra_pcie.port + nr;
+	pp = pcie->port + nr;
 	pp->root_bus_nr = sys->busnr;
 
 	/*
@@ -441,34 +441,29 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 	return 1;
 }
 
-static int tegra_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
 {
-	return INT_PCIE_INTR;
+	struct tegra_pcie_info *pcie = sys_to_pcie(pdev->bus->sysdata);
+
+	return pcie->irq;
 }
 
-static struct pci_bus __init *tegra_pcie_scan_bus(int nr,
-						  struct pci_sys_data *sys)
+static struct pci_bus __devinit *tegra_pcie_scan_bus(int nr,
+						     struct pci_sys_data *sys)
 {
+	struct tegra_pcie_info *pcie = sys_to_pcie(sys);
 	struct tegra_pcie_port *pp;
 
-	if (nr >= tegra_pcie.num_ports)
+	if (nr >= pcie->num_ports)
 		return NULL;
 
-	pp = tegra_pcie.port + nr;
+	pp = pcie->port + nr;
 	pp->root_bus_nr = sys->busnr;
 
 	return pci_scan_root_bus(NULL, sys->busnr, &tegra_pcie_ops, sys,
 				 &sys->resources);
 }
 
-static struct hw_pci tegra_pcie_hw __initdata = {
-	.nr_controllers	= 2,
-	.setup		= tegra_pcie_setup,
-	.scan		= tegra_pcie_scan_bus,
-	.map_irq	= tegra_pcie_map_irq,
-};
-
-
 static irqreturn_t tegra_pcie_isr(int irq, void *arg)
 {
 	const char *err_msg[] = {
@@ -482,12 +477,12 @@ static irqreturn_t tegra_pcie_isr(int irq, void *arg)
 		"AXI response decoding error",
 		"Transcation timeout",
 	};
-
+	struct tegra_pcie_info *pcie = arg;
 	u32 code, signature;
 
-	code = afi_readl(AFI_INTR_CODE) & AFI_INTR_CODE_MASK;
-	signature = afi_readl(AFI_INTR_SIGNATURE);
-	afi_writel(0, AFI_INTR_CODE);
+	code = afi_readl(pcie, AFI_INTR_CODE) & AFI_INTR_CODE_MASK;
+	signature = afi_readl(pcie, AFI_INTR_SIGNATURE);
+	afi_writel(pcie, 0, AFI_INTR_CODE);
 
 	if (code == AFI_INTR_LEGACY)
 		return IRQ_NONE;
@@ -500,14 +495,16 @@ static irqreturn_t tegra_pcie_isr(int irq, void *arg)
 	 * happen a lot during enumeration
 	 */
 	if (code == AFI_INTR_MASTER_ABORT)
-		pr_debug("PCIE: %s, signature: %08x\n", err_msg[code], signature);
+		dev_dbg(pcie->dev, "%s, signature: %08x\n", err_msg[code],
+			signature);
 	else
-		pr_err("PCIE: %s, signature: %08x\n", err_msg[code], signature);
+		dev_err(pcie->dev, "%s, signature: %08x\n", err_msg[code],
+			signature);
 
 	return IRQ_HANDLED;
 }
 
-static void tegra_pcie_setup_translations(void)
+static void tegra_pcie_setup_translations(struct tegra_pcie_info *pcie)
 {
 	u32 fpci_bar;
 	u32 size;
@@ -517,120 +514,120 @@ static void tegra_pcie_setup_translations(void)
 	fpci_bar = ((u32)0xfdff << 16);
 	size = PCIE_CFG_SZ;
 	axi_address = TEGRA_PCIE_BASE + PCIE_CFG_OFF;
-	afi_writel(axi_address, AFI_AXI_BAR0_START);
-	afi_writel(size >> 12, AFI_AXI_BAR0_SZ);
-	afi_writel(fpci_bar, AFI_FPCI_BAR0);
+	afi_writel(pcie, axi_address, AFI_AXI_BAR0_START);
+	afi_writel(pcie, size >> 12, AFI_AXI_BAR0_SZ);
+	afi_writel(pcie, fpci_bar, AFI_FPCI_BAR0);
 
 	/* Bar 1: extended config Bar */
 	fpci_bar = ((u32)0xfe1 << 20);
 	size = PCIE_EXT_CFG_SZ;
 	axi_address = TEGRA_PCIE_BASE + PCIE_EXT_CFG_OFF;
-	afi_writel(axi_address, AFI_AXI_BAR1_START);
-	afi_writel(size >> 12, AFI_AXI_BAR1_SZ);
-	afi_writel(fpci_bar, AFI_FPCI_BAR1);
+	afi_writel(pcie, axi_address, AFI_AXI_BAR1_START);
+	afi_writel(pcie, size >> 12, AFI_AXI_BAR1_SZ);
+	afi_writel(pcie, fpci_bar, AFI_FPCI_BAR1);
 
 	/* Bar 2: downstream IO bar */
 	fpci_bar = ((__u32)0xfdfc << 16);
-	size = MMIO_SIZE;
-	axi_address = MMIO_BASE;
-	afi_writel(axi_address, AFI_AXI_BAR2_START);
-	afi_writel(size >> 12, AFI_AXI_BAR2_SZ);
-	afi_writel(fpci_bar, AFI_FPCI_BAR2);
+	size = TEGRA_PCIE_MMIO_SIZE;
+	axi_address = TEGRA_PCIE_MMIO_BASE;
+	afi_writel(pcie, axi_address, AFI_AXI_BAR2_START);
+	afi_writel(pcie, size >> 12, AFI_AXI_BAR2_SZ);
+	afi_writel(pcie, fpci_bar, AFI_FPCI_BAR2);
 
 	/* Bar 3: prefetchable memory BAR */
 	fpci_bar = (((PREFETCH_MEM_BASE_0 >> 12) & 0x0fffffff) << 4) | 0x1;
 	size =  PREFETCH_MEM_SIZE_0 +  PREFETCH_MEM_SIZE_1;
 	axi_address = PREFETCH_MEM_BASE_0;
-	afi_writel(axi_address, AFI_AXI_BAR3_START);
-	afi_writel(size >> 12, AFI_AXI_BAR3_SZ);
-	afi_writel(fpci_bar, AFI_FPCI_BAR3);
+	afi_writel(pcie, axi_address, AFI_AXI_BAR3_START);
+	afi_writel(pcie, size >> 12, AFI_AXI_BAR3_SZ);
+	afi_writel(pcie, fpci_bar, AFI_FPCI_BAR3);
 
 	/* Bar 4: non prefetchable memory BAR */
 	fpci_bar = (((MEM_BASE_0 >> 12)	& 0x0FFFFFFF) << 4) | 0x1;
 	size = MEM_SIZE_0 + MEM_SIZE_1;
 	axi_address = MEM_BASE_0;
-	afi_writel(axi_address, AFI_AXI_BAR4_START);
-	afi_writel(size >> 12, AFI_AXI_BAR4_SZ);
-	afi_writel(fpci_bar, AFI_FPCI_BAR4);
+	afi_writel(pcie, axi_address, AFI_AXI_BAR4_START);
+	afi_writel(pcie, size >> 12, AFI_AXI_BAR4_SZ);
+	afi_writel(pcie, fpci_bar, AFI_FPCI_BAR4);
 
 	/* Bar 5: NULL out the remaining BAR as it is not used */
 	fpci_bar = 0;
 	size = 0;
 	axi_address = 0;
-	afi_writel(axi_address, AFI_AXI_BAR5_START);
-	afi_writel(size >> 12, AFI_AXI_BAR5_SZ);
-	afi_writel(fpci_bar, AFI_FPCI_BAR5);
+	afi_writel(pcie, axi_address, AFI_AXI_BAR5_START);
+	afi_writel(pcie, size >> 12, AFI_AXI_BAR5_SZ);
+	afi_writel(pcie, fpci_bar, AFI_FPCI_BAR5);
 
 	/* map all upstream transactions as uncached */
-	afi_writel(PHYS_OFFSET, AFI_CACHE_BAR0_ST);
-	afi_writel(0, AFI_CACHE_BAR0_SZ);
-	afi_writel(0, AFI_CACHE_BAR1_ST);
-	afi_writel(0, AFI_CACHE_BAR1_SZ);
+	afi_writel(pcie, PHYS_OFFSET, AFI_CACHE_BAR0_ST);
+	afi_writel(pcie, 0, AFI_CACHE_BAR0_SZ);
+	afi_writel(pcie, 0, AFI_CACHE_BAR1_ST);
+	afi_writel(pcie, 0, AFI_CACHE_BAR1_SZ);
 
 	/* No MSI */
-	afi_writel(0, AFI_MSI_FPCI_BAR_ST);
-	afi_writel(0, AFI_MSI_BAR_SZ);
-	afi_writel(0, AFI_MSI_AXI_BAR_ST);
-	afi_writel(0, AFI_MSI_BAR_SZ);
+	afi_writel(pcie, 0, AFI_MSI_FPCI_BAR_ST);
+	afi_writel(pcie, 0, AFI_MSI_BAR_SZ);
+	afi_writel(pcie, 0, AFI_MSI_AXI_BAR_ST);
+	afi_writel(pcie, 0, AFI_MSI_BAR_SZ);
 }
 
-static int tegra_pcie_enable_controller(void)
+static int tegra_pcie_enable_controller(struct tegra_pcie_info *pcie)
 {
 	u32 val, reg;
 	int i, timeout;
 
 	/* Enable slot clock and pulse the reset signals */
 	for (i = 0, reg = AFI_PEX0_CTRL; i < 2; i++, reg += 0x8) {
-		val = afi_readl(reg) |  AFI_PEX_CTRL_REFCLK_EN;
-		afi_writel(val, reg);
+		val = afi_readl(pcie, reg) |  AFI_PEX_CTRL_REFCLK_EN;
+		afi_writel(pcie, val, reg);
 		val &= ~AFI_PEX_CTRL_RST;
-		afi_writel(val, reg);
+		afi_writel(pcie, val, reg);
 
-		val = afi_readl(reg) | AFI_PEX_CTRL_RST;
-		afi_writel(val, reg);
+		val = afi_readl(pcie, reg) | AFI_PEX_CTRL_RST;
+		afi_writel(pcie, val, reg);
 	}
 
 	/* Enable dual controller and both ports */
-	val = afi_readl(AFI_PCIE_CONFIG);
+	val = afi_readl(pcie, AFI_PCIE_CONFIG);
 	val &= ~(AFI_PCIE_CONFIG_PCIEC0_DISABLE_DEVICE |
 		 AFI_PCIE_CONFIG_PCIEC1_DISABLE_DEVICE |
 		 AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_MASK);
 	val |= AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_DUAL;
-	afi_writel(val, AFI_PCIE_CONFIG);
+	afi_writel(pcie, val, AFI_PCIE_CONFIG);
 
-	val = afi_readl(AFI_FUSE) & ~AFI_FUSE_PCIE_T0_GEN2_DIS;
-	afi_writel(val, AFI_FUSE);
+	val = afi_readl(pcie, AFI_FUSE) & ~AFI_FUSE_PCIE_T0_GEN2_DIS;
+	afi_writel(pcie, val, AFI_FUSE);
 
 	/* Initialze internal PHY, enable up to 16 PCIE lanes */
-	pads_writel(0x0, PADS_CTL_SEL);
+	pads_writel(pcie, 0x0, PADS_CTL_SEL);
 
 	/* override IDDQ to 1 on all 4 lanes */
-	val = pads_readl(PADS_CTL) | PADS_CTL_IDDQ_1L;
-	pads_writel(val, PADS_CTL);
+	val = pads_readl(pcie, PADS_CTL) | PADS_CTL_IDDQ_1L;
+	pads_writel(pcie, val, PADS_CTL);
 
 	/*
 	 * set up PHY PLL inputs select PLLE output as refclock,
 	 * set TX ref sel to div10 (not div5)
 	 */
-	val = pads_readl(PADS_PLL_CTL);
+	val = pads_readl(pcie, PADS_PLL_CTL);
 	val &= ~(PADS_PLL_CTL_REFCLK_MASK | PADS_PLL_CTL_TXCLKREF_MASK);
 	val |= (PADS_PLL_CTL_REFCLK_INTERNAL_CML | PADS_PLL_CTL_TXCLKREF_DIV10);
-	pads_writel(val, PADS_PLL_CTL);
+	pads_writel(pcie, val, PADS_PLL_CTL);
 
 	/* take PLL out of reset  */
-	val = pads_readl(PADS_PLL_CTL) | PADS_PLL_CTL_RST_B4SM;
-	pads_writel(val, PADS_PLL_CTL);
+	val = pads_readl(pcie, PADS_PLL_CTL) | PADS_PLL_CTL_RST_B4SM;
+	pads_writel(pcie, val, PADS_PLL_CTL);
 
 	/*
 	 * Hack, set the clock voltage to the DEFAULT provided by hw folks.
 	 * This doesn't exist in the documentation
 	 */
-	pads_writel(0xfa5cfa5c, 0xc8);
+	pads_writel(pcie, 0xfa5cfa5c, 0xc8);
 
 	/* Wait for the PLL to lock */
 	timeout = 300;
 	do {
-		val = pads_readl(PADS_PLL_CTL);
+		val = pads_readl(pcie, PADS_PLL_CTL);
 		usleep_range(1000, 1000);
 		if (--timeout == 0) {
 			pr_err("Tegra PCIe error: timeout waiting for PLL\n");
@@ -639,188 +636,237 @@ static int tegra_pcie_enable_controller(void)
 	} while (!(val & PADS_PLL_CTL_LOCKDET));
 
 	/* turn off IDDQ override */
-	val = pads_readl(PADS_CTL) & ~PADS_CTL_IDDQ_1L;
-	pads_writel(val, PADS_CTL);
+	val = pads_readl(pcie, PADS_CTL) & ~PADS_CTL_IDDQ_1L;
+	pads_writel(pcie, val, PADS_CTL);
 
 	/* enable TX/RX data */
-	val = pads_readl(PADS_CTL);
+	val = pads_readl(pcie, PADS_CTL);
 	val |= (PADS_CTL_TX_DATA_EN_1L | PADS_CTL_RX_DATA_EN_1L);
-	pads_writel(val, PADS_CTL);
+	pads_writel(pcie, val, PADS_CTL);
 
 	/* Take the PCIe interface module out of reset */
-	tegra_periph_reset_deassert(tegra_pcie.pcie_xclk);
+	tegra_periph_reset_deassert(pcie->pcie_xclk);
 
 	/* Finally enable PCIe */
-	val = afi_readl(AFI_CONFIGURATION) | AFI_CONFIGURATION_EN_FPCI;
-	afi_writel(val, AFI_CONFIGURATION);
+	val = afi_readl(pcie, AFI_CONFIGURATION) | AFI_CONFIGURATION_EN_FPCI;
+	afi_writel(pcie, val, AFI_CONFIGURATION);
 
 	val = (AFI_INTR_EN_INI_SLVERR | AFI_INTR_EN_INI_DECERR |
 	       AFI_INTR_EN_TGT_SLVERR | AFI_INTR_EN_TGT_DECERR |
 	       AFI_INTR_EN_TGT_WRERR | AFI_INTR_EN_DFPCI_DECERR);
-	afi_writel(val, AFI_AFI_INTR_ENABLE);
-	afi_writel(0xffffffff, AFI_SM_INTR_ENABLE);
+	afi_writel(pcie, val, AFI_AFI_INTR_ENABLE);
+	afi_writel(pcie, 0xffffffff, AFI_SM_INTR_ENABLE);
 
 	/* FIXME: No MSI for now, only INT */
-	afi_writel(AFI_INTR_MASK_INT_MASK, AFI_INTR_MASK);
+	afi_writel(pcie, AFI_INTR_MASK_INT_MASK, AFI_INTR_MASK);
 
 	/* Disable all execptions */
-	afi_writel(0, AFI_FPCI_ERROR_MASKS);
+	afi_writel(pcie, 0, AFI_FPCI_ERROR_MASKS);
 
 	return 0;
 }
 
-static void tegra_pcie_power_off(void)
+static void tegra_pcie_power_off(struct tegra_pcie_info *pcie)
 {
-	tegra_periph_reset_assert(tegra_pcie.pcie_xclk);
-	tegra_periph_reset_assert(tegra_pcie.afi_clk);
-	tegra_periph_reset_assert(tegra_pcie.pex_clk);
+	tegra_periph_reset_assert(pcie->pcie_xclk);
+	tegra_periph_reset_assert(pcie->afi_clk);
+	tegra_periph_reset_assert(pcie->pex_clk);
 
 	tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
 	tegra_pmc_pcie_xclk_clamp(true);
 }
 
-static int tegra_pcie_power_regate(void)
+static int tegra_pcie_power_regate(struct tegra_pcie_info *pcie)
 {
 	int err;
 
-	tegra_pcie_power_off();
+	tegra_pcie_power_off(pcie);
 
 	tegra_pmc_pcie_xclk_clamp(true);
 
-	tegra_periph_reset_assert(tegra_pcie.pcie_xclk);
-	tegra_periph_reset_assert(tegra_pcie.afi_clk);
+	tegra_periph_reset_assert(pcie->pcie_xclk);
+	tegra_periph_reset_assert(pcie->afi_clk);
 
 	err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_PCIE,
-						tegra_pcie.pex_clk);
+						pcie->pex_clk);
 	if (err) {
-		pr_err("PCIE: powerup sequence failed: %d\n", err);
+		dev_err(pcie->dev, "powerup sequence failed: %d\n", err);
 		return err;
 	}
 
-	tegra_periph_reset_deassert(tegra_pcie.afi_clk);
+	tegra_periph_reset_deassert(pcie->afi_clk);
 
 	tegra_pmc_pcie_xclk_clamp(false);
 
-	clk_enable(tegra_pcie.afi_clk);
-	clk_enable(tegra_pcie.pex_clk);
-	return clk_enable(tegra_pcie.pll_e);
+	clk_enable(pcie->afi_clk);
+	clk_enable(pcie->pex_clk);
+	return clk_enable(pcie->pll_e);
 }
 
-static int tegra_pcie_clocks_get(void)
+static int tegra_pcie_clocks_get(struct tegra_pcie_info *pcie)
 {
 	int err;
 
-	tegra_pcie.pex_clk = clk_get(NULL, "pex");
-	if (IS_ERR(tegra_pcie.pex_clk))
-		return PTR_ERR(tegra_pcie.pex_clk);
+	pcie->pex_clk = clk_get(NULL, "pex");
+	if (IS_ERR(pcie->pex_clk))
+		return PTR_ERR(pcie->pex_clk);
 
-	tegra_pcie.afi_clk = clk_get(NULL, "afi");
-	if (IS_ERR(tegra_pcie.afi_clk)) {
-		err = PTR_ERR(tegra_pcie.afi_clk);
+	pcie->afi_clk = clk_get(NULL, "afi");
+	if (IS_ERR(pcie->afi_clk)) {
+		err = PTR_ERR(pcie->afi_clk);
 		goto err_afi_clk;
 	}
 
-	tegra_pcie.pcie_xclk = clk_get(NULL, "pcie_xclk");
-	if (IS_ERR(tegra_pcie.pcie_xclk)) {
-		err =  PTR_ERR(tegra_pcie.pcie_xclk);
+	pcie->pcie_xclk = clk_get(NULL, "pcie_xclk");
+	if (IS_ERR(pcie->pcie_xclk)) {
+		err = PTR_ERR(pcie->pcie_xclk);
 		goto err_pcie_xclk;
 	}
 
-	tegra_pcie.pll_e = clk_get_sys(NULL, "pll_e");
-	if (IS_ERR(tegra_pcie.pll_e)) {
-		err = PTR_ERR(tegra_pcie.pll_e);
+	pcie->pll_e = clk_get_sys(NULL, "pll_e");
+	if (IS_ERR(pcie->pll_e)) {
+		err = PTR_ERR(pcie->pll_e);
 		goto err_pll_e;
 	}
 
 	return 0;
 
 err_pll_e:
-	clk_put(tegra_pcie.pcie_xclk);
+	clk_put(pcie->pcie_xclk);
 err_pcie_xclk:
-	clk_put(tegra_pcie.afi_clk);
+	clk_put(pcie->afi_clk);
 err_afi_clk:
-	clk_put(tegra_pcie.pex_clk);
+	clk_put(pcie->pex_clk);
 
 	return err;
 }
 
-static void tegra_pcie_clocks_put(void)
+static void tegra_pcie_clocks_put(struct tegra_pcie_info *pcie)
 {
-	clk_put(tegra_pcie.pll_e);
-	clk_put(tegra_pcie.pcie_xclk);
-	clk_put(tegra_pcie.afi_clk);
-	clk_put(tegra_pcie.pex_clk);
+	clk_put(pcie->pll_e);
+	clk_put(pcie->pcie_xclk);
+	clk_put(pcie->afi_clk);
+	clk_put(pcie->pex_clk);
 }
 
-static int __init tegra_pcie_get_resources(void)
+static int __devinit tegra_pcie_get_resources(struct platform_device *pdev)
 {
-	struct resource *res_mmio = &tegra_pcie.res_mmio;
+	struct tegra_pcie_info *pcie = platform_get_drvdata(pdev);
+	struct resource *regs;
+	struct resource *mmio;
 	int err;
 
-	err = tegra_pcie_clocks_get();
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mmio = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+
+	if (!regs || !mmio) {
+		dev_err(&pdev->dev, "failed to get I/O resources\n");
+		return -ENXIO;
+	}
+
+	err = tegra_pcie_clocks_get(pcie);
 	if (err) {
-		pr_err("PCIE: failed to get clocks: %d\n", err);
+		dev_err(&pdev->dev, "failed to get clocks: %d\n", err);
 		return err;
 	}
 
-	err = tegra_pcie_power_regate();
+	err = tegra_pcie_power_regate(pcie);
 	if (err) {
-		pr_err("PCIE: failed to power up: %d\n", err);
+		dev_err(&pdev->dev, "failed to power up: %d\n", err);
 		goto err_pwr_on;
 	}
 
-	tegra_pcie.regs = ioremap_nocache(TEGRA_PCIE_BASE, PCIE_IOMAP_SZ);
-	if (tegra_pcie.regs == NULL) {
-		pr_err("PCIE: Failed to map PCI/AFI registers\n");
+	regs = request_mem_region(regs->start, resource_size(regs), "PCI/AFI");
+	if (regs == NULL) {
+		dev_err(&pdev->dev, "failed to request PCI/AFI region: %d\n", err);
+		goto err_req_reg;
+	}
+
+	pcie->regs = ioremap_nocache(regs->start, resource_size(regs));
+	if (pcie->regs == NULL) {
+		dev_err(&pdev->dev, "failed to map PCI/AFI registers\n");
 		err = -ENOMEM;
 		goto err_map_reg;
 	}
 
-	err = request_resource(&iomem_resource, res_mmio);
-	if (err) {
-		pr_err("PCIE: Failed to request resources: %d\n", err);
+	mmio = request_mem_region(mmio->start, resource_size(mmio), "PCI I/O");
+	if (mmio == NULL) {
+		dev_err(&pdev->dev, "failed to request PCI I/O region: %d\n", err);
 		goto err_req_io;
 	}
 
-	tegra_pcie_io_base = ioremap_nocache(res_mmio->start,
-					     resource_size(res_mmio));
-	if (tegra_pcie_io_base == NULL) {
-		pr_err("PCIE: Failed to map IO\n");
+	pcie->mmio = ioremap_nocache(mmio->start, resource_size(mmio));
+	if (pcie->mmio == NULL) {
+		dev_err(&pdev->dev, "failed to map PCI I/O region\n");
 		err = -ENOMEM;
 		goto err_map_io;
 	}
 
-	err = request_irq(INT_PCIE_INTR, tegra_pcie_isr,
-			  IRQF_SHARED, "PCIE", &tegra_pcie);
+	tegra_pcie_io_base = pcie->mmio;
+
+	err = platform_get_irq(pdev, 0);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to get IRQ: %d\n", err);
+		goto err_irq;
+	}
+
+	pcie->irq = err;
+
+	err = request_irq(pcie->irq, tegra_pcie_isr, IRQF_SHARED, "PCIE",
+			  pcie);
 	if (err) {
-		pr_err("PCIE: Failed to register IRQ: %d\n", err);
+		dev_err(&pdev->dev, "failed to register IRQ: %d\n", err);
 		goto err_irq;
 	}
-	set_irq_flags(INT_PCIE_INTR, IRQF_VALID);
 
 	return 0;
 
 err_irq:
-	iounmap(tegra_pcie_io_base);
+	iounmap(pcie->mmio);
 err_map_io:
-	release_resource(&tegra_pcie.res_mmio);
+	release_resource(mmio);
 err_req_io:
-	iounmap(tegra_pcie.regs);
+	iounmap(pcie->regs);
 err_map_reg:
-	tegra_pcie_power_off();
+	release_resource(regs);
+err_req_reg:
+	tegra_pcie_power_off(pcie);
 err_pwr_on:
-	tegra_pcie_clocks_put();
+	tegra_pcie_clocks_put(pcie);
 
 	return err;
 }
 
+static int tegra_pcie_put_resources(struct platform_device *pdev)
+{
+	struct tegra_pcie_info *pcie = platform_get_drvdata(pdev);
+	struct resource *regs;
+	struct resource *mmio;
+
+	free_irq(pcie->irq, pcie);
+
+	iounmap(pcie->mmio);
+	mmio = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	release_resource(mmio);
+
+	iounmap(pcie->regs);
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_resource(regs);
+
+	tegra_pcie_power_off(pcie);
+	tegra_pcie_clocks_put(pcie);
+
+	return 0;
+}
+
 /*
  * FIXME: If there are no PCIe cards attached, then calling this function
  * can result in the increase of the bootup time as there are big timeout
  * loops.
  */
 #define TEGRA_PCIE_LINKUP_TIMEOUT	200	/* up to 1.2 seconds */
-static bool tegra_pcie_check_link(struct tegra_pcie_port *pp, int idx,
+static bool tegra_pcie_check_link(struct tegra_pcie_info *pcie,
+				  struct tegra_pcie_port *pp, int idx,
 				  u32 reset_reg)
 {
 	u32 reg;
@@ -840,7 +886,7 @@ static bool tegra_pcie_check_link(struct tegra_pcie_port *pp, int idx,
 		}
 
 		if (!timeout)  {
-			pr_err("PCIE: port %d: link down, retrying\n", idx);
+			dev_err(pcie->dev, "port %d: link down, retrying\n", idx);
 			goto retry;
 		}
 
@@ -857,11 +903,11 @@ static bool tegra_pcie_check_link(struct tegra_pcie_port *pp, int idx,
 
 retry:
 		/* Pulse the PEX reset */
-		reg = afi_readl(reset_reg) | AFI_PEX_CTRL_RST;
-		afi_writel(reg, reset_reg);
+		reg = afi_readl(pcie, reset_reg) | AFI_PEX_CTRL_RST;
+		afi_writel(pcie, reg, reset_reg);
 		mdelay(1);
-		reg = afi_readl(reset_reg) & ~AFI_PEX_CTRL_RST;
-		afi_writel(reg, reset_reg);
+		reg = afi_readl(pcie, reset_reg) & ~AFI_PEX_CTRL_RST;
+		afi_writel(pcie, reg, reset_reg);
 
 		retries--;
 	} while (retries);
@@ -869,55 +915,117 @@ retry:
 	return false;
 }
 
-static void __init tegra_pcie_add_port(int index, u32 offset, u32 reset_reg)
+static void __devinit tegra_pcie_add_port(struct tegra_pcie_info *pcie,
+					  int index, u32 offset,
+					  u32 reset_reg)
 {
 	struct tegra_pcie_port *pp;
 
-	pp = tegra_pcie.port + tegra_pcie.num_ports;
+	pp = pcie->port + pcie->num_ports;
 
 	pp->index = -1;
-	pp->base = tegra_pcie.regs + offset;
-	pp->link_up = tegra_pcie_check_link(pp, index, reset_reg);
+	pp->base = pcie->regs + offset;
+	pp->link_up = tegra_pcie_check_link(pcie, pp, index, reset_reg);
 
 	if (!pp->link_up) {
 		pp->base = NULL;
-		printk(KERN_INFO "PCIE: port %d: link down, ignoring\n", index);
+		dev_info(pcie->dev, "port %d: link down, ignoring\n", index);
 		return;
 	}
 
-	tegra_pcie.num_ports++;
+	pcie->num_ports++;
 	pp->index = index;
 	pp->root_bus_nr = -1;
 	memset(pp->res, 0, sizeof(pp->res));
 }
 
-int __init tegra_pcie_init(bool init_port0, bool init_port1)
+static int __devinit tegra_pcie_probe(struct platform_device *pdev)
 {
+	struct tegra_pcie_pdata *pdata = pdev->dev.platform_data;
+	void *private_data[TEGRA_PCIE_MAX_PORTS];
+	struct tegra_pcie_info *pcie;
+	struct hw_pci hw;
 	int err;
 
-	if (!(init_port0 || init_port1))
+	if (!pdata->enable_ports[0] && !pdata->enable_ports[1])
 		return -ENODEV;
 
+	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pcie);
+	pcie->dev = &pdev->dev;
+
 	pcibios_min_mem = 0;
 
-	err = tegra_pcie_get_resources();
-	if (err)
+	err = tegra_pcie_get_resources(pdev);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to request resources: %d\n", err);
 		return err;
+	}
+
+	if (pdata->init) {
+		err = pdata->init(pdev);
+		if (err < 0) {
+			tegra_pcie_put_resources(pdev);
+			return err;
+		}
+	}
 
-	err = tegra_pcie_enable_controller();
+	err = tegra_pcie_enable_controller(pcie);
 	if (err)
 		return err;
 
 	/* setup the AFI address translations */
-	tegra_pcie_setup_translations();
+	tegra_pcie_setup_translations(pcie);
 
-	if (init_port0)
-		tegra_pcie_add_port(0, RP0_OFFSET, AFI_PEX0_CTRL);
+	if (pdata->enable_ports[0]) {
+		tegra_pcie_add_port(pcie, 0, RP0_OFFSET, AFI_PEX0_CTRL);
+		private_data[0] = pcie;
+	}
+
+	if (pdata->enable_ports[1]) {
+		tegra_pcie_add_port(pcie, 1, RP1_OFFSET, AFI_PEX1_CTRL);
+		private_data[1] = pcie;
+	}
 
-	if (init_port1)
-		tegra_pcie_add_port(1, RP1_OFFSET, AFI_PEX1_CTRL);
+	memset(&hw, 0, sizeof(hw));
+	hw.nr_controllers = 2;
+	hw.private_data = private_data;
+	hw.setup = tegra_pcie_setup;
+	hw.scan = tegra_pcie_scan_bus;
+	hw.map_irq = tegra_pcie_map_irq;
 
-	pci_common_init(&tegra_pcie_hw);
+	pci_common_init(&hw);
 
 	return 0;
 }
+
+static int __devexit tegra_pcie_remove(struct platform_device *pdev)
+{
+	struct tegra_pcie_pdata *pdata = pdev->dev.platform_data;
+	int err;
+
+	err = tegra_pcie_put_resources(pdev);
+	if (err < 0)
+		return err;
+
+	if (pdata->exit) {
+		err = pdata->exit(pdev);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static struct platform_driver tegra_pcie_driver = {
+	.driver = {
+		.name = "tegra-pcie",
+		.owner = THIS_MODULE,
+	},
+	.probe = tegra_pcie_probe,
+	.remove = __devexit_p(tegra_pcie_remove),
+};
+module_platform_driver(tegra_pcie_driver);
-- 
1.7.10.4

