Return-Path: <SRS0=qGEF=3E=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=qGEF=3E=arm.com=marc.zyngier@kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
To: Mason <slash.tmp@free.fr>
Cc: Bjorn Helgaas <helgaas@kernel.org>,  Thomas Gleixner <tglx@linutronix.de>,  Robin Murphy <robin.murphy@arm.com>,  Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,  Liviu Dudau <liviu.dudau@arm.com>,  David Laight <david.laight@aculab.com>,  linux-pci <linux-pci@vger.kernel.org>,  Linux ARM <linux-arm-kernel@lists.infradead.org>,  Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,  Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,  LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v0.2] PCI: Add support for tango PCIe host bridge
In-Reply-To: <cc958b0c-b947-2b3f-9e4b-9216e0085e6e@free.fr> (Mason's message
	of "Mon, 27 Mar 2017 21:44:08 +0200")
References: <91db1f47-3024-9712-309a-fb4b21e42028@free.fr>
	<e5c0bace-fcbe-de3f-b76f-0fb672562e84@arm.com>
	<310db9dd-7db6-2106-2e53-f0083b2d3758@free.fr>
	<012f7fcb-eaeb-70dd-a1a9-06c213789d30@arm.com>
	<0502e180-5517-12d6-e3a1-bcea0da7e201@free.fr>
	<4edd799a-650c-0189-cd5c-e9fc18c5f8bc@arm.com>
	<cc958b0c-b947-2b3f-9e4b-9216e0085e6e@free.fr>
Date: Mon, 27 Mar 2017 22:07:14 +0100
Message-ID: <8637dyo2d9.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 27 2017 at 08:44:08 PM, Mason <slash.tmp@free.fr> wrote:
> On 27/03/2017 19:09, Marc Zyngier wrote:
>
>> On 27/03/17 16:53, Mason wrote:
>> 
>>> I have one remaining issue with bitmaps.
>>>
>>> My HW regs are 32b. How do I grab e.g. bits 96-127?
>>> All I can think of is
>>>   u32 val = ((u32 *)bitmap)[3];
>>> 
>>> Is this acceptable?
>> 
>> No.
>> 
>>> mrutland mentioned bitmap_to_u32array() but IIUC it is used to
>>> copy an entire bitmap.
>> 
>> The real question is "Why do you need such a thing?".
>
> You told me to use an in-memory version of the "unmasked"
> bitmap, yes? In that case, I need to be able to grab
> a piece of said bitmap, to update the corresponding piece
> of the HW bitmap.
>
> For example, assume the first 3 MSIs are unmasked,
> in other words, unmasked = 0x7
>
> A new user comes along and wants to assign an MSI.
> Scan "unmasked", found bit at pos 3.
> Update "unmasked" to 0xf.
> At some point, I need to write 0xf to some HW reg.
> So I need to grab a piece of "unmasked" (bits 0-31 in my example)
>
>   pos = find_first_zero_bit(unmasked, COUNT);
>   __set_bit(pos, unmasked);
>   int reg_index = pos / 32;
>   u32 val = ((u32 *)unmasked)[reg_index];
>   writel_relaxed(val, pcie->enabled + reg_index * 4);
>
> Or did I miss something in your suggestion?

I don't know, I'm sightly taken aback by your question. Completely
puzzled, actually. "Read Modify Write" is a fairly obvious construct.

     val = readl_relaxed(pcie->enabled + reg_index);
     writel_relaxed(val | BIT(pos % 32), pcie->enabled + reg_index);

I never realized this could be such a novel concept. Replace pos with
hwirq, add a spinlock, and that's your irq_unmask.

My suggestion was to use a bitmap in order not to perform extra MMIO
accesses on the fast path. It doesn't mean that you cannot read from the
register under any circumstances. It just means that you don't do it
when there are more efficient ways to do it.

	M.
-- 
Jazz is not dead. It just smells funny.
