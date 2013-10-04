Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f42.google.com ([209.85.213.42]:49093 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab3JDWuq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Oct 2013 18:50:46 -0400
Received: by mail-yh0-f42.google.com with SMTP id z12so1162283yhz.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Oct 2013 15:50:45 -0700 (PDT)
Date: Fri, 4 Oct 2013 16:50:39 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: kgene.kim@samsung.com, grant.likely@linaro.org,
	rob.herring@calxeda.com, jg1.han@samsung.com, tgih.jun@samsung.com,
	yongjun_wei@trendmicro.com.cn, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Subject: Re: [PATCH] PCI: exynos: missing clk_disable_unprepare() on error in
 exynos_pcie_probe()
Message-ID: <20131004225039.GA26108@google.com>
References: <CAPgLHd_RTNxi-OYhmTZ35NttjnAg-gQ_WKHkUQr5ueMhXVLTMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPgLHd_RTNxi-OYhmTZ35NttjnAg-gQ_WKHkUQr5ueMhXVLTMg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Sep 29, 2013 at 10:29:11AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add the missing clk_disable_unprepare() before return
> from exynos_pcie_probe() in the error handling case.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied with Jingoo's ack and Sylwester's subject line to
pci/host-exynos.  Thanks!

Bjorn

> ---
>  drivers/pci/host/pci-exynos.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index 94e096b..e25598a 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -487,18 +487,24 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
>  
>  	elbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	exynos_pcie->elbi_base = devm_ioremap_resource(&pdev->dev, elbi_base);
> -	if (IS_ERR(exynos_pcie->elbi_base))
> -		return PTR_ERR(exynos_pcie->elbi_base);
> +	if (IS_ERR(exynos_pcie->elbi_base)) {
> +		ret = PTR_ERR(exynos_pcie->elbi_base);
> +		goto fail_bus_clk;
> +	}
>  
>  	phy_base = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>  	exynos_pcie->phy_base = devm_ioremap_resource(&pdev->dev, phy_base);
> -	if (IS_ERR(exynos_pcie->phy_base))
> -		return PTR_ERR(exynos_pcie->phy_base);
> +	if (IS_ERR(exynos_pcie->phy_base)) {
> +		ret = PTR_ERR(exynos_pcie->phy_base);
> +		goto fail_bus_clk;
> +	}
>  
>  	block_base = platform_get_resource(pdev, IORESOURCE_MEM, 2);
>  	exynos_pcie->block_base = devm_ioremap_resource(&pdev->dev, block_base);
> -	if (IS_ERR(exynos_pcie->block_base))
> -		return PTR_ERR(exynos_pcie->block_base);
> +	if (IS_ERR(exynos_pcie->block_base)) {
> +		ret = PTR_ERR(exynos_pcie->block_base);
> +		goto fail_bus_clk;
> +	}
>  
>  	ret = add_pcie_port(pp, pdev);
>  	if (ret < 0)
> 
