Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33894 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbdA1Ute (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 Jan 2017 15:49:34 -0500
Received: by mail-lf0-f41.google.com with SMTP id v186so177730648lfa.1
        for <linux-pci@vger.kernel.org>; Sat, 28 Jan 2017 12:49:04 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Janos Laube <janos.dev@gmail.com>,
        Paulius Zaleckas <paulius.zaleckas@gmail.com>,
        openwrt-devel@openwrt.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/4] PCI: add driver for Cortina Gemini Host Bridge
Date: Sat, 28 Jan 2017 21:48:37 +0100
Message-Id: <20170128204839.18330-2-linus.walleij@linaro.org>
In-Reply-To: <20170128204839.18330-1-linus.walleij@linaro.org>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds a host bridge driver for the Cortina Systems Gemini
SoC (SL3516) PCI Host Bridge.

This code is inspired by the out-of-tree OpenWRT patch and
then extensively rewritten for device tree and using the modern
helpers to cut down and modernize the code to all new PCI
frameworks.

Tested on the ITian Square One SQ201 NAS with the following
result in the boot log (trimmed to relevant parts):

OF: PCI: host bridge /pci@50000000 ranges:
OF: PCI:    IO 0x50000000..0x500fffff -> 0x00000000
OF: PCI:   MEM 0x58000000..0x5fffffff -> 0x58000000
gemini-pci 50000000.pci: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00]
pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
pci_bus 0000:00: root bus resource [mem 0x58000000-0x5fffffff]
pci 0000:00:00.0: [159b:4321] type 00 class 0x060000
pci 0000:00:09.0: [1106:3038] type 00 class 0x0c0300
pci 0000:00:09.0: reg 0x20: [io  0xfce0-0xfcff]
pci 0000:00:09.0: supports D1 D2
pci 0000:00:09.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:09.1: [1106:3038] type 00 class 0x0c0300
pci 0000:00:09.1: reg 0x20: [io  0xfce0-0xfcff]
pci 0000:00:09.1: supports D1 D2
pci 0000:00:09.1: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:09.2: [1106:3104] type 00 class 0x0c0320
pci 0000:00:09.2: reg 0x10: [mem 0x00000000-0x000000ff]
pci 0000:00:09.2: supports D1 D2
pci 0000:00:09.2: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:0c.0: [1814:0301] type 00 class 0x028000
pci 0000:00:0c.0: reg 0x10: [mem 0x58000000-0x58007fff]
PCI: bus0: Fast back to back transfers disabled
gemini-pci 50000000.pci: clear all IRQs
gemini-pci 50000000.pci: setting up PCI DMA
pci 0000:00:00.0: of_irq_parse_pci() failed with rc=-22
pci 0000:00:0c.0: BAR 0: assigned [mem 0x58000000-0x58007fff]
pci 0000:00:09.2: BAR 0: assigned [mem 0x58008000-0x580080ff]
pci 0000:00:09.0: BAR 4: assigned [io  0x0400-0x041f]
pci 0000:00:09.1: BAR 4: assigned [io  0x0420-0x043f]
pci 0000:00:09.0: enabling device (0140 -> 0141)
pci 0000:00:09.0: HCRESET not completed yet!
pci 0000:00:09.1: enabling device (0140 -> 0141)
pci 0000:00:09.1: HCRESET not completed yet!
pci 0000:00:09.2: enabling device (0140 -> 0142)
ieee80211 phy0: rt2x00_set_chip: Info - Chipset detected - rt: 2561, rf: 0003, rev: 000c
ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-pci 0000:00:09.2: EHCI Host Controller
ehci-pci 0000:00:09.2: new USB bus registered, assigned bus number 1
ehci-pci 0000:00:09.2: irq 146, io mem 0x58008000
ehci-pci 0000:00:09.2: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
uhci_hcd: USB Universal Host Controller Interface driver
uhci_hcd 0000:00:09.0: UHCI Host Controller
uhci_hcd 0000:00:09.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:09.0: HCRESET not completed yet!
uhci_hcd 0000:00:09.0: irq 144, io base 0x00000400
hub 2-0:1.0: USB hub found
hub 2-0:1.0: config failed, hub doesn't have any ports! (err -19)
uhci_hcd 0000:00:09.1: UHCI Host Controller
uhci_hcd 0000:00:09.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:09.1: HCRESET not completed yet!
uhci_hcd 0000:00:09.1: irq 145, io base 0x00000420
hub 3-0:1.0: USB hub found
hub 3-0:1.0: config failed, hub doesn't have any ports! (err -19)
usb 1-1: new high-speed USB device number 2 using ehci-pci
usb-storage 1-1:1.0: USB Mass Storage device detected
scsi host0: usb-storage 1-1:1.0
scsi 0:0:0:0: Direct-Access     USB      Flash Disk       1.00 PQ: 0 ANSI: 2
sd 0:0:0:0: [sda] 7900336 512-byte logical blocks: (4.04 GB/3.77 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 0b 00 00 08
sd 0:0:0:0: [sda] No Caching mode page found
sd 0:0:0:0: [sda] Assuming drive cache: write through
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI removable disk

$ lspci
00:00.0 Class 0600: 159b:4321
00:09.2 Class 0c03: 1106:3104
00:09.0 Class 0c03: 1106:3038
00:09.1 Class 0c03: 1106:3038
00:0c.0 Class 0280: 1814:0301

cat /proc/interrupts
           CPU0
 19:          0    GEMINI   3 Level     watchdog bark
 30:       4943    GEMINI  14 Edge      Gemini Timer Tick
 33:          0    GEMINI  17 Level     45000000.rtc
 34:        651    GEMINI  18 Level     serial
 66:          0      GPIO  18 Edge      factory reset
144:          0       PCI   0 Edge      uhci_hcd:usb2
145:          0       PCI   1 Edge      uhci_hcd:usb3
146:        160       PCI   2 Edge      ehci_hcd:usb1

Well the EHCI USB hub works fine, I can mount and manage
files and the IRQs just keep ticking up.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This can be merged to the PCI tree whenever it is considered
fine for inclusion.
---
 drivers/pci/host/Kconfig      |   7 +
 drivers/pci/host/Makefile     |   1 +
 drivers/pci/host/pci-gemini.c | 375 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 383 insertions(+)
 create mode 100644 drivers/pci/host/pci-gemini.c

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 898d2c48239c..e29c2caf3492 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -60,6 +60,13 @@ config PCI_EXYNOS
 	select PCIEPORTBUS
 	select PCIE_DW
 
+config PCI_GEMINI
+	bool "Cortina Gemini SL351x PCI roller"
+	depends on ARCH_GEMINI
+	depends on ARM
+	depends on OF
+	default ARCH_GEMINI
+
 config PCI_IMX6
 	bool "Freescale i.MX6 PCIe controller"
 	depends on SOC_IMX6Q
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index bfe3179ae74c..8f007fe7a19d 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_PCIE_DW) += pcie-designware.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
 obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
