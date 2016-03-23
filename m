Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:15684 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753823AbcCWCsA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 22 Mar 2016 22:48:00 -0400
From: "Yong, Jonathan" <jonathan.yong@intel.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, jonathan.yong@intel.com
Subject: [PATCH] PCI: PTM preliminary implementation
Date: Wed, 23 Mar 2016 02:47:51 +0000
Message-Id: <1458701271-1866-2-git-send-email-jonathan.yong@intel.com>
In-Reply-To: <1458701271-1866-1-git-send-email-jonathan.yong@intel.com>
References: <1458701271-1866-1-git-send-email-jonathan.yong@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Simplified Precision Time Measurement driver, activates PTM feature
if a PCIe PTM requester (as per PCI Express 3.1 Base Specification
section 7.32)is found, but not before checking if the rest of the
PCI hierarchy can support it.

The driver does not take part in facilitating PTM conversations,
neither does it provide any useful services, it is only responsible
for setting up the required configuration space bits.

As of writing, there aren't any PTM capable devices on the market
yet, but it is supported by the Intel Apollo Lake platform.

Signed-off-by: Yong, Jonathan <jonathan.yong@intel.com>
---
 drivers/pci/pci-sysfs.c       |   7 ++
 drivers/pci/pci.h             |  25 +++++
 drivers/pci/pcie/Kconfig      |   8 ++
 drivers/pci/pcie/Makefile     |   2 +-
 drivers/pci/pcie/pcie_ptm.c   | 212 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c           |   3 +
 include/linux/pci.h           |   9 ++
 include/uapi/linux/pci_regs.h |  12 +++
 8 files changed, 277 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/pcie/pcie_ptm.c

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index e982010..edda4ba 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1342,6 +1342,9 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 	/* Active State Power Management */
 	pcie_aspm_create_sysfs_dev_files(dev);
 
+	/* PTM */
+	pci_create_ptm_sysfs(dev);
+
 	if (!pci_probe_reset_function(dev)) {
 		retval = device_create_file(&dev->dev, &reset_attr);
 		if (retval)
@@ -1436,6 +1439,10 @@ static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
 	}
 
 	pcie_aspm_remove_sysfs_dev_files(dev);
