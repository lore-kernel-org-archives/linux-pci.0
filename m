Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752792AbdF0WUZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jun 2017 18:20:25 -0400
Date: Tue, 27 Jun 2017 17:20:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] drivers: pci: host: ftpci100: Remove pre-scan bus
 dependency
Message-ID: <20170627222022.GC17844@bhelgaas-glaptop.roam.corp.google.com>
References: <20170621162651.25315-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170621162651.25315-1-linus.walleij@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 21, 2017 at 06:26:51PM +0200, Linus Walleij wrote:
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> Remove leftover pci_bus dependencies from the probe path.
> 
> We were digging around in config space before the bus was
> up so we need to use a few raw accessors and avoid storing
> things in the bus structure until the host is initialized.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for helping untangle all this, Linus.

I split this into two parts:

  1) the faraday_raw_pci_read_config() stuff, which I folded into the
  "PCI: faraday: Convert IRQ masking to raw PCI config accessors"
  patch from Lorenzo's series.

  2) the bus max/cur clock speed setting, which I folded into the
  "PCI: faraday: Add clock handling" patch that you posted earlier.

I rebased pci/host-faraday on top of pci/enumeration, so I *think*
pci/host-faraday should have everything I know about for the FTPCI100.
Can you double-check it?

https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/host-faraday&id=2e7062416fdff640c5f2ee488690fc5af4b927ff

I'm still hoping to get this all in v4.13.

