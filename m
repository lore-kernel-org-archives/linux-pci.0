Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752627AbdHNVi0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Aug 2017 17:38:26 -0400
Date: Mon, 14 Aug 2017 16:38:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        jingoohan1@gmail.com, Joao.Pinto@synopsys.com,
        minghuan.lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com
Subject: Re: [PATCHv2 4/6] PCI: layerscape: refactor the host_init function
Message-ID: <20170814213824.GJ32525@bhelgaas-glaptop.roam.corp.google.com>
References: <1501748620-42866-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <1501748620-42866-5-git-send-email-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501748620-42866-5-git-send-email-Zhiqiang.Hou@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 03, 2017 at 04:23:38PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Make the ls1021a's host_init reuse layerscape platform's common
> host_init function.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Removed the disable outbound windows code and the remove duplicate class code
>    fixup code from this patch.
> 
>  drivers/pci/dwc/pci-layerscape.c | 54 ++++++++++++++++++++--------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
> index 09056a6..3533a8c 100644
> --- a/drivers/pci/dwc/pci-layerscape.c
> +++ b/drivers/pci/dwc/pci-layerscape.c
> @@ -107,33 +107,6 @@ static int ls1021_pcie_link_up(struct dw_pcie *pci)
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
> @@ -160,6 +133,33 @@ static void ls_pcie_host_init(struct pcie_port *pp)
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  
>  	ls_pcie_drop_msg_tlp(pcie);
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

The changelog suggests that this is a simple refactoring that doesn't
fix anything.

But because ls1021_pcie_host_init() now calls ls_pcie_host_init(), it
now calls:

  dw_pcie_dbi_ro_wr_en(pci);
  ls_pcie_fix_class(pcie);
  ls_pcie_clear_multifunction(pcie);
  dw_pcie_dbi_ro_wr_dis(pci);

when it did not call them before.

It's fine with me if you want to do that, but it should be mentioned
in the changelog.

>  }
>  
>  static int ls_pcie_msi_host_init(struct pcie_port *pp,
> -- 
> 2.1.0.27.g96db324
> 
