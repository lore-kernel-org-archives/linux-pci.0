Return-Path: <SRS0=kzs2=DF=assembler.cz=r.marek@kernel.org>
Return-Path: <SRS0=kzs2=DF=assembler.cz=r.marek@kernel.org>
Subject: Re: PCI VGA 0x3b0/0x3C0 aliases handling in Linux
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, RayeR <rayer@seznam.cz>, mj@ucw.cz
References: <098b7b02-90f8-636e-37b8-665c32aab96e@assembler.cz>
 <20171205190755.GB23510@bhelgaas-glaptop.roam.corp.google.com>
 <0a488e5b-d954-b2bc-0089-6c0542b8c571@assembler.cz>
 <20171206184314.GK23510@bhelgaas-glaptop.roam.corp.google.com>
From: Rudolf Marek <r.marek@assembler.cz>
Message-ID: <565cfb46-6327-8a18-19d2-9f884661b0eb@assembler.cz>
Date: Sat, 9 Dec 2017 20:40:13 +0100
MIME-Version: 1.0
In-Reply-To: <20171206184314.GK23510@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=iso-8859-2
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Thanks for the nice summary.

Dne 6.12.2017 v 19:43 Bjorn Helgaas napsal(a):
>> Yes exactly. Question is why the insanity alias exists in the first place. 
>> What Mr. PCI tried to fix or break with that alias design?
>> Besides making logic simpler, I have no idea.
> 
> I think this 10-bit aliasing is a compatibility feature for ISA.
> 

I looked it up in the "PCI System Architecture (4th Edition)" the whole
madness exists because there were legacy ISA drivers accessing the hardware
using the alias addresses. The same reason applies for the ISA enable bit 
on PCI bridge, where it will discards ISA accesses from primary side to 
allow the aliases propagate only to PCI/ISA bridge.

>> drivers/pci or platform/hardware?
> 
> drivers/pci
> 

OK I created  bug report available on [1], also using parts of your mails. I also tried
to summarize:

The Linux should do following:

Turn on VGA_16BIT_EN if supported by the bridge

If VGA_16BIT_EN is not supported by the bridge, try to reassign
the peer I/O BAR so it doesn't conflict with the 0x3b0-0x3df
aliases

The older PCI specs specifies the VGA_16BIT_EN as read as zero, so
it could be safe to try to turn it on all bridges, because maybe
the VGA arbiter can later switch another VGA card as primary

(I fixed the start of alias to 0x3b0 you had 0x3c0 in your mails).

It looks that:

/*
 * We don't have to worry about legacy ISA devices, so nothing to do here.
 * This is marked as __weak because multiple architectures define it; it should
 * eventually go away.
 */
resource_size_t __weak pcibios_align_resource(void *data,

Comment is not true, the aliasing problem exists on all architectures.

Thanks
Rudolf

[1] https://bugzilla.kernel.org/show_bug.cgi?id=198113
