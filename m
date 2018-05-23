Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rajat Jain <rajatja@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
        Kyle McMartin <jkkm@fb.com>
Cc: rajatxjain@gmail.com
Subject: [PATCH v2 1/5] PCI/AER: Define and allocate aer_stats structure for AER capable devices
Date: Wed, 23 May 2018 10:58:04 -0700
Message-Id: <20180523175808.28030-2-rajatja@google.com>
In-Reply-To: <20180523175808.28030-1-rajatja@google.com>
References: <20180522222805.80314-1-rajatja@google.com>
 <20180523175808.28030-1-rajatja@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Define a structure to hold the AER statistics. There are 2 groups
of statistics: dev_* counters that are to be collected for all AER
capable devices and rootport_* counters that are collected for all
(AER capable) rootports only. Allocate and free this structure when
device is added or released (thus counters survive the lifetime of the
device).

Add a new file aerdrv_stats.c to hold the AER stats collection logic.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: Fix the license header as per Greg's suggestions
    (Since there is disagreement with using "//" vs "/* */" for license
     I decided to keep the one preferred by Linus, also used by others
     in this directory)

 drivers/pci/pcie/aer/Makefile       |  2 +-
 drivers/pci/pcie/aer/aerdrv.h       |  6 +++
 drivers/pci/pcie/aer/aerdrv_core.c  |  9 +++++
 drivers/pci/pcie/aer/aerdrv_stats.c | 61 +++++++++++++++++++++++++++++
 drivers/pci/probe.c                 |  1 +
 include/linux/pci.h                 |  3 ++
 6 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/pcie/aer/aerdrv_stats.c

diff --git a/drivers/pci/pcie/aer/Makefile b/drivers/pci/pcie/aer/Makefile
index 09bd890875a3..a06f9cc2bde5 100644
--- a/drivers/pci/pcie/aer/Makefile
+++ b/drivers/pci/pcie/aer/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_PCIEAER) += aerdriver.o
 
 obj-$(CONFIG_PCIE_ECRC)	+= ecrc.o
 
-aerdriver-objs := aerdrv_errprint.o aerdrv_core.o aerdrv.o
+aerdriver-objs := aerdrv_errprint.o aerdrv_core.o aerdrv.o aerdrv_stats.o
 aerdriver-$(CONFIG_ACPI) += aerdrv_acpi.o
 
 obj-$(CONFIG_PCIEAER_INJECT) += aer_inject.o
diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index b4c950683cc7..d8b9fba536ed 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -33,6 +33,10 @@
 					PCI_ERR_UNC_MALF_TLP)
 
 #define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
+
+#define AER_MAX_TYPEOF_CORRECTABLE_ERRS 16	/* as per PCI_ERR_COR_STATUS */
+#define AER_MAX_TYPEOF_UNCORRECTABLE_ERRS 26	/* as per PCI_ERR_UNCOR_STATUS*/
+
 struct aer_err_info {
 	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
 	int error_dev_num;
@@ -81,6 +85,8 @@ void aer_isr(struct work_struct *work);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info);
 irqreturn_t aer_irq(int irq, void *context);
+int pci_aer_stats_init(struct pci_dev *pdev);
+void pci_aer_stats_exit(struct pci_dev *pdev);
 
 #ifdef CONFIG_ACPI_APEI
 int pcie_aer_get_firmware_first(struct pci_dev *pci_dev);
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 36e622d35c48..42a6f913069a 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -95,9 +95,18 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 int pci_aer_init(struct pci_dev *dev)
 {
 	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+
+	if (!dev->aer_cap || pci_aer_stats_init(dev))
+		return -EIO;
+
 	return pci_cleanup_aer_error_status_regs(dev);
 }
 
