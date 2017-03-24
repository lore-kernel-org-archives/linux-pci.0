Return-Path: <SRS0=v3pA=3B=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=v3pA=3B=arm.com=marc.zyngier@kernel.org>
Subject: Re: [RFC PATCH v0.2] PCI: Add support for tango PCIe host bridge
To: Mason <slash.tmp@free.fr>, Bjorn Helgaas <helgaas@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <91db1f47-3024-9712-309a-fb4b21e42028@free.fr>
 <e5c0bace-fcbe-de3f-b76f-0fb672562e84@arm.com>
 <310db9dd-7db6-2106-2e53-f0083b2d3758@free.fr>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <012f7fcb-eaeb-70dd-a1a9-06c213789d30@arm.com>
Date: Fri, 24 Mar 2017 18:47:37 +0000
MIME-Version: 1.0
In-Reply-To: <310db9dd-7db6-2106-2e53-f0083b2d3758@free.fr>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 23/03/17 17:03, Mason wrote:
> On 23/03/2017 15:22, Marc Zyngier wrote:
> 
>> On 23/03/17 13:05, Mason wrote:
>>
>>> +#define MSI_COUNT 32
>>
>> Is this something that is hardcoded? Unlikely to ever change?
> 
> The host bridge actually supports 256 MSIs.
> 
> IIUC, what you suggested on IRC is that I support 256 in the driver,
> and only read the status for *enabled* MSIs.
> 
> Pseudo-code:
> 
> for every 32-bit blob in the enabled bitmap
>   if the value is non-zero
>     lookup the corresponding status reg
> 
> Problem is that a BITMAP is unsigned long (as you point out below).
> So I'm not sure how to iterate 32-bits at a time over the BITMAP.

See my reply in a previous email.

