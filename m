Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:16891 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752883AbaCUN7q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Mar 2014 09:59:46 -0400
In-Reply-To: <27671657.LuGQtNBfqX@wuerfel>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com> <1395397968-6242-2-git-send-email-phil.edworthy@renesas.com> <27671657.LuGQtNBfqX@wuerfel>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
From: Phil.Edworthy@renesas.com
Message-ID: <OF038A7DC3.59E6288A-ON80257CA2.004AF404-80257CA2.004CDD76@eu.necel.com>
Date: Fri, 21 Mar 2014 13:59:35 +0000
Subject: Re: [PATCH v4 1/9] PCI: host: rcar: Add Renesas R-Car PCIe driver
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

Thanks for the review.

> From: Arnd Bergmann <arnd@arndb.de>
> To: linux-arm-kernel@lists.infradead.org, 
> Cc: Phil Edworthy <phil.edworthy@renesas.com>, 
linux-pci@vger.kernel.org, 
> linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Valentine 

> Barshak <valentine.barshak@cogentembedded.com>, Simon Horman 
> <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>, Ben Dooks 
> <ben.dooks@codethink.co.uk>
> Date: 21/03/2014 11:04
> Subject: Re: [PATCH v4 1/9] PCI: host: rcar: Add Renesas R-Car PCIe 
driver
> 
> On Friday 21 March 2014 10:32:40 Phil Edworthy wrote:
> > +static const struct of_device_id rcar_pcie_of_match[] = {
> > +   { .compatible = "renesas,r8a7779-pcie", .data = (void *)RCAR_H1 },
> > +   { .compatible = "renesas,r8a7790-pcie", .data = (void 
*)RCAR_GENERIC },
> > +   { .compatible = "renesas,r8a7791-pcie", .data = (void 
*)RCAR_GENERIC },
> > +   {},
> > +};
> > +MODULE_DEVICE_TABLE(of, rcar_pcie_of_match);
> 
> The only difference between RCAR_H1 and RCAR_GENERIC seems to be the
> use of the rcar_pcie_phy_init_rcar_h1 vs rcar_pcie_hw_init
> functions. I think this would be expressed in a nicer way doing
> 
> static const struct of_device_id rcar_pcie_of_match[] = {
>    { .compatible = "renesas,r8a7779-pcie", .data = 
rcar_pcie_phy_init_rcar_h1},
>    { .compatible = "renesas,r8a7790-pcie", .data =  rcar_pcie_hw_init},
>    { .compatible = "renesas,r8a7791-pcie", .data =  rcar_pcie_hw_init},
>    {},
> };
> 
> If you need other differences in the future, you can extend this
> to use a pointer to a struct containing the init function pointer.
Ok, I understand what you mean, though the rcar_pcie_phy_init_rcar_h1 
function is an extra call for r8a7779 devices to setup the PHY, not an 
alternative to rcar_pcie_hw_init.


> > +static int rcar_pcie_setup_window(int win, struct resource *res,
> > +               struct rcar_pcie *pcie)
> > +{
> > +   /* Setup PCIe address space mappings for each resource */
> > +   resource_size_t size;
> > +   u32 mask;
> > +
> > +   pci_write_reg(pcie, 0x00000000, PCIEPTCTLR(win));
> > +
> > +   /*
> > +    * The PAMR mask is calculated in units of 128Bytes, which
> > +    * keeps things pretty simple.
> > +    */
> > +   size = resource_size(res);
> > +   mask = (roundup_pow_of_two(size) / SZ_128) - 1;
> > +   pci_write_reg(pcie, mask << 7, PCIEPAMR(win));
> > +
> > +   pci_write_reg(pcie, upper_32_bits(res->start), PCIEPARH(win));
> > +   pci_write_reg(pcie, lower_32_bits(res->start), PCIEPARL(win));
> > +
> > +   /* First resource is for IO */
> > +   mask = PAR_ENABLE;
> > +   if (res->flags & IORESOURCE_IO)
> > +      mask |= IO_SPACE;
> > +
> > +   pci_write_reg(pcie, mask, PCIEPTCTLR(win));
> > +
> > +   return 0;
> > +}
> 
> Would it be possible to have this done in the boot loader so the kernel
> doesn't need to be bothered with it?
Hmm, I don't like the idea of depending on settings made by a bootloader, 
when it may be that a different bootloader could be used, or no bootloader 
at all.


