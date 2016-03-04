Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33132 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760229AbcCDWb5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2016 17:31:57 -0500
From: David Daney <ddaney.cavm@gmail.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: Dann Frazier <dann.frazier@canonical.com>,
	David Daney <david.daney@cavium.com>
Subject: [PATCH v7 1/3] PCI: generic: Refactor code to enable reuse by other drivers.
Date: Fri,  4 Mar 2016 14:31:46 -0800
Message-Id: <1457130708-3231-2-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1457130708-3231-1-git-send-email-ddaney.cavm@gmail.com>
References: <1457130708-3231-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

No change in functionality.

Move structure definitions into a separate header file.  Move common
code to new file with Kconfig machinery to build it.  Split probe
function in to two parts:

   - a small driver specific probe function (gen_pci_probe)

   - a common probe that can be used by other drivers
     (pci_host_common_probe)

Signed-off-by: David Daney <david.daney@cavium.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 MAINTAINERS                         |   1 +
 drivers/pci/host/Kconfig            |   4 +
 drivers/pci/host/Makefile           |   1 +
 drivers/pci/host/pci-host-common.c  | 194 ++++++++++++++++++++++++++++++++++++
 drivers/pci/host/pci-host-common.h  |  47 +++++++++
 drivers/pci/host/pci-host-generic.c | 181 +--------------------------------
 6 files changed, 251 insertions(+), 177 deletions(-)
 create mode 100644 drivers/pci/host/pci-host-common.c
 create mode 100644 drivers/pci/host/pci-host-common.h

diff --git a/MAINTAINERS b/MAINTAINERS
index da3e4d8..370b3cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8361,6 +8361,7 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/host-generic-pci.txt
+F:	drivers/pci/host/pci-host-common.c
 F:	drivers/pci/host/pci-host-generic.c
 
 PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (VMD)
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index d1cdd9c..cd5dfbb 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -54,9 +54,13 @@ config PCI_RCAR_GEN2_PCIE
 	help
 	  Say Y here if you want PCIe controller support on R-Car Gen2 SoCs.
 
+config PCI_HOST_COMMON
+	bool
+
 config PCI_HOST_GENERIC
 	bool "Generic PCI host controller"
 	depends on (ARM || ARM64) && OF
+	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want to support a simple generic PCI host
 	  controller, such as the one emulated by kvmtool.
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 7b2f20c..3b24af8 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
 obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
 obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
 obj-$(CONFIG_PCI_RCAR_GEN2_PCIE) += pcie-rcar.o
+obj-$(CONFIG_PCI_HOST_COMMON) += pci-host-common.o
 obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
 obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
 obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
