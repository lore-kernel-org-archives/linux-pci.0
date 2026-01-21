Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC973B9600;
	Wed, 21 Jan 2026 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989509; cv=none; b=FCPiL/5tsmhMcpMYfqFbU2S5cvaxnTHKwxsDKw9fOijwH5xs78yJCWpJDBavCcGL64qqFlZGMJZyWX6kc1+4iUENAfQGvKjHfbXA/oYfGKqcPdlVFBLCyke9Ni/YZTxn3v5xYbR6nJQFBIMC0Vtm7aaMudrctLEJmMtIWnSIlSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989509; c=relaxed/simple;
	bh=TuITjQI+l9XZd2z34A5WDasikeUJsIJbevs9z/2YDQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cn6ovWwwx/W4ljJ8r87IoYvHL1U2CvtaoCeOoWifmHystyYEzJu1NjVYm3mcOVtRG11AlOtZWAYomJd+fqpNiGmDqSAEi71BBpx5mv9TNYS25xfcCDnn0c3nVt2qwcsrLimblL4v8yzGeCIsqImHJlbKa9VDK09To8xey/gPlew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxCNhaHi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxCNhaHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDBAC116D0;
	Wed, 21 Jan 2026 09:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768989508;
	bh=TuITjQI+l9XZd2z34A5WDasikeUJsIJbevs9z/2YDQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JxCNhaHi+1EBywuKa+g8n49cQWJQ2ltfrSCLGl0REvjAtMFMmqLS/BTr7FQr2HP66
	 RcdYOmcZ9TjmvXZYre7CmntTyCtnMz8Ly/ezHHLDZkUIWRp/AhBrsrAlDsVC/HcaGJ
	 2y5TNWNefwp/OMy1wdjngTPGoCjkNBaORG0mk1BAD6QKWujl/GM/s/KzT8SEGUGkGm
	 witdSHE5faVU4Bet/0x6UH+s1UKd4D6dkhnGqmHOMW1Z7tID0I3UEKXTIZCX9tdzLa
	 fTtlB+k18dEX1bbmhfLG9UeFKxQEHFSgmKTGPfxErghwQ9NFyZyl/a2bPNr6sEloo1
	 52l8me8YGNq5A==
Date: Wed, 21 Jan 2026 10:58:23 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, linux-kernel@vger.kernel.org,
	s-vadapalli@ti.com, danishanwar@ti.com
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Fix resizable BAR support for multi-PF
 configurations
Message-ID: <aXCjP8KZw1ig8i-W@ryzen>
References: <20260121054214.274429-1-a-garg7@ti.com>
 <20260121054214.274429-2-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121054214.274429-2-a-garg7@ti.com>

