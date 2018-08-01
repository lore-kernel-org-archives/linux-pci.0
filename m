Return-Path: <SRS0=dvAb=KQ=bootlin.com=thomas.petazzoni@kernel.org>
Return-Path: <SRS0=dvAb=KQ=bootlin.com=thomas.petazzoni@kernel.org>
Date: Wed, 1 Aug 2018 10:49:57 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org, Russell King
 <linux@arm.linux.org.uk>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, Victor
 Gu <xigu@marvell.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@bootlin.com>, Zachary Zhang <zhangzg@marvell.com>, Wilson
 Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org, Ray Jui
 <ray.jui@broadcom.com>, Ley Foon Tan <lftan@altera.com>, Simon Horman
 <horms@verge.net.au>
Subject: Re: [PATCH 1/3] PCI: Introduce PCI software bridge common logic
Message-ID: <20180801104957.1b01b847@windsurf>
In-Reply-To: <20180712195802.GC28466@bhelgaas-glaptop.roam.corp.google.com>
References: <20180629092231.32207-1-thomas.petazzoni@bootlin.com>
	<20180629092231.32207-2-thomas.petazzoni@bootlin.com>
	<20180712195802.GC28466@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

Thanks for your review!

On Thu, 12 Jul 2018 14:58:02 -0500, Bjorn Helgaas wrote:

> > The idea of this logic is to emulate a root port PCI bridge by
> > providing configuration space read/write operations, and faking behind
> > the scenes the configuration space of a PCI bridge. A PCI host
> > controller driver simply has to call pci_sw_bridge_read() and
> > pci_sw_bridge_write() to read/write the configuration space of the
> > bridge.  
> 
> These systems must actually have a Root Port (there's obviously a Port
> that originates the link), but it's not visible in a spec-compliant
> way.  So this is basically a wrapper that translates accesses to
> standard config space into the vendor-specific registers.

Correct.

> Since there really *is* a hardware bridge but it just doesn't have the
> interface we expect, "sw_bridge" doesn't feel like quite the right
> name for it.  Maybe something related to adapter/emulation/interface/...?

sw_adapter ? sw_adap ?

> There are several drivers that do this, and it would be really cool to
> have them all do it in a similar way.  I found at least these:
> 
>   hv_pcifront_read_config()

This one indeed looks potentially a bit similar.

>   mvebu_pcie_rd_conf()

This one is converted by my patch series.

>   thunder_ecam_config_read()

This one I'm not sure what is happening,

>   thunder_pem_config_read()

For this one, it seems like the HW exposes a config space, just that it
is bogus. It is a bit of a different situation. It could be handled by
the same sw_bridge/sw_adapt stuff, but it's a slightly different use
case than "the HW doesn't expose any spec-compliant root port config
space".

>   xgene_pcie_config_read32()

I don't see why this one would need sw_bridge/sw_adap.

>   iproc_pcie_config_read32()

Not sure about this one either.

>   rcar_pcie_read_conf()

Perhaps it needs sw_bridge/sw_adap.

Really for all those ones, it would require some involvement from the
corresponding driver maintainers, who understand better their HW and
see if they would benefit from sw_bridge/sw_adap.

> I *really* like the fact that your accessors use the normal register
> names, e.g., PCI_EXP_DEVCAP instead of PCISWCAP_EXP_DEVCAP.  That's
> huge for greppability.

Thanks. There's however one down-side: I had to add separate accessors
for reading/writing the main PCI config space and the PCIe capability
config space. Any additional capability config space would require
adding another pair of accessors. But I really wanted to re-use the
existing PCI_EXP_* definitions. Another approach is perhaps to pass an
"ID" of the config space being accessed, i.e 0x0 for the main config
space, and PCI_CAP_ID_EXP for PCI express.

So instead of 4 accessors in pci_sw_bridge_ops, we would have only two:

pci_sw_bridge_read_status_t (*read)(struct pci_sw_bridge *bridge,
				    int id, int reg, u32 *value);
