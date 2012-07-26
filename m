Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:58524 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595Ab2GZTza (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jul 2012 15:55:30 -0400
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-tegra@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 06/10] ARM: tegra: Rewrite PCIe support as a driver
Date: Thu, 26 Jul 2012 21:55:08 +0200
Message-Id: <1343332512-28762-7-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds a platform device driver for the PCIe controller on
Tegra SOCs. Current users of the old code (TrimSlice and Harmony) are
converted and now initialize and register a corresponding platform
device.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v3:
- use devm_request_and_ioremap() and devm_clk_get()
- make root ports separate devices
- fix extended configuration space access

Changes in v2:
- use struct hw_pci's new private_data field
- fix DT initialization for TrimSlice

 arch/arm/mach-tegra/board-harmony-pcie.c     |  30 +-
 arch/arm/mach-tegra/board-harmony.c          |   1 +
 arch/arm/mach-tegra/board-harmony.h          |   1 +
 arch/arm/mach-tegra/board-trimslice.c        |  11 +-
 arch/arm/mach-tegra/board.h                  |   2 +-
 arch/arm/mach-tegra/devices.c                | 135 ++++
 arch/arm/mach-tegra/devices.h                |   3 +
 arch/arm/mach-tegra/include/mach/iomap.h     |   3 -
 arch/arm/mach-tegra/include/mach/pci-tegra.h |  38 ++
 arch/arm/mach-tegra/pcie.c                   | 926 ++++++++++++++++-----------
 10 files changed, 732 insertions(+), 418 deletions(-)
 create mode 100644 arch/arm/mach-tegra/include/mach/pci-tegra.h

