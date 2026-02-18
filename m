Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84148322753;
	Wed, 18 Feb 2026 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771421917; cv=none; b=mSkjdaZREDSALqw4h8t4jtKuA84bcad5vvieOCzgoc3aUhlVS5kPTp3p1BWXnC4GdCkUGiOo5LhgPMiRlNXDg1QI6DTkGRULCKYl6K38/DDysOhiuY9FzfCje4Z9D/8eNRoMcbtULGm85h4qMlT1mHj7oZEXqX4TF9UBw56+3JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771421917; c=relaxed/simple;
	bh=nf1PQ7PDf17bWRa+TIlLPQWoQMncV54jISORCxewpYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AN0VDpvLDqwP0DThpUR6KTnxXccLFyUGRfKdbm/whBjZonW0UrA51srCw6QBTIXC0dPnpj02xHDUrd5+ef5E1vzQ58GqepCkXUXAjTZGxhjEL6iFe+yieKc81ck6bgWy/J2sLAnneJiFEgDKN3g699saRy49yLfKYzo128v60to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJduA/yD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJduA/yD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C162DC19421;
	Wed, 18 Feb 2026 13:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771421917;
	bh=nf1PQ7PDf17bWRa+TIlLPQWoQMncV54jISORCxewpYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJduA/yDMzIvXgLIrqqVScUPApQ+a3R9gqkW1mTsvQxhDugJB/EQWrxuQICg7tgC/
	 tV47Zdu7tv+mV11w9J/6/Lx7AxwOuDTWKmy/vQJ6LlZC+qEs6lOBxRMiiF2AsDH6kz
	 ot6iNCG+WBsXUK8qtOr04H2LZuA65Yec13xgEya30KFlMQ+jVBaLgjKdLnGf/W9Tez
	 dikAxUJMggCBImjt/zH/xfNdc+VKwSShZEwuKE/+wEKacgFrnT9ZOW8vO3/3D06t9J
	 DLmA331yGjXrTkv5iTH54nsKE9BTySeX+0CPsLisoHIv91O2u+dNUEcOEzVwk4uQ5X
	 q2mY2nwBQGq8Q==
Date: Wed, 18 Feb 2026 19:08:20 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	yoshihiro.shimoda.uh@renesas.com, fancer.lancer@gmail.com, Zhiqiang.Hou@nxp.com, 
	gustavo.pimentel@synopsys.com, cassel@kernel.org, linux-kernel@vger.kernel.org, 
	s-vadapalli@ti.com, danishanwar@ti.com
Subject: Re: [PATCH 2/2] PCI: dwc: ep: Mirror the max link width and speed
 fields to all functions
Message-ID: <kr3yh3unbsynddcgzhl2zpxmna7hbc4dxgbqo3bmlwsn5twlyr@7gxzh4rqjubg>
References: <20260202072758.101845-1-a-garg7@ti.com>
 <20260202072758.101845-3-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260202072758.101845-3-a-garg7@ti.com>

On Mon, Feb 02, 2026 at 12:57:58PM +0530, Aksh Garg wrote:
> PCIe r6.0, section 7.5.3.6 states that for multi-function devices, the
> Max Link Width and Max Link Speed fields in the Link Capabilities
> Register must report the same values for all functions.
> 
> Currently, dw_pcie_setup() programs these fields only for physical
> function 0 (PF0) via dw_pcie_link_set_max_speed() and
> dw_pcie_link_set_max_link_width(). For multi-function endpoint
> configurations, PF1 and beyond retain their default values, violating
> the PCIe specification.
> 
> Fix this by reading the Max Link Width and Max Link Speed fields from
> PF0's Link Capabilities Register after dw_pcie_setup() completes,
> then mirroring these values to all other physical functions.
> 
> Fixes: 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support for DWC")
> Fixes: 89db0793c9f2 ("PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW handling")
> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> ---
> 
> The link speed and width would be negotiated through PF0 during
> initialization that controls the link behaviour, hence it didn't broke
> the driver. However, the change is proposed just to make the driver
> compatible with the PCIe base specifications.
> 
> The fix is implemented in pcie-designware-ep.c rather than modifying
> dw_pcie_setup() directly to keep pcie-designware.c independent of RC/EP
> specifics and maintain it as common code.
> 
>  .../pci/controller/dwc/pcie-designware-ep.c   | 24 ++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 771241e1a2c9..4ac25da2b117 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -1094,7 +1094,8 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
>  {
>  	struct dw_pcie_ep *ep = &pci->ep;
>  	u8 funcs = ep->epc->max_functions;
> -	u8 func_no;
> +	u32 ref_lnkcap, lnkcap;
> +	u8 func_no, offset;
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
>  
> @@ -1102,6 +1103,27 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
>  		dw_pcie_ep_init_rebar_registers(ep, func_no);
>  
>  	dw_pcie_setup(pci);
> +
> +	/*
> +	 * PCIe r6.0, section 7.5.3.6 states that for multi-function endpoints,
> +	 * max link width and speed fields must report same values for all functions.
> +	 * However, dw_pcie_setup() programs these fields only for physical function 0.
> +	 * Hence, mirror these fields to all other physical functions as well.
> +	 */
> +	if (funcs > 1) {
> +		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +		ref_lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> +		ref_lnkcap &= PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS;

Use FIELD_* macros please.

- Mani

> +
> +		for (func_no = 1; func_no < funcs; func_no++) {
> +			offset = dw_pcie_ep_find_capability(ep, func_no, PCI_CAP_ID_EXP);
> +			lnkcap = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_EXP_LNKCAP);
> +			lnkcap &= ~(PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS);
> +			lnkcap |= ref_lnkcap;
> +			dw_pcie_ep_writel_dbi(ep, func_no, offset + PCI_EXP_LNKCAP, lnkcap);
> +		}
> +	}
> +
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  }
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
