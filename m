Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:50352 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751702Ab3EPPlN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2013 11:41:13 -0400
Date: Thu, 16 May 2013 11:40:31 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Rob Herring <rob.herring@calxeda.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Olof Johansson <olof@lixom.net>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCHv9 7/9] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130516154031.GF6563@titan.lakedaemon.net>
References: <1368624323-24311-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1368624323-24311-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130516093312.GB2459@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130516093312.GB2459@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 16, 2013 at 06:33:14AM -0300, Ezequiel Garcia wrote:
> On Wed, May 15, 2013 at 03:25:21PM +0200, Thomas Petazzoni wrote:
> [..]
> > +
> > +static int __init mvebu_pcie_probe(struct platform_device *pdev)
> > +{
> > +	struct mvebu_pcie *pcie;
> > +	struct device_node *np = pdev->dev.of_node;
> > +	struct of_pci_range range;
> > +	struct of_pci_range_parser parser;
> > +	struct device_node *child;
> > +	int i, ret;
> > +
> > +	pcie = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_pcie),
> > +			    GFP_KERNEL);
> > +	if (!pcie)
> > +		return -ENOMEM;
> > +
> > +	pcie->pdev = pdev;
> > +
> > +	if (of_pci_range_parser_init(&parser, np))
> > +		return -EINVAL;
> > +
> > +	/* Get the I/O and memory ranges from DT */
> > +	for_each_of_pci_range(&parser, &range) {
> > +		unsigned long restype = range.flags & IORESOURCE_TYPE_BITS;
> > +		if (restype == IORESOURCE_IO) {
> > +			of_pci_range_to_resource(&range, np, &pcie->io);
> > +			of_pci_range_to_resource(&range, np, &pcie->realio);
> > +			pcie->io.name = "I/O";
> > +			pcie->realio.start = max_t(resource_size_t,
> > +						   PCIBIOS_MIN_IO,
> > +						   range.pci_addr);
> > +			pcie->realio.end = min_t(resource_size_t,
> > +						 IO_SPACE_LIMIT,
> > +						 range.pci_addr + range.size);
> > +		}
> > +		if (restype == IORESOURCE_MEM) {
> > +			of_pci_range_to_resource(&range, np, &pcie->mem);
> > +			pcie->mem.name = "MEM";
> > +		}
> > +	}
> > +
> > +	/* Get the bus range */
> > +	ret = of_pci_parse_bus_range(np, &pcie->busn);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "failed to parse bus-range property: %d\n",
> > +			ret);
> > +		return ret;
> > +	}
> > +
> > +	for_each_child_of_node(pdev->dev.of_node, child) {
> > +		if (!of_device_is_available(child))
> > +			continue;
> > +		pcie->nports++;
> > +	}
> > +
> > +	pcie->ports = devm_kzalloc(&pdev->dev, pcie->nports *
> > +				   sizeof(struct mvebu_pcie_port),
> > +				   GFP_KERNEL);
> > +	if (!pcie->ports)
> > +		return -ENOMEM;
> > +
> > +	i = 0;
> > +	for_each_child_of_node(pdev->dev.of_node, child) {
> > +		struct mvebu_pcie_port *port = &pcie->ports[i];
> > +
> > +		if (!of_device_is_available(child))
> > +			continue;
> > +
> > +		port->pcie = pcie;
> > +
> > +		if (of_property_read_u32(child, "marvell,pcie-port",
> > +					 &port->port)) {
> > +			dev_warn(&pdev->dev,
> > +				 "ignoring PCIe DT node, missing pcie-port property\n");
> > +			continue;
> > +		}
> > +
> > +		if (of_property_read_u32(child, "marvell,pcie-lane",
> > +					 &port->lane))
> > +			port->lane = 0;
> > +
> > +		port->name = kasprintf(GFP_KERNEL, "pcie%d.%d",
> > +				       port->port, port->lane);
> > +
> > +		port->devfn = of_pci_get_devfn(child);
> > +		if (port->devfn < 0)
> > +			continue;
> > +
> > +		port->base = mvebu_pcie_map_registers(pdev, child, port);
> > +		if (!port->base) {
> > +			dev_err(&pdev->dev, "PCIe%d.%d: cannot map registers\n",
> > +				port->port, port->lane);
> > +			continue;
> > +		}
> > +
> > +		if (mvebu_pcie_link_up(port)) {
> > +			port->haslink = 1;
> > +			dev_info(&pdev->dev, "PCIe%d.%d: link up\n",
> > +				 port->port, port->lane);
> > +		} else {
> > +			port->haslink = 0;
> > +			dev_info(&pdev->dev, "PCIe%d.%d: link down\n",
> > +				 port->port, port->lane);
> > +		}
> > +
> > +		port->clk = of_clk_get_by_name(child, NULL);
> > +		if (!port->clk) {
> > +			dev_err(&pdev->dev, "PCIe%d.%d: cannot get clock\n",
> > +			       port->port, port->lane);
> > +			iounmap(port->base);
> > +			port->haslink = 0;
> > +			continue;
> > +		}
> > +
> > +		port->dn = child;
> > +
> > +		clk_prepare_enable(port->clk);
> > +		spin_lock_init(&port->conf_lock);
> > +
> > +		mvebu_sw_pci_bridge_init(port);
> > +
> > +		i++;
> > +	}
> > +
> > +	mvebu_pcie_enable(pcie);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id mvebu_pcie_of_match_table[] = {
> > +	{ .compatible = "marvell,armada-xp-pcie", },
> > +	{ .compatible = "marvell,armada-370-pcie", },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, mvebu_pcie_of_match_table);
> > +
> > +static struct platform_driver mvebu_pcie_driver = {
> > +	.driver = {
> > +		.owner = THIS_MODULE,
> > +		.name = "mvebu-pcie",
> > +		.of_match_table =
> > +		   of_match_ptr(mvebu_pcie_of_match_table),
> > +	},
> > +};
> > +
> > +static int mvebu_pcie_init(void)
> 
> Building this showed a warning here. It seems you forgot
> to mark this one as __init.

Thomas, I'll fix this up when I pull this in, no need to resend. :)

thx,

Jason.
