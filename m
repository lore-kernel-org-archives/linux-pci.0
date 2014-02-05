Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:59143 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754709AbaBEUx1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 5 Feb 2014 15:53:27 -0500
Date: Wed, 5 Feb 2014 13:53:19 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Will Deacon <will.deacon@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"mohit.kumar@st.com" <mohit.kumar@st.com>
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
Message-ID: <20140205205319.GH25695@obsidianresearch.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <3460536.Sh23gjDa6X@wuerfel>
 <20140205190947.GA22297@mudshark.cambridge.arm.com>
 <3724624.kd9jZNUiTF@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3724624.kd9jZNUiTF@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 05, 2014 at 09:26:17PM +0100, Arnd Bergmann wrote:
> > > What you get out of "of_pci_range_to_resource(&range, np, &pci->io)"
> > > is not the resource you want to pass into pci_add_resource()
> > > later.

Right, of_pci_range_to_resource returns the CPU MMIO address. A big
problem here is that struct resource is being re-used for bus
physical, CPU MMIO, and Linux Driver addressing domains without any
helpful tagging.

typedef struct resource resource_bus;
typedef struct resource resource_cpu;

?

> > Do I need to open-code the resource translation from phys -> logical?
> 
> I think we should have some common infrastructure that lets you
> get this right more easily.

The offset stuff seems to be very confusing to people, removing it
from the APIs and forcing drivers to talk about bus addresess, CPU
addresses and internal Linux addresses seems a bit more plain?

What do you think about something like this:

int of_pci_alloc_io(.. resources,
                    struct of_pci_range *range,
                    struct device_node *np)
{
  struct resource bus_address, mmio_window, res;

  bus_address.start = range->pci_addr;
  bus_address.end = range->pci_addr + range->size - 1;

  mmio_window.start = range->cpu_addr;
  mmio_window.end = range->cpu_addr + range->size - 1;

  /* Input bus_address - addresses seen on the bus
           mmio_window - physical CPU address to create the bus
	   	         addreses
     Output res - Address suitable for use in drivers
     This does the pci_ioremap_io too */
  pci_alloc_virtual_io_window(&bus_address, &mmio_window, &res);

  /* bus_address - addresses seen on the bus
     res - matching driver view for the bus addresses */
  pci_add_resource_bus(&resources, &bus_address, &res);
}

And a similar function for MMIO that just omits
pci_alloc_virtual_io_window.

Jason
