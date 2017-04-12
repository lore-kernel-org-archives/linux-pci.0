Return-Path: <SRS0=5FSy=3U=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=5FSy=3U=arm.com=marc.zyngier@kernel.org>
Subject: Re: [RFC PATCH v0.2] PCI: Add support for tango PCIe host bridge
To: Mason <slash.tmp@free.fr>, Thomas Gleixner <tglx@linutronix.de>
References: <91db1f47-3024-9712-309a-fb4b21e42028@free.fr>
 <e5c0bace-fcbe-de3f-b76f-0fb672562e84@arm.com>
 <310db9dd-7db6-2106-2e53-f0083b2d3758@free.fr>
 <012f7fcb-eaeb-70dd-a1a9-06c213789d30@arm.com>
 <0502e180-5517-12d6-e3a1-bcea0da7e201@free.fr>
 <4edd799a-650c-0189-cd5c-e9fc18c5f8bc@arm.com>
 <30f662a6-5dab-515b-e35a-a312f3c7b509@free.fr>
 <5f81730d-fbe3-1f4c-de34-09bbfb893ee1@arm.com>
 <2b5eef4c-32f2-54f1-ca2f-f9426e68fb2c@free.fr>
 <67014006-a380-9e3b-c9af-a421052cb8e0@arm.com>
 <b59b81ea-bc1b-bff5-4a78-8a69538b0de3@free.fr>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <bc5bf8ad-69ef-4f14-f450-e162ddb5af7c@arm.com>
Date: Wed, 12 Apr 2017 09:08:31 +0100
MIME-Version: 1.0
In-Reply-To: <b59b81ea-bc1b-bff5-4a78-8a69538b0de3@free.fr>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 11/04/17 18:52, Mason wrote:
> On 11/04/2017 18:43, Marc Zyngier wrote:
> 
>> On 11/04/17 17:26, Mason wrote:
>>
>>> Is there a function to map virq to the hwirq in any domain?
>>
>> Be more precise. If you want the hwirq associated with the view of a
>> virq in a given domain, that's the hwirq field in the corresponding
>> irq_data structure. Or are you after something else?
> 
> I registered an unmask method for my irq_chip.
> (IIUC, I'm supposed to unmask a specific MSI in this callback.)
> 
> # cat /proc/interrupts 
>            CPU0       CPU1       
>  30:          0          0    MSIfoo      0 Edge      aerdrv
>  34:          0          0    MSIfoo 524288 Edge      xhci_hcd
>  35:          0          0    MSIfoo 524289 Edge      xhci_hcd
>  36:          0          0    MSIfoo 524290 Edge      xhci_hcd
> 
> 
> void foo_unmask(struct irq_data *data)
> {
> 	int xx,yy;
> 	struct irq_domain *dom = data->domain;
> 	printk("%s: irq_data=%p irq=%u hwirq=%lu chip=%p dom=%p pdata=%p data=%p\n",
> 		__func__, data, data->irq, data->hwirq, data->chip, data->domain,
> 		data->parent_data, data->chip_data);
> 	printk("%s ops=%p data=%p parent=%p\n\n",
> 		dom->name, dom->ops, dom->host_data, dom->parent);
> 	printk("pcie=%p\n", dom->parent->host_data);
> 	//dump_stack();
> 	pci_msi_unmask_irq(data);
> 	struct tango_pcie *pcie = data->domain->parent->host_data;
> 	printk("\n%s: pcie=%p irq=%u hwirq=%lu\n\n",
> 		__func__, pcie, data->irq, data->hwirq);
> 	xx = irq_find_mapping(pcie->irq_domain, data->hwirq);
> 	yy = irq_find_mapping(pcie->msi_domain, data->hwirq);

Do you realize that hwirq is *per domain*, and only makes sense to *one*
irqchip? What you've written here doesn't make any sense.

> 	printk("xx=%d yy=%d\n", xx, yy);
> }
> 
> so data->irq is the virq (30, 34, 35, 36)
> and data->hwirq is the domain hwirq (0, 524288, 524289, 524290)
> 
> Is there a way to map hwirq 524288 to MSI 0, hwirq 524289 to MSI 1, etc?

Why would you need to do such a thing?
- In MSI domain: IRQ34 -> hwirq 524288
- In foo domain: IRQ34 -> hwirq [whatever your driver has allocated]

The data is already there, at your fingertips. Just deal with with your
"foo" irqchip.

	M.
-- 
Jazz is not dead. It just smells funny...
