Return-Path: <SRS0=m2ui=3E=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=m2ui=3E=free.fr=slash.tmp@kernel.org>
Subject: Re: [RFC PATCH v0.2] PCI: Add support for tango PCIe host bridge
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Robin Murphy <robin.murphy@arm.com>,
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
 <cc958b0c-b947-2b3f-9e4b-9216e0085e6e@free.fr> <8637dyo2d9.fsf@arm.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <b180c091-e4a4-7f58-7378-e0f3a24e44d6@free.fr>
Date: Tue, 28 Mar 2017 00:04:38 +0200
MIME-Version: 1.0
In-Reply-To: <8637dyo2d9.fsf@arm.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 27/03/2017 23:07, Marc Zyngier wrote:

> On Mon, Mar 27 2017 at 08:44:08 PM, Mason wrote:
>
>> On 27/03/2017 19:09, Marc Zyngier wrote:
>>
>>> On 27/03/17 16:53, Mason wrote:
>>>
>>>> I have one remaining issue with bitmaps.
>>>>
>>>> My HW regs are 32b. How do I grab e.g. bits 96-127?
>>>> All I can think of is
>>>>   u32 val = ((u32 *)bitmap)[3];
>>>>
>>>> Is this acceptable?
>>>
>>> No.
>>>
>>>> mrutland mentioned bitmap_to_u32array() but IIUC it is used to
>>>> copy an entire bitmap.
>>>
>>> The real question is "Why do you need such a thing?".
>>
>> You told me to use an in-memory version of the "unmasked"
>> bitmap, yes? In that case, I need to be able to grab
>> a piece of said bitmap, to update the corresponding piece
>> of the HW bitmap.
>>
>> For example, assume the first 3 MSIs are unmasked,
>> in other words, unmasked = 0x7
>>
>> A new user comes along and wants to assign an MSI.
>> Scan "unmasked", found bit at pos 3.
>> Update "unmasked" to 0xf.
>> At some point, I need to write 0xf to some HW reg.
>> So I need to grab a piece of "unmasked" (bits 0-31 in my example)
>>
>>   pos = find_first_zero_bit(unmasked, COUNT);
>>   __set_bit(pos, unmasked);
>>   int reg_index = pos / 32;
>>   u32 val = ((u32 *)unmasked)[reg_index];
>>   writel_relaxed(val, pcie->enabled + reg_index * 4);
>>
>> Or did I miss something in your suggestion?
> 
> I don't know, I'm sightly taken aback by your question. Completely
> puzzled, actually. "Read Modify Write" is a fairly obvious construct.
> 
>      val = readl_relaxed(pcie->enabled + reg_index);
>      writel_relaxed(val | BIT(pos % 32), pcie->enabled + reg_index);
> 
> I never realized this could be such a novel concept. Replace pos with
> hwirq, add a spinlock, and that's your irq_unmask.

I'm not sure why you would think I'm not familiar with RMW.

My original code was:

	mask = readl_relaxed(pcie->msi_mask);
	pos = find_first_zero_bit(&mask, 32);
	writel(mask | BIT(pos), pcie->msi_mask);

To which you replied:
"Do you really need to read this from the HW each time you allocate an
interrupt? That feels pretty crazy. You're much better off having an
in-memory bitmap that will make things more efficient"

This is why I was trying to avoid a MMIO read from the HW
each time I allocate an interrupt.

> My suggestion was to use a bitmap in order not to perform extra MMIO
> accesses on the fast path. It doesn't mean that you cannot read from the
> register under any circumstances. It just means that you don't do it
> when there are more efficient ways to do it.

The fast path is the interrupt handler, right?
(I didn't read the interrupt mask in the ISR.)

I understand your underlying point. It is fine to read
from MMIO in the slow path, but try as hard as possible
NOT to do so in the fast path.

Regards.
