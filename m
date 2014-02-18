Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:63592 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbaBRSl2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2014 13:41:28 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 0/3] ARM: PCI: implement generic PCI host controller
Date: Tue, 18 Feb 2014 19:40:51 +0100
Message-ID: <3296233.1sYEW4ig2k@wuerfel>
In-Reply-To: <20140218180005.GD29304@obsidianresearch.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com> <1800297.J3Exeqph4n@wuerfel> <20140218180005.GD29304@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 18 February 2014 11:00:05 Jason Gunthorpe wrote:
> 
> > > You will have overlapping physical IO bus addresses - each domain will
> > > have a 0 IO BAR - but those will have distinct CPU physical addresses
> > > and can then be uniquely mapped into the IO mapping. So at the struct
> > > resource level the two domains have disjoint IO addresses, but each
> > > domain uses a different IO offset..
> > 
> > This would be the common case, but when we have a generic helper function,
> > it's actually not that are to handle a couple of variations of that,
> > which we may see in the field and can easily be described with the
> > existing binding.
> 
> I agree the DT binding ranges has enough flexibility to describe all
> of these cases, but I kind of circle back to the domain discussion and
> ask 'Why?'. 
> 
> As far as I can see there are two reasonable ways to handle IO space:
>  - The IO space is 1:1 mapped to the Physical CPU Address. In most
>    cases this would require 32 bit IO BARS in all devices.

I wouldn't consider this one reasonable ;-)

In particular, it would break /dev/port access horribly.

>  - The IO space in a domain is always 0 -> 64k and thus only ever
>    requires 16 bit BARs
> 
> And this is possible too:
>  - The IO space is 1:1: mapped to Linux Virtual IO port numbers
>    (which are a fiction) and devices sometimes require 32 bit
>    IO BARs. This gives you lspci output that matches dmesg and
>    /proc/ioport.

These two seem fine.

> Things get more complex if you want to support legacy non-BAR IO (eg
> VGA). Then you *really* want every domain to support 0->64k and you
> need driver support to setup a window for the legacy IO port. (eg on a
> multi-port root complex there is non-PCI spec hardware that routes the
> VGA addresses to the root port bridge that connects to the VGA card)
> Plus you probably need a memory hole around 1M..

For the I/O space part of this, that would be the same as your second
example above. For memory space, you need both the 640k-1M window and
the 15M-16M window. We have a couple of ARM platforms that actually
have a PCI MMIO window starting at bus address 0 with a mem_offset
matching the physical base address to facilitate VGA access,
try 'git grep -w vga_base'.

> But, I think this is overthinking things. IO space really is
> deprecated, and 0->64k is a fine default for everything but very
> specialized cases.

We may not need the entire complexity to handle all cases, but
I think it's a good idea to detect the ones we don't handle and
then warn about them. For some things, just doing it right may be
easier than detecting the case where we don't.

	Arnd