+obj-$(CONFIG_PCI_GEMINI) += pci-gemini.o
 obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
 obj-$(CONFIG_PCI_HYPERV) += pci-hyperv.o
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
diff --git a/drivers/pci/host/pci-gemini.c b/drivers/pci/host/pci-gemini.c
new file mode 100644
index 000000000000..7051dd992114
--- /dev/null
+++ b/drivers/pci/host/pci-gemini.c
@@ -0,0 +1,375 @@
+/*
+ * Support for Gemini PCI Controller
+ *
+ * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
+ *
+ * Based on the out-of-tree OpenWRT patch:
+ * Copyright (C) 2009 Janos Laube <janos.dev@gmail.com>
+ * Copyright (C) 2009 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
+ * Based on SL2312 PCI controller code
+ * Storlink (C) 2003
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/bitops.h>
+#include <linux/irq.h>
+#include <linux/spinlock.h>
+
+#define GEMINI_PCI_IOSIZE_1M		0x0000
+
+#define GEMINI_PCI_PMC			0x40
+#define GEMINI_PCI_PMCSR		0x44
+#define GEMINI_PCI_CTRL1		0x48
+#define GEMINI_PCI_CTRL2		0x4C
+#define GEMINI_PCI_MEM1_BASE_SIZE	0x50
+#define GEMINI_PCI_MEM2_BASE_SIZE	0x54
+#define GEMINI_PCI_MEM3_BASE_SIZE	0x58
+
+#define PCI_CTRL2_INTSTS_SHIFT		28
+#define PCI_CTRL2_INTMASK_SHIFT		22
+
+#define GEMINI_PCI_DMA_MASK		0xFFF00000
+#define GEMINI_PCI_DMA_MEM1_BASE	0x00000000
+#define GEMINI_PCI_DMA_MEM2_BASE	0x00000000
+#define GEMINI_PCI_DMA_MEM3_BASE	0x00000000
+#define GEMINI_PCI_DMA_MEM1_SIZE	7
+#define GEMINI_PCI_DMA_MEM2_SIZE	6
+#define GEMINI_PCI_DMA_MEM3_SIZE	6
+
+#define PCI_CONF_ENABLE		BIT(31)
+#define PCI_CONF_WHERE(r)	((r) & 0xFC)
+#define PCI_CONF_BUS(b)		(((b) & 0xFF) << 16)
+#define PCI_CONF_DEVICE(d)	(((d) & 0x1F) << 11)
+#define PCI_CONF_FUNCTION(f)	(((f) & 0x07) << 8)
+
+#define PCI_IOSIZE	0x00
+#define PCI_PROT	0x04
+#define PCI_CTRL	0x08
+#define PCI_SOFTRST	0x10
+#define PCI_CONFIG	0x28
+#define PCI_DATA	0x2C
+
+struct gemini_pci {
+	struct device *dev;
+	void __iomem *base;
+	struct irq_domain *irqdomain;
+	spinlock_t lock;
+	struct pci_bus *bus;
+};
+
+static int gemini_pci_read_config(struct pci_bus *bus, unsigned int fn,
+				  int config, int size, u32 *value)
+{
+	struct gemini_pci *p = bus->sysdata;
+	unsigned long irq_flags;
+
+	spin_lock_irqsave(&p->lock, irq_flags);
+
+	writel(PCI_CONF_BUS(bus->number) |
+			PCI_CONF_DEVICE(PCI_SLOT(fn)) |
+			PCI_CONF_FUNCTION(PCI_FUNC(fn)) |
+			PCI_CONF_WHERE(config) |
+			PCI_CONF_ENABLE,
+			p->base + PCI_CONFIG);
+
+	*value = readl(p->base + PCI_DATA);
+
+	if (size == 1)
+		*value = (*value >> (8 * (config & 3))) & 0xFF;
+	else if (size == 2)
+		*value = (*value >> (8 * (config & 3))) & 0xFFFF;
+
+	spin_unlock_irqrestore(&p->lock, irq_flags);
+
+	dev_dbg(&bus->dev,
+		"[read]  slt: %.2d, fnc: %d, cnf: 0x%.2X, val (%d bytes): 0x%.8X\n",
+		PCI_SLOT(fn), PCI_FUNC(fn), config, size, *value);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int gemini_pci_write_config(struct pci_bus *bus, unsigned int fn,
+				   int config, int size, u32 value)
+{
+	struct gemini_pci *p = bus->sysdata;
+	unsigned long irq_flags = 0;
+	int ret = PCIBIOS_SUCCESSFUL;
+
+	dev_dbg(&bus->dev,
+		"[write] slt: %.2d, fnc: %d, cnf: 0x%.2X, val (%d bytes): 0x%.8X\n",
+		PCI_SLOT(fn), PCI_FUNC(fn), config, size, value);
+
+	spin_lock_irqsave(&p->lock, irq_flags);
+
+	writel(PCI_CONF_BUS(bus->number) |
+			PCI_CONF_DEVICE(PCI_SLOT(fn)) |
+			PCI_CONF_FUNCTION(PCI_FUNC(fn)) |
+			PCI_CONF_WHERE(config) |
+			PCI_CONF_ENABLE,
+			p->base + PCI_CONFIG);
+
+	switch (size) {
+	case 4:
+		writel(value, p->base + PCI_DATA);
+		break;
+	case 2:
+		writew(value, p->base + PCI_DATA + (config & 3));
+		break;
+	case 1:
+		writeb(value, p->base + PCI_DATA + (config & 3));
+		break;
+	default:
+		ret = PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	spin_unlock_irqrestore(&p->lock, irq_flags);
+
+	return ret;
+}
+
+static struct pci_ops gemini_pci_ops = {
+	.read	= gemini_pci_read_config,
+	.write	= gemini_pci_write_config,
+};
+
+static void gemini_pci_ack_irq(struct irq_data *d)
+{
+	struct gemini_pci *p = irq_data_get_irq_chip_data(d);
+	unsigned int reg;
+
+	gemini_pci_read_config(p->bus, 0, GEMINI_PCI_CTRL2, 4, &reg);
+	reg &= ~(0xF << PCI_CTRL2_INTSTS_SHIFT);
+	reg |= BIT(irqd_to_hwirq(d) + PCI_CTRL2_INTSTS_SHIFT);
+	gemini_pci_write_config(p->bus, 0, GEMINI_PCI_CTRL2, 4, reg);
+}
+
+static void gemini_pci_mask_irq(struct irq_data *d)
+{
+	struct gemini_pci *p = irq_data_get_irq_chip_data(d);
+	unsigned int reg;
+
+	gemini_pci_read_config(p->bus, 0, GEMINI_PCI_CTRL2, 4, &reg);
+	reg &= ~((0xF << PCI_CTRL2_INTSTS_SHIFT)
+		 | BIT(irqd_to_hwirq(d) + PCI_CTRL2_INTMASK_SHIFT));
+	gemini_pci_write_config(p->bus, 0, GEMINI_PCI_CTRL2, 4, reg);
+}
+
+static void gemini_pci_unmask_irq(struct irq_data *d)
+{
+	struct gemini_pci *p = irq_data_get_irq_chip_data(d);
+	unsigned int reg;
+
+	gemini_pci_read_config(p->bus, 0, GEMINI_PCI_CTRL2, 4, &reg);
+	reg &= ~(0xF << PCI_CTRL2_INTSTS_SHIFT);
+	reg |= BIT(irqd_to_hwirq(d) + PCI_CTRL2_INTMASK_SHIFT);
+	gemini_pci_write_config(p->bus, 0, GEMINI_PCI_CTRL2, 4, reg);
+}
+
+static void gemini_pci_irq_handler(struct irq_desc *desc)
+{
+	struct gemini_pci *p = irq_desc_get_handler_data(desc);
+	struct irq_chip *irqchip = irq_desc_get_chip(desc);
+	unsigned int irq_stat, reg, i;
+
+	gemini_pci_read_config(p->bus, 0, GEMINI_PCI_CTRL2, 4, &reg);
+	irq_stat = reg >> PCI_CTRL2_INTSTS_SHIFT;
+
+	chained_irq_enter(irqchip, desc);
+
+	for (i = 0; i < 4; i++) {
+		if ((irq_stat & BIT(i)) == 0)
+			continue;
+		generic_handle_irq(irq_find_mapping(p->irqdomain, i));
+	}
+
+	chained_irq_exit(irqchip, desc);
+}
+
+static struct irq_chip gemini_pci_irq_chip = {
+	.name = "PCI",
+	.irq_ack = gemini_pci_ack_irq,
+	.irq_mask = gemini_pci_mask_irq,
+	.irq_unmask = gemini_pci_unmask_irq,
+};
+
+static int gemini_pci_irq_map(struct irq_domain *domain, unsigned int irq,
+			      irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &gemini_pci_irq_chip, handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops gemini_pci_irqdomain_ops = {
+	.map = gemini_pci_irq_map,
+};
+
+static int gemini_pci_setup_irq(struct gemini_pci *p, int irq)
+{
+	struct device_node *intc = of_get_next_child(p->dev->of_node, NULL);
+	int i;
+
+	if (!intc) {
+		dev_err(p->dev, "missing child interrupt-controller node\n");
+		return -EINVAL;
+	}
+
+	p->irqdomain = irq_domain_add_linear(intc, 4,
+					     &gemini_pci_irqdomain_ops,
+					     p);
+	if (!p->irqdomain) {
+		dev_err(p->dev, "failed to create Gemini PCI IRQ domain\n");
+		return -EINVAL;
+	}
+
+	irq_set_chained_handler_and_data(irq, gemini_pci_irq_handler, p);
+
+	for (i = 0; i < 4; i++)
+		irq_create_mapping(p->irqdomain, i);
+
+	return 0;
+}
+
+static int gemini_pci_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *regs;
+	resource_size_t io_base;
+	struct resource_entry *win;
+	struct gemini_pci *p;
+	struct resource *mem;
+	struct resource *io;
+	struct pci_bus *bus;
+	int irq;
+	int ret;
+	u32 val;
+	LIST_HEAD(res);
+
+	p = devm_kzalloc(dev, sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	p->dev = dev;
+	spin_lock_init(&p->lock);
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	p->base = devm_ioremap_resource(dev, regs);
+	if (IS_ERR(p->base))
+		return PTR_ERR(p->base);
+
+	ret = of_pci_get_host_bridge_resources(dev->of_node, 0, 0xff,
+					       &res, &io_base);
+	if (ret)
+		return ret;
+
+	ret = devm_request_pci_bus_resources(dev, &res);
+	if (ret)
+		return ret;
+
+	/* No clue what these do */
+	pcibios_min_io = 0x100;
+	pcibios_min_mem = 0;
+
+	/* setup I/O space to 1MB size */
+	writel(GEMINI_PCI_IOSIZE_1M, p->base + PCI_IOSIZE);
+
+	/* setup hostbridge */
+	val = readl(p->base + PCI_CTRL);
+	val |= PCI_COMMAND_IO;
+	val |= PCI_COMMAND_MEMORY;
+	val |= PCI_COMMAND_MASTER;
+	writel(val, p->base + PCI_CTRL);
+
+	/* Get the I/O and memory ranges from DT */
+	resource_list_for_each_entry(win, &res) {
+		switch (resource_type(win->res)) {
+		case IORESOURCE_IO:
+			io = win->res;
+			io->name = "Gemini PCI I/O";
+			ret = pci_remap_iospace(io, io_base);
+			if (ret) {
+				dev_warn(dev, "error %d: failed to map resource %pR\n",
+					 ret, io);
+				continue;
+			}
+			break;
+		case IORESOURCE_MEM:
+			mem = win->res;
+			mem->name = "Gemini PCI MEM";
+			break;
+		case IORESOURCE_BUS:
+			break;
+		default:
+			break;
+		}
+	}
+
+	bus = pci_scan_root_bus(&pdev->dev, 0, &gemini_pci_ops, p, &res);
+	if (!bus)
+		return -ENOMEM;
+	p->bus = bus;
+
+	dev_info(dev, "clear all IRQs\n");
+
+	/* Mask and clear all interrupts */
+	gemini_pci_write_config(bus, 0, GEMINI_PCI_CTRL2 + 2, 2, 0xF000);
+
+	/* IRQ - all PCI IRQs cascade off this one */
+	irq = platform_get_irq(pdev, 0);
+	if (!irq) {
+		dev_err(dev, "failed to get IRQ\n");
+		return -EINVAL;
+	}
+
+	ret = gemini_pci_setup_irq(p, irq);
+	if (ret) {
+		dev_err(dev, "failed to setup IRQ\n");
+		return ret;
+	}
+
+	dev_info(dev, "setting up PCI DMA\n");
+	val = (GEMINI_PCI_DMA_MEM1_BASE & GEMINI_PCI_DMA_MASK)
+		| (GEMINI_PCI_DMA_MEM1_SIZE << 16);
+	gemini_pci_write_config(bus, 0, GEMINI_PCI_MEM1_BASE_SIZE, 4, val);
+	val = (GEMINI_PCI_DMA_MEM2_BASE & GEMINI_PCI_DMA_MASK)
+		| (GEMINI_PCI_DMA_MEM2_SIZE << 16);
+	gemini_pci_write_config(bus, 0, GEMINI_PCI_MEM2_BASE_SIZE, 4, val);
+	val = (GEMINI_PCI_DMA_MEM3_BASE & GEMINI_PCI_DMA_MASK)
+		| (GEMINI_PCI_DMA_MEM3_SIZE << 16);
+	gemini_pci_write_config(bus, 0, GEMINI_PCI_MEM3_BASE_SIZE, 4, val);
+
+	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+	pci_bus_assign_resources(bus);
+	pci_assign_unassigned_bus_resources(bus);
+	pci_bus_add_devices(bus);
+	pci_free_resource_list(&res);
+
+	return 0;
+}
+
+static const struct of_device_id gemini_pci_of_match[] = {
+	{
+		.compatible = "cortina,gemini-pci",
+	},
+	{},
+};
+
+static struct platform_driver gemini_pci_driver = {
+	.driver = {
+		.name = "gemini-pci",
+		.of_match_table = of_match_ptr(gemini_pci_of_match),
+	},
+	.probe  = gemini_pci_probe,
+};
+builtin_platform_driver(gemini_pci_driver);
-- 
2.9.3

