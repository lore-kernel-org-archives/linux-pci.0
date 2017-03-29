Return-Path: <SRS0=q2b8=3G=arm.com=robin.murphy@kernel.org>
Return-Path: <SRS0=q2b8=3G=arm.com=robin.murphy@kernel.org>
Subject: Re: [PATCH v3 2/2] PCI: Add tango PCIe host bridge support
To: Mason <slash.tmp@free.fr>
References: <5309e718-5813-5b79-db57-9d702b50d0f9@sigmadesigns.com>
 <65114e62-7458-b6f7-327c-f07a5096a452@sigmadesigns.com>
 <01516ad9-e187-4bac-7c65-a7a90c576ce2@arm.com>
 <96da696c-141a-3e8d-1fb7-2c024a295f58@free.fr>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>, DT <devicetree@vger.kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <84a8b26d-7d24-df29-3959-45fce880916d@arm.com>
Date: Wed, 29 Mar 2017 15:33:44 +0100
MIME-Version: 1.0
In-Reply-To: <96da696c-141a-3e8d-1fb7-2c024a295f58@free.fr>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 29/03/17 13:53, Mason wrote:
> On 29/03/2017 14:19, Robin Murphy wrote:
> 
>> On 29/03/17 12:34, Marc Gonzalez wrote:
>>
>>> +	/*
>>> +	 * QUIRK #3
>>> +	 * Unfortunately, config and mem spaces are muxed.
>>> +	 * Linux does not support such a setting, since drivers are free
>>> +	 * to access mem space directly, at any time.
>>> +	 * Therefore, we can only PRAY that config and mem space accesses
>>> +	 * NEVER occur concurrently.
>>> +	 */
>>
>> What about David's suggestion of using an IPI for safe mutual exclusion?
> 
> I was left with the impression that this wouldn't solve the problem.
> If a mem space access is "in flight" on core0 when core1 starts a
> config space access, an IPI will not prevent breakage.
> 
> Did I misunderstand?
> 
> For my education, what is the API to send an IPI?
> And the API to handle an IPI?

There are a few ways you could implement some custom cross-call,
although in this case I think stop_machine() would probably be the most
appropriate candidate. However, you're right that in general it may not
actually help enough to be worthwhile - a DSB SY would ensure that
in-flight transactions have at least been observed by the CPUs and any
other coherent masters, but for any writes with a memory type allowing
early acknowledgement (i.e. a Normal or Device mapping of a BAR) that
doesn't necessarily correlate with them having reached their ultimate
destination. For a PCI destination in particular, I think the normal way
to ensure all posted writes have completed would be to read from config
space; ah...

>>> +	if (of_device_is_compatible(dev->of_node, "sigma,smp8759-pcie"))
>>> +		smp8759_init(pcie, base);
>>
>> ...then retrieve it with of_device_get_match_data() here. No need to
>> reinvent the wheel (or have to worry about the ordering of multiple
>> compatibles once rev. n+1 comes around).
> 
> I actually asked about this on IRC. The consensus was "use what
> best fits your use case". I need to do some processing based on
> the revision, so I thought
> 
>   if (chip_x)
> 	do_chip_x_init()
> 
> was a good way to express my intent. Did I misunderstand?

No, I'm in no way disputing that; what I'm pointing out is that you
already have an explicitly provided way to associate a value of "chip_x"
with a given compatible string - see other callers of
of_device_get_match_data() for inspiration. I don't have much of an
opinion as to whether it's an enum, a static structure of offsets and
callbacks, or you embrace the nasal demons and just wedge the init
function pointer in there directly (this'll never run on
IA-64/M68k/etc., right? :P). The point is that not only is it cleaner
and scales better as the driver grows, it stops you having to worry at
all about setting this trap for yourself:

	compatible = "rev3-with-extra-fun", "rev3";
	...

	if (of_device_is_compatible(dev, "rev3"))
		boring_init_without_extra_fun();	/* :( */

because once you've made your code robust against that, you'll realise
that what you've done is wasted your time open-coding a creaky
approximation of of_match_device().

Robin.

> For example, the init function for rev2 currently looks like this:
> 
> static void rev2_init(struct tango_pcie *pcie, void __iomem *base)
> {
> 	void __iomem *misc_irq	= base + 0x40;
> 	void __iomem *doorbell	= base + 0x8c;
> 
> 	pcie->mux		= base + 0x2c;
> 	pcie->msi_status	= base + 0x4c;
> 	pcie->msi_mask		= base + 0x6c;
> 	pcie->msi_doorbell	= 0x80000000;
> 
> 	writel(lower_32_bits(pcie->msi_doorbell), doorbell + 0);
> 	writel(upper_32_bits(pcie->msi_doorbell), doorbell + 4);
> 
> 	/* Enable legacy PCI interrupts */
> 	writel(BIT(15), misc_irq);
> 	writel(0xf << 4, misc_irq + 4);
> }
> 
>>> +#define VENDOR_SIGMA	0x1105
>>
>> Should this not be in include/linux/pci_ids.h?
> 
> Doh! Very likely. Thanks.
> 
> Regards.
> 
