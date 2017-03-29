Return-Path: <SRS0=7U76=3G=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=7U76=3G=free.fr=slash.tmp@kernel.org>
Subject: Re: [PATCH v3 1/2] PCI: Add tango MSI controller support
To: Marc Zyngier <marc.zyngier@arm.com>,
 Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>, DT <devicetree@vger.kernel.org>
References: <5309e718-5813-5b79-db57-9d702b50d0f9@sigmadesigns.com>
 <f37d7b55-e065-72aa-e690-13dd4718a9ce@sigmadesigns.com>
 <a12a79fd-94f9-5aa4-5aa0-5dccb6c5d615@arm.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <0541e62a-c87a-2e69-a7d1-28f886ad04c2@free.fr>
Date: Wed, 29 Mar 2017 15:16:59 +0200
MIME-Version: 1.0
In-Reply-To: <a12a79fd-94f9-5aa4-5aa0-5dccb6c5d615@arm.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 29/03/2017 14:29, Marc Zyngier wrote:

> On 29/03/17 12:29, Marc Gonzalez wrote:
>
>> The MSI controller in Tango supports 256 message-signaled interrupts,
>> and a single doorbell address.
>>
>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>> ---
>> Changes since v0.2
>> - Support 256 MSIs instead of only 32
>> - Use spinlock_t instead of struct mutex
>> - Add MSI_FLAG_PCI_MSIX flag
>>
>> IRQs are acked in tango_msi_isr because handle_simple_irq leaves
>> ack, clear, mask and unmask up to the driver. For the same reason,
>> interrupt enable mask is updated from tango_irq_domain_alloc/free.
> 
> I've asked you to move this to individual methods. You've decided not
> to, and that's your call. But I now wonder why I'm even bothering to
> review this, as you've so far just wasted my time.

I misunderstood what you wrote. When you pointed out the comment at
the top of handle_simple_irq (which I mentioned in my above blurb)
I took that to mean that I had to follow those instructions.

Judging by what you wrote below, I must replace handle_simple_irq
with handle_edge_irq, which will call the irq_chip callbacks.

But I don't understand how to get my pcie pointer back in irq_ack
or irq_unmask, or the relevant msi. Can you throw me a clue?

>> +static struct irq_chip tango_msi_irq_chip = {
>> +	.name = "MSI",
>> +	.irq_mask = pci_msi_mask_irq,
>> +	.irq_unmask = pci_msi_unmask_irq,
> 
> How do you make that work if the PCI device doesn't support per-MSI masking?

It seems you're saying this code is broken. Is it functional
in the Altera driver, and I did something to break it?

>> +static int find_free_msi(struct irq_domain *dom, unsigned int virq)
>> +{
>> +	u32 val;
>> +	struct tango_pcie *pcie = dom->host_data;
>> +	unsigned int offset, pos;
>> +
>> +	pos = find_first_zero_bit(pcie->bitmap, MSI_MAX);
>> +	if (pos >= MSI_MAX)
>> +		return -ENOSPC;
>> +
>> +	offset = (pos / 32) * 4;
>> +	val = readl_relaxed(pcie->msi_mask + offset);
>> +	writel_relaxed(val | BIT(pos % 32), pcie->msi_mask + offset);
> 
> Great. I'm now in a position where I can take an interrupt (because of
> the broken locking that doesn't disable interrupts), but the bitmap
> doesn't indicate it yet. With a bit of luck, I'll never make any forward
> progress.

Is this the Yoda way to say:
"Hey moron, use spin_lock_irqsave instead of spin_lock"?

>> +	irq_domain_set_info(dom, virq, pos, &tango_msi_chip,
>> +			dom->host_data, handle_simple_irq, NULL, NULL);
> 
> I've told you a number of times that PCI MSIs are edge triggered...

I will register handle_edge_irq.

> So there is not much progress from the previous version. It is just
> broken in a different ways, and ignores most of the work that is already
> done in the irqchip core.

I wish nothing more than to be able to use as much infrastructure
as possible, in order to write as little code as possible.

Regards.
