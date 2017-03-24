Return-Path: <SRS0=v3pA=3B=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=v3pA=3B=arm.com=marc.zyngier@kernel.org>
Subject: Re: [RFC PATCH v0.2] PCI: Add support for tango PCIe host bridge
To: Mason <slash.tmp@free.fr>, Bjorn Helgaas <helgaas@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <91db1f47-3024-9712-309a-fb4b21e42028@free.fr>
 <e5c0bace-fcbe-de3f-b76f-0fb672562e84@arm.com>
 <310db9dd-7db6-2106-2e53-f0083b2d3758@free.fr>
 <9fffedd4-6292-b662-a588-a68fe7380af6@free.fr>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <6e847686-43c6-11e9-6782-dec0fe81a58e@arm.com>
Date: Fri, 24 Mar 2017 18:22:17 +0000
MIME-Version: 1.0
In-Reply-To: <9fffedd4-6292-b662-a588-a68fe7380af6@free.fr>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 23/03/17 23:40, Mason wrote:
> On 23/03/2017 18:03, Mason wrote:
> 
>> The host bridge actually supports 256 MSIs.
>>
>> IIUC, what you suggested on IRC is that I support 256 in the driver,
>> and only read the status for *enabled* MSIs.
>>
>> Pseudo-code:
>>
>> for every 32-bit blob in the enabled bitmap
>>   if the value is non-zero
>>     lookup the corresponding status reg
>>
>> Problem is that a BITMAP is unsigned long (as you point out below).
>> So I'm not sure how to iterate 32-bits at a time over the BITMAP.
> 
> Something along these lines:
> 
> 	DECLARE_BITMAP(enabled, 256);
> 
> 	unsigned int pos = 0;
> 
> 	while ((pos = find_next_bit(enabled, 256, pos)) < 256) {
> 		int offset = (pos / 32) * 4;
> 		u32 status = readl_relaxed(status + offset);
> 		/* Handle each pos set in status */
> 		pos = round_up(pos, 32);
> 	}

Something along those lines, yes.

> You mentioned a bug in my code (due to the platform endianness)
> when passing the result of readl_relaxed to the bitops routine...
> How is one supposed to iterate over status?

You cannot directly use a pointer to a u32 in any of the bitmap
operations. You need to copy the value to an unsigned long, and apply
the bitmap op on that.

> I'm not yet seeing this endianness issue, since (status & BIT(i))
> provides the status of MSI_i, irrespective of endianness.

We discussed this over IRC, but I was referring to the above case and
64bit BE platforms, which would not do what you expect.

> Although I see that arch/arm/include/asm/bitops.h declares
> BE and LE variants... I'm confused.

Nothing in this code should be ARM specific. The kernel gives you the
tools to write (mostly) architecture, endianness and word size agnostic
code.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
