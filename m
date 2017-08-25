Return-Path: <SRS0=NMYr=73=mediatek.com=honghui.zhang@kernel.org>
Return-Path: <SRS0=NMYr=73=mediatek.com=honghui.zhang@kernel.org>
Message-ID: <1503622427.19072.11.camel@mhfsdcap03>
Subject: Re: [pci:pci/host-mediatek 11/11]
 drivers/pci/host/pcie-mediatek.c:541:43: error: 'node' undeclared
From: Honghui Zhang <honghui.zhang@mediatek.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: kbuild test robot <fengguang.wu@intel.com>, <kbuild-all@01.org>,
	<linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, ryder.lee
	<ryder.lee@mediatek.com>, <youlin.pei@mediatek.com>,
	<xinping.qian@mediatek.com>
Date: Fri, 25 Aug 2017 08:53:47 +0800
In-Reply-To: <20170824134451.GA31858@bhelgaas-glaptop.roam.corp.google.com>
References: <201708232205.SymULNVt%fengguang.wu@intel.com>
	 <20170823225211.GI8498@bhelgaas-glaptop.roam.corp.google.com>
	 <1503544447.19072.7.camel@mhfsdcap03>
	 <20170824134451.GA31858@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2017-08-24 at 08:44 -0500, Bjorn Helgaas wrote:
