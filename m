Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 10 Feb 2017 16:55:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [PATCH v3] PCI: exynos: refactor exynos pcie driver
Message-ID: <20170210225558.GV29169@bhelgaas-glaptop.roam.corp.google.com>
References: <CGME20170201044024epcas5p372ee4f1632da87b351acfa0b57926a1c@epcas5p3.samsung.com>
 <1485924186-8695-1-git-send-email-pankaj.dubey@samsung.com>
MIME-Version: 1.0
In-Reply-To: <1485924186-8695-1-git-send-email-pankaj.dubey@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
 Niyas Ahmed S T <niyas.ahmed@samsung.com>, linux-kernel@vger.kernel.org,
 krzk@kernel.org, jh80.chung@samsung.com, kgene@kernel.org,
 alim.akhtar@samsung.com, jingoohan1@gmail.com, bhelgaas@google.com,
 sanath@samsung.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 01, 2017 at 10:13:06AM +0530, Pankaj Dubey wrote:
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
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Jingoo, any thoughts on this?

> ---
> This patch set is prepared on top of Krzysztof's for-next and
> PCIe driver cleanup patch-v3 [1] by Jaehoon Chung.
> 
> [1]: https://lkml.org/lkml/2017/1/16/19
> 
> Changes from v2:
>  - Included Acked-by from Krzysztof
>  - Rebased on top of cleanup patch-v3 from Jaehoon Chung and latest
>    for-next of Krzysztof tree.
> 
> Changes from v1:
>  - Addressed review comments from Krzysztof and Jingoo Han.
> 
>  drivers/pci/host/pci-exynos.c | 346 ++++++++++++++++++++++++++----------------
>  1 file changed, 217 insertions(+), 129 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index faee7d3..0f255ab 100644
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
>  static void exynos_pcie_assert_reset(struct exynos_pcie *ep)
> @@ -295,24 +402,26 @@ static int exynos_pcie_establish_link(struct exynos_pcie *ep)
>  	exynos_pcie_init_phy(ep);
>  
>  	/* pulse for common reset */
> -	exynos_pcie_writel(ep->block_base, 1, PCIE_PHY_COMMON_RESET);
> +	exynos_pcie_writel(ep->mem_res->block_base, 1, PCIE_PHY_COMMON_RESET);
>  	udelay(500);
> -	exynos_pcie_writel(ep->block_base, 0, PCIE_PHY_COMMON_RESET);
> +	exynos_pcie_writel(ep->mem_res->block_base, 0, PCIE_PHY_COMMON_RESET);
>  
>  	exynos_pcie_deassert_core_reset(ep);
>  	dw_pcie_setup_rc(pp);
>  	exynos_pcie_assert_reset(ep);
>  
>  	/* assert LTSSM enable */
> -	exynos_pcie_writel(ep->elbi_base, PCIE_ELBI_LTSSM_ENABLE,
> +	exynos_pcie_writel(ep->mem_res->elbi_base, PCIE_ELBI_LTSSM_ENABLE,
>  			  PCIE_APP_LTSSM_ENABLE);
>  
>  	/* check if the link is up or not */
>  	if (!dw_pcie_wait_for_link(pp))
>  		return 0;
>  
> -	while (exynos_pcie_readl(ep->phy_base, PCIE_PHY_PLL_LOCKED) == 0) {
> -		val = exynos_pcie_readl(ep->block_base, PCIE_PHY_PLL_LOCKED);
> +	while (exynos_pcie_readl(ep->mem_res->phy_base,
> +				PCIE_PHY_PLL_LOCKED) == 0) {
> +		val = exynos_pcie_readl(ep->mem_res->block_base,
> +				PCIE_PHY_PLL_LOCKED);
>  		dev_info(dev, "PLL Locked: 0x%x\n", val);
>  	}
>  	exynos_pcie_power_off_phy(ep);
> @@ -323,8 +432,8 @@ static void exynos_pcie_clear_irq_pulse(struct exynos_pcie *ep)
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
> @@ -334,7 +443,7 @@ static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *ep)
>  	/* enable INTX interrupt */
>  	val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
>  		IRQ_INTC_ASSERT | IRQ_INTD_ASSERT;
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_IRQ_EN_PULSE);
> +	exynos_pcie_writel(ep->mem_res->elbi_base, val, PCIE_IRQ_EN_PULSE);
>  }
>  
>  static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
> @@ -361,9 +470,9 @@ static void exynos_pcie_msi_init(struct exynos_pcie *ep)
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
>  static void exynos_pcie_enable_interrupts(struct exynos_pcie *ep)
> @@ -423,7 +532,7 @@ static int exynos_pcie_link_up(struct pcie_port *pp)
>  	struct exynos_pcie *ep = to_exynos_pcie(pp);
>  	u32 val;
>  
> -	val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_RDLH_LINKUP);
> +	val = exynos_pcie_readl(ep->mem_res->elbi_base, PCIE_ELBI_RDLH_LINKUP);
>  	if (val == PCIE_ELBI_LTSSM_ENABLE)
>  		return 1;
>  
> @@ -501,7 +610,6 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
>  	struct exynos_pcie *ep;
>  	struct pcie_port *pp;
>  	struct device_node *np = dev->of_node;
> -	struct resource *res;
>  	int ret;
>  
>  	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> @@ -511,59 +619,36 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
>  	pp = &ep->pp;
>  	pp->dev = dev;
>  
> -	ep->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
> -
> -	ep->clk = devm_clk_get(dev, "pcie");
> -	if (IS_ERR(ep->clk)) {
> -		dev_err(dev, "Failed to get pcie rc clock\n");
> -		return PTR_ERR(ep->clk);
> -	}
> -	ret = clk_prepare_enable(ep->clk);
> -	if (ret)
> -		return ret;
> -
> -	ep->bus_clk = devm_clk_get(dev, "pcie_bus");
> -	if (IS_ERR(ep->bus_clk)) {
> -		dev_err(dev, "Failed to get pcie bus clock\n");
> -		ret = PTR_ERR(ep->bus_clk);
> -		goto fail_clk;
> -	}
> -	ret = clk_prepare_enable(ep->bus_clk);
> -	if (ret)
> -		goto fail_clk;
> +	ep->ops = (const struct exynos_pcie_ops *)
> +		of_device_get_match_data(dev);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	ep->elbi_base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(ep->elbi_base)) {
> -		ret = PTR_ERR(ep->elbi_base);
> -		goto fail_bus_clk;
> -	}
> +	ep->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	ep->phy_base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(ep->phy_base)) {
> -		ret = PTR_ERR(ep->phy_base);
> -		goto fail_bus_clk;
> +	if (ep->ops && ep->ops->get_mem_resources) {
> +		ret = ep->ops->get_mem_resources(pdev, ep);
> +		if (ret)
> +			return ret;
>  	}
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> -	ep->block_base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(ep->block_base)) {
> -		ret = PTR_ERR(ep->block_base);
> -		goto fail_bus_clk;
> +	if (ep->ops && ep->ops->get_clk_resources) {
> +		ret = ep->ops->get_clk_resources(ep);
> +		if (ret)
> +			return ret;
> +		ret = ep->ops->init_clk_resources(ep);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	ret = exynos_add_pcie_port(ep, pdev);
>  	if (ret < 0)
> -		goto fail_bus_clk;
> +		goto fail_probe;
>  
>  	platform_set_drvdata(pdev, ep);
>  	return 0;
>  
> -fail_bus_clk:
> -	clk_disable_unprepare(ep->bus_clk);
> -fail_clk:
> -	clk_disable_unprepare(ep->clk);
> +fail_probe:
> +	if (ep->ops && ep->ops->deinit_clk_resources)
> +		ep->ops->deinit_clk_resources(ep);
>  	return ret;
>  }
>  
> @@ -571,14 +656,17 @@ static int __exit exynos_pcie_remove(struct platform_device *pdev)
>  {
>  	struct exynos_pcie *ep = platform_get_drvdata(pdev);
>  
> -	clk_disable_unprepare(ep->bus_clk);
> -	clk_disable_unprepare(ep->clk);
> +	if (ep->ops && ep->ops->deinit_clk_resources)
> +		ep->ops->deinit_clk_resources(ep);
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
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
