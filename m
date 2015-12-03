Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:37160 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757972AbbLCPGI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2015 10:06:08 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <bhelgaas@google.com>, <arnd@arndb.de>, <will.deacon@arm.com>,
	<catalin.marinas@arm.com>, <hanjun.guo@linaro.org>,
	<Lorenzo.Pieralisi@arm.com>, <Liviu.Dudau@arm.com>,
	<tn@semihalf.com>
CC: <jiang.liu@linux.intel.com>, <tglx@linutronix.de>,
	<wangyijing@huawei.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linaro-acpi@lists.linaro.org>, <wangzhou1@hisilicon.com>,
	<liudongdong3@huawei.com>, <xuwei5@hisilicon.com>,
	<liguozhu@hisilicon.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: [RFC PATCH 1/2] PCI/ACPI: Add ACPI support for non ECAM Host Bridge Controllers
Date: Thu, 3 Dec 2015 23:19:58 +0800
Message-ID: <1449155999-220955-2-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1449155999-220955-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1449155999-220955-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch modifies the ARM64 architecure specific PCI framework to
support Host Bridge specific quirks. these quirks are need for
host bridge controllers that are not fully ECAM compliant.
The quirks array allows each vendor to define his own
acpi_scan_handler where its own pci_ops can be defined
and the global pointer "vendor_specific_ops" should be
set to them accordingly.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Signed-off-by: Liudongdong <liudongdong3@huawei.com>
---
 arch/arm64/kernel/pci.c        | 41 +++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/pci_quirks.h | 24 ++++++++++++++++++++++++
 drivers/acpi/pci_root.c        |  4 ++++
 include/acpi/acpi_drivers.h    |  6 ++++++
 4 files changed, 75 insertions(+)
 create mode 100644 arch/arm64/kernel/pci_quirks.h

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 66cc1ae..d60edb4 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 
 #include <asm/pci-bridge.h>
+#include "pci_quirks.h"
 
 /*
  * Called after each bus is probed, but before its children are examined
@@ -230,6 +231,43 @@ static struct acpi_pci_root_ops acpi_pci_root_ops = {
 	.prepare_resources = pci_acpi_root_prepare_resources,
 };
 
+/*
+ * List of acpi_scan_handlers according to the specific
+ * Host Bridge controllers that are non ECAM compliant
+ */
+static struct acpi_scan_handler *quirks_array[] = {
+		0
+};
+
+void acpi_arm64_quirks(void)
+{
+	int i = 0;
+
+	while (quirks_array[i]) {
+		acpi_scan_add_handler(quirks_array[i]);
+		i++;
+	}
+
+}
+
+/*
+ * pci_ops specified by vendors that are not
+ * ECAM compliant
+ */
+struct pci_ops *vendor_specific_ops;
+
+/* function to set vendor specific ops */
+void set_quirk_pci_ops(struct pci_ops *quirk_ops)
+{
+	vendor_specific_ops = quirk_ops;
+}
+
+/* function to unset vendor specific ops */
+void unset_quirk_pci_ops(void)
+{
+	vendor_specific_ops = NULL;
+}
+
 /* Root bridge scanning */
 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 {
@@ -253,6 +291,9 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		return NULL;
 	}
 
+	if (vendor_specific_ops)
+		acpi_pci_root_ops.pci_ops = vendor_specific_ops;
+
 	bus = acpi_pci_root_create(root, &acpi_pci_root_ops, info, root);
 
 	/* After the PCI-E bus has been walked and all devices discovered,
diff --git a/arch/arm64/kernel/pci_quirks.h b/arch/arm64/kernel/pci_quirks.h
new file mode 100644
index 0000000..27055ff
--- /dev/null
+++ b/arch/arm64/kernel/pci_quirks.h
@@ -0,0 +1,24 @@
+/*
+ * PCIe host controller declarations for ACPI quirks
+ *
+ * Copyright (C) 2015 HiSilicon Co., Ltd. http://www.hisilicon.com
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef PCI_QUIRKS_H
+#define PCI_QUIRKS_H
+
+/* declarations of vendor specific quirks */
+extern struct acpi_scan_handler pci_root_hisi_handler;
+
+/* function to set vendor specific ops */
+void set_quirk_pci_ops(struct pci_ops *quirk_ops);
+
+/* function to unset vendor specific ops */
+void unset_quirk_pci_ops(void);
+
+#endif /*PCI_QUIRKS_H*/
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index e682dc6..ff362bb3d 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -863,5 +863,9 @@ void __init acpi_pci_root_init(void)
 		return;
 
 	pci_acpi_crs_quirks();
+
+	/* Call quirks for non ECAM ARM64 Host Brdge controllers */
+	acpi_arm64_quirks();
+
 	acpi_scan_add_handler_with_hotplug(&pci_root_handler, "pci_root");
 }
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 29c6912..17f4a37 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -99,6 +99,12 @@ void pci_acpi_crs_quirks(void);
 static inline void pci_acpi_crs_quirks(void) { }
 #endif
 
+#ifdef CONFIG_ARM64
+void acpi_arm64_quirks(void);
+#else
+static inline void acpi_arm64_quirks(void) { }
+#endif
+
 /* --------------------------------------------------------------------------
                                     Processor
    -------------------------------------------------------------------------- */
-- 
1.9.1

