Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:63945 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932294Ab2JaH1j (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Oct 2012 03:27:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH 04/15] SPEAr13xx: Add PCIe Root Complex driver support
Date: Tue, 30 Oct 2012 22:20:23 +0000
Cc: shiraz.hashim@st.com, viresh.linux@gmail.com,
	spear-devel@list.st.com, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, olof@lixom.net
References: <cover.1351492562.git.pratyush.anand@st.com> <b26d316d6822888ccdeecf72346c7dbd618759eb.1351492562.git.pratyush.anand@st.com>
In-Reply-To: <b26d316d6822888ccdeecf72346c7dbd618759eb.1351492562.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201210302220.23690.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 29 October 2012, Pratyush Anand wrote:
> SPEAr13xx has dual mode PCIe controller which can be used as Root
> Complex as well as Endpoint. This driver supports RC mode of the
> controller.
> 
> If CONFIG_PCI_MSI is defined then support of MSI interrupt for
> downstream  PCIe devices will be enabled.
> 
> If CONFIG_PM is defined then it supports suspend/resume functionality.

I think I've seen the same hardware before used with another driver.
IMHO we should really make sure this does not get duplicated again and
move this stuff to a new subdirectory drivers/pci/host. We don't yet have
a completely architecture independent way of defining a PCIe root complex,
but we're getting there and given of how many ARM implementations we have,
we can just as well start with this one and adapt it to another arch if
necesary.

> +struct pcie_port {
> +	u8			controller;
> +	u8			root_bus_nr;
> +	void __iomem		*dbi_base;
> +	void __iomem		*va_dbi_base;
> +	void __iomem		*app_base;
> +	void __iomem		*va_app_base;
> +	void __iomem		*base;
> +	void __iomem		*phy_base;
> +	void __iomem		*va_phy_base;
> +	void __iomem		*cfg0_base;
> +	void __iomem		*va_cfg0_base;
> +	void __iomem		*cfg1_base;
> +	void __iomem		*va_cfg1_base;
> +	void __iomem		*mem_base;
> +	void __iomem		*io_base;
> +	spinlock_t		conf_lock;
> +	char			mem_space_name[16];
> +	char			io_space_name[16];
> +	struct resource		res[2];
> +	struct pcie_port_info	config;
> +	struct list_head	next;
> +	struct clk		*clk;
> +	int			irq;
> +	int			virt_irq_base;
> +	int			susp_state;
> +};

Can you explain why you need a total of 13 virtual memory areas?

> +
> +static struct list_head	pcie_port_list;

I'm pretty sure you don't need your own list of ports, since we already enumerate the
ports in the PCI code.

> +static struct hw_pci pci;

Why is this not statically initialized?

> +	snprintf(pp->io_space_name, sizeof(pp->io_space_name),
> +			"PCIe %d I/O", nr);
> +	pp->io_space_name[sizeof(pp->io_space_name) - 1] = 0;
> +	pp->res[1].name = pp->io_space_name;
> +	pp->res[1].start = PCIBIOS_MIN_IO + nr * pp->config.io_size;
> +	pp->res[1].end = pp->res[1].start + (pp->config.io_size - 1);
> +	pp->res[1].flags = IORESOURCE_IO;
> +	if (request_resource(&ioport_resource, &pp->res[1]))
> +		panic("can't allocate PCIe IO space");
> +	pci_add_resource_offset(&sys->resources, &pp->res[1], sys->io_offset);

Is the io_offset ever nonzero?

> +void __iomem *spear13xx_pcie_io_base(unsigned long addr)
> +{
> +	int controller = (addr - PCIBIOS_MIN_IO) / IO_SIZE_PER_PORT;
> +	struct pcie_port *pp;
> +
> +	pp = controller_to_port(controller);
> +
> +	return pp->io_base;
> +}

This function looks completely bogus. Subtracting PCIBIOS_MIN_IO means that
everything is shifted by 0x1000 ports, since secondary bridges don't
have this offset. The I/O spaces are just mapped linearly into the virtual
address space anyway, so looking up the I/O base like this is pointless.

