Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:58187 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547AbcFGIoh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jun 2016 04:44:37 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
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
	=?ISO-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v1 00/25] PCI: Request host bridge window resources
Date: Tue, 07 Jun 2016 10:21:36 +0200
Message-ID: <3416214.BpvATlfaN7@wuerfel>
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, June 6, 2016 6:04:44 PM CEST Bjorn Helgaas wrote:
> Several host bridge drivers (designware and all derivatives, iproc,
> xgene, xilinx, and xilinx-nwl) don't request the MMIO and I/O port
> windows they forward downstream to the PCI bus.
> 
> That means the PCI core can't request resources for PCI bridge
> windows and PCI BARs.
> 
> Several other drivers (altera, generic, mvebu, rcar, tegra) do request
> the windows, but use some duplicated code to do it.
> 
> This adds a new devm_request_pci_bus_resources() interface and changes
> these drivers to use it.  It also fixes several error paths where we failed
> to free the resource list allocated by of_pci_get_host_bridge_resources().
> 
> Tegra guys, please take a look at "PCI: tegra: Remove top-level resource
> from hierarchy" in particular.  Removing the top-level resource definitely
> makes /proc/iomem look uglier (although it will look more like that of
> other drivers).  A short-term fix could be to include device information in
> the resource name.  I think a better long-term fix would be to make the DT
> or platform device core request all the resources from the DT.
> 
> Comments welcome.  I expect we'll trip over something here, so I marked
> this "v1" and I don't plan to put it into -next for a while.
> 
> This is on my pci/host-request-windows branch, which you can pull or view
> at https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-request-windows

This looks very nice. There is one related aspect that I have been
grumbling about for a while, but I don't know what the driver is
actually supposed to do there:

For the IORESOURCE_IO resources, some drivers request the MMIO address
that the window is mapped into, some drivers request the PIO range, and
some of them request both. I also believe the resource that gets put
into the bridge resources list is not always the same one (or maybe
that got fixed by now).

What do you think is the correct behavior here, should the driver only
request the PIO range with parent=ioport_resource, or should it also
request the MMIO window for the I/O ports with parent=iomem_resource?
In the latter case, any idea how that can be generalized?

Another aspect is that we already have the
gen_pci_parse_request_of_pci_ranges() function that does the same as your
new devm_request_pci_bus_resources() and then a few other things. I
have been wondering whether we could move that function into common
code convert drivers to use that wherever possible, but I guess we can
always do that as a follow-up after this series.

	Arnd

