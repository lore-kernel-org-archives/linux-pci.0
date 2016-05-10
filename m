Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	arnd@arndb.de,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com,
	okaya@codeaurora.org,
	jchandra@broadcom.com
Cc: robert.richter@caviumnetworks.com,
	mw@semihalf.com,
	Liviu.Dudau@arm.com,
	ddaney@caviumnetworks.com,
	wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org,
	jcm@redhat.com,
	andrea.gallo@linaro.org,
	dhdang@apm.com,
	jeremy.linton@arm.com,
	liudongdong3@huawei.com,
	cov@codeaurora.org
Subject: [PATCH V7 01/11] PCI: Provide common functions for ECAM mapping
Date: Tue, 10 May 2016 17:19:51 +0200
Message-Id: <1462893601-8937-2-git-send-email-tn@semihalf.com>
In-Reply-To: <1462893601-8937-1-git-send-email-tn@semihalf.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

From: Jayachandran C <jchandra@broadcom.com>

Add config option PCI_ECAM and file drivers/pci/ecam.c to provide
generic functions for accessing memory mapped PCI config space.

The API is defined in drivers/pci/ecam.h and is written to replace the
API in drivers/pci/host/pci-host-common.h. The file defines a new
'struct pci_config_window' to hold the information related to a PCI
config area and its mapping. This structure is expected to be used as
sysdata for controllers that have ECAM based mapping.

Helper functions are provided to setup the mapping, free the mapping
and to implement the map_bus method in 'struct pci_ops'

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 drivers/pci/Kconfig  |   3 +
 drivers/pci/Makefile |   2 +
 drivers/pci/ecam.c   | 161 +++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/ecam.h   |  62 ++++++++++++++++++++
 4 files changed, 228 insertions(+)
 create mode 100644 drivers/pci/ecam.c
 create mode 100644 drivers/pci/ecam.h

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 209292e..56389be 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -83,6 +83,9 @@ config HT_IRQ
 config PCI_ATS
 	bool
 
+config PCI_ECAM
+	bool
+
 config PCI_IOV
 	bool "PCI IOV support"
 	depends on PCI
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 2154092..1fa6925 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -55,6 +55,8 @@ obj-$(CONFIG_PCI_SYSCALL) += syscall.o
 
 obj-$(CONFIG_PCI_STUB) += pci-stub.o
 
+obj-$(CONFIG_PCI_ECAM) += ecam.o
+
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 
 obj-$(CONFIG_OF) += of.o
diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
new file mode 100644
index 0000000..3d52005
--- /dev/null
+++ b/drivers/pci/ecam.c
@@ -0,0 +1,161 @@
+/*
+ * Copyright 2016 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation (the "GPL").
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License version 2 (GPLv2) for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * version 2 (GPLv2) along with this source code.
+ */
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+#include "ecam.h"
+
+/*
+ * On 64 bit systems, we do a single ioremap for the whole config space
+ * since we have enough virtual address range available. On 32 bit, do an
+ * ioremap per bus.
+ */
+static const bool per_bus_mapping = !config_enabled(CONFIG_64BIT);
+
+/*
+ * Create a PCI config space window
+ *  - reserve mem region
+ *  - alloc struct pci_config_window with space for all mappings
+ *  - ioremap the config space
+ */
+struct pci_config_window *pci_ecam_create(struct device *dev,
+		struct resource *cfgres, struct resource *busr,
+		struct pci_ecam_ops *ops)
+{
+	struct pci_config_window *cfg;
+	unsigned int bus_range, bus_range_max, bsz;
+	int i, err;
+
+	if (busr->start > busr->end)
+		return ERR_PTR(-EINVAL);
+
+	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+	if (!cfg)
+		return ERR_PTR(-ENOMEM);
+
+	cfg->ops = ops;
+	cfg->busr.start = busr->start;
+	cfg->busr.end = busr->end;
+	cfg->busr.flags = IORESOURCE_BUS;
+	bus_range = resource_size(&cfg->busr);
+	bus_range_max = resource_size(cfgres) >> ops->bus_shift;
+	if (bus_range > bus_range_max) {
+		dev_warn(dev, "bus max %#x reduced to %#x",
+					bus_range, bus_range_max);
+		bus_range = bus_range_max;
+		cfg->busr.end = busr->start + bus_range - 1;
+	}
+	bsz = 1 << ops->bus_shift;
+
+	cfg->res.start = cfgres->start;
+	cfg->res.end = cfgres->end;
+	cfg->res.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	cfg->res.name = "PCI ECAM";
+
+	err = request_resource(&iomem_resource, &cfg->res);
+	if (err) {
+		dev_err(dev, "request ECAM res %pR failed\n", &cfg->res);
+		goto err_exit;
+	}
+
+	if (per_bus_mapping) {
+		cfg->winp = kcalloc(bus_range, sizeof(*cfg->winp), GFP_KERNEL);
+		if (!cfg->winp)
+			goto err_exit_malloc;
+		for (i = 0; i < bus_range; i++) {
+			cfg->winp[i] = ioremap(cfgres->start + i * bsz, bsz);
+			if (!cfg->winp[i])
+				goto err_exit_iomap;
+		}
+	} else {
+		cfg->win = ioremap(cfgres->start, bus_range * bsz);
+		if (!cfg->win)
+			goto err_exit_iomap;
+	}
+
+	if (ops->init) {
+		err = ops->init(dev, cfg);
+		if (err)
+			goto err_exit;
+	}
+	dev_info(dev, "ECAM at %pR for %pR\n", &cfg->res, &cfg->busr);
+	return cfg;
+
+err_exit_iomap:
+	dev_err(dev, "ECAM ioremap failed\n");
+err_exit_malloc:
+	err = -ENOMEM;
+err_exit:
+	pci_ecam_free(cfg);
+	return ERR_PTR(err);
+}
+
+void pci_ecam_free(struct pci_config_window *cfg)
+{
+	int i;
+
+	if (per_bus_mapping) {
+		if (cfg->winp) {
+			for (i = 0; i < resource_size(&cfg->busr); i++)
+				if (cfg->winp[i])
+					iounmap(cfg->winp[i]);
+			kfree(cfg->winp);
+		}
+	} else {
+		if (cfg->win)
+			iounmap(cfg->win);
+	}
+	if (cfg->res.parent)
+		release_resource(&cfg->res);
+	kfree(cfg);
+}
+
+/*
+ * Function to implement the pci_ops ->map_bus method
+ */
+void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
+			       int where)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	unsigned int devfn_shift = cfg->ops->bus_shift - 8;
+	unsigned int busn = bus->number;
+	void __iomem *base;
+
+	if (busn < cfg->busr.start || busn > cfg->busr.end)
+		return NULL;
+
+	busn -= cfg->busr.start;
+	if (per_bus_mapping)
+		base = cfg->winp[busn];
+	else
+		base = cfg->win + (busn << cfg->ops->bus_shift);
+	return base + (devfn << devfn_shift) + where;
+}
+
+/* ECAM ops */
+struct pci_ecam_ops pci_generic_ecam_ops = {
+	.bus_shift	= 20,
+	.pci_ops	= {
+		.map_bus	= pci_ecam_map_bus,
+		.read		= pci_generic_config_read,
+		.write		= pci_generic_config_write,
+	}
+};
diff --git a/drivers/pci/ecam.h b/drivers/pci/ecam.h
new file mode 100644
index 0000000..57de00d
--- /dev/null
+++ b/drivers/pci/ecam.h
@@ -0,0 +1,62 @@
+/*
+ * Copyright 2016 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation (the "GPL").
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License version 2 (GPLv2) for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * version 2 (GPLv2) along with this source code.
+ */
+#ifndef DRIVERS_PCI_ECAM_H
+#define DRIVERS_PCI_ECAM_H
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+/*
+ * struct to hold pci ops and bus shift of the config window
+ * for a PCI controller.
+ */
+struct pci_config_window;
+struct pci_ecam_ops {
+	unsigned int			bus_shift;
+	struct pci_ops			pci_ops;
+	int				(*init)(struct device *,
+						struct pci_config_window *);
+};
+
+/*
+ * struct to hold the mappings of a config space window. This
+ * is expected to be used as sysdata for PCI controlllers which
+ * use ECAM.
+ */
+struct pci_config_window {
+	struct resource			res;
+	struct resource			busr;
+	void				*priv;
+	struct pci_ecam_ops		*ops;
+	union {
+		void __iomem		*win;	/* 64-bit single mapping */
+		void __iomem		**winp; /* 32-bit per bus mapping */
+	};
+};
+
+/* create and free for pci_config_window */
+struct pci_config_window *pci_ecam_create(struct device *dev,
+		struct resource *cfgres, struct resource *busr,
+		struct pci_ecam_ops *ops);
+void pci_ecam_free(struct pci_config_window *cfg);
+
+/* map_bus when ->sysdata is an instance of pci_config_window */
+void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
+			       int where);
+/* default ECAM ops, bus shift 20, generic read and write */
+extern struct pci_ecam_ops pci_generic_ecam_ops;
+
+#endif
-- 
1.9.1
