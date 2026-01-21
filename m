Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD636214D;
	Wed, 21 Jan 2026 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987251; cv=none; b=LRpfzgYVxHtm1lO9adiPQ20+yM/LNRhVyxQupF2oF8T5QkYZbkP096ItZ/GyiSmOp1rU/qbdCLHv+s4avRAXWFp5lQj/Y6WF9F15OoC6NT92yBTQgpdG18O8IW2TeLE3nHu4xcgd9CbtgmTubcbzdKNsErDRUXKHapNmKp8FOtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987251; c=relaxed/simple;
	bh=2853QaqFjbz3Xvya0K64I70ogQ5pk9Bhb15Gyl4q0mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEVl/W8hCT/4EBjB439X/xKYSCwXpKC11CcBVjHuXJw/PqDtZHTIPlDej8Y+E3QMAIVnThvNWMrzhRhPaks2KOrn962nbhrlCixLmReHZ+txKnXeH6gw4zVOzzCF/XBrJekVdZfmRzGL5UKuUSN/lpN7P/hOQ+T1l4A/gIRQ3k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHiWAE2q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHiWAE2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA70C116D0;
	Wed, 21 Jan 2026 09:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768987250;
	bh=2853QaqFjbz3Xvya0K64I70ogQ5pk9Bhb15Gyl4q0mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aHiWAE2qEIdYlo0ixdVRVlG6TEogL0GrUzf5vQVdbFl/SerO8wiAR+D5xt8oe27q9
	 C4974WTDzxda2sa2cBVzCtOjbyxSGGXz9p8CspVRC01CHAIbEByuTNbR/wi9xeMyrP
	 v9WfiVJEvHMJx3tsDc9vkmqDL5zXHMhQmkvdWfPpt8v9afyLBxhstB7BYoGHQqlIbE
	 0kuPWesN6ujyP0prntVWTKNyP2uxGJwDSLWXy2cWlVTsLOMj9DS89T//sLn7psXdAC
	 nchcXhn4UoFyRyd5Psnikz67NC+LhZNINXu6AQ+N4mFyPul8VEgqNmTo30NBzL3Ovn
	 1gBlDRKBKQmUg==
Date: Wed, 21 Jan 2026 10:20:45 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, linux-kernel@vger.kernel.org,
	s-vadapalli@ti.com, danishanwar@ti.com
Subject: Re: [PATCH 2/2] PCI: dwc: ep: Add per-PF BAR and iATU mapping support
Message-ID: <aXCaba4I0woHJCza@ryzen>
References: <20260121054214.274429-1-a-garg7@ti.com>
 <20260121054214.274429-3-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121054214.274429-3-a-garg7@ti.com>

On Wed, Jan 21, 2026 at 11:12:14AM +0530, Aksh Garg wrote:
> The commit 47a062609a30 ("PCI: designware-ep: Modify MSI and MSIX CAP
> way of finding") adds support for each physical function to have its
> own MSI and MSI-X capability structures by introducing struct
> dw_pcie_ep_func. However, BAR configuration and iATU mappings are still
> being managed globally in struct dw_pcie_ep, meaning all PFs shared the
> same BAR-to-iATU mapping table.

You are mentioning commit 47a062609a30 ("PCI: designware-ep: Modify MSI and
MSIX CAP way of finding"), but you should probably also mention commit
24ede430fa49 ("PCI: designware-ep: Add multiple PFs support for DWC")
which added support for PFs in the DWC driver.

That is the commit that is incorrect IMO. You cannot add support for PFs
and then have a different EPFs over overwriting address translation for
other EPFs. The design was simply broken from the start.


> 
> This creates conflicts when multiple physical functions attempts to
> configure BARs independently, as they would overwrite each other's
> iATU mappings and BAR configurations.
> 
> Move bar_to_atu and epf_bar from struct dw_pcie_ep to struct
> dw_pcie_ep_func to allow proper multi-function endpoint operation,
> where each function can configure its BARs without interfering with
> other functions.
> 
> Signed-off-by: Aksh Garg <a-garg7@ti.com>

Fixes: 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support for DWC")


> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 50 +++++++++++++------
>  drivers/pci/controller/dwc/pcie-designware.h  |  4 +-
>  2 files changed, 37 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index f222677a7a87..769602b58bd7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -153,11 +153,16 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>  	int ret;
>  	u32 free_win;
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct dw_pcie_ep_func *ep_func;
>  
> -	if (!ep->bar_to_atu[bar])
> +	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);

There is no reason why this can't be initialized on the same line as your are
declaring the ep_func variable, just like we do for other variables, e.g.
struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
so please more the initialization to same line as the declaration.


> +	if (!ep_func)
> +		return -EINVAL;
> +
> +	if (!ep_func->bar_to_atu[bar])
>  		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
>  	else
> -		free_win = ep->bar_to_atu[bar] - 1;
> +		free_win = ep_func->bar_to_atu[bar] - 1;
>  
>  	if (free_win >= pci->num_ib_windows) {
>  		dev_err(pci->dev, "No free inbound window\n");
> @@ -175,7 +180,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>  	 * Always increment free_win before assignment, since value 0 is used to identify
>  	 * unallocated mapping.
>  	 */
> -	ep->bar_to_atu[bar] = free_win + 1;
> +	ep_func->bar_to_atu[bar] = free_win + 1;
>  	set_bit(free_win, ep->ib_window_map);
>  
>  	return 0;
> @@ -211,17 +216,22 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar = epf_bar->barno;
> -	u32 atu_index = ep->bar_to_atu[bar] - 1;
> +	struct dw_pcie_ep_func *ep_func;
> +	u32 atu_index;
> +
> +	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);

Same comment as above.

>  
> -	if (!ep->bar_to_atu[bar])
> +	if (!ep_func || !ep_func->bar_to_atu[bar])
>  		return;
>  
> +	atu_index = ep_func->bar_to_atu[bar] - 1;
> +
>  	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
>  
>  	dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
>  	clear_bit(atu_index, ep->ib_window_map);
> -	ep->epf_bar[bar] = NULL;
> -	ep->bar_to_atu[bar] = 0;
> +	ep_func->epf_bar[bar] = NULL;
> +	ep_func->bar_to_atu[bar] = 0;
>  }
>  
>  static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie_ep *ep, u8 func_no,
> @@ -349,11 +359,16 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar = epf_bar->barno;
> +	struct dw_pcie_ep_func *ep_func;
>  	size_t size = epf_bar->size;
>  	enum pci_epc_bar_type bar_type;
>  	int flags = epf_bar->flags;
>  	int ret, type;
>  
> +	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);

