Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792557481;
	b=iq7vnu3NhkqTtksw6RgEn1rGv7nOggVZCYSR/J0WtLJjSavW5wuksxV988dfWVTyKm1I
	 eh3YBuZ1J8tUxC3SwE/JlCExnEbAlIG+ELtZ6KWbs+3GfVtkjUA/cAjqLLaAc5RthO6Lc
	 sFeSPdHUNeXHx7F+jfcLMdIjF8QJQHve7wiFcj/LFglT8uuYYboKvLjgkH+TICuaMe6KB
	 SsY+wBywfcn6OwRdoWj3yVwWQpDOO26KPQby6NyuPo1R+1tHEa2sxrnTxMUIN2RMzkbml
	 nPhVDbIZXb3PWvaGZbq2e+O5t92iRy7cSAXDgwRIL6KPEuZK5zZoi8fhz7uu8myo3Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792557481;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NPJOeY1lTtFyAtY+BqV2s3cUvU2z/pD/gVYpH5C5MKA=;
	b=KWiff1w87crsJv7puYdOPL+EILIo97KtarzmPM+570S/HxwxOC4OikljI0Ux9kRMxFq1
	 MH/InWOKc/iP6qOEzejSLL8aV/AAYizWBUm82bkbGKPE9UE9hKUoNzPTL2ymAXkJ9fKY4
	 YQUd1pfqk6dHO2nsIcu5DDHOCIFocEXydHArMUjR1phPDzGo0mGvBXM+CWfJJiAfVG3ol
	 3UkPdH0oRiI3d76BjDN4H6tRX9Y8xRqRi3MnhIOLB8k+7DXvtLdIhq/SRTRSw0zT0sNHI
	 aabPJxr07WrWzja0H31ML6lWnjHhUQeGw8VejWHr2TksPq76c2qbQec2/QObersNw0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWQk24Jn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66391606A319;
	Wed, 21 Oct 2026 04:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWQk24Jn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF55B1F000C9;
	Wed, 21 Oct 2026 04:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792557481;
	bh=NPJOeY1lTtFyAtY+BqV2s3cUvU2z/pD/gVYpH5C5MKA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FWQk24JncHsAtN4A/08n+BONYeFH5wOgS4TxF0CvnWmp9xDvux8DHcBwoc/vCc2b/
	 D6v/u4Roteh6V0EYvdHyh4RbCX0RkGM5Vu0QQvPwHgYE8LA0sZr9WVrUfond06HdGY
	 exh11nHclXKgfCmlP58PbQ3VohGQPwKsVuI+iDfJdWUbmEYX/57apvsKSvVD8V55h7
	 G+Q0BLvK1khLLvGMISrhvSqyYTJRANRgc5OVvZa4t2du+m52Ta+Bi6GrOkndES20h9
	 J2A1laeodPWp4UQwjGM766mAYX9CuAobQzRwR/hF0xLwFeCTUc9dA2lLTVkMJtotAa
	 iResu9LiuyE3Q==
Message-ID: <sashiko-outbox-179790@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/10] PCI: dwc: Expose endpoint DMA resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20261021042229.2280937-3-den@valinux.co.jp>
References: <20261021042229.2280937-1-den@valinux.co.jp>
 <20261021042229.2280937-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 04:38:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] PCI: dwc: edma->dw remains non-NULL after dw_pcie_edma_remove()
--

commit c234b2198cdf6bace1b7fdf24f49b374e8b18f28
Author: Koichiro Den <den@valinux.co.jp>

PCI: dwc: Expose endpoint DMA resources

