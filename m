Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60607 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032457AbbKENtx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 5 Nov 2015 08:49:53 -0500
Date: Thu, 5 Nov 2015 07:49:47 -0600
From: Rob Herring <robh@kernel.org>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar (usb): DT can override default window settings
Message-ID: <20151105134947.GA26919@rob-hp-laptop>
References: <1446567566-10952-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446567566-10952-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 03, 2015 at 04:19:26PM +0000, Phil Edworthy wrote:
> If the dtb specifies dma-ranges, we use those values. Otherwise, we
> default to the values that were previously hardcoded into the driver.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>  .../devicetree/bindings/pci/pci-rcar-gen2.txt      |  6 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pci/host/pci-rcar-gen2.c                   | 76 +++++++++++++++++++++-
>  2 files changed, 79 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> index 7fab84b..891463c 100644
> --- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> @@ -24,6 +24,11 @@ Required properties:
>  - interrupt-map-mask: standard property that helps to define the interrupt
>    mapping.
>  
> +Optional properties:
> +- dma-ranges: a single range for the inbound memory region. If not supplied,
> +  defaults to 1GiB at 0x40000000. Note there are hardware restrictions on the
> +  allowed combinations of address and size.
> +
>  Example SoC configuration:
>  
>  	pci0: pci@ee090000  {
> @@ -38,6 +43,7 @@ Example SoC configuration:
>  		#address-cells = <3>;
>  		#size-cells = <2>;
>  		#interrupt-cells = <1>;
> +		dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
>  		interrupt-map-mask = <0xff00 0 0 0x7>;
>  		interrupt-map = <0x0000 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
>  				 0x0800 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> index c4f64bf..6295116 100644
> --- a/drivers/pci/host/pci-rcar-gen2.c
> +++ b/drivers/pci/host/pci-rcar-gen2.c
> @@ -15,6 +15,7 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of_address.h>
>  #include <linux/of_pci.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> @@ -102,6 +103,8 @@ struct rcar_pci_priv {
>  	unsigned busnr;
>  	int irq;
>  	unsigned long window_size;
> +	unsigned long window_addr;
> +	unsigned long window_pci;
>  };
>  
>  /* PCI configuration space operations */
> @@ -239,8 +242,8 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
>  	       RCAR_PCI_ARBITER_PCIBP_MODE;
>  	iowrite32(val, reg + RCAR_PCI_ARBITER_CTR_REG);
>  
> -	/* PCI-AHB mapping: 0x40000000 base */
> -	iowrite32(0x40000000 | RCAR_PCIAHB_PREFETCH16,
> +	/* PCI-AHB mapping */
> +	iowrite32(priv->window_addr | RCAR_PCIAHB_PREFETCH16,
>  		  reg + RCAR_PCIAHB_WIN1_CTR_REG);
>  
>  	/* AHB-PCI mapping: OHCI/EHCI registers */
> @@ -251,7 +254,7 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
>  	iowrite32(RCAR_AHBPCI_WIN1_HOST | RCAR_AHBPCI_WIN_CTR_CFG,
>  		  reg + RCAR_AHBPCI_WIN1_CTR_REG);
>  	/* Set PCI-AHB Window1 address */
> -	iowrite32(0x40000000 | PCI_BASE_ADDRESS_MEM_PREFETCH,
> +	iowrite32(priv->window_pci | PCI_BASE_ADDRESS_MEM_PREFETCH,
>  		  reg + PCI_BASE_ADDRESS_1);
>  	/* Set AHB-PCI bridge PCI communication area address */
>  	val = priv->cfg_res->start + RCAR_AHBPCI_PCICOM_OFFSET;
> @@ -284,6 +287,64 @@ static struct pci_ops rcar_pci_ops = {
>  	.write	= pci_generic_config_write,
>  };
>  
> +static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
> +				     struct device_node *node)
> +{
> +	const int na = 3, ns = 2;
> +	int rlen;
> +
> +	parser->node = node;
> +	parser->pna = of_n_addr_cells(node);
> +	parser->np = parser->pna + na + ns;
> +
> +	parser->range = of_get_property(node, "dma-ranges", &rlen);
> +	if (!parser->range)
> +		return -ENOENT;
> +
> +	parser->end = parser->range + rlen / sizeof(__be32);
> +	return 0;
> +}
> +
> +static int rcar_pci_parse_map_dma_ranges(struct rcar_pci_priv *pci,
> +					 struct device_node *np)
> +{
> +	struct of_pci_range range;
> +	struct of_pci_range_parser parser;
> +	int index = 0;
> +
> +	/* Failure to parse is ok as we fall back to defaults */
> +	if (pci_dma_range_parser_init(&parser, np))
> +		return 0;
> +
> +	/* Get the dma-ranges from DT */
> +	for_each_of_pci_range(&parser, &range) {
> +		/* Hardware only allows one inbound 32-bit range */
> +		if (index)
> +			return -EINVAL;
> +
> +		pci->window_addr = (unsigned long)range.cpu_addr;
> +		pci->window_pci = (unsigned long)range.pci_addr;
> +		pci->window_size = (unsigned long)range.size;
> +
> +		/* Catch HW limitations */
> +		if (!(range.flags & IORESOURCE_PREFETCH)) {
> +			dev_err(pci->dev, "window must be prefetchable\n");
> +			return -EINVAL;
> +		}
> +		if (pci->window_addr) {
> +			u32 lowaddr = 1 << (ffs(pci->window_addr) - 1);
> +
> +			if (lowaddr < pci->window_size) {
> +				dev_err(pci->dev, "invalid window size/addr\n");
> +				return -EINVAL;
> +			}
> +		}
> +		index++;
> +	}
> +
> +	return 0;
> +}
> +
>  static int rcar_pci_probe(struct platform_device *pdev)
>  {
>  	struct resource *cfg_res, *mem_res;
> @@ -329,6 +390,9 @@ static int rcar_pci_probe(struct platform_device *pdev)
>  		return priv->irq;
>  	}
>  
> +	/* default window addr and size if not specified in DT */
> +	priv->window_addr = 0x40000000;
> +	priv->window_pci = 0x40000000;
>  	priv->window_size = SZ_1G;
>  
>  	if (pdev->dev.of_node) {
> @@ -344,6 +408,12 @@ static int rcar_pci_probe(struct platform_device *pdev)
>  		priv->busnr = busnr.start;
>  		if (busnr.end != busnr.start)
>  			dev_warn(&pdev->dev, "only one bus number supported\n");
> +
> +		ret = rcar_pci_parse_map_dma_ranges(priv, pdev->dev.of_node);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "failed to parse dma-range\n");
> +			return ret;
> +		}
>  	} else {
>  		priv->busnr = pdev->id;
>  	}
> -- 
> 1.9.1
> 
