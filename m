Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link
 [LNKD]. Try pci=noacpi or acpi=off
To: Ondrej Zary <linux@rainbow-software.org>
References: <201609251512.05657.linux@rainbow-software.org>
 <201609291848.33803.linux@rainbow-software.org>
 <701eeb2f-bfc2-d541-4f6f-34be200ea44a@codeaurora.org>
 <201609292000.56943.linux@rainbow-software.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        wim@djo.tudelft.nl, ravikanth.nalla@hpe.com
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <34355440-197d-44c7-b27d-535267d1161c@codeaurora.org>
Date: Thu, 29 Sep 2016 18:39:48 -0400
MIME-Version: 1.0
In-Reply-To: <201609292000.56943.linux@rainbow-software.org>
Content-Type: multipart/mixed;
 boundary="------------C3BABA23093CDA0C21B59E8F"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------C3BABA23093CDA0C21B59E8F
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

On 9/29/2016 2:00 PM, Ondrej Zary wrote:
>> The previous two patches were in the right direction.
>> >
>> > Can we also get the same output from 4.6 kernel with the attached patch for
>> > the same machine you sent these?
> Here it is.
> 
>> > Something about SCI still doesn't feel right.
>> >
>> > The IRQ assignment fails if the penalty is greater than
>> > PIRQ_PENALTY_ISA_ALWAYS. This will happen if BIOS tells us to use an IRQ
>> > and same IRQ is in use by the SCI.

Thanks, I reverted penalize_sci function and dropped patch #1. Can you try this again?


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

--------------C3BABA23093CDA0C21B59E8F
Content-Type: text/plain; charset=UTF-8;
 name="0001-ACPI-PCI-IRQ-add-PCI_USING-penalty-for-ISA-interrupt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ACPI-PCI-IRQ-add-PCI_USING-penalty-for-ISA-interrupt.pa";
 filename*1="tch"

>From 7597c656222b27f4cc55c16bab980ed28ef22bbd Mon Sep 17 00:00:00 2001
From: Sinan Kaya <okaya@codeaurora.org>
Date: Thu, 29 Sep 2016 10:25:21 -0400
Subject: [PATCH 1/2] ACPI, PCI IRQ: add PCI_USING penalty for ISA interrupts

The change introduced in commit 103544d86976 ("ACPI,PCI,IRQ: reduce
resource requirements") removed PCI_USING penalty from
acpi_pci_link_allocate function as there is no longer a fixed size penalty
array for both PCI and IRQ interrupts.

We need to add the PCI_USING penalty for ISA interrupts too if the link is
in use and matches our ISA IRQ number.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index c983bf7..a212709 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -619,6 +619,10 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 			    acpi_device_bid(link->device));
 		return -ENODEV;
 	} else {
+		if (link->irq.active < ACPI_MAX_ISA_IRQS)
+			acpi_isa_irq_penalty[link->irq.active] +=
+				PIRQ_PENALTY_PCI_USING;
+
 		printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
 		       acpi_device_name(link->device),
 		       acpi_device_bid(link->device), link->irq.active);
-- 
1.9.1


--------------C3BABA23093CDA0C21B59E8F
Content-Type: text/plain; charset=UTF-8;
 name="0002-Revert-ACPI-PCI-IRQ-remove-SCI-penalize-function.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-Revert-ACPI-PCI-IRQ-remove-SCI-penalize-function.patch"

>From 1835481ebcc5bb649dcc22a2d473fd3b203bf01d Mon Sep 17 00:00:00 2001
From: Sinan Kaya <okaya@codeaurora.org>
Date: Thu, 29 Sep 2016 15:36:15 -0400
Subject: [PATCH 2/2] Revert "ACPI,PCI,IRQ: remove SCI penalize function"

This reverts commit 9e5ed6d1fb87 ("ACPI,PCI,IRQ: remove SCI penalize
function"). SCI penalty API was replaced by the runtime penalty calculation
based on the value of acpi_gbl_FADT.sci_interrupt.

acpi_gbl_FADT.sci_interrupt type does not get updated at the right time
for some platforms and results in incorrect penalty assignment for PCI
IRQs as irq_get_trigger_type returns the wrong type.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/x86/kernel/acpi/boot.c |  1 +
 drivers/acpi/pci_link.c     | 32 +++++++++++++-------------------
 include/linux/acpi.h        |  1 +
 3 files changed, 15 insertions(+), 19 deletions(-)

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
index a212709..1934e2a 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -494,27 +494,10 @@ static int acpi_irq_pci_sharing_penalty(int irq)
 
 static int acpi_irq_get_penalty(int irq)
 {
-	int penalty = 0;
-
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
-
 	if (irq < ACPI_MAX_ISA_IRQS)
-		return penalty + acpi_isa_irq_penalty[irq];
+		return acpi_isa_irq_penalty[irq];
 
-	penalty += acpi_irq_pci_sharing_penalty(irq);
-	return penalty;
+	return acpi_irq_pci_sharing_penalty(irq);
 }
 
 int __init acpi_irq_penalty_init(void)
@@ -885,6 +868,17 @@ bool acpi_isa_irq_available(int irq)
 		    acpi_irq_get_penalty(irq) < PIRQ_PENALTY_ISA_ALWAYS);
 }
 
+void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
+{
+	if (irq >= 0 && irq < ARRAY_SIZE(acpi_isa_irq_penalty)) {
+		if (trigger != ACPI_MADT_TRIGGER_LEVEL ||
+		    polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
+			acpi_isa_irq_penalty[irq] += PIRQ_PENALTY_ISA_ALWAYS;
+		else
+			acpi_isa_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
+	}
+}
+
 /*
  * Over-ride default table to reserve additional IRQs for use by ISA
  * e.g. acpi_irq_isa=5
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4d8452c..85ac7d5 100644
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


--------------C3BABA23093CDA0C21B59E8F--
