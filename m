Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41164 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753113AbcGYV2z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Jul 2016 17:28:55 -0400
Date: Mon, 25 Jul 2016 16:28:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: tegra: Stop setting pcibios_min_mem
Message-ID: <20160725212850.GA24485@localhost>
References: <20160630131430.32096-1-thierry.reding@gmail.com>
 <20160630131430.32096-3-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160630131430.32096-3-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 30, 2016 at 03:14:30PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> In practice this value will never be used and it hinders portability of
> the driver, so remove it.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/pci/host/pci-tegra.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index f04b062e8c67..bbf77a49517d 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -2249,8 +2249,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  	if (err < 0)
>  		return err;
>  
> -	pcibios_min_mem = 0;

unsigned long pcibios_min_mem = 0x01000000;   # arch/arm/mm/iomap.c
#define PCIBIOS_MIN_MEM pcibios_min_mem       # arch/arm/include/asm/pci.h

PCIBIOS_MIN_MEM is used in __pci_assign_resource().

It looks to me like we still use pcibios_min_mem; am I missing something?

>  	err = tegra_pcie_get_resources(pcie);
>  	if (err < 0) {
>  		dev_err(&pdev->dev, "failed to request resources: %d\n", err);
> -- 
> 2.8.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
