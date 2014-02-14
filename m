Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55720 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbaBNLFj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Feb 2014 06:05:39 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Will Deacon <will.deacon@arm.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/3] ARM: PCI: implement generic PCI host controller
Date: Fri, 14 Feb 2014 12:05:27 +0100
Message-ID: <1800297.J3Exeqph4n@wuerfel>
In-Reply-To: <20140213182655.GE17248@obsidianresearch.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com> <20140213182655.GE17248@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 13 February 2014 11:26:55 Jason Gunthorpe wrote:
> The DT representation is very straightforward, just have more copies
> of what you already have. Each DT stanza should be represented in
> Linux a distinct PCI domain.
> 
> In Linux you run into two small problems
>  1) PCI Domain numbers needs to be allocated dynamically
>     * I think there should be a core thing to allocate a domain
>       object w/ a struct device, and assign a unique domain number.
>       We are already seeing drivers do things like keep track
>       of their own domain numbers via a counter (pcie-designware.c)
>       The host bridge object is similar to this but it isn't focused
>       on a domain.

Right, see also my other comment I just sent in the "Re: [PATCH v2 3/3]
PCI: ARM: add support for generic PCI host controller" thread.

The host driver is the wrong place to pick a domain number, but someone
has to do it.

>  2) The space in the IO fixed mapping needs to be allocated to PCI
>     host drivers dynamically
>     * pci_ioremap_io_dynamic that takes a bus address + cpu_physical
>       address and returns a Linux virtual address.
>       The first caller can get a nice traslation where bus address ==
>       Linux virtual address, everyone after can get best efforts.

I think we can have a helper that everything we need to do
with the I/O space:

* parse the ranges property
* pick an appropriate virtual address window
* ioremap the physical window there
* compute the io_offset
* pick a name for the resource
* request the io resource
* register the pci_host_bridge_window

> You will have overlapping physical IO bus addresses - each domain will
> have a 0 IO BAR - but those will have distinct CPU physical addresses
> and can then be uniquely mapped into the IO mapping. So at the struct
> resource level the two domains have disjoint IO addresses, but each
> domain uses a different IO offset..

This would be the common case, but when we have a generic helper function,
it's actually not that are to handle a couple of variations of that,
which we may see in the field and can easily be described with the
existing binding.

* If we allow multiple host bridges to be in the same PCI domain with
  a split bus space, we should also allow them to have a split I/O
  space, e.g. have two 32KB windows, both with io_offset=0. This would
  imply that the second bridge can only support relocatable I/O BARs.

* Similar to that, you may have multiple 64KB windows with io_offset=0.

* Some system may have hardwire I/O windows at a high bus address larger
  than IO_SPACE_LIMIT. This would mean a *negative* io_offset. I can't
  see any reason why anyone would do this, but I also don't see a reason
  to prevent it if we can easily keep the code generic enough to handle
  it without adding extra code.

* A more obscure case would be to have multiple I/O windows on a bus.
  This is allowed by the binding and by the pci_host_bridge_window,
  and while again I don't see a use case, it also doesn't seem hard
  to do, we just keep looping for all ranges rather than stop after
  the first window.

	Arnd