> +static void pcie_host_init(struct pcie_port *pp)
> +{
> +	struct pcie_port_info *config = &pp->config;
> +	void __iomem *dbi_base = pp->va_dbi_base;
> +	struct pcie_app_reg *app_reg = pp->va_app_base;
> +	u32 exp_cap_off = PCI_CAP_ID_EXP_OFFSET;
> +	u32 val;
> +
> +	/* Keep first 64K for IO */
> +	pp->io_base = pp->base;
> +	pp->mem_base = pp->io_base + config->io_size;
> +	pp->cfg0_base = pp->mem_base + config->mem_size;
> +	pp->cfg1_base = pp->cfg0_base + config->cfg0_size;

Why is the memory space part of the virtual bus address range here?


> +static int add_pcie_port(struct pcie_port *pp, struct platform_device *pdev)
> +{
> +	struct resource *base;
> +	struct resource *dbi_base;
> +	struct resource *phy_base;
> +	int virt_irq_base;
> +	struct device_node *np = pdev->dev.of_node;
> +	struct irq_domain *irq_domain;
> +	int num_virt_irqs = NUM_INTX_IRQS;
> +
> +	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!dbi_base) {
> +		dev_err(&pdev->dev, "couldn't get dbi base resource\n");
> +		return -EINVAL;
> +	}
> +	if (!devm_request_mem_region(&pdev->dev, dbi_base->start,
> +				resource_size(dbi_base), pdev->name)) {
> +		dev_err(&pdev->dev, "dbi base resource is busy\n");
> +		return -EBUSY;
> +	}
> +
> +	pp->dbi_base = (void __iomem *)dbi_base->start;

dbi_base is a resource here, which refers to a physical address. You cannot cast
that to an __iomem token.

> +	pp->va_dbi_base = devm_ioremap(&pdev->dev, dbi_base->start,
> +			resource_size(dbi_base));

Here you even pass that address into ioremap, so it certainly isn't a virtual address

> +	pp->phy_base = (void __iomem *)phy_base->start;

same here.

> +	pp->va_phy_base = devm_ioremap(&pdev->dev, phy_base->start,
> +			resource_size(phy_base));
> +	if (!pp->va_phy_base) {
> +		dev_err(&pdev->dev, "error with ioremap\n");
> +		return -ENOMEM;
> +	}
> +
> +	base = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!base) {
> +		dev_err(&pdev->dev, "couldn't get base resource\n");
> +		return -EINVAL;
> +	}
> +
> +	pp->base = (void __iomem *)base->start;

and here.

> +	virt_irq_base = irq_alloc_descs(-1, 0, num_virt_irqs, 0);
> +	if (IS_ERR_VALUE(virt_irq_base)) {
> +		dev_err(&pdev->dev, "irq desc alloc failed\n");
> +		return -ENXIO;
> +	}
> +
> +	irq_domain = irq_domain_add_legacy(np, num_virt_irqs, virt_irq_base,
> +			0, &irq_domain_simple_ops, NULL);

Why not use a linear domain?

> +	pp->virt_irq_base = irq_find_mapping(irq_domain, 0);

Then you can get rid of virt_irq_base and use CONFIG_SPARSE_IRQ.

> +	spin_lock_init(&pp->conf_lock);
> +	if (pcie_link_up(pp->va_app_base)) {
> +		dev_info(&pdev->dev, "link up\n");
> +	} else {
> +		dev_info(&pdev->dev, "link down\n");
> +		pcie_host_init(pp);
> +		pp->va_cfg0_base = devm_ioremap(&pdev->dev,
> +				(resource_size_t)pp->cfg0_base,

cfg0_base is an __iomem token, you cannot pass that into ioremap,
which expects a physical address.

> +	pp->config.io_size = IO_SIZE_PER_PORT;
> +	of_property_read_u32(np, "pcie-host,is_host", &pp->config.is_host);
> +	of_property_read_u32(np, "pcie-host,is_gen1", &pp->config.is_gen1);

These should probably be derived from the "compatible" value.

> +	of_property_read_u32(np, "pcie-host,cfg0_size", &pp->config.cfg0_size);
> +	of_property_read_u32(np, "pcie-host,cfg1_size", &pp->config.cfg1_size);
> +	of_property_read_u32(np, "pcie-host,mem_size", &pp->config.mem_size);
> +	of_property_read_u32(np, "pcie-host,msg_size", &pp->config.msg_size);
> +	of_property_read_u32(np, "pcie-host,in_mem_size",
> +			&pp->config.in_mem_size);

And these should come from the "ranges" property I suppose.

	Arnd
