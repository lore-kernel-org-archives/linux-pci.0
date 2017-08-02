Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752173AbdHBVLk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Aug 2017 17:11:40 -0400
Date: Wed, 2 Aug 2017 16:11:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        jingoohan1@gmail.com, Joao.Pinto@synopsys.com,
        Minghuan Lian <Minghuan.Lian@nxp.com>
Subject: Re: [PATCH 3/3] PCI: layerscape: refactor the host_init function
Message-ID: <20170802211137.GG20308@bhelgaas-glaptop.roam.corp.google.com>
References: <1499322829-23018-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <1499322829-23018-3-git-send-email-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499322829-23018-3-git-send-email-Zhiqiang.Hou@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 06, 2017 at 02:33:49PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Main changes:
> - Make the ls1021a's host_init reuse layerscape platform's common
>   host_init function.
> - Will not use the outbound windows configured by bootloader, but
>   introduce DWC common setup function dw_pcie_setup_rc and disable
>   the bootloader configured outbound windows. And remove the duplicate
>   class field fix code.

This seems to have two or even three distinct changes mixed together.
Please split them into separate patches.  In particular, you mention a
class code fix -- that should be its own separate patch.

> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
>  drivers/pci/dwc/pci-layerscape.c | 85 ++++++++++++++++++++++------------------
>  1 file changed, 46 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
> index fd86128..9bed3cd 100644
> --- a/drivers/pci/dwc/pci-layerscape.c
> +++ b/drivers/pci/dwc/pci-layerscape.c
> @@ -33,7 +33,8 @@
>  
>  /* PEX Internal Configuration Registers */
>  #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
> -#define PCIE_DBI_RO_WR_EN	0x8bc /* DBI Read-Only Write Enable Register */
> +
> +#define PCIE_IATU_NUM		6
>  
>  struct ls_pcie_drvdata {
>  	u32 lut_offset;
> @@ -69,15 +70,9 @@ static void ls_pcie_clear_multifunction(struct ls_pcie *pcie)
>  {
>  	struct dw_pcie *pci = pcie->pci;
>  
> +	dw_pcie_dbi_ro_wr_en(pci);
>  	iowrite8(PCI_HEADER_TYPE_BRIDGE, pci->dbi_base + PCI_HEADER_TYPE);
> -}
> -
> -/* Fix class value */
> -static void ls_pcie_fix_class(struct ls_pcie *pcie)
> -{
> -	struct dw_pcie *pci = pcie->pci;
> -
> -	iowrite16(PCI_CLASS_BRIDGE_PCI, pci->dbi_base + PCI_CLASS_DEVICE);
> +	dw_pcie_dbi_ro_wr_dis(pci);
>  }
>  
>  /* Drop MSG TLP except for Vendor MSG */
> @@ -91,6 +86,14 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
>  	iowrite32(val, pci->dbi_base + PCIE_STRFMR1);
>  }
>  
> +static void ls_pcie_disable_outbound_atus(struct ls_pcie *pcie)
> +{
> +	int i;
> +
> +	for (i = 0; i < PCIE_IATU_NUM; i++)
> +		dw_pcie_disable_atu(pcie->pci, DW_PCIE_REGION_OUTBOUND, i);
> +}
> +
>  static int ls1021_pcie_link_up(struct dw_pcie *pci)
>  {
>  	u32 state;
> @@ -108,33 +111,6 @@ static int ls1021_pcie_link_up(struct dw_pcie *pci)
>  	return 1;
>  }
>  
> -static void ls1021_pcie_host_init(struct pcie_port *pp)
> -{
> -	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -	struct ls_pcie *pcie = to_ls_pcie(pci);
> -	struct device *dev = pci->dev;
> -	u32 index[2];
> -
> -	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
> -						     "fsl,pcie-scfg");
> -	if (IS_ERR(pcie->scfg)) {
> -		dev_err(dev, "No syscfg phandle specified\n");
> -		pcie->scfg = NULL;
> -		return;
> -	}
> -
> -	if (of_property_read_u32_array(dev->of_node,
> -				       "fsl,pcie-scfg", index, 2)) {
> -		pcie->scfg = NULL;
> -		return;
> -	}
> -	pcie->index = index[1];
> -
> -	dw_pcie_setup_rc(pp);
> -
> -	ls_pcie_drop_msg_tlp(pcie);
> -}
> -
>  static int ls_pcie_link_up(struct dw_pcie *pci)
>  {
>  	struct ls_pcie *pcie = to_ls_pcie(pci);
> @@ -155,11 +131,42 @@ static void ls_pcie_host_init(struct pcie_port *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct ls_pcie *pcie = to_ls_pcie(pci);
>  
> -	iowrite32(1, pci->dbi_base + PCIE_DBI_RO_WR_EN);
> -	ls_pcie_fix_class(pcie);
> +	/*
> +	 * Disable the outbound windows configured by bootloader to avoid
> +	 * one transaction hitting multiple outbound windows and the function
> +	 * dw_pcie_setup_rc will re-configure the outbound windows.
> +	 */
> +	ls_pcie_disable_outbound_atus(pcie);
> +
>  	ls_pcie_clear_multifunction(pcie);
>  	ls_pcie_drop_msg_tlp(pcie);
> -	iowrite32(0, pci->dbi_base + PCIE_DBI_RO_WR_EN);
> +
> +	dw_pcie_setup_rc(pp);
> +}
> +
> +static void ls1021_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct ls_pcie *pcie = to_ls_pcie(pci);
> +	struct device *dev = pci->dev;
> +	u32 index[2];
> +
> +	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
> +						     "fsl,pcie-scfg");
> +	if (IS_ERR(pcie->scfg)) {
> +		dev_err(dev, "No syscfg phandle specified\n");
> +		pcie->scfg = NULL;
> +		return;
> +	}
> +
> +	if (of_property_read_u32_array(dev->of_node,
> +				       "fsl,pcie-scfg", index, 2)) {
> +		pcie->scfg = NULL;
> +		return;
> +	}
> +	pcie->index = index[1];
> +
> +	ls_pcie_host_init(pp);
>  }
>  
>  static int ls_pcie_msi_host_init(struct pcie_port *pp,
> -- 
> 2.1.0.27.g96db324
> 
