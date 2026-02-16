Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349AD30E0EF;
	Mon, 16 Feb 2026 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771251180; cv=none; b=AWeMY903RrYc1/4wXs6kkbHh8sNbziH/oVy+hRXL1yyzXlMg0Ig1Y6brkzqHimW2sTNINaduPzww3Xcv8UuQYcoesDSW8n5f777XULu0xiShefEM7T2EDuUcILb0DvFBF/xGZLQj0xb31kcOafJ7YKAgoJ/Nzz9Md7tikzVJjhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771251180; c=relaxed/simple;
	bh=EStq2QD0H0mA/UsByWuRWqrjFkq14BjC8hjk5PPIczM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGiMU/IrHJ3WUisB3qBPknkgaZKVUG3s8gCm2tP8TOxMWyBM+iVjLuBnWvW5bfE4jj9QagDFPUswM5T6DVRSbQMmBHsetFnlhK0vO+a58FRcI6Q36iqVQaAL4mH7Rz0XH1v8INgWn5TOcxsA8WRNGXxXyKH2xFO/K5MVyvGzF64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzgatof2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzgatof2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC4EC116C6;
	Mon, 16 Feb 2026 14:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771251179;
	bh=EStq2QD0H0mA/UsByWuRWqrjFkq14BjC8hjk5PPIczM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzgatof2hRaZf6okmOOMQslNNV9opIOqczEdLXspaQBkgF0/LJq6vY3YKOFnSkYGl
	 Up3oI4B39konVYUDuCTYHQslk9hzIK+2FnYYIq3ILlUWR+5R+AsH50KpcvHSVRNOQ2
	 rHnpVpWjATbXEKNhRJlC/+bstMA4/vmPtea8yroscUrXckE1pNuioR6Orp3RXz6daE
	 PUGGAxTMjvr4v0K+jE7WLqKn7+XoppqJLb7OHET5T04BAQvmRJ41Ax84RPp6I+4GwG
	 E7BwmCMIKm3xmBRBuP6aFGYB0JFsA0UpZkDUpyFpgWmSTJ8JJhTYNaYo9AOmoi2qIJ
	 u4bavAOTvPsOw==
Date: Mon, 16 Feb 2026 15:12:53 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	heiko@sntech.de, kishon@kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, shawn.lin@rock-chips.com,
	Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, ntb@lists.linux.dev
Subject: Re: [PATCH v7 5/9] PCI: dwc: ep: Expose integrated eDMA resources
 via EPC aux-resource API
Message-ID: <aZMl5SVsF_mzEsNT@ryzen>
References: <20260215163847.3522572-1-den@valinux.co.jp>
 <20260215163847.3522572-6-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215163847.3522572-6-den@valinux.co.jp>

On Mon, Feb 16, 2026 at 01:38:43AM +0900, Koichiro Den wrote:
> Implement the EPC aux-resource API for DesignWare endpoint controllers
> with integrated eDMA.
> 
> Report:
>   - DMA controller MMIO window (PCI_EPC_AUX_DMA_CTRL_MMIO)
>   - interrupt-emulation doorbell register (PCI_EPC_AUX_DOORBELL_MMIO),
>     including its Linux IRQ
>   - per-channel LL descriptor regions (PCI_EPC_AUX_DMA_CHAN_DESC)
> 
> If the DMA controller MMIO window is already exposed via a
> platform-owned fixed BAR subregion, also provide the BAR number and
> offset so EPF drivers can reuse it without reprogramming the BAR.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 7e7844ff0f7e..ffd2797b7b81 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -808,6 +808,154 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
>  	return ep->ops->get_features(ep);
>  }
>  
> +static const struct pci_epc_bar_rsvd_region *
> +dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
> +				enum pci_epc_bar_rsvd_region_type type,
> +				enum pci_barno *bar,
> +				resource_size_t *bar_offset)
> +{
> +	const struct pci_epc_features *features;
> +	const struct pci_epc_bar_desc *bar_desc;
> +	const struct pci_epc_bar_rsvd_region *r;
> +	int i, j;
> +
> +	if (!ep->ops->get_features)
> +		return NULL;
> +
> +	features = ep->ops->get_features(ep);
> +	if (!features)
> +		return NULL;
> +
> +	for (i = BAR_0; i <= BAR_5; i++) {
> +		bar_desc = &features->bar[i];
> +
> +		if (!bar_desc->nr_rsvd_regions || !bar_desc->rsvd_regions)
> +			continue;
> +
> +		for (j = 0; j < bar_desc->nr_rsvd_regions; j++) {
> +			r = &bar_desc->rsvd_regions[j];
> +
> +			if (r->type != type)
> +				continue;
> +
> +			if (bar)
> +				*bar = i;
> +			if (bar_offset)
> +				*bar_offset = r->offset;
> +			return r;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static int
> +dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			     struct pci_epc_aux_resource *resources,
> +			     int num_resources)
> +{
> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	const struct pci_epc_bar_rsvd_region *rsvd;
> +	struct dw_edma_chip *edma = &pci->edma;
> +	enum pci_barno dma_ctrl_bar = NO_BAR;
> +	int ll_cnt = 0, needed, idx = 0;
> +	resource_size_t db_offset = edma->db_offset;
> +	resource_size_t dma_ctrl_bar_offset = 0;
> +	resource_size_t dma_reg_size;
> +	unsigned int i;
> +
> +	if (!pci->edma_reg_size)
> +		return 0;
> +
> +	dma_reg_size = pci->edma_reg_size;
> +
> +	for (i = 0; i < edma->ll_wr_cnt; i++)
> +		if (edma->ll_region_wr[i].sz)
> +			ll_cnt++;
> +
> +	for (i = 0; i < edma->ll_rd_cnt; i++)
> +		if (edma->ll_region_rd[i].sz)
> +			ll_cnt++;
> +
> +	needed = 1 + ll_cnt + (db_offset != ~0 ? 1 : 0);
> +
> +	/* Count query mode */
> +	if (!resources || !num_resources)
> +		return needed;
> +
> +	if (num_resources < needed)
> +		return -ENOSPC;
> +
> +	rsvd = dw_pcie_ep_find_bar_rsvd_region(ep,
> +					       PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO,
> +					       &dma_ctrl_bar,
> +					       &dma_ctrl_bar_offset);
> +	if (rsvd && rsvd->size < dma_reg_size)
> +		dma_reg_size = rsvd->size;
> +
> +	/* DMA register block */
> +	resources[idx++] = (struct pci_epc_aux_resource) {
> +		.type = PCI_EPC_AUX_DMA_CTRL_MMIO,
> +		.phys_addr = pci->edma_reg_phys,
> +		.size = dma_reg_size,
> +		.bar = dma_ctrl_bar,
> +		.bar_offset = dma_ctrl_bar_offset,
> +	};
> +
> +	/*
> +	 * For interrupt-emulation doorbells, report a standalone resource
> +	 * instead of bundling it into the DMA controller MMIO resource.
> +	 */
> +	if (db_offset != ~0) {
> +		if (dma_reg_size < sizeof(u32) ||
> +		    db_offset > dma_reg_size - sizeof(u32))

In your other patch, you used:

	if (size_add(offset, sizeof(u32)) > epf->bar[bar].size)

For consistency, do you perhaps want to use the same here?

size_add(db_offset, sizeof(u32)) > dma_reg_size ?




Kind regards,
Niklas
