Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50681 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753011AbbFILO5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 9 Jun 2015 07:14:57 -0400
Date: Tue, 9 Jun 2015 12:15:07 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: James Morse <James.Morse@arm.com>,
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
	"gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
	"yuanzhichang@hisilicon.com" <yuanzhichang@hisilicon.com>,
	"zhudacai@hisilicon.com" <zhudacai@hisilicon.com>,
	"zhangjukuo@huawei.com" <zhangjukuo@huawei.com>,
	"qiuzhenfa@hisilicon.com" <qiuzhenfa@hisilicon.com>,
	"liguozhu@hisilicon.com" <liguozhu@hisilicon.com>
Subject: Re: [PATCH v2 2/4] PCI: designware: Add ARM64 support
Message-ID: <20150609111507.GB20182@red-moon>
References: <1433320542-49576-1-git-send-email-wangzhou1@hisilicon.com>
 <1433320542-49576-3-git-send-email-wangzhou1@hisilicon.com>
 <5570507F.4030704@arm.com>
 <557159B2.9090103@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <557159B2.9090103@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 05, 2015 at 09:11:30AM +0100, Zhou Wang wrote:

[...]

> >> -int dw_pcie_host_init(struct pcie_port *pp)
> >> +int __init dw_pcie_host_init(struct pcie_port *pp)
> >>  {
> >>  	struct device_node *np = pp->dev->of_node;
> >>  	struct platform_device *pdev = to_platform_device(pp->dev);
> >>  	struct of_pci_range range;
> >>  	struct of_pci_range_parser parser;
> >> +	struct pci_bus *bus;
> >>  	struct resource *cfg_res;
> >> +	LIST_HEAD(res);
> >>  	u32 val, na, ns;
> >>  	const __be32 *addrp;
> >>  	int i, index, ret;
> >> @@ -502,15 +498,49 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >>  	val |= PORT_LOGIC_SPEED_CHANGE;
> >>  	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
> >>  
> >> -#ifdef CONFIG_PCI_MSI
> >> -	dw_pcie_msi_chip.dev = pp->dev;
> >> -	dw_pci.msi_ctrl = &dw_pcie_msi_chip;
> >> +#ifdef CONFIG_ARM
> >> +	/*
> >> +	 * FIXME: we should really be able to use
> >> +	 * of_pci_get_host_bridge_resources on arm32 as well,
> >> +	 * but the conversion needs some more testing
> >> +	 */
> >> +	if (global_io_offset < SZ_1M && pp->io_size > 0) {
> >> +		pci_ioremap_io(global_io_offset, pp->io_base);
> >> +		global_io_offset += SZ_64K;
> >> +		pci_add_resource_offset(&res, &pp->io,
> >> +					global_io_offset - pp->io_bus_addr);
> >> +	}
> >> +	pci_add_resource_offset(&res, &pp->mem,
> >> +				pp->mem.start - pp->mem_bus_addr);
> >> +	pci_add_resource(&res, &pp->busn);
> > 
> > I don't think this #ifdef is necessary. In the spirit of 'the conversion
> > needs some more testing', I removed it leaving just the below arm64 code.
> > 
> > This worked on my Freescale i.MX6 Quad SABRE Lite Board, I went as far as
> > scanning for wireless access points.
> > 
> 
> I think it depends on which kind of PCIe device you use, if we use a PCIe device
> with a I/O Bar, it may not work well without above code. But so far, I have not
> met a PCIe device which must work with a I/O Bar.

There are two problems here:

1) the io_base address you get from of_pci_get_host_bridge_resources
   must be mapped using pci_remap_iospace. You are not doing this, so
   even if you had a PCIe card with I/O bar it would not work on arm64
   as the code stands. Remember that I/O space on arm/arm64 works as a
   memory access with offset from PCI_IOBASE and that's the value you get
   in the I/O resource. See:

   drivers/pci/host/pci-host-generic.c
   drivers/pci/host/pci-versatile.c
   drivers/pci/host/pci-xgene.c

2) (1) above would sort out I/O space access for both arm and arm64 so,
   as James said, the #ifdef is useless.

I hope this makes things clearer.

Thanks,
Lorenzo

