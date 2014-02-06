Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:60326 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932303AbaBFI3X (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Feb 2014 03:29:23 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
Date: Thu, 6 Feb 2014 09:28:52 +0100
Cc: linux-arm-kernel@lists.infradead.org,
	Will Deacon <will.deacon@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"mohit.kumar@st.com" <mohit.kumar@st.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com> <3724624.kd9jZNUiTF@wuerfel> <20140205205319.GH25695@obsidianresearch.com>
In-Reply-To: <20140205205319.GH25695@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201402060928.53310.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 05 February 2014, Jason Gunthorpe wrote:
> On Wed, Feb 05, 2014 at 09:26:17PM +0100, Arnd Bergmann wrote:
> > > > What you get out of "of_pci_range_to_resource(&range, np, &pci->io)"
> > > > is not the resource you want to pass into pci_add_resource()
> > > > later.
> 
> Right, of_pci_range_to_resource returns the CPU MMIO address. A big
> problem here is that struct resource is being re-used for bus
> physical, CPU MMIO, and Linux Driver addressing domains without any
> helpful tagging.
> 
> typedef struct resource resource_bus;
> typedef struct resource resource_cpu;
> 
> ?

I fear the resource management needs a bigger overhaul than than.
Most importantly, 'struct resource' is not connected to 'struct device'
at the moment, and it only deals with resource types that were around
15 years ago.

> > > Do I need to open-code the resource translation from phys -> logical?
> > 
> > I think we should have some common infrastructure that lets you
> > get this right more easily.
> 
> The offset stuff seems to be very confusing to people, removing it
> from the APIs and forcing drivers to talk about bus addresess, CPU
> addresses and internal Linux addresses seems a bit more plain?

Interesting idea. I'm not sure how Bjorn will like that
after he just did an overhaul of all users of the offset
API some time ago, but let's see what he thinks.

> What do you think about something like this:
> 
> int of_pci_alloc_io(.. resources,
>                     struct of_pci_range *range,
>                     struct device_node *np)
> {
>   struct resource bus_address, mmio_window, res;
> 
>   bus_address.start = range->pci_addr;
>   bus_address.end = range->pci_addr + range->size - 1;
> 
>   mmio_window.start = range->cpu_addr;
>   mmio_window.end = range->cpu_addr + range->size - 1;
> 
>   /* Input bus_address - addresses seen on the bus
>            mmio_window - physical CPU address to create the bus
> 	   	         addreses
>      Output res - Address suitable for use in drivers
>      This does the pci_ioremap_io too */
>   pci_alloc_virtual_io_window(&bus_address, &mmio_window, &res);
> 
>   /* bus_address - addresses seen on the bus
>      res - matching driver view for the bus addresses */
>   pci_add_resource_bus(&resources, &bus_address, &res);
> }
> 
> And a similar function for MMIO that just omits
> pci_alloc_virtual_io_window.

It certainly seems workable. OTOH if we just manage to do a
helper that scans the OF ranges, allocates the I/O window,
remaps it and calls the existing pci_add_resource_offset()
helper, PCI host drivers don't need to worry about the
io_offsets computation either and just need to pull out the
correct window locations if they need to set up the hardware
translation windows (which I'd hope we can often let the boot
loader take care of).

	Arnd
