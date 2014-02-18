Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:41928 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753350AbaBRSAP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 18 Feb 2014 13:00:15 -0500
Date: Tue, 18 Feb 2014 11:00:05 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Will Deacon <will.deacon@arm.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/3] ARM: PCI: implement generic PCI host controller
Message-ID: <20140218180005.GD29304@obsidianresearch.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <20140213182655.GE17248@obsidianresearch.com>
 <1800297.J3Exeqph4n@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1800297.J3Exeqph4n@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 14, 2014 at 12:05:27PM +0100, Arnd Bergmann wrote:

> >  2) The space in the IO fixed mapping needs to be allocated to PCI
> >     host drivers dynamically
> >     * pci_ioremap_io_dynamic that takes a bus address + cpu_physical
> >       address and returns a Linux virtual address.
> >       The first caller can get a nice traslation where bus address ==
> >       Linux virtual address, everyone after can get best efforts.
> 
> I think we can have a helper that everything we need to do
> with the I/O space:
> 
> * parse the ranges property
> * pick an appropriate virtual address window
> * ioremap the physical window there
> * compute the io_offset
> * pick a name for the resource
> * request the io resource
> * register the pci_host_bridge_window

Sounds good to me

> > You will have overlapping physical IO bus addresses - each domain will
> > have a 0 IO BAR - but those will have distinct CPU physical addresses
> > and can then be uniquely mapped into the IO mapping. So at the struct
> > resource level the two domains have disjoint IO addresses, but each
> > domain uses a different IO offset..
> 
> This would be the common case, but when we have a generic helper function,
> it's actually not that are to handle a couple of variations of that,
> which we may see in the field and can easily be described with the
> existing binding.

I agree the DT binding ranges has enough flexibility to describe all
of these cases, but I kind of circle back to the domain discussion and
ask 'Why?'. 

As far as I can see there are two reasonable ways to handle IO space:
 - The IO space is 1:1 mapped to the Physical CPU Address. In most
   cases this would require 32 bit IO BARS in all devices.
 - The IO space in a domain is always 0 -> 64k and thus only ever
   requires 16 bit BARs

And this is possible too:
 - The IO space is 1:1: mapped to Linux Virtual IO port numbers
   (which are a fiction) and devices sometimes require 32 bit
   IO BARs. This gives you lspci output that matches dmesg and
   /proc/ioport.

Things get more complex if you want to support legacy non-BAR IO (eg
VGA). Then you *really* want every domain to support 0->64k and you
need driver support to setup a window for the legacy IO port. (eg on a
multi-port root complex there is non-PCI spec hardware that routes the
VGA addresses to the root port bridge that connects to the VGA card)
Plus you probably need a memory hole around 1M..

But, I think this is overthinking things. IO space really is
deprecated, and 0->64k is a fine default for everything but very
specialized cases.

Jason