> ---
> This patch on top of Lorenzo's patch series make everything
> work fine for me.
> ---
>  drivers/pci/host/pci-ftpci100.c | 53 +++++++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
> index db31ab21884e..5162dffc102b 100644
> --- a/drivers/pci/host/pci-ftpci100.c
> +++ b/drivers/pci/host/pci-ftpci100.c
> @@ -183,12 +183,11 @@ static int faraday_res_to_memcfg(resource_size_t mem_base,
>  	return 0;
>  }
>  
> -static int faraday_pci_read_config(struct pci_bus *bus, unsigned int fn,
> -				   int config, int size, u32 *value)
> +static int faraday_raw_pci_read_config(struct faraday_pci *p, int bus_number,
> +				       unsigned int fn, int config, int size,
> +				       u32 *value)
>  {
> -	struct faraday_pci *p = bus->sysdata;
> -
> -	writel(PCI_CONF_BUS(bus->number) |
> +	writel(PCI_CONF_BUS(bus_number) |
>  			PCI_CONF_DEVICE(PCI_SLOT(fn)) |
>  			PCI_CONF_FUNCTION(PCI_FUNC(fn)) |
>  			PCI_CONF_WHERE(config) |
> @@ -202,11 +201,19 @@ static int faraday_pci_read_config(struct pci_bus *bus, unsigned int fn,
>  	else if (size == 2)
>  		*value = (*value >> (8 * (config & 3))) & 0xFFFF;
>  
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int faraday_pci_read_config(struct pci_bus *bus, unsigned int fn,
> +				   int config, int size, u32 *value)
> +{
> +	struct faraday_pci *p = bus->sysdata;
> +
>  	dev_dbg(&bus->dev,
>  		"[read]  slt: %.2d, fnc: %d, cnf: 0x%.2X, val (%d bytes): 0x%.8X\n",
>  		PCI_SLOT(fn), PCI_FUNC(fn), config, size, *value);
>  
> -	return PCIBIOS_SUCCESSFUL;
> +	return faraday_raw_pci_read_config(p, bus->number, fn, config, size, value);
>  }
>  
>  static int faraday_raw_pci_write_config(struct faraday_pci *p, int bus_number,
> @@ -262,10 +269,10 @@ static void faraday_pci_ack_irq(struct irq_data *d)
>  	struct faraday_pci *p = irq_data_get_irq_chip_data(d);
>  	unsigned int reg;
>  
> -	faraday_pci_read_config(p->bus, 0, FARADAY_PCI_CTRL2, 4, &reg);
> +	faraday_raw_pci_read_config(p, 0, 0, FARADAY_PCI_CTRL2, 4, &reg);
>  	reg &= ~(0xF << PCI_CTRL2_INTSTS_SHIFT);
>  	reg |= BIT(irqd_to_hwirq(d) + PCI_CTRL2_INTSTS_SHIFT);
> -	faraday_pci_write_config(p->bus, 0, FARADAY_PCI_CTRL2, 4, reg);
> +	faraday_raw_pci_write_config(p, 0, 0, FARADAY_PCI_CTRL2, 4, reg);
>  }
>  
>  static void faraday_pci_mask_irq(struct irq_data *d)
> @@ -273,10 +280,10 @@ static void faraday_pci_mask_irq(struct irq_data *d)
>  	struct faraday_pci *p = irq_data_get_irq_chip_data(d);
>  	unsigned int reg;
>  
> -	faraday_pci_read_config(p->bus, 0, FARADAY_PCI_CTRL2, 4, &reg);
> +	faraday_raw_pci_read_config(p, 0, 0, FARADAY_PCI_CTRL2, 4, &reg);
>  	reg &= ~((0xF << PCI_CTRL2_INTSTS_SHIFT)
>  		 | BIT(irqd_to_hwirq(d) + PCI_CTRL2_INTMASK_SHIFT));
> -	faraday_pci_write_config(p->bus, 0, FARADAY_PCI_CTRL2, 4, reg);
> +	faraday_raw_pci_write_config(p, 0, 0, FARADAY_PCI_CTRL2, 4, reg);
>  }
>  
>  static void faraday_pci_unmask_irq(struct irq_data *d)
> @@ -284,10 +291,10 @@ static void faraday_pci_unmask_irq(struct irq_data *d)
>  	struct faraday_pci *p = irq_data_get_irq_chip_data(d);
>  	unsigned int reg;
>  
> -	faraday_pci_read_config(p->bus, 0, FARADAY_PCI_CTRL2, 4, &reg);
> +	faraday_raw_pci_read_config(p, 0, 0, FARADAY_PCI_CTRL2, 4, &reg);
>  	reg &= ~(0xF << PCI_CTRL2_INTSTS_SHIFT);
>  	reg |= BIT(irqd_to_hwirq(d) + PCI_CTRL2_INTMASK_SHIFT);
> -	faraday_pci_write_config(p->bus, 0, FARADAY_PCI_CTRL2, 4, reg);
> +	faraday_raw_pci_write_config(p, 0, 0, FARADAY_PCI_CTRL2, 4, reg);
>  }
>  
>  static void faraday_pci_irq_handler(struct irq_desc *desc)
> @@ -296,7 +303,7 @@ static void faraday_pci_irq_handler(struct irq_desc *desc)
>  	struct irq_chip *irqchip = irq_desc_get_chip(desc);
>  	unsigned int irq_stat, reg, i;
>  
> -	faraday_pci_read_config(p->bus, 0, FARADAY_PCI_CTRL2, 4, &reg);
> +	faraday_raw_pci_read_config(p, 0, 0, FARADAY_PCI_CTRL2, 4, &reg);
>  	irq_stat = reg >> PCI_CTRL2_INTSTS_SHIFT;
>  
>  	chained_irq_enter(irqchip, desc);
> @@ -417,8 +424,8 @@ static int faraday_pci_parse_map_dma_ranges(struct faraday_pci *p,
>  		dev_info(dev, "DMA MEM%d BASE: 0x%016llx -> 0x%016llx config %08x\n",
>  			 i + 1, range.pci_addr, end, val);
>  		if (i <= 2) {
> -			faraday_pci_write_config(p->bus, 0, confreg[i],
> -						 4, val);
> +			faraday_raw_pci_write_config(p, 0, 0, confreg[i],
> +						     4, val);
>  		} else {
>  			dev_err(dev, "ignore extraneous dma-range %d\n", i);
>  			break;
> @@ -443,6 +450,8 @@ static int faraday_pci_probe(struct platform_device *pdev)
>  	struct resource *io;
>  	struct pci_host_bridge *host;
>  	struct clk *clk;
> +	unsigned char max_bus_speed = PCI_SPEED_33MHz;
> +	unsigned char cur_bus_speed = PCI_SPEED_33MHz;
>  	int ret;
>  	u32 val;
>  	LIST_HEAD(res);
> @@ -546,27 +555,27 @@ static int faraday_pci_probe(struct platform_device *pdev)
>  		unsigned long rate;
>  		u32 val;
>  
> -		faraday_pci_read_config(p->bus, 0,
> -					FARADAY_PCI_STATUS_CMD, 4, &val);
> +		faraday_raw_pci_read_config(p, 0, 0,
> +					    FARADAY_PCI_STATUS_CMD, 4, &val);
>  		rate = clk_get_rate(p->bus_clk);
>  
>  		if ((rate == 33000000) && (val & PCI_STATUS_66MHZ_CAPABLE)) {
>  			dev_info(dev, "33MHz bus is 66MHz capable\n");
> -			p->bus->max_bus_speed = PCI_SPEED_66MHz;
> +			max_bus_speed = PCI_SPEED_66MHz;
>  			ret = clk_set_rate(p->bus_clk, 66000000);
>  			if (ret)
>  				dev_err(dev, "failed to set bus clock\n");
>  		} else {
>  			dev_info(dev, "33MHz only bus\n");
> -			p->bus->max_bus_speed = PCI_SPEED_33MHz;
> +			max_bus_speed = PCI_SPEED_33MHz;
>  		}
>  
>  		/* Bumping the clock may fail so read back the rate */
>  		rate = clk_get_rate(p->bus_clk);
>  		if (rate == 33000000)
> -			p->bus->cur_bus_speed = PCI_SPEED_33MHz;
> +			cur_bus_speed = PCI_SPEED_33MHz;
>  		if (rate == 66000000)
> -			p->bus->cur_bus_speed = PCI_SPEED_66MHz;
> +			cur_bus_speed = PCI_SPEED_66MHz;
>  	}
>  
>  	ret = faraday_pci_parse_map_dma_ranges(p, dev->of_node);
> @@ -580,6 +589,8 @@ static int faraday_pci_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  	p->bus = host->bus;
> +	p->bus->max_bus_speed = max_bus_speed;
> +	p->bus->cur_bus_speed = cur_bus_speed;
>  
>  	pci_bus_assign_resources(p->bus);
>  	pci_bus_add_devices(p->bus);
> -- 
> 2.9.4
> 
