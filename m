Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.medvecky.net ([85.118.132.146]:32874 "EHLO
        mail.medvecky.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752349AbdLEUfq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Dec 2017 15:35:46 -0500
Subject: Re: PCI VGA 0x3b0/0x3C0 aliases handling in Linux
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, RayeR <rayer@seznam.cz>, mj@ucw.cz
References: <098b7b02-90f8-636e-37b8-665c32aab96e@assembler.cz>
 <20171205190755.GB23510@bhelgaas-glaptop.roam.corp.google.com>
From: Rudolf Marek <r.marek@assembler.cz>
Message-ID: <0a488e5b-d954-b2bc-0089-6c0542b8c571@assembler.cz>
Date: Tue, 5 Dec 2017 21:35:22 +0100
MIME-Version: 1.0
In-Reply-To: <20171205190755.GB23510@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Thanks for the quick reply.

Dne 5.12.2017 v 20:07 Bjorn Helgaas napsal(a):
> So if I understand correctly, you have
> 
>   - A bridge with PCI_BRIDGE_CTL_VGA set but VGA_16BIT_EN is clear

Yes

> 
>   - A peer of the bridge with an I/O BAR set to some alias of
>     0x3c0-0x3df

It is not a peer bridge, but some other bridge on bus 0. The non-working device is
a Audigy PCI card (05:00.0)

The path is 00:1c.3 (Intel PCIe bridge) -> 4:00.0 (ITE PCIe-PCI bridge) -> 5:00.0 (audigy)
The other bridge is 00:01.0 which connects to some VGA on bus 1.

The Audigy has only one resource:

Region 0: I/O ports at cfc0 [size=32]

Which collides with the 0x3b0. We used "isadump -f" to verify we indeed see an alias.
Rayer booted to DOS, edited the BAR and loadlin back to Linux and the device works,
so it was that. Later he reported that setting the bit4 also fixed that.
>
> In this case I think both the bridge and the peer device will claim
> accesses to 0x3c0-0x3df, which is a bad thing.

Yes, the isadump -f confirmed that.

> 
> And your proposal is that Linux should either
> 
>   - Turn on VGA_16BIT_EN (if supported by the bridge), or
> 
>   - If VGA_16BIT_EN is not supported by the bridge, try to reassign
>     the peer I/O BAR so it doesn't conflict with the 0x3c0-0x3df
>     aliases

The Aliases are:

0x3B0 - 0x3BB  and 0x3C0 - 0x3DF and it seems that also VGA palette snoops 
and VGA palette snoops: 0x3C6, 0x3C8, 0x3C9 

It seems that the VGA_16BIT_EN could also control the palette snoops alias,
so in the end it should remove all aliases.
I hope someone access to more recent PCI bridge specs can confirm.

> If I'm understanding correctly, this sounds very reasonable.

Yes exactly. Question is why the insanity alias exists in the first place. 
What Mr. PCI tried to fix or break with that alias design?
Besides making logic simpler, I have no idea.

>> I suspect it will fix couple of problems people were seeing with old
>> PCI cards as they tend to have the I/O regions (I stumbled upon
>> various reports when was suspecting the PCIe to PCI ITE chip and
>> interrupt routing problems)
> 
> To help understand and document this better, it would be nice to see a
> complete dmesg log and "lspci -vv" output (as root) showing the
> problem.  A kernel.org bugzilla would be a good place to store this.

Yes sure, in what category

drivers/pci or platform/hardware?

> It would also be great to collect up the other reports you've found
> and see if we can definitively tie them to this issue and potentially
> test a fix.

Oh, hm, those were random searches using a search engine. I was talking about [1], 
but reading it again, all issues were interrupt related.

I'll try to reproduce my searches.

Btw, latest pciutils-3.5.6 also lack of decoding of the bit4. I added to Martin Mares to CC.

I can prepare a patch for PCIutils if needed. Martin, please tell.

Thanks
Rudolf

[1] https://bugzilla.kernel.org/show_bug.cgi?id=43238