+
+	/* PTM */
+	pci_release_ptm_sysfs(dev);
+
 	if (dev->reset_fn) {
 		device_remove_file(&dev->dev, &reset_attr);
 		dev->reset_fn = 0;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d0fb934..c5ece1e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -320,6 +320,31 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 
 void pci_enable_acs(struct pci_dev *dev);
 
+#ifdef CONFIG_PCIEPORTBUS
+int pci_enable_ptm(struct pci_dev *dev);
+void pci_create_ptm_sysfs(struct pci_dev *dev);
+void pci_release_ptm_sysfs(struct pci_dev *dev);
+void pci_disable_ptm(struct pci_dev *dev);
+void pci_ptm_init(struct pci_dev *dev);
+#else
+static inline int pci_enable_ptm(struct pci_dev *dev)
+{
+	return -ENXIO;
+}
+static inline void pci_create_ptm_sysfs(struct pci_dev *dev)
+{
+}
+static inline void pci_release_ptm_sysfs(struct pci_dev *dev)
+{
+}
+static inline void pci_disable_ptm(struct pci_dev *dev)
+{
+}
+static inline pci_ptm_init(struct pci_dev *dev)
+{
+}
+#endif
+
 struct pci_dev_reset_methods {
 	u16 vendor;
 	u16 device;
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 72db7f4..9348cc3 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -81,3 +81,11 @@ endchoice
 config PCIE_PME
 	def_bool y
 	depends on PCIEPORTBUS && PM
+
+config PCIE_PTM
+	bool "Turn on Precision Time Management by default"
+	depends on PCIEPORTBUS
+	help
+	  Say Y here to enable PTM feature on PCI Express devices that
+	  support them as they are found during device enumeration. Otherwise
+	  the feature can be enabled manually through sysfs entries.
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 00c62df..d18b4c7 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -5,7 +5,7 @@
 # Build PCI Express ASPM if needed
 obj-$(CONFIG_PCIEASPM)		+= aspm.o
 
-pcieportdrv-y			:= portdrv_core.o portdrv_pci.o portdrv_bus.o
+pcieportdrv-y			:= portdrv_core.o portdrv_pci.o portdrv_bus.o pcie_ptm.o
 pcieportdrv-$(CONFIG_ACPI)	+= portdrv_acpi.o
 
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
diff --git a/drivers/pci/pcie/pcie_ptm.c b/drivers/pci/pcie/pcie_ptm.c
new file mode 100644
index 0000000..3476e65
--- /dev/null
+++ b/drivers/pci/pcie/pcie_ptm.c
@@ -0,0 +1,212 @@
+/*
+ * PCI Express Precision Time Measurement
+ * Copyright (c) 2016, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include "../pci.h"
+
+int pci_enable_ptm(struct pci_dev *dev);
+void pci_release_ptm(struct pci_dev *dev);
+
+#ifdef CONFIG_PCIE_PTM
+static bool disable_ptm;
+#else
+static bool disable_ptm = 1;
+#endif
+
+module_param_named(disable_ptm, disable_ptm, bool, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(disable_ptm, "Don't automatically enable PCIe PTM even if supported.");
+
+static int ptm_commit(struct pci_dev *dev)
+{
+	u32 dword;
+	int pos;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
+
+	/* Is this even possible? */
+	if (!pos)
+		return -ENXIO;
+
+	pci_read_config_dword(dev, pos + PCI_PTM_CONTROL_REG_OFFSET, &dword);
+	dword = dev->is_ptm_enabled ? dword | PCI_PTM_CTRL_ENABLE :
+		dword & ~PCI_PTM_CTRL_ENABLE;
+	dword = dev->is_ptm_root ? dword | PCI_PTM_CTRL_ROOT :
+		dword & ~PCI_PTM_CTRL_ROOT;
+
+	/* Only requester should have it set */
+	if (dev->is_ptm_requester)
+		dword = dword | (((u32)dev->ptm_effective_granularity) << 8);
+	return pci_write_config_dword(dev, pos + PCI_PTM_CONTROL_REG_OFFSET, dword);
+}
+
+/**
+ * pci_enable_ptm - Try to activate PTM functionality on device.
+ * @dev: PCI Express device with PTM requester role to enable.
+ *
+ * All PCIe Switches/Bridges in between need to be enabled for this to work.
+ *
+ * NOTE: Each requester must be associated with a PTM root (not to be confused
+ * with a root port or root complex). There can be multiple PTM roots in a
+ * a system forming multiple domains. All intervening bridges/switches in a
+ * domain must support PTM responder roles to relay PTM dialogues.
+ */
+int pci_enable_ptm(struct pci_dev *dev)
+{
+	int type;
+	struct pci_dev *upstream;
+
+	upstream = pci_upstream_bridge(dev);
+	type = pci_pcie_type(dev);
+
+	if (dev->is_ptm_root_capable)
+	{
+		/* If we are root capable but already part of a chain, don't set
+		 * the root select bit, only enable PTM */
+		if (!upstream || !upstream->is_ptm_enabled)
+			dev->is_ptm_root = 1;
+		dev->is_ptm_enabled = 1;
+	}
+
+	/* Is possible to be part of the PTM chain */
+	if (dev->is_ptm_responder && upstream && upstream->is_ptm_enabled)
+		dev->is_ptm_enabled = 1;
+
+	if (dev->is_ptm_requester && upstream && upstream->is_ptm_enabled) {
+		dev->is_ptm_enabled = 1;
+		dev->ptm_effective_granularity =
+			upstream->ptm_clock_granularity;
+	}
+	return ptm_commit(dev);
+}
+
+void pci_ptm_init(struct pci_dev *dev)
+{
+	u32 dword;
+	int pos;
+	u8 ver;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
+	if (!pos)
+		return;
+
+	/* Check capability version */
+	pci_read_config_dword(dev, pos, &dword);
+	ver = PCI_EXT_CAP_VER(dword);
+	if (ver != 0x1)
+	{
+		dev_warn(&dev->dev, "Expected PTM v1, got %u\n", ver);
+		return;
+	}
+
+	/* Fill in caps, masters are implied to be responders as well */
+	pci_read_config_dword(dev, pos + PCI_PTM_CAPABILITY_REG_OFFSET, &dword);
+	dev->is_ptm_capable = 1;
+	dev->is_ptm_root_capable   = (dword & PCI_PTM_CAP_ROOT) ? 1 : 0;
+	dev->is_ptm_responder      = (dword & PCI_PTM_CAP_RSP) ? 1 : 0;
+	dev->is_ptm_requester      = (dword & PCI_PTM_CAP_REQ) ? 1 : 0;
+	dev->ptm_clock_granularity = dev->is_ptm_responder ?
+		((dword & PCI_PTM_GRANULARITY_MASK) >> 8) : 0;
+	dev_info(&dev->dev, "Found PTM %s type device with %uns clock\n",
+		dev->is_ptm_root_capable ? "root" :
+		dev->is_ptm_responder ? "responder" :
+		dev->is_ptm_requester ? "requester" : "unknown",
+		dev->ptm_clock_granularity);
+
+	/* Get existing settings */
+	pci_read_config_dword(dev, pos + PCI_PTM_CONTROL_REG_OFFSET, &dword);
+	dev->is_ptm_enabled            = (dword & PCI_PTM_CTRL_ENABLE) ? 1 : 0;
+	dev->is_ptm_root               = (dword & PCI_PTM_CTRL_ROOT) ? 1 : 0;
+	dev->ptm_effective_granularity =
+		(dword & PCI_PTM_GRANULARITY_MASK) >> 8;
+
+	if(!disable_ptm)
+		pci_enable_ptm(dev);
+}
+
+static int do_disable_ptm(struct pci_dev *dev, void *v)
+{
+	if (dev->is_ptm_enabled)
+	{
+		dev->is_ptm_enabled            = 0;
+		dev->is_ptm_root               = 0;
+		dev->ptm_effective_granularity = 0;
+		ptm_commit(dev);
+	}
+	return 0;
+}
+
+/**
+ * pci_disable_ptm - Turn off PTM functionality on device.
+ * @dev: PCI Express device with PTM function to disable.
+ *
+ * Disables PTM functionality by clearing the PTM enable bit, if device is a
+ * switch/bridge it will also disable PTM function on other devices behind it.
+ */
+void pci_disable_ptm(struct pci_dev *dev)
+{
+	if (pci_is_bridge(dev))
+		pci_walk_bus(dev->bus, &do_disable_ptm, NULL);
+	else
+		do_disable_ptm(dev, NULL);
+}
+
+static ssize_t ptm_status_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u16 word;
+	int pos;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PTM);
+	if (!pos)
+		return -ENXIO;
+
+	pci_read_config_word(pdev, pos + PCI_PTM_CONTROL_REG_OFFSET, &word);
+	return sprintf(buf, "%u\n", word & PCI_PTM_CTRL_ENABLE ? 1 : 0);
+}
+
+static ssize_t ptm_status_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	unsigned long val;
+	ssize_t ret;
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret)
+		return ret;
+	if (val)
+		return pci_enable_ptm(pdev);
+	pci_disable_ptm(pdev);
+	return 0;
+}
+
+static DEVICE_ATTR_RW(ptm_status);
+
+void pci_release_ptm_sysfs(struct pci_dev *dev)
+{
+	if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM))
+		return;
+	device_remove_file(&dev->dev, &dev_attr_ptm_status);
+}
+
+void pci_create_ptm_sysfs(struct pci_dev *dev)
+{
+	if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM))
+		return;
+	device_create_file(&dev->dev, &dev_attr_ptm_status);
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8004f67..9d5e96e6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1657,6 +1657,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_enable_acs(dev);
 
 	pci_cleanup_aer_error_status_regs(dev);
