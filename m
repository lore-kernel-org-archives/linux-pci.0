Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:51385 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965122Ab3DHU5s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Apr 2013 16:57:48 -0400
Date: Mon, 8 Apr 2013 22:57:41 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCHv7 08/17] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130408225741.74fc383c@skate>
In-Reply-To: <CAErSpo7fGPe3wFha36kNMxeRP4gBpBWgfw85aTLey-DSz2ZYew@mail.gmail.com>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1364395234-11195-9-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAErSpo7fGPe3wFha36kNMxeRP4gBpBWgfw85aTLey-DSz2ZYew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn Helgaas,

On Mon, 8 Apr 2013 14:29:59 -0600, Bjorn Helgaas wrote:

> > Signed-off-by: Thomas Petazzoni
> > <thomas.petazzoni@free-electrons.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> A few trivial comments below; it's up to you whether you do anything
> with them or not.  It's OK with me if you ignore them :)
> 
> The only thing I saw that might be a bug is the resource_size()
> question in mvebu_pcie_probe().

Thanks for the review!

> > diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> > new file mode 100644
> > index 0000000..3ad563f
> > --- /dev/null
> > +++ b/drivers/pci/host/Makefile
> > @@ -0,0 +1,4 @@
> > +obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
> > +CFLAGS_pci-mvebu.o += \
> > +       -I$(srctree)/arch/arm/plat-orion/include \
> > +       -I$(srctree)/arch/arm/mach-mvebu/include
> 
> Too bad to have to adjust CFLAGS here.  Seems like I remember earlier
> discussion, but I didn't pay much attention, and if this is the best
> we can do, I guess it's OK.

Ah, indeed! This is now longer needed. The plat-orion include was
needed to get access to some PCIe functions, which are now part of the
driver, and the mach-mvebu header was needed to access some address
decoding window related functions, that are now part of the mvebu-mbus
driver.

> > +#define PCIE_BAR_CTRL_OFF(n)   (0x1804 + ((n - 1) * 4))
> 
> Strictly speaking, I suppose you should have "(((n) - 1) ..." here.

Correct, thanks.

> > +#define PCIE_STAT_OFF          0x1a04
> > +#define  PCIE_STAT_DEV_OFFS            20
> > +#define  PCIE_STAT_DEV_MASK            0x1f
> > +#define  PCIE_STAT_BUS_OFFS            8
> > +#define  PCIE_STAT_BUS_MASK            0xff
> > +#define  PCIE_STAT_LINK_DOWN           1
> 
> Whoever wrote pci_regs.h came up with a style I kind of like: the bit
> masks are already shifted so you can see where they are in the value,
> and there are no #defines for the shifts, e.g.,
> 
> #define PCI_EXP_FLAGS_TYPE      0x00f0  /* Device/Port type */
> 
> The users of PCI_EXP_FLAGS_TYPE just have a bare ">> 4" where
> necessary.  It seems like a good compromise that uses only one symbol
> (good for grepping), gives good visual indication in the header file
> of how the value is laid out, allows clearing bits without shifts, and
> clearly shows what's happening at the uses.
> 
> But what you have is OK, too :)

Hum, ok, I'll try to think of it. Maybe too much of a 'big' change at
this point, but I'll see.

> > +static int mvebu_pcie_link_up(void __iomem *base)
> 
> This could return bool, I guess.

Indeed.

> I think I would make
> 
>   mvebu_pcie_link_up()
>   mvebu_pcie_set_local_bus_nr()
>   mvebu_pcie_setup_wins()
>   mvebu_pcie_setup_hw()
>   mvebu_pcie_hw_rd_conf()
>   mvebu_pcie_hw_wr_conf()
> 
> all take a "struct mvebu_pcie_port *port" directly rather than having
> the caller pass in "port->base", but maybe you have a reason for doing
> otherwise.

I'll review this, I think your suggestion makes sense.

> > +       /*
> > +        * First, disable and clear BARs and windows.
> > +        */
> 
> Typically single-line comments would be "/* ... */" all on one line.

Correct.

