Return-Path: <SRS0=7ibK=3T=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=7ibK=3T=free.fr=slash.tmp@kernel.org>
Subject: Re: [RFC PATCH v0.2] PCI: Add support for tango PCIe host bridge
To: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <91db1f47-3024-9712-309a-fb4b21e42028@free.fr>
 <e5c0bace-fcbe-de3f-b76f-0fb672562e84@arm.com>
 <310db9dd-7db6-2106-2e53-f0083b2d3758@free.fr>
 <012f7fcb-eaeb-70dd-a1a9-06c213789d30@arm.com>
 <0502e180-5517-12d6-e3a1-bcea0da7e201@free.fr>
 <4edd799a-650c-0189-cd5c-e9fc18c5f8bc@arm.com>
 <30f662a6-5dab-515b-e35a-a312f3c7b509@free.fr>
 <5f81730d-fbe3-1f4c-de34-09bbfb893ee1@arm.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <2b5eef4c-32f2-54f1-ca2f-f9426e68fb2c@free.fr>
Date: Tue, 11 Apr 2017 18:26:23 +0200
MIME-Version: 1.0
In-Reply-To: <5f81730d-fbe3-1f4c-de34-09bbfb893ee1@arm.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 11/04/2017 17:49, Marc Zyngier wrote:
> On 11/04/17 16:13, Mason wrote:
>> On 27/03/2017 19:09, Marc Zyngier wrote:
>>
>>> Here's what your system looks like:
>>>
>>> PCI-EP -------> MSI Controller ------> INTC
>>>          MSI                    IRQ
>>>
>>> A PCI MSI is always edge. No ifs, no buts. That's what it is, and nothing
>>> else. Now, your MSI controller signals its output using a level interrupt,
>>> since you need to whack it on the head so that it lowers its line.
>>>
>>> There is not a single trigger, because there is not a single interrupt.
>>
>> Hello Marc,
>>
>> I was hoping you or Thomas might help clear some confusion
>> in my mind around IRQ domains (struct irq_domain).
>>
>> I have read https://www.kernel.org/doc/Documentation/IRQ-domain.txt
>>
>> IIUC, there should be one IRQ domain per IRQ controller.
>>
>> I have this MSI controller handling 256 interrupts, so I should
>> have *one* domain for all possible MSIs. Yet the Altera driver
>> registers *two* domains (msi_domain and inner_domain).
>>
>> Could I make everything work with a single IRQ domain?
> 
> No, because you have two irqchips. One that deals with the HW, and the
> other that deals with the MSIs how they are presented to the kernel,
> depending on the bus (PCI or something else). The fact that it doesn't
> really drive any HW doesn't make it irrelevant.

The example given in IRQ-domain.txt is

  Device --> IOAPIC -> Interrupt remapping Controller -> Local APIC -> CPU

with an irq_domain for each interrupt controller.


On my system I have:

  PCI-EP -> MSI controller -> System INTC -> GIC -> CPU

The driver for System INTC is drivers/irqchip/irq-tango.c
I think it has only one domain.

For the GIC, drivers/irqchip/irq-gic.c
I see a call to irq_domain_create_linear()

Is the handling of MSI different, and that is why we need
two domains? (Sorry, I did not understand that part well.)

When I looked at drivers/pci/host/pci-hyperv.c
they seem to have a single pci_msi_create_irq_domain call,
no call to domain_add or domain_create.
And they have a single struct irq_chip.

> You don't need to tell it anything about the number of interrupts you
> manage. As for your private structure, you've already given it to your
> low level domain, and there is no need to propagate it any further.

My main issue is that in the ack callback, I was in the "wrong"
domain, in that d->hwirq was not the MSI number. So I thought
I needed a single irq_domain.

Is there a function to map virq to the hwirq in any domain?

Regards.
