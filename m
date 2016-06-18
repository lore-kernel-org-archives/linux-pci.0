Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56352 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458AbcFRR6u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 18 Jun 2016 13:58:50 -0400
Date: Sat, 18 Jun 2016 12:58:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	linux-kernel@vger.kernel.org, rfi@lists.rocketboards.org,
	linux-renesas-soc@vger.kernel.org,
	Simon Horman <horms@verge.net.au>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tanmay Inamdar <tinamdar@apm.com>, Ray Jui <rjui@broadcom.com>,
	linux-tegra@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
	Michal Simek <michal.simek@xilinx.com>,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v1 00/25] PCI: Request host bridge window resources
Message-ID: <20160618175845.GA20504@localhost>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <3416214.BpvATlfaN7@wuerfel>
 <20160607131105.GA2543@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160607131105.GA2543@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 07, 2016 at 08:11:05AM -0500, Bjorn Helgaas wrote:
> On Tue, Jun 07, 2016 at 10:21:36AM +0200, Arnd Bergmann wrote:
> > On Monday, June 6, 2016 6:04:44 PM CEST Bjorn Helgaas wrote:
> > > Several host bridge drivers (designware and all derivatives, iproc,
> > > xgene, xilinx, and xilinx-nwl) don't request the MMIO and I/O port
> > > windows they forward downstream to the PCI bus.
> > > 
> > > That means the PCI core can't request resources for PCI bridge
> > > windows and PCI BARs.
> > > 
> > > Several other drivers (altera, generic, mvebu, rcar, tegra) do request
> > > the windows, but use some duplicated code to do it.
> > > 
> > > This adds a new devm_request_pci_bus_resources() interface and changes
> > > these drivers to use it.  It also fixes several error paths where we failed
> > > to free the resource list allocated by of_pci_get_host_bridge_resources().
> > > 
> > > Tegra guys, please take a look at "PCI: tegra: Remove top-level resource
> > > from hierarchy" in particular.  Removing the top-level resource definitely
> > > makes /proc/iomem look uglier (although it will look more like that of
> > > other drivers).  A short-term fix could be to include device information in
> > > the resource name.  I think a better long-term fix would be to make the DT
> > > or platform device core request all the resources from the DT.
> > > 
> > > Comments welcome.  I expect we'll trip over something here, so I marked
> > > this "v1" and I don't plan to put it into -next for a while.
> > > 
> > > This is on my pci/host-request-windows branch, which you can pull or view
> > > at https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-request-windows
> > 
> > This looks very nice. There is one related aspect that I have been
> > grumbling about for a while, but I don't know what the driver is
> > actually supposed to do there:
> > 
> > For the IORESOURCE_IO resources, some drivers request the MMIO address
> > that the window is mapped into, some drivers request the PIO range, and
> > some of them request both. I also believe the resource that gets put
> > into the bridge resources list is not always the same one (or maybe
> > that got fixed by now).
> > 
> > What do you think is the correct behavior here, should the driver only
> > request the PIO range with parent=ioport_resource, or should it also
> > request the MMIO window for the I/O ports with parent=iomem_resource?
> > In the latter case, any idea how that can be generalized?
> 
> I think it should request both because I think iomem_resource should
> contain everything in the memory map.  This would be required if we ever
> did any significant reassignment of top-level devices, e.g., ACPI devices.
> For example, on ia64, we do this:
> 
>   /proc/ioports:
>   00000000-00003fff : PCI Bus 0000:00
>   00004000-00009fff : PCI Bus 0000:80
>   0000a000-0000bfff : PCI Bus 0000:a0
>   0000c000-0000ffff : PCI Bus 0000:c0
> 
>   /proc/iomem:
>   80000000-9fffffff : PCI Bus 0000:00
>   a0000000-cfffffff : PCI Bus 0000:80
>   d0000000-dfffffff : PCI Bus 0000:a0
>   e0000000-fdffffff : PCI Bus 0000:c0
>   80004000000-80103fffffe : PCI Bus 0000:00
>   c0004000000-c0103fffffe : PCI Bus 0000:80
>   d0004000000-d0103fffffe : PCI Bus 0000:a0
>   e0004000000-e0103fffffe : PCI Bus 0000:c0
>   3fffffc000000-3fffffcffffff : PCI Bus 0000:00 I/O Ports 00000000-00003fff
>   3fffffd000000-3fffffe7fffff : PCI Bus 0000:80 I/O Ports 00004000-00009fff
>   3fffffe800000-3fffffeffffff : PCI Bus 0000:a0 I/O Ports 0000a000-0000bfff
>   3ffffff000000-3ffffffffffff : PCI Bus 0000:c0 I/O Ports 0000c000-0000ffff
> 
> > Another aspect is that we already have the
> > gen_pci_parse_request_of_pci_ranges() function that does the same as your
> > new devm_request_pci_bus_resources() and then a few other things. I
> > have been wondering whether we could move that function into common
> > code convert drivers to use that wherever possible, but I guess we can
> > always do that as a follow-up after this series.
> 
> Oh, I didn't notice that; thanks for pointing it out.  That should be
> consolidated somehow.  It also checks to be sure there is a
> non-prefetchable memory resource.  A few other drivers also do that, but
> most don't.  I suppose that will mostly catch DT errors.

Coming back to this, I did actually change
gen_pci_parse_request_of_pci_ranges() to call my new function in
[16/25] "PCI: generic: Request host bridge window resources with core
function".

The gen_pci_parse_request_of_pci_ranges() is still there and it still
contains the loop to deal with the I/O port space and to validate that
a non-prefetchable memory window exists.  Both of those could probably
be made more generic later.

Bjorn
