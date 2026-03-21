Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48CC25CC74;
	Sat, 21 Mar 2026 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774102883; cv=none; b=DjsYQYrx638H3ohQb41qY1wGFmmsQCsff/sHJk51uXQDcii6PYpuiOLopoHnGfqTV760ccbz9pnelrpdjvGP1DgcNKh6Em7u8KHE8cxL+Jorw77VB3u5s5uPrZP9iMFPxmn1FYpXaCvi/cgBz2og21QVnmzCmUDRvPzw5zDrsiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774102883; c=relaxed/simple;
	bh=DY4uWjalSuqbL52BDoEf933WTqI+Am7QyBM9qsb5BWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6olIb1kb6lknqWw7UIoJu7e21mUAvMGW2RATD7ftqcSF3gABUnHxDk4ODpprZD5OTH+a/q5f1R6jeVf1do/jvW+YSrtIRQoJcVsfA5X3IuWg0wAOFe0cOT1W4ZHWX7YhgsUG2Lp+FjfSVBBZk3YXqz7cpm5J67Q0lzLsedPcso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCuwWaQq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCuwWaQq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDF2C19421;
	Sat, 21 Mar 2026 14:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774102883;
	bh=DY4uWjalSuqbL52BDoEf933WTqI+Am7QyBM9qsb5BWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCuwWaQqaGB6AqYafAMqKDmc4wq1UGyVi/Y21TjM5F/aEiRP3cXN6SyRyAXWE8nft
	 dANev5rLLwsu0Dp856TzYjqvaN+DW+JLPnSkW77K743sLqnL8LsSWWwo51MhAbAugG
	 zlDjXcbKGW0eNk/W+yKn19mv1I3jJFOFpH9aQ/AP2vUHb8hXv34zsNFS9agQM3+fGR
	 3n8d3VNRLEfYHMubFX5+n+QpCCIFxjDIH4IEidyoWG75w2o/cjNtG0Rd1Ucu2vmHcQ
	 K3a8tSvEZ9nCjMCwZ45QBq8yJH+PlONL7muApF0MmscgEeI23k2GsTyuo8NJXU9MMp
	 sc7ynGZABP1BQ==
Date: Sat, 21 Mar 2026 19:51:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>, Marco Crivellari <marco.crivellari@suse.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v10 2/7] PCI: dwc: Record integrated eDMA register window
Message-ID: <tzcqd4makvehalrvpv2t7oiioz24vuewyggnnmlcjusuhv74hl@7ywfq565tm74>
References: <20260302071427.534158-1-den@valinux.co.jp>
 <20260302071427.534158-3-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302071427.534158-3-den@valinux.co.jp>

On Mon, Mar 02, 2026 at 04:14:22PM +0900, Koichiro Den wrote:
> Some DesignWare PCIe controllers integrate an eDMA block whose registers
> are located in a dedicated register window. Endpoint function drivers
> may need the physical base and size of this window to map/expose it to a
> peer.
> 

This sounds exactly like 'Remote eDMA' concept where the eDMA registers are
exposed over BAR and programmed by the host. So why this duplication and why
can't you reuse remote eDMA?

- Mani

> Record the physical base and size of the integrated eDMA register window
> in struct dw_pcie.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 4 ++++
>  drivers/pci/controller/dwc/pcie-designware.h | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 5741c09dde7f..f82ed189f6ae 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -162,8 +162,12 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
>  			pci->edma.reg_base = devm_ioremap_resource(pci->dev, res);
>  			if (IS_ERR(pci->edma.reg_base))
>  				return PTR_ERR(pci->edma.reg_base);
> +			pci->edma_reg_phys = res->start;
> +			pci->edma_reg_size = resource_size(res);
>  		} else if (pci->atu_size >= 2 * DEFAULT_DBI_DMA_OFFSET) {
>  			pci->edma.reg_base = pci->atu_base + DEFAULT_DBI_DMA_OFFSET;
> +			pci->edma_reg_phys = pci->atu_phys_addr + DEFAULT_DBI_DMA_OFFSET;
> +			pci->edma_reg_size = pci->atu_size - DEFAULT_DBI_DMA_OFFSET;
>  		}
>  	}
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ae6389dd9caa..52f26663e8b1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -541,6 +541,8 @@ struct dw_pcie {
>  	int			max_link_speed;
>  	u8			n_fts[2];
>  	struct dw_edma_chip	edma;
> +	phys_addr_t		edma_reg_phys;
> +	resource_size_t		edma_reg_size;
>  	bool			l1ss_support;	/* L1 PM Substates support */
>  	struct clk_bulk_data	app_clks[DW_PCIE_NUM_APP_CLKS];
>  	struct clk_bulk_data	core_clks[DW_PCIE_NUM_CORE_CLKS];
> -- 
> 2.51.0
> 

-- 
மணிவண்ணன் சதாசிவம்
