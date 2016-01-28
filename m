Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
To: <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
	<lenb@kernel.org>, <izumi.taku@jp.fujitsu.com>,
	<wency@cn.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
	<ddaney.cavm@gmail.com>, <chen.fan.fnst@cn.fujitsu.com>,
	<helgaas@kernel.org>, <okaya@codeaurora.org>,
	<bhelgaas@google.com>, <jiang.liu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 1/1] pci: fix unavailable irq number 255 reported by BIOS
Date: Thu, 28 Jan 2016 09:35:46 +0800
Message-ID: <1453944946-18852-1-git-send-email-chen.fan.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In our X86 environment, when enable Secure boot, we found an abnormal
phenomenon as following call trace shows. after investigation, we
found the firmware assigned an irq number 255 which means unknown
or no connection in PCI local spec for i801_smbus, meanwhile the
ACPI didn't configure the pci irq routing. and the 255 irq number
was assigned for megasa msix without IRQF_SHARED. then in this case
during i801_smbus probe, the i801_smbus driver would request irq with
bad irq number 255. but the 255 irq number was assigned for memgasa
with MSIX enable. which will cause request_irq fails and result in
the call trace below, here we introduce an IRQ_NOTCONNECTED to identify
the device interrupt is not connected.

i801_smbus 0000:00:1f.3: enabling device (0140 -> 0143)
i801_smbus 0000:00:1f.3: can't derive routing for PCI INT C
i801_smbus 0000:00:1f.3: PCI INT C: no GSI
genirq: Flags mismatch irq 255. 00000080 (i801_smbus) vs. 00000000 (megasa)
CPU: 0 PID: 2487 Comm: kworker/0:1 Not tainted 3.10.0-229.el7.x86_64 #1
Hardware name: FUJITSU PRIMEQUEST 2800E2/D3736, BIOS PRIMEQUEST 2000 Serie5

Call Trace:
  dump_stack+0x19/0x1b
  __setup_irq+0x54a/0x570
  request_threaded_irq+0xcc/0x170
  i801_probe+0x32f/0x508 [i2c_i801]
  local_pci_probe+0x45/0xa0
i801_smbus 0000:00:1f.3: Failed to allocate irq 255: -16
i801_smbus: probe of 0000:00:1f.3 failed with error -16

Signed-off-by: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>
---
 drivers/acpi/pci_irq.c    | 20 ++++++++++++++++++++
 include/linux/interrupt.h | 10 ++++++++++
 kernel/irq/manage.c       |  9 ++++++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index d30184c..dda6d25 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -33,6 +33,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>
 
 #define PREFIX "ACPI: "
 
@@ -387,6 +388,22 @@ static inline int acpi_isa_register_gsi(struct pci_dev *dev)
 }
 #endif
 
+static inline bool acpi_pci_irq_valid(struct pci_dev *dev)
+{
+#ifdef CONFIG_X86
+	/*
+	 * On x86 irq line 0xff means "unknown" or "no connection" (PCI 3.0,
+	 * Section 6.2.4, footnote on page 223).
+	 */
+	if (dev->irq == 0xff) {
+		dev->irq = IRQ_NOTCONNECTED;
+		dev_warn(&dev->dev, "PCI INT not connected\n");
+		return false;
+	}
+#endif
+	return true;
+}
+
 int acpi_pci_irq_enable(struct pci_dev *dev)
 {
 	struct acpi_prt_entry *entry;
@@ -409,6 +426,9 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	if (pci_has_managed_irq(dev))
 		return 0;
 
+	if (!acpi_pci_irq_valid(dev))
+		return 0;
+
 	entry = acpi_pci_irq_lookup(dev, pin);
 	if (!entry) {
 		/*
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index cb30edb..12f7da4 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -125,6 +125,16 @@ struct irqaction {
 
 extern irqreturn_t no_action(int cpl, void *dev_id);
 
+/*
+ * If a (PCI) device interrupt is not connected we set dev->irq to
+ * IRQ_NOTCONNECTED. This causes request_irq() to fail with -ENOTCONN, so we
+ * can distingiush that case from other error returns.
+ *
+ * 0x80000000 is guaranteed to be outside the available range of interrupts
+ * and easy to distinguish from other possible incorrect values.
+ */
+#define IRQ_NOTCONNECTED	(1U << 31)
+
 extern int __must_check
 request_threaded_irq(unsigned int irq, irq_handler_t handler,
 		     irq_handler_t thread_fn,
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 8411872..e79e60f 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1609,6 +1609,9 @@ int request_threaded_irq(unsigned int irq, irq_handler_t handler,
 	struct irq_desc *desc;
 	int retval;
 
+	if (irq == IRQ_NOTCONNECTED)
+		return -ENOTCONN;
+
 	/*
 	 * Sanity-check: shared interrupts must pass in a real dev-ID,
 	 * otherwise we'll have trouble later trying to figure out
@@ -1699,9 +1702,13 @@ EXPORT_SYMBOL(request_threaded_irq);
 int request_any_context_irq(unsigned int irq, irq_handler_t handler,
 			    unsigned long flags, const char *name, void *dev_id)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
+	struct irq_desc *desc;
 	int ret;
 
+	if (irq == IRQ_NOTCONNECTED)
+		return -ENOTCONN;
+
+	desc = irq_to_desc(irq);
 	if (!desc)
 		return -EINVAL;
 
-- 
1.9.3



