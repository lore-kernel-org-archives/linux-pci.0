Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57436 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeAPJ7I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jan 2018 04:59:08 -0500
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH v4 3/5] PCI/ERR: Unify error info/types in pcie_err
Date: Tue, 16 Jan 2018 15:28:41 +0530
Message-Id: <1516096723-8013-4-git-send-email-poza@codeaurora.org>
In-Reply-To: <1516096723-8013-1-git-send-email-poza@codeaurora.org>
References: <1516096723-8013-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch unifies error reporting defines into separate file so that it
can be shared by clients, it provisions to add more error types from
multiple error handling agents such as aer, dpc etc.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 6402f7f..12072e4 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -42,6 +42,7 @@
 #include <linux/llist.h>
 #include <linux/genalloc.h>
 #include <linux/pci.h>
+#include <linux/pci_err.h>
 #include <linux/aer.h>
 #include <linux/nmi.h>
 #include <linux/sched/clock.h>
@@ -462,7 +463,7 @@ static void ghes_do_proc(struct ghes *ghes,
 				 * use, so treat it as a fatal AER error.
 				 */
 				if (gdata->flags & CPER_SEC_RESET)
-					aer_severity = AER_FATAL;
+					aer_severity = PCI_ERR_AER_FATAL;
 
 				aer_recover_queue(pcie_err->device_id.segment,
 						  pcie_err->device_id.bus,
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 5ed9575..23c3478 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -18,6 +18,7 @@
 
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pci_err.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/pm.h>
@@ -165,7 +166,7 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 		return false;
 
 	/* Check if error is recorded */
-	if (e_info->severity == AER_CORRECTABLE) {
+	if (e_info->severity == PCI_ERR_AER_CORRECTABLE) {
 		pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS, &status);
 		pci_read_config_dword(dev, pos + PCI_ERR_COR_MASK, &mask);
 	} else {
@@ -275,7 +276,7 @@ static void handle_error_source(struct pcie_device *aerdev,
 {
 	int pos;
 
-	if (info->severity == AER_CORRECTABLE) {
+	if (info->severity == PCI_ERR_AER_CORRECTABLE) {
 		/*
 		 * Correctable error does not need software intervention.
 		 * No need to go through error recovery process.
@@ -378,7 +379,7 @@ static int get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 	if (!pos)
 		return 1;
 
-	if (info->severity == AER_CORRECTABLE) {
+	if (info->severity == PCI_ERR_AER_CORRECTABLE) {
 		pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS,
 			&info->status);
 		pci_read_config_dword(dev, pos + PCI_ERR_COR_MASK,
@@ -386,7 +387,7 @@ static int get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 		if (!(info->status & ~info->mask))
 			return 0;
 	} else if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
-		info->severity == AER_NONFATAL) {
+		info->severity == PCI_ERR_AER_NONFATAL) {
 
 		/* Link is still healthy for IO reads */
 		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS,
@@ -449,7 +450,7 @@ static void aer_isr_one_error(struct pcie_device *p_device,
 	 */
 	if (e_src->status & PCI_ERR_ROOT_COR_RCV) {
 		e_info->id = ERR_COR_ID(e_src->id);
-		e_info->severity = AER_CORRECTABLE;
+		e_info->severity = PCI_ERR_AER_CORRECTABLE;
 
 		if (e_src->status & PCI_ERR_ROOT_MULTI_COR_RCV)
 			e_info->multi_error_valid = 1;
@@ -466,9 +467,9 @@ static void aer_isr_one_error(struct pcie_device *p_device,
 		e_info->id = ERR_UNCOR_ID(e_src->id);
 
 		if (e_src->status & PCI_ERR_ROOT_FATAL_RCV)
-			e_info->severity = AER_FATAL;
+			e_info->severity = PCI_ERR_AER_FATAL;
 		else
-			e_info->severity = AER_NONFATAL;
+			e_info->severity = PCI_ERR_AER_NONFATAL;
 
 		if (e_src->status & PCI_ERR_ROOT_MULTI_UNCOR_RCV)
 			e_info->multi_error_valid = 1;
diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
index 54c4b69..cf2b90b 100644
--- a/drivers/pci/pcie/aer/aerdrv_errprint.c
+++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
@@ -15,6 +15,7 @@
 
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pci_err.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/pm.h>
@@ -29,11 +30,11 @@
 #define AER_AGENT_COMPLETER		2
 #define AER_AGENT_TRANSMITTER		3
 
-#define AER_AGENT_REQUESTER_MASK(t)	((t == AER_CORRECTABLE) ?	\
+#define AER_AGENT_REQUESTER_MASK(t)	((t == PCI_ERR_AER_CORRECTABLE) ?	\
 	0 : (PCI_ERR_UNC_COMP_TIME|PCI_ERR_UNC_UNSUP))
-#define AER_AGENT_COMPLETER_MASK(t)	((t == AER_CORRECTABLE) ?	\
+#define AER_AGENT_COMPLETER_MASK(t)	((t == PCI_ERR_AER_CORRECTABLE) ?	\
 	0 : PCI_ERR_UNC_COMP_ABORT)
-#define AER_AGENT_TRANSMITTER_MASK(t)	((t == AER_CORRECTABLE) ?	\
+#define AER_AGENT_TRANSMITTER_MASK(t)	((t == PCI_ERR_AER_CORRECTABLE) ?	\
 	(PCI_ERR_COR_REP_ROLL|PCI_ERR_COR_REP_TIMER) : 0)
 
 #define AER_GET_AGENT(t, e)						\
@@ -46,9 +47,9 @@
 #define AER_DATA_LINK_LAYER_ERROR	1
 #define AER_TRANSACTION_LAYER_ERROR	2
 
-#define AER_PHYSICAL_LAYER_ERROR_MASK(t) ((t == AER_CORRECTABLE) ?	\
+#define AER_PHYSICAL_LAYER_ERROR_MASK(t) ((t == PCI_ERR_AER_CORRECTABLE) ?	\
 	PCI_ERR_COR_RCVR : 0)
-#define AER_DATA_LINK_LAYER_ERROR_MASK(t) ((t == AER_CORRECTABLE) ?	\
+#define AER_DATA_LINK_LAYER_ERROR_MASK(t) ((t == PCI_ERR_AER_CORRECTABLE) ?	\
 	(PCI_ERR_COR_BAD_TLP|						\
 	PCI_ERR_COR_BAD_DLLP|						\
 	PCI_ERR_COR_REP_ROLL|						\
@@ -147,7 +148,7 @@ static void __aer_print_error(struct pci_dev *dev,
 		if (!(status & (1 << i)))
 			continue;
 
-		if (info->severity == AER_CORRECTABLE)
+		if (info->severity == PCI_ERR_AER_CORRECTABLE)
 			errmsg = i < ARRAY_SIZE(aer_correctable_error_string) ?
 				aer_correctable_error_string[i] : NULL;
 		else
@@ -210,11 +211,11 @@ int cper_severity_to_aer(int cper_severity)
 {
 	switch (cper_severity) {
 	case CPER_SEV_RECOVERABLE:
-		return AER_NONFATAL;
+		return PCI_ERR_AER_NONFATAL;
 	case CPER_SEV_FATAL:
-		return AER_FATAL;
+		return PCI_ERR_AER_FATAL;
 	default:
-		return AER_CORRECTABLE;
+		return PCI_ERR_AER_CORRECTABLE;
 	}
 }
 EXPORT_SYMBOL_GPL(cper_severity_to_aer);
@@ -226,7 +227,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	u32 status, mask;
 	const char **status_strs;
 
-	if (aer_severity == AER_CORRECTABLE) {
+	if (aer_severity == PCI_ERR_AER_CORRECTABLE) {
 		status = aer->cor_status;
 		mask = aer->cor_mask;
 		status_strs = aer_correctable_error_string;
@@ -247,7 +248,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	dev_err(&dev->dev, "aer_layer=%s, aer_agent=%s\n",
 		aer_error_layer[layer], aer_agent_string[agent]);
 
-	if (aer_severity != AER_CORRECTABLE)
+	if (aer_severity != PCI_ERR_AER_CORRECTABLE)
 		dev_err(&dev->dev, "aer_uncor_severity: 0x%08x\n",
 			aer->uncor_severity);
 
diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
index 5792a9f..63566b1 100644
--- a/drivers/pci/pcie/pcie-err.c
+++ b/drivers/pci/pcie/pcie-err.c
@@ -16,6 +16,7 @@
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/pci_err.h>
 #include <linux/aer.h>
 #include <linux/pcieport_if.h>
 #include "portdrv.h"
@@ -283,7 +284,7 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
 	enum pci_channel_state state;
 
-	if (severity == AER_FATAL)
+	if (severity == PCI_ERR_AER_FATAL)
 		state = pci_channel_io_frozen;
 	else
 		state = pci_channel_io_normal;
@@ -293,7 +294,7 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 			"error_detected",
 			pci_report_error_detected);
 
-	if (severity == AER_FATAL) {
+	if (severity == PCI_ERR_AER_FATAL) {
 		result = pci_reset_link(dev);
 		if (result != PCI_ERS_RESULT_RECOVERED)
 			goto failed;
diff --git a/include/linux/aer.h b/include/linux/aer.h
index cd4f086..3eac8ed 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -11,10 +11,6 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 
-#define AER_NONFATAL		0
-#define AER_FATAL		1
-#define AER_CORRECTABLE		2
-
 struct pci_dev;
 
 struct aer_header_log_regs {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index babcd89..c170c92 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1998,8 +1998,6 @@ static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev, int res
 void pci_hp_remove_module_link(struct pci_slot *pci_slot);
 #endif
 
-void pci_do_recovery(struct pci_dev *dev, int severity);
-
 /**
  * pci_pcie_cap - get the saved PCIe capability offset
  * @dev: PCI device
diff --git a/include/linux/pci_err.h b/include/linux/pci_err.h
new file mode 100644
index 0000000..3710759
--- /dev/null
+++ b/include/linux/pci_err.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _PCI_ERR_H_
+#define _PCI_ERR_H_
+
+#define PCI_ERR_AER_NONFATAL		0
+#define PCI_ERR_AER_FATAL		1
+#define PCI_ERR_AER_CORRECTABLE		2
+
+void pci_do_recovery(struct pci_dev *dev, int severity);
+#endif /* _PCI_ERR_H_ */
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
