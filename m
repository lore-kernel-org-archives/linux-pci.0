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
 <bc5bf8ad-69ef-4f14-f450-e162ddb5af7c@arm.com>
 <241b130e-1fb7-ecd4-034e-eb02065ada66@free.fr>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <37cd6172-b04e-fcad-18fc-4fbb26cc611b@arm.com>
Date: Wed, 12 Apr 2017 10:59:13 +0100
MIME-Version: 1.0
In-Reply-To: <241b130e-1fb7-ecd4-034e-eb02065ada66@free.fr>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 12/04/17 10:50, Mason wrote:
> On 12/04/2017 10:08, Marc Zyngier wrote:
> 
>> On 11/04/17 18:52, Mason wrote:
>>
>>> so data->irq is the virq (30, 34, 35, 36)
>>> and data->hwirq is the domain hwirq (0, 524288, 524289, 524290)
>>>
>>> Is there a way to map hwirq 524288 to MSI 0, hwirq 524289 to MSI 1, etc?
>>
>> Why would you need to do such a thing?
>> - In MSI domain: IRQ34 -> hwirq 524288
>> - In foo domain: IRQ34 -> hwirq [whatever your driver has allocated]
>>
>> The data is already there, at your fingertips. Just deal with with your
>> "foo" irqchip.
> 
> OK, let me take a step back, I may have missed the forest for
> the trees.
> 
> In my original code (copied from the Altera driver) I unmasked
> a given MSI in the tango_irq_domain_alloc() function. You said
> this was the wrong place, as it should be done in the irqchip
> unmask callback. Did I understand correctly, so far?

Yes.

> I have registered custom mask/unmask callbacks for both irq_chips.

And that's *wrong*. I've repeatedly said that you only need to deal with
*your* irqchip. End of story. Nowhere else. Please leave the MSI irqchip
alone, it is very unlikely that you have to provide anything at all to it.

	M.
-- 
Jazz is not dead. It just smells funny...
