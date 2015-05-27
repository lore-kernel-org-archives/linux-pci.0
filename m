Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0102.northgrum.com ([134.223.120.77]:28268 "EHLO
	xspv0102.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbbE0VLW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 17:11:22 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v0 05/13] PCI: Specify static enumeration on kcmdline
Date: Wed, 27 May 2015 20:59:04 +0000
Message-ID: <b9348d39b49545df97fa07618668b62c@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The user can specify a static enumeration profile via kernel command
line. A future commit will parse those options.

Signed-off-by: Jason Tang <jason.tang2@ngc.com>
---
 drivers/pci/Makefile          |    2 ++
 drivers/pci/pci.c             |    2 ++
 drivers/pci/pci.h             |    2 ++
 drivers/pci/pci_static_enum.c |   54 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+)
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
index 81f06e8..5d8c0e0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4607,6 +4607,8 @@ static int __init pci_setup(char *str)
 				pcie_bus_config = PCIE_BUS_PEER2PEER;
 			} else if (!strncmp(str, "pcie_scan_all", 13)) {
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
+			} else if (!strncmp(str, "enum=", 5)) {
+				pci_static_enum_set_opt(str + 5);
 			} else {
 				printk(KERN_ERR "PCI: Unknown option `%s'\n",
 						str);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 075bd9d..3282b51 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -322,6 +322,7 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 #endif
 
 #ifdef CONFIG_PCI_STATIC_ENUMERATION
+void pci_static_enum_set_opt(const char *str);
 /**
  * pci_bus_subordinate() - return the subordinate bus number assigned
  * to @dev by the static enumeration profile, or 0 if not set
@@ -331,6 +332,7 @@ static inline unsigned char pci_bus_subordinate(struct pci_bus *bus)
 	return bus->subordinate;
 }
 #else
+static inline void pci_static_enum_set_opt(const char *str) { return; }
 static inline unsigned char pci_bus_subordinate(struct pci_bus *bus)
 {
 	return 0;
diff --git a/drivers/pci/pci_static_enum.c b/drivers/pci/pci_static_enum.c
new file mode 100644
index 0000000..a28bd33
--- /dev/null
+++ b/drivers/pci/pci_static_enum.c
@@ -0,0 +1,54 @@
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
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+
+#include <asm/setup.h>
+
+#define PREFIX "PCI ENUM: "
+
+static DEFINE_SPINLOCK(static_enum_lock);
+
+#define PCI_STATIC_ENUM_PARAM_SIZE COMMAND_LINE_SIZE
+static char pci_static_enum_param[PCI_STATIC_ENUM_PARAM_SIZE] = { 0 };
+
+/**
+ * pci_static_enum_set_opt() - set/append the PCI static enumeration
+ * options as given by kernel command line
+ * @str: static enumeration options
+ */
+void __init pci_static_enum_set_opt(const char *str)
+{
+	/*
+	   So why store the options and parse later? The reason is
+	   because the static enumerator is stateful, in that it keeps
+	   track of which devices it has overridden. It cannot call
+	   kmalloc() yet because memory allocation has not been set up
+	   yet when this function is called. The next best thing is
+	   store the options in a statically-allocated string, and then
+	   parse it later, when kmalloc() is legal.
+	 */
+	size_t cur, len;
+
+	spin_lock(&static_enum_lock);
+	cur = strlen(pci_static_enum_param);
+	len = strlen(str);
+	/* use ';' to separate each option */
+	if (cur > 0 && cur < PCI_STATIC_ENUM_PARAM_SIZE - 1)
+		pci_static_enum_param[cur++] = ';';
+	if (len > PCI_STATIC_ENUM_PARAM_SIZE - 1 - cur)
+		len = PCI_STATIC_ENUM_PARAM_SIZE - 1 - cur;
+	strncat(pci_static_enum_param + cur, str, len);
+	spin_unlock(&static_enum_lock);
+}
-- 
1.7.9.5

