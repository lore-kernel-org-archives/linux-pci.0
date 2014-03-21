Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:56382 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933AbaCUPHp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Mar 2014 11:07:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Phil.Edworthy@renesas.com, Simon Horman <horms@verge.net.au>,
	linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 1/9] PCI: host: rcar: Add Renesas R-Car PCIe driver
Date: Fri, 21 Mar 2014 16:07:03 +0100
Message-ID: <4337701.rbRMDOA6lL@wuerfel>
In-Reply-To: <OF038A7DC3.59E6288A-ON80257CA2.004AF404-80257CA2.004CDD76@eu.necel.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com> <27671657.LuGQtNBfqX@wuerfel> <OF038A7DC3.59E6288A-ON80257CA2.004AF404-80257CA2.004CDD76@eu.necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 21 March 2014 13:59:35 Phil.Edworthy@renesas.com wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > static const struct of_device_id rcar_pcie_of_match[] = {
> >    { .compatible = "renesas,r8a7779-pcie", .data = 
> rcar_pcie_phy_init_rcar_h1},
> >    { .compatible = "renesas,r8a7790-pcie", .data =  rcar_pcie_hw_init},
> >    { .compatible = "renesas,r8a7791-pcie", .data =  rcar_pcie_hw_init},
> >    {},
> > };
> > 
> > If you need other differences in the future, you can extend this
> > to use a pointer to a struct containing the init function pointer.
>
> Ok, I understand what you mean, though the rcar_pcie_phy_init_rcar_h1 
> function is an extra call for r8a7779 devices to setup the PHY, not an 
> alternative to rcar_pcie_hw_init.

I assumed that would be trivial to change, by calling rcar_pcie_hw_init
at the end of rcar_pcie_phy_init_rcar_h1 rather than the other way round.

> > > +static int rcar_pcie_setup_window(int win, struct resource *res,
> > > +               struct rcar_pcie *pcie)
> > > +{
> > > +   /* Setup PCIe address space mappings for each resource */
> > > +   resource_size_t size;
> > > +   u32 mask;
> > > +
> > > +   pci_write_reg(pcie, 0x00000000, PCIEPTCTLR(win));
> > > +
> > > +   /*
> > > +    * The PAMR mask is calculated in units of 128Bytes, which
> > > +    * keeps things pretty simple.
> > > +    */
> > > +   size = resource_size(res);
> > > +   mask = (roundup_pow_of_two(size) / SZ_128) - 1;
> > > +   pci_write_reg(pcie, mask << 7, PCIEPAMR(win));
> > > +
> > > +   pci_write_reg(pcie, upper_32_bits(res->start), PCIEPARH(win));
> > > +   pci_write_reg(pcie, lower_32_bits(res->start), PCIEPARL(win));
> > > +
> > > +   /* First resource is for IO */
> > > +   mask = PAR_ENABLE;
> > > +   if (res->flags & IORESOURCE_IO)
> > > +      mask |= IO_SPACE;
> > > +
> > > +   pci_write_reg(pcie, mask, PCIEPTCTLR(win));
> > > +
> > > +   return 0;
> > > +}
> > 
> > Would it be possible to have this done in the boot loader so the kernel
> > doesn't need to be bothered with it?
>
> Hmm, I don't like the idea of depending on settings made by a bootloader, 
> when it may be that a different bootloader could be used, or no bootloader 
> at all.

If you need to support the case without a boot loader, that would be
a good reason to leave the code in.

Otherwise, I think it's better to mandate early that the boot loader
sets up a lot of the basic stuff. As long as nobody has a kernel that
does the same setup, you also won't see any boot loaders that get it
wrong, because they never work. It's also easy enough to add back
if you later have to support a broken boot loader.

> > > +static int rcar_pcie_setup(int nr, struct pci_sys_data *sys)
> > > +{
> > > +   struct rcar_pcie *pcie = sys_to_pcie(sys);
> > > +   struct resource *res;
> > > +   int i, ret;
> > > +
> > > +   pcie->root_bus_nr = sys->busnr;
> > > +
> > > +   /* Setup PCI resources */
> > > +   for (i = 0; i < PCI_MAX_RESOURCES; i++) {
> > > +
> > > +      res = &pcie->res[i];
> > > +      if (!res->flags)
> > > +         continue;
> > > +
> > > +      if (res->flags & IORESOURCE_IO) {
> > > +         /* Setup IO mapped memory accesses */
> > > +         ret = pci_ioremap_io(0, res->start);
> > > +         if (ret)
> > > +            return 1;
> > > +
> > > +         /* Correct addresses for remapped IO */
> > > +         res->end = res->end - res->start;
> > > +         res->start = 0;
> > > +      }
> > > +
> > > +      rcar_pcie_setup_window(i, res, pcie);
> > > +      pci_add_resource(&sys->resources, res);
> > > +   }
> > 
> > This assumes that the start of the I/O window is always at
> > bus address 0, and that you have only one PCI host in the system.
> > Are both guaranteed through the hardware design?
>
> The I/O window can be anywhere I believe, so I guess I should pull the 
> actual bus address from the DT.

Ok. There is actually work on the way to simplify this a lot
so you don't have to do it in the driver, but it will probably
take a little more time, especially since Will Deacon is on an
extended vacation at the moment and he was driving things.

> All existing devices I have seen, have a single PCIe host.

The seems less obvious to rely on though, it's quite common
for newer hardware to have multiple blocks of whatever the first
generation has only one of ;-)

> > > +static int __init rcar_pcie_phy_init_rcar_h1(struct rcar_pcie *pcie)
> > > +{
> > > +   unsigned int timeout = 10;
> > > +
> > > +   /* Initialize the phy */
> > > +   phy_write_reg(pcie, 0, 0x42, 0x1, 0x0EC34191);
> > > +   phy_write_reg(pcie, 1, 0x42, 0x1, 0x0EC34180);
> > > +   phy_write_reg(pcie, 0, 0x43, 0x1, 0x00210188);
> > > +   phy_write_reg(pcie, 1, 0x43, 0x1, 0x00210188);
> > > +   phy_write_reg(pcie, 0, 0x44, 0x1, 0x015C0014);
> > > +   phy_write_reg(pcie, 1, 0x44, 0x1, 0x015C0014);
> > > +   phy_write_reg(pcie, 1, 0x4C, 0x1, 0x786174A0);
> > 
> > Have you considered moving this into a separate PHY driver?
> > There are probably good reasons either way, so I'm not asking you
> > to do it, just to think about what would be best for this driver.
> > 
> > It seems that you already have two different implementations
> > that only vary in how they access the PHY, so moving that
> > into a separate driver would keep the knowledge out of the
> > host driver. OTOH, the PHY registers look like they are part of
> > the pci host itself.
>
> The PHYs are separate entities, but access to them is via the PCIe 
> controller's registers. In the general case, there shouldn't be any PHY 
> setup to do, it's just the R-Car H1 devices that needs a little tweaking.

Ok.


> > Most importantly, why don't you use a mapping that includes RAM beyond
> > the first 4GB?
> I had intended to send a patch later on to open this up to the first 12GB. 
> Limitations of this block of hardware mean that we can do at most three 
> 4GB regions. The first 12GB would be ok for LPAE on existing devices as 
> all DDR is mapped within that range, but obviously not ideal.

Ok, in this case it sounds like you should definitely use the dma-ranges
property, since it's possibly that board designers put their ram in funny
places. You probably want to have a dma-ranges property with three 4GB
entries then and document the size limitation in the pci host binding,
rather than a single entry spanning all of RAM.

	Arnd
