Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37215 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbbG2RXj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 29 Jul 2015 13:23:39 -0400
Date: Wed, 29 Jul 2015 18:24:24 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
	James Morse <James.Morse@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"yuanzhichang@hisilicon.com" <yuanzhichang@hisilicon.com>,
	"zhudacai@hisilicon.com" <zhudacai@hisilicon.com>,
	"zhangjukuo@huawei.com" <zhangjukuo@huawei.com>,
	"qiuzhenfa@hisilicon.com" <qiuzhenfa@hisilicon.com>,
	"liudongdong3@huawei.com" <liudongdong3@huawei.com>,
	"qiujiang@huawei.com" <qiujiang@huawei.com>,
	"kangfenglong@huawei.com" <kangfenglong@huawei.com>,
	"liguozhu@hisilicon.com" <liguozhu@hisilicon.com>
Subject: Re: [PATCH v5 2/5] PCI: designware: Add ARM64 support
Message-ID: <20150729172423.GB29159@red-moon>
References: <1437794486-21134-1-git-send-email-wangzhou1@hisilicon.com>
 <1437794486-21134-3-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437794486-21134-3-git-send-email-wangzhou1@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 25, 2015 at 04:21:23AM +0100, Zhou Wang wrote:
> This patch tries to unify ARM32 and ARM64 PCIe in designware driver. Delete
> function dw_pcie_setup, dw_pcie_scan_bus, dw_pcie_map_irq and struct hw_pci,
> move related operations to dw_pcie_host_init. Also set pp->root_bus_nr = 0 in
> each PCIe host driver which is based on pcie-designware. This patch also try

Memory for ports is kzalloc'ed, so there is no need to zero it. I still
think that you should explain the root_bus_nr setting to 0 a bit
better, why you make the change and why it is safe.

[...]

