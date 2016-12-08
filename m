Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751540AbcLHS0i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Dec 2016 13:26:38 -0500
Date: Thu, 8 Dec 2016 12:26:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Gospodarek <gospo@broadcom.com>
Cc: bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, Ray Jui <rjui@broadcom.com>
Subject: Re: [PATCH pci/host-iproc] pci-iproc: skip check for legacy IRQ on
 PAXC buses
Message-ID: <20161208182634.GA30533@bhelgaas-glaptop.roam.corp.google.com>
References: <1480624492-32420-1-git-send-email-gospo@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1480624492-32420-1-git-send-email-gospo@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 01, 2016 at 03:34:52PM -0500, Andy Gospodarek wrote:
> PAXC and PAXCv2 buses do not support legacy IRQs so there is no reason
> to even try and map them.  Without a change like this, one cannot create
> VFs on Nitro ports since legacy interrupts are checked as part of the
> PCI device creation process.  Testing on PAXC hardware showed that VFs
> are properly created with only the change to not set pcie->map_irq, but
> just to be safe the change in iproc_pcie_setup will ensure that
> pdev_fixup_irq will not panic.
> 
> Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Ray Jui <rjui@broadcom.com>

Applied to pci/host-iproc for v4.10 with Ray's acked-by, thanks!

> ---
>  drivers/pci/host/pcie-iproc-platform.c | 9 ++++++++-
>  drivers/pci/host/pcie-iproc.c          | 5 ++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
> index fd3ed9b..22d814a 100644
> --- a/drivers/pci/host/pcie-iproc-platform.c
> +++ b/drivers/pci/host/pcie-iproc-platform.c
> @@ -108,7 +108,14 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	pcie->map_irq = of_irq_parse_and_map_pci;
> +	/* PAXC doesn't support legacy IRQs, skip mapping */
> +	switch (pcie->type) {
> +	case IPROC_PCIE_PAXC:
> +	case IPROC_PCIE_PAXC_V2:
> +		break;
> +	default:
> +		pcie->map_irq = of_irq_parse_and_map_pci;
> +	}
>  
>  	ret = iproc_pcie_setup(pcie, &res);
>  	if (ret)
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index cd51334..3ebc025 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -1274,7 +1274,10 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  
>  	pci_scan_child_bus(bus);
>  	pci_assign_unassigned_bus_resources(bus);
> -	pci_fixup_irqs(pci_common_swizzle, pcie->map_irq);
> +
> +	if (pcie->map_irq)
> +		pci_fixup_irqs(pci_common_swizzle, pcie->map_irq);
> +
>  	pci_bus_add_devices(bus);
>  
>  	return 0;
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
