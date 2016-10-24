Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        ravikanth.nalla@hpe.com, linux@rainbow-software.org,
        timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
        alex.williamson@redhat.com
Cc: net147@gmail.com, linux-pci@vger.kernel.org, agross@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wim@djo.tudelft.nl,
        Sinan Kaya <okaya@codeaurora.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 2/3] ACPI: pci_link: penalize SCI correctly
Date: Mon, 24 Oct 2016 00:31:31 -0400
Message-Id: <1477283492-26657-3-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1477283492-26657-1-git-send-email-okaya@codeaurora.org>
References: <1477283492-26657-1-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Ondrej reported that IRQs stopped working in v4.7 on several
platforms.  A typical scenario, from Ondrej's VT82C694X/694X, is:

ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: No IRQ available for PCI Interrupt Link [LNKA]
8139too 0000:00:0f.0: PCI INT A: no GSI

We're using PIC routing, so acpi_irq_balance == 0, and LNKA is already
active at IRQ 11. In that case, acpi_pci_link_allocate() only tries
to use the active IRQ (IRQ 11) which also happens to be the SCI.

We should penalize the SCI by PIRQ_PENALTY_PCI_USING, but
irq_get_trigger_type(11) returns something other than
IRQ_TYPE_LEVEL_LOW, so we penalize it by PIRQ_PENALTY_ISA_ALWAYS
instead, which makes acpi_pci_link_allocate() assume the IRQ isn't
available and give up.

Add acpi_penalize_sci_irq() so platforms can tell us the SCI IRQ,
trigger, and polarity directly and we don't have to depend on
irq_get_trigger_type().

Link: http://lkml.kernel.org/r/201609251512.05657.linux@rainbow-software.org
Reported-by: Ondrej Zary <linux@rainbow-software.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/x86/kernel/acpi/boot.c |  1 +
 drivers/acpi/pci_link.c     | 30 +++++++++++++++---------------
 include/linux/acpi.h        |  1 +
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 90d84c3..0ffd26e 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -453,6 +453,7 @@ static void __init acpi_sci_ioapic_setup(u8 bus_irq, u16 polarity, u16 trigger,
 		polarity = acpi_sci_flags & ACPI_MADT_POLARITY_MASK;
 
 	mp_override_legacy_irq(bus_irq, polarity, trigger, gsi);
+	acpi_penalize_sci_irq(bus_irq, trigger, polarity);
 
 	/*
 	 * stash over-ride to indicate we've been here
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 6229b02..74bf96e 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -87,6 +87,7 @@ struct acpi_pci_link {
 
 static LIST_HEAD(acpi_link_list);
 static DEFINE_MUTEX(acpi_link_lock);
+static int sci_irq = -1, sci_penalty;
 
 /* --------------------------------------------------------------------------
                             PCI Link Device Management
@@ -496,25 +497,13 @@ static int acpi_irq_get_penalty(int irq)
 {
 	int penalty = 0;
 
-	/*
-	* Penalize IRQ used by ACPI SCI. If ACPI SCI pin attributes conflict
-	* with PCI IRQ attributes, mark ACPI SCI as ISA_ALWAYS so it won't be
-	* use for PCI IRQs.
-	*/
-	if (irq == acpi_gbl_FADT.sci_interrupt) {
-		u32 type = irq_get_trigger_type(irq) & IRQ_TYPE_SENSE_MASK;
-
-		if (type != IRQ_TYPE_LEVEL_LOW)
-			penalty += PIRQ_PENALTY_ISA_ALWAYS;
-		else
-			penalty += PIRQ_PENALTY_PCI_USING;
-	}
+	if (irq == sci_irq)
+		penalty += sci_penalty;
 
 	if (irq < ACPI_MAX_ISA_IRQS)
 		return penalty + acpi_isa_irq_penalty[irq];
 
-	penalty += acpi_irq_pci_sharing_penalty(irq);
-	return penalty;
+	return penalty + acpi_irq_pci_sharing_penalty(irq);
 }
 
 int __init acpi_irq_penalty_init(void)
@@ -881,6 +870,17 @@ bool acpi_isa_irq_available(int irq)
 		    acpi_irq_get_penalty(irq) < PIRQ_PENALTY_ISA_ALWAYS);
 }
 
+void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
+{
+	sci_irq = irq;
+
+	if (trigger == ACPI_MADT_TRIGGER_LEVEL &&
+	    polarity == ACPI_MADT_POLARITY_ACTIVE_LOW)
+		sci_penalty = PIRQ_PENALTY_PCI_USING;
+	else
+		sci_penalty = PIRQ_PENALTY_ISA_ALWAYS;
+}
+
 /*
  * Over-ride default table to reserve additional IRQs for use by ISA
  * e.g. acpi_irq_isa=5
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index c5eaf2f..67d1d3e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -318,6 +318,7 @@ struct pci_dev;
 int acpi_pci_irq_enable (struct pci_dev *dev);
 void acpi_penalize_isa_irq(int irq, int active);
 bool acpi_isa_irq_available(int irq);
+void acpi_penalize_sci_irq(int irq, int trigger, int polarity);
 void acpi_pci_irq_disable (struct pci_dev *dev);
 
 extern int ec_read(u8 addr, u8 *val);
-- 
1.9.1

