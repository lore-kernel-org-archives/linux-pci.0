Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40577 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754069AbbLDSR5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Dec 2015 13:17:57 -0500
Date: Fri, 4 Dec 2015 12:17:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell Joyce <russell.joyce@york.ac.uk>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Jingoo Han <jingoohan1@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/28] PCI: xilinx: keep references to both IRQ domains
Message-ID: <20151204181749.GB20125@localhost>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
 <1448900513-20856-6-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448900513-20856-6-git-send-email-paul.burton@imgtec.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Paul,

Please capitalize the first word of your PCI changelog subjects.

On Mon, Nov 30, 2015 at 04:21:30PM +0000, Paul Burton wrote:
> pcie-xilinx creates 2 IRQ domains when built with MSI support: one for
> MSI interrupts & one for legacy INTx interrupts. However, it only kept a
> reference to the MSI IRQ domain. This means that any INTx interrupts
> that may occur would be mapped using the wrong domain, and that only the
> MSI IRQ domain would be removed along with the driver. Track both IRQ
> domains & clean up both as appropriate.

It looks like this fixes a problem in the original commit 8961def56845
("PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver"), which
appeared in v3.18.  Does this need a stable backport tag?

It sounds like any device using INTx just won't work?  From later
patches, I surmise that this series might be related to using Xilinx
in a new MIPS Boston board.  If that's the case, and pre-v4.5 kernels
don't support that board anyway, a stable backport might not be
needed.  It *does* fix a leak even if you don't need INTx, but that
seems minor and probably not worth a stable backport all by itself.

I probably *would* add a 'Fixes: 8961def56845 ("PCI: xilinx: Add
Xilinx AXI PCIe Host Bridge IP driver")' line to leave breadcrumbs for
people backporting things.

This seems to be part of a larger series -- can these PCI patches go
through my tree, or do they all need to go together because of
dependencies on the rest of the series?

They all need acks from Michal, of course.

> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
> 
>  drivers/pci/host/pcie-xilinx.c | 58 ++++++++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
> index 3c7a0d5..c412a37 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -105,6 +105,7 @@
>   * @root_busno: Root Bus number
>   * @dev: Device pointer
>   * @irq_domain: IRQ domain pointer
> + * @msi_irq_domain: MSI IRQ domain pointer
>   * @bus_range: Bus range
>   * @resources: Bus Resources
>   */
> @@ -115,6 +116,7 @@ struct xilinx_pcie_port {
>  	u8 root_busno;
>  	struct device *dev;
>  	struct irq_domain *irq_domain;
> +	struct irq_domain *msi_irq_domain;
>  	struct resource bus_range;
>  	struct list_head resources;
>  };
> @@ -291,7 +293,7 @@ static int xilinx_pcie_msi_setup_irq(struct msi_controller *chip,
>  	if (hwirq < 0)
>  		return hwirq;
>  
> -	irq = irq_create_mapping(port->irq_domain, hwirq);
> +	irq = irq_create_mapping(port->msi_irq_domain, hwirq);
>  	if (!irq)
>  		return -EINVAL;
>  
> @@ -517,31 +519,21 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
>  
>  /**
>   * xilinx_pcie_free_irq_domain - Free IRQ domain
> - * @port: PCIe port information
> + * @domain: the IRQ domain to free
> + * @nr: the number of IRQs in the domain
>   */
> -static void xilinx_pcie_free_irq_domain(struct xilinx_pcie_port *port)
> +static void xilinx_pcie_free_irq_domain(struct irq_domain *domain, int nr)
>  {
>  	int i;
> -	u32 irq, num_irqs;
> -
> -	/* Free IRQ Domain */
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -
> -		free_pages(port->msi_pages, 0);
> -
> -		num_irqs = XILINX_NUM_MSI_IRQS;
> -	} else {
> -		/* INTx */
> -		num_irqs = 4;
> -	}
> +	u32 irq;
>  
> -	for (i = 0; i < num_irqs; i++) {
> -		irq = irq_find_mapping(port->irq_domain, i);
> +	for (i = 0; i < nr; i++) {
> +		irq = irq_find_mapping(domain, i);
>  		if (irq > 0)
>  			irq_dispose_mapping(irq);
>  	}
>  
> -	irq_domain_remove(port->irq_domain);
> +	irq_domain_remove(domain);
>  }
>  
>  /**
> @@ -571,20 +563,20 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
>  		return PTR_ERR(port->irq_domain);
>  	}
>  
> -	/* Setup MSI */
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		port->irq_domain = irq_domain_add_linear(node,
> -							 XILINX_NUM_MSI_IRQS,
> -							 &msi_domain_ops,
> -							 &xilinx_pcie_msi_chip);
> -		if (!port->irq_domain) {
> -			dev_err(dev, "Failed to get a MSI IRQ domain\n");
> -			return PTR_ERR(port->irq_domain);
> -		}
> +	if (!IS_ENABLED(CONFIG_PCI_MSI))
> +		return 0;
>  
> -		xilinx_pcie_enable_msi(port);
> +	/* Setup MSI */
> +	port->msi_irq_domain = irq_domain_add_linear(node,
> +						     XILINX_NUM_MSI_IRQS,
> +						     &msi_domain_ops,
> +						     &xilinx_pcie_msi_chip);
> +	if (!port->msi_irq_domain) {
> +		dev_err(dev, "Failed to get a MSI IRQ domain\n");
> +		return PTR_ERR(port->msi_irq_domain);
>  	}
>  
> +	xilinx_pcie_enable_msi(port);
>  	return 0;
>  }
>  
> @@ -868,7 +860,13 @@ static int xilinx_pcie_remove(struct platform_device *pdev)
>  {
>  	struct xilinx_pcie_port *port = platform_get_drvdata(pdev);
>  
> -	xilinx_pcie_free_irq_domain(port);
> +	xilinx_pcie_free_irq_domain(port->irq_domain, 4);
> +
> +	if (config_enabled(CONFIG_MSI)) {
> +		free_pages(port->msi_pages, 0);
> +		xilinx_pcie_free_irq_domain(port->msi_irq_domain,
> +					    XILINX_NUM_MSI_IRQS);
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.6.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