+void pci_aer_exit(struct pci_dev *dev)
+{
+	pci_aer_stats_exit(dev);
+}
+
 /**
  * add_error_device - list device to be handled
  * @e_info: pointer to error info
diff --git a/drivers/pci/pcie/aer/aerdrv_stats.c b/drivers/pci/pcie/aer/aerdrv_stats.c
new file mode 100644
index 000000000000..2f48d6bc81f1
--- /dev/null
+++ b/drivers/pci/pcie/aer/aerdrv_stats.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Google Inc, All Rights Reserved.
+ *
+ * Rajat Jain (rajatja@google.com)
+ *
+ * AER Statistics - exposed to userspace via /sysfs attributes.
+ */
+
+#include <linux/pci.h>
+#include "aerdrv.h"
+
+/* AER stats for the device */
+struct aer_stats {
+
+	/*
+	 * Fields for all AER capable devices. They indicate the errors
+	 * "as seen by this device". Note that this may mean that if an
+	 * end point is causing problems, the AER counters may increment
+	 * at its link partner (e.g. root port) because the errors will be
+	 * "seen" by the link partner and not the the problematic end point
+	 * itself (which may report all counters as 0 as it never saw any
+	 * problems).
+	 */
+	/* Individual counters for different type of correctable errors */
+	u64 dev_cor_errs[AER_MAX_TYPEOF_CORRECTABLE_ERRS];
+	/* Individual counters for different type of uncorrectable errors */
+	u64 dev_uncor_errs[AER_MAX_TYPEOF_UNCORRECTABLE_ERRS];
+	/* Total number of correctable errors seen by this device */
+	u64 dev_total_cor_errs;
+	/* Total number of fatal uncorrectable errors seen by this device */
+	u64 dev_total_fatal_errs;
+	/* Total number of fatal uncorrectable errors seen by this device */
+	u64 dev_total_nonfatal_errs;
+
+	/*
+	 * Fields for Root ports only, these indicate the total number of
+	 * ERR_COR, ERR_FATAL, and ERR_NONFATAL messages received by the
+	 * rootport, INCLUDING the ones that are generated internally (by
+	 * the rootport itself)
+	 */
+	u64 rootport_total_cor_errs;
+	u64 rootport_total_fatal_errs;
+	u64 rootport_total_nonfatal_errs;
+};
+
+int pci_aer_stats_init(struct pci_dev *pdev)
+{
+	pdev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
+	if (!pdev->aer_stats) {
+		dev_err(&pdev->dev, "No memory for aer_stats\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+void pci_aer_stats_exit(struct pci_dev *pdev)
+{
+	kfree(pdev->aer_stats);
+	pdev->aer_stats = NULL;
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 384020757b81..dd662c241373 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2064,6 +2064,7 @@ static void pci_configure_device(struct pci_dev *dev)
 
 static void pci_release_capabilities(struct pci_dev *dev)
 {
+	pci_aer_exit(dev);
 	pci_vpd_release(dev);
 	pci_iov_release(dev);
 	pci_free_cap_save_buffers(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 21965e0dbe62..5c84b1304de7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -299,6 +299,7 @@ struct pci_dev {
 	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
 #ifdef CONFIG_PCIEAER
 	u16		aer_cap;	/* AER capability offset */
+	struct aer_stats *aer_stats;	/* AER stats for this device */
 #endif
 	u8		pcie_cap;	/* PCIe capability offset */
 	u8		msi_cap;	/* MSI capability offset */
@@ -1470,10 +1471,12 @@ static inline bool pcie_aspm_support_enabled(void) { return false; }
 void pci_no_aer(void);
 bool pci_aer_available(void);
 int pci_aer_init(struct pci_dev *dev);
+void pci_aer_exit(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
 static inline bool pci_aer_available(void) { return false; }
 static inline int pci_aer_init(struct pci_dev *d) { return -ENODEV; }
+static inline void pci_aer_exit(struct pci_dev *d) { }
 #endif
 
 #ifdef CONFIG_PCIE_ECRC
-- 
2.17.0.441.gb46fe60e1d-goog
