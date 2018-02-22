Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38188 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752816AbeBVHqm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Feb 2018 02:46:42 -0500
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
Subject: [PATCH v9 5/7] PCI/AER: Unify aer error defines at single space
Date: Thu, 22 Feb 2018 13:16:09 +0530
Message-Id: <1519285571-5634-6-git-send-email-poza@codeaurora.org>
In-Reply-To: <1519285571-5634-1-git-send-email-poza@codeaurora.org>
References: <1519285571-5634-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch moves AER error defines to drivers/pci/pci.h.
So that it unifies the error repoting codes at single place along with dpc

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 1efefe9..7ae9bb3 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -56,6 +56,7 @@
 #include <ras/ras_event.h>
 
 #include "apei-internal.h"
+#include "../../pci/pci.h"
 
 #define GHES_PFX	"GHES: "
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 124f42e..b0e63b5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -343,7 +343,11 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 void pci_enable_acs(struct pci_dev *dev);
 
 /* PCI error reporting and recovery */
-#define DPC_FATAL	4
+#define AER_NONFATAL		0
+#define AER_FATAL		1
+#define AER_CORRECTABLE		2
+
+#define DPC_FATAL		4
 
 void pci_do_recovery(struct pci_dev *dev, int severity);
 
diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
index 6a352e6..4c59f37 100644
--- a/drivers/pci/pcie/aer/aerdrv_errprint.c
+++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
@@ -19,6 +19,7 @@
 #include <linux/cper.h>
 
 #include "aerdrv.h"
+#include "../../pci.h"
 #include <ras/ras_event.h>
 
 #define AER_AGENT_RECEIVER		0
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 8f87bbe..3eac8ed 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -11,10 +11,6 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 
-#define AER_NONFATAL			0
-#define AER_FATAL			1
-#define AER_CORRECTABLE			2
-
 struct pci_dev;
 
 struct aer_header_log_regs {
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 9c68986..d75c75b 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -13,6 +13,7 @@
 #include <linux/aer.h>
 #include <linux/cper.h>
 #include <linux/mm.h>
+#include "../../../drivers/pci/pci.h"
 
 /*
  * MCE Extended Error Log trace event
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
