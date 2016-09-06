Return-Path: <rjwysocki@gmail.com>
Return-Path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <292d1dd1-0084-d796-b852-6cad2099eb66@semihalf.com>
References: <1473152938-17388-1-git-send-email-tn@semihalf.com>
 <1473152938-17388-8-git-send-email-tn@semihalf.com> <alpine.DEB.2.20.1609061149090.5647@nanos>
 <292d1dd1-0084-d796-b852-6cad2099eb66@semihalf.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 6 Sep 2016 13:29:09 +0200
Message-ID: <CAJZ5v0iYc=1CN546MaabJdoNBUW8JbeD_qt8hSSDBPLJnB8Hug@mail.gmail.com>
Subject: Re: [PATCH V10 7/8] irqchip/gicv3-its: Factor out PCI-MSI part that
 might be reused for ACPI
To: Tomasz Nowicki <tn@semihalf.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>,
	Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, shijie.huang@arm.com,
	robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Andrea Gallo <andrea.gallo@linaro.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Stone <al.stone@linaro.org>,
	G Gregory <graeme.gregory@linaro.org>, David Daney <ddaney.cavm@gmail.com>,
	Sinan Kaya <okaya@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 6, 2016 at 12:22 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
> Hi Thomas,
>
>
> On 06.09.2016 11:50, Thomas Gleixner wrote:
>>
>> On Tue, 6 Sep 2016, Tomasz Nowicki wrote:
>>>
>>> -static int __init its_pci_msi_init(void)
>>> +static int __init its_pci_msi_init_one(struct fwnode_handle *handle,
>>> +                                      const char *name)
>>>  {
>>> -       struct device_node *np;
>>>         struct irq_domain *parent;
>>>
>>> +       parent = irq_find_matching_fwnode(handle, DOMAIN_BUS_NEXUS);
>>> +       if (!parent || !msi_get_domain_info(parent)) {
>>> +               pr_err("%s: Unable to locate ITS domain\n", name);
>>> +               return -ENXIO;
>>> +       }
>>> +
>>> +       if (!pci_msi_create_irq_domain(handle, &its_pci_msi_domain_info,
>>> +                                      parent)) {
>>> +               pr_err("%s: Unable to create PCI domain\n", name);
>>> +               return -ENOMEM;
>>
>>
>> So you have error codes here.
>>
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int __init its_pci_of_msi_init(void)
>>> +{
>>> +       struct device_node *np;
>>> +
>>>         for (np = of_find_matching_node(NULL, its_device_id); np;
>>>              np = of_find_matching_node(np, its_device_id)) {
>>>                 if (!of_property_read_bool(np, "msi-controller"))
>>>                         continue;
>>>
>>> -               parent = irq_find_matching_host(np, DOMAIN_BUS_NEXUS);
>>> -               if (!parent || !msi_get_domain_info(parent)) {
>>> -                       pr_err("%s: unable to locate ITS domain\n",
>>> -                              np->full_name);
>>> +               if (its_pci_msi_init_one(of_node_to_fwnode(np),
>>> np->full_name))
>>>                         continue;
>>> -               }
>>> -
>>> -               if (!pci_msi_create_irq_domain(of_node_to_fwnode(np),
>>> -                                              &its_pci_msi_domain_info,
>>> -                                              parent)) {
>>> -                       pr_err("%s: unable to create PCI domain\n",
>>> -                              np->full_name);
>>> -                       continue;
>>> -               }
>>>
>>>                 pr_info("PCI/MSI: %s domain created\n", np->full_name);
>>>         }
>>>
>>>         return 0;
>>
>>
>> And no matter what you return success
>>
>>>  }
>>> +
>>> +static int __init its_pci_msi_init(void)
>>> +{
>>> +       its_pci_of_msi_init();
>>
>>
>> Which you subsequently ignore here. What's the point?
>>
>
> Well, this patch is meant to refactor the code. It does not change the error
> handing nor the functionality. However, you have got a point but IMO it
> should be fixed in separate patch if possible.

But you are refactoring the code, so it would make sense to clean it
up while at it.  Perhaps add one more patch to the series?

Thanks,
Rafael
