Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:25470 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbdHFAEc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Aug 2017 20:04:32 -0400
From: Paul Burton <paul.burton@imgtec.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Bharat Kumar Gogada <bharatku@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v6 1/6] PCI: Move enum pci_interrupt_pin to a new common header
Date: Sat, 5 Aug 2017 17:03:46 -0700
Message-ID: <20170806000351.17952-2-paul.burton@imgtec.com>
In-Reply-To: <20170806000351.17952-1-paul.burton@imgtec.com>
References: <20170806000351.17952-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We currently have a definition of enum pci_interrupt_pin in a header
specific to PCI endpoints - pci-epf.h. In order to allow for use of this
enum from PCI host code in a future commit, move its definition to a new
pci-common.h header which we'll include from both host & endpoint code.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org

---

Changes in v6:
- New patch.

 include/linux/pci-common.h | 31 +++++++++++++++++++++++++++++++
 include/linux/pci-epf.h    |  9 +--------
 2 files changed, 32 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/pci-common.h

diff --git a/include/linux/pci-common.h b/include/linux/pci-common.h
new file mode 100644
index 000000000000..6a69a2c95ac7
--- /dev/null
+++ b/include/linux/pci-common.h
@@ -0,0 +1,31 @@
+/**
+ * Common PCI definitions
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 of
+ * the License as published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_PCI_COMMON_H__
+#define __LINUX_PCI_COMMON_H__
+
+/**
+ * enum pci_interrupt_pin - PCI INTx interrupt values
+ * @PCI_INTERRUPT_UNKNOWN: Unknown or unassigned interrupt
+ * @PCI_INTERRUPT_INTA: PCI INTA pin
+ * @PCI_INTERRUPT_INTB: PCI INTB pin
+ * @PCI_INTERRUPT_INTC: PCI INTC pin
+ * @PCI_INTERRUPT_INTD: PCI INTD pin
+ *
+ * Corresponds to values for legacy PCI INTx interrupts, as can be found in the
+ * PCI_INTERRUPT_PIN register.
+ */
+enum pci_interrupt_pin {
+	PCI_INTERRUPT_UNKNOWN,
+	PCI_INTERRUPT_INTA,
+	PCI_INTERRUPT_INTB,
+	PCI_INTERRUPT_INTC,
+	PCI_INTERRUPT_INTD,
+};
+
+#endif /* __LINUX_PCI_COMMON_H__ */
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 0d529cb90143..77c92fcb2416 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -14,17 +14,10 @@
 
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/pci-common.h>
 
 struct pci_epf;
 
-enum pci_interrupt_pin {
-	PCI_INTERRUPT_UNKNOWN,
-	PCI_INTERRUPT_INTA,
-	PCI_INTERRUPT_INTB,
-	PCI_INTERRUPT_INTC,
-	PCI_INTERRUPT_INTD,
-};
-
 enum pci_barno {
 	BAR_0,
 	BAR_1,
-- 
2.13.4
