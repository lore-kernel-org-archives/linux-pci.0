Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:52097 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932731AbbA1UTm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jan 2015 15:19:42 -0500
Received: by mail-oi0-f47.google.com with SMTP id a141so19755771oig.6
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2015 12:19:42 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 3/3] PCI: add DT based ARM Versatile PCI host driver
Date: Wed, 28 Jan 2015 10:16:18 -0600
Message-Id: <1422461778-6769-4-git-send-email-robh@kernel.org>
In-Reply-To: <1422461778-6769-1-git-send-email-robh@kernel.org>
References: <1422461778-6769-1-git-send-email-robh@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This converts the Versatile PCI host code to a platform driver using
the commom DT parsing and setup. The driver uses only an empty ARM
pci_sys_data struct and does not use pci_common_init_dev init function.
The old host code will be removed in a subsequent commit when Versatile
is completely converted to DT.

I've tested this on QEMU with the sym53c8xx driver in both i/o and
memory mapped modes.

Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                      |   8 ++
 drivers/pci/host/Kconfig         |   4 +
 drivers/pci/host/Makefile        |   1 +
 drivers/pci/host/pci-versatile.c | 237 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 250 insertions(+)
 create mode 100644 drivers/pci/host/pci-versatile.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fa3853..9237079 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7220,6 +7220,14 @@ F:	include/linux/pci*
 F:	arch/x86/pci/
 F:	arch/x86/kernel/quirks.c
 
+PCI DRIVER FOR ARM VERSATILE PLATFORM
+M:	Rob Herring <robh@kernel.org>
+L:	linux-pci@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/versatile.txt
+F:	drivers/pci/host/pci-versatile.c
+
 PCI DRIVER FOR APPLIEDMICRO XGENE
 M:	Tanmay Inamdar <tinamdar@apm.com>
 L:	linux-pci@vger.kernel.org
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index c4b6568..7b892a9 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -102,4 +102,8 @@ config PCI_LAYERSCAPE
 	help
 	  Say Y here if you want PCIe controller support on Layerscape SoCs.
 
+config PCI_VERSATILE
+	bool "ARM Versatile PB PCI controller"
+	depends on ARCH_VERSATILE
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 44c2699..e61d91c 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
 obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
 obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
 obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
+obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
new file mode 100644
index 0000000..341529c
--- /dev/null
+++ b/drivers/pci/host/pci-versatile.c
@@ -0,0 +1,237 @@
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
+
+static void __iomem *versatile_pci_base;
+static void __iomem *versatile_cfg_base[2];
+
+#define PCI_IMAP(m)		(versatile_pci_base + ((m) * 4))
+#define PCI_SMAP(m)		(versatile_pci_base + 0x14 + ((m) * 4))
+#define PCI_SELFID		(versatile_pci_base + 0xc)
+
+#define VP_PCI_DEVICE_ID		0x030010ee
+#define VP_PCI_CLASS_ID			0x0b400000
+
+static u32 pci_slot_ignore;
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
+__setup("pci_slot_ignore=", versatile_pci_slot_ignore);
+
+
+static void __iomem *versatile_map_bus(struct pci_bus *bus,
+				       unsigned int devfn, int offset)
+{
+	unsigned int busnr = bus->number;
+
+	if (pci_slot_ignore & (1 << PCI_SLOT(devfn)))
+		return NULL;
+
+	return versatile_cfg_base[1] + ((busnr << 16) | (devfn << 8) | offset);
+}
+
+static struct pci_ops pci_versatile_ops = {
+	.map_bus = versatile_map_bus,
+	.read	= pci_generic_config_read32,
+	.write	= pci_generic_config_write,
+};
+
+static int versatile_pci_parse_request_of_pci_ranges(struct device *dev,
+						     struct list_head *res)
+{
+	int err, mem = 1, res_valid = 0;
+	struct device_node *np = dev->of_node;
+	resource_size_t iobase;
+	struct pci_host_bridge_window *win;
+
+	err = of_pci_get_host_bridge_resources(np, 0, 0xff, res, &iobase);
+	if (err)
+		return err;
+
+	list_for_each_entry(win, res, list) {
+		struct resource *parent, *res = win->res;
+
+		switch (resource_type(res)) {
+		case IORESOURCE_IO:
+			parent = &ioport_resource;
+			err = pci_remap_iospace(res, iobase);
+			if (err) {
+				dev_warn(dev, "error %d: failed to map resource %pR\n",
+					 err, res);
+				continue;
+			}
+			break;
+		case IORESOURCE_MEM:
+			parent = &iomem_resource;
+			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
+
+			writel(res->start >> 28, PCI_IMAP(mem));
+			writel(PHYS_OFFSET >> 28, PCI_SMAP(mem));
+			mem++;
+
+			break;
+		case IORESOURCE_BUS:
+		default:
+			continue;
+		}
+
+		err = devm_request_resource(dev, parent, res);
+		if (err)
+			goto out_release_res;
+	}
+
+	if (!res_valid) {
+		dev_err(dev, "non-prefetchable memory resource required\n");
+		err = -EINVAL;
+		goto out_release_res;
+	}
+
+	return 0;
+
+out_release_res:
+	pci_free_resource_list(res);
+	return err;
+}
+
+/* Unused, temporary to satisfy ARM arch code */
+struct pci_sys_data sys;
+
+static int versatile_pci_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	int ret, i, myslot = -1;
+	u32 val;
+	void __iomem *local_pci_cfg_base;
+	struct pci_bus *bus;
+	LIST_HEAD(pci_res);
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
+	ret = versatile_pci_parse_request_of_pci_ranges(&pdev->dev, &pci_res);
+	if (ret)
+		return ret;
+
+	/*
+	 * We need to discover the PCI core first to configure itself
+	 * before the main PCI probing is performed
+	 */
+	for (i = 0; i < 32; i++) {
+		if ((readl(versatile_cfg_base[0] + (i << 11) + PCI_VENDOR_ID) == VP_PCI_DEVICE_ID) &&
+		    (readl(versatile_cfg_base[0] + (i << 11) + PCI_CLASS_REVISION) == VP_PCI_CLASS_ID)) {
+			myslot = i;
+			break;
+		}
+	}
+	if (myslot == -1) {
+		dev_err(&pdev->dev, "Cannot find PCI core!\n");
+		return -EIO;
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
+	val = readl(local_pci_cfg_base + PCI_COMMAND);
+	val |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE;
+	writel(val, local_pci_cfg_base + PCI_COMMAND);
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
+	pci_add_flags(PCI_ENABLE_PROC_DOMAINS);
+	pci_add_flags(PCI_REASSIGN_ALL_BUS | PCI_REASSIGN_ALL_RSRC);
+
+	bus = pci_scan_root_bus(&pdev->dev, 0, &pci_versatile_ops, &sys, &pci_res);
+	if (!bus)
+		return -ENOMEM;
+
+	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+	pci_assign_unassigned_bus_resources(bus);
+
+	return 0;
+}
+
+static const struct of_device_id versatile_pci_of_match[] = {
+	{ .compatible = "arm,versatile-pci", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, versatile_pci_of_match);
+
+static struct platform_driver versatile_pci_driver = {
+	.driver = {
+		.name = "versatile-pci",
+		.of_match_table = versatile_pci_of_match,
+	},
+	.probe = versatile_pci_probe,
+};
+module_platform_driver(versatile_pci_driver);
+
+MODULE_DESCRIPTION("Versatile PCI driver");
+MODULE_LICENSE("GPL v2");
-- 
2.1.0

