Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50260 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbbKYXOj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Nov 2015 18:14:39 -0500
Date: Wed, 25 Nov 2015 17:14:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH v2] PCI: imx6: add dt prop for link gen, default to gen1
Message-ID: <20151125231435.GI8869@localhost>
References: <1446735481-27326-1-git-send-email-tharvey@gateworks.com>
 <1447942365-11662-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447942365-11662-1-git-send-email-tharvey@gateworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tim,

On Thu, Nov 19, 2015 at 06:12:45AM -0800, Tim Harvey wrote:
> Freescale has stated [1] that the LVDS clock source of the IMX6 does not pass
> the PCI Gen2 clock jitter test, therefore unless an external Gen2 compliant
> external clock source is present and supplied back to the IMX6 PCIe core
> via LVDS CLK1/CLK2 you can not claim Gen2 compliance.
> 
> Add a dt property to specify gen1 vs gen2 and check this before allowing
> a Gen2 link.
> 
> We default to Gen1 if the property is not present because at this time there
> are no IMX6 boards in mainline that 'input' a clock on LVDS CLK1/CLK2.
> 
> In order to be Gen2 compliant on IMX6 you need to:
>  - have a Gen2 compliant external clock generator and route that clock back
>    to either LVDS CLK1 or LVDS CLK2 as an input.
>    (see IMX6SX-SabreSD reference design)
>  - specify this clock in the pcie node in the dt
>    (ie IMX6QDL_CLK_LVDS1_IN or IMX6QDL_CLK_LVDS2_IN instead of
>     IMX6QDL_CLK_LVDS1_GATE which configures it as a CLK output)
> 
> [1] https://community.freescale.com/message/453209
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v2:
>  - moved dt property to designware core
> 
>  .../devicetree/bindings/pci/designware-pcie.txt          |  1 +
>  drivers/pci/host/pci-imx6.c                              | 16 ++++++++++------
>  drivers/pci/host/pcie-designware.c                       |  4 ++++
>  drivers/pci/host/pcie-designware.h                       |  1 +
>  4 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index 9f4faa8..a9a94b9 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -26,3 +26,4 @@ Optional properties:
>  - bus-range: PCI bus numbers covered (it is recommended for new devicetrees to
>    specify this property, to keep backwards compatibility a range of 0x00-0xff
>    is assumed if not present)
> +- max-link-speed: Specify PCI gen for link capability (ie 2 for gen2)

Is there some sort of DT or OF spec that lists "max-link-speed" as a
generic property?  I see Lucas' desire to have this be common across
DesignWare PCIe cores.  Should it be moved up a level even from there,
i.e., to bindings/pci/pci.txt?

It might be worth mentioning in pci/fsl,imx6q-pcie.txt that we limit
the link to gen1 unless max-link-speed is present and has the value
"2".

> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 8f3a981..6a9f310 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -392,11 +392,15 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
>  	if (ret)
>  		return ret;
>  
> -	/* Allow Gen2 mode after the link is up. */
> -	tmp = readl(pp->dbi_base + PCIE_RC_LCR);
> -	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
> -	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2;
> -	writel(tmp, pp->dbi_base + PCIE_RC_LCR);
> +	if (pp->link_gen == 2) {
> +		/* Allow Gen2 mode after the link is up. */
> +		tmp = readl(pp->dbi_base + PCIE_RC_LCR);
> +		tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
> +		tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2;
> +		writel(tmp, pp->dbi_base + PCIE_RC_LCR);
> +	} else {
> +		dev_info(pp->dev, "Link: Gen2 disabled\n");
> +	}
>  
>  	/*
>  	 * Start Directed Speed Change so the best possible speed both link
> @@ -420,7 +424,7 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
>  	}
>  
>  	tmp = readl(pp->dbi_base + PCIE_RC_LCSR);
> -	dev_dbg(pp->dev, "Link up, Gen=%i\n", (tmp >> 16) & 0xf);
> +	dev_info(pp->dev, "Link up, Gen%i\n", (tmp >> 16) & 0xf);
>  	return 0;
>  }
>  
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 52aa6e3..7aa81ff 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -487,6 +487,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		return -EINVAL;
>  	}
>  
> +	pp->link_gen = -1;
> +	if (of_property_read_u32(np, "max-link-speed", &ret) == 0)
> +		pp->link_gen = ret;
> +
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		if (!pp->ops->msi_host_init) {
>  			pp->irq_domain = irq_domain_add_linear(pp->dev->of_node,
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index d0bbd27..5ce821d 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -48,6 +48,7 @@ struct pcie_port {
>  	struct resource		busn;
>  	int			irq;
>  	u32			lanes;
> +	int			link_gen;
>  	struct pcie_host_ops	*ops;
>  	int			msi_irq;
>  	struct irq_domain	*irq_domain;
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
