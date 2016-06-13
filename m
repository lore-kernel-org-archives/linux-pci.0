Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45086 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933570AbcFMTFj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Jun 2016 15:05:39 -0400
Subject: [PATCH v6 1/3] PCI: Add Precision Time Measurement (PTM) support
To: Jonathan Yong <jonathan.yong@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 13 Jun 2016 14:05:34 -0500
Message-ID: <20160613190534.12503.18923.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160613185945.12503.32760.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160613185945.12503.32760.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jonathan Yong <jonathan.yong@intel.com>

Add Precision Time Measurement (PTM) support (see PCIe r3.1, sec 6.22).

Enable PTM on PTM Root devices and switch ports.  This does not enable PTM
on endpoints.

There currently are no PTM-capable devices on the market, but it is
expected to be supported by the Intel Apollo Lake platform.

[bhelgaas: complete rework]
Signed-off-by: Jonathan Yong <jonathan.yong@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h             |    6 ++++
 drivers/pci/pcie/Kconfig      |   12 +++++++
 drivers/pci/pcie/Makefile     |    1 +
 drivers/pci/pcie/ptm.c        |   70 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c           |    3 ++
 include/linux/pci.h           |    5 +++
 include/uapi/linux/pci_regs.h |   10 +++++-
 7 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/pcie/ptm.c

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a814bbb..faed7b7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -321,6 +321,12 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 
 void pci_enable_acs(struct pci_dev *dev);
 
+#ifdef CONFIG_PCIE_PTM
+void pci_ptm_init(struct pci_dev *dev);
+#else
+static inline void pci_ptm_init(struct pci_dev *dev) { }
+#endif
+
 struct pci_dev_reset_methods {
 	u16 vendor;
 	u16 device;
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 22ca641..52c0c0f5 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -95,3 +95,15 @@ config PCIE_DPC
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called pcie-dpc.
+
+config PCIE_PTM
+	bool "PCIe Precision Time Measurement support"
+	default y
+	depends on PCIEPORTBUS
+	help
+	  This enables PCI Express Precision Time Measurement (PTM)
+	  support.  If you have devices that support PTM, it will be
+	  enabled automatically.
+
+	  This is only useful if you have devices that support PTM, but it
+	  is safe to enable even if you don't.
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index b24525b..36e35ea 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_PCIEAER)		+= aer/
 obj-$(CONFIG_PCIE_PME) += pme.o
 
 obj-$(CONFIG_PCIE_DPC) += pcie-dpc.o
+obj-$(CONFIG_PCIE_PTM) += ptm.o
diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
new file mode 100644
index 0000000..5c8479b
--- /dev/null
+++ b/drivers/pci/pcie/ptm.c
@@ -0,0 +1,70 @@
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
+static void pci_ptm_info(struct pci_dev *dev)
+{
+	dev_info(&dev->dev, "PTM enabled%s\n", dev->ptm_root ? " (root)" : "");
+}
+
+void pci_ptm_init(struct pci_dev *dev)
+{
+	int pos;
+	struct pci_dev *ups;
+	u32 cap, ctrl;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
+	if (!pos)
+		return;
+
+	/*
+	 * Enable PTM only on upstream devices (root ports, switch ports,
+	 * etc.) on the assumption that it causes no link traffic until an
+	 * endpoint enables it.
+	 */
+	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT ||
+	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END))
+		return;
+
+	pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
+
+	/*
+	 * There's no point in enabling PTM unless it's enabled in the
+	 * upstream device or this device can be a PTM Root itself.  Per
+	 * the spec recommendation (PCIe r3.1, sec 7.32.3), select the
+	 * furthest upstream Time Source as the PTM Root.
+	 */
+	ups = pci_upstream_bridge(dev);
+	if (ups && ups->ptm_enabled) {
+		ctrl = PCI_PTM_CTRL_ENABLE;
+	} else {
+		if (cap & PCI_PTM_CAP_ROOT) {
+			ctrl = PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT;
+			dev->ptm_root = 1;
+		} else
+			return;
+	}
+
+	pci_write_config_dword(dev, pos + PCI_PTM_CTRL, ctrl);
+	dev->ptm_enabled = 1;
+
+	pci_ptm_info(dev);
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8e3ef72..4b5c099 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1658,6 +1658,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_enable_acs(dev);
 
 	pci_cleanup_aer_error_status_regs(dev);
+
+	/* Precision Time Measurement */
+	pci_ptm_init(dev);
 }
 
 /*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b67e4df..09e6c18 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -361,6 +361,11 @@ struct pci_dev {
 	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
 	struct bin_attribute *res_attr_wc[DEVICE_COUNT_RESOURCE]; /* sysfs file for WC mapping of resources */
+
+#ifdef CONFIG_PCIE_PTM
+	unsigned int	ptm_root:1;
+	unsigned int	ptm_enabled:1;
+#endif
 #ifdef CONFIG_PCI_MSI
 	const struct attribute_group **msi_irq_groups;
 #endif
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 4040951..926fff4 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -671,7 +671,8 @@
 #define PCI_EXT_CAP_ID_PMUX	0x1A	/* Protocol Multiplexing */
 #define PCI_EXT_CAP_ID_PASID	0x1B	/* Process Address Space ID */
 #define PCI_EXT_CAP_ID_DPC	0x1D	/* Downstream Port Containment */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DPC
+#define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PTM
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
@@ -964,4 +965,11 @@
 
 #define PCI_EXP_DPC_SOURCE_ID		10	/* DPC Source Identifier */
 
+/* Precision Time Measurement */
+#define PCI_PTM_CAP			0x04	    /* PTM Capability */
+#define  PCI_PTM_CAP_ROOT		0x00000004  /* Root capable */
+#define PCI_PTM_CTRL			0x08	    /* PTM Control */
+#define  PCI_PTM_CTRL_ENABLE		0x00000001  /* PTM enable */
+#define  PCI_PTM_CTRL_ROOT		0x00000002  /* Root select */
+
 #endif /* LINUX_PCI_REGS_H */

