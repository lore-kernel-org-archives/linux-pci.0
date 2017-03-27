Return-Path: <SRS0=qGEF=3E=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=qGEF=3E=arm.com=marc.zyngier@kernel.org>
Subject: Re: [RFC PATCH v0.2] PCI: Add support for tango PCIe host bridge
To: Mason <slash.tmp@free.fr>, Bjorn Helgaas <helgaas@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <91db1f47-3024-9712-309a-fb4b21e42028@free.fr>
 <e5c0bace-fcbe-de3f-b76f-0fb672562e84@arm.com>
 <310db9dd-7db6-2106-2e53-f0083b2d3758@free.fr>
 <012f7fcb-eaeb-70dd-a1a9-06c213789d30@arm.com>
 <0502e180-5517-12d6-e3a1-bcea0da7e201@free.fr>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <4edd799a-650c-0189-cd5c-e9fc18c5f8bc@arm.com>
Date: Mon, 27 Mar 2017 18:09:52 +0100
MIME-Version: 1.0
In-Reply-To: <0502e180-5517-12d6-e3a1-bcea0da7e201@free.fr>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 27/03/17 16:53, Mason wrote:
> On 24/03/2017 19:47, Marc Zyngier wrote:
> 
>> On 23/03/17 17:03, Mason wrote:
>>
>>> On 23/03/2017 15:22, Marc Zyngier wrote:
>>>
>>>> On 23/03/17 13:05, Mason wrote:
>>>>
>>>>> +	writel_relaxed(status, pcie->msi_status); /* clear IRQs */
>>>>
>>>> Why isn't this your irq_ack method instead of open-coding it?
>>>
>>> I based my driver on the Altera driver, and I did it like
>>> I thought they did. I will try fixing my code.
>>
>> Doesn't make it right, unfortunately. I wish you would try to understand
>> the API first instead of copy-pasting things (including potential bugs).
> 
> So far, I have not been able to get the irqchip framework to
> call the irq_ack functions I registered.
> 
> Should I pass a different handler than handle_simple_irq
> to irq_domain_set_info?
> 
> 	irq_domain_set_info(domain, virq, pos, &tango_msi_chip,
> 		domain->host_data, handle_simple_irq, NULL, NULL);

Only you can answer that question. But looking at the documentation is 
always a good start:

/**
 *      handle_simple_irq - Simple and software-decoded IRQs.
 *      @desc:  the interrupt description structure for this irq
 *
 *      Simple interrupts are either sent from a demultiplexing interrupt
 *      handler or come from hardware, where no interrupt hardware control
 *      is necessary.
 *
 *      Note: The caller is expected to handle the ack, clear, mask and
 *      unmask issues if necessary.
 */

I'd tend to infer that this is not what you want. On the other hand,
something called handle_edge_irq sounds promising when you deal
with edge interrupts. But again, you are writing the driver, I cannot
guide your hand.

> When an MSI packet arrives at the MSI doorbell address, the controller
> reads the packet's data; this is the MSI number "num". It sets bit "num"
> to 1 in the status regs, and raises IRQ line 55 on the system intc.
> The IRQ signal remains high, until software clears it by writing 1
> in bit "num" of the status regs.
> 
> Is this an edge interrupt or a level interrupt?
> 
> I was told if the interrupt request is triggered by an event, then
> it is an edge interrupt. The reception of an MSI packet is an event.
> But the IRQ remains high, so this feels like a level high.
> I'm hopelessly confused :-(

Here's what your system looks like:

PCI-EP -------> MSI Controller ------> INTC
         MSI                    IRQ

A PCI MSI is always edge. No ifs, no buts. That's what it is, and nothing
else. Now, your MSI controller signals its output using a level interrupt,
since you need to whack it on the head so that it lowers its line.

There is not a single trigger, because there is not a single interrupt.

>>>>> +	mutex_lock(&pcie->lock);
>>>>> +
>>>>> +	mask = readl_relaxed(pcie->msi_mask);
>>>>
>>>> Do you really need to read this from the HW each time you allocate an
>>>> interrupt? That feels pretty crazy. You're much better off having an
>>>> in-memory bitmap that will make things more efficient [...]
> 
> I have one remaining issue with bitmaps.
> 
> My HW regs are 32b. How do I grab e.g. bits 96-127?
> All I can think of is
>   u32 val = ((u32 *)bitmap)[3];
> 
> Is this acceptable?

No.

> 
> mrutland mentioned bitmap_to_u32array() but IIUC it is used to
> copy an entire bitmap.

The real question is "Why do you need such a thing?".

> 
> 
>>>>> +	if (pos < MSI_COUNT)
>>>>> +		writel(mask | BIT(pos), pcie->msi_mask);
>>>>
>>>> And it would make a lot more sense to move this write (which should be
>>>> relaxed) to irq_unmask. Also, calling msi_mask for something that is an
>>>> enable register is a bit counter intuitive.
>>>
>>> I don't have as much experience as you.
>>> I just used the names in the HW documentation.
>>> I think it is the "mask" (as in bitmap) of enabled MSIs.
>>> I will change "mask" to "enable".
>>>
>>> Are you saying I should not use pci_msi_mask_irq and pci_msi_unmask_irq,
>>> but register custom implementations? I should still call these in my
>>> custom functions, right?
>>
>> You can call both in your own mask/unmask methods. They serve different
>> purpose (one is at the endpoint level, the other is at the MSI
>> controller level).
> 
> So, if I understand correctly, I should check for an available MSIs
> using the in-memory bitmap in tango_irq_domain_alloc(), but I would
> defer actually enabling the MSI until irq_unmask?

Yes.

> I think work on bitmap and on the underlying HW regs need to be
> protected under the same spinlock, correct?

Yes.

> 
> 
>>> Note: I don't have an "interrupt-map" prop because rev1 doesn't support
>>> legacy PCI interrupts (INTx). But I see the PCI framework wrongly mapping
>>> intA to my system's interrupt #1, presumably because I am lacking an
>>> interrupt-map?
>>
>> Probably. I don't think it is legal not to have an interrupt-map.
> 
> My understanding is that the interrupt-map actually specifies how to
> map the legacy IRQs. My platform does not support legacy IRQs; maybe
> there is some binding to say that? Maybe this is more a question for
> the PCI folks.

Probably. But it looks to me that a a PCIe RC that doesn't support legacy
interrupts is not a correct implementation. We can probably work around it,
but that feels pretty wrong.

	M.
-- 
Jazz is not dead. It just smells funny...
