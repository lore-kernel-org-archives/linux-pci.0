Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:13364 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbbIQVWh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2015 17:22:37 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v1 5/7] PCI: Let kcmdline specify static enumeration profile
Date: Thu, 17 Sep 2015 21:11:19 +0000
Message-ID: <a0d7abf7a8094e018e5b818a12903663@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Allow the user to specify a static enumeration profile via kernel
command line.  An upcoming commit will parse that option.

Signed-off-by: Jason Tang <jason.tang2@ngc.com>
---
 drivers/pci/Makefile          |  2 ++
 drivers/pci/pci.c             |  2 ++
 drivers/pci/pci.h             |  6 ++++++
 drivers/pci/pci_static_enum.c | 31 +++++++++++++++++++++++++++++++
 4 files changed, 41 insertions(+)
 create mode 100644 drivers/pci/pci_static_enum.c

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 73e4af4..3cacdfc 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -59,5 +59,7 @@ obj-$(CONFIG_OF) += of.o
 
 ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
 
+obj-$(CONFIG_PCI_STATIC_ENUMERATION) += pci_static_enum.o
+
 # PCI host controller drivers
 obj-y += host/
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c56dd35..d42be48 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4595,6 +4595,8 @@ static int __init pci_setup(char *str)
 				pcie_bus_config = PCIE_BUS_PEER2PEER;
 			} else if (!strncmp(str, "pcie_scan_all", 13)) {
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
+			} else if (!strncmp(str, "enum=", 5)) {
+				pci_static_enum_set_opt(str + 5);
 			} else {
 				printk(KERN_ERR "PCI: Unknown option `%s'\n",
 						str);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4ff0ff1..0a37794 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -335,4 +335,10 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 
 struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
 
+#ifdef CONFIG_PCI_STATIC_ENUMERATION
+void pci_static_enum_set_opt(const char *str);
+#else
+static inline void pci_static_enum_set_opt(const char *str) { return; }
+#endif
+
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/pci_static_enum.c b/drivers/pci/pci_static_enum.c
new file mode 100644
index 0000000..2d6cb33
--- /dev/null
+++ b/drivers/pci/pci_static_enum.c
@@ -0,0 +1,31 @@
+/*
+ * PCI static enumeration
+ *
+ * Copyright (C) 2015 Northrop Grumman Corporation.  All rights reserved.
+ *                    Jason Tang <jason.tang2@ngc.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/string.h>
+
+#include <asm/setup.h>
+
+#define PREFIX "PCI ENUM: "
+
+#define PCI_STATIC_ENUM_PARAM_SIZE COMMAND_LINE_SIZE
+static char pci_static_enum_param[PCI_STATIC_ENUM_PARAM_SIZE] = { 0 };
+
+/**
+ * pci_static_enum_set_opt() - set PCI static enumeration options as
+ * given by kernel command line
+ * @str: static enumeration options
+ */
+void __init pci_static_enum_set_opt(const char *str)
+{
+	strncpy(pci_static_enum_param, str, sizeof(pci_static_enum_param));
+	pci_static_enum_param[sizeof(pci_static_enum_param) - 1] = '\0';
+}
-- 
1.8.3.1

