Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:54821 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbcJHUqF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Oct 2016 16:46:05 -0400
Date: Sat, 8 Oct 2016 11:37:52 +0900
From: Simon Horman <horms@verge.net.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 01/10] PCI: rcar: Rename accessors
Message-ID: <20161008023752.GC14617@verge.net.au>
References: <20161007162446.23279.48813.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161007162446.23279.48813.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 07, 2016 at 11:24:46AM -0500, Bjorn Helgaas wrote:
> Rename rcar_pci_read_reg() to rcar_readl() and rcar_pci_write_reg() to
> rcar_writel() for consistency with other drivers.  No functional change
> intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I am fine with this entire series.

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/pci/host/pcie-rcar.c |  142 ++++++++++++++++++++----------------------
>  1 file changed, 68 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index e06b1d3..b6899c8 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -152,16 +152,15 @@ struct rcar_pcie {
>  	struct			rcar_msi msi;
>  };
>  
> -static void rcar_pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
> -			       unsigned long reg)
> +static unsigned long rcar_readl(struct rcar_pcie *pcie, unsigned long reg)
>  {
> -	writel(val, pcie->base + reg);
> +	return readl(pcie->base + reg);
>  }
>  
> -static unsigned long rcar_pci_read_reg(struct rcar_pcie *pcie,
> -				       unsigned long reg)
> +static void rcar_writel(struct rcar_pcie *pcie, unsigned long val,
> +			unsigned long reg)
>  {
> -	return readl(pcie->base + reg);
> +	writel(val, pcie->base + reg);
>  }

The diff might have been a bit easier on the eyes if rcar_pci_write_reg()
was after rcar_pci_read_reg()