> > +
> > +static int rcar_pcie_setup(int nr, struct pci_sys_data *sys)
> > +{
> > +   struct rcar_pcie *pcie = sys_to_pcie(sys);
> > +   struct resource *res;
> > +   int i, ret;
> > +
> > +   pcie->root_bus_nr = sys->busnr;
> > +
> > +   /* Setup PCI resources */
> > +   for (i = 0; i < PCI_MAX_RESOURCES; i++) {
> > +
> > +      res = &pcie->res[i];
> > +      if (!res->flags)
> > +         continue;
> > +
> > +      if (res->flags & IORESOURCE_IO) {
> > +         /* Setup IO mapped memory accesses */
> > +         ret = pci_ioremap_io(0, res->start);
> > +         if (ret)
> > +            return 1;
> > +
> > +         /* Correct addresses for remapped IO */
> > +         res->end = res->end - res->start;
> > +         res->start = 0;
> > +      }
> > +
> > +      rcar_pcie_setup_window(i, res, pcie);
> > +      pci_add_resource(&sys->resources, res);
> > +   }
> 
> This assumes that the start of the I/O window is always at
> bus address 0, and that you have only one PCI host in the system.
> Are both guaranteed through the hardware design?
The I/O window can be anywhere I believe, so I guess I should pull the 
actual bus address from the DT.
All existing devices I have seen, have a single PCIe host.


> > +static void __init rcar_pcie_enable(struct rcar_pcie *pcie)
> > +{
> > +   struct platform_device *pdev = to_platform_device(pcie->dev);
> > +   struct hw_pci hw;
> > +
> > +   memset(&hw, 0, sizeof(hw));
> > +
> > +   hw.nr_controllers = 1;
> > +   hw.private_data   = (void **)&pcie;
> > +   hw.setup          = rcar_pcie_setup,
> > +   hw.map_irq        = of_irq_parse_and_map_pci,
> > +   hw.ops        = &rcar_pcie_ops,
> 
> You can write this slightly nicer doing
> 
>    struct hw_pci hw = {
>       .nr_controllers = 1,
>       .private_data = (void **)&pcie,
>       ...
>    };
Ok, will do.


> > +static int __init rcar_pcie_phy_init_rcar_h1(struct rcar_pcie *pcie)
> > +{
> > +   unsigned int timeout = 10;
> > +
> > +   /* Initialize the phy */
> > +   phy_write_reg(pcie, 0, 0x42, 0x1, 0x0EC34191);
> > +   phy_write_reg(pcie, 1, 0x42, 0x1, 0x0EC34180);
> > +   phy_write_reg(pcie, 0, 0x43, 0x1, 0x00210188);
> > +   phy_write_reg(pcie, 1, 0x43, 0x1, 0x00210188);
> > +   phy_write_reg(pcie, 0, 0x44, 0x1, 0x015C0014);
> > +   phy_write_reg(pcie, 1, 0x44, 0x1, 0x015C0014);
> > +   phy_write_reg(pcie, 1, 0x4C, 0x1, 0x786174A0);
> 
> Have you considered moving this into a separate PHY driver?
> There are probably good reasons either way, so I'm not asking you
> to do it, just to think about what would be best for this driver.
> 
> It seems that you already have two different implementations
> that only vary in how they access the PHY, so moving that
> into a separate driver would keep the knowledge out of the
> host driver. OTOH, the PHY registers look like they are part of
> the pci host itself.
The PHYs are separate entities, but access to them is via the PCIe 
controller's registers. In the general case, there shouldn't be any PHY 
setup to do, it's just the R-Car H1 devices that needs a little tweaking.


> > +   /*
> > +    * For target transfers, setup a single 64-bit 4GB mapping at 
address
> > +    * 0. The hardware can only map memory that starts on a power of 
two
> > +    * boundary, and size is power of 2, so best to ignore it.
> > +    */
> > +   pci_write_reg(pcie, 0, PCIEPRAR(0));
> > +   pci_write_reg(pcie, 0, PCIELAR(0));
> > +   pci_write_reg(pcie, 0xfffffff0UL | LAM_PREFETCH |
> > +      LAM_64BIT | LAR_ENABLE, PCIELAMR(0));
> > +   pci_write_reg(pcie, 0, PCIELAR(1));
> > +   pci_write_reg(pcie, 0, PCIEPRAR(1));
> > +   pci_write_reg(pcie, 0, PCIELAMR(1));
> 
> Is this the only reasonable configuration? If not, you might want to
> do the same thing as the x-gene PCI driver that is not yet merged,
> and parse the 'dma-ranges' property to determine what the mapping
> on a particular machine should be.
Based on the restrictions of these registers, it seemed like a sensible 
approach to open up the whole 32-bit address space. I'll have a look at 
the x-gene patches to see if that would be better.

> Most importantly, why don't you use a mapping that includes RAM beyond
> the first 4GB?
I had intended to send a patch later on to open this up to the first 12GB. 
Limitations of this block of hardware mean that we can do at most three 
4GB regions. The first 12GB would be ok for LPAE on existing devices as 
all DDR is mapped within that range, but obviously not ideal.


> > +static int __init pcie_init(void)
> > +{
> > +   return platform_driver_probe(&rcar_pcie_driver, rcar_pcie_probe);
> > +}
> > +subsys_initcall(pcie_init);
> 
> Why so early?
Good catch, copied from another PCIe driver!

> Overall, this driver looks pretty good.
> 
>    Arnd

Thanks
Phil