> > +       for (i = 1; i <= 2; i++) {
> 
> Interesting use of "i <= 2" rather than the typical "i < 3".

I must confess this code comes from plat-orion/pcie.c, and I just
copy/pasted it (note: we intentionally don't use plat-orion/pcie.c to
avoid having to have to include a header in plat-orion/include, and
this plat-orion/pcie.c should ultimately go away once all Marvell EBU
platforms are migrated to use the new PCIe driver).

> > +       /*
> > +        * Enable interrupt lines A-D.
> > +        */
> > +       mask = readl(base + PCIE_MASK_OFF);
> > +       mask |= 0x0f000000;
> 
> No #defines for these bits?

Good point.

> > +       writel(mask, base + PCIE_MASK_OFF);
> > +}
> > +
> > +static int mvebu_pcie_hw_rd_conf(void __iomem *base, struct
> > pci_bus *bus,
> > +                                u32 devfn, int where, int size,
> > u32 *val) +{
> > +       writel(PCIE_CONF_BUS(bus->number) |
> > +               PCIE_CONF_DEV(PCI_SLOT(devfn)) |
> > +               PCIE_CONF_FUNC(PCI_FUNC(devfn)) |
> > +               PCIE_CONF_REG(where) | PCIE_CONF_ADDR_EN,
> 
> A "PCIE_CONF_ADDR(busnr, devfn, where)" macro would be nice here.

Right.

> > +static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port
> > *port) +{
> > +       phys_addr_t iobase;
> > +
> > +       /* Are the current iobase/iolimit values invalid? */
> 
> I first thought "current ... values" meant "the values before the
> change."  If you used "new values" it might be clearer that this is
> used to handle *writes* to the window base/size registers, and that
> we're looking at the values being written.

Ok, makes sense indeed.

> > +               return mvebu_sw_pci_bridge_write(port, where, size,
> > val);
> > +       }
> > +
> > +       return PCIBIOS_SUCCESSFUL;
> 
> This last "return" is unreachable (I see you omitted it from the
> rd_conf() path already :)).  This would be slightly simpler as:
> 
>   static struct mvebu_pcie_port *mvebu_find_port(struct mvebu_pcie
> *pcie, struct pci_bus *bus, int devfn)
>   {
>     int i;
> 
>     for (i = 0; i < pcie->nports; i++) {
>       if ((bus->number == 0 && pcie->ports[i].devfn == devfn) ||
>           (pcie->ports[porti].bridge.secondary_bus == bus->number))
>         return &pcie->ports[i];
>     }
>     return NULL;
>   }
> 
>   static int mvebu_pcie_wr_conf(struct pci_bus *bus, ...)
>   {
>     port = mvebu_find_port(pcie, bus, devfn);
>     if (!port)
>       return PCIBIOS_DEVICE_NOT_FOUND;
> 
>     if (bus->number == 0)
>       return mvebu_sw_pci_bridge_write(port, where, size, val);
> 
>     if (!port->haslink || PCI_SLOT(devfn) != 0)
>       return PCIBIOS_DEVICE_NOT_FOUND;
> 
>     ...
>     return ret;
>   }

Ok, I'll have a look at this.

> > IORESOURCE_TYPE_BITS;
> > +               if (restype == IORESOURCE_IO) {
> > +                       of_pci_range_to_resource(&range, np,
> > &pcie->io);
> > +                       of_pci_range_to_resource(&range, np,
> > &pcie->realio);
> > +                       pcie->io.name = "I/O";
> > +                       pcie->realio.start = PCIBIOS_MIN_IO;
> > +                       pcie->realio.end =
> > min(resource_size(&pcie->io),
> > +                                              IO_SPACE_LIMIT);
> 
> Using "resource_size(&pcie->io)" here seems strange -- are you
> assuming that pcie->io starts at address zero?

No, I'm assuming PCIBIOS_MIN_IO is always 0. So presumarly, this should
be something like:

	pcie->realio.end = min(PCIBIOS_MIN_IO +
				resource_size(&pcie->io),
				IO_SPACE_LIMIT);


Thanks for all your valuable comments!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
