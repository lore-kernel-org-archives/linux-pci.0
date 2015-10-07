Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47075 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754924AbbJGR5a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 Oct 2015 13:57:30 -0400
Date: Wed, 7 Oct 2015 12:57:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Li Yang <leoli@freescale.com>, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v2] PCI: layerscape: Add PCIe support for LS1043a and
 LS2080a
Message-ID: <20151007175725.GC27633@localhost>
References: <1442481219-28299-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442481219-28299-1-git-send-email-Minghuan.Lian@freescale.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Minghuan,

On Thu, Sep 17, 2015 at 05:13:39PM +0800, Minghuan Lian wrote:
> The patch adds PCIe support for LS1043a and LS2080a.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
> This patch is based on v4.3-rc1 and [PATCH v9 0/6]
> PCI: hisi: Add PCIe host support for HiSilicon SoC Hip05
> patchset from Zhou Wang.
> 
> change log
> v2:
> 1. rename ls2085a to ls2080a
> 2. Add ls_pcie_msi_host_init()
> 
>  drivers/pci/host/Kconfig          |   2 +-
>  drivers/pci/host/pci-layerscape.c | 227 ++++++++++++++++++++++++++------------
>  2 files changed, 157 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index ae873be..38fe8a8 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -105,7 +105,7 @@ config PCI_XGENE_MSI
>  
>  config PCI_LAYERSCAPE
>  	bool "Freescale Layerscape PCIe controller"
> -	depends on OF && ARM
> +	depends on OF && (ARM || ARM64)

It seems like there are a couple things going on here, and I wonder if
you can split them out into separate patches.

1) Making this work on ARM64 as well as on ARM.  This may be of
interest for other DesignWare-based drivers, so if you split this out,
maybe it would be a useful template for converting the other drivers,
too.

2) Adding LS1043a and LS2080a.  Obviously, this is only of interest to
this driver, but maybe it could be separated out into a separate
patch?

>  	select PCIE_DW
>  	select MFD_SYSCON
>  	help
> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
> index b2328ea1..cdb8737 100644
> --- a/drivers/pci/host/pci-layerscape.c
> +++ b/drivers/pci/host/pci-layerscape.c
> @@ -11,7 +11,6 @@
>   */
>  
>  #include <linux/kernel.h>
> -#include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of_pci.h>
> @@ -32,27 +31,68 @@
>  #define LTSSM_STATE_MASK	0x3f
>  #define LTSSM_PCIE_L0		0x11 /* L0 state */
>  
> -/* Symbol Timer Register and Filter Mask Register 1 */
> -#define PCIE_STRFMR1 0x71c
> +/* PEX Internal Configuration Registers */
> +#define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
> +#define PCIE_DBI_RO_WR_EN	0x8bc /* DBI Read-Only Write Enable Register */
> +
> +/* PEX LUT registers */
> +#define PCIE_LUT_DBG		0x7FC /* PEX LUT Debug Register */
> +
> +struct ls_pcie_drvdata {
> +	u32 lut_offset;
> +	u32 ltssm_shift;
> +	struct pcie_host_ops *ops;
> +};
>  
>  struct ls_pcie {
> -	struct list_head node;
> -	struct device *dev;
> -	struct pci_bus *bus;
> -	void __iomem *dbi;
> -	struct regmap *scfg;
>  	struct pcie_port pp;
> +	const struct ls_pcie_drvdata *drvdata;
> +	void __iomem *regs;
> +	void __iomem *lut;
> +	struct regmap *scfg;
>  	int index;
> -	int msi_irq;
>  };
>  
>  #define to_ls_pcie(x)	container_of(x, struct ls_pcie, pp)
>  
> -static int ls_pcie_link_up(struct pcie_port *pp)
> +static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
> +{
> +	u32 header_type;
> +
> +	header_type = ioread32(pcie->regs + (PCI_HEADER_TYPE & ~0x3));
> +	header_type = (header_type >> (8 * (PCI_HEADER_TYPE & 0x3))) & 0x7f;
> +
> +	return header_type == PCI_HEADER_TYPE_BRIDGE;
> +}
> +
> +/* Clean multi-function bit */
> +static void ls_pcie_clean_multifunction(struct ls_pcie *pcie)

This *clears* the multi-function bit.  It's not really clear what
it means to "clean" a bit :)

Why do you read/write 32 bits at a time?  Is there a problem with 8-
or 16-bit accesses?  If 8- or 16-bit accesses don't work, then we have
to worry about the RW1C problem for some registers.

