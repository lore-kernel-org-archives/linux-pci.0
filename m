Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:1459 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbdHOTDL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2017 15:03:11 -0400
From: Paul Burton <paul.burton@imgtec.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v7 1/8] PCI: Move enum pci_interrupt_pin to linux/pci.h
Date: Tue, 15 Aug 2017 12:02:16 -0700
Message-ID: <20170815190223.18807-2-paul.burton@imgtec.com>
In-Reply-To: <20170815190223.18807-1-paul.burton@imgtec.com>
References: <20170815190223.18807-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We currently have a definition of enum pci_interrupt_pin in a header
specific to PCI endpoints - linux/pci-epf.h. In order to allow for use
of this enum from PCI host code in a future commit, move its definition
to linux/pci.h & include that from linux/pci-epf.h.

Additionally we add a PCI_NUM_INTX macro which indicates the number of
PCI INTx interrupts, and will be used alongside enum pci_interrupt_pin
in further patches.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org

---

Changes in v7:
- Move it to linux/pci.h rather than a new header.
- Add PCI_NUM_INTX.

Changes in v6:
- New patch.

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 include/linux/pci-epf.h |  9 +--------
 include/linux/pci.h     | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 0d529cb90143..bc8750688348 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -14,17 +14,10 @@
 
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/pci.h>
 
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
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a75c13673852..8098c438d88a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1395,6 +1395,28 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 					      NULL);
 }
 
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
+/* The number of legacy PCI INTx interrupts */
+#define PCI_NUM_INTX	4
+
 #ifdef CONFIG_PCIEPORTBUS
 extern bool pcie_ports_disabled;
 extern bool pcie_ports_auto;
-- 
2.14.1
