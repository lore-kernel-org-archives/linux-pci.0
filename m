Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link
 [LNKD]. Try pci=noacpi or acpi=off
To: Ondrej Zary <linux@rainbow-software.org>
References: <201609251512.05657.linux@rainbow-software.org>
 <201609291549.07784.linux@rainbow-software.org>
 <e90fb01a-77e3-a094-9631-0b703972c750@codeaurora.org>
 <201609291848.33803.linux@rainbow-software.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        wim@djo.tudelft.nl, ravikanth.nalla@hpe.com
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <701eeb2f-bfc2-d541-4f6f-34be200ea44a@codeaurora.org>
Date: Thu, 29 Sep 2016 13:18:43 -0400
MIME-Version: 1.0
In-Reply-To: <201609291848.33803.linux@rainbow-software.org>
Content-Type: multipart/mixed;
 boundary="------------EDEE035209F4AB984312D6F5"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------EDEE035209F4AB984312D6F5
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

On 9/29/2016 12:48 PM, Ondrej Zary wrote:
>> Let's see the new set. If this doesn't work, I'll have to provide you with
>> > another patch to get the penalty counts again. The original debug aids
>> > patch may not apply after these.
> It boots but the IRQ problem still remains the same. See the attached logs:
> dmesg-bad.txt: without the irq -> link->irq.active change
> dmesg-bad2.txt: with the irq -> link->irq.active change
> dmesg-bad2-debug.txt: as above with modified debug patch
> 
> @@ -876,8 +893,11 @@ void acpi_penalize_isa_irq(int irq, int active)
>  {
>         int penalty = active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING;
> 
> -       if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
> +       if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty))) {
>                 acpi_isa_irq_penalty[irq] += penalty;
> +               pr_info("%s:%d acpi_isa_irq_penalty[%d]=0x%x active = %d\n", 
> __func__,
> +                               __LINE__, irq,  acpi_irq_get_penalty(irq), 
> active);
> +       }
>  }
> 

The previous two patches were in the right direction.

Can we also get the same output from 4.6 kernel with the attached patch for the
same machine you sent these?

Something about SCI still doesn't feel right.

The IRQ assignment fails if the penalty is greater than PIRQ_PENALTY_ISA_ALWAYS.
This will happen if BIOS tells us to use an IRQ and same IRQ is in use by the 
SCI.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

--------------EDEE035209F4AB984312D6F5
Content-Type: text/plain; charset=UTF-8;
 name="0001-ACPI-PCI-IRQ-debug-aids-for-4.6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ACPI-PCI-IRQ-debug-aids-for-4.6.patch"

>From 609da980e4af9757b33a9d4f0771a08f1a1e17fe Mon Sep 17 00:00:00 2001
From: Sinan Kaya <okaya@codeaurora.org>
Date: Thu, 29 Sep 2016 13:16:49 -0400
Subject: [PATCH] ACPI, PCI, IRQ: debug aids for 4.6

Change-Id: I9c6170034ec30f04372315de3076f610f7e87668
---
 drivers/acpi/pci_link.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index ededa90..0bd51f0 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -541,6 +541,10 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 	else
 		irq = link->irq.possible[link->irq.possible_count - 1];
 
+	pr_info("irq : %d\n", irq);
+	pr_info("acpi_irq_balance : %d\n", acpi_irq_balance);
+	pr_info("link->irq.active : %d\n", link->irq.active);
+	pr_info("acpi_gbl_FADT.sci_interrupt : %d\n", acpi_gbl_FADT.sci_interrupt);
 	if (acpi_irq_balance || !link->irq.active) {
 		/*
 		 * Select the best IRQ.  This is done in reverse to promote
@@ -548,10 +552,21 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 		 */
 		for (i = (link->irq.possible_count - 1); i >= 0; i--) {
 			if (acpi_irq_penalty[irq] >
-			    acpi_irq_penalty[link->irq.possible[i]])
+			    acpi_irq_penalty[link->irq.possible[i]]) {
+				pr_info("acpi_irq_get_penalty(%d) : 0x%x\n", link->irq.possible[i], acpi_irq_penalty[link->irq.possible[i]]);
+				pr_info("acpi_irq_get_penalty(%d) : 0x%x\n", irq, acpi_irq_penalty[irq]);
 				irq = link->irq.possible[i];
+			}
 		}
 	}
+	for (i = (link->irq.possible_count - 1); i >= 0; i--) {
+		pr_info("penalty[%d] = 0x%x\n",
+				link->irq.possible[i],
+		    acpi_irq_penalty[link->irq.possible[i]]);
+	}
+	pr_info("irq : %d\n", irq);
+	pr_info("acpi_gbl_FADT.sci_interrupt : %d\n", acpi_gbl_FADT.sci_interrupt);
+
 	if (acpi_irq_penalty[irq] >= PIRQ_PENALTY_ISA_ALWAYS) {
 		printk(KERN_ERR PREFIX "No IRQ available for %s [%s]. "
 			    "Try pci=noacpi or acpi=off\n",
@@ -569,6 +584,7 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 		return -ENODEV;
 	} else {
 		acpi_irq_penalty[link->irq.active] += PIRQ_PENALTY_PCI_USING;
+		pr_info("acpi_irq_get_penalty(%d) : 0x%x\n", link->irq.active, acpi_irq_penalty[link->irq.active]);
 		printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
 		       acpi_device_name(link->device),
 		       acpi_device_bid(link->device), link->irq.active);
@@ -824,6 +840,9 @@ void acpi_penalize_isa_irq(int irq, int active)
 			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_USED;
 		else
 			acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
+
+		pr_info("%s:%d acpi_isa_irq_penalty[%d]=0x%x active = %d\n", __func__,
+				__LINE__, irq,  acpi_irq_penalty[irq], active);
 	}
 }
 
-- 
1.9.1


--------------EDEE035209F4AB984312D6F5--
