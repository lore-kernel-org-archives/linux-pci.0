Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:37194 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbcEKIr2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 11 May 2016 04:47:28 -0400
From: "Yong, Jonathan" <jonathan.yong@intel.com>
To: linux-pci@vger.kernel.org
Cc: jonathan.yong@intel.com, bhelgaas@google.com
Subject: [PATCH v5] PCI: PTM preliminary implementation
Date: Wed, 11 May 2016 08:47:26 +0000
Message-Id: <1462956446-27361-2-git-send-email-jonathan.yong@intel.com>
In-Reply-To: <1462956446-27361-1-git-send-email-jonathan.yong@intel.com>
References: <1462956446-27361-1-git-send-email-jonathan.yong@intel.com>
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
 drivers/pci/pci.c             |   2 +
 drivers/pci/pci.h             |  13 ++++
 drivers/pci/pcie/Kconfig      |  10 +++
 drivers/pci/pcie/Makefile     |   3 +
 drivers/pci/pcie/pcie_ptm.c   | 170 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c           |   3 +
 include/linux/pci.h           |  13 ++++
 include/uapi/linux/pci_regs.h |  13 +++-
 8 files changed, 226 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/pcie/pcie_ptm.c

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 25e0327..6810c00 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4856,6 +4856,8 @@ static int __init pci_setup(char *str)
 				pci_no_msi();
 			} else if (!strcmp(str, "noaer")) {
 				pci_no_aer();
+			} else if (!strcmp(str, "noptm")) {
+				pci_no_ptm();
 			} else if (!strncmp(str, "realloc=", 8)) {
 				pci_realloc_get_opt(str + 8);
 			} else if (!strncmp(str, "realloc", 7)) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a814bbb..3ccc375 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -321,6 +321,19 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 
 void pci_enable_acs(struct pci_dev *dev);
 
