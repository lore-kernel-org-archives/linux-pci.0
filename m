Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58009 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980AbbGMORD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Jul 2015 10:17:03 -0400
Date: Mon, 13 Jul 2015 15:17:35 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	James Morse <James.Morse@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"fabrice.gasnier@st.com" <fabrice.gasnier@st.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Yuanzhichang <yuanzhichang@hisilicon.com>,
	Zhudacai <zhudacai@hisilicon.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"liguozhu@hisilicon.com" <liguozhu@hisilicon.com>
Subject: Re: [PATCH v2 2/4] PCI: designware: Add ARM64 support
Message-ID: <20150713125854.GA14750@red-moon>
References: <5570507F.4030704@arm.com>
 <557159B2.9090103@hisilicon.com>
 <20150609111507.GB20182@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E013A4278@lhreml505-mbx.china.huawei.com>
 <55792032.2080903@hisilicon.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E013A4D61@lhreml505-mbx.china.huawei.com>
 <558008D2.5090807@hisilicon.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E013AA396@lhreml505-mbx.china.huawei.com>
 <20150713105819.GA14459@red-moon>
 <55A3A4F0.4010009@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55A3A4F0.4010009@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 13, 2015 at 12:45:52PM +0100, Zhou Wang wrote:
> On 2015/7/13 18:58, Lorenzo Pieralisi wrote:
> > On Tue, Jun 16, 2015 at 03:14:21PM +0100, Gabriele Paoloni wrote:
> >
> > [...]
> >
> >>>> +   bus = pci_create_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops,
> >>>> +                         pp, &res);
> >
> > I think you can't do that on ARM 32-bit platforms. They rely on pci_sys_data
> > in pcibios_msi_controller and pcibios_align_resource, if you do not
> > pass a pci_sys_data struct in the sysdata pointer this can't work and
> > unless you get lucky it will explode.
> >
> > We have to remove pci_sys_data dependency on ARM, then this approach
> > will work.
> >
> > Thanks,
> > Lorenzo
> >
> 
> Hi Lorenzo,
> 
> For pcibios_align_resource, 1/4 can be used to solve this problem.
> For pcibios_msi_controller, bus->msi can be set in pcie-designware, then
> we can get msi controller by dev->bus->msi in pci_msi_controller.

Yes, 1/4 solves the problem I know, but that's a bit hackish, it would
be better if we can create the host bridge and pass it to
create_root_bus, that's what Yijing was doing but I am not sure
if that's still the plan given his latest series here.

https://patchwork.ozlabs.org/project/linux-pci/list/?submitter=15928

I've just posted a patch for pcibios_msi_controller removal, I did
not notice that it was something already put forward by Arnd, anyway
those are the last two steps required, let's get them merged.

https://patchwork.ozlabs.org/patch/494498/

Lorenzo

