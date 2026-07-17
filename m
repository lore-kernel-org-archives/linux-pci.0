Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385373793A8
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 05:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784265593; cv=none; b=LlBpVk7qn8UR9EMfDC1jHyFBkjE6jfacgUCq/DYUb8ey58AmPzLBrgAqdtpTU0rdfXk90RhDcpusCaeYqtBQ5tjnfz78i2M4Pum4uOHZlLU1vhU9j+TTXrc2nKY90NKtbCiCGqz5D1xaqutw1NLkyUIpwbIr1e1XLNqDyxQn+UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784265593; c=relaxed/simple;
	bh=LQnH+r7O+xQHTxgE9FONp25Lmj7LJBtj+XKMe6HREp0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XrqMBWB4TlOxJFKuuOdo6ql6JqweiCwfo1+/vs68jeCCFqZGNW1vLsoUaA2pAKLS+GO2sUwnanqjPNdNc6ADztfW/v0nR10NPkVcqiCgatW0PbSIpLYsXCS3dUDaO8T0aUnFVAusgRpfyLN2EIi/g8spd0o2Ppvw5gOGK7YwFbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWM+3gw7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWM+3gw7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC741F000E9;
	Fri, 17 Jul 2026 05:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784265590;
	bh=r2aZIWk+zIR0d+8CNmf457wcaUnlhf7H0w095bkKmx4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eWM+3gw7Wi0AafhyzreHzW1+MarpYo5/B8uzihfC1wDlOYYzh2waM5eMrXZUGh9ZS
	 Mw12tAiOrgSF34w00Q3ZHsGgJ5Y6lUTJiLMMpNj5y8wsaO9kFKEIpFzc+21Ym8zh8t
	 KCj/oRBIMEjddNxNe1Lzq2Gm/xkn8leASvXrh6lQzXjAbaQjsfvWqYjL5njV0hh483
	 FagGK1wMsmV0YbWHVSJAHdiW4s/Kip7Vq87GVCj7utsjDGdu5thZw90m+YLXkEu6XD
	 c5adWxjiZmPHU1FW6RJyHo94FYqBowNhgvPF+ziPDKsvjOdQP5JgKaL4f2NjLafrrJ
	 QapSUsOUKhqLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/6] PCI: dwc: Expose endpoint DMA resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260717050635.2145014-5-den@valinux.co.jp>
References: <20260717050635.2145014-1-den@valinux.co.jp>
 <20260717050635.2145014-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 05:19:49 +0000
Message-Id: <20260717051950.2CC741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] TOCTOU race condition and lockless access of `edma` state lead=
s to kernel heap buffer overflow.
- [High] Missing implementation of `delegate_dma_chan` and `reclaim_dma_cha=
n` in `pci_epc_ops` makes exposed DMA channels unusable.
--

--- Patch [4]: [PATCH v5 4/6] PCI: dwc: Expose endpoint DMA resources ---
commit 0cf8b17e421eb425ac8f9d3f97c02af0eb190199
Author: Koichiro Den <den@valinux.co.jp>

PCI: dwc: Expose endpoint DMA resources

Expose the DesignWare endpoint-integrated eDMA register window, logical
DMA channels, and linked-list descriptor memories through the EPC
auxiliary resource API. Expose DMA controller and channel resources only
after the local DW eDMA provider has been registered.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index 7d2794945704e..ef1e2b6d85cf3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c

[ ... ]

> @@ -865,14 +895,23 @@ dw_pcie_ep_get_aux_resources_count(struct pci_epc *=
epc, u8 func_no,
>  	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>  	struct dw_edma_chip *edma =3D &pci->edma;
> +	int ret;
> +	int count =3D 0;
> =20
>  	if (!pci->edma_reg_size)
>  		return 0;
> =20
> -	if (edma->db_offset =3D=3D ~0)
> -		return 0;
> +	ret =3D dw_pcie_ep_check_edma_vfunc(vfunc_no);
> +	if (ret)
> +		return ret;
> =20
> -	return 1;
> +	if (dw_pcie_ep_has_edma_ll_resources(edma))
> +		count +=3D 1 + 2 * (edma->ll_wr_cnt + edma->ll_rd_cnt);
> +
> +	if (edma->dw && edma->db_offset !=3D ~0)
> +		count++;

[Severity: Critical]
Is it possible for edma->dw to change concurrently here (e.g. if the link
state changes and dw_edma_probe() completes), leading to an inconsistent
count and a buffer overflow in dw_pcie_ep_get_aux_resources() below?

If edma->dw is NULL during dw_pcie_ep_has_edma_ll_resources(), but becomes
non-NULL before the second check, count will be evaluated as 1.

> +
> +	return count;
>  }
> =20
>  static int
> @@ -888,6 +927,8 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 =
func_no, u8 vfunc_no,
>  	resource_size_t db_offset =3D edma->db_offset;
>  	resource_size_t dma_ctrl_bar_offset =3D 0;
>  	resource_size_t dma_reg_size;
> +	bool has_edma_ll_resources;
> +	unsigned int i;
>  	int count;
> =20
>  	count =3D dw_pcie_ep_get_aux_resources_count(epc, func_no, vfunc_no);
> @@ -901,6 +942,7 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 =
func_no, u8 vfunc_no,
>  		return 0;
> =20
>  	dma_reg_size =3D pci->edma_reg_size;
> +	has_edma_ll_resources =3D dw_pcie_ep_has_edma_ll_resources(edma);

[Severity: Critical]
Since count could be calculated as 1 earlier, the bounds check
(num_resources < count) passes. However, has_edma_ll_resources is
re-evaluated here.=20

If edma->dw is now non-NULL, this evaluates to true, and the function
will write 1 + 2 * (wr_cnt + rd_cnt) elements into the resources array which
may only be sized for 1 element, causing an out-of-bounds write.

[ ... ]

> @@ -917,7 +1029,7 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8=
 func_no, u8 vfunc_no,
>  				  sizeof(u32), dma_reg_size))
>  		return -EINVAL;
> =20
> -	resources[0] =3D (struct pci_epc_aux_resource) {
> +	resources[count] =3D (struct pci_epc_aux_resource) {
>  		.type =3D PCI_EPC_AUX_DOORBELL_MMIO,
>  		.phys_addr =3D pci->edma_reg_phys + db_offset,
>  		.size =3D sizeof(u32),

[Severity: High]
This patch exposes DMA channels via dw_pcie_ep_get_aux_resources(), but does
epc_ops also need to implement the delegate_dma_chan and reclaim_dma_chan
callbacks?

Without these callbacks in epc_ops, if an EPF driver attempts to reserve one
of these newly exposed DMA channels by calling pci_epc_delegate_dma_chan(),
will it immediately fail with -EOPNOTSUPP?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717050635.2145=
014-1-den@valinux.co.jp?part=3D4