> +{
> +	u32 val;
> +
> +	val = ioread32(pcie->regs + (PCI_HEADER_TYPE & ~0x3));
> +	val &= ~(1 << 23);
> +	iowrite32(val, pcie->regs + (PCI_HEADER_TYPE & ~0x3));
> +}
> +
> +/* Fix class value */
> +static void ls_pcie_fix_class(struct ls_pcie *pcie)
> +{
> +	u32 val;
> +
> +	val = ioread32(pcie->regs + PCI_CLASS_REVISION);
> +	val = (val & 0x0000ffff) | (PCI_CLASS_BRIDGE_PCI << 16);
> +	iowrite32(val, pcie->regs + PCI_CLASS_REVISION);
> +}
> +
> +static int ls1021_pcie_link_up(struct pcie_port *pp)
>  {
>  	u32 state;
>  	struct ls_pcie *pcie = to_ls_pcie(pp);
>  
> +	if (!pcie->scfg)
> +		return 0;
> +
>  	regmap_read(pcie->scfg, SCFG_PEXMSCPORTSR(pcie->index), &state);
>  	state = (state >> LTSSM_STATE_SHIFT) & LTSSM_STATE_MASK;
>  
> @@ -62,110 +102,155 @@ static int ls_pcie_link_up(struct pcie_port *pp)
>  	return 1;
>  }
>  
> -static int ls_pcie_establish_link(struct pcie_port *pp)
> +static void ls1021_pcie_host_init(struct pcie_port *pp)
>  {
> -	unsigned int retries;
> +	struct ls_pcie *pcie = to_ls_pcie(pp);
> +	u32 val, index[2];
>  
> -	for (retries = 0; retries < 200; retries++) {
> -		if (dw_pcie_link_up(pp))
> -			return 0;
> -		usleep_range(100, 1000);
> +	pcie->scfg = syscon_regmap_lookup_by_phandle(pp->dev->of_node,
> +						     "fsl,pcie-scfg");
> +	if (IS_ERR(pcie->scfg)) {
> +		dev_err(pp->dev, "No syscfg phandle specified\n");
> +		pcie->scfg = NULL;
> +		return;
> +	}
> +
> +	if (of_property_read_u32_array(pp->dev->of_node,
> +				       "fsl,pcie-scfg", index, 2)) {
> +		pcie->scfg = NULL;
> +		return;
>  	}
> +	pcie->index = index[1];
>  
> -	dev_err(pp->dev, "phy link never came up\n");
> -	return -EINVAL;
> +	/*
> +	 * LS1021A Workaround for internal TKT228622
> +	 * to fix the INTx hang issue
> +	 */
> +	val = ioread32(pcie->regs + PCIE_STRFMR1);
> +	val &= 0xffff;
> +	iowrite32(val, pcie->regs + PCIE_STRFMR1);
> +}
> +
> +static int ls_pcie_link_up(struct pcie_port *pp)
> +{
> +	struct ls_pcie *pcie = to_ls_pcie(pp);
> +	u32 state;
> +
> +	state = (ioread32(pcie->lut + PCIE_LUT_DBG) >>
> +		 pcie->drvdata->ltssm_shift) &
> +		 LTSSM_STATE_MASK;
> +
> +	if (state < LTSSM_PCIE_L0)
> +		return 0;
> +
> +	return 1;
>  }
>  
>  static void ls_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct ls_pcie *pcie = to_ls_pcie(pp);
> -	u32 val;
>  
> -	dw_pcie_setup_rc(pp);
> -	ls_pcie_establish_link(pp);
> +	iowrite32(1, pcie->regs + PCIE_DBI_RO_WR_EN);
> +	ls_pcie_fix_class(pcie);
> +	ls_pcie_clean_multifunction(pcie);
> +	iowrite32(0, pcie->regs + PCIE_DBI_RO_WR_EN);
> +}
>  
> -	/*
> -	 * LS1021A Workaround for internal TKT228622
> -	 * to fix the INTx hang issue
> -	 */
> -	val = ioread32(pcie->dbi + PCIE_STRFMR1);
> -	val &= 0xffff;
> -	iowrite32(val, pcie->dbi + PCIE_STRFMR1);