> On Thu, Aug 24, 2017 at 11:14:07AM +0800, mtk11102 wrote:
> > On Wed, 2017-08-23 at 17:52 -0500, Bjorn Helgaas wrote:
> > > On Wed, Aug 23, 2017 at 10:53:07PM +0800, kbuild test robot wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host-mediatek
> > > > head:   8e8ed61600e99258ff59bf36b85b671eed25a462
> > > > commit: 8e8ed61600e99258ff59bf36b85b671eed25a462 [11/11] PCI: mediatek: Add MSI support for MT2712 and MT7622
> > > > config: arm-allmodconfig (attached as .config)
> > > > compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> > > > reproduce:
> > > >         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         git checkout 8e8ed61600e99258ff59bf36b85b671eed25a462
> > > >         # save the attached .config to linux build tree
> > > >         make.cross ARCH=arm 
> > > 
> > > The "node" and "dev" undeclared errors are my fault, and I fixed them.  But
> > > I don't think I introduced the casting warnings.  These warnings are on a
> > > 32-bit build.
> > > 
> > > I pushed the update to fix the node/dev errors.  Please take a look at the
> > > remaining casting warnings.
> > > 
> > > > All error/warnings (new ones prefixed by >>):
> > > > 
> > > >    In file included from include/linux/clk.h:16:0,
> > > >                     from drivers/pci/host/pcie-mediatek.c:18:
> > > >    drivers/pci/host/pcie-mediatek.c: In function 'mtk_pcie_msi_setup_irq':
> > > > >> drivers/pci/host/pcie-mediatek.c:488:33: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> > > >      msg.address_lo = lower_32_bits((u64)(port->base + PCIE_MSI_VECTOR));
> > > >                                     ^
> > > >    include/linux/kernel.h:178:33: note: in definition of macro 'lower_32_bits'
> > > >     #define lower_32_bits(n) ((u32)(n))
> > > >                                     ^
> > > >    drivers/pci/host/pcie-mediatek.c: In function 'mtk_pcie_enable_msi':
> > > > >> drivers/pci/host/pcie-mediatek.c:541:43: error: 'node' undeclared (first use in this function)
> > > >      port->msi_domain = irq_domain_add_linear(node, MTK_MSI_IRQS_NUM,
> > > >                                               ^~~~
> > > >    drivers/pci/host/pcie-mediatek.c:541:43: note: each undeclared identifier is reported only once for each function it appears in
> > > > >> drivers/pci/host/pcie-mediatek.c:545:11: error: 'dev' undeclared (first use in this function)
> > > >       dev_err(dev, "failed to create MSI IRQ domain\n");
> > > >               ^~~
> > > >    In file included from include/linux/clk.h:16:0,
> > > >                     from drivers/pci/host/pcie-mediatek.c:18:
> > > >    drivers/pci/host/pcie-mediatek.c:549:22: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> > > >      val = lower_32_bits((u64)(port->base + PCIE_MSI_VECTOR));
> > > >                          ^
> > > >    include/linux/kernel.h:178:33: note: in definition of macro 'lower_32_bits'
> > > >     #define lower_32_bits(n) ((u32)(n))
> > > >                                     ^
> > > > 
> > 
> > hi, Bjorn,
> > I fixed the build warning at arm by the following diff:
> > diff --git a/drivers/pci/host/pcie-mediatek.c
> > b/drivers/pci/host/pcie-mediatek.c
> > index 707e669..b8d6ed8 100644
> > --- a/drivers/pci/host/pcie-mediatek.c
> > +++ b/drivers/pci/host/pcie-mediatek.c
> > @@ -459,6 +459,7 @@ static int mtk_pcie_msi_setup_irq(struct
> > msi_controller *chip,
> >         struct msi_msg msg;
> >         int hwirq;
> >         u32 irq;
> > +       phys_addr_t msg_addr;
> > 
> >         port = mtk_pcie_find_port(pdev->bus, pdev->devfn);
> >         if (!port)
> > @@ -475,9 +476,10 @@ static int mtk_pcie_msi_setup_irq(struct
> > msi_controller *chip,
> > 
> >         irq_set_msi_desc(irq, desc);
> > 
> > +       msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> >         /* MT2712/MT7622 only support 32 bit MSI address */
> >         msg.address_hi = 0;
> > -       msg.address_lo = lower_32_bits((u64)(port->base +
> > PCIE_MSI_VECTOR));
> > +       msg.address_lo = lower_32_bits(msg_addr);
> >         msg.data = hwirq;
> > 
> >         pci_write_msi_msg(irq, &msg);
> > @@ -531,8 +533,10 @@ static const struct irq_domain_ops msi_domain_ops =
> > {
> >  static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
> >  {
> >         u32 val;
> > +       phys_addr_t msg_addr;
> > 
> > -       val = lower_32_bits((u64)(port->base + PCIE_MSI_VECTOR));
> > +       msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> > +       val = lower_32_bits(msg_addr);
> >         writel(val, port->base + PCIE_IMSI_ADDR);
> > 
> >         val = readl(port->base + PCIE_INT_MASK);
> 
> I don't think this is quite right: virt_to_phys() converts a CPU
> virtual address to a CPU physical address, but the msg_addr is a PCI
> bus address.  In many cases, PCI bus addresses are identical to CPU
> physical addresses, but not always.
> 
> But I see other drivers doing the same thing:
> 
>   dw_pcie_msi_init()
>   dw_msi_setup_msg()
>   advk_msi_irq_compose_msi_msg()
>   advk_pcie_init_msi_irq_domain()
>   rcar_pcie_enable_msi()
>   xilinx_pcie_msi_setup_irq()
>   xilinx_pcie_enable_msi()
> 
> and I don't know the right way to fix this.  MSI is basically a
> special case of DMA.  For most DMA, we allocate a buffer and use
> something like dma_map_single() to map it via an IOMMU (if present)
> and return the corresponding bus address.  For MSIs, the target isn't
> usually a memory buffer, and I don't know that dma_map_single() would
> do the right thing.
> 
> But I guess we should use your fix for now since I don't have a better
> idea.
> 
> > I pull the your host-mediatek branch and seems the build error is still
> > there.
> > Should I send a new patch base on your pci/host-mediatek to fix the
> > build warnings, or should I wait for your push for build error and then
> > send the patch?
> 
> Sorry, I must have forgotten to push it.  Should be there now:
> 9f3ec1e47377 ("PCI: mediatek: Add MSI support for MT2712 and MT7622")
> 
> Hopefully that has everything we need (I included your fix above).
> 

Thanks very much for your help.

> Bjorn
