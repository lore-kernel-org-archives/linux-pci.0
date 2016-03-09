Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56784 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbcCIAle (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Mar 2016 19:41:34 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org
Cc: linux-pci@vger.kernel.org, ravikanth.nalla@hpe.com,
	lenb@kernel.org, harish.k@hpe.com, ashwin.reghunandanan@hpe.com,
	bhelgaas@google.com, rjw@rjwysocki.net,
	Sinan Kaya <okaya@codeaurora.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Revert "Revert "ACPI, PCI, irq: remove interrupt count restriction""
Date: Tue,  8 Mar 2016 19:41:19 -0500
Message-Id: <1457484079-18202-4-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1457484079-18202-1-git-send-email-okaya@codeaurora.org>
References: <1457484079-18202-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Revert commit e249714571db (Revert "ACPI, PCI, irq: remove interrupt
count restriction") boot regression issue is resolved now.
Removed the conflicts as code is much simpler now.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 6bd77f1..d1c0532 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -4,6 +4,7 @@
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
  *  Copyright (C) 2002       Dominik Brodowski <devel@brodo.de>
+ *  Copyright (c) 2015, The Linux Foundation. All rights reserved.
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
@@ -439,7 +440,6 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
  * enabled system.
  */
 
-#define ACPI_MAX_IRQS		256
 #define ACPI_MAX_ISA_IRQ	16
 
 #define PIRQ_PENALTY_PCI_POSSIBLE	(16*16)
@@ -448,7 +448,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
 #define PIRQ_PENALTY_ISA_USED		(16*16*16*16*16)
 #define PIRQ_PENALTY_ISA_ALWAYS		(16*16*16*16*16*16)
 
-static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
+static int acpi_irq_isa_penalty[ACPI_MAX_ISA_IRQ] = {
 	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ0 timer */
 	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ1 keyboard */
 	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ2 cascade */
@@ -465,7 +465,6 @@ static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
 	PIRQ_PENALTY_ISA_USED,		/* IRQ13 fpe, sometimes */
 	PIRQ_PENALTY_ISA_USED,		/* IRQ14 ide0 */
 	PIRQ_PENALTY_ISA_USED,		/* IRQ15 ide1 */
-	/* >IRQ15 */
 };
 
 static int acpi_irq_pci_sharing_penalty(int irq)
@@ -502,7 +501,7 @@ static int acpi_irq_get_penalty(int irq)
 	int penalty = 0;
 
 	if (irq < ACPI_MAX_ISA_IRQ)
-		penalty += acpi_irq_penalty[irq];
+		penalty += acpi_irq_isa_penalty[irq];
 
 	if (irq == acpi_gbl_FADT.sci_interrupt)
 		penalty += PIRQ_PENALTY_PCI_USING;
@@ -556,12 +555,12 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
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
@@ -786,7 +785,7 @@ static void acpi_pci_link_remove(struct acpi_device *device)
 }
 
 /*
- * modify acpi_irq_penalty[] from cmdline
+ * modify acpi_irq_isa_penalty[] from cmdline
  */
 static int __init acpi_irq_penalty_update(char *str, int used)
 {
@@ -812,7 +811,7 @@ static int __init acpi_irq_penalty_update(char *str, int used)
 		else
 			new_penalty = 0;
 
-		acpi_irq_penalty[irq] = new_penalty;
+		acpi_irq_isa_penalty[irq] = new_penalty;
 		if (retval != 2)	/* no next number */
 			break;
 	}
@@ -828,15 +827,15 @@ static int __init acpi_irq_penalty_update(char *str, int used)
  */
 void acpi_penalize_isa_irq(int irq, int active)
 {
-	if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_irq_penalty)))
-		acpi_irq_penalty[irq] = active ?
+	if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_irq_isa_penalty)))
+		acpi_irq_isa_penalty[irq] = active ?
 			PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING;
 }
 
 bool acpi_isa_irq_available(int irq)
 {
-	return irq >= 0 && (irq >= ARRAY_SIZE(acpi_irq_penalty) ||
-			    acpi_irq_penalty[irq] < PIRQ_PENALTY_ISA_ALWAYS);
+	return irq >= 0 &&
+		(acpi_irq_get_penalty(irq) < PIRQ_PENALTY_ISA_ALWAYS);
 }
 
 /*
-- 
1.8.2.1