> +static int ls_pcie_msi_host_init(struct pcie_port *pp,
> +				 struct msi_controller *chip)
> +{
> +	struct device_node *msi_node;
> +	struct device_node *np = pp->dev->of_node;
> +
> +	msi_node = of_parse_phandle(np, "msi-parent", 0);
> +	if (!msi_node) {
> +		dev_err(pp->dev, "failed to find msi-parent\n");
> +		return -EINVAL;
> +	}

This doesn't actually *do* anything except complain if "msi-parent" is
missing.  I'm not sure that's worth doing: if we need "msi-parent"
somewhere, we should complain there if we don't find it.  If we don't
need it, why complain if it's missing?

> +
> +	return 0;
>  }
>  
> +static struct pcie_host_ops ls1021_pcie_host_ops = {
> +	.link_up = ls1021_pcie_link_up,
> +	.host_init = ls1021_pcie_host_init,
> +	.msi_host_init = ls_pcie_msi_host_init,
> +};
> +
>  static struct pcie_host_ops ls_pcie_host_ops = {
>  	.link_up = ls_pcie_link_up,
>  	.host_init = ls_pcie_host_init,
> +	.msi_host_init = ls_pcie_msi_host_init,
>  };
>  
> -static int ls_add_pcie_port(struct ls_pcie *pcie)
> -{
> -	struct pcie_port *pp;
> -	int ret;
> +static struct ls_pcie_drvdata ls1021_drvdata = {
> +	.ops = &ls1021_pcie_host_ops,
> +};
>  
> -	pp = &pcie->pp;
> -	pp->dev = pcie->dev;
> -	pp->dbi_base = pcie->dbi;
> -	pp->root_bus_nr = -1;
> -	pp->ops = &ls_pcie_host_ops;
> +static struct ls_pcie_drvdata ls1043_drvdata = {
> +	.lut_offset = 0x10000,
> +	.ltssm_shift = 24,
> +	.ops = &ls_pcie_host_ops,
> +};
>  
> -	ret = dw_pcie_host_init(pp);
> -	if (ret) {
> -		dev_err(pp->dev, "failed to initialize host\n");
> -		return ret;
> -	}
> +static struct ls_pcie_drvdata ls2080_drvdata = {
> +	.lut_offset = 0x80000,
> +	.ltssm_shift = 0,
> +	.ops = &ls_pcie_host_ops,
> +};
>  
> -	return 0;
> -}
> +static const struct of_device_id ls_pcie_of_match[] = {
> +	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
> +	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata },
> +	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ls_pcie_of_match);
>  
>  static int __init ls_pcie_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *match;
>  	struct ls_pcie *pcie;
> -	struct resource *dbi_base;
> -	u32 index[2];
> +	struct pcie_port *pp;
> +	struct resource *res;
>  	int ret;
>  
> +	match = of_match_device(ls_pcie_of_match, &pdev->dev);
> +	if (!match)
> +		return -ENODEV;
> +
>  	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
>  	if (!pcie)
>  		return -ENOMEM;
>  
> -	pcie->dev = &pdev->dev;
> -
> -	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
> -	pcie->dbi = devm_ioremap_resource(&pdev->dev, dbi_base);
> -	if (IS_ERR(pcie->dbi)) {
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
> +	pcie->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(pcie->regs)) {
>  		dev_err(&pdev->dev, "missing *regs* space\n");
> -		return PTR_ERR(pcie->dbi);
> +		return PTR_ERR(pcie->regs);
>  	}
>  
> -	pcie->scfg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> -						     "fsl,pcie-scfg");
> -	if (IS_ERR(pcie->scfg)) {
> -		dev_err(&pdev->dev, "No syscfg phandle specified\n");
> -		return PTR_ERR(pcie->scfg);
> -	}
> +	pcie->drvdata = match->data;
> +	pcie->lut = pcie->regs + pcie->drvdata->lut_offset;
> +	pp = &pcie->pp;
> +	pp->dev = &pdev->dev;
> +	pp->dbi_base = pcie->regs;
> +	pp->ops = pcie->drvdata->ops;
>  
> -	ret = of_property_read_u32_array(pdev->dev.of_node,
> -					 "fsl,pcie-scfg", index, 2);
> -	if (ret)
> -		return ret;
> -	pcie->index = index[1];
> +	if (!ls_pcie_is_bridge(pcie))
> +		return -ENODEV;
>  
> -	ret = ls_add_pcie_port(pcie);
> -	if (ret < 0)
> +	ret = dw_pcie_host_init(pp);

We have several DesignWare-based drivers (dra7xx, exynos, imx6, ks,
ls, spear13xx), and I'd like to keep their structure as similar as
possible.  For example, they all have basically this structure:

  X_pcie_probe
    X_add_pcie_port
      dw_pcie_host_init             # pp->ops->host_init callback
        X_pcie_host_init
          X_pcie_establish_link

This patch removes ls_add_pcie_port() and ls_pcie_establish_link(), so
we're diverging a bit.  That makes it harder to see the similarities
across these drivers, which I think is a loss.

> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize host\n");
>  		return ret;
> +	}
>  
>  	platform_set_drvdata(pdev, pcie);
>  
>  	return 0;
>  }
>  
> -static const struct of_device_id ls_pcie_of_match[] = {
> -	{ .compatible = "fsl,ls1021a-pcie" },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, ls_pcie_of_match);
> -
>  static struct platform_driver ls_pcie_driver = {
>  	.driver = {
>  		.name = "layerscape-pcie",
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
