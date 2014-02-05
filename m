Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:45975 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750994AbaBETKS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Feb 2014 14:10:18 -0500
Date: Wed, 5 Feb 2014 19:09:47 +0000
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"mohit.kumar@st.com" <mohit.kumar@st.com>
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
Message-ID: <20140205190947.GA22297@mudshark.cambridge.arm.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <1391532784-1953-3-git-send-email-will.deacon@arm.com>
 <3460536.Sh23gjDa6X@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3460536.Sh23gjDa6X@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

Thanks for having a look.

On Tue, Feb 04, 2014 at 07:13:49PM +0000, Arnd Bergmann wrote:
> On Tuesday 04 February 2014 16:53:03 Will Deacon wrote:
> > +
> > +- ranges         : As described in IEEE Std 1275-1994, but must provide
> > +                   at least a definition of the Configuration Space plus
> > +                   one or both of IO and Memory Space.
> > +
> 
> I might need to reread the spec, but I think the config space is not
> actually supposed to be in the 'ranges' of the host bridge at all,
> and it should just be listed in the 'reg'.

This wasn't at all clear to me (I listed it in the cover-letter as being
something to sort out).

> IIRC the reason why the config space is part of the three-cell address
> is so that you can have funky ways to say "memory space of the device
> with bus/dev/fn is actually translated to address X rather then Y".
> 
> It's too late to change that for the other drivers now, after the
> binding is established.

The spec is based on the idea that open-firmware enumerates your entire PCI
bus topology, then provides the Conriguation Space address for each device
using a reg property.

Since:

  (a) This doesn't match what we're planning to support
  (b) Runs the risk of making the "reg" encoding something specific to this
      driver
  (c) Doesn't match how we describe Memory and IO Spaces
  (d) There is already precendence in mainline

I chose to use "ranges" instead.

Now, if "reg" is definitely the correct thing to do, is it simply a matter
of putting the Configuration Space base address in there, or do we also need
to do the rest of what ePAPR says (expansion ROM details, ...)? I don't like
the idea of enumerating the entire bus in the DT when we don't need to.

> > +Configuration Space is assumed to be memory-mapped (as opposed to being
> > +accessed via an ioport) and laid out with a direct correspondence to the
> > +geography of a PCI bus address, by concatenating the various components
> > +to form a 24-bit offset:
> > +
> > +        cfg_offset(bus, device, function, register) =
> > +                bus << 16 | device << 11 | function << 8 | register
> 
> This won't allow extended config space. Why not just do the
> regular mmconfig layout and make this:
> 
> 	cfg_offset(bus, device, function, register) =
> 		bus << 20 | device << 15 | function << 12 | register;

Is it worth adding a DT property to support both, or is ECAM the only thing
to care about? I'm happy either way, although I'll need to hack kvmtool to
use the new scheme.

> > +static int virt_pci_setup(int nr, struct pci_sys_data *sys)
> > +{
> > +	struct virt_pci *pci = sys->private_data;
> > +
> > +	if (resource_type(&pci->io)) {
> > +		pci_add_resource(&sys->resources, &pci->io);
> > +		pci_ioremap_io(nr * resource_size(&pci->io), pci->io.start);
> > +	}
> 
> This should really compute an io_offset.
> 
> > +	if (resource_type(&pci->mem))
> > +		pci_add_resource(&sys->resources, &pci->mem);
> 
> and also a mem_offset, which is something different.

As somebody new to PCI, I'm afraid you've lost me here. Are you referring to
using pci_add_resource_offset instead, then removing my restriction on
having a single resource from the parsing code?

> > +	pci->cfg_base = devm_ioremap_resource(pci->dev, &pci->cfg);
> > +	return !IS_ERR(pci->cfg_base);
> > +}
> > +
> > +static const struct of_device_id virt_pci_of_match[] = {
> > +	{ .compatible = "linux,pci-virt" },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, virt_pci_of_match);
> 
> I don't think we even want "virt" in the compatible string. The
> binding should be generic enough that it can actually work with
> real hardware.

Sure. How about "arm,pci-generic" ? Alternatives are
"arm,pcie-generic" or "linux,pci-generic".

> > +	for_each_of_pci_range(&parser, &range) {
> > +		u32 restype = range.flags & IORESOURCE_TYPE_BITS;
> > +
> > +		switch (restype) {
> > +		case IORESOURCE_IO:
> > +			if (resource_type(&pci->io))
> > +				dev_warn(dev,
> > +					 "ignoring additional io resource\n");
> > +			else
> > +				of_pci_range_to_resource(&range, np, &pci->io);
> > +			break;
> > +		case IORESOURCE_MEM:
> > +			if (resource_type(&pci->mem))
> > +				dev_warn(dev,
> > +					 "ignoring additional mem resource\n");
> > +			else
> > +				of_pci_range_to_resource(&range, np, &pci->mem);
> > +			break;
> 
> This shows once more that the range parser code is suboptimal. So far
> every single driver got the I/O space wrong here, because the obvious
> way to write this function is also completely wrong.

I see you mentioned to Liviu that you should register a logical resource,
rather than physical resource returned from the parser. It seems odd that
I/O space appears to work with this code as-is (I've tested it on arm using
kvmtool by removing the memory bars).

> What you get out of "of_pci_range_to_resource(&range, np, &pci->io)"
> is not the resource you want to pass into pci_add_resource()
> later.

Do I need to open-code the resource translation from phys -> logical?

> 
> > +	memset(&hw, 0, sizeof(hw));
> > +	hw.nr_controllers	= 1;
> > +	hw.private_data		= (void **)&pci;
> > +	hw.setup		= virt_pci_setup;
> > +	hw.map_irq		= of_irq_parse_and_map_pci;
> > +	hw.ops			= &virt_pci_ops;
> > +	pci_common_init_dev(dev, &hw);
> 
> Since most fields here are constant, I'd just write this as
> 
> 	struct hw_pci hw = {
> 		.nr_controllers = 1,
> 		.setup = virt_pci_setup,
> 		...
> 	};

Can do.

Thanks,

Will
