Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Sat, 6 Feb 2016 09:19:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Chen Fan <chen.fan.fnst@cn.fujitsu.com>,
	linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: Problems since commit Recognize that Interrupt Line 255 means
 "not connected"
Message-ID: <20160206151922.GB22119@localhost>
References: <56B52990.3030103@gmail.com>
 <1676062.Zh6hUgWIix@vostro.rjw.lan>
 <56B5AA4B.5040705@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56B5AA4B.5040705@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Heiner,

On Sat, Feb 06, 2016 at 09:09:47AM +0100, Heiner Kallweit wrote:
> Am 06.02.2016 um 00:37 schrieb Rafael J. Wysocki:
> > On Saturday, February 06, 2016 12:00:32 AM Heiner Kallweit wrote:
> >> Since commit a44c386a361e "x86/PCI/ACPI: Recognize that Interrupt Line 255
> >> means "not connected"" I get several "PCI INT not connected" warnings on
> >> a Zotac CI321 and EHCI failes to load:
> > 
> > That doesn't follow clearly from your report, but I'm assuming that it works
> > correctly without that commit, right?
> > 
> Right, w/o this commit it looks like this:
> 
> dmesg
> ehci-pci 0000:00:1d.0: irq 23, io mem 0xf7d1b000
> 
> /proc/interrupts
> IO-APIC  23-fasteoi   ehci_hcd:usb3

Thanks a lot for your report!  This is a bit of a minefield, and I was
worried that we'd trip over something with a44c386a361e.

Oops, I think I see a problem with a44c386a361e.  We're checking for
Interrupt Line == 255 even before we try to look it up in the _PRT.  I
think we should only check Interrupt Line *after* everything else has
failed.  Can you try the patch below instead of a44c386a361e?

If the patch below doesn't work, would you mind collecting the
complete output of "lspci -vvv" and the complete dmesg logs from
kernels with and without a44c386a361e, and putting them somewhere
(maybe a bugzilla.kernel.org report)?

Bjorn


diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index d30184c..807a0a8 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -33,6 +33,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>
 
 #define PREFIX "ACPI: "
 
@@ -387,6 +388,23 @@ static inline int acpi_isa_register_gsi(struct pci_dev *dev)
 }
 #endif
 
+static inline bool acpi_pci_irq_valid(struct pci_dev *dev, u8 pin)
+{
+#ifdef CONFIG_X86
+	/*
+	 * On x86, Interrupt Line 0xff means "unknown" or "no connection"
+	 * (PCI 3.0, Section 6.2.4, footnote on page 223).
+	 */
+	if (dev->irq == 0xff) {
+		dev->irq = IRQ_NOTCONNECTED;
+		dev_warn(&dev->dev, "PCI INT %c: not connected\n",
+			 pin_name(pin));
+		return false;
+	}
+#endif
+	return true;
+}
+
 int acpi_pci_irq_enable(struct pci_dev *dev)
 {
 	struct acpi_prt_entry *entry;
@@ -431,11 +449,14 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	} else
 		gsi = -1;
 
-	/*
-	 * No IRQ known to the ACPI subsystem - maybe the BIOS / 
-	 * driver reported one, then use it. Exit in any case.
-	 */
 	if (gsi < 0) {
+		/*
+		 * No IRQ known to the ACPI subsystem - maybe the BIOS /
+		 * driver reported one, then use it. Exit in any case.
+		 */
+		if (!acpi_pci_irq_valid(dev, pin))
+			return 0;
+
 		if (acpi_isa_register_gsi(dev))
 			dev_warn(&dev->dev, "PCI INT %c: no GSI\n",
 				 pin_name(pin));
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 0e95fcc..358076e 100644
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
 
