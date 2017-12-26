Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 26 Dec 2017 15:11:24 -0600
From: Rob Herring <robh@kernel.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org, jingoohan1@gmail.com, kgene@kernel.org,
        lorenzo.pieralisi@arm.com
Subject: Re: [RFC 2/2] pci: dwc: pci-exynos: add the codes to support the
 exynos5433
Message-ID: <20171226211123.feje5l46y62aft7u@rob-hp-laptop>
References: <20171221121408.22636-1-jh80.chung@samsung.com>
 <CGME20171221121409epcas1p1a12d0f3b0b5d5e732da865ee78f6bb47@epcas1p1.samsung.com>
 <20171221121408.22636-2-jh80.chung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171221121408.22636-2-jh80.chung@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 21, 2017 at 09:14:07PM +0900, Jaehoon Chung wrote:
> Exynos5433 has the PCIe for WiFi.
> Added the codes relevant to PCIe for supporting the exynos5433.
> Also changed the binding documentation name to
> 'samsung,exynos-pcie.txt'.
> (It's not only exynos5440 anymore.)
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  ...exynos5440-pcie.txt => samsung,exynos-pcie.txt} |   2 +-
>  drivers/pci/dwc/pci-exynos.c                       | 183 ++++++++++++++++-----
>  2 files changed, 144 insertions(+), 41 deletions(-)
>  rename Documentation/devicetree/bindings/pci/{samsung,exynos5440-pcie.txt => samsung,exynos-pcie.txt} (97%)
> 
> diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.txt
> similarity index 97%
> rename from Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
> rename to Documentation/devicetree/bindings/pci/samsung,exynos-pcie.txt
> index 34a11bfbfb60..958dcc150505 100644
> --- a/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.txt
> @@ -4,7 +4,7 @@ This PCIe host controller is based on the Synopsys DesignWare PCIe IP
>  and thus inherits all the common properties defined in designware-pcie.txt.
>  
>  Required properties:
> -- compatible: "samsung,exynos5440-pcie"
> +- compatible: "samsung,exynos5440-pcie" or "samsung,exynos5433-pcie"

Quite a lot of driver changes for just a new compatible.

>  - reg: base addresses and lengths of the PCIe controller,

For example, you're adding the DBI registers which is not documented 
here. 

Perhaps it is time to remove the old phy support before adding a new 
platform.

>  	the PHY controller, additional register for the PHY controller.
>  	(Registers for the PHY controller are DEPRECATED.
> diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
> index 5596fdedbb94..8dee2e90347e 100644
> --- a/drivers/pci/dwc/pci-exynos.c
> +++ b/drivers/pci/dwc/pci-exynos.c
> @@ -40,6 +40,8 @@
>  #define PCIE_IRQ_SPECIAL		0x008
>  #define PCIE_IRQ_EN_PULSE		0x00c
>  #define PCIE_IRQ_EN_LEVEL		0x010
> +#define PCIE_SW_WAKE			0x018
> +#define PCIE_BUS_EN			BIT(1)
>  #define IRQ_MSI_ENABLE			BIT(2)
>  #define PCIE_IRQ_EN_SPECIAL		0x014
>  #define PCIE_PWR_RESET			0x018
> @@ -49,7 +51,8 @@
>  #define PCIE_NONSTICKY_RESET		0x024
>  #define PCIE_APP_INIT_RESET		0x028
>  #define PCIE_APP_LTSSM_ENABLE		0x02c
> -#define PCIE_ELBI_RDLH_LINKUP		0x064
> +#define PCIE_ELBI_RDLH_LINKUP		0x074
> +#define PCIE_ELBI_XMLH_LINKUP		BIT(4)
>  #define PCIE_ELBI_LTSSM_ENABLE		0x1
>  #define PCIE_ELBI_SLV_AWMISC		0x11c
>  #define PCIE_ELBI_SLV_ARMISC		0x120
> @@ -94,6 +97,10 @@
>  #define PCIE_PHY_TRSV3_PD_TSV		BIT(7)
>  #define PCIE_PHY_TRSV3_LVCC		0x31c
>  
> +/* DBI register */
> +#define PCIE_MISC_CONTROL_1_OFF		0x8BC
> +#define DBI_RO_WR_EN			BIT(0)
> +
>  struct exynos_pcie_mem_res {
>  	void __iomem *elbi_base;   /* DT 0th resource: PCIe CTRL */
>  	void __iomem *phy_base;    /* DT 1st resource: PHY CTRL */
> @@ -221,6 +228,96 @@ static const struct exynos_pcie_ops exynos5440_pcie_ops = {
>  	.deinit_clk_resources	= exynos5440_pcie_deinit_clk_resources,
>  };
>  
> +static int exynos5433_pcie_get_mem_resources(struct platform_device *pdev,
> +					     struct exynos_pcie *ep)
> +{
> +	struct dw_pcie *pci = ep->pci;
> +	struct device *dev = pci->dev;
> +	struct resource *res;
> +
> +	ep->mem_res = devm_kzalloc(dev, sizeof(*ep->mem_res), GFP_KERNEL);
> +	if (!ep->mem_res)
> +		return -ENOMEM;
> +
> +	/* External Local Bus interface(ELBI) Register */

These are standard DW registers IIRC. So the DW core should handle this.

> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
> +	ep->mem_res->elbi_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(ep->mem_res->elbi_base))
> +		return PTR_ERR(ep->mem_res->elbi_base);
> +
> +	/* Data Bus Interface(DBI) Register */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +	pci->dbi_base = devm_ioremap_resource(&pdev->dev, res);

This is handled by the DW plat driver. Perhaps the DW core should handle 
it too. 

Does the 5440 really not have DBI registers or you just happen to not 
need to access them?

> +	if (IS_ERR(pci->dbi_base))
> +		return PTR_ERR(pci->dbi_base);
> +
> +	return 0;
> +}
> +
> +static int exynos5433_pcie_get_clk_resources(struct exynos_pcie *ep)
> +{
> +	struct dw_pcie *pci = ep->pci;
> +	struct device *dev = pci->dev;
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

Can't you reuse exynos5440_pcie_get_clk_resources? They appear to be the 
same.

> +
> +static void exynos5433_pcie_deinit_clk_resources(struct exynos_pcie *ep)
> +{
> +	clk_disable_unprepare(ep->clk_res->bus_clk);
> +	clk_disable_unprepare(ep->clk_res->clk);
> +}
> +
> +
> +static int exynos5433_pcie_init_clk_resources(struct exynos_pcie *ep)
> +{
> +	struct dw_pcie *pci = ep->pci;
> +	struct device *dev = pci->dev;
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

Ditto.

Rob
