Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:51826 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbaBEU0Y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Feb 2014 15:26:24 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"mohit.kumar@st.com" <mohit.kumar@st.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
Date: Wed, 05 Feb 2014 21:26:17 +0100
Message-ID: <3724624.kd9jZNUiTF@wuerfel>
In-Reply-To: <20140205190947.GA22297@mudshark.cambridge.arm.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com> <3460536.Sh23gjDa6X@wuerfel> <20140205190947.GA22297@mudshark.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 05 February 2014 19:09:47 Will Deacon wrote:

> On Tue, Feb 04, 2014 at 07:13:49PM +0000, Arnd Bergmann wrote:
> > On Tuesday 04 February 2014 16:53:03 Will Deacon wrote:
> Now, if "reg" is definitely the correct thing to do, is it simply a matter
> of putting the Configuration Space base address in there, or do we also need
> to do the rest of what ePAPR says (expansion ROM details, ...)? I don't like
> the idea of enumerating the entire bus in the DT when we don't need to.

You won't have to worry about the per-device stuff, aside from that,
do what Jason says ;-)
 
> > > +Configuration Space is assumed to be memory-mapped (as opposed to being
> > > +accessed via an ioport) and laid out with a direct correspondence to the
> > > +geography of a PCI bus address, by concatenating the various components
> > > +to form a 24-bit offset:
> > > +
> > > +        cfg_offset(bus, device, function, register) =
> > > +                bus << 16 | device << 11 | function << 8 | register
> > 
> > This won't allow extended config space. Why not just do the
> > regular mmconfig layout and make this:
> > 
> > 	cfg_offset(bus, device, function, register) =
> > 		bus << 20 | device << 15 | function << 12 | register;
> 
> Is it worth adding a DT property to support both, or is ECAM the only thing
> to care about? I'm happy either way, although I'll need to hack kvmtool to
> use the new scheme.

For any 64-bit system, ECAM is the only thing we need. On 32-bit
systems, we can't just map the entire config space though, since
that would require 256MB of vmalloc space. Ideally the driver is
smart enough to map only the space for the present buses (1MB
per bus), which I think is what x86 does, or one page per
PCI function that is present, but that can be tricky for hotplugging.

> > > +static int virt_pci_setup(int nr, struct pci_sys_data *sys)
> > > +{
> > > +	struct virt_pci *pci = sys->private_data;
> > > +
> > > +	if (resource_type(&pci->io)) {
> > > +		pci_add_resource(&sys->resources, &pci->io);
> > > +		pci_ioremap_io(nr * resource_size(&pci->io), pci->io.start);
> > > +	}
> > 
> > This should really compute an io_offset.
> > 
> > > +	if (resource_type(&pci->mem))
> > > +		pci_add_resource(&sys->resources, &pci->mem);
> > 
> > and also a mem_offset, which is something different.
> 
> As somebody new to PCI, I'm afraid you've lost me here. Are you referring to
> using pci_add_resource_offset instead, then removing my restriction on
> having a single resource from the parsing code?

I mean pci_add_resource_offset, but I don't understand what the
restriction is that you are talking about. To elaborate on the offsets,
the common case is that the PCI memory space is the same as the
host physical address space for both MMIO and DMA, while you have
only one PCI host with a single I/O space range from port 0 to 65536.

If you mandate that, your code is actually correct and you do not
require an io_offset or mem_offset.

In practice, there can be various ways that a system requires something
more complex:

* You can have a memory space range that puts PCI bus address zero
  at the start of the pci->mem resource. In this case, you have
  mem_offset = pci->mem.start. We should probably try not to do
  this, but there is existing hardware doing it.

* You might have multiple sections of the PCI bus space mapped
  into CPU physical space. If you want to support legacy VGA
  console, you probably want to map the first 16MB of the bus
  space at an arbitrary location (with the mem_offset as above),
  plus a second, larger section of the bus space with an identity
  mapping (mem_offset_= 0) for all devices other than VGA.
  You'd also need to copy some VGA specific code from arm32 to
  arm64 to actually make this work.

* If you have two PCI host bridges and each of them comes with
  its own I/O space range starting between 0x0-0xffff, you have
  to map one of them into logical I/O space address 0x10000-0x1ffff
  and set io_offset = 0x10000 for that bus.

* Alternatively, the second bus in that case can use *bus* I/O
  port address 0x10000-0x1ffff and use io_offset=0, but that
  prevents you from having legacy ISA I/O ports on the
  second bus, since they are hardwired to a known port number
  in the range 0x0-0x1000 (the first 4KB). This includes VGA
  console.

> > > +	for_each_of_pci_range(&parser, &range) {
> > > +		u32 restype = range.flags & IORESOURCE_TYPE_BITS;
> > > +
> > > +		switch (restype) {
> > > +		case IORESOURCE_IO:
> > > +			if (resource_type(&pci->io))
> > > +				dev_warn(dev,
> > > +					 "ignoring additional io resource\n");
> > > +			else
> > > +				of_pci_range_to_resource(&range, np, &pci->io);
> > > +			break;
> > > +		case IORESOURCE_MEM:
> > > +			if (resource_type(&pci->mem))
> > > +				dev_warn(dev,
> > > +					 "ignoring additional mem resource\n");
> > > +			else
> > > +				of_pci_range_to_resource(&range, np, &pci->mem);
> > > +			break;
> > 
> > This shows once more that the range parser code is suboptimal. So far
> > every single driver got the I/O space wrong here, because the obvious
> > way to write this function is also completely wrong.
> 
> I see you mentioned to Liviu that you should register a logical resource,
> rather than physical resource returned from the parser. It seems odd that
> I/O space appears to work with this code as-is (I've tested it on arm using
> kvmtool by removing the memory bars).

what do you see in /proc/ioports and /proc/iomem then?

> > What you get out of "of_pci_range_to_resource(&range, np, &pci->io)"
> > is not the resource you want to pass into pci_add_resource()
> > later.
> 
> Do I need to open-code the resource translation from phys -> logical?

I think we should have some common infrastructure that lets you
get this right more easily.

	Arnd
