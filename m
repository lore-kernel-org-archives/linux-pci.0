Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH V3 1/3] ACPI, PCI IRQ: add PCI_USING penalty for ISA
 interrupts
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1476505867-24599-1-git-send-email-okaya@codeaurora.org>
 <1476505867-24599-2-git-send-email-okaya@codeaurora.org>
 <20161022235837.GA1668@localhost>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
 ravikanth.nalla@hpe.com, linux@rainbow-software.org, timur@codeaurora.org,
 cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com,
 linux-pci@vger.kernel.org, agross@codeaurora.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 wim@djo.tudelft.nl, linux-arm-kernel@lists.infradead.org,
 Len Brown <lenb@kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5299d939-5d7d-05b7-bd5a-df1fe213fb21@codeaurora.org>
Date: Mon, 24 Oct 2016 00:16:04 -0400
MIME-Version: 1.0
In-Reply-To: <20161022235837.GA1668@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 10/22/2016 7:58 PM, Bjorn Helgaas wrote:
> On Sat, Oct 15, 2016 at 12:31:05AM -0400, Sinan Kaya wrote:
>> The change introduced in commit 103544d86976 ("ACPI,PCI,IRQ: reduce
>> resource requirements") removed PCI_USING penalty from
>> acpi_pci_link_allocate function as there is no longer a fixed size penalty
>> array for both PCI interrupts greater than 16.
>>
>> The array size has been reduced to 16 and array name got prefixed as ISA
>> since it only is accountable for the ISA interrupts.
>>
>> The original change in commit 103544d86976 ("ACPI,PCI,IRQ: reduce
>> resource requirements") removed penalty assignment in the code for PCI
>> thinking that we will add the penalty later in acpi_irq_pci_sharing_penalty
>> function.
>>
>> However, this function only gets called if the IRQ number is greater than
>> 16 and acpi_irq_get_penalty function gets called before ACPI start in
>> acpi_isa_irq_available and acpi_penalize_isa_irq functions. We can't rely
>> on iterating the link list.
>>
>> We need to add the PCI_USING penalty for ISA interrupts too if the link is
>> in use and matches our ISA IRQ number.
> 
> I think the history about the array size is more than is necessary for this
> changelog.  I think the useful part is something like this:
> 
>   ACPI: pci_link: Include PIRQ_PENALTY_PCI_USING for ISA IRQs
> 
>   103544d86976 ("ACPI,PCI,IRQ: reduce resource requirements") replaced
>   the addition of PIRQ_PENALTY_PCI_USING in acpi_pci_link_allocate()
>   with an addition in acpi_irq_pci_sharing_penalty(), but f7eca374f000
>   ("ACPI,PCI,IRQ: separate ISA penalty calculation") removed the use
>   of acpi_irq_pci_sharing_penalty() for ISA IRQs.
> 
>   Therefore, PIRQ_PENALTY_PCI_USING is missing from ISA IRQs used by
>   interrupt links.  Include that penalty by adding it in the
>   acpi_pci_link_allocate() path.
> 
>   Fixes: f7eca374f000 ("ACPI,PCI,IRQ: separate ISA penalty calculation")
>   
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

OK. Updated as suggested.

> 
>> ---
>>  drivers/acpi/pci_link.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
>> index c983bf7..a212709 100644
>> --- a/drivers/acpi/pci_link.c
>> +++ b/drivers/acpi/pci_link.c
>> @@ -619,6 +619,10 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>>  			    acpi_device_bid(link->device));
>>  		return -ENODEV;
>>  	} else {
>> +		if (link->irq.active < ACPI_MAX_ISA_IRQS)
>> +			acpi_isa_irq_penalty[link->irq.active] +=
>> +				PIRQ_PENALTY_PCI_USING;
>> +
>>  		printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
>>  		       acpi_device_name(link->device),
>>  		       acpi_device_bid(link->device), link->irq.active);
>> -- 
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
