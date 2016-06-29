Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com,
	eric.auger@redhat.com
Cc: linux-pci@vger.kernel.org, agross@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, wim@djo.tudelft.nl,
	perex@perex.cz, tiwai@suse.com, Sinan Kaya <okaya@codeaurora.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/4] ACPI,PCI,IRQ: separate ISA penalty calculation
Date: Wed, 29 Jun 2016 04:27:37 -0400
Message-Id: <1467188859-28188-4-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1467188859-28188-1-git-send-email-okaya@codeaurora.org>
References: <1467188859-28188-1-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since commit 103544d86976 ("ACPI,PCI,IRQ: reduce resource requirements")
the penalty values are calculated on the fly rather than boot time.

This works fine for PCI interrupts but not so well for the ISA interrupts.
Whether an ISA interrupt is in use or not information is not available
inside the pci_link.c file. This information gets sent externally via
acpi_penalize_isa_irq function. If active is true, then the IRQ is in use
by ISA. Otherwise, IRQ is in use by PCI.

Since the current code relies on PCI Link object for determination of
penalties, we are factoring in the PCI penalty twice after
acpi_penalize_isa_irq function is called.

This change is limiting the newly added functionality to just PCI
interrupts so that old behavior is still maintained.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 714ba4d..8c08971 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -496,9 +496,6 @@ static int acpi_irq_get_penalty(int irq)
 {
 	int penalty = 0;
 
-	if (irq < ACPI_MAX_ISA_IRQS)
-		penalty += acpi_isa_irq_penalty[irq];
-
 	/*
 	* Penalize IRQ used by ACPI SCI. If ACPI SCI pin attributes conflict
 	* with PCI IRQ attributes, mark ACPI SCI as ISA_ALWAYS so it won't be
@@ -513,6 +510,9 @@ static int acpi_irq_get_penalty(int irq)
 			penalty += PIRQ_PENALTY_PCI_USING;
 	}
 
+	if (irq < ACPI_MAX_ISA_IRQS)
+		return penalty + acpi_isa_irq_penalty[irq];
+
 	penalty += acpi_irq_pci_sharing_penalty(irq);
 	return penalty;
 }
-- 
1.8.2.1

