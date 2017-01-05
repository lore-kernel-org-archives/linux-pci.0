Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2] PCI: exynos: refactor exynos pcie driver
To: Pankaj Dubey <pankaj.dubey@samsung.com>, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-id: <339cc068-567e-09b0-3578-08fd7a5df109@samsung.com>
Date: Thu, 05 Jan 2017 13:17:52 +0900
MIME-version: 1.0
In-reply-to: <1483588418-2551-1-git-send-email-pankaj.dubey@samsung.com>
References: <CGME20170105035104epcas1p2de6c52e577dd78a4f3539fb32d1f0dfe@epcas1p2.samsung.com>
 <1483588418-2551-1-git-send-email-pankaj.dubey@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: CPGS <cpgs@samsung.com>, jingoohan1@gmail.com,
 Niyas Ahmed S T <niyas.ahmed@samsung.com>, krzk@kernel.org, kgene@kernel.org,
 alim.akhtar@samsung.com, bhelgaas@google.com, sanath@samsung.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 01/05/2017 12:53 PM, Pankaj Dubey wrote:
> From: Niyas Ahmed S T <niyas.ahmed@samsung.com>
> 
> Currently Exynos PCIe driver is only supported for Exynos5440 SoC.
> This patch does refactoring of Exynos PCIe driver to extend support
> for other Exynos SoC.
> 
> Following are the main changes done via this patch:
> 
> 1) It adds separate structs for memory, clock resources.
> 
> Reason behind this change is, moving ahead various Exynos SoC will
> have different hardware resources such as iomem, clocks, regmap handles
> etc. for PCIe controller, so keeping these resources in separate struct
> will help us in intiailizing them via per SoC ops, and will avoid too
> many of_machine_is_compatible in code, and help us simplifying
> exynos_pcie struct.
> 
> 2) It add exynos_pcie_ops struct which will allow us to support the
> differences in resources in different Exynos SoC.
> 
> No functional change intended.
> 
> Signed-off-by: Niyas Ahmed S T <niyas.ahmed@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
> This patch set is prepared on top of Krzysztof's for-next and
> PCIe driver cleanup patch [1] by Jaehoon Chung.
> 
> [1]: https://lkml.org/lkml/2016/12/19/44
> 
> Changes from v1:
>  - Addressed review comments from Krzysztof and Jingoo Han.
> 
>  drivers/pci/host/pci-exynos.c | 348 ++++++++++++++++++++++++++----------------
>  1 file changed, 219 insertions(+), 129 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index 33562cf..d91751b 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -17,6 +17,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/of_device.h>
>  #include <linux/of_gpio.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> @@ -28,16 +29,6 @@
>  
>  #define to_exynos_pcie(x)	container_of(x, struct exynos_pcie, pp)
>  
> -struct exynos_pcie {
> -	struct pcie_port	pp;
> -	void __iomem		*elbi_base;	/* DT 0th resource */
> -	void __iomem		*phy_base;	/* DT 1st resource */
> -	void __iomem		*block_base;	/* DT 2nd resource */
> -	int			reset_gpio;
> -	struct clk		*clk;
> -	struct clk		*bus_clk;
> -};
> -
>  /* PCIe ELBI registers */
>  #define PCIE_IRQ_PULSE			0x000
>  #define IRQ_INTA_ASSERT			BIT(0)
> @@ -102,6 +93,122 @@ struct exynos_pcie {
>  #define PCIE_PHY_TRSV3_PD_TSV		BIT(7)
>  #define PCIE_PHY_TRSV3_LVCC		0x31c
>  
> +struct exynos_pcie_mem_res {
> +	void __iomem *elbi_base; /* DT 0th resource: PCIE CTRL */
> +	void __iomem *phy_base; /* DT 1st resource: PHY CTRL */
> +	void __iomem *block_base; /* DT 2nd resource: PHY ADDITIONAL CTRL */
> +};
> +
> +struct exynos_pcie_clk_res {
> +	struct clk *clk;
> +	struct clk *bus_clk;
> +};
> +
> +struct exynos_pcie {
> +	struct pcie_port		pp;
> +	struct exynos_pcie_mem_res	*mem_res;
> +	struct exynos_pcie_clk_res	*clk_res;
> +	const struct exynos_pcie_ops	*ops;
> +	int				reset_gpio;
> +};
> +
> +struct exynos_pcie_ops {
> +	int (*get_mem_resources)(struct platform_device *pdev,
> +			struct exynos_pcie *ep);
> +	int (*get_clk_resources)(struct exynos_pcie *ep);
> +	int (*init_clk_resources)(struct exynos_pcie *ep);
> +	void (*deinit_clk_resources)(struct exynos_pcie *ep);
> +};
> +
> +static int exynos5440_pcie_get_mem_resources(struct platform_device *pdev,
> +						struct exynos_pcie *ep)
> +{
> +	struct resource *res;
> +	struct device *dev = ep->pp.dev;
> +
> +	ep->mem_res = devm_kzalloc(dev, sizeof(*ep->mem_res), GFP_KERNEL);
> +	if (!ep->mem_res)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	ep->mem_res->elbi_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(ep->mem_res->elbi_base))
> +		return PTR_ERR(ep->mem_res->elbi_base);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	ep->mem_res->phy_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(ep->mem_res->phy_base))
> +		return PTR_ERR(ep->mem_res->phy_base);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +	ep->mem_res->block_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(ep->mem_res->block_base))
> +		return PTR_ERR(ep->mem_res->block_base);
> +
> +	return 0;
> +}
> +
> +static int exynos5440_pcie_get_clk_resources(struct exynos_pcie *ep)
> +{
> +	struct device *dev = ep->pp.dev;
> +
> +	ep->clk_res = devm_kzalloc(dev, sizeof(*ep->clk_res), GFP_KERNEL);
> +	if (!ep->clk_res)
> +		return -ENOMEM;
> +
> +	ep->clk_res->clk = devm_clk_get(dev, "pcie");
> +	if (IS_ERR(ep->clk_res->clk)) {
> +		dev_err(dev, "Failed to get pcie rc clock\n");
> +		return PTR_ERR(ep->clk_res->clk);
> +	}
> +
> +	ep->clk_res->bus_clk = devm_clk_get(dev, "pcie_bus");
> +	if (IS_ERR(ep->clk_res->bus_clk)) {
> +		dev_err(dev, "Failed to get pcie bus clock\n");
> +		return PTR_ERR(ep->clk_res->bus_clk);
> +	}
> +
> +	return 0;
> +}
> +
> +static int exynos5440_pcie_init_clk_resources(struct exynos_pcie *ep)
> +{
> +	struct device *dev = ep->pp.dev;
> +	int ret;
> +
> +	ret = clk_prepare_enable(ep->clk_res->clk);
> +	if (ret) {
> +		dev_err(dev, "cannot enable pcie rc clock");
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(ep->clk_res->bus_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot enable pcie bus clock");
> +		goto err_bus_clk;
> +	}
> +
> +	return 0;
> +
> +err_bus_clk:
> +	clk_disable_unprepare(ep->clk_res->clk);
> +
> +	return ret;
> +}
> +
> +static void exynos5440_pcie_deinit_clk_resources(struct exynos_pcie *ep)
> +{
> +	clk_disable_unprepare(ep->clk_res->bus_clk);
> +	clk_disable_unprepare(ep->clk_res->clk);
> +}
> +
> +static const struct exynos_pcie_ops exynos5440_pcie_ops = {
> +	.get_mem_resources	= exynos5440_pcie_get_mem_resources,
> +	.get_clk_resources	= exynos5440_pcie_get_clk_resources,
> +	.init_clk_resources	= exynos5440_pcie_init_clk_resources,
> +	.deinit_clk_resources	= exynos5440_pcie_deinit_clk_resources,
> +};
> +
>  static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
>  {
>  	writel(val, base + reg);
> @@ -116,155 +223,155 @@ static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *ep, bool on)
>  {
>  	u32 val;
>  
> -	val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_AWMISC);
> +	val = exynos_pcie_readl(ep->mem_res->elbi_base, PCIE_ELBI_SLV_AWMISC);
>  	if (on)
>  		val |= PCIE_ELBI_SLV_DBI_ENABLE;
>  	else
>  		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_AWMISC);
> +	exynos_pcie_writel(ep->mem_res->elbi_base, val, PCIE_ELBI_SLV_AWMISC);
>  }
>  
>  static void exynos_pcie_sideband_dbi_r_mode(struct exynos_pcie *ep, bool on)
>  {
>  	u32 val;
>  
> -	val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_ARMISC);
> +	val = exynos_pcie_readl(ep->mem_res->elbi_base, PCIE_ELBI_SLV_ARMISC);
>  	if (on)
>  		val |= PCIE_ELBI_SLV_DBI_ENABLE;
>  	else
>  		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_ARMISC);
> +	exynos_pcie_writel(ep->mem_res->elbi_base, val, PCIE_ELBI_SLV_ARMISC);
>  }
>  
>  static void exynos_pcie_assert_core_reset(struct exynos_pcie *ep)
>  {
>  	u32 val;
>  
> -	val = exynos_pcie_readl(ep->elbi_base, PCIE_CORE_RESET);
> +	val = exynos_pcie_readl(ep->mem_res->elbi_base, PCIE_CORE_RESET);
>  	val &= ~PCIE_CORE_RESET_ENABLE;
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_CORE_RESET);
> -	exynos_pcie_writel(ep->elbi_base, 0, PCIE_PWR_RESET);
> -	exynos_pcie_writel(ep->elbi_base, 0, PCIE_STICKY_RESET);
> -	exynos_pcie_writel(ep->elbi_base, 0, PCIE_NONSTICKY_RESET);
> +	exynos_pcie_writel(ep->mem_res->elbi_base, val, PCIE_CORE_RESET);
> +	exynos_pcie_writel(ep->mem_res->elbi_base, 0, PCIE_PWR_RESET);
> +	exynos_pcie_writel(ep->mem_res->elbi_base, 0, PCIE_STICKY_RESET);
> +	exynos_pcie_writel(ep->mem_res->elbi_base, 0, PCIE_NONSTICKY_RESET);
>  }
>  
>  static void exynos_pcie_deassert_core_reset(struct exynos_pcie *ep)
>  {
>  	u32 val;
>  
> -	val = exynos_pcie_readl(ep->elbi_base, PCIE_CORE_RESET);
> +	val = exynos_pcie_readl(ep->mem_res->elbi_base, PCIE_CORE_RESET);
>  	val |= PCIE_CORE_RESET_ENABLE;
>  
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_CORE_RESET);
> -	exynos_pcie_writel(ep->elbi_base, 1, PCIE_STICKY_RESET);
> -	exynos_pcie_writel(ep->elbi_base, 1, PCIE_NONSTICKY_RESET);
> -	exynos_pcie_writel(ep->elbi_base, 1, PCIE_APP_INIT_RESET);
> -	exynos_pcie_writel(ep->elbi_base, 0, PCIE_APP_INIT_RESET);
> -	exynos_pcie_writel(ep->block_base, 1, PCIE_PHY_MAC_RESET);
> +	exynos_pcie_writel(ep->mem_res->elbi_base, val, PCIE_CORE_RESET);
> +	exynos_pcie_writel(ep->mem_res->elbi_base, 1, PCIE_STICKY_RESET);
> +	exynos_pcie_writel(ep->mem_res->elbi_base, 1, PCIE_NONSTICKY_RESET);
> +	exynos_pcie_writel(ep->mem_res->elbi_base, 1, PCIE_APP_INIT_RESET);
> +	exynos_pcie_writel(ep->mem_res->elbi_base, 0, PCIE_APP_INIT_RESET);
> +	exynos_pcie_writel(ep->mem_res->block_base, 1, PCIE_PHY_MAC_RESET);
>  }
>  
>  static void exynos_pcie_assert_phy_reset(struct exynos_pcie *ep)
>  {
> -	exynos_pcie_writel(ep->block_base, 0, PCIE_PHY_MAC_RESET);
> -	exynos_pcie_writel(ep->block_base, 1, PCIE_PHY_GLOBAL_RESET);
> +	exynos_pcie_writel(ep->mem_res->block_base, 0, PCIE_PHY_MAC_RESET);
> +	exynos_pcie_writel(ep->mem_res->block_base, 1, PCIE_PHY_GLOBAL_RESET);
>  }
>  
>  static void exynos_pcie_deassert_phy_reset(struct exynos_pcie *ep)
>  {
> -	exynos_pcie_writel(ep->block_base, 0, PCIE_PHY_GLOBAL_RESET);
> -	exynos_pcie_writel(ep->elbi_base, 1, PCIE_PWR_RESET);
> -	exynos_pcie_writel(ep->block_base, 0, PCIE_PHY_COMMON_RESET);
> -	exynos_pcie_writel(ep->block_base, 0, PCIE_PHY_CMN_REG);
> -	exynos_pcie_writel(ep->block_base, 0, PCIE_PHY_TRSVREG_RESET);
> -	exynos_pcie_writel(ep->block_base, 0, PCIE_PHY_TRSV_RESET);
> +	exynos_pcie_writel(ep->mem_res->block_base, 0, PCIE_PHY_GLOBAL_RESET);
> +	exynos_pcie_writel(ep->mem_res->elbi_base, 1, PCIE_PWR_RESET);
> +	exynos_pcie_writel(ep->mem_res->block_base, 0, PCIE_PHY_COMMON_RESET);
> +	exynos_pcie_writel(ep->mem_res->block_base, 0, PCIE_PHY_CMN_REG);
> +	exynos_pcie_writel(ep->mem_res->block_base, 0, PCIE_PHY_TRSVREG_RESET);
> +	exynos_pcie_writel(ep->mem_res->block_base, 0, PCIE_PHY_TRSV_RESET);
>  }
>  
>  static void exynos_pcie_power_on_phy(struct exynos_pcie *ep)
>  {
>  	u32 val;
>  
> -	val = exynos_pcie_readl(ep->phy_base, PCIE_PHY_COMMON_POWER);
> +	val = exynos_pcie_readl(ep->mem_res->phy_base, PCIE_PHY_COMMON_POWER);
>  	val &= ~PCIE_PHY_COMMON_PD_CMN;
> -	exynos_pcie_writel(ep->phy_base, val, PCIE_PHY_COMMON_POWER);
> +	exynos_pcie_writel(ep->mem_res->phy_base, val, PCIE_PHY_COMMON_POWER);
>  
> -	val = exynos_pcie_readl(ep->phy_base, PCIE_PHY_TRSV0_POWER);
> +	val = exynos_pcie_readl(ep->mem_res->phy_base, PCIE_PHY_TRSV0_POWER);
>  	val &= ~PCIE_PHY_TRSV0_PD_TSV;
> -	exynos_pcie_writel(ep->phy_base, val, PCIE_PHY_TRSV0_POWER);
> +	exynos_pcie_writel(ep->mem_res->phy_base, val, PCIE_PHY_TRSV0_POWER);
>  
> -	val = exynos_pcie_readl(ep->phy_base, PCIE_PHY_TRSV1_POWER);
> +	val = exynos_pcie_readl(ep->mem_res->phy_base, PCIE_PHY_TRSV1_POWER);
>  	val &= ~PCIE_PHY_TRSV1_PD_TSV;
> -	exynos_pcie_writel(ep->phy_base, val, PCIE_PHY_TRSV1_POWER);
> +	exynos_pcie_writel(ep->mem_res->phy_base, val, PCIE_PHY_TRSV1_POWER);
>  
> -	val = exynos_pcie_readl(ep->phy_base, PCIE_PHY_TRSV2_POWER);
> +	val = exynos_pcie_readl(ep->mem_res->phy_base, PCIE_PHY_TRSV2_POWER);
>  	val &= ~PCIE_PHY_TRSV2_PD_TSV;
> -	exynos_pcie_writel(ep->phy_base, val, PCIE_PHY_TRSV2_POWER);
> +	exynos_pcie_writel(ep->mem_res->phy_base, val, PCIE_PHY_TRSV2_POWER);
>  
> -	val = exynos_pcie_readl(ep->phy_base, PCIE_PHY_TRSV3_POWER);
> +	val = exynos_pcie_readl(ep->mem_res->phy_base, PCIE_PHY_TRSV3_POWER);
>  	val &= ~PCIE_PHY_TRSV3_PD_TSV;
> -	exynos_pcie_writel(ep->phy_base, val, PCIE_PHY_TRSV3_POWER);
> +	exynos_pcie_writel(ep->mem_res->phy_base, val, PCIE_PHY_TRSV3_POWER);
>  }
>  
>  static void exynos_pcie_power_off_phy(struct exynos_pcie *ep)
>  {
>  	u32 val;
>  
> -	val = exynos_pcie_readl(ep->phy_base, PCIE_PHY_COMMON_POWER);
> +	val = exynos_pcie_readl(ep->mem_res->phy_base, PCIE_PHY_COMMON_POWER);
>  	val |= PCIE_PHY_COMMON_PD_CMN;
> -	exynos_pcie_writel(ep->phy_base, val, PCIE_PHY_COMMON_POWER);
> +	exynos_pcie_writel(ep->mem_res->phy_base, val, PCIE_PHY_COMMON_POWER);
>  
> -	val = exynos_pcie_readl(ep->phy_base, PCIE_PHY_TRSV0_POWER);
> +	val = exynos_pcie_readl(ep->mem_res->phy_base, PCIE_PHY_TRSV0_POWER);
>  	val |= PCIE_PHY_TRSV0_PD_TSV;
> -	exynos_pcie_writel(ep->phy_base, val, PCIE_PHY_TRSV0_POWER);
> +	exynos_pcie_writel(ep->mem_res->phy_base, val, PCIE_PHY_TRSV0_POWER);
>  
> -	val = exynos_pcie_readl(ep->phy_base, PCIE_PHY_TRSV1_POWER);
> +	val = exynos_pcie_readl(ep->mem_res->phy_base, PCIE_PHY_TRSV1_POWER);
>  	val |= PCIE_PHY_TRSV1_PD_TSV;
> -	exynos_pcie_writel(ep->phy_base, val, PCIE_PHY_TRSV1_POWER);
> +	exynos_pcie_writel(ep->mem_res->phy_base, val, PCIE_PHY_TRSV1_POWER);
>  
> -	val = exynos_pcie_readl(ep->phy_base, PCIE_PHY_TRSV2_POWER);
> +	val = exynos_pcie_readl(ep->mem_res->phy_base, PCIE_PHY_TRSV2_POWER);
>  	val |= PCIE_PHY_TRSV2_PD_TSV;
> -	exynos_pcie_writel(ep->phy_base, val, PCIE_PHY_TRSV2_POWER);
> +	exynos_pcie_writel(ep->mem_res->phy_base, val, PCIE_PHY_TRSV2_POWER);
>  
> -	val = exynos_pcie_readl(ep->phy_base, PCIE_PHY_TRSV3_POWER);
> +	val = exynos_pcie_readl(ep->mem_res->phy_base, PCIE_PHY_TRSV3_POWER);
>  	val |= PCIE_PHY_TRSV3_PD_TSV;
> -	exynos_pcie_writel(ep->phy_base, val, PCIE_PHY_TRSV3_POWER);
> +	exynos_pcie_writel(ep->mem_res->phy_base, val, PCIE_PHY_TRSV3_POWER);
>  }
>  
>  static void exynos_pcie_init_phy(struct exynos_pcie *ep)
>  {
>  	/* DCC feedback control off */
> -	exynos_pcie_writel(ep->phy_base, 0x29, PCIE_PHY_DCC_FEEDBACK);
> +	exynos_pcie_writel(ep->mem_res->phy_base, 0x29, PCIE_PHY_DCC_FEEDBACK);
>  
>  	/* set TX/RX impedance */
> -	exynos_pcie_writel(ep->phy_base, 0xd5, PCIE_PHY_IMPEDANCE);
> +	exynos_pcie_writel(ep->mem_res->phy_base, 0xd5, PCIE_PHY_IMPEDANCE);
>  
>  	/* set 50Mhz PHY clock */
> -	exynos_pcie_writel(ep->phy_base, 0x14, PCIE_PHY_PLL_DIV_0);
> -	exynos_pcie_writel(ep->phy_base, 0x12, PCIE_PHY_PLL_DIV_1);
> +	exynos_pcie_writel(ep->mem_res->phy_base, 0x14, PCIE_PHY_PLL_DIV_0);
> +	exynos_pcie_writel(ep->mem_res->phy_base, 0x12, PCIE_PHY_PLL_DIV_1);
>  
>  	/* set TX Differential output for lane 0 */
> -	exynos_pcie_writel(ep->phy_base, 0x7f, PCIE_PHY_TRSV0_DRV_LVL);
> +	exynos_pcie_writel(ep->mem_res->phy_base, 0x7f, PCIE_PHY_TRSV0_DRV_LVL);
>  
>  	/* set TX Pre-emphasis Level Control for lane 0 to minimum */
> -	exynos_pcie_writel(ep->phy_base, 0x0, PCIE_PHY_TRSV0_EMP_LVL);
> +	exynos_pcie_writel(ep->mem_res->phy_base, 0x0, PCIE_PHY_TRSV0_EMP_LVL);
>  
>  	/* set RX clock and data recovery bandwidth */
> -	exynos_pcie_writel(ep->phy_base, 0xe7, PCIE_PHY_PLL_BIAS);
> -	exynos_pcie_writel(ep->phy_base, 0x82, PCIE_PHY_TRSV0_RXCDR);
> -	exynos_pcie_writel(ep->phy_base, 0x82, PCIE_PHY_TRSV1_RXCDR);
> -	exynos_pcie_writel(ep->phy_base, 0x82, PCIE_PHY_TRSV2_RXCDR);
> -	exynos_pcie_writel(ep->phy_base, 0x82, PCIE_PHY_TRSV3_RXCDR);
> +	exynos_pcie_writel(ep->mem_res->phy_base, 0xe7, PCIE_PHY_PLL_BIAS);
> +	exynos_pcie_writel(ep->mem_res->phy_base, 0x82, PCIE_PHY_TRSV0_RXCDR);
> +	exynos_pcie_writel(ep->mem_res->phy_base, 0x82, PCIE_PHY_TRSV1_RXCDR);
> +	exynos_pcie_writel(ep->mem_res->phy_base, 0x82, PCIE_PHY_TRSV2_RXCDR);
> +	exynos_pcie_writel(ep->mem_res->phy_base, 0x82, PCIE_PHY_TRSV3_RXCDR);
>  
>  	/* change TX Pre-emphasis Level Control for lanes */
> -	exynos_pcie_writel(ep->phy_base, 0x39, PCIE_PHY_TRSV0_EMP_LVL);
> -	exynos_pcie_writel(ep->phy_base, 0x39, PCIE_PHY_TRSV1_EMP_LVL);
> -	exynos_pcie_writel(ep->phy_base, 0x39, PCIE_PHY_TRSV2_EMP_LVL);
> -	exynos_pcie_writel(ep->phy_base, 0x39, PCIE_PHY_TRSV3_EMP_LVL);
> +	exynos_pcie_writel(ep->mem_res->phy_base, 0x39, PCIE_PHY_TRSV0_EMP_LVL);
> +	exynos_pcie_writel(ep->mem_res->phy_base, 0x39, PCIE_PHY_TRSV1_EMP_LVL);
> +	exynos_pcie_writel(ep->mem_res->phy_base, 0x39, PCIE_PHY_TRSV2_EMP_LVL);
> +	exynos_pcie_writel(ep->mem_res->phy_base, 0x39, PCIE_PHY_TRSV3_EMP_LVL);
>  
>  	/* set LVCC */
> -	exynos_pcie_writel(ep->phy_base, 0x20, PCIE_PHY_TRSV0_LVCC);
> -	exynos_pcie_writel(ep->phy_base, 0xa0, PCIE_PHY_TRSV1_LVCC);
> -	exynos_pcie_writel(ep->phy_base, 0xa0, PCIE_PHY_TRSV2_LVCC);
> -	exynos_pcie_writel(ep->phy_base, 0xa0, PCIE_PHY_TRSV3_LVCC);
> +	exynos_pcie_writel(ep->mem_res->phy_base, 0x20, PCIE_PHY_TRSV0_LVCC);
> +	exynos_pcie_writel(ep->mem_res->phy_base, 0xa0, PCIE_PHY_TRSV1_LVCC);
> +	exynos_pcie_writel(ep->mem_res->phy_base, 0xa0, PCIE_PHY_TRSV2_LVCC);
> +	exynos_pcie_writel(ep->mem_res->phy_base, 0xa0, PCIE_PHY_TRSV3_LVCC);
>  }
>  
>  static void exynos_pcie_assert_reset(struct exynos_pcie *exynos_pcie)
> @@ -295,25 +402,27 @@ static int exynos_pcie_establish_link(struct exynos_pcie *exynos_pcie)
>  	exynos_pcie_init_phy(exynos_pcie);
>  
>  	/* pulse for common reset */
> -	exynos_pcie_writel(exynos_pcie->block_base, 1, PCIE_PHY_COMMON_RESET);
> +	exynos_pcie_writel(exynos_pcie->mem_res->block_base, 1,
> +				PCIE_PHY_COMMON_RESET);
>  	udelay(500);
> -	exynos_pcie_writel(exynos_pcie->block_base, 0, PCIE_PHY_COMMON_RESET);
> +	exynos_pcie_writel(exynos_pcie->mem_res->block_base, 0,
> +				PCIE_PHY_COMMON_RESET);
>  
>  	exynos_pcie_deassert_core_reset(exynos_pcie);
>  	dw_pcie_setup_rc(pp);
>  	exynos_pcie_assert_reset(exynos_pcie);
>  
>  	/* assert LTSSM enable */
> -	exynos_pcie_writel(exynos_pcie->elbi_base, PCIE_ELBI_LTSSM_ENABLE,
> -			  PCIE_APP_LTSSM_ENABLE);
> +	exynos_pcie_writel(exynos_pcie->mem_res->elbi_base,
> +			PCIE_ELBI_LTSSM_ENABLE, PCIE_APP_LTSSM_ENABLE);
>  
>  	/* check if the link is up or not */
>  	if (!dw_pcie_wait_for_link(pp))
>  		return 0;
>  
> -	while (exynos_pcie_readl(exynos_pcie->phy_base,
> +	while (exynos_pcie_readl(exynos_pcie->mem_res->phy_base,
>  				PCIE_PHY_PLL_LOCKED) == 0) {
> -		val = exynos_pcie_readl(exynos_pcie->block_base,
> +		val = exynos_pcie_readl(exynos_pcie->mem_res->block_base,
>  				PCIE_PHY_PLL_LOCKED);
>  		dev_info(dev, "PLL Locked: 0x%x\n", val);
>  	}
> @@ -325,8 +434,8 @@ static void exynos_pcie_clear_irq_pulse(struct exynos_pcie *ep)
>  {
>  	u32 val;
>  
> -	val = exynos_pcie_readl(ep->elbi_base, PCIE_IRQ_PULSE);
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_IRQ_PULSE);
> +	val = exynos_pcie_readl(ep->mem_res->elbi_base, PCIE_IRQ_PULSE);
> +	exynos_pcie_writel(ep->mem_res->elbi_base, val, PCIE_IRQ_PULSE);
>  }
>  
>  static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *ep)
> @@ -336,7 +445,7 @@ static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *ep)
>  	/* enable INTX interrupt */
>  	val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
>  		IRQ_INTC_ASSERT | IRQ_INTD_ASSERT;
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_IRQ_EN_PULSE);
> +	exynos_pcie_writel(ep->mem_res->elbi_base, val, PCIE_IRQ_EN_PULSE);
>  }
>  
>  static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
> @@ -363,9 +472,9 @@ static void exynos_pcie_msi_init(struct exynos_pcie *ep)
>  	dw_pcie_msi_init(pp);
>  
>  	/* enable MSI interrupt */
> -	val = exynos_pcie_readl(ep->elbi_base, PCIE_IRQ_EN_LEVEL);
> +	val = exynos_pcie_readl(ep->mem_res->elbi_base, PCIE_IRQ_EN_LEVEL);
>  	val |= IRQ_MSI_ENABLE;
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_IRQ_EN_LEVEL);
> +	exynos_pcie_writel(ep->mem_res->elbi_base, val, PCIE_IRQ_EN_LEVEL);
>  }
>  
>  static void exynos_pcie_enable_interrupts(struct exynos_pcie *exynos_pcie)
> @@ -425,7 +534,8 @@ static int exynos_pcie_link_up(struct pcie_port *pp)
>  	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
>  	u32 val;
>  
> -	val = exynos_pcie_readl(exynos_pcie->elbi_base, PCIE_ELBI_RDLH_LINKUP);
> +	val = exynos_pcie_readl(exynos_pcie->mem_res->elbi_base,
> +					PCIE_ELBI_RDLH_LINKUP);
>  	if (val == PCIE_ELBI_LTSSM_ENABLE)
>  		return 1;
>  
> @@ -503,7 +613,6 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
>  	struct exynos_pcie *exynos_pcie;
>  	struct pcie_port *pp;
>  	struct device_node *np = dev->of_node;
> -	struct resource *res;
>  	int ret;
>  
>  	exynos_pcie = devm_kzalloc(dev, sizeof(*exynos_pcie), GFP_KERNEL);
> @@ -513,59 +622,37 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
>  	pp = &exynos_pcie->pp;
>  	pp->dev = dev;
>  
> -	exynos_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
> -
> -	exynos_pcie->clk = devm_clk_get(dev, "pcie");
> -	if (IS_ERR(exynos_pcie->clk)) {
> -		dev_err(dev, "Failed to get pcie rc clock\n");
> -		return PTR_ERR(exynos_pcie->clk);
> -	}
> -	ret = clk_prepare_enable(exynos_pcie->clk);
> -	if (ret)
> -		return ret;
> +	exynos_pcie->ops = (const struct exynos_pcie_ops *)
> +				of_device_get_match_data(dev);
>  
> -	exynos_pcie->bus_clk = devm_clk_get(dev, "pcie_bus");
> -	if (IS_ERR(exynos_pcie->bus_clk)) {
> -		dev_err(dev, "Failed to get pcie bus clock\n");
> -		ret = PTR_ERR(exynos_pcie->bus_clk);
> -		goto fail_clk;
> -	}
> -	ret = clk_prepare_enable(exynos_pcie->bus_clk);
> -	if (ret)
> -		goto fail_clk;
> +	exynos_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	exynos_pcie->elbi_base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(exynos_pcie->elbi_base)) {
> -		ret = PTR_ERR(exynos_pcie->elbi_base);
> -		goto fail_bus_clk;
> +	if (exynos_pcie->ops && exynos_pcie->ops->get_mem_resources) {
> +		ret = exynos_pcie->ops->get_mem_resources(pdev, exynos_pcie);
> +		if (ret)
> +			return ret;
>  	}
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	exynos_pcie->phy_base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(exynos_pcie->phy_base)) {
> -		ret = PTR_ERR(exynos_pcie->phy_base);
> -		goto fail_bus_clk;
> -	}
> +	if (exynos_pcie->ops && exynos_pcie->ops->get_clk_resources) {
> +		ret = exynos_pcie->ops->get_clk_resources(exynos_pcie);
> +		if (ret)
> +			return ret;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> -	exynos_pcie->block_base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(exynos_pcie->block_base)) {
> -		ret = PTR_ERR(exynos_pcie->block_base);
> -		goto fail_bus_clk;
> +		ret = exynos_pcie->ops->init_clk_resources(exynos_pcie);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	ret = exynos_add_pcie_port(exynos_pcie, pdev);
>  	if (ret < 0)
> -		goto fail_bus_clk;
> +		goto fail_probe;
>  
>  	platform_set_drvdata(pdev, exynos_pcie);
>  	return 0;
>  
> -fail_bus_clk:
> -	clk_disable_unprepare(exynos_pcie->bus_clk);
> -fail_clk:
> -	clk_disable_unprepare(exynos_pcie->clk);
> +fail_probe:
> +	if (exynos_pcie->ops && exynos_pcie->ops->deinit_clk_resources)
> +		exynos_pcie->ops->deinit_clk_resources(exynos_pcie);
>  	return ret;
>  }
>  
> @@ -573,14 +660,17 @@ static int __exit exynos_pcie_remove(struct platform_device *pdev)
>  {
>  	struct exynos_pcie *exynos_pcie = platform_get_drvdata(pdev);
>  
> -	clk_disable_unprepare(exynos_pcie->bus_clk);
> -	clk_disable_unprepare(exynos_pcie->clk);
> +	if (exynos_pcie->ops && exynos_pcie->ops->deinit_clk_resources)
> +		exynos_pcie->ops->deinit_clk_resources(exynos_pcie);
>  
>  	return 0;
>  }
>  
>  static const struct of_device_id exynos_pcie_of_match[] = {
> -	{ .compatible = "samsung,exynos5440-pcie", },
> +	{
> +		.compatible = "samsung,exynos5440-pcie",
> +		.data = &exynos5440_pcie_ops
> +	},
>  	{},
>  };
>  
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