> -int dw_pcie_host_init(struct pcie_port *pp)
> +int __init dw_pcie_host_init(struct pcie_port *pp)
>  {
>         struct device_node *np = pp->dev->of_node;
>         struct platform_device *pdev = to_platform_device(pp->dev);
> -       struct of_pci_range range;
> -       struct of_pci_range_parser parser;
> +       struct pci_bus *bus;
>         struct resource *cfg_res;
> -       u32 val, na, ns;
> +       LIST_HEAD(res);
> +       u32 val, ns;
>         const __be32 *addrp;
>         int i, index, ret;
> +       struct resource_entry *win;
> 
> -       /* Find the address cell size and the number of cells in order to get
> -        * the untranslated address.
> -        */
> -       of_property_read_u32(np, "#address-cells", &na);
> +       /* Find the number of cells in order to get the untranslated address */
>         ns = of_n_size_cells(np);
> 
>         cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
> @@ -392,78 +382,62 @@ int dw_pcie_host_init(struct pcie_port *pp)
>                 dev_err(pp->dev, "missing *config* reg space\n");
>         }
> 
> -       if (of_pci_range_parser_init(&parser, np)) {
> -               dev_err(pp->dev, "missing ranges property\n");
> -               return -EINVAL;
> -       }
> +       ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base);
> +       if (ret)
> +               return ret;
> 
>         /* Get the I/O and memory ranges from DT */
> -       for_each_of_pci_range(&parser, &range) {
> -               unsigned long restype = range.flags & IORESOURCE_TYPE_BITS;
> -
> -               if (restype == IORESOURCE_IO) {
> -                       of_pci_range_to_resource(&range, np, &pp->io);
> -                       pp->io.name = "I/O";
> -                       pp->io.start = max_t(resource_size_t,
> -                                            PCIBIOS_MIN_IO,
> -                                            range.pci_addr + global_io_offset);
> -                       pp->io.end = min_t(resource_size_t,
> -                                          IO_SPACE_LIMIT,
> -                                          range.pci_addr + range.size
> -                                          + global_io_offset - 1);
> -                       pp->io_size = resource_size(&pp->io);
> -                       pp->io_bus_addr = range.pci_addr;
> -                       pp->io_base = range.cpu_addr;
> -
> -                       /* Find the untranslated IO space address */
> -                       pp->io_mod_base = of_read_number(parser.range -
> -                                                        parser.np + na, ns);
> -               }
> -               if (restype == IORESOURCE_MEM) {
> -                       of_pci_range_to_resource(&range, np, &pp->mem);
> -                       pp->mem.name = "MEM";
> -                       pp->mem_size = resource_size(&pp->mem);
> -                       pp->mem_bus_addr = range.pci_addr;
> -
> -                       /* Find the untranslated MEM space address */
> -                       pp->mem_mod_base = of_read_number(parser.range -
> -                                                         parser.np + na, ns);
> -               }
> -               if (restype == 0) {
> -                       of_pci_range_to_resource(&range, np, &pp->cfg);
> -                       pp->cfg0_size = resource_size(&pp->cfg)/2;
> -                       pp->cfg1_size = resource_size(&pp->cfg)/2;
> -                       pp->cfg0_base = pp->cfg.start;
> -                       pp->cfg1_base = pp->cfg.start + pp->cfg0_size;
> +       resource_list_for_each_entry(win, &res) {
> +               switch (resource_type(win->res)) {
> +               case IORESOURCE_IO:
> +                       pp->io = win->res;
> +                       pp->io->name = "I/O";
> +                       pp->io_size = resource_size(pp->io);
> +                       pp->io_bus_addr = pp->io->start - win->offset;
> +                       pp->io_mod_base = win->__res.start;
> +                       ret = pci_remap_iospace(pp->io, pp->io_base);
> +                       if (ret) {
> +                               dev_warn(pp->dev, "error %d: failed to map resource %pR\n",
> +                                        ret, pp->io);
> +                               continue;
> +                       }
> +                       break;
> +               case IORESOURCE_MEM:
> +                       pp->mem = win->res;
> +                       pp->mem->name = "MEM";
> +                       pp->mem_size = resource_size(pp->mem);
> +                       pp->mem_bus_addr = pp->mem->start - win->offset;
> +                       pp->mem_mod_base = win->__res.start;
> +                       break;
> +               case 0:
> +                       pp->cfg = win->res;
> +                       pp->cfg0_size = resource_size(pp->cfg)/2;
> +                       pp->cfg1_size = resource_size(pp->cfg)/2;
> +                       pp->cfg0_base = pp->cfg->start;
> +                       pp->cfg1_base = pp->cfg->start + pp->cfg0_size;
> 
>                         /* Find the untranslated configuration space address */
> -                       pp->cfg0_mod_base = of_read_number(parser.range -
> -                                                          parser.np + na, ns);
> -                       pp->cfg1_mod_base = pp->cfg0_mod_base +
> -                                           pp->cfg0_size;
> +                       pp->cfg0_mod_base = win->__res.start;
> +                       pp->cfg1_mod_base = pp->cfg0_mod_base + pp->cfg0_size;
> +                       break;
> +               case IORESOURCE_BUS:
> +                       pp->busn = win->res;
> +                       break;
> +               default:
> +                       continue;
>                 }
>         }
> 
> -       ret = of_pci_parse_bus_range(np, &pp->busn);
> -       if (ret < 0) {
> -               pp->busn.name = np->name;
> -               pp->busn.start = 0;
> -               pp->busn.end = 0xff;
> -               pp->busn.flags = IORESOURCE_BUS;
> -               dev_dbg(pp->dev, "failed to parse bus-range property: %d, using default %pR\n",
> -                       ret, &pp->busn);
> -       }
> -
>         if (!pp->dbi_base) {
> -               pp->dbi_base = devm_ioremap(pp->dev, pp->cfg.start,
> -                                       resource_size(&pp->cfg));
> +               pp->dbi_base = devm_ioremap(pp->dev, pp->cfg->start,
> +                                       resource_size(pp->cfg));
>                 if (!pp->dbi_base) {
>                         dev_err(pp->dev, "error with ioremap\n");
>                         return -ENOMEM;
>                 }
>         }
> 
> -       pp->mem_base = pp->mem.start;
> +       pp->mem_base = pp->mem->start;
> 
>         if (!pp->va_cfg0_base) {
>                 pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
> @@ -524,15 +498,28 @@ int dw_pcie_host_init(struct pcie_port *pp)
>         val |= PORT_LOGIC_SPEED_CHANGE;
>         dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
> 
> -#ifdef CONFIG_PCI_MSI
> -       dw_pcie_msi_chip.dev = pp->dev;

Is it safe to remove the dev assignment ?

> -       dw_pci.msi_ctrl = &dw_pcie_msi_chip;
> +       bus = pci_create_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops,
> +                             pp, &res);
> +       if (!bus)
> +               return -ENOMEM;
> +
> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> +       bus->msi = container_of(&pp->irq_domain, struct msi_controller, domain);
> +#else
> +       bus->msi = &dw_pcie_msi_chip;
>  #endif

For the records, this patch conflicts with my MSI series:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/360461.html

Conflict resolution is easy but it is worth keeping in mind.

Thanks !
Lorenzo

> 
> -       dw_pci.nr_controllers = 1;
> -       dw_pci.private_data = (void **)&pp;
> +       pci_scan_child_bus(bus);
> +       if (pp->ops->scan_bus)
> +               pp->ops->scan_bus(pp);
> 
> -       pci_common_init_dev(pp->dev, &dw_pci);
> +#ifdef CONFIG_ARM
> +       /* support old dtbs that incorrectly describe IRQs */
> +       pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> +#endif
> +
> +       pci_assign_unassigned_bus_resources(bus);
> +       pci_bus_add_devices(bus);
> 
>         return 0;
>  }
> @@ -633,7 +620,7 @@ static int dw_pcie_valid_config(struct pcie_port *pp,
>  static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>                         int size, u32 *val)
>  {
> -       struct pcie_port *pp = sys_to_pcie(bus->sysdata);
> +       struct pcie_port *pp = bus->sysdata;
>         int ret;
> 
>         if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
> @@ -657,7 +644,7 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>  static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>                         int where, int size, u32 val)
>  {
> -       struct pcie_port *pp = sys_to_pcie(bus->sysdata);
> +       struct pcie_port *pp = bus->sysdata;
>         int ret;
> 
>         if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
> @@ -681,62 +668,6 @@ static struct pci_ops dw_pcie_ops = {
>         .write = dw_pcie_wr_conf,
>  };
> 
> -static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
> -{
> -       struct pcie_port *pp;
> -
> -       pp = sys_to_pcie(sys);
> -
> -       if (global_io_offset < SZ_1M && pp->io_size > 0) {
> -               sys->io_offset = global_io_offset - pp->io_bus_addr;
> -               pci_ioremap_io(global_io_offset, pp->io_base);
> -               global_io_offset += SZ_64K;
> -               pci_add_resource_offset(&sys->resources, &pp->io,
> -                                       sys->io_offset);
> -       }
> -
> -       sys->mem_offset = pp->mem.start - pp->mem_bus_addr;
> -       pci_add_resource_offset(&sys->resources, &pp->mem, sys->mem_offset);
> -       pci_add_resource(&sys->resources, &pp->busn);
> -
> -       return 1;
> -}
> -
> -static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
> -{
> -       struct pci_bus *bus;
> -       struct pcie_port *pp = sys_to_pcie(sys);
> -
> -       pp->root_bus_nr = sys->busnr;
> -       bus = pci_scan_root_bus(pp->dev, sys->busnr,
> -                                 &dw_pcie_ops, sys, &sys->resources);
> -       if (!bus)
> -               return NULL;
> -
> -       if (bus && pp->ops->scan_bus)
> -               pp->ops->scan_bus(pp);
> -
> -       return bus;
> -}
> -
> -static int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> -{
> -       struct pcie_port *pp = sys_to_pcie(dev->bus->sysdata);
> -       int irq;
> -
> -       irq = of_irq_parse_and_map_pci(dev, slot, pin);
> -       if (!irq)
> -               irq = pp->irq;
> -
> -       return irq;
> -}
> -
> -static struct hw_pci dw_pci = {
> -       .setup          = dw_pcie_setup,
> -       .scan           = dw_pcie_scan_bus,
> -       .map_irq        = dw_pcie_map_irq,
> -};
> -
>  void dw_pcie_setup_rc(struct pcie_port *pp)
>  {
>         u32 val;
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index d0bbd27..efac57d 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -34,7 +34,7 @@ struct pcie_port {
>         u64                     cfg1_mod_base;
>         void __iomem            *va_cfg1_base;
>         u32                     cfg1_size;
> -       u64                     io_base;
> +       resource_size_t         io_base;
>         u64                     io_mod_base;
>         phys_addr_t             io_bus_addr;
>         u32                     io_size;
> @@ -42,10 +42,10 @@ struct pcie_port {
>         u64                     mem_mod_base;
>         phys_addr_t             mem_bus_addr;
>         u32                     mem_size;
> -       struct resource         cfg;
> -       struct resource         io;
> -       struct resource         mem;
> -       struct resource         busn;
> +       struct resource         *cfg;
> +       struct resource         *io;
> +       struct resource         *mem;
> +       struct resource         *busn;
>         int                     irq;
>         u32                     lanes;
>         struct pcie_host_ops    *ops;
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
> index c49fbdc..03eb204 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -286,7 +286,7 @@ static int spear13xx_add_pcie_port(struct pcie_port *pp,
>                 return ret;
>         }
> 
> -       pp->root_bus_nr = -1;
> +       pp->root_bus_nr = 0;
>         pp->ops = &spear13xx_pcie_host_ops;
> 
>         ret = dw_pcie_host_init(pp);
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
