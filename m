Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:46836 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934965AbcJQOem (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2016 10:34:42 -0400
Subject: Re: [PATCH] PCI: designware: check for iATU unroll support after
 initializing host
To: Niklas Cassel <niklas.cassel@axis.com>, <jingoohan1@gmail.com>,
        <pratyush.anand@gmail.com>, <bhelgaas@google.com>,
        <Joao.Pinto@synopsys.com>
References: <1476482095-26289-1-git-send-email-niklass@axis.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Niklas Cassel <niklass@axis.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <74f25cf5-b307-9799-87a7-e359b3698304@synopsys.com>
Date: Mon, 17 Oct 2016 15:34:19 +0100
MIME-Version: 1.0
In-Reply-To: <1476482095-26289-1-git-send-email-niklass@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 10/14/2016 10:54 PM, Niklas Cassel wrote:
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
> 

Acked-by: Joao Pinto <jpinto@synopsys.com>

Thanks
Joao
