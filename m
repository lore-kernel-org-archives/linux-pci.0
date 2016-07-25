Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 25 Jul 2016 12:30:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: kishon@ti.com, bhelgaas@google.com, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: dra7xx: Fix return value in case of error
Message-ID: <20160725173047.GC12484@localhost>
References: <1468531107-3639-1-git-send-email-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1468531107-3639-1-git-send-email-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 14, 2016 at 11:18:27PM +0200, Christophe JAILLET wrote:
> In function 'dra7xx_pcie_init_irq_domain', the pattern used to check and
> return error is:
> 
>    if (!var) {
>       dev_err(...);
>       return PTR_ERR(var);
>    }
> 
> So the returned value in case of error is always 0, which means 'success'.
> Change it to return -ENODEV instead.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied with Kishon's reviewed-by to pci/host-dra7xx for v4.8, thanks!

> ---
>  drivers/pci/host/pci-dra7xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> index f441130..81b3949 100644
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -181,14 +181,14 @@ static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
>  
>  	if (!pcie_intc_node) {
>  		dev_err(dev, "No PCIe Intc node found\n");
> -		return PTR_ERR(pcie_intc_node);
> +		return -ENODEV;
>  	}
>  
>  	pp->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
>  					       &intx_domain_ops, pp);
>  	if (!pp->irq_domain) {
>  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> -		return PTR_ERR(pp->irq_domain);
> +		return -ENODEV;
>  	}
>  
>  	return 0;
> -- 
> 2.7.4
> 
> 
> ---
> L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
> https://www.avast.com/antivirus
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
