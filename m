Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:19657 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754662AbaD1KED convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 28 Apr 2014 06:04:03 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: RE: [PATCH v7 01/10] PCI: host: rcar: Add Renesas R-Car PCIe driver
Date: Mon, 28 Apr 2014 10:03:56 +0000
Message-ID: <9b8bedae9d604383ac7ec22fd0f62fdb@HKXPR06MB168.apcprd06.prod.outlook.com>
References: <1396261856-22465-1-git-send-email-phil.edworthy@renesas.com>
 <1396261856-22465-2-git-send-email-phil.edworthy@renesas.com>
 <20140424191901.GE29593@google.com>
In-Reply-To: <20140424191901.GE29593@google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Thanks for the review.

On 24 April 2014 20:19, Bjorn wrote:
> On Mon, Mar 31, 2014 at 11:30:46AM +0100, Phil Edworthy wrote:
> > This PCIe Host driver currently does not support MSI, so cards
> > fall back to INTx interrupts.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ...
> 
> > --- /dev/null
> > +++ b/drivers/pci/host/pcie-rcar.c
> > @@ -0,0 +1,693 @@
> > ...
> > +#include <linux/slab.h>
> > +#include "pcie-rcar.h"
> 
> It looks like the things in pcie-rcar.h are used only in this file
> (pcie-rcar.c), so you might as well just put the contents here and not have
> a pcie-rcar.h at all.  Of course, if there are things needed by more than
> one file, they should stay in pcie-rcar.h.
Nothing else uses them so I'll put in the c file.

> > +#define DRV_NAME "rcar-pcie"
> > +
> > +#define RCONF(x)	(PCICONF(0)+(x))
> > +#define RPMCAP(x)	(PMCAP(0)+(x))
> > +#define REXPCAP(x)	(EXPCAP(0)+(x))
> > +#define RVCCAP(x)	(VCCAP(0)+(x))
> > +
> > +#define  PCIE_CONF_BUS(b)	(((b) & 0xff) << 24)
> > +#define  PCIE_CONF_DEV(d)	(((d) & 0x1f) << 19)
> > +#define  PCIE_CONF_FUNC(f)	(((f) & 0x7) << 16)
> > +
> > +#define PCI_MAX_RESOURCES 4
> > +#define MAX_NR_INBOUND_MAPS 6
> > +
> > +/* Structure representing the PCIe interface */
> > +struct rcar_pcie {
> > +	struct device		*dev;
> > +	void __iomem		*base;
> > +	struct resource		res[PCI_MAX_RESOURCES];
> > +	u8			root_bus_nr;
> 
> I don't understand how root_bus_nr works.  From its name, it sounds like
> it's the bus number of the PCI bus on the downstream side of the host
> bridge.
That's correct.

> That bus number should be a property of the host bridge, i.e.,
> it's either hard-wired into the bridge, or it's programmable somewhere.
> But root_bus_nr comes from sys->busnr, which is apparently from some
> generic code that knows nothing about this particular host bridge.
The manual for this hardware says that the HW doesn't care what the bus number
is set to. The only thing the HW needs to know is that when sending config
accesses, we need to indicate whether it's a TYPE0 or TYPE1 header; so we use
root_bus_nr to determine this. The generic code that sets up sys->busnr (ARM
bios32 in this case), just increments bus number for each controller.

This is very similar to the pcie-designware driver, in dw_pcie_scan_bus().

> > +	struct clk		*clk;
> > +	struct clk		*bus_clk;
> > +};
> > +
> > +static inline struct rcar_pcie *sys_to_pcie(struct pci_sys_data *sys)
> > +{
> > +	return sys->private_data;
> > +}
> > +
> > +static void
> > +pci_write_reg(struct rcar_pcie *pcie, unsigned long val, unsigned long
> reg)
> 
> Use this indentation style:
> 
>     static void pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
> 
> and wrap the args as necessary (as you already did with
> rcar_pcie_read_conf() below).
Ok
 
> > +{
> > +	writel(val, pcie->base + reg);
> > +}
> > +
> > +static unsigned long
> > +pci_read_reg(struct rcar_pcie *pcie, unsigned long reg)
> > +{
> > +	return readl(pcie->base + reg);
> > +}
> > +
> > +enum {
> > +	PCI_ACCESS_READ,
> > +	PCI_ACCESS_WRITE,
> > +};
> > +
> > +static void rcar_rmw32(struct rcar_pcie *pcie,
> > +			    int where, u32 mask, u32 data)
> 
> No wrapping necessary here.
Sure
 
