Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
To: <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
	<lenb@kernel.org>, <izumi.taku@jp.fujitsu.com>,
	<wency@cn.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
	<ddaney.cavm@gmail.com>, <chen.fan.fnst@cn.fujitsu.com>,
	<helgaas@kernel.org>, <okaya@codeaurora.org>,
	<bhelgaas@google.com>, <jiang.liu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <tglx@linutronix.de>,
	<linux@roeck-us.net>
Subject: [PATCH v3 1/2] pci: add an irq_invalid flag to specify the IRQ is not connected
Date: Wed, 27 Jan 2016 14:08:43 +0800
Message-ID: <f83cc56ce64ab6d18e28ed5a7faa18fb81a7880d.1453862105.git.chen.fan.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1453862105.git.chen.fan.fnst@cn.fujitsu.com>
References: <cover.1453862105.git.chen.fan.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Quoting the PCI3.0 SPEC on page 223:
"For x86 based PCs, the values in this register correspond
to IRQ numbers (0-15) of the standard dual 8259 configuration.
The value 255 is defined as meaning "unknown" or "no connection"
to the interrupt controller. Values between 15 and 254 are reserved."

So we add an irq_invalid flag to tell driver that the device wire
is not connected. then the driver could know whether it should call
request_irq().

Signed-off-by: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
---
 drivers/acpi/pci_irq.c | 10 ++++++++++
 include/linux/pci.h    |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index d30184c..bb78376 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -436,6 +436,16 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	 * driver reported one, then use it. Exit in any case.
 	 */
 	if (gsi < 0) {
+#ifdef CONFIG_X86
+		/*
+		 * For X86 architecture, The Interrupt Line value of 0xff is
+		 * defined to mean "unknown" or "no connection" (PCI 3.0,
+		 * Section 6.2.4, footnote on page 223). we flag the IRQ
+		 * as INVALID.
+		 */
+		if (dev->irq == 0xff)
+			dev->irq_invalid = 1;
+#endif
 		if (acpi_isa_register_gsi(dev))
 			dev_warn(&dev->dev, "PCI INT %c: no GSI\n",
 				 pin_name(pin));
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d86378c..06f137e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -359,6 +359,7 @@ struct pci_dev {
 	unsigned int	io_window_1k:1;	/* Intel P2P bridge 1K I/O windows */
 	unsigned int	irq_managed:1;
 	unsigned int	has_secondary_link:1;
+	unsigned int	irq_invalid:1;
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
-- 
1.9.3



