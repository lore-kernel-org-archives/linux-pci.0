Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792658579;
	b=OTdhyezqIvR0HoPPPoB0yikA4Xi9tIlMvw6VkyclCjcLwmd20pAe1B6Sa2c1WNVLpYpa
	 Q7I4+n6Lv5TUjjXT6vlBLeDlrksswA/ZtLOPOFEIZiV0r/hj4ba5q9ZS6Rj3S5CtTlxZt
	 fIzp33a8CPS5VPGv4LVTornpipeUvDHkg67vLyBKI+/Ne0e1Reoj+UUyAS5Au35WwLkun
	 bKkmZpVTk3p07Sxpm92ydeIdbhESb2LuSwbPM4eifLa1gB/KlqLwfQqY0nbBJdFyvRAtG
	 ki9AbV+3yUvEDGjeXh/lF7CaaFI2Yp7idDXAoRv5nP5YPdOyaV3KVUA1PZpHKrUwrSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658579;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zW0WzvfvmiMpzzzA6KT+YynSiUOsdWG5AwK3bO2wpI4=;
	b=AmwmtM+YstsEcp+I9AvbVDb23/JY4gdeH68Vx8Bf25B/xFlY3CV6jSKTYJOEMAhQ4Zug
	 ufJX9YNi5KZZmDntidpW4q8PYDRzfc3/nHsSGAt3HYRIlCgyHPJOu2iKfdmQ4j6NFEjLZ
	 cez/AcFGR0mZWqqZhmXBcsjg/ewLEfvmTumsZm1RyHgOYR+boDIIvVsnFFWdS7UcUNkGI
	 +sh3DPvqvYn6TC0mUZ5H9jtO0nbS+OowhAv+4/ytE40yfecTiRtpfJk6w6CinclvbCB70
	 goEqkNQl36UaEkYnDiFmJjdat8ManCXwkwfSf0epCYwA1euRTJdCaISE/HlGC2Ky+ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0HT7j65;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA3F606A319;
	Thu, 22 Oct 2026 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0HT7j65
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1FE1F000C1;
	Thu, 22 Oct 2026 08:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792658578;
	bh=zW0WzvfvmiMpzzzA6KT+YynSiUOsdWG5AwK3bO2wpI4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e0HT7j65zoJ8vQ+9YIF9UxmBxenDgfaktGVrweAs2Od/S9Fw5FD5yKg8hzsxWEyBX
	 kR/bqdaXrHN6XRwZyo3tLr6WpZxe0MjHfBM7FJ/119juUjJdZwmub7ZUnCWB1nbljm
	 5ca7xVpQT4AiagNHq/Fde7uV4zWTs8K8mtvDYC0qrF5AEgU4Viovu+xFdZzSWt0O7E
	 sgASxCrY9Z6mR5vGIes6qG5YHL1CWsvUd35VEHJ9QRAaHTuXF3n68Ul9UfqdTPuxP5
	 S5uh2UaENBy13hft5ROGfU9H/ncON8nVgw4VC0dtqmqLaoSXG2zO6qxfOEB8ACIjBK
	 jm9sJJLgPUSsA==
Message-ID: <sashiko-outbox-181198@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/10] PCI: dwc: Expose endpoint DMA resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20261022082230.3164834-3-den@valinux.co.jp>
References: <20261022082230.3164834-1-den@valinux.co.jp>
 <20261022082230.3164834-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 08:42:57 +0000
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
- [Medium] PCI: dwc: stale edma->dw in dw_pcie_ep_get_aux_resources() after=
 eDMA removal
--

commit 9475ea2f70e5c9c7b09a2bc537c0f97a6e428f7f
Author: Koichiro Den <den@valinux.co.jp>

PCI: dwc: Expose endpoint DMA resources

This commit exposes the endpoint-integrated eDMA register window and
linked-list memory regions via the EPC auxiliary resource API. It also
checks that the local dw-edma device is registered and rejects virtual
function queries.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index 630ba172280c2..7166ec7f212bd 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
[ ... ]
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
> =20
> -	return 1;
> +	ll_wr_cnt =3D edma->ll_wr_cnt;
> +	ll_rd_cnt =3D edma->ll_rd_cnt;
> +
> +	if (!edma->cfg_non_ll)
> +		count +=3D 1 + ll_wr_cnt + ll_rd_cnt;
> +
> +	if (edma->db_offset !=3D ~0)
> +		count++;
> +
> +	return count;
>  }
> =20
>  static int
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
> +
> +	ll_wr_cnt =3D edma->ll_wr_cnt;
> +	ll_rd_cnt =3D edma->ll_rd_cnt;
> +	db_offset =3D edma->db_offset;
> +	has_ll =3D !edma->cfg_non_ll;
> +
> +	count =3D db_offset !=3D ~0;
> +	if (has_ll)
> +		count +=3D 1 + ll_wr_cnt + ll_rd_cnt;

[Severity: Medium]
Can edma->dw remain a non-NULL stale pointer here after the local dw-edma
device has been unregistered?

Both dw_pcie_ep_get_aux_resources_count() and dw_pcie_ep_get_aux_resources()
check edma->dw to verify that the local dw-edma device is registered before
exposing PCI_EPC_AUX_DMA_CTRL_MMIO and PCI_EPC_AUX_DMA_DESC_MEM resources.

However, when the eDMA device is torn down via dw_pcie_edma_remove() ->
dw_edma_remove(), either on the err_remove_edma error path in
dw_pcie_ep_init_registers():

drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_init_registers()=
 {
	...
err_remove_edma:
	dw_pcie_edma_remove(pci);

	return ret;
}

or during fundamental reset in dw_pcie_ep_cleanup():

drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_cleanup() {
	...
	dwc_pcie_debugfs_deinit(pci);
	dw_pcie_edma_remove(pci);
}

dw_edma_remove() in drivers/dma/dw-edma/dw-edma-core.c unregisters the DMA
device (and resets chip->db_offset =3D ~0 via dw_edma_emul_irq_free()), but
neither dw_edma_remove() nor dw_pcie_edma_remove() clears chip->dw:

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

If an endpoint function driver subsequently queries
pci_epc_get_aux_resources_count() and pci_epc_get_aux_resources() while the
eDMA device is unregistered, wouldn't the !edma->dw check pass and expose
DMA control MMIO and linked-list descriptor resources for a removed eDMA
instance?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022082230.3164=
834-1-den@valinux.co.jp?part=3D2