This commit exposes the endpoint-integrated eDMA register window and
linked-list descriptor memory regions through the EPC auxiliary resource AP=
I.
It also updates the auxiliary resource queries to reject VF requests and ch=
eck
whether the local dw-edma device is registered before reporting resources.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index 630ba172280c2..7166ec7f212bd 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -858,6 +858,15 @@ dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *e=
p,
>  	return NULL;
>  }
> =20
> +static int dw_pcie_ep_check_edma_vfunc(u8 vfunc_no)
> +{
> +	/*
> +	 * The DWC endpoint databook says it is not possible to assign the
> +	 * DMA/HDMA registers to any Virtual Function.
> +	 */
> +	return vfunc_no ? -EOPNOTSUPP : 0;
> +}
> +
>  static int
>  dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
>  				   u8 vfunc_no)
> @@ -865,14 +874,30 @@ dw_pcie_ep_get_aux_resources_count(struct pci_epc *=
epc, u8 func_no,
>  	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>  	struct dw_edma_chip *edma =3D &pci->edma;
> +	u16 ll_wr_cnt, ll_rd_cnt;
> +	int count =3D 0;
> +	int ret;
> =20
>  	if (!pci->edma_reg_size)
>  		return 0;
> =20
> -	if (edma->db_offset =3D=3D ~0)
> +	ret =3D dw_pcie_ep_check_edma_vfunc(vfunc_no);
> +	if (ret)
> +		return ret;
> +
> +	if (!edma->dw)
>  		return 0;

[Severity: Medium]
Can edma->dw remain non-NULL after the local dw-edma device has been
unregistered?

Both dw_pcie_ep_get_aux_resources_count() and dw_pcie_ep_get_aux_resources()
in drivers/pci/controller/dwc/pcie-designware-ep.c check edma->dw to verify
that the local dw-edma device is registered before reporting DMA resources.

However, when the eDMA device is unregistered via dw_pcie_edma_remove() ->
dw_edma_remove(), such as in dw_pcie_ep_cleanup() during a fundamental reset
or on the err_remove_edma error path in dw_pcie_ep_init_registers():

drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_cleanup() {
	dwc_pcie_debugfs_deinit(pci);
	dw_pcie_edma_remove(pci);
}

drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_init_registers()=
 {
	...
err_remove_edma:
	dw_pcie_edma_remove(pci);

	return ret;
}

dw_edma_remove() in drivers/dma/dw-edma/dw-edma-core.c tears down the IRQs,
workqueue, and DMA device without clearing chip->dw:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_remove() {
	...
	/* Deregister eDMA device */
	dma_async_device_unregister(&dw->dma);
	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
				 vc.chan.device_node) {
		tasklet_kill(&chan->vc.task);
		list_del(&chan->vc.chan.device_node);
	}

	return err;
}

Because edma->dw and edma->ll_wr_cnt / edma->ll_rd_cnt remain populated aft=
er
dw_pcie_edma_remove(), won't subsequent calls to
dw_pcie_ep_get_aux_resources_count() and dw_pcie_ep_get_aux_resources() pass
the !edma->dw check and continue reporting PCI_EPC_AUX_DMA_CTRL_MMIO and
PCI_EPC_AUX_DMA_DESC_MEM resources for an unregistered dw-edma device?

[ ... ]

> @@ -885,14 +910,32 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u=
8 func_no, u8 vfunc_no,
>  	const struct pci_epc_bar_rsvd_region *rsvd;
>  	struct dw_edma_chip *edma =3D &pci->edma;
>  	enum pci_barno dma_ctrl_bar =3D NO_BAR;
> -	resource_size_t db_offset =3D edma->db_offset;
> +	resource_size_t db_offset;
>  	resource_size_t dma_ctrl_bar_offset =3D 0;
>  	resource_size_t dma_reg_size;
> -	int count;
> +	u16 ll_wr_cnt, ll_rd_cnt;
> +	bool has_ll;
> +	unsigned int i;
> +	int count, ret;
> =20
> -	count =3D dw_pcie_ep_get_aux_resources_count(epc, func_no, vfunc_no);
> -	if (count < 0)
> -		return count;
> +	if (!pci->edma_reg_size)
> +		return 0;
> +
> +	ret =3D dw_pcie_ep_check_edma_vfunc(vfunc_no);
> +	if (ret)
> +		return ret;
> +
> +	if (!edma->dw)
> +		return 0;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021042229.2280=
937-1-den@valinux.co.jp?part=3D2
