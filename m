Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:27043 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbdHFAEu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Aug 2017 20:04:50 -0400
From: Paul Burton <paul.burton@imgtec.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Bharat Kumar Gogada <bharatku@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v6 2/6] PCI: Introduce pci_irqd_intx_xlate()
Date: Sat, 5 Aug 2017 17:03:47 -0700
Message-ID: <20170806000351.17952-3-paul.burton@imgtec.com>
In-Reply-To: <20170806000351.17952-1-paul.burton@imgtec.com>
References: <20170806000351.17952-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Legacy PCI INTx interrupts are represented in both the PCI_INTERRUPT_PIN
register & in device trees using the range 1-4. This has led to various
drivers using this range internally with an IRQ domain of size 5 whose
first entry is wasted, and to other drivers getting this wrong resulting
in broken interrupts.

In order to save the wasted IRQ domain entry this patch introduces a new
pci_irqd_intx_xlate() helper function, which drivers can assign as the
xlate callback for their INTx IRQ domain. Further patches will make use
of this in drivers to allow them to use an IRQ domain of size 4 for
legacy INTx interrupts.

Note that although it seems tempting to instead perform this translation
in of_irq_parse_pci() in order to catch all drivers in one shot, this
would present complications with handling interrupt-map properties in
device trees, since those are handled outside of of_irq_parse_pci() &
expect the 1-4 range for INTx interrupts. It would also require that all
drivers are modified at once, where this approach allows them to be
tackled one by one.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org

---
Bjorn, if this works for you then I can prepare another series to fix up
other drivers to use this if you like.

Changes in v6:
- New patch.

 include/linux/pci.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4869e66dd659..40c4f5f48d5b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -33,6 +33,7 @@
 #include <linux/resource_ext.h>
 #include <uapi/linux/pci.h>
 
+#include <linux/pci-common.h>
 #include <linux/pci_ids.h>
 
 /*
@@ -1394,6 +1395,38 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 					      NULL);
 }
 
+/**
+ * pci_irqd_intx_xlate() - Translate PCI INTx value to an IRQ domain hwirq
+ * @d: the INTx IRQ domain
+ * @node: the DT node for the device whose interrupt we're translating
+ * @intspec: the interrupt specifier data from the DT
+ * @intsize: the number of entries in @intspec
+ * @out_hwirq: pointer at which to write the hwirq number
+ * @out_type: pointer at which to write the interrupt type
+ *
+ * Translate a PCI INTx interrupt number from device tree in the range 1-4, as
+ * stored in the standard PCI_INTERRUPT_PIN register, to a value in the range
+ * 0-3 suitable for use in a 4 entry IRQ domain. That is, subtract one from the
+ * INTx value to obtain the hwirq number.
+ *
+ * Returns 0 on success, or -EINVAL if the interrupt specifier is out of range.
+ */
+static inline int pci_irqd_intx_xlate(struct irq_domain *d,
+				      struct device_node *node,
+				      const u32 *intspec,
+				      unsigned int intsize,
+				      unsigned long *out_hwirq,
+				      unsigned int *out_type)
+{
+	const u32 intx = intspec[0];
+
+	if (intx < PCI_INTERRUPT_INTA || intx > PCI_INTERRUPT_INTD)
+		return -EINVAL;
+
+	*out_hwirq = intx - PCI_INTERRUPT_INTA;
+	return 0;
+}
+
 #ifdef CONFIG_PCIEPORTBUS
 extern bool pcie_ports_disabled;
 extern bool pcie_ports_auto;
-- 
2.13.4
