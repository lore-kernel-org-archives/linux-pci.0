Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
Subject: Re: [PATCH V10 7/8] irqchip/gicv3-its: Factor out PCI-MSI part that
 might be reused for ACPI
To: Thomas Gleixner <tglx@linutronix.de>
References: <1473152938-17388-1-git-send-email-tn@semihalf.com>
 <1473152938-17388-8-git-send-email-tn@semihalf.com>
 <alpine.DEB.2.20.1609061149090.5647@nanos>
Cc: marc.zyngier@arm.com, jason@lakedaemon.net, rjw@rjwysocki.net,
 helgaas@kernel.org, rafael@kernel.org, Lorenzo.Pieralisi@arm.com,
 will.deacon@arm.com, catalin.marinas@arm.com, hanjun.guo@linaro.org,
 shijie.huang@arm.com, robert.richter@caviumnetworks.com, mw@semihalf.com,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linaro-acpi@lists.linaro.org, andrea.gallo@linaro.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 al.stone@linaro.org, graeme.gregory@linaro.org, ddaney.cavm@gmail.com,
 okaya@codeaurora.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <292d1dd1-0084-d796-b852-6cad2099eb66@semihalf.com>
Date: Tue, 6 Sep 2016 12:22:57 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609061149090.5647@nanos>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Thomas,

On 06.09.2016 11:50, Thomas Gleixner wrote:
> On Tue, 6 Sep 2016, Tomasz Nowicki wrote:
>> -static int __init its_pci_msi_init(void)
>> +static int __init its_pci_msi_init_one(struct fwnode_handle *handle,
>> +				       const char *name)
>>  {
>> -	struct device_node *np;
>>  	struct irq_domain *parent;
>>
>> +	parent = irq_find_matching_fwnode(handle, DOMAIN_BUS_NEXUS);
>> +	if (!parent || !msi_get_domain_info(parent)) {
>> +		pr_err("%s: Unable to locate ITS domain\n", name);
>> +		return -ENXIO;
>> +	}
>> +
>> +	if (!pci_msi_create_irq_domain(handle, &its_pci_msi_domain_info,
>> +				       parent)) {
>> +		pr_err("%s: Unable to create PCI domain\n", name);
>> +		return -ENOMEM;
>
> So you have error codes here.
>
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init its_pci_of_msi_init(void)
>> +{
>> +	struct device_node *np;
>> +
>>  	for (np = of_find_matching_node(NULL, its_device_id); np;
>>  	     np = of_find_matching_node(np, its_device_id)) {
>>  		if (!of_property_read_bool(np, "msi-controller"))
>>  			continue;
>>
>> -		parent = irq_find_matching_host(np, DOMAIN_BUS_NEXUS);
>> -		if (!parent || !msi_get_domain_info(parent)) {
>> -			pr_err("%s: unable to locate ITS domain\n",
>> -			       np->full_name);
>> +		if (its_pci_msi_init_one(of_node_to_fwnode(np), np->full_name))
>>  			continue;
>> -		}
>> -
>> -		if (!pci_msi_create_irq_domain(of_node_to_fwnode(np),
>> -					       &its_pci_msi_domain_info,
>> -					       parent)) {
>> -			pr_err("%s: unable to create PCI domain\n",
>> -			       np->full_name);
>> -			continue;
>> -		}
>>
>>  		pr_info("PCI/MSI: %s domain created\n", np->full_name);
>>  	}
>>
>>  	return 0;
>
> And no matter what you return success
>
>>  }
>> +
>> +static int __init its_pci_msi_init(void)
>> +{
>> +	its_pci_of_msi_init();
>
> Which you subsequently ignore here. What's the point?
>

Well, this patch is meant to refactor the code. It does not change the 
error handing nor the functionality. However, you have got a point but 
IMO it should be fixed in separate patch if possible.

Thanks,
Tomasz
