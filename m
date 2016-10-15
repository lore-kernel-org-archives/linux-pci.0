Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V3 1/3] ACPI, PCI IRQ: add PCI_USING penalty for ISA
 interrupts
To: "Rafael J. Wysocki" <rafael@kernel.org>
References: <1476505867-24599-1-git-send-email-okaya@codeaurora.org>
 <1476505867-24599-2-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0iiU-1JwAows+WbE9v3pjYi9cRHDwtDEDBuCUjWk=o=KA@mail.gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>, ravikanth.nalla@hpe.com,
        Ondrej Zary <linux@rainbow-software.org>,
        Timur Tabi <timur@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Jon Masters <jcm@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Andy Gross <agross@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>, wim@djo.tudelft.nl,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <4b3f9df2-3fba-74f2-e944-aa474d35fed4@codeaurora.org>
Date: Sat, 15 Oct 2016 12:58:56 -0400
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iiU-1JwAows+WbE9v3pjYi9cRHDwtDEDBuCUjWk=o=KA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

On 10/15/2016 8:39 AM, Rafael J. Wysocki wrote:
> On Sat, Oct 15, 2016 at 6:31 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
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
> 
> I'd write the above this way:
> 
> "Commit 103544d86976 (ACPI,PCI,IRQ: reduce resource requirements)
> dropped the PCI_USING penalty from acpi_pci_link_allocate() with the
> assumption that the penalty will be added later in
> acpi_irq_pci_sharing_penalty()."
> 
> This conveys essentially the same information (up to some irrelevant
> bits), but in a clearer way IMO.
> 
>>
>> However, this function only gets called if the IRQ number is greater than
>> 16 and acpi_irq_get_penalty function gets called before ACPI start in
>> acpi_isa_irq_available and acpi_penalize_isa_irq functions. We can't rely
>> on iterating the link list.
> 
> "However, acpi_irq_pci_sharing_penalty() is only called for IRQ
> numbers above 15.  Moreover, acpi_irq_get_penalty() is invoked by
> acpi_isa_irq_available() and acpi_penalize_isa_irq() before the ACPI
> initialization and the PCI interrupt links list is not ready at that
> point, so it cannot be relied on when computing the penalty."
> 
>>
>> We need to add the PCI_USING penalty for ISA interrupts too if the link is
>> in use and matches our ISA IRQ number.
> 
> "For this reason, the PCI_USING penalty has to be added in
> acpi_pci_link_allocate() directly if the link has been enabled
> successfully and the IRQ number is within the ISA range."
> 
> IIUC
> 
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  drivers/acpi/pci_link.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
>> index c983bf7..a212709 100644
>> --- a/drivers/acpi/pci_link.c
>> +++ b/drivers/acpi/pci_link.c
>> @@ -619,6 +619,10 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>>                             acpi_device_bid(link->device));
>>                 return -ENODEV;
>>         } else {
>> +               if (link->irq.active < ACPI_MAX_ISA_IRQS)
>> +                       acpi_isa_irq_penalty[link->irq.active] +=
>> +                               PIRQ_PENALTY_PCI_USING;
>> +
> 
> There's no need to break the line here and I would put the above after
> the printk().
> 
> Or even after the whole "else" branch (which is unnecessary, but let's
> limit changes in this patch).
> 
>>                 printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
>>                        acpi_device_name(link->device),
>>                        acpi_device_bid(link->device), link->irq.active);
>> --
> 

Thanks for the feedback. I can resubmit with the comments corrected. I'll wait
until I hear from Bjorn first.

> Thanks,
> Rafael
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
