Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 5 Jul 2018 17:23:57 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/3] PCI: mvebu: Convert to use pci_host_bridge directly
Message-ID: <20180705162357.GB13716@red-moon>
References: <20180629091007.31069-1-thomas.petazzoni@bootlin.com>
 <20180629091007.31069-3-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20180629091007.31069-3-thomas.petazzoni@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Nadav Haklai <nadavh@marvell.com>, Russell King <linux@arm.linux.org.uk>,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 29, 2018 at 11:10:06AM +0200, Thomas Petazzoni wrote:

[...]

> +	pcie->mem.name = "PCI MEM";
> +	pci_add_resource_offset(&pcie->resources, &pcie->mem, 0);

Nit: pci_add_resource() would do.

> +
> +	/* Get the PCIe IO aperture */
>  	mvebu_mbus_get_pcie_io_aperture(&pcie->io);
>  
>  	if (resource_size(&pcie->io) != 0) {
> @@ -1055,12 +1016,42 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>  	} else
>  		pcie->realio = pcie->io;
>  
> -	/* Get the bus range */
> -	ret = of_pci_parse_bus_range(np, &pcie->busn);
> -	if (ret) {
> -		dev_err(dev, "failed to parse bus-range property: %d\n", ret);
> +	pcie->realio.name = "PCI I/O";
> +
> +	if (resource_size(&pcie->realio) != 0)
> +		pci_add_resource_offset(&pcie->resources, &pcie->realio, 0);

Ditto.

> +
> +	ret = devm_request_pci_bus_resources(dev, &pcie->resources);
> +	if (ret)
> +		return 0;
> +
> +	ret = pci_remap_iospace(&pcie->realio, pcie->realio.start);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int mvebu_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mvebu_pcie *pcie;
> +	struct pci_host_bridge *bridge;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *child;
> +	int num, i, ret;
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct mvebu_pcie));
> +	if (!bridge)
> +		return -ENOMEM;
> +
> +	pcie = pci_host_bridge_priv(bridge);
> +	pcie->pdev = pdev;
> +	platform_set_drvdata(pdev, pcie);
> +
> +	ret = mvebu_pcie_parse_request_resources(pcie);
> +	if (ret)
>  		return ret;
> -	}
>  
>  	num = of_get_available_child_count(np);
>  
> @@ -1104,18 +1095,24 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>  			continue;
>  		}
>  
> +		mvebu_pcie_setup_hw(port);
>  		mvebu_pcie_set_local_dev_nr(port, 1);
>  		mvebu_pci_sw_bridge_init(port);
>  	}
>  
>  	pcie->nports = i;
>  
> -	for (i = 0; i < (IO_SPACE_LIMIT - SZ_64K); i += SZ_64K)
> -		pci_ioremap_io(i, pcie->io.start + i);

Mmmm..I think that arch/arm let the mach override the mapping attributes
for MVEBU (for some platforms) so replacing this with
pci_remap_iospace() may trigger a regression, we need to investigate.

Also, I do not know why the loop above does not pay attention to the
real IO space resource size, whether that's on purpose or just a left
over.

Lorenzo

> -
> -	mvebu_pcie_enable(pcie);
> -
> -	return 0;
> +	list_splice_init(&pcie->resources, &bridge->windows);
> +	bridge->dev.parent = dev;
> +	bridge->sysdata = pcie;
> +	bridge->busnr = 0;
> +	bridge->ops = &mvebu_pcie_ops;
> +	bridge->map_irq = of_irq_parse_and_map_pci;
> +	bridge->swizzle_irq = pci_common_swizzle;
> +	bridge->align_resource = mvebu_pcie_align_resource;
> +	bridge->msi = pcie->msi;
> +
> +	return pci_host_probe(bridge);
>  }
>  
>  static const struct of_device_id mvebu_pcie_of_match_table[] = {
> -- 
> 2.14.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
