Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752280AbcKBQ0q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Nov 2016 12:26:46 -0400
Date: Wed, 2 Nov 2016 11:26:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: jingoohan1@gmail.com, pratyush.anand@gmail.com,
        bhelgaas@google.com, Joao.Pinto@synopsys.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <niklass@axis.com>
Subject: Re: [PATCH] PCI: designware: check for iATU unroll support after
 initializing host
Message-ID: <20161102162639.GB6568@bhelgaas-glaptop.roam.corp.google.com>
References: <1476482095-26289-1-git-send-email-niklass@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476482095-26289-1-git-send-email-niklass@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 14, 2016 at 11:54:55PM +0200, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@axis.com>
> 
> dw_pcie_iatu_unroll_enabled reads a dbi_base register.
> Reading any dbi_base register before pp->ops->host_init has been called
> causes "imprecise external abort" on platforms like ARTPEC-6, where the
> PCIe module is disabled at boot and first enabled in pp->ops->host_init.
> Move dw_pcie_iatu_unroll_enabled to dw_pcie_setup_rc, since it is after
> pp->ops->host_init, but before pp->iatu_unroll_enabled is actually used.
> 
> Fixes: a0601a470537 ("PCI: designware: Add iATU Unroll feature")
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

Applied to for-linus for v4.9 with acks and tested-by from Joao, Olof,
and James, thanks!

> ---
>  drivers/pci/host/pcie-designware.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 035f50c03281..bed19994c1e9 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -637,8 +637,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		}
>  	}
>  
> -	pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
> -
>  	if (pp->ops->host_init)
>  		pp->ops->host_init(pp);
>  
> @@ -809,6 +807,11 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  {
>  	u32 val;
>  
> +	/* get iATU unroll support */
> +	pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
> +	dev_dbg(pp->dev, "iATU unroll: %s\n",
> +		pp->iatu_unroll_enabled ? "enabled" : "disabled");
> +
>  	/* set the number of lanes */
>  	val = dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL);
>  	val &= ~PORT_LINK_MODE_MASK;
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