diff --git a/arch/arm/mach-tegra/board-harmony-pcie.c b/arch/arm/mach-tegra/board-harmony-pcie.c
index e8c3fda..712f3bd 100644
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
@@ -44,30 +46,24 @@ int __init harmony_pcie_init(void)
 
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
+int __init harmony_pcie_init(void)
 {
-	if (!machine_is_harmony())
-		return 0;
+	tegra_pcie_pdata.init = harmony_pcie_board_init;
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
index 776aa95..2667fe9 100644
--- a/arch/arm/mach-tegra/board-trimslice.c
+++ b/arch/arm/mach-tegra/board-trimslice.c
@@ -34,6 +34,7 @@
 #include <asm/setup.h>
 
 #include <mach/iomap.h>
+#include <mach/pci-tegra.h>
 #include <mach/sdhci.h>
 
 #include "board.h"
@@ -145,14 +146,11 @@ static __initdata struct tegra_clk_init_table trimslice_clk_init_table[] = {
 	{ NULL,		NULL,		0,		0},
 };
 
-static int __init tegra_trimslice_pci_init(void)
+static int __init trimslice_pci_init(void)
 {
-	if (!machine_is_trimslice())
-		return 0;
-
-	return tegra_pcie_init(true, true);
+	platform_device_register(&tegra_pcie_device);
+	return 0;
 }
-subsys_initcall(tegra_trimslice_pci_init);
 
 static void __init tegra_trimslice_init(void)
 {
@@ -167,6 +165,7 @@ static void __init tegra_trimslice_init(void)
 
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
index 4529561..203af2e 100644
--- a/arch/arm/mach-tegra/devices.c
+++ b/arch/arm/mach-tegra/devices.c
@@ -28,6 +28,7 @@
 #include <mach/iomap.h>
 #include <mach/dma.h>
 #include <mach/usb_phy.h>
+#include <mach/pci-tegra.h>
 
 #include "gpio-names.h"
 #include "devices.h"
@@ -735,3 +736,137 @@ struct platform_device tegra_nand_device = {
 	.num_resources = ARRAY_SIZE(tegra_nand_resources),
 	.resource = tegra_nand_resources,
 };
+
+static struct resource tegra_pcie_resources[] = {
+	/* PADS registers */
+	[0] = {
+		.start = 0x80003000,
+		.end = 0x800037ff,
+		.flags = IORESOURCE_MEM,
+	},
+	/* AFI registers */
+	[1] = {
+		.start = 0x80003800,
+		.end = 0x800039ff,
+		.flags = IORESOURCE_MEM,
+	},
+	/* PCI configuration space */
+	[2] = {
+		.start = 0x81000000,
+		.end = 0x81000000 + SZ_16M - 1,
+		.flags = IORESOURCE_MEM | IORESOURCE_PCI_CS,
+	},
+	/* PCI extended configuration space */
+	[3] = {
+		.start = 0x90000000,
+		.end = 0x90000000 + SZ_256M - 1,
+		.flags = IORESOURCE_MEM | IORESOURCE_PCI_CS,
+	},
+	[4] = {
+		.start = INT_PCIE_INTR,
+		.end = INT_PCIE_INTR,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct resource tegra_pcie_rp0_resources[] = {
+	[0] = {
+		.start = 0x80000000,
+		.end = 0x80000000 + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static struct resource tegra_pcie_rp0_ranges[] = {
+	[0] = {
+		.start = 0x81000000,
+		.end = 0x81000000 + SZ_8M - 1,
+		.flags = IORESOURCE_MEM | IORESOURCE_PCI_CS,
+	},
+	[1] = {
+		.start = 0x90000000,
+		.end = 0x90000000 + SZ_128M - 1,
+		.flags = IORESOURCE_MEM | IORESOURCE_PCI_CS,
+	},
+	[2] = {
+		.start = 0x82000000,
+		.end = 0x82000000 + SZ_64K - 1,
+		.flags = IORESOURCE_IO,
+	},
+	[3] = {
+		.start = 0xa0000000,
+		.end = 0xa0000000 + SZ_128M - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[4] = {
+		.start = 0xb0000000,
+		.end = 0xb0000000 + SZ_128M - 1,
+		.flags = IORESOURCE_MEM | IORESOURCE_PREFETCH,
+	},
+};
+
+static struct resource tegra_pcie_rp1_resources[] = {
+	[0] = {
+		.start = 0x80001000,
+		.end = 0x80001000 + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static struct resource tegra_pcie_rp1_ranges[] = {
+	[0] = {
+		.start = 0x81800000,
+		.end = 0x81800000 + SZ_8M - 1,
+		.flags = IORESOURCE_MEM | IORESOURCE_PCI_CS,
+	},
+	[1] = {
+		.start = 0x98000000,
+		.end = 0x98000000 + SZ_128M - 1,
+		.flags = IORESOURCE_MEM | IORESOURCE_PCI_CS,
+	},
+	[2] = {
+		.start = 0x82010000,
+		.end = 0x82010000 + SZ_64K - 1,
+		.flags = IORESOURCE_IO,
+	},
+	[3] = {
+		.start = 0xa8000000,
+		.end = 0xa8000000 + SZ_128M - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[4] = {
+		.start = 0xb8000000,
+		.end = 0xb8000000 + SZ_128M - 1,
+		.flags = IORESOURCE_MEM | IORESOURCE_PREFETCH,
+	},
+};
+
+static struct tegra_pcie_rp tegra_pcie_ports[] = {
+	[0] = {
+		.resources = tegra_pcie_rp0_resources,
+		.num_resources = ARRAY_SIZE(tegra_pcie_rp0_resources),
+		.ranges = tegra_pcie_rp0_ranges,
+		.num_ranges = ARRAY_SIZE(tegra_pcie_rp0_ranges),
+		.num_lanes = 2,
+	},
+	[1] = {
+		.resources = tegra_pcie_rp1_resources,
+		.num_resources = ARRAY_SIZE(tegra_pcie_rp1_resources),
+		.ranges = tegra_pcie_rp1_ranges,
+		.num_ranges = ARRAY_SIZE(tegra_pcie_rp1_ranges),
+		.num_lanes = 2,
+	},
+};
+
+struct tegra_pcie_pdata tegra_pcie_pdata = {
+	.ports = tegra_pcie_ports,
+	.num_ports = ARRAY_SIZE(tegra_pcie_ports),
+};
+
+struct platform_device tegra_pcie_device = {
+	.name = "tegra-pcie",
+	.id = -1,
+	.resource = tegra_pcie_resources,
+	.num_resources = ARRAY_SIZE(tegra_pcie_resources),
+	.dev.platform_data = &tegra_pcie_pdata,
+};
diff --git a/arch/arm/mach-tegra/devices.h b/arch/arm/mach-tegra/devices.h
index f054d10..eb28671 100644
--- a/arch/arm/mach-tegra/devices.h
+++ b/arch/arm/mach-tegra/devices.h
@@ -58,4 +58,7 @@ extern struct platform_device tegra_i2s_device2;
 extern struct platform_device tegra_das_device;
 extern struct platform_device tegra_pwm_device;
 
+extern struct tegra_pcie_pdata tegra_pcie_pdata;
+extern struct platform_device tegra_pcie_device;
+
 #endif
diff --git a/arch/arm/mach-tegra/include/mach/iomap.h b/arch/arm/mach-tegra/include/mach/iomap.h
index fee3a94..7e76da7 100644
--- a/arch/arm/mach-tegra/include/mach/iomap.h
+++ b/arch/arm/mach-tegra/include/mach/iomap.h
@@ -303,9 +303,6 @@
 #define IO_APB_VIRT	IOMEM(0xFE300000)
 #define IO_APB_SIZE	SZ_1M
 
-#define TEGRA_PCIE_BASE		0x80000000
-#define TEGRA_PCIE_IO_BASE	(TEGRA_PCIE_BASE + SZ_4M)
-
 #define IO_TO_VIRT_BETWEEN(p, st, sz)	((p) >= (st) && (p) < ((st) + (sz)))
 #define IO_TO_VIRT_XLATE(p, pst, vst)	(((p) - (pst) + (vst)))
 
diff --git a/arch/arm/mach-tegra/include/mach/pci-tegra.h b/arch/arm/mach-tegra/include/mach/pci-tegra.h
new file mode 100644
index 0000000..e6d9fc3
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/pci-tegra.h
@@ -0,0 +1,38 @@
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
+struct tegra_pcie_rp {
+	unsigned int index;
+	struct resource *resources;
+	unsigned int num_resources;
+	struct resource *ranges;
+	unsigned int num_ranges;
+	unsigned int num_lanes;
+};
+
+struct tegra_pcie_pdata {
+	int (*init)(struct platform_device *pdev);
+	int (*exit)(struct platform_device *pdev);
+
+	struct tegra_pcie_rp *ports;
+	unsigned int num_ports;
+};
+
+#endif
diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index efe71dd..3e5fb66 100644
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
@@ -35,20 +37,17 @@
 #include <linux/export.h>
 
 #include <asm/sizes.h>
+#include <asm/mach/irq.h>
 #include <asm/mach/pci.h>
 
 #include <mach/iomap.h>
 #include <mach/clk.h>
 #include <mach/powergate.h>
+#include <mach/pci-tegra.h>
 
-#include "board.h"
 #include "pmc.h"
 
 /* register definitions */
-#define AFI_OFFSET	0x3800
-#define PADS_OFFSET	0x3000
-#define RP0_OFFSET	0x0000
-#define RP1_OFFSET	0x1000
 
 #define AFI_AXI_BAR0_SZ	0x00
 #define AFI_AXI_BAR1_SZ	0x04
@@ -161,141 +160,146 @@
  * 0x90000000 - 0x9fffffff - non-prefetchable memory
  * 0xa0000000 - 0xbfffffff - prefetchable memory
  */
-#define PCIE_REGS_SZ		SZ_16K
-#define PCIE_CFG_OFF		PCIE_REGS_SZ
-#define PCIE_CFG_SZ		SZ_1M
-#define PCIE_EXT_CFG_OFF	(PCIE_CFG_SZ + PCIE_CFG_OFF)
-#define PCIE_EXT_CFG_SZ		SZ_1M
-#define PCIE_IOMAP_SZ		(PCIE_REGS_SZ + PCIE_CFG_SZ + PCIE_EXT_CFG_SZ)
-
-#define MEM_BASE_0		(TEGRA_PCIE_BASE + SZ_256M)
-#define MEM_SIZE_0		SZ_128M
-#define MEM_BASE_1		(MEM_BASE_0 + MEM_SIZE_0)
-#define MEM_SIZE_1		SZ_128M
-#define PREFETCH_MEM_BASE_0	(MEM_BASE_1 + MEM_SIZE_1)
-#define PREFETCH_MEM_SIZE_0	SZ_128M
-#define PREFETCH_MEM_BASE_1	(PREFETCH_MEM_BASE_0 + PREFETCH_MEM_SIZE_0)
-#define PREFETCH_MEM_SIZE_1	SZ_128M
-
-#define  PCIE_CONF_BUS(b)	((b) << 16)
-#define  PCIE_CONF_DEV(d)	((d) << 11)
-#define  PCIE_CONF_FUNC(f)	((f) << 8)
-#define  PCIE_CONF_REG(r)	\
-	(((r) & ~0x3) | (((r) < 256) ? PCIE_CFG_OFF : PCIE_EXT_CFG_OFF))
 
-struct tegra_pcie_port {
-	int			index;
-	u8			root_bus_nr;
-	void __iomem		*base;
+#define PCIE_CONF_BUS(b)	((b) << 16)
+#define PCIE_CONF_DEV(d)	((d) << 11)
+#define PCIE_CONF_FUNC(f)	((f) << 8)
+#define PCIE_CONF_REG(r)	((((r) & 0xf00) << 16) | ((r) & ~3))
 
-	bool			link_up;
+struct tegra_pcie {
+	struct device *dev;
 
-	char			mem_space_name[16];
-	char			prefetch_space_name[20];
-	struct resource		res[2];
-};
+	void __iomem *pads;
+	void __iomem *afi;
+	int irq;
+
+	struct resource *cfg;
+	struct resource *extcfg;
 
-struct tegra_pcie_info {
-	struct tegra_pcie_port	port[2];
-	int			num_ports;
+	void __iomem *cs;
+	void __iomem *extcs;
 
-	void __iomem		*regs;
-	struct resource		res_mmio;
+	struct resource io;
+	struct resource mem;
+	struct resource prefetch;
 
-	struct clk		*pex_clk;
-	struct clk		*afi_clk;
-	struct clk		*pcie_xclk;
-	struct clk		*pll_e;
+	struct clk *pex_clk;
+	struct clk *afi_clk;
+	struct clk *pcie_xclk;
+	struct clk *pll_e;
+
+	struct list_head ports;
+	unsigned int num_ports;
 };
 
-static struct tegra_pcie_info tegra_pcie;
+struct tegra_pcie_port {
+	struct tegra_pcie *pcie;
+
+	void __iomem *base;
+	unsigned int index;
+
+	struct resource io;
+	struct resource mem;
+	struct resource prefetch;
+
+	struct list_head list;
+};
 
-static inline void afi_writel(u32 value, unsigned long offset)
+static inline struct tegra_pcie_port *sys_to_pcie(struct pci_sys_data *sys)
 {
-	writel(value, offset + AFI_OFFSET + tegra_pcie.regs);
+	return sys->private_data;
 }
 
-static inline u32 afi_readl(unsigned long offset)
+static inline void afi_writel(struct tegra_pcie *pcie, u32 value,
+			      unsigned long offset)
 {
-	return readl(offset + AFI_OFFSET + tegra_pcie.regs);
+	writel(value, pcie->afi + offset);
 }
 
-static inline void pads_writel(u32 value, unsigned long offset)
+static inline u32 afi_readl(struct tegra_pcie *pcie, unsigned long offset)
 {
-	writel(value, offset + PADS_OFFSET + tegra_pcie.regs);
+	return readl(pcie->afi + offset);
 }
 
-static inline u32 pads_readl(unsigned long offset)
+static inline void pads_writel(struct tegra_pcie *pcie, u32 value,
+			       unsigned long offset)
 {
-	return readl(offset + PADS_OFFSET + tegra_pcie.regs);
+	writel(value, pcie->pads + offset);
 }
 
-static struct tegra_pcie_port *bus_to_port(int bus)
+static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
 {
-	int i;
-
-	for (i = tegra_pcie.num_ports - 1; i >= 0; i--) {
-		int rbus = tegra_pcie.port[i].root_bus_nr;
-		if (rbus != -1 && rbus == bus)
-			break;
-	}
-
-	return i >= 0 ? tegra_pcie.port + i : NULL;
+	return readl(pcie->pads + offset);
 }
 
 static int tegra_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
-				int where, int size, u32 *val)
+				int where, int size, u32 *value)
 {
-	struct tegra_pcie_port *pp = bus_to_port(bus->number);
-	void __iomem *addr;
+	struct tegra_pcie_port *port = sys_to_pcie(bus->sysdata);
+	struct tegra_pcie *pcie = port->pcie;
+	unsigned long offset = -1;
+	void __iomem *addr = NULL;
 
-	if (pp) {
+	if (!bus->parent) {
 		if (devfn != 0) {
-			*val = 0xffffffff;
+			*value = 0xffffffff;
 			return PCIBIOS_DEVICE_NOT_FOUND;
 		}
 
-		addr = pp->base + (where & ~0x3);
+		addr = port->base + (where & ~0x3);
 	} else {
-		addr = tegra_pcie.regs + (PCIE_CONF_BUS(bus->number) +
-					  PCIE_CONF_DEV(PCI_SLOT(devfn)) +
-					  PCIE_CONF_FUNC(PCI_FUNC(devfn)) +
-					  PCIE_CONF_REG(where));
+		if (where >= 0x100)
+			addr = pcie->extcs;
+		else
+			addr = pcie->cs;
+
+		offset = PCIE_CONF_BUS(bus->number) +
+			 PCIE_CONF_DEV(PCI_SLOT(devfn)) +
+			 PCIE_CONF_FUNC(PCI_FUNC(devfn)) +
+			 PCIE_CONF_REG(where);
+		addr += offset;
 	}
 
-	*val = readl(addr);
+	*value = readl(addr);
 
 	if (size == 1)
-		*val = (*val >> (8 * (where & 3))) & 0xff;
+		*value = (*value >> (8 * (where & 3))) & 0xff;
 	else if (size == 2)
-		*val = (*val >> (8 * (where & 3))) & 0xffff;
+		*value = (*value >> (8 * (where & 3))) & 0xffff;
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static int tegra_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
-				 int where, int size, u32 val)
+				 int where, int size, u32 value)
 {
-	struct tegra_pcie_port *pp = bus_to_port(bus->number);
+	struct tegra_pcie_port *port = sys_to_pcie(bus->sysdata);
+	struct tegra_pcie *pcie = port->pcie;
+	unsigned long offset = -1;
 	void __iomem *addr;
-
 	u32 mask;
 	u32 tmp;
 
-	if (pp) {
+	if (!bus->parent) {
 		if (devfn != 0)
 			return PCIBIOS_DEVICE_NOT_FOUND;
 
-		addr = pp->base + (where & ~0x3);
+		addr = port->base + (where & ~0x3);
 	} else {
-		addr = tegra_pcie.regs + (PCIE_CONF_BUS(bus->number) +
-					  PCIE_CONF_DEV(PCI_SLOT(devfn)) +
-					  PCIE_CONF_FUNC(PCI_FUNC(devfn)) +
-					  PCIE_CONF_REG(where));
+		if (where >= 0x100)
+			addr = pcie->extcs;
+		else
+			addr = pcie->cs;
+
+		offset = PCIE_CONF_BUS(bus->number) +
+			 PCIE_CONF_DEV(PCI_SLOT(devfn)) +
+			 PCIE_CONF_FUNC(PCI_FUNC(devfn)) +
+			 PCIE_CONF_REG(where);
+		addr += offset;
 	}
 
 	if (size == 4) {
-		writel(val, addr);
+		writel(value, addr);
 		return PCIBIOS_SUCCESSFUL;
 	}
 
@@ -307,7 +311,7 @@ static int tegra_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	tmp = readl(addr) & mask;
-	tmp |= val << ((where & 0x3) * 8);
+	tmp |= value << ((where & 0x3) * 8);
 	writel(tmp, addr);
 
 	return PCIBIOS_SUCCESSFUL;
@@ -358,85 +362,36 @@ DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, tegra_pcie_relax_enable);
 
 static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 {
-	struct tegra_pcie_port *pp;
-
-	if (nr >= tegra_pcie.num_ports)
-		return 0;
+	struct tegra_pcie_port *port = sys_to_pcie(sys);
 
-	pp = tegra_pcie.port + nr;
-	pp->root_bus_nr = sys->busnr;
+	pci_add_resource_offset(&sys->resources, &port->io,
+				sys->io_offset);
+	pci_add_resource_offset(&sys->resources, &port->mem,
+				sys->mem_offset);
+	pci_add_resource_offset(&sys->resources, &port->prefetch,
+				sys->mem_offset);
 
-	pci_ioremap_io(nr * SZ_64K, TEGRA_PCIE_IO_BASE);
-
-	/*
-	 * IORESOURCE_MEM
-	 */
-	snprintf(pp->mem_space_name, sizeof(pp->mem_space_name),
-		 "PCIe %d MEM", pp->index);
-	pp->mem_space_name[sizeof(pp->mem_space_name) - 1] = 0;
-	pp->res[0].name = pp->mem_space_name;
-	if (pp->index == 0) {
-		pp->res[0].start = MEM_BASE_0;
-		pp->res[0].end = pp->res[0].start + MEM_SIZE_0 - 1;
-	} else {
-		pp->res[0].start = MEM_BASE_1;
-		pp->res[0].end = pp->res[0].start + MEM_SIZE_1 - 1;
-	}
-	pp->res[0].flags = IORESOURCE_MEM;
-	if (request_resource(&iomem_resource, &pp->res[0]))
-		panic("Request PCIe Memory resource failed\n");
-	pci_add_resource_offset(&sys->resources, &pp->res[0], sys->mem_offset);
-
-	/*
-	 * IORESOURCE_MEM | IORESOURCE_PREFETCH
-	 */
-	snprintf(pp->prefetch_space_name, sizeof(pp->prefetch_space_name),
-		 "PCIe %d PREFETCH MEM", pp->index);
-	pp->prefetch_space_name[sizeof(pp->prefetch_space_name) - 1] = 0;
-	pp->res[1].name = pp->prefetch_space_name;
-	if (pp->index == 0) {
-		pp->res[1].start = PREFETCH_MEM_BASE_0;
-		pp->res[1].end = pp->res[2].start + PREFETCH_MEM_SIZE_0 - 1;
-	} else {
-		pp->res[1].start = PREFETCH_MEM_BASE_1;
-		pp->res[1].end = pp->res[1].start + PREFETCH_MEM_SIZE_1 - 1;
-	}
-	pp->res[1].flags = IORESOURCE_MEM | IORESOURCE_PREFETCH;
-	if (request_resource(&iomem_resource, &pp->res[1]))
-		panic("Request PCIe Prefetch Memory resource failed\n");
-	pci_add_resource_offset(&sys->resources, &pp->res[1], sys->mem_offset);
+	pci_ioremap_io(nr * SZ_64K, port->io.start);
 
 	return 1;
 }
 
-static int tegra_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
 {
-	return INT_PCIE_INTR;
+	struct tegra_pcie_port *port = sys_to_pcie(pdev->bus->sysdata);
+
+	return port->pcie->irq;
 }
 
-static struct pci_bus __init *tegra_pcie_scan_bus(int nr,
-						  struct pci_sys_data *sys)
+static struct pci_bus __devinit *tegra_pcie_scan_bus(int nr,
+						     struct pci_sys_data *sys)
 {
-	struct tegra_pcie_port *pp;
+	struct tegra_pcie_port *port = sys_to_pcie(sys);
 
-	if (nr >= tegra_pcie.num_ports)
-		return NULL;
-
-	pp = tegra_pcie.port + nr;
-	pp->root_bus_nr = sys->busnr;
-
-	return pci_scan_root_bus(NULL, sys->busnr, &tegra_pcie_ops, sys,
-				 &sys->resources);
+	return pci_scan_root_bus(port->pcie->dev, sys->busnr, &tegra_pcie_ops,
+				 sys, &sys->resources);
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
@@ -448,14 +403,14 @@ static irqreturn_t tegra_pcie_isr(int irq, void *arg)
 		"Invalid write",
 		"Response decoding error",
 		"AXI response decoding error",
-		"Transcation timeout",
+		"Transaction timeout",
 	};
-
+	struct tegra_pcie *pcie = arg;
 	u32 code, signature;
 
-	code = afi_readl(AFI_INTR_CODE) & AFI_INTR_CODE_MASK;
-	signature = afi_readl(AFI_INTR_SIGNATURE);
-	afi_writel(0, AFI_INTR_CODE);
+	code = afi_readl(pcie, AFI_INTR_CODE) & AFI_INTR_CODE_MASK;
+	signature = afi_readl(pcie, AFI_INTR_SIGNATURE);
+	afi_writel(pcie, 0, AFI_INTR_CODE);
 
 	if (code == AFI_INTR_LEGACY)
 		return IRQ_NONE;
@@ -468,405 +423,594 @@ static irqreturn_t tegra_pcie_isr(int irq, void *arg)
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
+static void tegra_pcie_setup_translations(struct tegra_pcie *pcie)
 {
 	u32 fpci_bar;
 	u32 size;
 	u32 axi_address;
 
 	/* Bar 0: config Bar */
-	fpci_bar = ((u32)0xfdff << 16);
-	size = PCIE_CFG_SZ;
-	axi_address = TEGRA_PCIE_BASE + PCIE_CFG_OFF;
-	afi_writel(axi_address, AFI_AXI_BAR0_START);
-	afi_writel(size >> 12, AFI_AXI_BAR0_SZ);
-	afi_writel(fpci_bar, AFI_FPCI_BAR0);
+	fpci_bar = 0xfdff0000;
+	size = resource_size(pcie->cfg);
+	axi_address = pcie->cfg->start;
+	afi_writel(pcie, axi_address, AFI_AXI_BAR0_START);
+	afi_writel(pcie, size >> 12, AFI_AXI_BAR0_SZ);
+	afi_writel(pcie, fpci_bar, AFI_FPCI_BAR0);
 
 	/* Bar 1: extended config Bar */
-	fpci_bar = ((u32)0xfe1 << 20);
-	size = PCIE_EXT_CFG_SZ;
-	axi_address = TEGRA_PCIE_BASE + PCIE_EXT_CFG_OFF;
-	afi_writel(axi_address, AFI_AXI_BAR1_START);
-	afi_writel(size >> 12, AFI_AXI_BAR1_SZ);
-	afi_writel(fpci_bar, AFI_FPCI_BAR1);
+	fpci_bar = 0xfe100000;
+	size = resource_size(pcie->extcfg);
+	axi_address = pcie->extcfg->start;
+	afi_writel(pcie, axi_address, AFI_AXI_BAR1_START);
+	afi_writel(pcie, size >> 12, AFI_AXI_BAR1_SZ);
+	afi_writel(pcie, fpci_bar, AFI_FPCI_BAR1);
 
 	/* Bar 2: downstream IO bar */
-	fpci_bar = ((__u32)0xfdfc << 16);
-	size = SZ_128K;
-	axi_address = TEGRA_PCIE_IO_BASE;
-	afi_writel(axi_address, AFI_AXI_BAR2_START);
-	afi_writel(size >> 12, AFI_AXI_BAR2_SZ);
-	afi_writel(fpci_bar, AFI_FPCI_BAR2);
+	fpci_bar = 0xfdfc0000;
+	size = resource_size(&pcie->io);
+	axi_address = pcie->io.start;
+	afi_writel(pcie, axi_address, AFI_AXI_BAR2_START);
+	afi_writel(pcie, size >> 12, AFI_AXI_BAR2_SZ);
+	afi_writel(pcie, fpci_bar, AFI_FPCI_BAR2);
 
 	/* Bar 3: prefetchable memory BAR */
-	fpci_bar = (((PREFETCH_MEM_BASE_0 >> 12) & 0x0fffffff) << 4) | 0x1;
-	size =  PREFETCH_MEM_SIZE_0 +  PREFETCH_MEM_SIZE_1;
-	axi_address = PREFETCH_MEM_BASE_0;
-	afi_writel(axi_address, AFI_AXI_BAR3_START);
-	afi_writel(size >> 12, AFI_AXI_BAR3_SZ);
-	afi_writel(fpci_bar, AFI_FPCI_BAR3);
+	fpci_bar = (((pcie->prefetch.start >> 12) & 0x0fffffff) << 4) | 0x1;
+	size = resource_size(&pcie->prefetch);
+	axi_address = pcie->prefetch.start;
+	afi_writel(pcie, axi_address, AFI_AXI_BAR3_START);
+	afi_writel(pcie, size >> 12, AFI_AXI_BAR3_SZ);
+	afi_writel(pcie, fpci_bar, AFI_FPCI_BAR3);
 
 	/* Bar 4: non prefetchable memory BAR */
-	fpci_bar = (((MEM_BASE_0 >> 12)	& 0x0FFFFFFF) << 4) | 0x1;
-	size = MEM_SIZE_0 + MEM_SIZE_1;
-	axi_address = MEM_BASE_0;
-	afi_writel(axi_address, AFI_AXI_BAR4_START);
-	afi_writel(size >> 12, AFI_AXI_BAR4_SZ);
-	afi_writel(fpci_bar, AFI_FPCI_BAR4);
+	fpci_bar = (((pcie->mem.start >> 12) & 0x0fffffff) << 4) | 0x1;
+	size = resource_size(&pcie->mem);
+	axi_address = pcie->mem.start;
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
-
-	/* No MSI */
-	afi_writel(0, AFI_MSI_FPCI_BAR_ST);
-	afi_writel(0, AFI_MSI_BAR_SZ);
-	afi_writel(0, AFI_MSI_AXI_BAR_ST);
-	afi_writel(0, AFI_MSI_BAR_SZ);
+	afi_writel(pcie, PHYS_OFFSET, AFI_CACHE_BAR0_ST);
+	afi_writel(pcie, 0, AFI_CACHE_BAR0_SZ);
+	afi_writel(pcie, 0, AFI_CACHE_BAR1_ST);
+	afi_writel(pcie, 0, AFI_CACHE_BAR1_SZ);
+
+	/* MSI translations are setup only when needed */
+	afi_writel(pcie, 0, AFI_MSI_FPCI_BAR_ST);
+	afi_writel(pcie, 0, AFI_MSI_BAR_SZ);
+	afi_writel(pcie, 0, AFI_MSI_AXI_BAR_ST);
+	afi_writel(pcie, 0, AFI_MSI_BAR_SZ);
 }
 
-static int tegra_pcie_enable_controller(void)
+static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 {
-	u32 val, reg;
-	int i, timeout;
-
-	/* Enable slot clock and pulse the reset signals */
-	for (i = 0, reg = AFI_PEX0_CTRL; i < 2; i++, reg += 0x8) {
-		val = afi_readl(reg) |  AFI_PEX_CTRL_REFCLK_EN;
-		afi_writel(val, reg);
-		val &= ~AFI_PEX_CTRL_RST;
-		afi_writel(val, reg);
-
-		val = afi_readl(reg) | AFI_PEX_CTRL_RST;
-		afi_writel(val, reg);
-	}
+	unsigned int timeout;
+	unsigned long value;
 
-	/* Enable dual controller and both ports */
-	val = afi_readl(AFI_PCIE_CONFIG);
-	val &= ~(AFI_PCIE_CONFIG_PCIEC0_DISABLE_DEVICE |
-		 AFI_PCIE_CONFIG_PCIEC1_DISABLE_DEVICE |
-		 AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_MASK);
-	val |= AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_DUAL;
-	afi_writel(val, AFI_PCIE_CONFIG);
+	/* enable dual controller and both ports */
+	value = afi_readl(pcie, AFI_PCIE_CONFIG);
+	value &= ~(AFI_PCIE_CONFIG_PCIEC0_DISABLE_DEVICE |
+		   AFI_PCIE_CONFIG_PCIEC1_DISABLE_DEVICE |
+		   AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_MASK);
+	value |= AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_DUAL;
+	afi_writel(pcie, value, AFI_PCIE_CONFIG);
 
-	val = afi_readl(AFI_FUSE) & ~AFI_FUSE_PCIE_T0_GEN2_DIS;
-	afi_writel(val, AFI_FUSE);
+	value = afi_readl(pcie, AFI_FUSE);
+	value &= ~AFI_FUSE_PCIE_T0_GEN2_DIS;
+	afi_writel(pcie, value, AFI_FUSE);
 
-	/* Initialze internal PHY, enable up to 16 PCIE lanes */
-	pads_writel(0x0, PADS_CTL_SEL);
+	/* initialze internal PHY, enable up to 16 PCIE lanes */
+	pads_writel(pcie, 0x0, PADS_CTL_SEL);
 
 	/* override IDDQ to 1 on all 4 lanes */
-	val = pads_readl(PADS_CTL) | PADS_CTL_IDDQ_1L;
-	pads_writel(val, PADS_CTL);
+	value = pads_readl(pcie, PADS_CTL);
+	value |= PADS_CTL_IDDQ_1L;
+	pads_writel(pcie, value, PADS_CTL);
 
 	/*
-	 * set up PHY PLL inputs select PLLE output as refclock,
-	 * set TX ref sel to div10 (not div5)
+	 * Set up PHY PLL inputs select PLLE output as refclock,
+	 * set TX ref sel to div10 (not div5).
 	 */
-	val = pads_readl(PADS_PLL_CTL);
-	val &= ~(PADS_PLL_CTL_REFCLK_MASK | PADS_PLL_CTL_TXCLKREF_MASK);
-	val |= (PADS_PLL_CTL_REFCLK_INTERNAL_CML | PADS_PLL_CTL_TXCLKREF_DIV10);
-	pads_writel(val, PADS_PLL_CTL);
+	value = pads_readl(pcie, PADS_PLL_CTL);
+	value &= ~(PADS_PLL_CTL_REFCLK_MASK | PADS_PLL_CTL_TXCLKREF_MASK);
+	value |= (PADS_PLL_CTL_REFCLK_INTERNAL_CML | PADS_PLL_CTL_TXCLKREF_DIV10);
+	pads_writel(pcie, value, PADS_PLL_CTL);
 
 	/* take PLL out of reset  */
-	val = pads_readl(PADS_PLL_CTL) | PADS_PLL_CTL_RST_B4SM;
-	pads_writel(val, PADS_PLL_CTL);
+	value = pads_readl(pcie, PADS_PLL_CTL);
+	value |= PADS_PLL_CTL_RST_B4SM;
+	pads_writel(pcie, value, PADS_PLL_CTL);
 
 	/*
 	 * Hack, set the clock voltage to the DEFAULT provided by hw folks.
-	 * This doesn't exist in the documentation
+	 * This doesn't exist in the documentation.
 	 */
-	pads_writel(0xfa5cfa5c, 0xc8);
+	pads_writel(pcie, 0xfa5cfa5c, 0xc8);
 
-	/* Wait for the PLL to lock */
+	/* wait for the PLL to lock */
 	timeout = 300;
 	do {
-		val = pads_readl(PADS_PLL_CTL);
+		value = pads_readl(pcie, PADS_PLL_CTL);
 		usleep_range(1000, 1000);
 		if (--timeout == 0) {
 			pr_err("Tegra PCIe error: timeout waiting for PLL\n");
 			return -EBUSY;
 		}
-	} while (!(val & PADS_PLL_CTL_LOCKDET));
+	} while (!(value & PADS_PLL_CTL_LOCKDET));
 
 	/* turn off IDDQ override */
-	val = pads_readl(PADS_CTL) & ~PADS_CTL_IDDQ_1L;
-	pads_writel(val, PADS_CTL);
+	value = pads_readl(pcie, PADS_CTL);
+	value &= ~PADS_CTL_IDDQ_1L;
+	pads_writel(pcie, value, PADS_CTL);
 
 	/* enable TX/RX data */
-	val = pads_readl(PADS_CTL);
-	val |= (PADS_CTL_TX_DATA_EN_1L | PADS_CTL_RX_DATA_EN_1L);
-	pads_writel(val, PADS_CTL);
+	value = pads_readl(pcie, PADS_CTL);
+	value |= PADS_CTL_TX_DATA_EN_1L | PADS_CTL_RX_DATA_EN_1L;
+	pads_writel(pcie, value, PADS_CTL);
 
-	/* Take the PCIe interface module out of reset */
-	tegra_periph_reset_deassert(tegra_pcie.pcie_xclk);
+	/* take the PCIe interface module out of reset */
+	tegra_periph_reset_deassert(pcie->pcie_xclk);
 
-	/* Finally enable PCIe */
-	val = afi_readl(AFI_CONFIGURATION) | AFI_CONFIGURATION_EN_FPCI;
-	afi_writel(val, AFI_CONFIGURATION);
+	/* finally enable PCIe */
+	value = afi_readl(pcie, AFI_CONFIGURATION);
+	value |= AFI_CONFIGURATION_EN_FPCI;
+	afi_writel(pcie, value, AFI_CONFIGURATION);
 
-	val = (AFI_INTR_EN_INI_SLVERR | AFI_INTR_EN_INI_DECERR |
-	       AFI_INTR_EN_TGT_SLVERR | AFI_INTR_EN_TGT_DECERR |
-	       AFI_INTR_EN_TGT_WRERR | AFI_INTR_EN_DFPCI_DECERR);
-	afi_writel(val, AFI_AFI_INTR_ENABLE);
-	afi_writel(0xffffffff, AFI_SM_INTR_ENABLE);
+	value = AFI_INTR_EN_INI_SLVERR | AFI_INTR_EN_INI_DECERR |
+		AFI_INTR_EN_TGT_SLVERR | AFI_INTR_EN_TGT_DECERR |
+		AFI_INTR_EN_TGT_WRERR | AFI_INTR_EN_DFPCI_DECERR;
+	afi_writel(pcie, value, AFI_AFI_INTR_ENABLE);
+	afi_writel(pcie, 0xffffffff, AFI_SM_INTR_ENABLE);
 
-	/* FIXME: No MSI for now, only INT */
-	afi_writel(AFI_INTR_MASK_INT_MASK, AFI_INTR_MASK);
+	/* don't enable MSI for now, only when needed */
+	afi_writel(pcie, AFI_INTR_MASK_INT_MASK, AFI_INTR_MASK);
 
-	/* Disable all execptions */
-	afi_writel(0, AFI_FPCI_ERROR_MASKS);
+	/* disable all exceptions */
+	afi_writel(pcie, 0, AFI_FPCI_ERROR_MASKS);
 
 	return 0;
 }
 
-static void tegra_pcie_power_off(void)
+static void tegra_pcie_power_off(struct tegra_pcie *pcie)
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
+static int tegra_pcie_power_regate(struct tegra_pcie *pcie)
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
 
-	clk_prepare_enable(tegra_pcie.afi_clk);
-	clk_prepare_enable(tegra_pcie.pex_clk);
-	return clk_prepare_enable(tegra_pcie.pll_e);
+	clk_prepare_enable(pcie->afi_clk);
+	clk_prepare_enable(pcie->pex_clk);
+	return clk_prepare_enable(pcie->pll_e);
 }
 
-static int tegra_pcie_clocks_get(void)
+static int tegra_pcie_clocks_get(struct tegra_pcie *pcie)
 {
-	int err;
+	pcie->pex_clk = devm_clk_get(pcie->dev, "pex");
+	if (IS_ERR(pcie->pex_clk))
+		return PTR_ERR(pcie->pex_clk);
 
-	tegra_pcie.pex_clk = clk_get(NULL, "pex");
-	if (IS_ERR(tegra_pcie.pex_clk))
-		return PTR_ERR(tegra_pcie.pex_clk);
+	pcie->afi_clk = devm_clk_get(pcie->dev, "afi");
+	if (IS_ERR(pcie->afi_clk))
+		return PTR_ERR(pcie->afi_clk);
 
-	tegra_pcie.afi_clk = clk_get(NULL, "afi");
-	if (IS_ERR(tegra_pcie.afi_clk)) {
-		err = PTR_ERR(tegra_pcie.afi_clk);
-		goto err_afi_clk;
-	}
+	pcie->pcie_xclk = devm_clk_get(pcie->dev, "pcie_xclk");
+	if (IS_ERR(pcie->pcie_xclk))
+		return PTR_ERR(pcie->pcie_xclk);
 
-	tegra_pcie.pcie_xclk = clk_get(NULL, "pcie_xclk");
-	if (IS_ERR(tegra_pcie.pcie_xclk)) {
-		err =  PTR_ERR(tegra_pcie.pcie_xclk);
-		goto err_pcie_xclk;
-	}
-
-	tegra_pcie.pll_e = clk_get_sys(NULL, "pll_e");
-	if (IS_ERR(tegra_pcie.pll_e)) {
-		err = PTR_ERR(tegra_pcie.pll_e);
-		goto err_pll_e;
-	}
+	pcie->pll_e = devm_clk_get(pcie->dev, "pll_e");
+	if (IS_ERR(pcie->pll_e))
+		return PTR_ERR(pcie->pll_e);
 
 	return 0;
-
-err_pll_e:
-	clk_put(tegra_pcie.pcie_xclk);
-err_pcie_xclk:
-	clk_put(tegra_pcie.afi_clk);
-err_afi_clk:
-	clk_put(tegra_pcie.pex_clk);
-
-	return err;
-}
-
-static void tegra_pcie_clocks_put(void)
-{
-	clk_put(tegra_pcie.pll_e);
-	clk_put(tegra_pcie.pcie_xclk);
-	clk_put(tegra_pcie.afi_clk);
-	clk_put(tegra_pcie.pex_clk);
 }
 
-static int __init tegra_pcie_get_resources(void)
+static int __devinit tegra_pcie_get_resources(struct tegra_pcie *pcie)
 {
+	struct platform_device *pdev = to_platform_device(pcie->dev);
+	struct resource *pads, *afi;
 	int err;
 
-	err = tegra_pcie_clocks_get();
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
-		goto err_pwr_on;
+		dev_err(&pdev->dev, "failed to power up: %d\n", err);
+		return err;
 	}
 
-	tegra_pcie.regs = ioremap_nocache(TEGRA_PCIE_BASE, PCIE_IOMAP_SZ);
-	if (tegra_pcie.regs == NULL) {
-		pr_err("PCIE: Failed to map PCI/AFI registers\n");
-		err = -ENOMEM;
-		goto err_map_reg;
+	/* request and remap controller registers */
+	pads = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!pads) {
+		err = -EADDRNOTAVAIL;
+		goto power_off;
 	}
 
-	err = request_irq(INT_PCIE_INTR, tegra_pcie_isr,
-			  IRQF_SHARED, "PCIE", &tegra_pcie);
+	afi = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!afi) {
+		err = -EADDRNOTAVAIL;
+		goto power_off;
+	}
+
+	pcie->pads = devm_request_and_ioremap(&pdev->dev, pads);
+	if (!pcie->pads) {
+		err = -EADDRNOTAVAIL;
+		goto power_off;
+	}
+
+	pcie->afi = devm_request_and_ioremap(&pdev->dev, afi);
+	if (!pcie->afi) {
+		err = -EADDRNOTAVAIL;
+		goto power_off;
+	}
+
+	/* request and remap configuration space */
+	pcie->cfg = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	if (!pcie->cfg) {
+		err = -EADDRNOTAVAIL;
+		goto power_off;
+	}
+
+	pcie->extcfg = platform_get_resource(pdev, IORESOURCE_MEM, 3);
+	if (!pcie->extcfg) {
+		err = -EADDRNOTAVAIL;
+		goto power_off;
+	}
+
+	pcie->cs = devm_request_and_ioremap(&pdev->dev, pcie->cfg);
+	if (!pcie->cs) {
+		err = -EADDRNOTAVAIL;
+		goto power_off;
+	}
+
+	pcie->extcs = devm_request_and_ioremap(&pdev->dev, pcie->extcfg);
+	if (!pcie->extcs) {
+		err = -EADDRNOTAVAIL;
+		goto power_off;
+	}
+
+	/* request interrupt */
+	err = platform_get_irq(pdev, 0);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to get IRQ: %d\n", err);
+		goto power_off;
+	}
+
+	pcie->irq = err;
+
+	err = devm_request_irq(&pdev->dev, pcie->irq, tegra_pcie_isr,
+			       IRQF_SHARED, "PCIE", pcie);
 	if (err) {
-		pr_err("PCIE: Failed to register IRQ: %d\n", err);
-		goto err_req_io;
+		dev_err(&pdev->dev, "failed to register IRQ: %d\n", err);
+		goto power_off;
 	}
-	set_irq_flags(INT_PCIE_INTR, IRQF_VALID);
 
 	return 0;
 
-err_req_io:
-	iounmap(tegra_pcie.regs);
-err_map_reg:
-	tegra_pcie_power_off();
-err_pwr_on:
-	tegra_pcie_clocks_put();
-
+power_off:
+	tegra_pcie_power_off(pcie);
 	return err;
 }
 
+static int tegra_pcie_put_resources(struct tegra_pcie *pcie)
+{
+	tegra_pcie_power_off(pcie);
+	return 0;
+}
+
+static inline void init_range(struct resource *range, unsigned long flags)
+{
+	range->start = ~0;
+	range->end = 0;
+	range->flags = flags;
+}
+
+static inline void merge_range(struct resource *range, struct resource *new)
+{
+	if (new->start < range->start)
+		range->start = new->start;
+
+	if (new->end > range->end)
+		range->end = new->end;
+}
+
+static unsigned long tegra_pcie_port_get_pex_ctrl(struct tegra_pcie_port *port)
+{
+	unsigned long ret = 0;
+
+	switch (port->index) {
+	case 0:
+		ret = AFI_PEX0_CTRL;
+		break;
+
+	case 1:
+		ret = AFI_PEX1_CTRL;
+		break;
+	}
+
+	return ret;
+}
+
 /*
  * FIXME: If there are no PCIe cards attached, then calling this function
  * can result in the increase of the bootup time as there are big timeout
  * loops.
  */
 #define TEGRA_PCIE_LINKUP_TIMEOUT	200	/* up to 1.2 seconds */
-static bool tegra_pcie_check_link(struct tegra_pcie_port *pp, int idx,
-				  u32 reset_reg)
+static bool tegra_pcie_port_check_link(struct tegra_pcie_port *port)
 {
-	u32 reg;
-	int retries = 3;
-	int timeout;
+	unsigned long value, ctrl = tegra_pcie_port_get_pex_ctrl(port);
+	unsigned int retries = 3;
+
+	/* enable reference clock */
+	value = afi_readl(port->pcie, ctrl);
+	value |= AFI_PEX_CTRL_REFCLK_EN;
+	afi_writel(port->pcie, value, ctrl);
 
 	do {
-		timeout = TEGRA_PCIE_LINKUP_TIMEOUT;
-		while (timeout) {
-			reg = readl(pp->base + RP_VEND_XP);
+		unsigned int timeout = TEGRA_PCIE_LINKUP_TIMEOUT;
 
-			if (reg & RP_VEND_XP_DL_UP)
+		do {
+			value = readl(port->base + RP_VEND_XP);
+
+			if (value & RP_VEND_XP_DL_UP)
 				break;
 
-			mdelay(1);
-			timeout--;
-		}
+			usleep_range(1000, 1000);
+		} while (--timeout);
 
-		if (!timeout)  {
-			pr_err("PCIE: port %d: link down, retrying\n", idx);
+		if (!timeout) {
+			dev_err(port->pcie->dev, "link %u down, retrying\n",
+				port->index);
 			goto retry;
 		}
 
 		timeout = TEGRA_PCIE_LINKUP_TIMEOUT;
-		while (timeout) {
-			reg = readl(pp->base + RP_LINK_CONTROL_STATUS);
 
-			if (reg & 0x20000000)
+		do {
+			value = readl(port->base + RP_LINK_CONTROL_STATUS);
+
+			if (value & 0x20000000)
 				return true;
 
-			mdelay(1);
-			timeout--;
-		}
+			usleep_range(1000, 1000);
+		} while (--timeout);
 
 retry:
 		/* Pulse the PEX reset */
-		reg = afi_readl(reset_reg) | AFI_PEX_CTRL_RST;
-		afi_writel(reg, reset_reg);
-		mdelay(1);
-		reg = afi_readl(reset_reg) & ~AFI_PEX_CTRL_RST;
-		afi_writel(reg, reset_reg);
+		value = afi_readl(port->pcie, ctrl);
+		value |= AFI_PEX_CTRL_RST;
+		afi_writel(port->pcie, value, ctrl);
 
-		retries--;
-	} while (retries);
+		usleep_range(1000, 1000);
+
+		value = afi_readl(port->pcie, ctrl);
+		value &= ~AFI_PEX_CTRL_RST;
+		afi_writel(port->pcie, value, ctrl);
+	} while (--retries);
 
 	return false;
 }
 
-static void __init tegra_pcie_add_port(int index, u32 offset, u32 reset_reg)
+static int tegra_pcie_enable(struct tegra_pcie *pcie)
 {
-	struct tegra_pcie_port *pp;
+	struct tegra_pcie_port *port;
+	struct hw_pci hw;
 
-	pp = tegra_pcie.port + tegra_pcie.num_ports;
+	list_for_each_entry(port, &pcie->ports, list) {
+		memset(&hw, 0, sizeof(hw));
 
-	pp->index = -1;
-	pp->base = tegra_pcie.regs + offset;
-	pp->link_up = tegra_pcie_check_link(pp, index, reset_reg);
+		hw.nr_controllers = 1;
+		hw.private_data = (void **)&port;
+		hw.setup = tegra_pcie_setup;
+		hw.scan = tegra_pcie_scan_bus;
+		hw.map_irq = tegra_pcie_map_irq;
 
-	if (!pp->link_up) {
-		pp->base = NULL;
-		printk(KERN_INFO "PCIE: port %d: link down, ignoring\n", index);
-		return;
+		pci_common_init(&hw);
+	}
+
+	return 0;
+}
+
+static int tegra_pcie_add_port(struct tegra_pcie *pcie,
+			       struct tegra_pcie_rp *rp)
+{
+	struct tegra_pcie_port *port;
+	unsigned int i;
+
+	if (!rp->num_resources)
+		return -ENODEV;
+
+	port = devm_kzalloc(pcie->dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&port->list);
+	port->index = rp->index;
+	port->pcie = pcie;
+
+	port->base = devm_request_and_ioremap(pcie->dev, &rp->resources[0]);
+	if (!port->base)
+		return -EADDRNOTAVAIL;
+
+	if (!tegra_pcie_port_check_link(port)) {
+		dev_info(pcie->dev, "link %u down, ignoring\n", port->index);
+		return -ENODEV;
+	}
+
+	for (i = 0; i < rp->num_ranges; i++) {
+		struct resource *src = &rp->ranges[i], *dest;
+
+		switch (src->flags & IORESOURCE_TYPE_BITS) {
+		case IORESOURCE_IO:
+			if (resource_size(src) > SZ_64K) {
+				dev_warn(pcie->dev, "I/O region for port %u exceeds 64 KiB limit, truncating!\n",
+					 port->index);
+				src->end = src->start + SZ_64K - 1;
+			}
+
+			merge_range(&pcie->io, src);
+			dest = &port->io;
+			break;
+
+		case IORESOURCE_MEM:
+			if (src->flags & IORESOURCE_PREFETCH) {
+				merge_range(&pcie->prefetch, src);
+				dest = &port->prefetch;
+			} else {
+				merge_range(&pcie->mem, src);
+				dest = &port->mem;
+			}
+			break;
+
+		default:
+			dev_dbg(pcie->dev, "unknown resource type: %#lx\n",
+				src->flags & IORESOURCE_TYPE_BITS);
+			continue;
+		}
+
+		memcpy(dest, src, sizeof(*src));
 	}
 
-	tegra_pcie.num_ports++;
-	pp->index = index;
-	pp->root_bus_nr = -1;
-	memset(pp->res, 0, sizeof(pp->res));
+	list_add_tail(&port->list, &pcie->ports);
+	pcie->num_ports++;
+
+	return 0;
 }
 
-int __init tegra_pcie_init(bool init_port0, bool init_port1)
+static int __devinit tegra_pcie_probe(struct platform_device *pdev)
 {
+	struct tegra_pcie_pdata *pdata = pdev->dev.platform_data;
+	struct tegra_pcie *pcie;
+	unsigned int i;
 	int err;
 
-	if (!(init_port0 || init_port1))
+	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pcie->dev = &pdev->dev;
+
+	if (!pdata)
 		return -ENODEV;
 
 	pcibios_min_mem = 0;
 
-	err = tegra_pcie_get_resources();
-	if (err)
+	err = tegra_pcie_get_resources(pcie);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to request resources: %d\n", err);
 		return err;
+	}
+
+	platform_set_drvdata(pdev, pcie);
+
+	if (pdata->init) {
+		err = pdata->init(pdev);
+		if (err < 0)
+			goto put_resources;
+	}
 
-	err = tegra_pcie_enable_controller();
+	err = tegra_pcie_enable_controller(pcie);
 	if (err)
-		return err;
+		goto put_resources;
+
+	/* probe root ports */
+	INIT_LIST_HEAD(&pcie->ports);
+	pcie->num_ports = 0;
+
+	for (i = 0; i < pdata->num_ports; i++) {
+		err = tegra_pcie_add_port(pcie, &pdata->ports[i]);
+		if (err < 0)
+			dev_dbg(&pdev->dev, "failed to add port %u: %d\n",
+				pdata->ports[i].index, err);
+	}
 
 	/* setup the AFI address translations */
-	tegra_pcie_setup_translations();
+	tegra_pcie_setup_translations(pcie);
 
-	if (init_port0)
-		tegra_pcie_add_port(0, RP0_OFFSET, AFI_PEX0_CTRL);
+	err = tegra_pcie_enable(pcie);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to enable PCIe ports: %d\n", err);
+		goto put_resources;
+	}
 
-	if (init_port1)
-		tegra_pcie_add_port(1, RP1_OFFSET, AFI_PEX1_CTRL);
+	return 0;
 
-	pci_common_init(&tegra_pcie_hw);
+put_resources:
+	tegra_pcie_put_resources(pcie);
+	return err;
+}
+
+static int __devexit tegra_pcie_remove(struct platform_device *pdev)
+{
+	struct tegra_pcie_pdata *pdata = pdev->dev.platform_data;
+	struct tegra_pcie *pcie = platform_get_drvdata(pdev);
+	int err;
+
+	err = tegra_pcie_put_resources(pcie);
+	if (err < 0)
+		return err;
+
+	if (pdata->exit) {
+		err = pdata->exit(pdev);
+		if (err < 0)
+			return err;
+	}
 
 	return 0;
 }
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
1.7.11.2