+
+	/* Enable PTM Capabilities */
+	pci_ptm_init(dev);
 }
 
 /*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 004b813..2facd44 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -363,6 +363,15 @@ struct pci_dev {
 	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
 	struct bin_attribute *res_attr_wc[DEVICE_COUNT_RESOURCE]; /* sysfs file for WC mapping of resources */
+
+	unsigned int 	is_ptm_capable:1;
+	unsigned int	is_ptm_root_capable:1;
+	unsigned int	is_ptm_responder:1;
+	unsigned int	is_ptm_requester:1;
+	unsigned int	is_ptm_enabled:1;
+	unsigned int	is_ptm_root:1;
+	u8		ptm_clock_granularity;
+	u8		ptm_effective_granularity;
 #ifdef CONFIG_PCI_MSI
 	const struct attribute_group **msi_irq_groups;
 #endif
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 1becea8..559b28f 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -671,6 +671,7 @@
 #define PCI_EXT_CAP_ID_PMUX	0x1A	/* Protocol Multiplexing */
 #define PCI_EXT_CAP_ID_PASID	0x1B	/* Process Address Space ID */
 #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PASID
+#define PCI_EXT_CAP_ID_PTM	0x1f	/* Precision Time Measurement */
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
@@ -946,4 +947,15 @@
 #define PCI_TPH_CAP_ST_SHIFT	16	/* st table shift */
 #define PCI_TPH_BASE_SIZEOF	12	/* size with no st table */
 
+/* Precision Time Measurement */
+#define PCI_PTM_CAP_REQ			0x0001  /* Requester capable */
+#define PCI_PTM_CAP_RSP			0x0002  /* Responder capable */
+#define PCI_PTM_CAP_ROOT		0x0004  /* Root capable */
+#define PCI_PTM_GRANULARITY_MASK	0xFF00  /* Local clock granularity */
+#define PCI_PTM_CTRL_ENABLE		0x0001  /* PTM enable */
+#define PCI_PTM_CTRL_ROOT		0x0002  /* Root select */
+#define PCI_PTM_HEADER_REG_OFFSET       0x00	/* PTM version and such */
+#define PCI_PTM_CAPABILITY_REG_OFFSET   0x04	/* Capabilities */
+#define PCI_PTM_CONTROL_REG_OFFSET      0x08	/* Control reg */
+
 #endif /* LINUX_PCI_REGS_H */
-- 
2.7.3

