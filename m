Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50045 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751137AbcJXEbn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2016 00:31:43 -0400
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        ravikanth.nalla@hpe.com, linux@rainbow-software.org,
        timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
        alex.williamson@redhat.com
Cc: net147@gmail.com, linux-pci@vger.kernel.org, agross@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wim@djo.tudelft.nl,
        Sinan Kaya <okaya@codeaurora.org>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 1/3] ACPI, PCI, IRQ: assign ISA IRQ directly during early boot stages
Date: Mon, 24 Oct 2016 00:31:30 -0400
Message-Id: <1477283492-26657-2-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1477283492-26657-1-git-send-email-okaya@codeaurora.org>
References: <1477283492-26657-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We do not want to store the SCI penalty in the acpi_isa_irq_penalty[]
table because acpi_isa_irq_penalty[] only holds ISA IRQ penalties and
there's no guarantee that the SCI is an ISA IRQ.  We add in the SCI
penalty as a special case in acpi_irq_get_penalty().

But if we called acpi_penalize_isa_irq() or acpi_irq_penalty_update()
for an SCI that happened to be an ISA IRQ, they stored the SCI
penalty (part of the acpi_irq_get_penalty() return value) in
acpi_isa_irq_penalty[].  Subsequent calls to acpi_irq_get_penalty()
returned a penalty that included *two* SCI penalties.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index c983bf7..6229b02 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -849,7 +849,7 @@ static int __init acpi_irq_penalty_update(char *str, int used)
 			continue;
 
 		if (used)
-			new_penalty = acpi_irq_get_penalty(irq) +
+			new_penalty = acpi_isa_irq_penalty[irq] +
 					PIRQ_PENALTY_ISA_USED;
 		else
 			new_penalty = 0;
@@ -871,7 +871,7 @@ static int __init acpi_irq_penalty_update(char *str, int used)
 void acpi_penalize_isa_irq(int irq, int active)
 {
 	if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
-		acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
+		acpi_isa_irq_penalty[irq] +=
 		  (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
 }
 
-- 
1.9.1

