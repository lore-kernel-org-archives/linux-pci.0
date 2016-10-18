Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH V2 3/4] ACPI,PCI,IRQ: separate ISA penalty calculation
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1467188859-28188-1-git-send-email-okaya@codeaurora.org>
 <1467188859-28188-4-git-send-email-okaya@codeaurora.org>
 <20161018104649.GA13940@localhost>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org,
 jcm@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com,
 linux-pci@vger.kernel.org, agross@codeaurora.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 wim@djo.tudelft.nl, perex@perex.cz, tiwai@suse.com,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <17ab5714-0e2e-8b5f-356f-8f2019a0177b@codeaurora.org>
Date: Tue, 18 Oct 2016 09:10:38 -0700
MIME-Version: 1.0
In-Reply-To: <20161018104649.GA13940@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 10/18/2016 3:46 AM, Bjorn Helgaas wrote:
> Hi Sinan,
> 
> On Wed, Jun 29, 2016 at 04:27:37AM -0400, Sinan Kaya wrote:
>> Since commit 103544d86976 ("ACPI,PCI,IRQ: reduce resource requirements")
>> the penalty values are calculated on the fly rather than boot time.
>>
>> This works fine for PCI interrupts but not so well for the ISA interrupts.
>> Whether an ISA interrupt is in use or not information is not available
>> inside the pci_link.c file. This information gets sent externally via
>> acpi_penalize_isa_irq function. If active is true, then the IRQ is in use
>> by ISA. Otherwise, IRQ is in use by PCI.
>>
>> Since the current code relies on PCI Link object for determination of
>> penalties, we are factoring in the PCI penalty twice after
>> acpi_penalize_isa_irq function is called.
> 
> I know this patch has already been merged, but I'm confused.
> 
> Can you be a little more specific about how we factor in the PCI
> penalty twice?  I think that when we enumerate an enabled link device,
> we call acpi_penalize_isa_irq(x) in this path:
> 
>   pnpacpi_allocated_resource
>     pnpacpi_add_irqresource
>       pcibios_penalize_isa_irq
>         acpi_penalize_isa_irq
>           acpi_isa_irq_penalty[x] = PIRQ_PENALTY_ISA_USED
> 

This is not really a problem but more information about how things work. 
I was trying to point out the fact that acpi_penalize_isa_irq is changing
the penalties externally while ISA IRQs get initialized based on the active
parameter. 

The penalty determination of ISA IRQ goes through 2 paths.
1. assign PCI_USING during power up via acpi_irq_penalty_init
2. update the penalty with acpi_irq_pci_sharing_penalty function based on active
parameter.


> And I see that acpi_irq_penalty_init() also adds in some penalty
> (either "PIRQ_PENALTY_PCI_POSSIBLE / possible_count" or
> PIRQ_PENALTY_PCI_POSSIBLE).  And when we call acpi_irq_get_penalty(x),
> we add in PIRQ_PENALTY_PCI_USING.
> 
> It doesn't seem right to me that we're adding both
> PIRQ_PENALTY_ISA_USED and PIRQ_PENALTY_PCI_USING.  Is that the problem
> you're referring to?

Correct, this is the one. What happened in this case is that 
acpi_irq_penalty_init added a PCI_USING penalty during boot. Then, when we
wanted to get the penalty for an ISA IRQ. This added another PCI_USING penalty
in acpi_irq_pci_sharing_penalty function in addition to originally added penalty.

Now, we have 2 * PCI_USING assigned to an ISA IRQ.

> 
>> This change is limiting the newly added functionality to just PCI
>> interrupts so that old behavior is still maintained.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  drivers/acpi/pci_link.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
>> index 714ba4d..8c08971 100644
>> --- a/drivers/acpi/pci_link.c
>> +++ b/drivers/acpi/pci_link.c
>> @@ -496,9 +496,6 @@ static int acpi_irq_get_penalty(int irq)
>>  {
>>  	int penalty = 0;
>>  
>> -	if (irq < ACPI_MAX_ISA_IRQS)
>> -		penalty += acpi_isa_irq_penalty[irq];
>> -
>>  	/*
>>  	* Penalize IRQ used by ACPI SCI. If ACPI SCI pin attributes conflict
>>  	* with PCI IRQ attributes, mark ACPI SCI as ISA_ALWAYS so it won't be
>> @@ -513,6 +510,9 @@ static int acpi_irq_get_penalty(int irq)
>>  			penalty += PIRQ_PENALTY_PCI_USING;
>>  	}
>>  
>> +	if (irq < ACPI_MAX_ISA_IRQS)
>> +		return penalty + acpi_isa_irq_penalty[irq];
>> +
>>  	penalty += acpi_irq_pci_sharing_penalty(irq);
>>  	return penalty;
> 
> I don't understand what's going on here.
> 
> acpi_irq_pci_sharing_penalty(X) basically tells us how many link
> devices are already using IRQ X.  This change makes it so we don't
> consider that information if X < ACPI_MAX_ISA_IRQS.
> 

The ISA IRQ doesn't need the penalties coming from
acpi_irq_pci_sharing_penalty function since acpi_irq_pci_sharing_penalty
is intended do the same thing as acpi_irq_penalty_init. It is just smarter
to cover more IRQ range.

Since acpi_irq_penalty_init is called during boot for the ISA IRQS, calling
acpi_irq_pci_sharing_penalty again is incorrect.


> Let's say we have several link devices that are initially disabled,
> e.g.,
> 
>   LNKA (IRQs 9 10 11)
>   LNKB (IRQs 9 10 11)
>   LNKC (IRQs 9 10 11)
> 
> When we enable these, I think we'll choose the same IRQ for all of
> them because we no longer look at the other links to see how they're
> configured.

You are right. This is the reason why I have this patch.

[PATCH V3 1/3] ACPI, PCI IRQ: add PCI_USING penalty for ISA interrupts

The penalties get assigned by the acpi_irq_penalty_init and acpi_penalize_isa_irq
functions before the PCI Link object is created until this moment. 

By the time link object is getting initialized, the code chooses the correct penalty here:

/
 * Select the best IRQ.  This is done in reverse to promote
 * the use of IRQs 9, 10, 11, and >15.
 */
for (i = (link->irq.possible_count - 1); i >= 0; i--) {
        if (acpi_irq_get_penalty(irq) >
            acpi_irq_get_penalty(link->irq.possible[i]))
                irq = link->irq.possible[i];
}

and the code needs to increment the penalty on this IRQ so that the next PCI Link object
would find another IRQ. This is missing right now.


> 
>>  }
>> -- 
>> 1.8.2.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