> And the latest series is v3 version
> "[PATCH v3 0/5] PCI: hisi: Add PCIe host support for Hisilicon Soc Hip05"
> 
> Best regards,
> Zhou
> 
> >>>> +   if (!bus)
> >>>> +           return -ENOMEM;
> >>>> +
> >>>> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> >>>> +   bus->msi = container_of(&pp->irq_domain, struct msi_controller,
> >>> domain);
> >>>> +#else
> >>>> +   bus->msi = &dw_pcie_msi_chip;
> >>>>  #endif
> >>>>
> >>>> -   dw_pci.nr_controllers = 1;
> >>>> -   dw_pci.private_data = (void **)&pp;
> >>>> +   pci_scan_child_bus(bus);
> >>>> +   if (pp->ops->scan_bus)
> >>>> +           pp->ops->scan_bus(pp);
> >>>>
> >>>> -   pci_common_init_dev(pp->dev, &dw_pci);
> >>>> +#ifdef CONFIG_ARM
> >>>> +   /* support old dtbs that incorrectly describe IRQs */
> >>>> +   pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> >>>> +#endif
> >>>> +
> >>>> +   pci_assign_unassigned_bus_resources(bus);
> >>>> +   pci_bus_add_devices(bus);
> >>>>
> >>>>     return 0;
> >>>>  }
> >>>> @@ -653,7 +665,7 @@ static int dw_pcie_valid_config(struct pcie_port
> >>> *pp,
> >>>>  static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
> >>>>                     int size, u32 *val)
> >>>>  {
> >>>> -   struct pcie_port *pp = sys_to_pcie(bus->sysdata);
> >>>> +   struct pcie_port *pp = bus->sysdata;
> >>>>     int ret;
> >>>>
> >>>>     if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
> >>>> @@ -677,7 +689,7 @@ static int dw_pcie_rd_conf(struct pci_bus *bus,
> >>> u32 devfn, int where,
> >>>>  static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
> >>>>                     int where, int size, u32 val)
> >>>>  {
> >>>> -   struct pcie_port *pp = sys_to_pcie(bus->sysdata);
> >>>> +   struct pcie_port *pp = bus->sysdata;
> >>>>     int ret;
> >>>>
> >>>>     if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
> >>>> @@ -701,64 +713,6 @@ static struct pci_ops dw_pcie_ops = {
> >>>>     .write = dw_pcie_wr_conf,
> >>>>  };
> >>>>
> >>>> -static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
> >>>> -{
> >>>> -   struct pcie_port *pp;
> >>>> -
> >>>> -   pp = sys_to_pcie(sys);
> >>>> -
> >>>> -   if (global_io_offset < SZ_1M && pp->io_size > 0) {
> >>>> -           sys->io_offset = global_io_offset - pp->io_bus_addr;
> >>>> -           pci_ioremap_io(global_io_offset, pp->io_base);
> >>>> -           global_io_offset += SZ_64K;
> >>>> -           pci_add_resource_offset(&sys->resources, &pp->io,
> >>>> -                                   sys->io_offset);
> >>>> -   }
> >>>> -
> >>>> -   sys->mem_offset = pp->mem.start - pp->mem_bus_addr;
> >>>> -   pci_add_resource_offset(&sys->resources, &pp->mem, sys-
> >>>> mem_offset);
> >>>> -   pci_add_resource(&sys->resources, &pp->busn);
> >>>> -
> >>>> -   return 1;
> >>>> -}
> >>>> -
> >>>> -static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data
> >>> *sys)
> >>>> -{
> >>>> -   struct pci_bus *bus;
> >>>> -   struct pcie_port *pp = sys_to_pcie(sys);
> >>>> -
> >>>> -   pp->root_bus_nr = sys->busnr;
> >>>> -   bus = pci_create_root_bus(pp->dev, sys->busnr,
> >>>> -                             &dw_pcie_ops, sys, &sys->resources);
> >>>> -   if (!bus)
> >>>> -           return NULL;
> >>>> -
> >>>> -   pci_scan_child_bus(bus);
> >>>> -
> >>>> -   if (bus && pp->ops->scan_bus)
> >>>> -           pp->ops->scan_bus(pp);
> >>>> -
> >>>> -   return bus;
> >>>> -}
> >>>> -
> >>>> -static int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8
> >>> pin)
> >>>> -{
> >>>> -   struct pcie_port *pp = sys_to_pcie(dev->bus->sysdata);
> >>>> -   int irq;
> >>>> -
> >>>> -   irq = of_irq_parse_and_map_pci(dev, slot, pin);
> >>>> -   if (!irq)
> >>>> -           irq = pp->irq;
> >>>> -
> >>>> -   return irq;
> >>>> -}
> >>>> -
> >>>> -static struct hw_pci dw_pci = {
> >>>> -   .setup          = dw_pcie_setup,
> >>>> -   .scan           = dw_pcie_scan_bus,
> >>>> -   .map_irq        = dw_pcie_map_irq,
> >>>> -};
> >>>> -
> >>>>  void dw_pcie_setup_rc(struct pcie_port *pp)
> >>>>  {
> >>>>     u32 val;
> >>>> diff --git a/drivers/pci/host/pcie-designware.h
> >>> b/drivers/pci/host/pcie-designware.h
> >>>> index d0bbd27..ab78710 100644
> >>>> --- a/drivers/pci/host/pcie-designware.h
> >>>> +++ b/drivers/pci/host/pcie-designware.h
> >>>> @@ -34,7 +34,7 @@ struct pcie_port {
> >>>>     u64                     cfg1_mod_base;
> >>>>     void __iomem            *va_cfg1_base;
> >>>>     u32                     cfg1_size;
> >>>> -   u64                     io_base;
> >>>> +   resource_size_t                 io_base;
> >>>>     u64                     io_mod_base;
> >>>>     phys_addr_t             io_bus_addr;
> >>>>     u32                     io_size;
> >>>> @@ -42,10 +42,10 @@ struct pcie_port {
> >>>>     u64                     mem_mod_base;
> >>>>     phys_addr_t             mem_bus_addr;
> >>>>     u32                     mem_size;
> >>>> -   struct resource         cfg;
> >>>> -   struct resource         io;
> >>>> -   struct resource         mem;
> >>>> -   struct resource         busn;
> >>>> +   struct resource         *cfg;
> >>>> +   struct resource         *io;
> >>>> +   struct resource         *mem;
> >>>> +   struct resource         *busn;
> >>>>     int                     irq;
> >>>>     u32                     lanes;
> >>>>     struct pcie_host_ops    *ops;
> >>>> diff --git a/drivers/pci/host/pcie-spear13xx.c
> >>> b/drivers/pci/host/pcie-spear13xx.c
> >>>> index 020d788..e78ddf8 100644
> >>>> --- a/drivers/pci/host/pcie-spear13xx.c
> >>>> +++ b/drivers/pci/host/pcie-spear13xx.c
> >>>> @@ -287,7 +287,7 @@ static int spear13xx_add_pcie_port(struct
> >>> pcie_port *pp,
> >>>>             return ret;
> >>>>     }
> >>>>
> >>>> -   pp->root_bus_nr = -1;
> >>>> +   pp->root_bus_nr = 0;
> >>>>     pp->ops = &spear13xx_pcie_host_ops;
> >>>>
> >>>>     ret = dw_pcie_host_init(pp);
> >>>>
> >>>> --------------------------------------------------
> >>>> --------------------------------------------------
> >>>>
> >>>>> -----Original Message-----
> >>>>> From: Wangzhou (B)
> >>>>> Sent: Thursday, June 11, 2015 6:44 AM
> >>>>> To: Gabriele Paoloni
> >>>>> Cc: Lorenzo Pieralisi; James Morse; Bjorn Helgaas; Jingoo Han;
> >>> Pratyush
> >>>>> Anand; Arnd Bergmann; fabrice.gasnier@st.com; Liviu Dudau; linux-
> >>>>> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> >>>>> devicetree@vger.kernel.org; Yuanzhichang; Zhudacai; zhangjukuo;
> >>>>> qiuzhenfa; Liguozhu (Kenneth)
> >>>>> Subject: Re: [PATCH v2 2/4] PCI: designware: Add ARM64 support
> >>>>>
> >>>>> On 2015/6/10 21:35, Gabriele Paoloni wrote:
> >>>>>> Hi Zhou Wang and all
> >>>>>>
> >>>>>> I have worked on a patch that unify ARM and ARM64. As you can see I
> >>>>> have removed the parser and now I use
> >>>>> "of_pci_get_host_bridge_resources" in order to retrieve the
> >>> resources
> >>>>> associated to each pci host bridge window.
> >>>>>> The resources now are not copied to the designware pcie_port pp,
> >>>>> instead they are passed by pointer.
> >>>>>>
> >>>>>> This patch is intended to replace entirely "[PATCH v2 2/4]"; so I
> >>>>> have also included all the changes about the other drivers
> >>>>>>
> >>>>>> Please find the patch inline below.
> >>>>>>
> >>>>>> Let me know if you think it is ok.
> >>>>>>
> >>>>>> Regards
> >>>>>>
> >>>>>> Gab
> >>>>>>
> >>>>>> ------------------------------------
> >>>>>> ------------------------------------
> >>>>>>
> >>>>>> This patch is a rework of
> >>>>>> "[PATCH v2 2/4] PCI: designware: Add ARM64 support" from Zhou Wang.
> >>>>>>
> >>>>>> The intention is to complete the unification between ARM and
> >>>>>> ARM64 now that the dependency on arch/arm/kernel/bios32.c is gone.
> >>>>>>
> >>>>>> I have also included the rework asked by James Morse:
> >>>>>> io_base declared as resource_size_t
> >>>>>>
> >>>>>> It compiles fine on ARCH arm and arm64.
> >>>>>
> >>>>> Hi Gabriele,
> >>>>>
> >>>>> I manually apply this patch on my series, as there are some format
> >>>>> errors
> >>>>> about this patch. And I think this patch is a experimental one, it
> >>>>> could not
> >>>>> be compiled successfully.
> >>>>>
> >>>>>>
> >>>>>> It needs to be tested.
> >>>>>>
> >>>>>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> >>>>>>
> >>>>>> [...]
> >>>>>>
> >>>>>> -int dw_pcie_host_init(struct pcie_port *pp)
> >>>>>> +int __init dw_pcie_host_init(struct pcie_port *pp)
> >>>>>>  {
> >>>>>>   struct device_node *np = pp->dev->of_node;
> >>>>>>   struct platform_device *pdev = to_platform_device(pp->dev);
> >>>>>> - struct of_pci_range range;
> >>>>>> - struct of_pci_range_parser parser;
> >>>>>> + struct pci_bus *bus;
> >>>>>>   struct resource *cfg_res;
> >>>>>> + LIST_HEAD(res);
> >>>>>>   u32 val, na, ns;
> >>>>>>   const __be32 *addrp;
> >>>>>>   int i, index, ret;
> >>>>>> + int rlen;
> >>>>>> + struct pci_host_bridge_window *win;
> >>>>>
> >>>>> This struct is not in latest kernel, I think you should use struct
> >>>>> resource_entry.
> >>>>>
> >>>>> Thanks,
> >>>>> Zhou
> >>>>>
> >>>>>> + const __be32 *parser_range_end = of_get_property(np, "ranges",
> >>>>> &rlen);
> >>>>>> +
> >>>>>> + if (parser_range_end == NULL)
> >>>>>> +                 return -ENOENT;
> >>>>>> + parser_range_end += rlen/sizeof(__be32);
> >>>>>> +
> >>>>>>
> >>>>>>   /* Find the address cell size and the number of cells in order to
> >>>>> get
> >>>>>>    * the untranslated address.
> >>>>>> @@ -375,78 +375,67 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >>>>>>           dev_err(pp->dev, "missing *config* reg space\n");
> >>>>>>   }
> >>>>>>
> >>>>>> - if (of_pci_range_parser_init(&parser, np)) {
> >>>>>> -         dev_err(pp->dev, "missing ranges property\n");
> >>>>>> -         return -EINVAL;
> >>>>>> - }
> >>>>>> + ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp-
> >>>>>> io_base);
> >>>>>> + if (ret)
> >>>>>> +         return ret;
> >>>>>>
> >>>>>>   /* Get the I/O and memory ranges from DT */
> >>>>>> - for_each_of_pci_range(&parser, &range) {
> >>>>>> -         unsigned long restype = range.flags & IORESOURCE_TYPE_BITS;
> >>>>>> -
> >>>>>> -         if (restype == IORESOURCE_IO) {
> >>>>>> -                 of_pci_range_to_resource(&range, np, &pp->io);
> >>>>>> -                 pp->io.name = "I/O";
> >>>>>> -                 pp->io.start = max_t(resource_size_t,
> >>>>>> -                                      PCIBIOS_MIN_IO,
> >>>>>> -                                      range.pci_addr + global_io_offset);
> >>>>>> -                 pp->io.end = min_t(resource_size_t,
> >>>>>> -                                    IO_SPACE_LIMIT,
> >>>>>> -                                    range.pci_addr + range.size
> >>>>>> -                                    + global_io_offset - 1);
> >>>>>> -                 pp->io_size = resource_size(&pp->io);
> >>>>>> -                 pp->io_bus_addr = range.pci_addr;
> >>>>>> -                 pp->io_base = range.cpu_addr;
> >>>>>> -
> >>>>>> -                 /* Find the untranslated IO space address */
> >>>>>> -                 pp->io_mod_base = of_read_number(parser.range -
> >>>>>> -                                                  parser.np + na, ns);
> >>>>>> -         }
> >>>>>> -         if (restype == IORESOURCE_MEM) {
> >>>>>> -                 of_pci_range_to_resource(&range, np, &pp->mem);
> >>>>>> -                 pp->mem.name = "MEM";
> >>>>>> -                 pp->mem_size = resource_size(&pp->mem);
> >>>>>> -                 pp->mem_bus_addr = range.pci_addr;
> >>>>>> -
> >>>>>> -                 /* Find the untranslated MEM space address */
> >>>>>> -                 pp->mem_mod_base = of_read_number(parser.range -
> >>>>>> -                                                   parser.np + na, ns);
> >>>>>> -         }
> >>>>>> -         if (restype == 0) {
> >>>>>> -                 of_pci_range_to_resource(&range, np, &pp->cfg);
> >>>>>> -                 pp->cfg0_size = resource_size(&pp->cfg)/2;
> >>>>>> -                 pp->cfg1_size = resource_size(&pp->cfg)/2;
> >>>>>> -                 pp->cfg0_base = pp->cfg.start;
> >>>>>> -                 pp->cfg1_base = pp->cfg.start + pp->cfg0_size;
> >>>>>> + list_for_each_entry(win, &res, list) {
> >>>>>> +         switch (resource_type(win->res)) {
> >>>>>> +         case IORESOURCE_IO:
> >>>>>> +                 pp->io = win->res;
> >>>>>> +                 pp->io->name = "I/O";
> >>>>>> +                 pp->io_size = resource_size(pp->io);
> >>>>>> +                 pp->io_bus_addr = pp->io->start - win->offset;
> >>>>>> +                 /* magic 5 below comes from magic na and ns in
> >>>>>> +                  * of_pci_range_parser_init()                 */
> >>>>>> +                 pp->io_mod_base = of_read_number(parser_range_end -
> >>>>>> +                                 of_n_addr_cells(np) - 5 + na, ns);
> >>>>>> +                 ret = pci_remap_iospace(pp->io, pp->io_base);
> >>>>>> +                 if (ret) {
> >>>>>> +                         dev_warn(pp->dev, "error %d: failed to map
> >>>>> resource %pR\n",
> >>>>>> +                         ret, pp->io);
> >>>>>> +                 continue;
> >>>>>> +                 }
> >>>>>> +                 break;
> >>>>>> +         case IORESOURCE_MEM:
> >>>>>> +                 pp->mem = win->res;
> >>>>>> +                 pp->mem->name = "MEM";
> >>>>>> +                 pp->mem_size = resource_size(pp->mem);
> >>>>>> +                 pp->mem_bus_addr = pp->mem->start - win->offset;
> >>>>>> +                 pp->mem_mod_base = of_read_number(parser_range_end -
> >>>>>> +                                 of_n_addr_cells(np) - 5 + na, ns);
> >>>>>> +                 break;
> >>>>>> +         case 0:
> >>>>>> +                 pp->cfg = win->res;
> >>>>>> +                 pp->cfg0_size = resource_size(pp->cfg)/2;
> >>>>>> +                 pp->cfg1_size = resource_size(pp->cfg)/2;
> >>>>>> +                 pp->cfg0_base = pp->cfg->start;
> >>>>>> +                 pp->cfg1_base = pp->cfg->start + pp->cfg0_size;
> >>>>>>
> >>>>>>                   /* Find the untranslated configuration space address
> >>>>> */
> >>>>>> -                 pp->cfg0_mod_base = of_read_number(parser.range -
> >>>>>> -                                                    parser.np + na, ns);
> >>>>>> -                 pp->cfg1_mod_base = pp->cfg0_mod_base +
> >>>>>> -                                     pp->cfg0_size;
> >>>>>> +                 pp->cfg0_mod_base = of_read_number(parser_range_end -
> >>>>>> +                                 of_n_addr_cells(np) - 5 + na, ns);
> >>>>>> +                 pp->cfg1_mod_base = pp->cfg0_mod_base + pp->cfg0_size;
> >>>>>> +                 break;
> >>>>>> +         case IORESOURCE_BUS:
> >>>>>> +                 pp->busn = win->res;
> >>>>>> +                 break;
> >>>>>> +         default:
> >>>>>> +                 continue;
> >>>>>>           }
> >>>>>>   }
> >>>>>>
> >>>>>> - ret = of_pci_parse_bus_range(np, &pp->busn);
> >>>>>> - if (ret < 0) {
> >>>>>> -         pp->busn.name = np->name;
> >>>>>> -         pp->busn.start = 0;
> >>>>>> -         pp->busn.end = 0xff;
> >>>>>> -         pp->busn.flags = IORESOURCE_BUS;
> >>>>>> -         dev_dbg(pp->dev, "failed to parse bus-range property: %d,
> >>>>> using default %pR\n",
> >>>>>> -                 ret, &pp->busn);
> >>>>>> - }
> >>>>>> -
> >>>>>>   if (!pp->dbi_base) {
> >>>>>> -         pp->dbi_base = devm_ioremap(pp->dev, pp->cfg.start,
> >>>>>> -                                 resource_size(&pp->cfg));
> >>>>>> +         pp->dbi_base = devm_ioremap(pp->dev, pp->cfg->start,
> >>>>>> +                                 resource_size(pp->cfg));
> >>>>>>           if (!pp->dbi_base) {
> >>>>>>                   dev_err(pp->dev, "error with ioremap\n");
> >>>>>>                   return -ENOMEM;
> >>>>>>           }
> >>>>>>   }
> >>>>>>
> >>>>>> - pp->mem_base = pp->mem.start;
> >>>>>> + pp->mem_base = pp->mem->start;
> >>>>>>
> >>>>>>   if (!pp->va_cfg0_base) {
> >>>>>>           pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base, @@
> >>>>> -493,24 +482,47 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >>>>>>   if (pp->ops->host_init)
> >>>>>>           pp->ops->host_init(pp);
> >>>>>>
> >>>>>> - dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
> >>>>>> + if (dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0)
> >>>>>> +                 != PCIBIOS_SUCCESSFUL)
> >>>>>> +         return -EINVAL;
> >>>>>>
> >>>>>>   /* program correct class for RC */
> >>>>>> - dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2,
> >>>>> PCI_CLASS_BRIDGE_PCI);
> >>>>>> + if (dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2,
> >>>>> PCI_CLASS_BRIDGE_PCI)
> >>>>>> +                 != PCIBIOS_SUCCESSFUL)
> >>>>>> +         return -EINVAL;
> >>>>>> +
> >>>>>> + if (dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4,
> >>>>> &val)
> >>>>>> +                 != PCIBIOS_SUCCESSFUL)
> >>>>>> +         return -EINVAL;
> >>>>>>
> >>>>>> - dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
> >>>>>>   val |= PORT_LOGIC_SPEED_CHANGE;
> >>>>>> - dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
> >>>>>>
> >>>>>> -#ifdef CONFIG_PCI_MSI
> >>>>>> - dw_pcie_msi_chip.dev = pp->dev;
> >>>>>> - dw_pci.msi_ctrl = &dw_pcie_msi_chip;
> >>>>>> + if (dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val)
> >>>>>> +                 != PCIBIOS_SUCCESSFUL)
> >>>>>> +         return -EINVAL;
> >>>>>> +
> >>>>>> + bus = pci_create_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops,
> >>>>>> +                       pp, &res);
> >>>>>> + if (!bus)
> >>>>>> +         return -ENOMEM;
> >>>>>> +
> >>>>>> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> >>>>>> + bus->msi = container_of(&pp->irq_domain, struct msi_controller,
> >>>>>> +domain); #else
> >>>>>> + bus->msi = &dw_pcie_msi_chip;
> >>>>>>  #endif
> >>>>>>
> >>>>>> - dw_pci.nr_controllers = 1;
> >>>>>> - dw_pci.private_data = (void **)&pp;
> >>>>>> + pci_scan_child_bus(bus);
> >>>>>> + if (pp->ops->scan_bus)
> >>>>>> +         pp->ops->scan_bus(pp);
> >>>>>>
> >>>>>> - pci_common_init_dev(pp->dev, &dw_pci);
> >>>>>> +#ifdef CONFIG_ARM
> >>>>>> + /* support old dtbs that incorrectly describe IRQs */
> >>>>>> + pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> >>>>> #endif
> >>>>>> +
> >>>>>> + pci_assign_unassigned_bus_resources(bus);
> >>>>>> + pci_bus_add_devices(bus);
> >>>>>>
> >>>>>>   return 0;
> >>>>>>  }
> >>>>>> @@ -653,7 +665,7 @@ static int dw_pcie_valid_config(struct
> >>> pcie_port
> >>>>> *pp,  static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int
> >>>>> where,
> >>>>>>                   int size, u32 *val)
> >>>>>>  {
> >>>>>> - struct pcie_port *pp = sys_to_pcie(bus->sysdata);
> >>>>>> + struct pcie_port *pp = bus->sysdata;
> >>>>>>   int ret;
> >>>>>>
> >>>>>>   if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) { @@ -
> >>>>> 677,7 +689,7 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32
> >>>>> devfn, int where,  static int dw_pcie_wr_conf(struct pci_bus *bus,
> >>> u32
> >>>>> devfn,
> >>>>>>                   int where, int size, u32 val)
> >>>>>>  {
> >>>>>> - struct pcie_port *pp = sys_to_pcie(bus->sysdata);
> >>>>>> + struct pcie_port *pp = bus->sysdata;
> >>>>>>   int ret;
> >>>>>>
> >>>>>>   if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) @@ -
> >>>>> 701,64 +713,6 @@ static struct pci_ops dw_pcie_ops = {
> >>>>>>   .write = dw_pcie_wr_conf,
> >>>>>>  };
> >>>>>>
> >>>>>> -static int dw_pcie_setup(int nr, struct pci_sys_data *sys) -{
> >>>>>> - struct pcie_port *pp;
> >>>>>> -
> >>>>>> - pp = sys_to_pcie(sys);
> >>>>>> -
> >>>>>> - if (global_io_offset < SZ_1M && pp->io_size > 0) {
> >>>>>> -         sys->io_offset = global_io_offset - pp->io_bus_addr;
> >>>>>> -         pci_ioremap_io(global_io_offset, pp->io_base);
> >>>>>> -         global_io_offset += SZ_64K;
> >>>>>> -         pci_add_resource_offset(&sys->resources, &pp->io,
> >>>>>> -                                 sys->io_offset);
> >>>>>> - }
> >>>>>> -
> >>>>>> - sys->mem_offset = pp->mem.start - pp->mem_bus_addr;
> >>>>>> - pci_add_resource_offset(&sys->resources, &pp->mem, sys-
> >>>>>> mem_offset);
> >>>>>> - pci_add_resource(&sys->resources, &pp->busn);
> >>>>>> -
> >>>>>> - return 1;
> >>>>>> -}
> >>>>>> -
> >>>>>> -static struct pci_bus *dw_pcie_scan_bus(int nr, struct
> >>> pci_sys_data
> >>>>> *sys) -{
> >>>>>> - struct pci_bus *bus;
> >>>>>> - struct pcie_port *pp = sys_to_pcie(sys);
> >>>>>> -
> >>>>>> - pp->root_bus_nr = sys->busnr;
> >>>>>> - bus = pci_create_root_bus(pp->dev, sys->busnr,
> >>>>>> -                           &dw_pcie_ops, sys, &sys->resources);
> >>>>>> - if (!bus)
> >>>>>> -         return NULL;
> >>>>>> -
> >>>>>> - pci_scan_child_bus(bus);
> >>>>>> -
> >>>>>> - if (bus && pp->ops->scan_bus)
> >>>>>> -         pp->ops->scan_bus(pp);
> >>>>>> -
> >>>>>> - return bus;
> >>>>>> -}
> >>>>>> -
> >>>>>> -static int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8
> >>>>> pin) -{
> >>>>>> - struct pcie_port *pp = sys_to_pcie(dev->bus->sysdata);
> >>>>>> - int irq;
> >>>>>> -
> >>>>>> - irq = of_irq_parse_and_map_pci(dev, slot, pin);
> >>>>>> - if (!irq)
> >>>>>> -         irq = pp->irq;
> >>>>>> -
> >>>>>> - return irq;
> >>>>>> -}
> >>>>>> -
> >>>>>> -static struct hw_pci dw_pci = {
> >>>>>> - .setup          = dw_pcie_setup,
> >>>>>> - .scan           = dw_pcie_scan_bus,
> >>>>>> - .map_irq        = dw_pcie_map_irq,
> >>>>>> -};
> >>>>>> -
> >>>>>>  void dw_pcie_setup_rc(struct pcie_port *pp)  {
> >>>>>>   u32 val;
> >>>>>> diff --git a/drivers/pci/host/pcie-designware.h
> >>>>> b/drivers/pci/host/pcie-designware.h
> >>>>>> index d0bbd27..ab78710 100644
> >>>>>> --- a/drivers/pci/host/pcie-designware.h
> >>>>>> +++ b/drivers/pci/host/pcie-designware.h
> >>>>>> @@ -34,7 +34,7 @@ struct pcie_port {
> >>>>>>   u64                     cfg1_mod_base;
> >>>>>>   void __iomem            *va_cfg1_base;
> >>>>>>   u32                     cfg1_size;
> >>>>>> - u64                     io_base;
> >>>>>> + resource_size_t                 io_base;
> >>>>>>   u64                     io_mod_base;
> >>>>>>   phys_addr_t             io_bus_addr;
> >>>>>>   u32                     io_size;
> >>>>>> @@ -42,10 +42,10 @@ struct pcie_port {
> >>>>>>   u64                     mem_mod_base;
> >>>>>>   phys_addr_t             mem_bus_addr;
> >>>>>>   u32                     mem_size;
> >>>>>> - struct resource         cfg;
> >>>>>> - struct resource         io;
> >>>>>> - struct resource         mem;
> >>>>>> - struct resource         busn;
> >>>>>> + struct resource         *cfg;
> >>>>>> + struct resource         *io;
> >>>>>> + struct resource         *mem;
> >>>>>> + struct resource         *busn;
> >>>>>>   int                     irq;
> >>>>>>   u32                     lanes;
> >>>>>>   struct pcie_host_ops    *ops;
> >>>>>> diff --git a/drivers/pci/host/pcie-spear13xx.c
> >>>>> b/drivers/pci/host/pcie-spear13xx.c
> >>>>>> index 020d788..e78ddf8 100644
> >>>>>> --- a/drivers/pci/host/pcie-spear13xx.c
> >>>>>> +++ b/drivers/pci/host/pcie-spear13xx.c
> >>>>>> @@ -287,7 +287,7 @@ static int spear13xx_add_pcie_port(struct
> >>>>> pcie_port *pp,
> >>>>>>           return ret;
> >>>>>>   }
> >>>>>>
> >>>>>> - pp->root_bus_nr = -1;
> >>>>>> + pp->root_bus_nr = 0;
> >>>>>>   pp->ops = &spear13xx_pcie_host_ops;
> >>>>>>
> >>>>>>   ret = dw_pcie_host_init(pp);
> >>>>>> ------------------------------------
> >>>>>> ------------------------------------
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>> -----Original Message-----
> >>>>>>> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> >>>>>>> Sent: Tuesday, June 09, 2015 12:15 PM
> >>>>>>> To: Wangzhou (B)
> >>>>>>> Cc: James Morse; Bjorn Helgaas; Jingoo Han; Pratyush Anand; Arnd
> >>>>>>> Bergmann; fabrice.gasnier@st.com; Liviu Dudau; linux-
> >>>>>>> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> >>>>>>> devicetree@vger.kernel.org; Gabriele Paoloni; Yuanzhichang;
> >>> Zhudacai;
> >>>>>>> zhangjukuo; qiuzhenfa; Liguozhu (Kenneth)
> >>>>>>> Subject: Re: [PATCH v2 2/4] PCI: designware: Add ARM64 support
> >>>>>>>
> >>>>>>> On Fri, Jun 05, 2015 at 09:11:30AM +0100, Zhou Wang wrote:
> >>>>>>>
> >>>>>>> [...]
> >>>>>>>
> >>>>>>>>>> -int dw_pcie_host_init(struct pcie_port *pp)
> >>>>>>>>>> +int __init dw_pcie_host_init(struct pcie_port *pp)
> >>>>>>>>>>  {
> >>>>>>>>>>       struct device_node *np = pp->dev->of_node;
> >>>>>>>>>>       struct platform_device *pdev = to_platform_device(pp->dev);
> >>>>>>>>>>       struct of_pci_range range;
> >>>>>>>>>>       struct of_pci_range_parser parser;
> >>>>>>>>>> +     struct pci_bus *bus;
> >>>>>>>>>>       struct resource *cfg_res;
> >>>>>>>>>> +     LIST_HEAD(res);
> >>>>>>>>>>       u32 val, na, ns;
> >>>>>>>>>>       const __be32 *addrp;
> >>>>>>>>>>       int i, index, ret;
> >>>>>>>>>> @@ -502,15 +498,49 @@ int dw_pcie_host_init(struct pcie_port
> >>> *pp)
> >>>>>>>>>>       val |= PORT_LOGIC_SPEED_CHANGE;
> >>>>>>>>>>       dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4,
> >>>>>>> val);
> >>>>>>>>>>
> >>>>>>>>>> -#ifdef CONFIG_PCI_MSI
> >>>>>>>>>> -     dw_pcie_msi_chip.dev = pp->dev;
> >>>>>>>>>> -     dw_pci.msi_ctrl = &dw_pcie_msi_chip;
> >>>>>>>>>> +#ifdef CONFIG_ARM
> >>>>>>>>>> +     /*
> >>>>>>>>>> +      * FIXME: we should really be able to use
> >>>>>>>>>> +      * of_pci_get_host_bridge_resources on arm32 as well,
> >>>>>>>>>> +      * but the conversion needs some more testing
> >>>>>>>>>> +      */
> >>>>>>>>>> +     if (global_io_offset < SZ_1M && pp->io_size > 0) {
> >>>>>>>>>> +             pci_ioremap_io(global_io_offset, pp->io_base);
> >>>>>>>>>> +             global_io_offset += SZ_64K;
> >>>>>>>>>> +             pci_add_resource_offset(&res, &pp->io,
> >>>>>>>>>> +                                     global_io_offset - pp->io_bus_addr);
> >>>>>>>>>> +     }
> >>>>>>>>>> +     pci_add_resource_offset(&res, &pp->mem,
> >>>>>>>>>> +                             pp->mem.start - pp->mem_bus_addr);
> >>>>>>>>>> +     pci_add_resource(&res, &pp->busn);
> >>>>>>>>>
> >>>>>>>>> I don't think this #ifdef is necessary. In the spirit of 'the
> >>>>>>>>> conversion needs some more testing', I removed it leaving just
> >>> the
> >>>>>>> below arm64 code.
> >>>>>>>>>
> >>>>>>>>> This worked on my Freescale i.MX6 Quad SABRE Lite Board, I went
> >>> as
> >>>>>>>>> far as scanning for wireless access points.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> I think it depends on which kind of PCIe device you use, if we
> >>> use
> >>>>> a
> >>>>>>>> PCIe device with a I/O Bar, it may not work well without above
> >>> code.
> >>>>>>>> But so far, I have not met a PCIe device which must work with a
> >>> I/O
> >>>>>>> Bar.
> >>>>>>>
> >>>>>>> There are two problems here:
> >>>>>>>
> >>>>>>> 1) the io_base address you get from
> >>> of_pci_get_host_bridge_resources
> >>>>>>>    must be mapped using pci_remap_iospace. You are not doing this,
> >>>>> so
> >>>>>>>    even if you had a PCIe card with I/O bar it would not work on
> >>>>> arm64
> >>>>>>>    as the code stands. Remember that I/O space on arm/arm64 works
> >>> as
> >>>>> a
> >>>>>>>    memory access with offset from PCI_IOBASE and that's the value
> >>>>> you
> >>>>>>> get
> >>>>>>>    in the I/O resource. See:
> >>>>>>>
> >>>>>>>    drivers/pci/host/pci-host-generic.c
> >>>>>>>    drivers/pci/host/pci-versatile.c
> >>>>>>>    drivers/pci/host/pci-xgene.c
> >>>>>>>
> >>>>>>> 2) (1) above would sort out I/O space access for both arm and
> >>> arm64
> >>>>> so,
> >>>>>>>    as James said, the #ifdef is useless.
> >>>>>>>
> >>>>>>> I hope this makes things clearer.
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Lorenzo
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>> +#else
> >>>>>>>>>> +     ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res,
> >>>>>>>>>> +&pp->io_base);
> >>>>>>>>>
> >>>>>>>>> of_pci_get_host_bridge_resources expects &pp->io_base to be a
> >>>>>>>>> resource_size_t*, but &io_base is u64*. This generates a warning
> >>>>> on
> >>>>>>>>> arm with the above change. Changing the the type in
> >>>>>>>>> drivers/pci/host/pcie-designware.h fixes this.
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Thanks,
> >>>>>>>>>
> >>>>>>>>> James
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> OK, will modify this in next version.
> >>>>>>>>
> >>>>>>>> Best Regards and thanks again for your test, Zhou
> >>>>>>>>
> >>>>>>>>>> +     if (ret)
> >>>>>>>>>> +             return ret;
> >>>>>>>>>> +#endif
> >>>>>>>>>> +
> >>>>>>>>>> +     bus = pci_create_root_bus(pp->dev, pp->root_bus_nr,
> >>>>>>> &dw_pcie_ops,
> >>>>>>>>>> +                           pp, &res);
> >>>>>>>>>> +     if (!bus)
> >>>>>>>>>> +             return -ENOMEM;
> >>>>>>>>>> +
> >>>>>>>>>> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> >>>>>>>>>> +     bus->msi = container_of(&pp->irq_domain, struct
> >>>>>>> msi_controller,
> >>>>>>>>>> +domain); #else
> >>>>>>>>>> +     bus->msi = &dw_pcie_msi_chip;
> >>>>>>>>>>  #endif
> >>>>>>>>>>
> >>>>>>>>>> -     dw_pci.nr_controllers = 1;
> >>>>>>>>>> -     dw_pci.private_data = (void **)&pp;
> >>>>>>>>>> +     pci_scan_child_bus(bus);
> >>>>>>>>>> +     if (pp->ops->scan_bus)
> >>>>>>>>>> +             pp->ops->scan_bus(pp);
> >>>>>>>>>>
> >>>>>>>>>> -     pci_common_init_dev(pp->dev, &dw_pci);
> >>>>>>>>>> +#ifdef CONFIG_ARM
> >>>>>>>>>> +     /* support old dtbs that incorrectly describe IRQs */
> >>>>>>>>>> +     pci_fixup_irqs(pci_common_swizzle,
> >>>>>>> of_irq_parse_and_map_pci);
> >>>>>>>>>> +#endif
> >>>>>>>>>> +
> >>>>>>>>>> +     pci_assign_unassigned_bus_resources(bus);
> >>>>>>>>>> +     pci_bus_add_devices(bus);
> >>>>>>>>>>
> >>>>>>>>>>       return 0;
> >>>>>>>>>>  }
> >>>>>>>>>> @@ -653,7 +683,7 @@ static int dw_pcie_valid_config(struct
> >>>>>>>>>> pcie_port *pp,  static int dw_pcie_rd_conf(struct pci_bus *bus,
> >>>>>>> u32 devfn, int where,
> >>>>>>>>>>                       int size, u32 *val)
> >>>>>>>>>>  {
> >>>>>>>>>> -     struct pcie_port *pp = sys_to_pcie(bus->sysdata);
> >>>>>>>>>> +     struct pcie_port *pp = bus->sysdata;
> >>>>>>>>>>       int ret;
> >>>>>>>>>>
> >>>>>>>>>>       if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
> >>>>>>> { @@
> >>>>>>>>>> -677,7 +707,7 @@ static int dw_pcie_rd_conf(struct pci_bus *bus,
> >>>>>>>>>> u32 devfn, int where,  static int dw_pcie_wr_conf(struct
> >>> pci_bus
> >>>>>>> *bus, u32 devfn,
> >>>>>>>>>>                       int where, int size, u32 val)
> >>>>>>>>>>  {
> >>>>>>>>>> -     struct pcie_port *pp = sys_to_pcie(bus->sysdata);
> >>>>>>>>>> +     struct pcie_port *pp = bus->sysdata;
> >>>>>>>>>>       int ret;
> >>>>>>>>>>
> >>>>>>>>>>       if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) @@
> >>>>>>>>>> -701,64 +731,6 @@ static struct pci_ops dw_pcie_ops = {
> >>>>>>>>>>       .write = dw_pcie_wr_conf,
> >>>>>>>>>>  };
> >>>>>>>>>>
> >>>>>>>>>> -static int dw_pcie_setup(int nr, struct pci_sys_data *sys) -{
> >>>>>>>>>> -     struct pcie_port *pp;
> >>>>>>>>>> -
> >>>>>>>>>> -     pp = sys_to_pcie(sys);
> >>>>>>>>>> -
> >>>>>>>>>> -     if (global_io_offset < SZ_1M && pp->io_size > 0) {
> >>>>>>>>>> -             sys->io_offset = global_io_offset - pp->io_bus_addr;
> >>>>>>>>>> -             pci_ioremap_io(global_io_offset, pp->io_base);
> >>>>>>>>>> -             global_io_offset += SZ_64K;
> >>>>>>>>>> -             pci_add_resource_offset(&sys->resources, &pp->io,
> >>>>>>>>>> -                                     sys->io_offset);
> >>>>>>>>>> -     }
> >>>>>>>>>> -
> >>>>>>>>>> -     sys->mem_offset = pp->mem.start - pp->mem_bus_addr;
> >>>>>>>>>> -     pci_add_resource_offset(&sys->resources, &pp->mem, sys-
> >>>>>>>> mem_offset);
> >>>>>>>>>> -     pci_add_resource(&sys->resources, &pp->busn);
> >>>>>>>>>> -
> >>>>>>>>>> -     return 1;
> >>>>>>>>>> -}
> >>>>>>>>>> -
> >>>>>>>>>> -static struct pci_bus *dw_pcie_scan_bus(int nr, struct
> >>>>>>>>>> pci_sys_data *sys) -{
> >>>>>>>>>> -     struct pci_bus *bus;
> >>>>>>>>>> -     struct pcie_port *pp = sys_to_pcie(sys);
> >>>>>>>>>> -
> >>>>>>>>>> -     pp->root_bus_nr = sys->busnr;
> >>>>>>>>>> -     bus = pci_create_root_bus(pp->dev, sys->busnr,
> >>>>>>>>>> -                               &dw_pcie_ops, sys, &sys->resources);
> >>>>>>>>>> -     if (!bus)
> >>>>>>>>>> -             return NULL;
> >>>>>>>>>> -
> >>>>>>>>>> -     pci_scan_child_bus(bus);
> >>>>>>>>>> -
> >>>>>>>>>> -     if (bus && pp->ops->scan_bus)
> >>>>>>>>>> -             pp->ops->scan_bus(pp);
> >>>>>>>>>> -
> >>>>>>>>>> -     return bus;
> >>>>>>>>>> -}
> >>>>>>>>>> -
> >>>>>>>>>> -static int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot,
> >>>>> u8
> >>>>>>>>>> pin) -{
> >>>>>>>>>> -     struct pcie_port *pp = sys_to_pcie(dev->bus->sysdata);
> >>>>>>>>>> -     int irq;
> >>>>>>>>>> -
> >>>>>>>>>> -     irq = of_irq_parse_and_map_pci(dev, slot, pin);
> >>>>>>>>>> -     if (!irq)
> >>>>>>>>>> -             irq = pp->irq;
> >>>>>>>>>> -
> >>>>>>>>>> -     return irq;
> >>>>>>>>>> -}
> >>>>>>>>>> -
> >>>>>>>>>> -static struct hw_pci dw_pci = {
> >>>>>>>>>> -     .setup          = dw_pcie_setup,
> >>>>>>>>>> -     .scan           = dw_pcie_scan_bus,
> >>>>>>>>>> -     .map_irq        = dw_pcie_map_irq,
> >>>>>>>>>> -};
> >>>>>>>>>> -
> >>>>>>>>>>  void dw_pcie_setup_rc(struct pcie_port *pp)  {
> >>>>>>>>>>       u32 val;
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> .
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-
> >>>>> pci"
> >>>>>>>> in the body of a message to majordomo@vger.kernel.org More
> >>>>> majordomo
> >>>>>>>> info at  http://vger.kernel.org/majordomo-info.html
> >>>>>>>>
> >>>>>>
> >>>>>> .
> >>>>>>
> >>>>>
> >>>>
> >>>>
> >>>> .
> >>>>
> >>>
> >>
> >
> > .
> >
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