>>> +static void tango_msi_isr(struct irq_desc *desc)
>>> +{
>>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>>> +	struct tango_pcie *pcie;
>>> +	unsigned long status, virq;
>>> +	int pos;
>>> +
>>> +	chained_irq_enter(chip, desc);
>>> +	pcie = irq_desc_get_handler_data(desc);
>>> +
>>> +	status = readl_relaxed(pcie->msi_status);
>>
>> Please use types that unambiguously match that of the MMIO accessor (u32
>> in this case). On a 64bit system, unsigned long is likely to be 64bit.
>> You can assign it to an unsigned long before calling the
>> for_each_set_bit operator.
> 
> OK. I'm aware that unsigned long is 64 bits on sane 64b platforms,
> but since extending u32 to u64 would pad with zeros, I didn't expect
> this to be an issue. I will change the code. Note: I copied the
> code from the Altera driver.

This is an issue when your system is 64bit BE, something that is not
that uncommon.

> 
>>> +	writel_relaxed(status, pcie->msi_status); /* clear IRQs */
>>
>> Why isn't this your irq_ack method instead of open-coding it?
> 
> I based my driver on the Altera driver, and I did it like
> I thought they did. I will try fixing my code.

Doesn't make it right, unfortunately. I wish you would try to understand
the API first instead of copy-pasting things (including potential bugs).

> 
>>> +	for_each_set_bit(pos, &status, MSI_COUNT) {
>>> +		virq = irq_find_mapping(pcie->irq_domain, pos);
>>> +		if (virq)
>>> +			generic_handle_irq(virq);
>>> +		else
>>> +			pr_err("Unhandled MSI: %d\n", pos);
>>
>> Please rate-limit this.
> 
> I'll use pr_err_ratelimited
> 
> 
>>> +static struct msi_domain_info msi_domain_info = {
>>> +	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS,
>>
>> No support for MSI-X? Why?
> 
> Good question.
> https://en.wikipedia.org/wiki/Message_Signaled_Interrupts#MSI-X
> My controller supports a single doorbell, and only 256 MSIs.
> I thought that meant it didn't support MSI-X.

The "single doorbell" requirement is on the end-point, not on the
controller. Multi-MSI only has a single register for all possible
interrupts, while MSI-X allows one doorbell address per interrupt. In
your case, all interrupts will have the same doorbell address, which is
perfectly fine.

> 
> 
>>> +static int tango_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>>> +		unsigned int nr_irqs, void *args)
>>> +{
>>> +	struct tango_pcie *pcie = domain->host_data;
>>> +	int pos, err = 0;
>>> +	u32 mask;
>>> +
>>> +	if (nr_irqs != 1) /* When does that happen? */
>>> +		return -EINVAL;
>>
>> Only if the end-point wants to use Multi-MSI. You don't advertise
>> support for it, so it should never happen.
> 
> Should I keep the test or remove it?

Up to you. Some people warn loudly, some other ignore it, you've chosen
a middle ground.

> 
> 
>>> +	mutex_lock(&pcie->lock);
>>> +
>>> +	mask = readl_relaxed(pcie->msi_mask);
>>
>> Do you really need to read this from the HW each time you allocate an
>> interrupt? That feels pretty crazy. You're much better off having an
>> in-memory bitmap that will make things more efficient, and avoid the
>> following bug...
>>
>>> +	pos = find_first_zero_bit(&mask, MSI_COUNT);
>>
>> ... where using a u32 as a bitmap is a very bad idea (because not the
>> whole world is a 32bit, little endian platform).
> 
> I understand your point. This ties in to the ISR discussion.
> 
> 
>>> +	if (pos < MSI_COUNT)
>>> +		writel(mask | BIT(pos), pcie->msi_mask);
>>
>> And it would make a lot more sense to move this write (which should be
>> relaxed) to irq_unmask. Also, calling msi_mask for something that is an
>> enable register is a bit counter intuitive.
> 
> I don't have as much experience as you.
> I just used the names in the HW documentation.
> I think it is the "mask" (as in bitmap) of enabled MSIs.
> I will change "mask" to "enable".
> 
> Are you saying I should not use pci_msi_mask_irq and pci_msi_unmask_irq,
> but register custom implementations? I should still call these in my
> custom functions, right?

You can call both in your own mask/unmask methods. They serve different
purpose (one is at the endpoint level, the other is at the MSI
controller level).

> 
> 
>>> +	else
>>> +		err = -ENOSPC;
>>> +
>>> +	mutex_unlock(&pcie->lock);
>>> +
>>> +	irq_domain_set_info(domain, virq, pos, &tango_msi_chip,
>>> +			domain->host_data, handle_simple_irq, NULL, NULL);
>>
>> And here, you're polluting the domain even if you failed to allocate the
>> interrupt.
> 
> This bug is 100% mine. Will fix.

Erm. In this file, all bugs are yours! :-)

> 
>>> +
>>> +	return err;
>>> +}
>>> +
>>> +static void tango_irq_domain_free(struct irq_domain *domain,
>>> +				   unsigned int virq, unsigned int nr_irqs)
>>> +{
>>> +	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
>>> +	struct tango_pcie *pcie = irq_data_get_irq_chip_data(d);
>>> +	int pos = d->hwirq;
>>> +	u32 mask;
>>> +
>>> +	mutex_lock(&pcie->lock);
>>> +
>>> +	mask = readl(pcie->msi_mask);
>>> +	writel(mask & ~BIT(pos), pcie->msi_mask);
>>
>> Same as above, please move this to the irq_unmask method.
> 
> This one should be irq_mask, no?

Yes.

> 
> Even If I move the MMIO write, it should be done under lock,
> I think. But I don't know in what context irq_unmask will
> be called.
> You said: not mutex, spinlock.

It can be called from interrupt context, so it cannot be a mutex.

> 
> 
>>> +static int tango_msi_remove(struct platform_device *pdev)
>>> +{
>>> +	struct tango_pcie *msi = platform_get_drvdata(pdev);
>>> +
>>> +	irq_set_chained_handler(msi->irq, NULL);
>>> +	irq_set_handler_data(msi->irq, NULL);
>>> +	/* irq_set_chained_handler_and_data(msi->irq, NULL, NULL); instead? */
> 
> Can I call irq_set_chained_handler_and_data(msi->irq, NULL, NULL);
> instead of the two calls?

Probably. Reading the code should tell you.

> 
>>> +	mutex_init(&pcie->lock);
>>> +	writel(0, pcie->msi_mask);
>>> +
>>> +	/* Why is fwnode for this call? */
>>> +	irq_dom = irq_domain_add_linear(NULL, MSI_COUNT, &msi_domain_ops, pcie);
>>
>> Use irq_domain_create_linear, pass the same fwnode.
> 
> Will change that.
> 
> 
>>> +	if (!irq_dom) {
>>> +		pr_err("Failed to create IRQ domain\n");
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	msi_dom = pci_msi_create_irq_domain(fwnode, &msi_domain_info, irq_dom);
>>> +	if (!msi_dom) {
>>> +		pr_err("Failed to create MSI domain\n");
>>> +		irq_domain_remove(irq_dom);
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	virq = platform_get_irq(pdev, 1);
>>
>> In the absence of a documented binding, it is hard to know if you're
>> doing the right thing.
> 
> 		pcie@50000000 {
> 			compatible = "sigma,smp8759-pcie";
> 			reg = <0x50000000 SZ_64M>, <0x2e000 0x100>;
> 			device_type = "pci";
> 			bus-range = <0 63>;
> 			#size-cells = <2>;
> 			#address-cells = <3>;
> 			#interrupt-cells = <1>;
> 			ranges = <0x02000000 0x0 0x04000000  0x54000000  0x0 SZ_192M>;
> 			msi-controller;
> 			/* 54 for misc interrupts, 55 for MSI */
> 			interrupts = <54 IRQ_TYPE_LEVEL_HIGH>, <55 IRQ_TYPE_LEVEL_HIGH>;
> 		};

This is not a binding. This is an example from your DT. Look at
Documentation/devicetree/bindings/pci/ for examples of the required
documentation.

> 
> Note: I don't have an "interrupt-map" prop because rev1 doesn't support
> legacy PCI interrupts (INTx). But I see the PCI framework wrongly mapping
> intA to my system's interrupt #1, presumably because I am lacking an
> interrupt-map?

Probably. I don't think it is legal not to have an interrupt-map.

> 
> Also I find the MSI interrupt number to be high:
> 
> # cat /proc/interrupts 
>            CPU0       CPU1       
>  19:      21171       1074     GIC-0  29 Edge      twd
>  20:        116          0      irq0   1 Level     serial
>  26:          7          0       MSI   0 Edge      aerdrv
>  28:       3263          0       MSI 524288 Edge      xhci_hcd
> 
> 524288 is 0x80000. Was this offset chosen by the intc core?

By the PCI/MSI layer. See pci_msi_domain_calc_hwirq().

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