new file mode 100644
index 0000000..e9f850f
--- /dev/null
+++ b/drivers/pci/host/pci-host-common.c
@@ -0,0 +1,194 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Copyright (C) 2014 ARM Limited
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/platform_device.h>
+
+#include "pci-host-common.h"
+
+static void gen_pci_release_of_pci_ranges(struct gen_pci *pci)
+{
+	pci_free_resource_list(&pci->resources);
+}
+
+static int gen_pci_parse_request_of_pci_ranges(struct gen_pci *pci)
+{
+	int err, res_valid = 0;
+	struct device *dev = pci->host.dev.parent;
+	struct device_node *np = dev->of_node;
+	resource_size_t iobase;
+	struct resource_entry *win;
+
+	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pci->resources,
+					       &iobase);
+	if (err)
+		return err;
+
+	resource_list_for_each_entry(win, &pci->resources) {
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
+			break;
+		case IORESOURCE_BUS:
+			pci->cfg.bus_range = res;
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
+	gen_pci_release_of_pci_ranges(pci);
+	return err;
+}
+
+static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
+{
+	int err;
+	u8 bus_max;
+	resource_size_t busn;
+	struct resource *bus_range;
+	struct device *dev = pci->host.dev.parent;
+	struct device_node *np = dev->of_node;
+	u32 sz = 1 << pci->cfg.ops->bus_shift;
+
+	err = of_address_to_resource(np, 0, &pci->cfg.res);
+	if (err) {
+		dev_err(dev, "missing \"reg\" property\n");
+		return err;
+	}
+
+	/* Limit the bus-range to fit within reg */
+	bus_max = pci->cfg.bus_range->start +
+		  (resource_size(&pci->cfg.res) >> pci->cfg.ops->bus_shift) - 1;
+	pci->cfg.bus_range->end = min_t(resource_size_t,
+					pci->cfg.bus_range->end, bus_max);
+
+	pci->cfg.win = devm_kcalloc(dev, resource_size(pci->cfg.bus_range),
+				    sizeof(*pci->cfg.win), GFP_KERNEL);
+	if (!pci->cfg.win)
+		return -ENOMEM;
+
+	/* Map our Configuration Space windows */
+	if (!devm_request_mem_region(dev, pci->cfg.res.start,
+				     resource_size(&pci->cfg.res),
+				     "Configuration Space"))
+		return -ENOMEM;
+
+	bus_range = pci->cfg.bus_range;
+	for (busn = bus_range->start; busn <= bus_range->end; ++busn) {
+		u32 idx = busn - bus_range->start;
+
+		pci->cfg.win[idx] = devm_ioremap(dev,
+						 pci->cfg.res.start + idx * sz,
+						 sz);
+		if (!pci->cfg.win[idx])
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+int pci_host_common_probe(struct platform_device *pdev,
+			  struct gen_pci *pci)
+{
+	int err;
+	const char *type;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct pci_bus *bus, *child;
+
+	type = of_get_property(np, "device_type", NULL);
+	if (!type || strcmp(type, "pci")) {
+		dev_err(dev, "invalid \"device_type\" %s\n", type);
+		return -EINVAL;
+	}
+
+	of_pci_check_probe_only();
+
+	pci->host.dev.parent = dev;
+	INIT_LIST_HEAD(&pci->host.windows);
+	INIT_LIST_HEAD(&pci->resources);
+
+	/* Parse our PCI ranges and request their resources */
+	err = gen_pci_parse_request_of_pci_ranges(pci);
+	if (err)
+		return err;
+
+	/* Parse and map our Configuration Space windows */
+	err = gen_pci_parse_map_cfg_windows(pci);
+	if (err) {
+		gen_pci_release_of_pci_ranges(pci);
+		return err;
+	}
+
+	/* Do not reassign resources if probe only */
+	if (!pci_has_flag(PCI_PROBE_ONLY))
+		pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
+
+
+	bus = pci_scan_root_bus(dev, pci->cfg.bus_range->start,
+				&pci->cfg.ops->ops, pci, &pci->resources);
+	if (!bus) {
+		dev_err(dev, "Scanning rootbus failed");
+		return -ENODEV;
+	}
+
+	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+
+	if (!pci_has_flag(PCI_PROBE_ONLY)) {
+		pci_bus_size_bridges(bus);
+		pci_bus_assign_resources(bus);
+
+		list_for_each_entry(child, &bus->children, node)
+			pcie_bus_configure_settings(child);
+	}
+
+	pci_bus_add_devices(bus);
+	return 0;
+}
+
+MODULE_DESCRIPTION("Generic PCI host driver common code");
+MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/host/pci-host-common.h b/drivers/pci/host/pci-host-common.h
new file mode 100644
index 0000000..09f3fa0
--- /dev/null
+++ b/drivers/pci/host/pci-host-common.h
@@ -0,0 +1,47 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Copyright (C) 2014 ARM Limited
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+#ifndef _PCI_HOST_COMMON_H
+#define _PCI_HOST_COMMON_H
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+struct gen_pci_cfg_bus_ops {
+	u32 bus_shift;
+	struct pci_ops ops;
+};
+
+struct gen_pci_cfg_windows {
+	struct resource				res;
+	struct resource				*bus_range;
+	void __iomem				**win;
+
+	struct gen_pci_cfg_bus_ops		*ops;
+};
+
+struct gen_pci {
+	struct pci_host_bridge			host;
+	struct gen_pci_cfg_windows		cfg;
+	struct list_head			resources;
+};
+
+int pci_host_common_probe(struct platform_device *pdev,
+			  struct gen_pci *pci);
+
+#endif /* _PCI_HOST_COMMON_H */
diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 1652bc7..e8aa78f 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -25,24 +25,7 @@
 #include <linux/of_pci.h>
 #include <linux/platform_device.h>
 
-struct gen_pci_cfg_bus_ops {
-	u32 bus_shift;
-	struct pci_ops ops;
-};
-
-struct gen_pci_cfg_windows {
-	struct resource				res;
-	struct resource				*bus_range;
-	void __iomem				**win;
-
-	struct gen_pci_cfg_bus_ops		*ops;
-};
-
-struct gen_pci {
-	struct pci_host_bridge			host;
-	struct gen_pci_cfg_windows		cfg;
-	struct list_head			resources;
-};
+#include "pci-host-common.h"
 
 static void __iomem *gen_pci_map_cfg_bus_cam(struct pci_bus *bus,
 					     unsigned int devfn,
@@ -93,175 +76,19 @@ static const struct of_device_id gen_pci_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, gen_pci_of_match);
 
-static void gen_pci_release_of_pci_ranges(struct gen_pci *pci)
-{
-	pci_free_resource_list(&pci->resources);
-}
-
-static int gen_pci_parse_request_of_pci_ranges(struct gen_pci *pci)
-{
-	int err, res_valid = 0;
-	struct device *dev = pci->host.dev.parent;
-	struct device_node *np = dev->of_node;
-	resource_size_t iobase;
-	struct resource_entry *win;
-
-	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pci->resources,
-					       &iobase);
-	if (err)
-		return err;
-
-	resource_list_for_each_entry(win, &pci->resources) {
-		struct resource *parent, *res = win->res;
-
-		switch (resource_type(res)) {
-		case IORESOURCE_IO:
-			parent = &ioport_resource;
-			err = pci_remap_iospace(res, iobase);
-			if (err) {
-				dev_warn(dev, "error %d: failed to map resource %pR\n",
-					 err, res);
-				continue;
-			}
-			break;
-		case IORESOURCE_MEM:
-			parent = &iomem_resource;
-			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
-			break;
-		case IORESOURCE_BUS:
-			pci->cfg.bus_range = res;
-		default:
-			continue;
-		}
-
-		err = devm_request_resource(dev, parent, res);
-		if (err)
-			goto out_release_res;
-	}
-
-	if (!res_valid) {
-		dev_err(dev, "non-prefetchable memory resource required\n");
-		err = -EINVAL;
-		goto out_release_res;
-	}
-
-	return 0;
-
-out_release_res:
-	gen_pci_release_of_pci_ranges(pci);
-	return err;
-}
-
-static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
-{
-	int err;
-	u8 bus_max;
-	resource_size_t busn;
-	struct resource *bus_range;
-	struct device *dev = pci->host.dev.parent;
-	struct device_node *np = dev->of_node;
-	u32 sz = 1 << pci->cfg.ops->bus_shift;
-
-	err = of_address_to_resource(np, 0, &pci->cfg.res);
-	if (err) {
-		dev_err(dev, "missing \"reg\" property\n");
-		return err;
-	}
-
-	/* Limit the bus-range to fit within reg */
-	bus_max = pci->cfg.bus_range->start +
-		  (resource_size(&pci->cfg.res) >> pci->cfg.ops->bus_shift) - 1;
-	pci->cfg.bus_range->end = min_t(resource_size_t,
-					pci->cfg.bus_range->end, bus_max);
-
-	pci->cfg.win = devm_kcalloc(dev, resource_size(pci->cfg.bus_range),
-				    sizeof(*pci->cfg.win), GFP_KERNEL);
-	if (!pci->cfg.win)
-		return -ENOMEM;
-
-	/* Map our Configuration Space windows */
-	if (!devm_request_mem_region(dev, pci->cfg.res.start,
-				     resource_size(&pci->cfg.res),
-				     "Configuration Space"))
-		return -ENOMEM;
-
-	bus_range = pci->cfg.bus_range;
-	for (busn = bus_range->start; busn <= bus_range->end; ++busn) {
-		u32 idx = busn - bus_range->start;
-
-		pci->cfg.win[idx] = devm_ioremap(dev,
-						 pci->cfg.res.start + idx * sz,
-						 sz);
-		if (!pci->cfg.win[idx])
-			return -ENOMEM;
-	}
-
-	return 0;
-}
-
 static int gen_pci_probe(struct platform_device *pdev)
 {
-	int err;
-	const char *type;
-	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
+	const struct of_device_id *of_id;
 	struct gen_pci *pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
-	struct pci_bus *bus, *child;
 
 	if (!pci)
 		return -ENOMEM;
 
-	type = of_get_property(np, "device_type", NULL);
-	if (!type || strcmp(type, "pci")) {
-		dev_err(dev, "invalid \"device_type\" %s\n", type);
-		return -EINVAL;
-	}
-
-	of_pci_check_probe_only();
-
-	of_id = of_match_node(gen_pci_of_match, np);
+	of_id = of_match_node(gen_pci_of_match, dev->of_node);
 	pci->cfg.ops = (struct gen_pci_cfg_bus_ops *)of_id->data;
-	pci->host.dev.parent = dev;
-	INIT_LIST_HEAD(&pci->host.windows);
-	INIT_LIST_HEAD(&pci->resources);
-
-	/* Parse our PCI ranges and request their resources */
-	err = gen_pci_parse_request_of_pci_ranges(pci);
-	if (err)
-		return err;
-
-	/* Parse and map our Configuration Space windows */
-	err = gen_pci_parse_map_cfg_windows(pci);
-	if (err) {
-		gen_pci_release_of_pci_ranges(pci);
-		return err;
-	}
-
-	/* Do not reassign resources if probe only */
-	if (!pci_has_flag(PCI_PROBE_ONLY))
-		pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
-
-
-	bus = pci_scan_root_bus(dev, pci->cfg.bus_range->start,
-				&pci->cfg.ops->ops, pci, &pci->resources);
-	if (!bus) {
-		dev_err(dev, "Scanning rootbus failed");
-		return -ENODEV;
-	}
-
-	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
-
-	if (!pci_has_flag(PCI_PROBE_ONLY)) {
-		pci_bus_size_bridges(bus);
-		pci_bus_assign_resources(bus);
-
-		list_for_each_entry(child, &bus->children, node)
-			pcie_bus_configure_settings(child);
-	}
 
-	pci_bus_add_devices(bus);
-	return 0;
+	return pci_host_common_probe(pdev, pci);
 }
 
 static struct platform_driver gen_pci_driver = {
-- 
1.8.3.1

