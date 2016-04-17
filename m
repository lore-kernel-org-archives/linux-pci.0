Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org
Cc: linux-pci@vger.kernel.org, ravikanth.nalla@hpe.com,
	lenb@kernel.org, harish.k@hpe.com, ashwin.reghunandanan@hpe.com,
	bhelgaas@google.com, rjw@rjwysocki.net,
	Sinan Kaya <okaya@codeaurora.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/4] acpi,pci,irq: reduce static IRQ array size to 16
Date: Sun, 17 Apr 2016 13:36:54 -0400
Message-Id: <1460914617-8259-2-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1460914617-8259-1-git-send-email-okaya@codeaurora.org>
References: <1460914617-8259-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that the supported number of PCI IRQs are no longer capped
with 256, renaming the static array to support ISA IRQs only
and removing the MAX_IRQS constant.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index cc0ba16..12ea784 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -438,8 +438,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
  * enabled system.
  */
 
-#define ACPI_MAX_IRQS		256
-#define ACPI_MAX_ISA_IRQ	16
+#define ACPI_MAX_ISA_IRQS	16
 
 #define PIRQ_PENALTY_PCI_POSSIBLE	(16*16)
 #define PIRQ_PENALTY_PCI_USING		(16*16*16)
@@ -447,7 +446,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
 #define PIRQ_PENALTY_ISA_USED		(16*16*16*16*16)
 #define PIRQ_PENALTY_ISA_ALWAYS		(16*16*16*16*16*16)
 
-static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
+static int acpi_isa_irq_penalty[ACPI_MAX_ISA_IRQS] = {
 	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ0 timer */
 	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ1 keyboard */
 	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ2 cascade */
@@ -500,8 +499,8 @@ static int acpi_irq_get_penalty(int irq)
 {
 	int penalty = 0;
 
-	if (irq < ACPI_MAX_ISA_IRQ)
-		penalty += acpi_irq_penalty[irq];
+	if (irq < ACPI_MAX_ISA_IRQS)
+		penalty += acpi_isa_irq_penalty[irq];
 
 	/*
 	* Penalize IRQ used by ACPI SCI. If ACPI SCI pin attributes conflict
@@ -541,14 +540,15 @@ int __init acpi_irq_penalty_init(void)
 			    link->irq.possible_count;
 
 			for (i = 0; i < link->irq.possible_count; i++) {
-				if (link->irq.possible[i] < ACPI_MAX_ISA_IRQ)
-					acpi_irq_penalty[link->irq.
+				if (link->irq.possible[i] < ACPI_MAX_ISA_IRQS)
+					acpi_isa_irq_penalty[link->irq.
 							 possible[i]] +=
 					    penalty;
 			}
 
-		} else if (link->irq.active) {
-			acpi_irq_penalty[link->irq.active] +=
+		} else if (link->irq.active &&
+				(link->irq.active < ACPI_MAX_ISA_IRQS)) {
+			acpi_isa_irq_penalty[link->irq.active] +=
 			    PIRQ_PENALTY_PCI_POSSIBLE;
 		}
 	}
@@ -831,7 +831,7 @@ static void acpi_pci_link_remove(struct acpi_device *device)
 }
 
 /*
- * modify acpi_irq_penalty[] from cmdline
+ * modify acpi_isa_irq_penalty[] from cmdline
  */
 static int __init acpi_irq_penalty_update(char *str, int used)
 {
@@ -840,24 +840,24 @@ static int __init acpi_irq_penalty_update(char *str, int used)
 	for (i = 0; i < 16; i++) {
 		int retval;
 		int irq;
+		int new_penalty;
 
 		retval = get_option(&str, &irq);
 
 		if (!retval)
 			break;	/* no number found */
 
-		if (irq < 0)
-			continue;
-
-		if (irq >= ARRAY_SIZE(acpi_irq_penalty))
+		/* see if this is a ISA IRQ */
+		if ((irq < 0) || (irq >= ACPI_MAX_ISA_IRQS))
 			continue;
 
 		if (used)
-			acpi_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
-				PIRQ_PENALTY_ISA_USED;
+			new_penalty = acpi_irq_get_penalty(irq) +
+					PIRQ_PENALTY_ISA_USED;
 		else
-			acpi_irq_penalty[irq] = 0;
+			new_penalty = 0;
 
+		acpi_isa_irq_penalty[irq] = new_penalty;
 		if (retval != 2)	/* no next number */
 			break;
 	}
@@ -873,14 +873,14 @@ static int __init acpi_irq_penalty_update(char *str, int used)
  */
 void acpi_penalize_isa_irq(int irq, int active)
 {
-	if (irq >= 0 && irq < ARRAY_SIZE(acpi_irq_penalty))
-		acpi_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
+	if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
+		acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
 			active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING;
 }
 
 bool acpi_isa_irq_available(int irq)
 {
-	return irq >= 0 && (irq >= ARRAY_SIZE(acpi_irq_penalty) ||
+	return irq >= 0 && (irq >= ARRAY_SIZE(acpi_isa_irq_penalty) ||
 		    acpi_irq_get_penalty(irq) < PIRQ_PENALTY_ISA_ALWAYS);
 }
 
-- 
1.8.2.1
