Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 10/13] PCI/AER: Move private AER things to aerdrv.c
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:05:47 -0500
Message-ID: <152848834746.11888.3692087095799839481.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Most of the things in aerdrv.h are only used in aerdrv.c, so move them
there.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/aerdrv.c |   64 +++++++++++++++++++++++++++++++++
 drivers/pci/pcie/aer/aerdrv.h |   79 -----------------------------------------
 2 files changed, 63 insertions(+), 80 deletions(-)
 delete mode 100644 drivers/pci/pcie/aer/aerdrv.h

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 51b66307e68c..3fc23fc95f98 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -27,8 +27,70 @@
 #include <acpi/apei.h>
 #include <ras/ras_event.h>
 
-#include "aerdrv.h"
 #include "../../pci.h"
+#include "../portdrv.h"
+
+#define AER_ERROR_SOURCES_MAX		100
+#define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
+
+struct aer_err_info {
+	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
+	int error_dev_num;
+
+	unsigned int id:16;
+
+	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
+	unsigned int __pad1:5;
+	unsigned int multi_error_valid:1;
+
+	unsigned int first_error:5;
+	unsigned int __pad2:2;
+	unsigned int tlp_header_valid:1;
+
+	unsigned int status;		/* COR/UNCOR Error Status */
+	unsigned int mask;		/* COR/UNCOR Error Mask */
+	struct aer_header_log_regs tlp;	/* TLP Header */
+};
+
+struct aer_err_source {
+	unsigned int status;
+	unsigned int id;
+};
+
+struct aer_rpc {
+	struct pci_dev *rpd;		/* Root Port device */
+	struct work_struct dpc_handler;
+	struct aer_err_source e_sources[AER_ERROR_SOURCES_MAX];
+	struct aer_err_info e_info;
+	unsigned short prod_idx;	/* Error Producer Index */
+	unsigned short cons_idx;	/* Error Consumer Index */
+	int isr;
+	spinlock_t e_lock;		/*
+					 * Lock access to Error Status/ID Regs
+					 * and error producer/consumer index
+					 */
+	struct mutex rpc_mutex;		/*
+					 * only one thread could do
+					 * recovery on the same
+					 * root port hierarchy
+					 */
+};
+
+#define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
+					PCI_ERR_UNC_ECRC|		\
+					PCI_ERR_UNC_UNSUP|		\
+					PCI_ERR_UNC_COMP_ABORT|		\
+					PCI_ERR_UNC_UNX_COMP|		\
+					PCI_ERR_UNC_MALF_TLP)
+
+#define SYSTEM_ERROR_INTR_ON_MESG_MASK	(PCI_EXP_RTCTL_SECEE|	\
+					PCI_EXP_RTCTL_SENFEE|	\
+					PCI_EXP_RTCTL_SEFEE)
+#define ROOT_PORT_INTR_ON_MESG_MASK	(PCI_ERR_ROOT_CMD_COR_EN|	\
+					PCI_ERR_ROOT_CMD_NONFATAL_EN|	\
+					PCI_ERR_ROOT_CMD_FATAL_EN)
+#define ERR_COR_ID(d)			(d & 0xffff)
+#define ERR_UNCOR_ID(d)			(d >> 16)
 
 static int pcie_aer_disable;
 
diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
deleted file mode 100644
index 9867950635df..000000000000
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ /dev/null
@@ -1,79 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2006 Intel Corp.
- *	Tom Long Nguyen (tom.l.nguyen@intel.com)
- *	Zhang Yanmin (yanmin.zhang@intel.com)
- */
-
-#ifndef _AERDRV_H_
-#define _AERDRV_H_
-
-#include <linux/workqueue.h>
-#include <linux/aer.h>
-#include <linux/interrupt.h>
-
-#include "../portdrv.h"
-
-#define SYSTEM_ERROR_INTR_ON_MESG_MASK	(PCI_EXP_RTCTL_SECEE|	\
-					PCI_EXP_RTCTL_SENFEE|	\
-					PCI_EXP_RTCTL_SEFEE)
-#define ROOT_PORT_INTR_ON_MESG_MASK	(PCI_ERR_ROOT_CMD_COR_EN|	\
-					PCI_ERR_ROOT_CMD_NONFATAL_EN|	\
-					PCI_ERR_ROOT_CMD_FATAL_EN)
-#define ERR_COR_ID(d)			(d & 0xffff)
-#define ERR_UNCOR_ID(d)			(d >> 16)
-
-#define AER_ERROR_SOURCES_MAX		100
-
-#define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
-					PCI_ERR_UNC_ECRC|		\
-					PCI_ERR_UNC_UNSUP|		\
-					PCI_ERR_UNC_COMP_ABORT|		\
-					PCI_ERR_UNC_UNX_COMP|		\
-					PCI_ERR_UNC_MALF_TLP)
-
-#define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
-struct aer_err_info {
-	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
-	int error_dev_num;
-
-	unsigned int id:16;
-
-	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
-	unsigned int __pad1:5;
-	unsigned int multi_error_valid:1;
-
-	unsigned int first_error:5;
-	unsigned int __pad2:2;
-	unsigned int tlp_header_valid:1;
-
-	unsigned int status;		/* COR/UNCOR Error Status */
-	unsigned int mask;		/* COR/UNCOR Error Mask */
-	struct aer_header_log_regs tlp;	/* TLP Header */
-};
-
-struct aer_err_source {
-	unsigned int status;
-	unsigned int id;
-};
-
-struct aer_rpc {
-	struct pci_dev *rpd;		/* Root Port device */
-	struct work_struct dpc_handler;
-	struct aer_err_source e_sources[AER_ERROR_SOURCES_MAX];
-	struct aer_err_info e_info;
-	unsigned short prod_idx;	/* Error Producer Index */
-	unsigned short cons_idx;	/* Error Consumer Index */
-	int isr;
-	spinlock_t e_lock;		/*
-					 * Lock access to Error Status/ID Regs
-					 * and error producer/consumer index
-					 */
-	struct mutex rpc_mutex;		/*
-					 * only one thread could do
-					 * recovery on the same
-					 * root port hierarchy
-					 */
-};
-
-#endif /* _AERDRV_H_ */