Same comment as above.


> +	if (!ep_func)
> +		return -EINVAL;
> +
>  	/*
>  	 * DWC does not allow BAR pairs to overlap, e.g. you cannot combine BARs
>  	 * 1 and 2 to form a 64-bit BAR.
> @@ -367,14 +382,14 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	 * calling clear_bar() would clear the BAR's PCI address assigned by the
>  	 * host).
>  	 */
> -	if (ep->epf_bar[bar]) {
> +	if (ep_func->epf_bar[bar]) {
>  		/*
>  		 * We can only dynamically change a BAR if the new BAR size and
>  		 * BAR flags do not differ from the existing configuration.
>  		 */
> -		if (ep->epf_bar[bar]->barno != bar ||
> -		    ep->epf_bar[bar]->size != size ||
> -		    ep->epf_bar[bar]->flags != flags)
> +		if (ep_func->epf_bar[bar]->barno != bar ||
> +		    ep_func->epf_bar[bar]->size != size ||
> +		    ep_func->epf_bar[bar]->flags != flags)
>  			return -EINVAL;
>  
>  		/*
> @@ -420,7 +435,7 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	if (ret)
>  		return ret;
>  
> -	ep->epf_bar[bar] = epf_bar;
> +	ep_func->epf_bar[bar] = epf_bar;
>  
>  	return 0;
>  }
> @@ -782,7 +797,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	bir = FIELD_GET(PCI_MSIX_TABLE_BIR, tbl_offset);
>  	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
>  
> -	msix_tbl = ep->epf_bar[bir]->addr + tbl_offset;
> +	msix_tbl = ep_func->epf_bar[bir]->addr + tbl_offset;
>  	msg_addr = msix_tbl[(interrupt_num - 1)].msg_addr;
>  	msg_data = msix_tbl[(interrupt_num - 1)].msg_data;
>  	vec_ctrl = msix_tbl[(interrupt_num - 1)].vector_ctrl;
> @@ -845,11 +860,16 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit);
>  
>  static void __dw_pcie_ep_init_non_sticky_registers(struct dw_pcie_ep *ep, u8 func_no)
>  {
> +	struct dw_pcie_ep_func *ep_func;
>  	unsigned int offset;
>  	unsigned int nbars;
>  	enum pci_barno bar;
>  	u32 reg, i, val;
>  
> +	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);

Same comment as above.


> +	if (!ep_func)
> +		return;
> +
>  	offset = dw_pcie_ep_find_ext_capability(ep, func_no, PCI_EXT_CAP_ID_REBAR);
>  
>  	if (offset) {
> @@ -876,8 +896,8 @@ static void __dw_pcie_ep_init_non_sticky_registers(struct dw_pcie_ep *ep, u8 fun
>  			 */
>  			val = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_REBAR_CTRL);
>  			bar = FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, val);
> -			if (ep->epf_bar[bar])
> -				pci_epc_bar_size_to_rebar_cap(ep->epf_bar[bar]->size, &val);
> +			if (ep_func->epf_bar[bar])
> +				pci_epc_bar_size_to_rebar_cap(ep_func->epf_bar[bar]->size, &val);
>  			else
>  				val = BIT(4);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 31685951a080..a4d1733f5c6a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -463,6 +463,8 @@ struct dw_pcie_ep_func {
>  	u8			func_no;
>  	u8			msi_cap;	/* MSI capability offset */
>  	u8			msix_cap;	/* MSI-X capability offset */
> +	u8			bar_to_atu[PCI_STD_NUM_BARS];
> +	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
>  };
>  
>  struct dw_pcie_ep {
> @@ -472,13 +474,11 @@ struct dw_pcie_ep {
>  	phys_addr_t		phys_base;
>  	size_t			addr_size;
>  	size_t			page_size;
> -	u8			bar_to_atu[PCI_STD_NUM_BARS];
>  	phys_addr_t		*outbound_addr;
>  	unsigned long		*ib_window_map;
>  	unsigned long		*ob_window_map;
>  	void __iomem		*msi_mem;
>  	phys_addr_t		msi_mem_phys;
> -	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
>  };
>  
>  struct dw_pcie_ops {
> -- 
> 2.34.1
> 

With minor nits fixed:
Reviewed-by: Niklas Cassel <cassel@kernel.org>
