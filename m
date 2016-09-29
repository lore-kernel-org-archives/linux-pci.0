Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link
 [LNKD]. Try pci=noacpi or acpi=off
To: Ondrej Zary <linux@rainbow-software.org>
References: <201609251512.05657.linux@rainbow-software.org>
 <201609291110.50176.linux@rainbow-software.org>
 <131b4220b509ed95dfbb35a441ccbc2c@codeaurora.org>
 <201609291549.07784.linux@rainbow-software.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        wim@djo.tudelft.nl, ravikanth.nalla@hpe.com
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <e90fb01a-77e3-a094-9631-0b703972c750@codeaurora.org>
Date: Thu, 29 Sep 2016 10:28:23 -0400
MIME-Version: 1.0
In-Reply-To: <201609291549.07784.linux@rainbow-software.org>
Content-Type: multipart/mixed;
 boundary="------------01D33A00B13E2A599EE430F3"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------01D33A00B13E2A599EE430F3
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

On 9/29/2016 9:49 AM, Ondrej Zary wrote:
>> Ok, since I have not seen the full boot log I am guessing that isa api
>> > gets called before the link objects are initialized.
> Netconsole did not work (probably because it crashes too early?) and I don't 
> have a null-modem cable.
> 

Probably, this is telling me that using the link list to determine penalties for
ISA penalties is a bad idea as the ISA API seems to be called from arbitrary
contexts even before the ACPI Link objects are created. 

I was trying to reuse the PCI execution path for ISA interrupts using the last
two patches. I dropped the first and last two patches and restored the penalty PCI
penalty assignment for the active interrupt only if the interrupt is a ISA interrupt
with a new patch.

>> > Can you appply the first three only (0001, 0002 and 0003) to see if it
>> > makes a difference?
> It boots with first 3 patches only but the problem remains - see the attached 
> log.

Let's see the new set. If this doesn't work, I'll have to provide you with another
patch to get the penalty counts again. The original debug aids patch may not apply
after these.




-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

--------------01D33A00B13E2A599EE430F3
Content-Type: text/plain; charset=UTF-8;
 name="0001-ACPI-PCI-IRQ-remove-double-penalty-calculation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ACPI-PCI-IRQ-remove-double-penalty-calculation.patch"

>From 82278a843e968ed98f18cd7a3cca515aabe2ab3a Mon Sep 17 00:00:00 2001
From: Sinan Kaya <okaya@codeaurora.org>
Date: Wed, 28 Sep 2016 19:08:34 -0400
Subject: [PATCH 1/2] ACPI, PCI, IRQ: remove double penalty calculation

acpi_irq_get_penalty returns the penalty for both PCI and ISA penalties.
Now that we don't have any storage place for PCI IRQs, we run into some
math problem such as follows:

The original code was as simple as this:
acpi_isa_irq_penalty += penalty

In order to hide PCI IRQ calculation difference vs. ISA IRQ difference, we
created the acpi_irq_get_penalty function and replaced the above statement
as

acpi_isa_irq_penalty = acpi_irq_get_penalty() + penalty

This is what acpi_irq_get_penalty returns.

acpi_irq_get_penalty()= acpi_isa_irq_penalty + SCI penalty

When you call acpi_penalize_isa_irq twice, you end up with:

acpi_isa_irq_penalty = 2 * SCI penalty + acpi_isa_irq_penalty

Fixing this by directly modifying acpi_isa_irq_penalty for the new penalty
added.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index c983bf7..59326ac 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -870,9 +870,10 @@ static int __init acpi_irq_penalty_update(char *str, int used)
  */
 void acpi_penalize_isa_irq(int irq, int active)
 {
+	int penalty = active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING;
+
 	if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
-		acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
-		  (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
+		acpi_isa_irq_penalty[irq] += penalty;
 }
 
 bool acpi_isa_irq_available(int irq)
-- 
1.9.1


--------------01D33A00B13E2A599EE430F3
Content-Type: text/plain; charset=UTF-8;
 name="0002-ACPI-PCI-IRQ-add-PCI_USING-penalty-for-ISA-interrupt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-ACPI-PCI-IRQ-add-PCI_USING-penalty-for-ISA-interrupt.pa";
 filename*1="tch"

>From 163255c91635d5e85dc71724b86def80ff433b88 Mon Sep 17 00:00:00 2001
From: Sinan Kaya <okaya@codeaurora.org>
Date: Thu, 29 Sep 2016 10:25:21 -0400
Subject: [PATCH 2/2] ACPI, PCI IRQ: add PCI_USING penalty for ISA interrupts

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
index 59326ac..47407cb 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -619,6 +619,10 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 			    acpi_device_bid(link->device));
 		return -ENODEV;
 	} else {
+		if (irq < ACPI_MAX_ISA_IRQS)
+			acpi_isa_irq_penalty[link->irq.active] +=
+				PIRQ_PENALTY_PCI_USING;
+
 		printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
 		       acpi_device_name(link->device),
 		       acpi_device_bid(link->device), link->irq.active);
-- 
1.9.1


--------------01D33A00B13E2A599EE430F3--
