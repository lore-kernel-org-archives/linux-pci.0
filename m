Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 17 Oct 2016 08:01:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: layerscape: Fix drvdata usage before assignment
Message-ID: <20161017130145.GB18903@localhost>
References: <1476700772-18745-1-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476700772-18745-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 17, 2016 at 11:39:32AM +0100, Marc Zyngier wrote:
> Commit fefe6733e516 ("PCI: layerscape: Move struct pcie_port setup
> to probe function") changed the init ordering of the pcie structure,
> but started to use the pcie->drvdata field before initializing it.
> Mayhem follows.
> 
> Fix this by moving the drvdata assignment right before the first use.
> Tested on LS2085a.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Applied to for-linus for v4.9, thanks, Marc!

> ---
>  drivers/pci/host/pci-layerscape.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
> index 856d428..27602a3 100644
> --- a/drivers/pci/host/pci-layerscape.c
> +++ b/drivers/pci/host/pci-layerscape.c
> @@ -270,6 +270,7 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
>  
>  	pp = &pcie->pp;
>  	pp->dev = dev;
> +	pcie->drvdata = match->data;
>  	pp->ops = pcie->drvdata->ops;
>  
>  	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
> @@ -279,7 +280,6 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(pcie->pp.dbi_base);
>  	}
>  
> -	pcie->drvdata = match->data;
>  	pcie->lut = pcie->pp.dbi_base + pcie->drvdata->lut_offset;
>  
>  	if (!ls_pcie_is_bridge(pcie))
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
