Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51508 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754306AbcHAR6E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 1 Aug 2016 13:58:04 -0400
Date: Mon, 1 Aug 2016 12:47:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Remove stray call to pci_ioremap_io()
Message-ID: <20160801174702.GA6592@localhost>
References: <20160801070539.24779-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160801070539.24779-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 01, 2016 at 09:05:39AM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This was introduced by an unfortunate interaction between commits
> 45c64b6ac4ef ("PCI: tegra: Request host bridge window resources with
> core function") and e6e9f471f5fe ("PCI: tegra: Use generic
> pci_remap_iospace() rather than ARM32-specific one").
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Thanks, I re-did the merge and fixed my mistake.

> ---
>  drivers/pci/host/pci-tegra.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 2544937620a5..6de0757b11e4 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -621,8 +621,6 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
>  	if (err < 0)
>  		return err;
>  
> -	pci_ioremap_io(pcie->pio.start, pcie->io.start);
> -
>  	pci_add_resource_offset(&sys->resources, &pcie->pio, sys->io_offset);
>  	pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
>  	pci_add_resource_offset(&sys->resources, &pcie->prefetch,
> -- 
> 2.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
