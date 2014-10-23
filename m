Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:35866 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbaJWQd2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Oct 2014 12:33:28 -0400
Received: by mail-yh0-f41.google.com with SMTP id i57so1666071yha.0
        for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2014 09:33:27 -0700 (PDT)
Date: Thu, 23 Oct 2014 10:33:24 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND ] PCI: exynos: Add exynos prefix before
 add_pcie_port/pcie_init
Message-ID: <20141023163324.GA15847@google.com>
References: <000001cfedb4$de2ab230$9a801690$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000001cfedb4$de2ab230$9a801690$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 22, 2014 at 01:58:49PM +0900, Jingoo Han wrote:
> The add_pcie_port/pcie_init functions are Exynos-specific.
> Add exynos prefix to avoid collision in global name space.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to pci/host-exynos for v3.19, thanks!

> ---
>  drivers/pci/host/pci-exynos.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index c5d0ca3..902d7cd 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -509,8 +509,8 @@ static struct pcie_host_ops exynos_pcie_host_ops = {
>  	.host_init = exynos_pcie_host_init,
>  };
>  
> -static int __init add_pcie_port(struct pcie_port *pp,
> -				struct platform_device *pdev)
> +static int __init exynos_add_pcie_port(struct pcie_port *pp,
> +				       struct platform_device *pdev)
>  {
>  	int ret;
>  
> @@ -615,7 +615,7 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
>  		goto fail_bus_clk;
>  	}
>  
> -	ret = add_pcie_port(pp, pdev);
> +	ret = exynos_add_pcie_port(pp, pdev);
>  	if (ret < 0)
>  		goto fail_bus_clk;
>  
> @@ -656,11 +656,11 @@ static struct platform_driver exynos_pcie_driver = {
>  
>  /* Exynos PCIe driver does not allow module unload */
>  
> -static int __init pcie_init(void)
> +static int __init exynos_pcie_init(void)
>  {
>  	return platform_driver_probe(&exynos_pcie_driver, exynos_pcie_probe);
>  }
> -subsys_initcall(pcie_init);
> +subsys_initcall(exynos_pcie_init);
>  
>  MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
>  MODULE_DESCRIPTION("Samsung PCIe host controller driver");
> -- 
> 1.7.9.5
> 
> 
