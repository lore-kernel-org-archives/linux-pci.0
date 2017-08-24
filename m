Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752842AbdHXRMI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Aug 2017 13:12:08 -0400
Date: Thu, 24 Aug 2017 12:12:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        jingoohan1@gmail.com, Joao.Pinto@synopsys.com,
        minghuan.lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        svarbanov@mm-sol.com, niklas.cassel@axis.com,
        jesper.nilsson@axis.com
Subject: Re: [PATCHv4 4/9] PCI: layerscape: refactor the host_init function
Message-ID: <20170824171206.GP31858@bhelgaas-glaptop.roam.corp.google.com>
References: <20170823060856.9387-1-Zhiqiang.Hou@nxp.com>
 <20170823060856.9387-5-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170823060856.9387-5-Zhiqiang.Hou@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 23, 2017 at 02:08:51PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Make the ls1021a's host_init reuse layerscape platform's common
> host_init function.

This patch does two things:

  1) Moves ls1021_pcie_host_init() to a different place in the file
  2) Calls ls_pcie_host_init() instead of repeating that code in
     ls1021_pcie_host_init()

Those should be separate patches so they're easier to review.

Or if you don't really need to move ls1021_pcie_host_init() to a different
place, that would be even easier.

> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V4:
>  - no change
> 
>  drivers/pci/dwc/pci-layerscape.c | 65 ++++++++++++++++++----------------------
>  1 file changed, 29 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
> index 3aa34214643c..57b86a0cd2c8 100644
> --- a/drivers/pci/dwc/pci-layerscape.c
> +++ b/drivers/pci/dwc/pci-layerscape.c
> @@ -108,42 +108,6 @@ static int ls1021_pcie_link_up(struct dw_pcie *pci)
>  	return 1;
>  }
>  
> -static int ls1021_pcie_host_init(struct pcie_port *pp)
> -{
> -	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -	struct ls_pcie *pcie = to_ls_pcie(pci);
> -	struct device *dev = pci->dev;
> -	u32 index[2];
> -	int ret;
> -
> -	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
> -						     "fsl,pcie-scfg");
> -	if (IS_ERR(pcie->scfg)) {
> -		ret = PTR_ERR(pcie->scfg);
> -		dev_err(dev, "No syscfg phandle specified\n");
> -		pcie->scfg = NULL;
> -		return ret;
> -	}
> -
> -	if (of_property_read_u32_array(dev->of_node,
> -				       "fsl,pcie-scfg", index, 2)) {
> -		pcie->scfg = NULL;
> -		return -EINVAL;
> -	}
> -	pcie->index = index[1];
> -
> -	dw_pcie_setup_rc(pp);
> -
> -	iowrite32(1, pci->dbi_base + PCIE_DBI_RO_WR_EN);
> -	ls_pcie_fix_class(pcie);
> -	ls_pcie_clear_multifunction(pcie);
> -	iowrite32(0, pci->dbi_base + PCIE_DBI_RO_WR_EN);
> -
> -	ls_pcie_drop_msg_tlp(pcie);
> -
> -	return 0;
> -}
> -
>  static int ls_pcie_link_up(struct dw_pcie *pci)
>  {
>  	struct ls_pcie *pcie = to_ls_pcie(pci);
> @@ -176,6 +140,35 @@ static int ls_pcie_host_init(struct pcie_port *pp)
>  	return 0;
>  }
>  
> +static int ls1021_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct ls_pcie *pcie = to_ls_pcie(pci);
> +	struct device *dev = pci->dev;
> +	u32 index[2];
> +	int ret;
> +
> +	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
> +						     "fsl,pcie-scfg");
> +	if (IS_ERR(pcie->scfg)) {
> +		ret = PTR_ERR(pcie->scfg);
> +		dev_err(dev, "No syscfg phandle specified\n");
> +		pcie->scfg = NULL;
> +		return ret;
> +	}
> +
> +	if (of_property_read_u32_array(dev->of_node,
> +				       "fsl,pcie-scfg", index, 2)) {
> +		pcie->scfg = NULL;
> +		return -EINVAL;
> +	}
> +	pcie->index = index[1];
> +
> +	ls_pcie_host_init(pp);
> +
> +	return 0;
> +}
> +
>  static int ls_pcie_msi_host_init(struct pcie_port *pp,
>  				 struct msi_controller *chip)
>  {
> -- 
> 2.14.1
> 
