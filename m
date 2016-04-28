Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 28 Apr 2016 10:45:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>, arnd@arndb.de,
	will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
	hanjun.guo@linaro.org, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com
Subject: Re: [PATCH V6 05/13] acpi, pci: Support IO resources when parsing
 PCI host bridge resources.
Message-ID: <20160428154517.GC15598@localhost>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-6-git-send-email-tn@semihalf.com>
 <20160427023916.GF6789@localhost>
 <20160427141429.GA7324@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160427141429.GA7324@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 27, 2016 at 03:26:59PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Apr 26, 2016 at 09:39:16PM -0500, Bjorn Helgaas wrote:
> > On Fri, Apr 15, 2016 at 07:06:40PM +0200, Tomasz Nowicki wrote:
> > > Platforms that have memory mapped IO port (such as ARM64) need special
> > > handling for PCI I/O resources. For host bridge's resource probing case
> > > these resources need to be fixed up with pci_register_io_range/pci_remap_iospace etc.
> > 
> > ia64 also has memory-mapped I/O port space.  It would be ideal to find
> > some way to handle ia64 and ARM64 similarly.  At the very least, we
> > have to make sure that this doesn't break ia64.  The ia64 dense/sparse
> > I/O spaces complicate things; I don't know if ARM64 has something
> > similar or not.
> 
> No it does not, and that's exactly the same problem we faced with
> the DT generic version of of_pci_range_to_resource() which basically
> relies on PCI_IOBASE to be defined to add code that creates IO port
> resources out of the MMIO resource describing how IO port space is
> mapped to MMIO (physical) address space.

Mapping IO port space into MMIO space is pretty common since most
arches don't have inb/outb instructions like x86 does.  Several arches
(at least ia64 and parisc) have some sort of sparse mapping, but my
point is that the "dense" mapping (one byte MMIO space per IO port) is
pretty similar across arches.

There are differences in how we compute the MMIO address from the IO
port number, of course, e.g., on arm64 the CPU virtual MMIO address is
a simple offset from the IO port number, i.e., "vaddr = PCI_IOBASE +
res->start" in pci_remap_iospace(), while on ia64, that CPU address is
less constrained, i.e., "vaddr = space->mmio_base | port" in
__ia64_mk_io_addr().

> IIRC everything hinges on PCI_IOBASE definition to make sure that
> of_pci_range_to_resource() *works*, which means that if PCI_IOBASE is
> not defined (ie IA64) that code - acpi_pci_root_remap_iospace() in this
> case - does nothing.

OK.  That's confusing to read, but I see that it probably works.

> So acpi_pci_root_remap_iospace() is of_pci_range_to_resource() ACPI
> equivalent + the pci_remap_iospace() call (I have to dig into the
> logs to check why Liviu did not add a call to pci_remap_iospace()
> in of_pci_get_host_bridge_resources() - I want to do that actually).
> 
> The point here is: IO space (in DT and ACPI) handling is arch specific.
> 
> For DT, by relying on PCI_IOBASE, we left that code in drivers/of and
> it works (well, with some niggles - see the thread with Murali on IO
> space on TI keystone) for ARM/ARM64.
> 
> http://www.spinics.net/lists/linux-pci/msg49725.html
> 
> What are we going to do with the ACPI version ?
> 
> Do we want to add an arch specific call that takes the raw resource
> describing IO space and creates an IO port resource (and the MMIO
> equivalent - that's what add_io_space() does in IA64) and use that
> in generic ACPI parsing code ?

There's a lot of non-arch-specific stuff here, which is what's
bothering me.  The arch-specific parts are:

  - discovering IO port region (bus address start and size)
  - discovering MMIO mapping address and size (CPU "mem" resource)
  - discovering or assigning IO port base (CPU "io" resource)
  - setting up whatever structures arch uses to implement inb()

Once you have the CPU "mem" and "io" resources, the code to insert
them into iomem_resource and ioport_resource and ioremap() the MMIO
space should be pretty generic.  Right now that code is scattered
through the arches and most of them don't do it correctly, e.g.,
typically they don't request the "mem" resource.