> 
> >> +#else
> >> +	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base);
> > 
> > of_pci_get_host_bridge_resources expects &pp->io_base to be a
> > resource_size_t*, but &io_base is u64*. This generates a warning on arm
> > with the above change. Changing the the type in
> > drivers/pci/host/pcie-designware.h fixes this.
> > 
> > 
> > Thanks,
> > 
> > James
> > 
> 
> OK, will modify this in next version.
> 
> Best Regards and thanks again for your test,
> Zhou
> 
> >> +	if (ret)
> >> +		return ret;
> >> +#endif
> >> +
> >> +	bus = pci_create_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops,
> >> +			      pp, &res);
> >> +	if (!bus)
> >> +		return -ENOMEM;
> >> +
> >> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> >> +	bus->msi = container_of(&pp->irq_domain, struct msi_controller, domain);
> >> +#else
> >> +	bus->msi = &dw_pcie_msi_chip;
> >>  #endif
> >>  
> >> -	dw_pci.nr_controllers = 1;
> >> -	dw_pci.private_data = (void **)&pp;
> >> +	pci_scan_child_bus(bus);
> >> +	if (pp->ops->scan_bus)
> >> +		pp->ops->scan_bus(pp);
> >>  
> >> -	pci_common_init_dev(pp->dev, &dw_pci);
> >> +#ifdef CONFIG_ARM
> >> +	/* support old dtbs that incorrectly describe IRQs */
> >> +	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> >> +#endif
> >> +
> >> +	pci_assign_unassigned_bus_resources(bus);
> >> +	pci_bus_add_devices(bus);
> >>  
> >>  	return 0;
> >>  }
> >> @@ -653,7 +683,7 @@ static int dw_pcie_valid_config(struct pcie_port *pp,
> >>  static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
> >>  			int size, u32 *val)
> >>  {
> >> -	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
> >> +	struct pcie_port *pp = bus->sysdata;
> >>  	int ret;
> >>  
> >>  	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
> >> @@ -677,7 +707,7 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
> >>  static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
> >>  			int where, int size, u32 val)
> >>  {
> >> -	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
> >> +	struct pcie_port *pp = bus->sysdata;
> >>  	int ret;
> >>  
> >>  	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
> >> @@ -701,64 +731,6 @@ static struct pci_ops dw_pcie_ops = {
> >>  	.write = dw_pcie_wr_conf,
> >>  };
> >>  
> >> -static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
> >> -{
> >> -	struct pcie_port *pp;
> >> -
> >> -	pp = sys_to_pcie(sys);
> >> -
> >> -	if (global_io_offset < SZ_1M && pp->io_size > 0) {
> >> -		sys->io_offset = global_io_offset - pp->io_bus_addr;
> >> -		pci_ioremap_io(global_io_offset, pp->io_base);
> >> -		global_io_offset += SZ_64K;
> >> -		pci_add_resource_offset(&sys->resources, &pp->io,
> >> -					sys->io_offset);
> >> -	}
> >> -
> >> -	sys->mem_offset = pp->mem.start - pp->mem_bus_addr;
> >> -	pci_add_resource_offset(&sys->resources, &pp->mem, sys->mem_offset);
> >> -	pci_add_resource(&sys->resources, &pp->busn);
> >> -
> >> -	return 1;
> >> -}
> >> -
> >> -static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
> >> -{
> >> -	struct pci_bus *bus;
> >> -	struct pcie_port *pp = sys_to_pcie(sys);
> >> -
> >> -	pp->root_bus_nr = sys->busnr;
> >> -	bus = pci_create_root_bus(pp->dev, sys->busnr,
> >> -				  &dw_pcie_ops, sys, &sys->resources);
> >> -	if (!bus)
> >> -		return NULL;
> >> -
> >> -	pci_scan_child_bus(bus);
> >> -
> >> -	if (bus && pp->ops->scan_bus)
> >> -		pp->ops->scan_bus(pp);
> >> -
> >> -	return bus;
> >> -}
> >> -
> >> -static int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> >> -{
> >> -	struct pcie_port *pp = sys_to_pcie(dev->bus->sysdata);
> >> -	int irq;
> >> -
> >> -	irq = of_irq_parse_and_map_pci(dev, slot, pin);
> >> -	if (!irq)
> >> -		irq = pp->irq;
> >> -
> >> -	return irq;
> >> -}
> >> -
> >> -static struct hw_pci dw_pci = {
> >> -	.setup		= dw_pcie_setup,
> >> -	.scan		= dw_pcie_scan_bus,
> >> -	.map_irq	= dw_pcie_map_irq,
> >> -};
> >> -
> >>  void dw_pcie_setup_rc(struct pcie_port *pp)
> >>  {
> >>  	u32 val;
> > 
> > 
> > .
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
