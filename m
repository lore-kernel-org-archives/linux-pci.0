Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755246AbcHSBgP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Aug 2016 21:36:15 -0400
Date: Thu, 18 Aug 2016 15:47:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: tegra: Use of_device_get_match_data()
Message-ID: <20160818204735.GN27353@localhost>
References: <20160815153132.520-1-thierry.reding@gmail.com>
 <20160815153132.520-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160815153132.520-2-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 15, 2016 at 05:31:32PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This function was introduced a couple of releases ago to help reduce the
> the boilerplate required to get at the SoC specific data.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied to pci/host-tegra for v4.9, thanks!

> ---
>  drivers/pci/host/pci-tegra.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 7756a792600c..2d520755b1d7 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -2201,21 +2201,16 @@ remove:
>  
>  static int tegra_pcie_probe(struct platform_device *pdev)
>  {
> -	const struct of_device_id *match;
>  	struct tegra_pcie *pcie;
>  	int err;
>  
> -	match = of_match_device(tegra_pcie_of_match, &pdev->dev);
> -	if (!match)
> -		return -ENODEV;
> -
>  	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
>  	if (!pcie)
>  		return -ENOMEM;
>  
> +	pcie->soc = of_device_get_match_data(&pdev->dev);
>  	INIT_LIST_HEAD(&pcie->buses);
>  	INIT_LIST_HEAD(&pcie->ports);
> -	pcie->soc = match->data;
>  	pcie->dev = &pdev->dev;
>  
>  	err = tegra_pcie_parse_dt(pcie);
> -- 
> 2.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
