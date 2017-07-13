Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750857AbdGMD3u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jul 2017 23:29:50 -0400
Date: Wed, 12 Jul 2017 22:29:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>
Subject: Re: [PATCH] PCI: iproc: remove unused struct iproc_pcie *pcie
Message-ID: <20170713032947.GG4486@bhelgaas-glaptop.roam.corp.google.com>
References: <1499852825-64990-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499852825-64990-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 12, 2017 at 05:47:05PM +0800, Shawn Lin wrote:
> It was never used and could be removed, otherwise
> we could see a warning:
> 
> drivers/pci/host/pcie-iproc-msi.c: In function 'iproc_msi_handler':
> drivers/pci/host/pcie-iproc-msi.c:320:21: warning: variable 'pcie' set
> but not used [-Wunused-but-set-variable]
> 
> Cc: Ray Jui <rjui@broadcom.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/host-iproc for v4.14, thanks!

> ---
> 
>  drivers/pci/host/pcie-iproc-msi.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc-msi.c b/drivers/pci/host/pcie-iproc-msi.c
> index 9fad791..2d0f535 100644
> --- a/drivers/pci/host/pcie-iproc-msi.c
> +++ b/drivers/pci/host/pcie-iproc-msi.c
> @@ -317,7 +317,6 @@ static void iproc_msi_handler(struct irq_desc *desc)
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>  	struct iproc_msi_grp *grp;
>  	struct iproc_msi *msi;
> -	struct iproc_pcie *pcie;
>  	u32 eq, head, tail, nr_events;
>  	unsigned long hwirq;
>  	int virq;
> @@ -326,7 +325,6 @@ static void iproc_msi_handler(struct irq_desc *desc)
>  
>  	grp = irq_desc_get_handler_data(desc);
>  	msi = grp->msi;
> -	pcie = msi->pcie;
>  	eq = grp->eq;
>  
>  	/*
> -- 
> 1.9.1
> 
> 
