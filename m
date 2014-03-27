Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:62387 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756819AbaC0WrI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Mar 2014 18:47:08 -0400
Received: by mail-oa0-f46.google.com with SMTP id i7so5114442oag.5
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2014 15:47:07 -0700 (PDT)
From: Rob Herring <robherring2@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, liviu.dudau@arm.com
Cc: linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH 3/3] pci: add DT based ARM Versatile PCI host driver
Date: Thu, 27 Mar 2014 17:46:38 -0500
Message-Id: <1395960398-4238-4-git-send-email-robherring2@gmail.com>
In-Reply-To: <1395960398-4238-1-git-send-email-robherring2@gmail.com>
References: <1395960398-4238-1-git-send-email-robherring2@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rob Herring <robh@kernel.org>

This converts the Versatile PCI host code to a platform driver using
of_create_pci_host_bridge for parsing DT and setup.

I think more of this setup could be done by the core code. There are
accesses to the host's config space (accesses using local_pci_cfg_base)
which seem like they could be done by the core code or using standard
config space accessors. The problem is bridge->bus->self is needed, but
it does not get setup. I'm not exactly sure how that should work.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/Kconfig         |   4 +
 drivers/pci/host/Makefile        |   1 +
 drivers/pci/host/pci-versatile.c | 275 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 280 insertions(+)
 create mode 100644 drivers/pci/host/pci-versatile.c

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 47d46c6..b4dd911 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -33,4 +33,8 @@ config PCI_RCAR_GEN2
 	  There are 3 internal PCI controllers available with a single
 	  built-in EHCI/OHCI host controller present on each one.
 
+config PCI_VERSATILE
+	bool "ARM Versatile PB PCI controller"
+	depends on ARCH_VERSATILE
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 13fb333..fe67ab3 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
 obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
 obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
+obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
new file mode 100644
index 0000000..98abd1f
--- /dev/null
+++ b/drivers/pci/host/pci-versatile.c
@@ -0,0 +1,275 @@
+/*
+ * Copyright 2004 Koninklijke Philips Electronics NV
+ *
+ * Conversion to platform driver and DT:
+ * Copyright 2014 Linaro Ltd.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * 14/04/2005 Initial version, colin.king@philips.com
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+static void __iomem *versatile_pci_base;
+static void __iomem *versatile_cfg_base[2];
+
+#define PCI_IMAP(m)		(versatile_pci_base + ((m) * 4))
+#define PCI_SMAP(m)		(versatile_pci_base + 0x14 + ((m) * 4))
+#define PCI_SELFID		(versatile_pci_base + 0xc)
+
+#define DEVICE_ID_OFFSET		0x00
+#define CSR_OFFSET			0x04
+#define CLASS_ID_OFFSET			0x08
+
+#define VP_PCI_DEVICE_ID		0x030010ee
+#define VP_PCI_CLASS_ID			0x0b400000
+
+static unsigned long pci_slot_ignore;
+
+static int __init versatile_pci_slot_ignore(char *str)
+{
+	int retval;
+	int slot;
+
+	while ((retval = get_option(&str, &slot))) {
+		if ((slot < 0) || (slot > 31))
+			pr_err("Illegal slot value: %d\n", slot);
+		else
+			pci_slot_ignore |= (1 << slot);
+	}
+	return 1;
+}
+
+__setup("pci_slot_ignore=", versatile_pci_slot_ignore);
+
+
+static void __iomem *__pci_addr(struct pci_bus *bus,
+				unsigned int devfn, int offset)
+{
+	unsigned int busnr = bus->number;
+
+	/*
+	 * Trap out illegal values
+	 */
+	BUG_ON(offset > 255);
+	BUG_ON(busnr > 255);
+	BUG_ON(devfn > 255);
+
+	return versatile_cfg_base[1] + ((busnr << 16) |
+		(PCI_SLOT(devfn) << 11) | (PCI_FUNC(devfn) << 8) | offset);
+}
+
+static int versatile_read_config(struct pci_bus *bus, unsigned int devfn,
+				 int where, int size, u32 *val)
+{
+	void __iomem *addr = __pci_addr(bus, devfn, where & ~3);
+	u32 v;
+	int slot = PCI_SLOT(devfn);
+
+	if (pci_slot_ignore & (1 << slot)) {
+		/* Ignore this slot */
+		v = (1 << (8 * size)) - 1;
+	} else {
+		switch (size) {
+		case 1:
+			v = readl(addr);
+			if (where & 2)
+				v >>= 16;
+			if (where & 1)
+				v >>= 8;
+			v &= 0xff;
+			break;
+
+		case 2:
+			v = readl(addr);
+			if (where & 2)
+				v >>= 16;
+			v &= 0xffff;
+			break;
+
+		default:
+			v = readl(addr);
+			break;
+		}
+	}
+
+	*val = v;
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int versatile_write_config(struct pci_bus *bus, unsigned int devfn,
+				  int where, int size, u32 val)
+{
+	void __iomem *addr = __pci_addr(bus, devfn, where);
+	int slot = PCI_SLOT(devfn);
+
+	if (pci_slot_ignore & (1 << slot))
+		return PCIBIOS_SUCCESSFUL;
+
+	switch (size) {
+	case 1:
+		writeb((u8)val, addr);
+		break;
+
+	case 2:
+		writew((u16)val, addr);
+		break;
+
+	case 4:
+		writel(val, addr);
+		break;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops pci_versatile_ops = {
+	.read	= versatile_read_config,
+	.write	= versatile_write_config,
+};
+
+static const struct of_device_id versatile_pci_of_match[] = {
+	{ .compatible = "arm,versatile-pci", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, versatile_pci_of_match);
+
+/* Unused, temporary to satisfy ARM arch code */
+struct pci_sys_data sys;
+
+static int versatile_pci_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	int ret, i, mem = 1, myslot = -1;
+	unsigned int lastbus;
+	u32 val;
+	struct pci_host_bridge *bridge;
+	void __iomem *local_pci_cfg_base;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+	versatile_pci_base = devm_ioremap_resource(&pdev->dev, res);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res)
+		return -ENODEV;
+	versatile_cfg_base[0] = devm_ioremap_resource(&pdev->dev, res);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	if (!res)
+		return -ENODEV;
+	versatile_cfg_base[1] = devm_ioremap_resource(&pdev->dev, res);
+
+	bridge = of_create_pci_host_bridge(&pdev->dev, &pci_versatile_ops, &sys);
+	if (!bridge)
+		return -ENODEV;
+
+	/*
+	 *  We need to discover the PCI core first to configure itself
+	 *  before the main PCI probing is performed
+	 */
+	for (i = 0; i < 32; i++) {
+		if ((readl(versatile_cfg_base[0] + (i << 11) + DEVICE_ID_OFFSET) == VP_PCI_DEVICE_ID) &&
+		    (readl(versatile_cfg_base[0] + (i << 11) + CLASS_ID_OFFSET) == VP_PCI_CLASS_ID)) {
+			myslot = i;
+			break;
+		}
+	}
+	if (myslot == -1) {
+		dev_err(&pdev->dev, "Cannot find PCI core!\n");
+		ret = -EIO;
+		goto out;
+	}
+	/*
+	 * Do not to map Versatile FPGA PCI device into memory space
+	 */
+	pci_slot_ignore |= (1 << myslot);
+
+	dev_info(&pdev->dev, "PCI core found (slot %d)\n", myslot);
+
+	writel(myslot, PCI_SELFID);
+	local_pci_cfg_base = versatile_cfg_base[1] + (myslot << 11);
+
+	val = readl(local_pci_cfg_base + CSR_OFFSET);
+	val |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE;
+	writel(val, local_pci_cfg_base + CSR_OFFSET);
+
+	/*
+	 * Configure the PCI inbound memory windows to be 1:1 mapped to SDRAM
+	 */
+	writel(PHYS_OFFSET, local_pci_cfg_base + PCI_BASE_ADDRESS_0);
+	writel(PHYS_OFFSET, local_pci_cfg_base + PCI_BASE_ADDRESS_1);
+	writel(PHYS_OFFSET, local_pci_cfg_base + PCI_BASE_ADDRESS_2);
+
+	/*
+	 * For many years the kernel and QEMU were symbiotically buggy
+	 * in that they both assumed the same broken IRQ mapping.
+	 * QEMU therefore attempts to auto-detect old broken kernels
+	 * so that they still work on newer QEMU as they did on old
+	 * QEMU. Since we now use the correct (ie matching-hardware)
+	 * IRQ mapping we write a definitely different value to a
+	 * PCI_INTERRUPT_LINE register to tell QEMU that we expect
+	 * real hardware behaviour and it need not be backwards
+	 * compatible for us. This write is harmless on real hardware.
+	 */
+	writel(0, versatile_cfg_base[0] + PCI_INTERRUPT_LINE);
+
+	pci_bus_for_each_resource(bridge->bus, res, i) {
+		if (!res || (resource_type(res) != IORESOURCE_MEM))
+			continue;
+
+		writel(res->start >> 28, PCI_IMAP(mem));
+		writel(PHYS_OFFSET >> 28, PCI_SMAP(mem));
+
+		mem++;
+	}
+
+	pci_ioremap_io(0, bridge->io_base);
+
+	/* We always enable PCI domains and we keep domain 0 backward
+	 * compatible in /proc for video cards
+	 */
+	pci_add_flags(PCI_ENABLE_PROC_DOMAINS);
+	pci_add_flags(PCI_REASSIGN_ALL_BUS | PCI_REASSIGN_ALL_RSRC);
+
+	lastbus = pci_scan_child_bus(bridge->bus);
+	pci_bus_update_busn_res_end(bridge->bus, lastbus);
+
+	pci_assign_unassigned_bus_resources(bridge->bus);
+
+	pci_bus_add_devices(bridge->bus);
+
+	return 0;
+
+ out:
+	return ret;
+}
+
+static struct platform_driver versatile_pci_driver = {
+	.driver = {
+		.name = "versatile-pci",
+		.owner = THIS_MODULE,
+		.of_match_table = versatile_pci_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = versatile_pci_probe,
+};
+module_platform_driver(versatile_pci_driver);
+
+MODULE_DESCRIPTION("Versatile PCI driver");
+MODULE_LICENSE("GPLv2");
-- 
1.8.3.2