void (*write)(struct pci_sw_bridge *bridge, int id, int reg,
              u32 old, u32 new, u32 mask);

where "id" would allow the accessor to know if we're accessing the main
config space, or the PCI express capability config space.

How does that sound ?

> > By default, the PCI bridge configuration space is simply emulated by a
> > chunk of memory, but the PCI host controller can override the behavior
> > of the read and write operations on a per-register basis to do
> > additional actions if needed.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > ---
> >  drivers/pci/Kconfig           |   3 +
> >  drivers/pci/Makefile          |   1 +
> >  drivers/pci/pci-sw-bridge.c   | 149 ++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci-sw-bridge.h | 125 +++++++++++++++++++++++++++++++++++  
> 
> Could this go in drivers/pci instead of include/linux?  I'd prefer to
> hide it inside the PCI core if that's possible.

Sure, I'll fix that.

> > + * Should be called by the PCI controller driver when reading the PCI
> > + * configuration space of the fake bridge. It will call back the
> > + * ->ops->read_base or ->ops->read_pcie operations.
> > + */
> > +int pci_sw_bridge_read(struct pci_sw_bridge *bridge, int where,
> > +		       int size, u32 *value)  
> 
> We don't really have a strong convention about the names of config
> accessors: *_rd_conf(), *_read_config(), *config_read() are all used.
> Maybe we could at least include "conf" to connect this with config
> space as opposed to MMIO space.

No problem, I'll fix that, makes perfect sense.

