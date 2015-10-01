Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <560D5B98.5050400@caviumnetworks.com>
Date: Thu, 1 Oct 2015 09:13:12 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Marc Zyngier <marc.zyngier@arm.com>
CC: David Daney <ddaney.cavm@gmail.com>,
	<linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Frank Rowand <frowand.list@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v3 3/4] PCI/MSI:  Add helper function pci_msi_domain_get_msi_rid().
References: <1443653222-24924-1-git-send-email-ddaney.cavm@gmail.com> <1443653222-24924-4-git-send-email-ddaney.cavm@gmail.com> <560CFBDC.4020901@arm.com>
In-Reply-To: <560CFBDC.4020901@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/01/2015 02:24 AM, Marc Zyngier wrote:
> Hi David,
>
> On 30/09/15 23:47, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> Add pci_msi_domain_get_msi_rid() to return the MSI requester id (RID).
>> Initially needed by gic-v3 based systems. It will be used by follow on
>> patch to drivers/irqchip/irq-gic-v3-its-pci-msi.c
>>
>> Initially supports mapping the RID via OF device tree.  In the future,
>> this could be extended to use ACPI _IORT tables as well.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   drivers/pci/msi.c   | 31 +++++++++++++++++++++++++++++++
>>   include/linux/msi.h |  1 +
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index d449714..92b6dc9 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/io.h>
>>   #include <linux/slab.h>
>>   #include <linux/irqdomain.h>
>> +#include <linux/of_irq.h>
>>
>>   #include "pci.h"
>>
>> @@ -1327,4 +1328,34 @@ struct irq_domain *pci_msi_create_default_irq_domain(struct device_node *node,
>>
>>   	return domain;
>>   }
>> +
>> +struct get_mis_id_data {
>> +	u32	alias;
>> +};
>> +
>> +static int get_msi_id_cb(struct pci_dev *pdev, u16 alias, void *data)
>> +{
>> +	struct get_mis_id_data *s = data;
>> +
>> +	s->alias = alias;
>> +	return 0;
>> +}
>
> Why not use a naked u32, since you only have a single field in this
> structure? Or is it that you are anticipating other fields there?

In this case, I think using a pointer to u32 is a good idea.  It would 
simplify the source code somewhat.  Although, I think the generated 
binary would likely be the same.  I don't foresee adding things to this 
structure.  If it becomes necessary in the future, we can just go back 
to using a pointer to a structure.

>
>> +/**
>> + * pci_msi_domain_get_msi_rid - Get the MSI requester id (RID)
>> + * @domain:	The interrupt domain
>> + * @pdev:	The PCI device.
>> + *
>> + * The RID for a device is formed from the alias, with a firmware
>> + * supplied mapping applied
>> + *
>> + * Returns: The RID.
>> + */
>> +u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
>> +{
>> +	struct get_mis_id_data d;
>> +
>> +	d.alias = 0;
>> +	pci_for_each_dma_alias(pdev, get_msi_id_cb, &d);
>> +	return of_msi_map_rid(&pdev->dev, domain->of_node, d.alias);
>
> Should you check whether domain->of_node is NULL first? I don't think
> of_msi_map_rid would have any problem with that, but a domain that is
> not backed by an of_node makes me feel a bit uneasy and would tend to
> indicate that we're not using DT.

Yes, that makes sense.  As you observe, I think it probably works as is, 
but it would be good to make it more clear.  This is especially true 
when we add ACPI support.  We will want to be clear on which of 
device-tree or ACPI we are using.


>
>> +}
>>   #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
>> diff --git a/include/linux/msi.h b/include/linux/msi.h
>> index ad939d0..56e3b76 100644
>> --- a/include/linux/msi.h
>> +++ b/include/linux/msi.h
>> @@ -293,6 +293,7 @@ irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
>>   					  struct msi_desc *desc);
>>   int pci_msi_domain_check_cap(struct irq_domain *domain,
>>   			     struct msi_domain_info *info, struct device *dev);
>> +u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
>>   #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
>>
>>   #endif /* LINUX_MSI_H */
>>
>
> Otherwise looks good to me.

I will send what I hope is the final revision of the patches later today.

David Daney