+#ifdef CONFIG_PCIE_PTM
+int pci_enable_ptm(struct pci_dev *dev);
+void pci_ptm_init(struct pci_dev *dev);
+void pci_no_ptm(void);
+#else
+static inline int pci_enable_ptm(struct pci_dev *dev)
+{
+	return -ENXIO;
+}
+static inline void pci_ptm_init(struct pci_dev *dev) {}
+static inline void pci_no_ptm(void){}
+#endif
+
 struct pci_dev_reset_methods {
 	u16 vendor;
 	u16 device;
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 72db7f4..6e62b1c 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -81,3 +81,13 @@ endchoice
 config PCIE_PME
 	def_bool y
 	depends on PCIEPORTBUS && PM
+
+config PCIE_PTM
+	bool "Enable Precision Time Measurement support"
+	default y
+	depends on PCIEPORTBUS
+	help
+	  Say Y here if you have PCI Express devices that are capable of
+	  Precision Time Measurement (PTM). This is only useful if you
+	  have devices that support PTM and that your PCI Express controller
+	  is PTM capable, but it is safe to enable even if you don't.
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 00c62df..726b972 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -14,3 +14,6 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
 obj-$(CONFIG_PCIEAER)		+= aer/
 
 obj-$(CONFIG_PCIE_PME) += pme.o
+
+# Precision Time Measurement support
+obj-$(CONFIG_PCIE_PTM) += pcie_ptm.o
diff --git a/drivers/pci/pcie/pcie_ptm.c b/drivers/pci/pcie/pcie_ptm.c
new file mode 100644
index 0000000..27e6548
--- /dev/null
+++ b/drivers/pci/pcie/pcie_ptm.c
@@ -0,0 +1,170 @@
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
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include "../pci.h"
+
+static bool noptm;
+
+static int ptm_commit(struct pci_dev *dev)
+{
+	u32 dword;
+	int pos;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
+
+	pci_read_config_dword(dev, pos + PCI_PTM_CONTROL_REG_OFFSET, &dword);
+	dword = dev->ptm_enabled ? dword | PCI_PTM_CTRL_ENABLE :
+		dword & ~PCI_PTM_CTRL_ENABLE;
+	dword = dev->ptm_root ? dword | PCI_PTM_CTRL_ROOT :
+		dword & ~PCI_PTM_CTRL_ROOT;
+
+	/* Only requester should have it set */
+	if (dev->ptm_requester)
+		dword = (dword & ~PCI_PTM_GRANULARITY_MASK) |
+		(((u32)dev->ptm_effective_granularity) << 8);
+	return pci_write_config_dword(dev, pos + PCI_PTM_CONTROL_REG_OFFSET,
+		dword);
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
+	struct pci_dev *upstream;
+
+	upstream = pci_upstream_bridge(dev);
+	if (dev->ptm_root_capable) {
+		/* If we are root capable but already part of a chain, don't set
+		 * the root select bit, only enable PTM
+		 */
+		if (!upstream || !upstream->ptm_enabled)
+			dev->ptm_root = 1;
+		dev->ptm_enabled = 1;
+	}
+
+	/* Is possible to be part of the PTM chain? */
+	if (dev->ptm_responder && upstream && upstream->ptm_enabled)
+		dev->ptm_enabled = 1;
+
+	if (dev->ptm_requester && upstream && upstream->ptm_enabled) {
+		dev->ptm_enabled = 1;
+		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
+			dev->ptm_effective_granularity =
+				upstream->ptm_clock_granularity;
+		} else {
+			dev->ptm_effective_granularity =
+				upstream->ptm_clock_implemented ?
+				upstream->ptm_max_clock_granularity : 0;
+		}
+	}
+
+	/* Did we have a condition to allow PTM? */
+	if (!dev->ptm_enabled)
+		return -ENXIO;
+
+	return ptm_commit(dev);
+}
+
+static void pci_ptm_info(struct pci_dev *dev)
+{
+	dev_info(&dev->dev, "PTM %s type\n",
+		dev->ptm_root_capable ? "root" :
+		dev->ptm_responder ? "respond" :
+		dev->ptm_requester ? "requester" :
+		"unknown");
+	switch (dev->ptm_clock_granularity) {
+	case 0x00:
+		dev_info(&dev->dev, "PTM clock unimplemented\n");
+		break;
+	case 0xff:
+		dev_info(&dev->dev, "PTM clock greater than 254ns\n");
+		break;
+	default:
+		dev_info(&dev->dev, "PTM clock %huns\n",
+			dev->ptm_clock_granularity);
+	}
+}
+
+static void set_slow_ptm(struct pci_dev *dev, u16 from, u16 to)
+{
+	dev_warn(&dev->dev, "One of the devices higher in the PTM domain has a clock granularity higher than the current device, using worst case time, %huns -> %huns\n",
+		from, to);
+	dev->ptm_max_clock_granularity = to;
+}
+
+void pci_ptm_init(struct pci_dev *dev)
+{
+	u32 dword;
+	int pos;
+	struct pci_dev *ups;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
+	if (!pos)
+		return;
+
+	ups = pci_upstream_bridge(dev);
+
+	/* Fill in caps, masters are implied to be responders as well */
+	pci_read_config_dword(dev, pos + PCI_PTM_CAPABILITY_REG_OFFSET, &dword);
+	dev->ptm_capable = 1;
+	dev->ptm_root_capable   = (dword & PCI_PTM_CAP_ROOT) ? 1 : 0;
+	dev->ptm_responder      = (dword & PCI_PTM_CAP_RSP) ? 1 : 0;
+	dev->ptm_requester      = (dword & PCI_PTM_CAP_REQ) ? 1 : 0;
+	dev->ptm_clock_granularity = dev->ptm_responder ?
+		((dword & PCI_PTM_GRANULARITY_MASK) >> 8) : 0;
+	dev->ptm_clock_implemented = dev->ptm_clock_granularity ? 1 : 0;
+	pci_ptm_info(dev);
+
+	/* Get existing settings */
+	pci_read_config_dword(dev, pos + PCI_PTM_CONTROL_REG_OFFSET, &dword);
+	dev->ptm_enabled            = (dword & PCI_PTM_CTRL_ENABLE) ? 1 : 0;
+	dev->ptm_root               = (dword & PCI_PTM_CTRL_ROOT) ? 1 : 0;
+	dev->ptm_effective_granularity =
+		(dword & PCI_PTM_GRANULARITY_MASK) >> 8;
+
+	/* Find out the maximum clock granularity thus far */
+	if (dev->ptm_responder) {
+		dev->ptm_max_clock_granularity =
+			dev->ptm_clock_granularity;
+		if (ups && ups->ptm_clock_implemented) {
+			if (ups->ptm_max_clock_granularity >
+				dev->ptm_clock_granularity) {
+				set_slow_ptm(dev,
+					dev->ptm_clock_granularity,
+					ups->ptm_max_clock_granularity
+					);
+			}
+		}
+	}
+
+	if (!noptm)
+		pci_enable_ptm(dev);
+}
+
+void pci_no_ptm(void)
+{
+	noptm = 1;
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
index 932ec74..b15a52c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -363,6 +363,19 @@ struct pci_dev {
 	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
 	struct bin_attribute *res_attr_wc[DEVICE_COUNT_RESOURCE]; /* sysfs file for WC mapping of resources */
+
+#ifdef CONFIG_PCIE_PTM
+	unsigned int	ptm_capable:1;
+	unsigned int	ptm_root_capable:1;
+	unsigned int	ptm_responder:1;
+	unsigned int	ptm_requester:1;
+	unsigned int	ptm_enabled:1;
+	unsigned int	ptm_root:1;
+	unsigned int	ptm_clock_implemented:1;
+	u8		ptm_clock_granularity;
+	u8		ptm_effective_granularity;
+	u8		ptm_max_clock_granularity;
+#endif
 #ifdef CONFIG_PCI_MSI
 	const struct attribute_group **msi_irq_groups;
 #endif
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 1becea8..b9f0fc6 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -670,7 +670,8 @@
 #define PCI_EXT_CAP_ID_SECPCI	0x19	/* Secondary PCIe Capability */
 #define PCI_EXT_CAP_ID_PMUX	0x1A	/* Protocol Multiplexing */
 #define PCI_EXT_CAP_ID_PASID	0x1B	/* Process Address Space ID */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PASID
+#define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PTM
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
@@ -946,4 +947,14 @@
 #define PCI_TPH_CAP_ST_SHIFT	16	/* st table shift */
 #define PCI_TPH_BASE_SIZEOF	12	/* size with no st table */
 
+/* Precision Time Measurement */
+#define PCI_PTM_CAPABILITY_REG_OFFSET	0x04    /* Capabilities */
+#define  PCI_PTM_CAP_REQ		0x00000001  /* Requester capable */
+#define  PCI_PTM_CAP_RSP		0x00000002  /* Responder capable */
+#define  PCI_PTM_CAP_ROOT		0x00000004  /* Root capable */
+#define  PCI_PTM_GRANULARITY_MASK	0x0000FF00  /* Clock granularity */
+#define PCI_PTM_CONTROL_REG_OFFSET	0x08	/* Control reg */
+#define  PCI_PTM_CTRL_ENABLE		0x00000001  /* PTM enable */
+#define  PCI_PTM_CTRL_ROOT		0x00000002  /* Root select */
+
 #endif /* LINUX_PCI_REGS_H */
-- 
2.7.3

