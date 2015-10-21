Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59367 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754507AbbJUVgQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 21 Oct 2015 17:36:16 -0400
Date: Wed, 21 Oct 2015 16:36:12 -0500
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
Subject: Re: [PATCH v4 5/6] PCI: layerscape: add PCIe support for LS1043a and
 LS2080a
Message-ID: <20151021213612.GK1583@localhost>
References: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
 <1444979960-24100-5-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444979960-24100-5-git-send-email-Minghuan.Lian@freescale.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 16, 2015 at 03:19:19PM +0800, Minghuan Lian wrote:
> Both LS1043a and LS2080a are based on ARMv8 64-bit architecture
> and have similar PCIe implementation. LUT is added to controller.
> The patch removes the necessary fields from struct ls_pcie.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
> This patch is based on v4.3-rc4 and [PATCH v10 3/6]
> PCI: designware: Add ARM64 support.
> 
> change log
> v4: 
> 1. split to 6 patches.
> 2. use ARCH_LAYERSCAPE instead of ARM64
> 
> v3:
> 1. Use 8 or 16 bit access function to simplify code
> 2. Add ls_add_pcie_port in accordance with other DesignWare-based drivers
> 
> v2:
> 1. Rename ls2085a to ls2080a
> 2. Add ls_pcie_msi_host_init()
> 
>  drivers/pci/host/Kconfig          |  2 +-
>  drivers/pci/host/pci-layerscape.c | 72 +++++++++++++++++++++++++++++++++++----
>  2 files changed, 67 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index ae873be..8eb09ea 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -105,7 +105,7 @@ config PCI_XGENE_MSI
>  
>  config PCI_LAYERSCAPE
>  	bool "Freescale Layerscape PCIe controller"
> -	depends on OF && ARM
> +	depends on OF && (ARM || ARCH_LAYERSCAPE)
>  	select PCIE_DW
>  	select MFD_SYSCON
>  	help
> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
> index 891e504..c53692a 100644
> --- a/drivers/pci/host/pci-layerscape.c
> +++ b/drivers/pci/host/pci-layerscape.c
> @@ -31,23 +31,26 @@
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
>  
>  struct ls_pcie_drvdata {
> +	u32 lut_offset;
> +	u32 ltssm_shift;
>  	struct pcie_host_ops *ops;
>  };
>  
>  struct ls_pcie {
> -	struct list_head node;
> -	struct device *dev;
> -	struct pci_bus *bus;

These fields look unused and unrelated to LS1043a and LS2080a.  I split
their removal into a separate patch.

>  	void __iomem *dbi;
> +	void __iomem *lut;
>  	struct regmap *scfg;
>  	struct pcie_port pp;
>  	const struct ls_pcie_drvdata *drvdata;
>  	int index;
> -	int msi_irq;
>  };
>  
>  #define to_ls_pcie(x)	container_of(x, struct ls_pcie, pp)
> @@ -62,6 +65,18 @@ static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
>  	return header_type == PCI_HEADER_TYPE_BRIDGE;
>  }
>  
> +/* Clear multi-function bit */
> +static void ls_pcie_clear_multifunction(struct ls_pcie *pcie)
> +{
> +	iowrite8(PCI_HEADER_TYPE_BRIDGE, pcie->dbi + PCI_HEADER_TYPE);
> +}
> +
> +/* Fix class value */
> +static void ls_pcie_fix_class(struct ls_pcie *pcie)
> +{
> +	iowrite16(PCI_CLASS_BRIDGE_PCI, pcie->dbi + PCI_CLASS_DEVICE);
> +}
> +
>  static int ls1021_pcie_link_up(struct pcie_port *pp)
>  {
>  	u32 state;
> @@ -110,17 +125,61 @@ static void ls1021_pcie_host_init(struct pcie_port *pp)
>  	iowrite32(val, pcie->dbi + PCIE_STRFMR1);
>  }
>  
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
> +}
> +
> +static void ls_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct ls_pcie *pcie = to_ls_pcie(pp);
> +
> +	iowrite32(1, pcie->dbi + PCIE_DBI_RO_WR_EN);
> +	ls_pcie_fix_class(pcie);
> +	ls_pcie_clear_multifunction(pcie);
> +	iowrite32(0, pcie->dbi + PCIE_DBI_RO_WR_EN);
> +}
> +
>  static struct pcie_host_ops ls1021_pcie_host_ops = {
>  	.link_up = ls1021_pcie_link_up,
>  	.host_init = ls1021_pcie_host_init,
>  };
>  
> +static struct pcie_host_ops ls_pcie_host_ops = {
> +	.link_up = ls_pcie_link_up,
> +	.host_init = ls_pcie_host_init,
> +};
> +
>  static struct ls_pcie_drvdata ls1021_drvdata = {
>  	.ops = &ls1021_pcie_host_ops,
>  };
>  
> +static struct ls_pcie_drvdata ls1043_drvdata = {
> +	.lut_offset = 0x10000,
> +	.ltssm_shift = 24,
> +	.ops = &ls_pcie_host_ops,
> +};
> +
> +static struct ls_pcie_drvdata ls2080_drvdata = {
> +	.lut_offset = 0x80000,
> +	.ltssm_shift = 0,
> +	.ops = &ls_pcie_host_ops,
> +};
> +
>  static const struct of_device_id ls_pcie_of_match[] = {
>  	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
> +	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata },
> +	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, ls_pcie_of_match);
> @@ -167,6 +226,7 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
>  	}
>  
>  	pcie->drvdata = match->data;
> +	pcie->lut = pcie->dbi + pcie->drvdata->lut_offset;
>  
>  	if (!ls_pcie_is_bridge(pcie))
>  		return -ENODEV;
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
