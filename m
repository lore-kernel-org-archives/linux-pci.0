Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:2949 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbdHOTDb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2017 15:03:31 -0400
From: Paul Burton <paul.burton@imgtec.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v7 2/8] PCI: Introduce pci_irqd_intx_xlate()
Date: Tue, 15 Aug 2017 12:02:17 -0700
Message-ID: <20170815190223.18807-3-paul.burton@imgtec.com>
In-Reply-To: <20170815190223.18807-1-paul.burton@imgtec.com>
References: <20170815190223.18807-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Legacy PCI INTx interrupts are represented in the PCI_INTERRUPT_PIN
register using the range 1-4, which matches our enum pci_interrupt_pin.
This is however not ideal for an IRQ domain, where with 4 interrupts we
would ideally have a domain of size 4 & hwirq numbers in the range 0-3.

Different PCI host controller drivers have handled this in different
ways. Of those under drivers/pci/ which register an INTx IRQ domain, we
have:

- pcie-altera uses the range 1-4 in device trees and an IRQ domain of
  size 5 to cover that range, with entry 0 wasted.

- pcie-xilinx & pcie-xilinx-nwl use the range 1-4 in device trees but
  register an IRQ domain of size 4, which doesn't cover the hwirq=4/INTD
  case leading to that interrupt being broken.

- pci-ftpci100 & pci-aardvark use the range 0-3 in both device trees &
  as hwirq numbering in the driver & IRQ domain.

In order to introduce some level of consistency in at least the hwirq
numbering used by the drivers & IRQ domains, this patch introduces a new
pci_irqd_intx_xlate() helper function which drivers using the 1-4 range
in device trees can assign as the xlate callback for their INTx IRQ
domain. This translates the 1-4 range into a 0-3 range, allowing us to
use an IRQ domain of size 4 & avoid a wasted entry. Further patches will
make use of this in drivers to allow them to use an IRQ domain of size 4
for legacy INTx interrupts without breaking INTD.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org

---

Changes in v7:
- Rewrite the commit message.

Changes in v6:
- New patch.

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 include/linux/pci.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8098c438d88a..e97ce5d1bbb6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1417,6 +1417,38 @@ enum pci_interrupt_pin {
 /* The number of legacy PCI INTx interrupts */
 #define PCI_NUM_INTX	4
 
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
2.14.1
