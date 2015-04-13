Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:8562 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754154AbbDMGRY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Apr 2015 02:17:24 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dimitri Sivanich <sivanich@sgi.com>, x86@kernel.org,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Grant Likely <grant.likely@linaro.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Cohen <david.a.cohen@linux.intel.com>,
	Sander Eikelenboom <linux@eikelenboom.it>,
	David Vrabel <david.vrabel@citrix.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch Part1 v8 36/37] x86/irq: Introduce helper functions to support hierarchy irqdomain for IOAPIC
Date: Mon, 13 Apr 2015 14:11:58 +0800
Message-Id: <1428905519-23704-37-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1428905519-23704-1-git-send-email-jiang.liu@linux.intel.com>
References: <1428905519-23704-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce several helper functions, which will be used to enable
hierarchy irqdomain for IOAPIC.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Grant Likely <grant.likely@linaro.org>
Link: http://lkml.kernel.org/r/1416901802-24211-9-git-send-email-jiang.liu@linux.intel.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/apic/io_apic.c |   61 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 3c6609617306..c8f786b5b91c 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -82,6 +82,7 @@ struct mp_chip_data {
 	struct IO_APIC_route_entry entry;
 	int trigger;
 	int polarity;
+	u32 count;
 	bool isa_irq;
 };
 
@@ -945,6 +946,46 @@ void ioapic_set_alloc_attr(struct irq_alloc_info *info, int node,
 	info->ioapic_valid = 1;
 }
 
+#ifndef CONFIG_ACPI
+int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
+#endif
+
+static void ioapic_copy_alloc_attr(struct irq_alloc_info *dst,
+				   struct irq_alloc_info *src,
+				   u32 gsi, int ioapic_idx, int pin)
+{
+	int trigger, polarity;
+
+	copy_irq_alloc_info(dst, src);
+	dst->type = X86_IRQ_ALLOC_TYPE_IOAPIC;
+	dst->ioapic_id = mpc_ioapic_id(ioapic_idx);
+	dst->ioapic_pin = pin;
+	dst->ioapic_valid = 1;
+	if (src && src->ioapic_valid) {
+		dst->ioapic_node = src->ioapic_node;
+		dst->ioapic_trigger = src->ioapic_trigger;
+		dst->ioapic_polarity = src->ioapic_polarity;
+	} else {
+		dst->ioapic_node = NUMA_NO_NODE;
+		if (acpi_get_override_irq(gsi, &trigger, &polarity) >= 0) {
+			dst->ioapic_trigger = trigger;
+			dst->ioapic_polarity = polarity;
+		} else {
+			/*
+			 * PCI interrupts are always polarity one level
+			 * triggered.
+			 */
+			dst->ioapic_trigger = 1;
+			dst->ioapic_polarity = 1;
+		}
+	}
+}
+
+static int ioapic_alloc_attr_node(struct irq_alloc_info *info)
+{
+	return (info && info->ioapic_valid) ? info->ioapic_node : NUMA_NO_NODE;
+}
+
 static void mp_register_handler(unsigned int irq, unsigned long trigger)
 {
 	irq_flow_handler_t hdl;
@@ -962,6 +1003,26 @@ static void mp_register_handler(unsigned int irq, unsigned long trigger)
 	__irq_set_handler(irq, hdl, 0, fasteoi ? "fasteoi" : "edge");
 }
 
+static bool mp_check_pin_attr(int irq, struct irq_alloc_info *info)
+{
+	struct mp_chip_data *data = irq_get_chip_data(irq);
+
+	/*
+	 * setup_IO_APIC_irqs() programs all legacy IRQs with default trigger
+	 * and polarity attirbutes. So allow the first user to reprogram the
+	 * pin with real trigger and polarity attributes.
+	 */
+	if (irq < nr_legacy_irqs() && data->count == 1) {
+		if (info->ioapic_trigger != data->trigger)
+			mp_register_handler(irq, data->trigger);
+		data->entry.trigger = data->trigger = info->ioapic_trigger;
+		data->entry.polarity = data->polarity = info->ioapic_polarity;
+	}
+
+	return data->trigger == info->ioapic_trigger &&
+	       data->polarity == info->ioapic_polarity;
+}
+
 static int alloc_irq_from_domain(struct irq_domain *domain, u32 gsi, int pin,
 				 struct irq_alloc_info *info)
 {
-- 
1.7.10.4

