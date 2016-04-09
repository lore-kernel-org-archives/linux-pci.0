Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org
Cc: linux-pci@vger.kernel.org, ravikanth.nalla@hpe.com,
	lenb@kernel.org, harish.k@hpe.com, ashwin.reghunandanan@hpe.com,
	bhelgaas@google.com, rjw@rjwysocki.net,
	Sinan Kaya <okaya@codeaurora.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/3] acpi,pci,irq: remove SCI penalize function
Date: Fri,  8 Apr 2016 21:26:32 -0400
Message-Id: <1460165192-4526-4-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1460165192-4526-1-git-send-email-okaya@codeaurora.org>
References: <1460165192-4526-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Removing the SCI penalize function as the penalty is now calculated on the
fly.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/x86/kernel/acpi/boot.c | 1 -
 drivers/acpi/pci_link.c     | 9 ---------
 include/linux/acpi.h        | 1 -
 3 files changed, 11 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index e759076..5e99f22 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -445,7 +445,6 @@ static void __init acpi_sci_ioapic_setup(u8 bus_irq, u16 polarity, u16 trigger,
 		polarity = acpi_sci_flags & ACPI_MADT_POLARITY_MASK;
 
 	mp_override_legacy_irq(bus_irq, polarity, trigger, gsi);
-	acpi_penalize_sci_irq(bus_irq, trigger, polarity);
 
 	/*
 	 * stash over-ride to indicate we've been here
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 63dae95..5b9a2d0 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -909,15 +909,6 @@ bool acpi_isa_irq_available(int irq)
 }
 
 /*
- * Penalize IRQ used by ACPI SCI. If ACPI SCI pin attributes conflict with
- * PCI IRQ attributes, mark ACPI SCI as ISA_ALWAYS so it won't be use for
- * PCI IRQs.
- */
-void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
-{
-}
-
-/*
  * Over-ride default table to reserve additional IRQs for use by ISA
  * e.g. acpi_irq_isa=5
  * Useful for telling ACPI how not to interfere with your ISA sound card.
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 06ed7e5..0f41317 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -311,7 +311,6 @@ struct pci_dev;
 int acpi_pci_irq_enable (struct pci_dev *dev);
 void acpi_penalize_isa_irq(int irq, int active);
 bool acpi_isa_irq_available(int irq);
-void acpi_penalize_sci_irq(int irq, int trigger, int polarity);
 void acpi_pci_irq_disable (struct pci_dev *dev);
 
 extern int ec_read(u8 addr, u8 *val);
-- 
1.8.2.1
