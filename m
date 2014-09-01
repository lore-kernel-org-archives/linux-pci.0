Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux PM list <linux-pm@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Dmitry Torokhov <dtor@google.com>,
	Aubrey Li <aubrey.li@intel.com>
Subject: [PATCH 07/13] genirq: Distangle edge handler entry
Date: Mon, 01 Sep 2014 16:24:17 +0200
Message-ID: <2736441.mjEfdRQtUX@vostro.rjw.lan>
In-Reply-To: <2516134.pmOxkEuOOy@vostro.rjw.lan>
References: <26580319.OZP7jvJnA9@vostro.rjw.lan> <5320472.coYotHR1d0@vostro.rjw.lan> <2516134.pmOxkEuOOy@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

If the interrupt is disabled or has no action, then we should not call
the poll check. Separate the checks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/irq/chip.c |   39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

Index: linux/kernel/irq/chip.c
===================================================================
--- linux.orig/kernel/irq/chip.c
+++ linux/kernel/irq/chip.c
@@ -540,19 +540,29 @@ handle_edge_irq(unsigned int irq, struct
 	raw_spin_lock(&desc->lock);
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
+
 	/*
-	 * If we're currently running this IRQ, or its disabled,
-	 * we shouldn't process the IRQ. Mark it pending, handle
-	 * the necessary masking and go out
+	 * If the handler is currently running, mark it pending,
+	 * handle the necessary masking and go out
 	 */
-	if (unlikely(irqd_irq_disabled(&desc->irq_data) ||
-		     irqd_irq_inprogress(&desc->irq_data) || !desc->action)) {
+	if (unlikely(irqd_irq_inprogress(&desc->irq_data))) {
 		if (!irq_check_poll(desc)) {
 			desc->istate |= IRQS_PENDING;
 			mask_ack_irq(desc);
 			goto out_unlock;
 		}
 	}
+
+	/*
+	 * If its disabled or no action available then mask it and get
+	 * out of here.
+	 */
+	if (irqd_irq_disabled(&desc->irq_data) || !desc->action) {
+		desc->istate |= IRQS_PENDING;
+		mask_ack_irq(desc);
+		goto out_unlock;
+	}
+
 	kstat_incr_irqs_this_cpu(irq, desc);
 
 	/* Start handling the irq */
@@ -601,18 +611,27 @@ void handle_edge_eoi_irq(unsigned int ir
 	raw_spin_lock(&desc->lock);
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
+
 	/*
-	 * If we're currently running this IRQ, or its disabled,
-	 * we shouldn't process the IRQ. Mark it pending, handle
-	 * the necessary masking and go out
+	 * If the handler is currently running, mark it pending,
+	 * handle the necessary masking and go out
 	 */
-	if (unlikely(irqd_irq_disabled(&desc->irq_data) ||
-		     irqd_irq_inprogress(&desc->irq_data) || !desc->action)) {
+	if (unlikely(irqd_irq_inprogress(&desc->irq_data))) {
 		if (!irq_check_poll(desc)) {
 			desc->istate |= IRQS_PENDING;
 			goto out_eoi;
 		}
 	}
+
+	/*
+	 * If its disabled or no action available then mask it and get
+	 * out of here.
+	 */
+	if (irqd_irq_disabled(&desc->irq_data) || !desc->action) {
+		desc->istate |= IRQS_PENDING;
+		goto out_eoi;
+	}
+
 	kstat_incr_irqs_this_cpu(irq, desc);
 
 	do {

