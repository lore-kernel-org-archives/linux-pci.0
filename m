Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60624 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbcDQRhS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 17 Apr 2016 13:37:18 -0400
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org
Cc: linux-pci@vger.kernel.org, ravikanth.nalla@hpe.com,
	lenb@kernel.org, harish.k@hpe.com, ashwin.reghunandanan@hpe.com,
	bhelgaas@google.com, rjw@rjwysocki.net,
	Sinan Kaya <okaya@codeaurora.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/4] acpi,pci,irq: reduce resource requirements
Date: Sun, 17 Apr 2016 13:36:53 -0400
Message-Id: <1460914617-8259-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Code has been redesigned to calculate penalty requirements on the fly. This
significantly simplifies the implementation and removes some of the init
calls from x86 architecture.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 97 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 68 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index ededa90..cc0ba16 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -36,6 +36,7 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/irq.h>
 
 #include "internal.h"
 
@@ -440,7 +441,6 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
 #define ACPI_MAX_IRQS		256
 #define ACPI_MAX_ISA_IRQ	16
 
-#define PIRQ_PENALTY_PCI_AVAILABLE	(0)
 #define PIRQ_PENALTY_PCI_POSSIBLE	(16*16)
 #define PIRQ_PENALTY_PCI_USING		(16*16*16)
 #define PIRQ_PENALTY_ISA_TYPICAL	(16*16*16*16)
@@ -457,9 +457,9 @@ static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
 	PIRQ_PENALTY_ISA_TYPICAL,	/* IRQ6 */
 	PIRQ_PENALTY_ISA_TYPICAL,	/* IRQ7 parallel, spurious */
 	PIRQ_PENALTY_ISA_TYPICAL,	/* IRQ8 rtc, sometimes */
-	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ9  PCI, often acpi */
-	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ10 PCI */
-	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ11 PCI */
+	0,				/* IRQ9  PCI, often acpi */
+	0,				/* IRQ10 PCI */
+	0,				/* IRQ11 PCI */
 	PIRQ_PENALTY_ISA_USED,		/* IRQ12 mouse */
 	PIRQ_PENALTY_ISA_USED,		/* IRQ13 fpe, sometimes */
 	PIRQ_PENALTY_ISA_USED,		/* IRQ14 ide0 */
@@ -467,6 +467,60 @@ static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
 	/* >IRQ15 */
 };
 
+static int acpi_irq_pci_sharing_penalty(int irq)
+{
+	struct acpi_pci_link *link;
+	int penalty = 0;
+
+	list_for_each_entry(link, &acpi_link_list, list) {
+		/*
+		 * If a link is active, penalize its IRQ heavily
+		 * so we try to choose a different IRQ.
+		 */
+		if (link->irq.active && link->irq.active == irq)
+			penalty += PIRQ_PENALTY_PCI_USING;
+		else {
+			int i;
+
+			/*
+			 * If a link is inactive, penalize the IRQs it
+			 * might use, but not as severely.
+			 */
+			for (i = 0; i < link->irq.possible_count; i++)
+				if (link->irq.possible[i] == irq)
+					penalty += PIRQ_PENALTY_PCI_POSSIBLE /
+						link->irq.possible_count;
+		}
+	}
+
+	return penalty;
+}
+
+static int acpi_irq_get_penalty(int irq)
+{
+	int penalty = 0;
+
+	if (irq < ACPI_MAX_ISA_IRQ)
+		penalty += acpi_irq_penalty[irq];
+
+	/*
+	* Penalize IRQ used by ACPI SCI. If ACPI SCI pin attributes conflict
+	* with PCI IRQ attributes, mark ACPI SCI as ISA_ALWAYS so it won't be
+	* use for PCI IRQs.
+	*/
+	if (irq == acpi_gbl_FADT.sci_interrupt) {
+		u32 type = irq_get_trigger_type(irq) & IRQ_TYPE_SENSE_MASK;
+
+		if (type != IRQ_TYPE_LEVEL_LOW)
+			penalty += PIRQ_PENALTY_ISA_ALWAYS;
+		else
+			penalty += PIRQ_PENALTY_PCI_USING;
+	}
+
+	penalty += acpi_irq_pci_sharing_penalty(irq);
+	return penalty;
+}
+
 int __init acpi_irq_penalty_init(void)
 {
 	struct acpi_pci_link *link;
@@ -547,12 +601,12 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 		 * the use of IRQs 9, 10, 11, and >15.
 		 */
 		for (i = (link->irq.possible_count - 1); i >= 0; i--) {
-			if (acpi_irq_penalty[irq] >
-			    acpi_irq_penalty[link->irq.possible[i]])
+			if (acpi_irq_get_penalty(irq) >
+			    acpi_irq_get_penalty(link->irq.possible[i]))
 				irq = link->irq.possible[i];
 		}
 	}
-	if (acpi_irq_penalty[irq] >= PIRQ_PENALTY_ISA_ALWAYS) {
+	if (acpi_irq_get_penalty(irq) >= PIRQ_PENALTY_ISA_ALWAYS) {
 		printk(KERN_ERR PREFIX "No IRQ available for %s [%s]. "
 			    "Try pci=noacpi or acpi=off\n",
 			    acpi_device_name(link->device),
@@ -568,7 +622,6 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 			    acpi_device_bid(link->device));
 		return -ENODEV;
 	} else {
-		acpi_irq_penalty[link->irq.active] += PIRQ_PENALTY_PCI_USING;
 		printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
 		       acpi_device_name(link->device),
 		       acpi_device_bid(link->device), link->irq.active);
@@ -800,9 +853,10 @@ static int __init acpi_irq_penalty_update(char *str, int used)
 			continue;
 
 		if (used)
-			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_USED;
+			acpi_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
+				PIRQ_PENALTY_ISA_USED;
 		else
-			acpi_irq_penalty[irq] = PIRQ_PENALTY_PCI_AVAILABLE;
+			acpi_irq_penalty[irq] = 0;
 
 		if (retval != 2)	/* no next number */
 			break;
@@ -819,34 +873,19 @@ static int __init acpi_irq_penalty_update(char *str, int used)
  */
 void acpi_penalize_isa_irq(int irq, int active)
 {
-	if (irq >= 0 && irq < ARRAY_SIZE(acpi_irq_penalty)) {
-		if (active)
-			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_USED;
-		else
-			acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
-	}
+	if (irq >= 0 && irq < ARRAY_SIZE(acpi_irq_penalty))
+		acpi_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
+			active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING;
 }
 
 bool acpi_isa_irq_available(int irq)
 {
 	return irq >= 0 && (irq >= ARRAY_SIZE(acpi_irq_penalty) ||
-			    acpi_irq_penalty[irq] < PIRQ_PENALTY_ISA_ALWAYS);
+		    acpi_irq_get_penalty(irq) < PIRQ_PENALTY_ISA_ALWAYS);
 }
 
-/*
- * Penalize IRQ used by ACPI SCI. If ACPI SCI pin attributes conflict with
- * PCI IRQ attributes, mark ACPI SCI as ISA_ALWAYS so it won't be use for
- * PCI IRQs.
- */
 void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
 {
-	if (irq >= 0 && irq < ARRAY_SIZE(acpi_irq_penalty)) {
-		if (trigger != ACPI_MADT_TRIGGER_LEVEL ||
-		    polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
-			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_ALWAYS;
-		else
-			acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
-	}
 }
 
 /*
-- 
1.8.2.1