> > +{
> > +	int shift = 8 * (where & 3);
> > +	u32 val = pci_read_reg(pcie, where & ~3);
> 
> A blank line is typical here (after the local variables).
Ok

> > +	val &= ~(mask << shift);
> > +	val |= data << shift;
> > +	pci_write_reg(pcie, val, where & ~3);
> > +}
> > +
> > +static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
> > +{
> > +	int shift = 8 * (where & 3);
> > +	u32 val = pci_read_reg(pcie, where & ~3);
> 
> And here.
Ok
 
> > +	return val >> shift;
> > +}
> > +
> > +static int rcar_pcie_config_access(struct rcar_pcie *pcie,
> > +		unsigned char access_type, struct pci_bus *bus,
> > +		unsigned int devfn, int where, u32 *data)
> > +{
> > +	int dev, func, reg, index;
> > +
> > +	dev = PCI_SLOT(devfn);
> > +	func = PCI_FUNC(devfn);
> > +	reg = where & ~3;
> > +	index = reg / 4;
> > +
> > +	if (bus->number > 255 || dev > 31 || func > 7)
> > +		return PCIBIOS_FUNC_NOT_SUPPORTED;
> 
> I do see one other place in the tree (sh7786_pcie_config_access()) where we
> test all these, but I don't think it's really necessary.  It's actually
> impossible to satisfy this condition, given the definitions of bus->number,
> PCI_SLOT(), and PCI_FUNC().
Ok, I'll remove them. They were simply copied over from the sh7786 driver.

> > ...
> > +	/* Clear errors */
> > +	pci_write_reg(pcie, pci_read_reg(pcie, PCIEERRFR), PCIEERRFR);
> > +
> > +	/* Set the PIO address */
> > +	pci_write_reg(pcie, PCIE_CONF_BUS(bus->number) |
> PCIE_CONF_DEV(dev) |
> > +				PCIE_CONF_FUNC(func) | reg, PCIECAR);
> > +
> > +	/* Enable the configuration access */
> > +	if (bus->parent->number == pcie->root_bus_nr)
> > +		pci_write_reg(pcie, CONFIG_SEND_ENABLE | TYPE0,
> PCIECCTLR);
> > +	else
> > +		pci_write_reg(pcie, CONFIG_SEND_ENABLE | TYPE1,
> PCIECCTLR);
> > +
> > +	/* Check for errors */
> > +	if (pci_read_reg(pcie, PCIEERRFR) & UNSUPPORTED_REQUEST)
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +
> > +	/* Check for master and target aborts */
> > +	if (rcar_read_conf(pcie, RCONF(PCI_STATUS)) &
> > +		(PCI_STATUS_REC_MASTER_ABORT |
> PCI_STATUS_REC_TARGET_ABORT))
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +
> > +	if (access_type == PCI_ACCESS_READ)
> > +		*data = pci_read_reg(pcie, PCIECDR);
> > +	else
> > +		pci_write_reg(pcie, *data, PCIECDR);
> > +
> > +	/* Disable the configuration access */
> > +	pci_write_reg(pcie, 0, PCIECCTLR);
> 
> It looks like the above all needs to be atomic, so I suppose you're relying
> on higher-level locking to ensure that.  It might be worth a mention of the
> lock you rely on, just in case that ever changes (I doubt it would, but
> it's conceivable).
Yes, the locking is done at a higher level; I'll add comment for this.

> > ...
> > +static int rcar_pcie_setup_window(int win, struct resource *res,
> > +					struct rcar_pcie *pcie)
> > +{
> > +	/* Setup PCIe address space mappings for each resource */
> > +	resource_size_t size;
> > +	u32 mask;
> > +
> > +	pci_write_reg(pcie, 0x00000000, PCIEPTCTLR(win));
> > +
> > +	/*
> > +	 * The PAMR mask is calculated in units of 128Bytes, which
> > +	 * keeps things pretty simple.
> > +	 */
> > +	size = resource_size(res);
> > +	mask = (roundup_pow_of_two(size) / SZ_128) - 1;
> > +	pci_write_reg(pcie, mask << 7, PCIEPAMR(win));
> > +
> > +	pci_write_reg(pcie, upper_32_bits(res->start), PCIEPARH(win));
> > +	pci_write_reg(pcie, lower_32_bits(res->start), PCIEPARL(win));
> > +
> > +	/* First resource is for IO */
> > +	mask = PAR_ENABLE;
> > +	if (res->flags & IORESOURCE_IO)
> > +		mask |= IO_SPACE;
> > +
> > +	pci_write_reg(pcie, mask, PCIEPTCTLR(win));
> > +
> > +	return 0;
> 
> Maybe could be a void function, since no error is possible?
Sure

> > ...
> > +static int __init rcar_pcie_get_resources(struct platform_device *pdev,
> > +	struct rcar_pcie *pcie)
> > +{
> > +	struct resource res;
> > +	int err;
> > +
> > +	err = of_address_to_resource(pdev->dev.of_node, 0, &res);
> > +	if (err)
> > +		return err;
> 
> I don't see anywhere that figures out the bus number range behind this host
> bridge.  The PCI core needs to know this.  I know the core assumes 00-ff if
> it's not supplied, but that's just to deal with the legacy situation where
> we assumed one host bridge was all anybody would ever need.
> 
> For new code, we should be explicit about the range.
This means add a DT entry for bus-range, and simply calling pci_add_resource for
the range, right? If so, ok.

Thanks
Phil