> > +	if (bridge->has_pcie && reg >= PCI_CAP_PCIE_START) {
> > +		reg -= PCI_CAP_PCIE_START;
> > +
> > +		if (bridge->ops->read_pcie)
> > +			ret = bridge->ops->read_pcie(bridge, reg, value);
> > +		else
> > +			ret = PCI_SW_BRIDGE_NOT_HANDLED;
> > +
> > +		if (ret == PCI_SW_BRIDGE_NOT_HANDLED)
> > +			*value = *((u32*) &bridge->pcie_conf + reg / 4);
> > +	} else {
> > +		if (bridge->ops->read_base)
> > +			ret = bridge->ops->read_base(bridge, reg, value);
> > +		else
> > +			ret = PCI_SW_BRIDGE_NOT_HANDLED;
> > +
> > +		if (ret == PCI_SW_BRIDGE_NOT_HANDLED)
> > +			*value = *((u32*) &bridge->conf + reg / 4);  
> 
> I'm not sure about this part, where the config space that's not
> handled by the bridge's ops ends up just being RAM that's readable and
> writable with no effect on the hardware.  That seems a little
> counter-intuitive.  I think dropping writes and reading zeroes would
> simplify my mental model.

The fact that it is handled just like RAM is actually needed for a
number of registers. For example, in the current pci-mvebu driver, when
reading we have:

        case PCI_VENDOR_ID:
                *value = bridge->device << 16 | bridge->vendor;
                break;

        case PCI_COMMAND:
                *value = bridge->command | bridge->status << 16;
                break;

        case PCI_CLASS_REVISION:
                *value = bridge->class << 16 | bridge->interface << 8 |
                         bridge->revision;
                break;

        case PCI_CACHE_LINE_SIZE:
                *value = bridge->bist << 24 | bridge->header_type << 16 |
                         bridge->latency_timer << 8 | bridge->cache_line_size;
                break;

        case PCI_BASE_ADDRESS_0 ... PCI_BASE_ADDRESS_1:
                *value = bridge->bar[((where & ~3) - PCI_BASE_ADDRESS_0) / 4];
                break;

        case PCI_PRIMARY_BUS:
                *value = (bridge->secondary_latency_timer << 24 |
                          bridge->subordinate_bus         << 16 |
                          bridge->secondary_bus           <<  8 |
                          bridge->primary_bus);
                break;

        case PCI_IO_BASE:
                if (!mvebu_has_ioport(port))
                        *value = bridge->secondary_status << 16;
                else
                        *value = (bridge->secondary_status << 16 |
                                  bridge->iolimit          <<  8 |
                                  bridge->iobase);
                break;

We definitely cannot return zeroes for all these values.

And for writes, we have code like this:

        case PCI_BASE_ADDRESS_0 ... PCI_BASE_ADDRESS_1:
                bridge->bar[((where & ~3) - PCI_BASE_ADDRESS_0) / 4] = value;
                break;

        case PCI_IO_BASE:
                /*
                 * We also keep bit 1 set, it is a read-only bit that
                 * indicates we support 32 bits addressing for the
                 * I/O
                 */
                bridge->iobase = (value & 0xff) | PCI_IO_RANGE_TYPE_32;
                bridge->iolimit = ((value >> 8) & 0xff) | PCI_IO_RANGE_TYPE_32;
                mvebu_pcie_handle_iobase_change(port);
                break;

        case PCI_MEMORY_BASE:
                bridge->membase = value & 0xffff;
                bridge->memlimit = value >> 16;
                mvebu_pcie_handle_membase_change(port);
                break;

        case PCI_IO_BASE_UPPER16:
                bridge->iobaseupper = value & 0xffff;
                bridge->iolimitupper = value >> 16;
                mvebu_pcie_handle_iobase_change(port);
                break;

        case PCI_PRIMARY_BUS:
                bridge->primary_bus             = value & 0xff;
                bridge->secondary_bus           = (value >> 8) & 0xff;
                bridge->subordinate_bus         = (value >> 16) & 0xff;
                bridge->secondary_latency_timer = (value >> 24) & 0xff;
                mvebu_pcie_set_local_bus_nr(port, bridge->secondary_bus);
                break;

The writes being made to those parts of the config space are being
reflected back when reading the config space later.

> > +	if (size == 1)
> > +		*value = (*value >> (8 * (where & 3))) & 0xff;
> > +	else if (size == 2)
> > +		*value = (*value >> (8 * (where & 3))) & 0xffff;
> > +	else if (size != 4)
> > +		return PCIBIOS_BAD_REGISTER_NUMBER;  
> 
> This isn't directly related to your patches, but this is a common
> pattern with some variations between drivers, which makes me wonder
> whether there are bugs lurking.  These use "where & 3" for size 2:
> 
>   advk_pcie_rd_conf()
>   mtk_pcie_hw_rd_cfg()
>   pci_generic_config_read32()
> 
> But these use "where & 2":
> 
>   _altera_pcie_cfg_read()
>   rcar_pcie_read_conf()
> 
> I *think* this means that unaligned 2-byte config reads on Altera and
> R-Car will return incorrect data.  In both cases, the actual read seen
> by the hardware is a 32-bit read, but I think we extract the wrong 16
> bits from that result.

Indeed, if unaligned 2-byte config reads are made, they will return
bogus results. But are such reads allowed ?

> I wonder if there's a way to use a common helper function to do this.

Yes, this small bit of logic is duplicated all over the place. I'll see
if I can come up with some reasonable helpers for that.

> > +	return PCIBIOS_SUCCESSFUL;
> > +}  
> 
> > +	/*
> > +	 * Called when writing to the regular PCI bridge configuration
> > +	 * space. old is the current value, new is the new value being
> > +	 * written, and mask indicates which parts of the value are
> > +	 * being changed.
> > +	 */
> > +	void (*write_base)(struct pci_sw_bridge *bridge, int reg,
> > +			   u32 old, u32 new, u32 mask);
> > +
> > +	/*
> > +	 * Same as ->read_base(), except it is for reading from the
> > +	 * PCIe capability configuration space.  
> 
> I think you mean "->write_base(), except it is for writing to"

Indeed, yes. Will fix that.

So, to sum up, there are really three key questions:

 (1) Which name do you want for this ?

 (2) Agreeing on whether a RAM-like behavior is acceptable, and if not,
     which solution do you propose instead.

 (3) How much do you want me to convert other drivers vs. the
     maintainers for those drivers being responsible for doing this.

Since "There are only two hard things in Computer Science: cache
invalidation and naming things.", I expect question (1) to be the most
difficult one :-)

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