On Wed, Jan 21, 2026 at 11:12:13AM +0530, Aksh Garg wrote:
> The resizable BAR support added by the commit 3a3d4cabe681
> ("PCI: dwc: ep: Allow EPF drivers to configure the size of Resizable
> BARs") incorrectly configures the resizable BARs only for the first
> Physical Function (PF0) in EP mode.
> 
> The resizable BAR configuration functions use generic dw_pcie_*_dbi
> operations instead of physical function specific dw_pcie_ep_*_dbi
> operations. This causes resizable BAR configuration to always target
> PF0 regardless of the requested function number.
> 
> Additionally, dw_pcie_ep_init_non_sticky_registers() only initializes
> resizable BAR registers for PF0, leaving other PFs unconfigured during
> the execution of this function.
> 
> Fix this by using physical function specific configuration space access
> operations throughout the resizable BAR code path and initializing
> registers for all the physical functions that support resizable BARs.
> 
> Fixes: 3a3d4cabe681 ("PCI: dwc: ep: Allow EPF drivers to configure the size of Resizable BARs")
> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 49 +++++++++++++------
>  1 file changed, 33 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 19571ac2b961..f222677a7a87 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -75,6 +75,13 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
>  				 cap, ep, func_no);
>  }
>  
> +static u16 dw_pcie_ep_find_ext_capability(struct dw_pcie_ep *ep,
> +					  u8 func_no, u8 cap)
> +{
> +	return PCI_FIND_NEXT_EXT_CAP(dw_pcie_ep_read_cfg, 0,
> +				     cap, ep, func_no);
> +}
> +
>  /**
>   * dw_pcie_ep_hide_ext_capability - Hide a capability from the linked list
>   * @pci: DWC PCI device
> @@ -217,22 +224,22 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	ep->bar_to_atu[bar] = 0;
>  }
>  
> -static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie *pci,
> +static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie_ep *ep, u8 func_no,
>  						enum pci_barno bar)
>  {
>  	u32 reg, bar_index;
>  	unsigned int offset, nbars;
>  	int i;
>  
> -	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> +	offset = dw_pcie_ep_find_ext_capability(ep, func_no, PCI_EXT_CAP_ID_REBAR);
>  	if (!offset)
>  		return offset;
>  
> -	reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> +	reg = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_REBAR_CTRL);
>  	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, reg);
>  
>  	for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL) {
> -		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> +		reg = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_REBAR_CTRL);
>  		bar_index = FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, reg);
>  		if (bar_index == bar)
>  			return offset;
> @@ -253,7 +260,7 @@ static int dw_pcie_ep_set_bar_resizable(struct dw_pcie_ep *ep, u8 func_no,
>  	u32 rebar_cap, rebar_ctrl;
>  	int ret;
>  
> -	rebar_offset = dw_pcie_ep_get_rebar_offset(pci, bar);
> +	rebar_offset = dw_pcie_ep_get_rebar_offset(ep, func_no, bar);
>  	if (!rebar_offset)
>  		return -EINVAL;
>  
> @@ -283,16 +290,16 @@ static int dw_pcie_ep_set_bar_resizable(struct dw_pcie_ep *ep, u8 func_no,
>  	 * 1 MB to 128 TB. Bits 31:16 in PCI_REBAR_CTRL define "supported sizes"
>  	 * bits for sizes 256 TB to 8 EB. Disallow sizes 256 TB to 8 EB.
>  	 */
> -	rebar_ctrl = dw_pcie_readl_dbi(pci, rebar_offset + PCI_REBAR_CTRL);
> +	rebar_ctrl = dw_pcie_ep_readl_dbi(ep, func_no, rebar_offset + PCI_REBAR_CTRL);
>  	rebar_ctrl &= ~GENMASK(31, 16);
> -	dw_pcie_writel_dbi(pci, rebar_offset + PCI_REBAR_CTRL, rebar_ctrl);
> +	dw_pcie_ep_writel_dbi(ep, func_no, rebar_offset + PCI_REBAR_CTRL, rebar_ctrl);
>  
>  	/*
>  	 * The "selected size" (bits 13:8) in PCI_REBAR_CTRL are automatically
>  	 * updated when writing PCI_REBAR_CAP, see "Figure 3-26 Resizable BAR
>  	 * Example for 32-bit Memory BAR0" in DWC EP databook 5.96a.
>  	 */
> -	dw_pcie_writel_dbi(pci, rebar_offset + PCI_REBAR_CAP, rebar_cap);
> +	dw_pcie_ep_writel_dbi(ep, func_no, rebar_offset + PCI_REBAR_CAP, rebar_cap);
>  
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  
> @@ -836,20 +843,17 @@ void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit);
>  
> -static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
> +static void __dw_pcie_ep_init_non_sticky_registers(struct dw_pcie_ep *ep, u8 func_no)
>  {
> -	struct dw_pcie_ep *ep = &pci->ep;
>  	unsigned int offset;
>  	unsigned int nbars;
>  	enum pci_barno bar;
>  	u32 reg, i, val;
>  
> -	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> -
> -	dw_pcie_dbi_ro_wr_en(pci);
> +	offset = dw_pcie_ep_find_ext_capability(ep, func_no, PCI_EXT_CAP_ID_REBAR);
>  
>  	if (offset) {
> -		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> +		reg = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_REBAR_CTRL);
>  		nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, reg);
>  
>  		/*
> @@ -870,16 +874,29 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
>  			 * the controller when RESBAR_CAP_REG is written, which
>  			 * is why RESBAR_CAP_REG is written here.
>  			 */
> -			val = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> +			val = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_REBAR_CTRL);
>  			bar = FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, val);
>  			if (ep->epf_bar[bar])
>  				pci_epc_bar_size_to_rebar_cap(ep->epf_bar[bar]->size, &val);
>  			else
>  				val = BIT(4);
>  
> -			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, val);
> +			dw_pcie_ep_writel_dbi(ep, func_no, offset + PCI_REBAR_CAP, val);
>  		}
>  	}
> +}
> +
> +static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
> +{
> +	struct dw_pcie_ep *ep = &pci->ep;
> +	u8 func_no, funcs;
> +
> +	funcs = ep->epc->max_functions;

Initialize this on the same line as the variable is declared.
u8 func_no; will be on a separate line.


> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	for (func_no = 0; func_no < funcs; func_no++)
> +		__dw_pcie_ep_init_non_sticky_registers(ep, func_no);
>  
>  	dw_pcie_setup(pci);
>  	dw_pcie_dbi_ro_wr_dis(pci);
> -- 
> 2.34.1
> 


Thank you for fixing this!

Reviewed-by: Niklas Cassel <cassel@kernel.org>


You do need another patch in this series though, that fixes:
https://github.com/torvalds/linux/blob/v6.19-rc6/drivers/pci/controller/dwc/pcie-designware-ep.c#L972-L986

As currently, ptm_cap_base is fetched using dw_pcie_find_ext_capability()
instead of your new dw_pcie_ep_find_ext_capability() which takes a func_no.


Kind regards,
Niklas
