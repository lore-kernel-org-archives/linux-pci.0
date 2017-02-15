Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 15 Feb 2017 15:03:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, krzk@kernel.org,
        linux-kernel@vger.kernel.org, jingoohan1@gmail.com,
        javier@osg.samsung.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org, cpgs@samsung.com,
        niyas.ahmed@samsung.com, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, kishon@ti.com,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        vivek.gautam@codeaurora.org, robh+dt@kernel.org
Subject: Re: [PATCH V3 4/4] PCI: exynos: support the using PHY generic
 framework
Message-ID: <20170215210357.GA13006@bhelgaas-glaptop.roam.corp.google.com>
References: <20170213082613.19628-1-jh80.chung@samsung.com>
 <CGME20170213082616epcas5p2a20cca498e9ddde7c5d3f7664fb8606e@epcas5p2.samsung.com>
 <20170213082613.19628-5-jh80.chung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170213082613.19628-5-jh80.chung@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 13, 2017 at 05:26:13PM +0900, Jaehoon Chung wrote:
> Switch the pci-exynos driver to generic PHY framework. At the same time
> backward compatibility is preserved: Warning will be printed for old
> DTB.
> 
> Refer to the binding file:
> - Documentation/devictree/bindings/pci/samsung,exynos5440-pcie.txt
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> Changelog on V3:
> - Changes the commit-message
> - Fixes the merge conflict
> 
> Changelog on V2:
> - This patch is split from previous PATCH[1/4]
> - Maintain the backward compatibility
> - Adds 'using_phy' for cheching whether phy framework is used or not
> - Adds 'DEPRECATED' message for old dt-binding way
> 
>  drivers/pci/host/pci-exynos.c | 54 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index 758906b..f6a8b6e 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -21,6 +21,7 @@
>  #include <linux/of_gpio.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> +#include <linux/phy/phy.h>
>  #include <linux/resource.h>
>  #include <linux/signal.h>
>  #include <linux/types.h>
> @@ -110,6 +111,10 @@ struct exynos_pcie {
>  	struct exynos_pcie_clk_res	*clk_res;
>  	const struct exynos_pcie_ops	*ops;
>  	int				reset_gpio;
> +
> +	/* For Generic PHY Framework */
> +	bool				using_phy;
> +	struct phy			*phy;
>  };
>  
>  struct exynos_pcie_ops {
> @@ -126,6 +131,10 @@ static int exynos5440_pcie_get_mem_resources(struct platform_device *pdev,
>  	struct resource *res;
>  	struct device *dev = ep->pp.dev;
>  
> +	/* If using the PHY framework, doesn't need to get other resource */
> +	if (ep->using_phy)
> +		return 0;
> +
>  	ep->mem_res = devm_kzalloc(dev, sizeof(*ep->mem_res), GFP_KERNEL);
>  	if (!ep->mem_res)
>  		return -ENOMEM;
> @@ -396,10 +405,28 @@ static int exynos_pcie_establish_link(struct exynos_pcie *ep)
>  	}
>  
>  	exynos_pcie_assert_core_reset(ep);
> -	exynos_pcie_assert_phy_reset(ep);
> -	exynos_pcie_deassert_phy_reset(ep);
> -	exynos_pcie_power_on_phy(ep);
> -	exynos_pcie_init_phy(ep);
> +
> +	if (ep->using_phy) {
> +		phy_reset(ep->phy);
> +
> +		exynos_pcie_writel(ep->mem_res->elbi_base, 1,
> +				PCIE_PWR_RESET);
> +
> +		phy_power_on(ep->phy);
> +		phy_init(ep->phy);
> +	} else {
> +		exynos_pcie_assert_phy_reset(ep);
> +		exynos_pcie_deassert_phy_reset(ep);
> +		exynos_pcie_power_on_phy(ep);
> +		exynos_pcie_init_phy(ep);
> +
> +		/* pulse for common reset */
> +		exynos_pcie_writel(ep->mem_res->block_base, 1,
> +					PCIE_PHY_COMMON_RESET);
> +		udelay(500);
> +		exynos_pcie_writel(ep->mem_res->block_base, 0,
> +					PCIE_PHY_COMMON_RESET);
> +	}
>  
>  	/* pulse for common reset */
>  	exynos_pcie_writel(ep->mem_res->block_base, 1, PCIE_PHY_COMMON_RESET);
> @@ -418,6 +445,11 @@ static int exynos_pcie_establish_link(struct exynos_pcie *ep)
>  	if (!dw_pcie_wait_for_link(pp))
>  		return 0;
>  
> +	if (ep->using_phy) {
> +		phy_power_off(ep->phy);
> +		return -ETIMEDOUT;
> +	}
> +
>  	while (exynos_pcie_readl(ep->mem_res->phy_base,
>  				PCIE_PHY_PLL_LOCKED) == 0) {
>  		val = exynos_pcie_readl(ep->mem_res->block_base,
> @@ -624,6 +656,17 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
>  
>  	ep->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
>  
> +	/* Assume that controller doesn't use the PHY framework */
> +	ep->using_phy = false;
> +
> +	ep->phy = devm_of_phy_get(dev, np, NULL);
> +	if (IS_ERR(ep->phy)) {
> +		if (PTR_ERR(ep->phy) == -EPROBE_DEFER)
> +			return PTR_ERR(ep->phy);
> +		dev_warn(dev, "Use the 'phy' property. Current DT of pci-exynos was deprecated!!\n");
> +	} else
> +		ep->using_phy = true;
> +
>  	if (ep->ops && ep->ops->get_mem_resources) {
>  		ret = ep->ops->get_mem_resources(pdev, ep);
>  		if (ret)
> @@ -647,6 +690,9 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
>  	return 0;
>  
>  fail_probe:
> +	if (ep->using_phy)
> +		phy_exit(ep->phy);
> +
>  	if (ep->ops && ep->ops->deinit_clk_resources)
>  		ep->ops->deinit_clk_resources(ep);
>  	return ret;
> -- 
> 2.10.2
> 
