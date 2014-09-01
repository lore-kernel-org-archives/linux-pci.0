Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux PM list <linux-pm@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Dmitry Torokhov <dtor@google.com>,
	Aubrey Li <aubrey.li@intel.com>
Subject: [PATCH 11/13] x86 / PM: Set IRQCHIP_SKIP_SET_WAKE for IOAPIC IRQ chip objects
Date: Mon, 01 Sep 2014 16:28:01 +0200
Message-ID: <1604186.gKriExSOTM@vostro.rjw.lan>
In-Reply-To: <2516134.pmOxkEuOOy@vostro.rjw.lan>
References: <26580319.OZP7jvJnA9@vostro.rjw.lan> <5320472.coYotHR1d0@vostro.rjw.lan> <2516134.pmOxkEuOOy@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Set the IRQCHIP_SKIP_SET_WAKE for IOAPIC IRQ chip objects so that
interrupts from them can work as wakeup interrupts for suspend-to-idle.

After this change, running enable_irq_wake() on one of the IRQs in
question will succeed and IRQD_WAKEUP_STATE will be set for it, so
all of the suspend-to-idle wakeup mechanics introduced previously
will work for it automatically.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/apic/io_apic.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-pm/arch/x86/kernel/apic/io_apic.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/apic/io_apic.c
+++ linux-pm/arch/x86/kernel/apic/io_apic.c
@@ -2618,6 +2618,7 @@ static struct irq_chip ioapic_chip __rea
 	.irq_eoi		= ack_apic_level,
 	.irq_set_affinity	= native_ioapic_set_affinity,
 	.irq_retrigger		= ioapic_retrigger_irq,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
 static inline void init_IO_APIC_traps(void)
@@ -3168,6 +3169,7 @@ static struct irq_chip msi_chip = {
 	.irq_ack		= ack_apic_edge,
 	.irq_set_affinity	= msi_set_affinity,
 	.irq_retrigger		= ioapic_retrigger_irq,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
 int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc,
@@ -3266,6 +3268,7 @@ static struct irq_chip dmar_msi_type = {
 	.irq_ack		= ack_apic_edge,
 	.irq_set_affinity	= dmar_msi_set_affinity,
 	.irq_retrigger		= ioapic_retrigger_irq,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
 int arch_setup_dmar_msi(unsigned int irq)
@@ -3316,6 +3319,7 @@ static struct irq_chip hpet_msi_type = {
 	.irq_ack = ack_apic_edge,
 	.irq_set_affinity = hpet_msi_set_affinity,
 	.irq_retrigger = ioapic_retrigger_irq,
+	.flags = IRQCHIP_SKIP_SET_WAKE,
 };
 
 int default_setup_hpet_msi(unsigned int irq, unsigned int id)
@@ -3379,6 +3383,7 @@ static struct irq_chip ht_irq_chip = {
 	.irq_ack		= ack_apic_edge,
 	.irq_set_affinity	= ht_set_affinity,
 	.irq_retrigger		= ioapic_retrigger_irq,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
 int arch_setup_ht_irq(unsigned int irq, struct pci_dev *dev)

