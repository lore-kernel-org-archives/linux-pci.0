Return-Path: <arnd@arndb.de>
Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Jingoo Han <jingoohan1@gmail.com>, Pratyush Anand <pratyush.anand@gmail.com>, linux-kernel@vger.kernel.org, rfi@lists.rocketboards.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>, Ray Jui <rjui@broadcom.com>, linux-tegra@vger.kernel.org, Ley Foon Tan <lftan@altera.com>, Michal Simek <michal.simek@xilinx.com>, =?ISO-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v1 00/25] PCI: Request host bridge window resources
Date: Tue, 07 Jun 2016 15:25:46 +0200
Message-ID: <3552943.lb56sJA8nL@wuerfel>
In-Reply-To: <20160607131105.GA2543@localhost>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com> <3416214.BpvATlfaN7@wuerfel> <20160607131105.GA2543@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, June 7, 2016 8:11:05 AM CEST Bjorn Helgaas wrote:
> > 
> > What do you think is the correct behavior here, should the driver only
> > request the PIO range with parent=ioport_resource, or should it also
> > request the MMIO window for the I/O ports with parent=iomem_resource?
> > In the latter case, any idea how that can be generalized?
> 
> I think it should request both because I think iomem_resource should
> contain everything in the memory map.  This would be required if we ever
> did any significant reassignment of top-level devices, e.g., ACPI devices.

Ok. Should we try to pass the mmio resource for the I/O window to
the devm_request_pci_bus_resources() function along with the other
arguments then?

As far as I can tell, it should not go into the resource list
because it is not something the PCI core code should access the
way it handles the other resources.

	Arnd
