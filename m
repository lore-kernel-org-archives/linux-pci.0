Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 2/5] gic-its: Allow pci_requester_id to be overridden.
To: Pavel Fedin <p.fedin@samsung.com>,
	'David Daney' <ddaney.cavm@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>,
	'Catalin Marinas' <catalin.marinas@arm.com>,
	'Will Deacon' <will.deacon@arm.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>,
	'Thomas Gleixner' <tglx@linutronix.de>,
	'Jason Cooper' <jason@lakedaemon.net>
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
 <1436979285-8177-3-git-send-email-ddaney.cavm@gmail.com>
 <01a101d0db52$2d23b360$876b1a20$@samsung.com>
CC: <linux-kernel@vger.kernel.org>,
	'Robert Richter' <rrichter@cavium.com>,
	'David Daney' <david.daney@cavium.com>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <55D5F0E1.30702@caviumnetworks.com>
Date: Thu, 20 Aug 2015 08:23:13 -0700
MIME-Version: 1.0
In-Reply-To: <01a101d0db52$2d23b360$876b1a20$@samsung.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/20/2015 07:11 AM, Pavel Fedin wrote:
>
>   Hello!
>
>> -----Original Message-----
>> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org] On Behalf Of David
>> Daney
>> Sent: Wednesday, July 15, 2015 7:55 PM
>> To: linux-arm-kernel@lists.infradead.org; Catalin Marinas; Will Deacon; Bjorn Helgaas; linux-
>> pci@vger.kernel.org; Thomas Gleixner; Jason Cooper
>> Cc: linux-kernel@vger.kernel.org; Robert Richter; David Daney
>> Subject: [PATCH 2/5] gic-its: Allow pci_requester_id to be overridden.
>>
>> From: David Daney <david.daney@cavium.com>
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c   | 14 +++++++++++++-
>>   include/linux/irqchip/arm-gic-v3.h |  2 ++
>>   2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 1b7e155..4580970 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1189,11 +1189,23 @@ static int its_pci_msi_vec_count(struct pci_dev *pdev)
>>   	return max(msi, msix);
>>   }
>>
>> +static u32 its_dflt_pci_requester_id(struct pci_dev *pdev, u16 alias)
>> +{
>> +	return alias;
>> +}
>> +
>> +static its_pci_requester_id_t its_pci_requester_id = its_dflt_pci_requester_id;
>> +void set_its_pci_requester_id(its_pci_requester_id_t fn)
>> +{
>> +	its_pci_requester_id = fn;
>> +}
>> +EXPORT_SYMBOL(set_its_pci_requester_id);
>
>   IMHO having a globally defined function is a horrible approach. What if some HW has two different
> PCI host controllers, each of them wants to provide different form of IDs? I know, this is just
> imaginary, but still...

It is not imaginary, such systems exist.

>   What if instead of this function we simply add a field to a struct pci_bus ? Then bus driver would
> fill in HW-specific ID bits for every bus.
>   I can send a patch if interested.

There is a lot of work being done in the upstream to extract the proper 
information from the device tree.  We are going to piggyback on that for 
the next versions of the patch.

ACPI will have to be made to work as well.

David Daney




>
>> +
>>   static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
>>   {
>>   	struct its_pci_alias *dev_alias = data;
>>
>> -	dev_alias->dev_id = alias;
>> +	dev_alias->dev_id = its_pci_requester_id(pdev, alias);
>>   	if (pdev != dev_alias->pdev)
>>   		dev_alias->count += its_pci_msi_vec_count(dev_alias->pdev);
>>
>> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
>> index ffbc034..18e3757 100644
>> --- a/include/linux/irqchip/arm-gic-v3.h
>> +++ b/include/linux/irqchip/arm-gic-v3.h
>> @@ -389,6 +389,8 @@ int its_cpu_init(void);
>>   int its_init(struct device_node *node, struct rdists *rdists,
>>   	     struct irq_domain *domain);
>>
>> +typedef u32 (*its_pci_requester_id_t)(struct pci_dev *, u16);
>> +void set_its_pci_requester_id(its_pci_requester_id_t fn);
>>   #endif
>>
>>   #endif
>> --
>
> Kind regards,
> Pavel Fedin
> Expert Engineer
> Samsung Electronics Research center Russia
>
>
>
