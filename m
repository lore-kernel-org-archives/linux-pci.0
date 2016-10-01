Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        ravikanth.nalla@hpe.com, linux@rainbow-software.org,
        timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
        alex.williamson@redhat.com
Cc: linux-pci@vger.kernel.org, agross@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wim@djo.tudelft.nl,
        Sinan Kaya <okaya@codeaurora.org>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Revert "ACPI,PCI,IRQ: reduce static IRQ array size to 16"
Date: Sat,  1 Oct 2016 13:46:14 -0400
Message-Id: <1475343976-20744-1-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This reverts commit 5c5087a55390 ("ACPI,PCI,IRQ: reduce static IRQ array
size to 16").

The code maintains a fixed size array for IRQ penalties. The array
gets updated by external calls such as acpi_penalize_sci_irq,
acpi_penalize_isa_irq to reflect the actual interrupt usage of the
system. Since the IRQ distribution is platform specific, this is
not known ahead of time. The IRQs get updated based on the SCI
interrupt number BIOS has chosen or the ISA IRQs that were assigned
to existing peripherals.

By the time ACPI gets initialized, this code tries to determine an
IRQ number based on penalty values in this array. It will try to locate
the IRQ with the least penalty assignment so that interrupt sharing is
avoided if possible.

A couple of notes about the external APIs:
1. These API can be called before the ACPI is started. Therefore, one
cannot assume that the PCI link objects are initialized for calculating
penalties.
2. The polarity and trigger information passed via the
acpi_penalize_sci_irq from the BIOS may not match what the IRQ subsystem
is reporting as the call might have been placed before the IRQ is
registered by the interrupt subsystem.

The previous change was in the direction to remove these external API and
try to calculate the penalties at runtime for the ISA path as well. This
didn't work out well with the existing platforms.

Restoring the old behavior for IRQ < 256 and the new behavior will remain
effective for IRQ >= 256.

Link: http://www.spinics.net/lists/linux-pci/msg54599.html
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index c983bf7..f3792f4 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -438,6 +438,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
  * enabled system.
  */
 
+#define ACPI_MAX_IRQS		256
 #define ACPI_MAX_ISA_IRQS	16
 
 #define PIRQ_PENALTY_PCI_POSSIBLE	(16*16)
@@ -446,7 +447,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
 #define PIRQ_PENALTY_ISA_USED		(16*16*16*16*16)
 #define PIRQ_PENALTY_ISA_ALWAYS		(16*16*16*16*16*16)
 
-static int acpi_isa_irq_penalty[ACPI_MAX_ISA_IRQS] = {
+static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
 	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ0 timer */
 	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ1 keyboard */
 	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ2 cascade */
@@ -511,7 +512,7 @@ static int acpi_irq_get_penalty(int irq)
 	}
 
 	if (irq < ACPI_MAX_ISA_IRQS)
-		return penalty + acpi_isa_irq_penalty[irq];
+		return penalty + acpi_irq_penalty[irq];
 
 	penalty += acpi_irq_pci_sharing_penalty(irq);
 	return penalty;
@@ -538,14 +539,14 @@ int __init acpi_irq_penalty_init(void)
 
 			for (i = 0; i < link->irq.possible_count; i++) {
 				if (link->irq.possible[i] < ACPI_MAX_ISA_IRQS)
-					acpi_isa_irq_penalty[link->irq.
+					acpi_irq_penalty[link->irq.
 							 possible[i]] +=
 					    penalty;
 			}
 
 		} else if (link->irq.active &&
-				(link->irq.active < ACPI_MAX_ISA_IRQS)) {
-			acpi_isa_irq_penalty[link->irq.active] +=
+				(link->irq.active < ACPI_MAX_IRQS)) {
+			acpi_irq_penalty[link->irq.active] +=
 			    PIRQ_PENALTY_PCI_POSSIBLE;
 		}
 	}
@@ -828,7 +829,7 @@ static void acpi_pci_link_remove(struct acpi_device *device)
 }
 
 /*
- * modify acpi_isa_irq_penalty[] from cmdline
+ * modify acpi_irq_penalty[] from cmdline
  */
 static int __init acpi_irq_penalty_update(char *str, int used)
 {
@@ -837,24 +838,24 @@ static int __init acpi_irq_penalty_update(char *str, int used)
 	for (i = 0; i < 16; i++) {
 		int retval;
 		int irq;
-		int new_penalty;
 
 		retval = get_option(&str, &irq);
 
 		if (!retval)
 			break;	/* no number found */
 
-		/* see if this is a ISA IRQ */
-		if ((irq < 0) || (irq >= ACPI_MAX_ISA_IRQS))
+		if (irq < 0)
+			continue;
+
+		if (irq >= ARRAY_SIZE(acpi_irq_penalty))
 			continue;
 
 		if (used)
-			new_penalty = acpi_irq_get_penalty(irq) +
-					PIRQ_PENALTY_ISA_USED;
+			acpi_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
+				PIRQ_PENALTY_ISA_USED;
 		else
-			new_penalty = 0;
+			acpi_irq_penalty[irq] = 0;
 
-		acpi_isa_irq_penalty[irq] = new_penalty;
 		if (retval != 2)	/* no next number */
 			break;
 	}
@@ -870,14 +871,14 @@ static int __init acpi_irq_penalty_update(char *str, int used)
  */
 void acpi_penalize_isa_irq(int irq, int active)
 {
-	if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
-		acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
-		  (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
+	if (irq >= 0 && irq < ARRAY_SIZE(acpi_irq_penalty))
+		acpi_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
+		    (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
 }
 
 bool acpi_isa_irq_available(int irq)
 {
-	return irq >= 0 && (irq >= ARRAY_SIZE(acpi_isa_irq_penalty) ||
+	return irq >= 0 && (irq >= ARRAY_SIZE(acpi_irq_penalty) ||
 		    acpi_irq_get_penalty(irq) < PIRQ_PENALTY_ISA_ALWAYS);
 }
 
-- 
1.9.1

