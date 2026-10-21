Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792557819;
	b=mhN+Gl71bCSavqVvoX9GltMkbgVP7xYjGs0CnyVg9CghPHyOY9QrVPZdP8PjI70qotoT
	 GU8Aedv+N7wErXkA/lb/oMAaOF37XJQQVJEwWKHGUXXCelVWHxPMcYOAes+YAqN3iqHKi
	 1R1QI8oHhMd73ZlWjR6H5tRj2gW6/0lAgwlA8T9rsVKOLYDhaR5XXOQ7yJGi9Sieh6lCz
	 Tbs0KE1A5zp/eX0N7RQa1ZTaqt7n1D/TqKlI2dl77G0/UjjsrEqI8tAHUZx6X1S6Qh4S+
	 7Qviou6adEc5IZF1q7f+pCe4kKulYDNZryIOZGMiT8eJrkQBZDYs3Slx+VcMk9AxOBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792557819;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QHlN66bGmR/3DgAsRMtNfcpHXFZM7mRM0lkWf82RG1E=;
	b=DG3qDqrqLZvHRTegZG5gvfArT8U7xiw6wVSCde86qXUtrXE1nnnbKo5tPX3ZdodbT3ZC
	 LWfLrBcGoiwcE8vsxQtp3pNHr1dlxbQTj48GaPUrgh9aj/NCnO7Ei6aRaMeDOvuOLJT8P
	 Tw5G2nU/I0VCXG2N3tPBhr+qE4ogqdvH1jGLSVNlnXrpieCoGO5ho6auxZbEsAnqXGRWp
	 bVOm09p9UcnYOcv0WwMnU4GqZ4si9RQCLMbcaVLEp6vjVr/KNocwAjM3m0CEA78+ou3OR
	 FFwIIniGk59qBtnxsEoZ1jiZ14RanyrUdzHjdV3fd652YuO7vzABkV0VKObWSYLl3XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyhC3sxR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E0606A319;
	Wed, 21 Oct 2026 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyhC3sxR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EAC1F000C9;
	Wed, 21 Oct 2026 04:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792557819;
	bh=QHlN66bGmR/3DgAsRMtNfcpHXFZM7mRM0lkWf82RG1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SyhC3sxR+XH9Jp4/5QxReY30DMz1s66Vei/i0YxU9y7mFMfW7hAO6d8t9aBjb+rZa
	 g6+wxzPwYg2oDoCnJPeBsp2Wa8V8G094wNryU4Tu74XmaH8po4BUFBxHTVpqq98S+p
	 bb1BZdM399htUG35GgX+F32k0IV7dXjvgo7ezSPDR0IyaaWg3MzNnD5BSvkGWVYNmP
	 nr7QcllfaoZYr2JmCiz1ZsT6bgZN2FQTPe7/eZ5oi2yOGXC/4AXOC7ABcIUgUIxxLb
	 Vs+CM77qsRSV/IJiL1S/NuiTM+mmi7PdJEFVf5lrlhnSuhTnp9yEPYIr96hcUaTz8M
	 UYLHsghNFnEvw==
Message-ID: <sashiko-outbox-179793@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/10] PCI: endpoint: pci-epf-vntb: Allow DMA and MW
 to share a BAR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20261021042229.2280937-7-den@valinux.co.jp>
References: <20261021042229.2280937-1-den@valinux.co.jp>
 <20261021042229.2280937-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 04:43:38 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] PCI: pci-epf-vntb: wrong alignment reporting in vntb_epf_mw_get_al=
ign()
- [Medium] PCI: pci-epf-vntb: unaligned MW offset in epf_ntb_dw_edma_collec=
t()
- [Medium] PCI: pci-epf-vntb: broken BAR validation in epf_ntb_dw_edma_coll=
ect()
--

commit 79eb04af128c16e4dcc089f5decfc0f781ca41df
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: pci-epf-vntb: Allow DMA and MW to share a BAR

This commit allows the endpoint DMA BAR (dma_bar) to share a BAR with a
memory window by placing the DMA submap regions after the configured MW
region. It also updates MW alignment reporting and requires the host to
advertise MW/DMA boundary support during LINK_UP.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index ac83af54122f7..721cd841a1dd8 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c

[ ... ]

> @@ -229,6 +230,22 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
>  	return false;
>  }
> =20
> +static u64 epf_ntb_dma_bar_offset(struct epf_ntb *ntb, enum pci_barno ba=
rno)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < ntb->num_mws; i++)
> +		if (ntb->epf_ntb_bar[BAR_MW1 + i] =3D=3D barno)
> +			return ntb->mws_size[i];
> +
> +	return 0;
> +}
> +
> +static bool epf_ntb_dma_shares_bar(struct epf_ntb *ntb, enum pci_barno b=
arno)
> +{
> +	return ntb->dma && ntb->epf_ntb_bar[BAR_DMA] =3D=3D barno;
> +}
> +
>  struct epf_ntb_dma_filter {
>  	struct device *dev;
>  	int chan_id;
> @@ -353,6 +370,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *nt=
b,
>  	unsigned int i;
>  	size_t align;
>  	u32 next =3D 0;
> +	u64 offset;
>  	int ret;
> =20
>  	if (ctrl->u.dma_ctrl.reg_layout_data !=3D EDMA_MF_EDMA_UNROLL)
> @@ -371,9 +389,30 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *n=
tb,
>  	if (!is_power_of_2(align))
>  		return -EINVAL;
> =20
> -	if (epf_ntb_is_bar_used(ntb, barno) ||
> -	    pci_epc_get_next_free_bar(features, barno) !=3D barno)
> +	if (barno =3D=3D ntb->epf_ntb_bar[BAR_CONFIG] ||
> +	    barno =3D=3D ntb->epf_ntb_bar[BAR_DB])
> +		return -EINVAL;
> +
> +	offset =3D epf_ntb_dma_bar_offset(ntb, barno);
> +	if (!offset &&
> +	    (epf_ntb_is_bar_used(ntb, barno) ||
> +	     pci_epc_get_next_free_bar(features, barno) !=3D barno))
> +		return -EINVAL;

[Severity: Medium]
When a shared BAR is configured (offset !=3D 0), gating
pci_epc_get_next_free_bar(features, barno) !=3D barno under !offset skips t=
he
EPC BAR validity check in epf_ntb_dw_edma_collect().

If both mwX_bar and dma_bar are explicitly configured to the same BAR number
via configfs, epf_ntb_find_bar() skips its loop because
ntb->epf_ntb_bar[bar] is already non-negative:

drivers/pci/endpoint/functions/pci-epf-vntb.c:epf_ntb_find_bar() {
	while (ntb->epf_ntb_bar[bar] < 0) {
		barno =3D pci_epc_get_next_free_bar(epc_features, barno);
		if (barno < 0)
			break; /* No more BAR available */

		if (ntb->epf_ntb_bar[BAR_DMA] !=3D barno &&
		    !epf_ntb_is_bar_used(ntb, barno))
			ntb->epf_ntb_bar[bar] =3D barno;

		barno +=3D 1;
	}
}

Because epf_ntb_mw_bar_init() also skips pci_epc_set_bar() when shared is
true, nothing verifies that barno is not BAR_RESERVED, BAR_DISABLED, or an
upper 32-bit slot of a preceding 64-bit BAR. In addition,
epf_ntb_dma_bar_offset() returns the first matching MW size without checking
whether multiple MWs were assigned to the same BAR, and epf_ntb_find_bar()
still skips ntb->epf_ntb_bar[BAR_DMA] when auto-assigning MW BARs.

Should pci_epc_get_next_free_bar(features, barno) !=3D barno be checked
unconditionally in epf_ntb_dw_edma_collect(), and should duplicate MW BAR
assignments and auto-assignment in epf_ntb_find_bar() be handled for shared
BARs?

> +	if (offset > U32_MAX)
> +		return -EOVERFLOW;
> +	if (offset && !is_power_of_2(offset))
>  		return -EINVAL;
> +	dma->ctrl.submap.offset =3D offset;
> +	next =3D offset;
> +	if (next) {
> +		/*
> +		 * submap[0] covers the MW prefix. Keep its temporary
> +		 * target at address 0 until the MW translation is
> +		 * installed.
> +		 */
> +		dma->submap[0].size =3D next;
> +		dma->num_submap =3D 1;
> +	}

[Severity: Medium]
What happens if offset is a power of two that is smaller than align
(features->align, which is 16 KiB or 64 KiB on several DesignWare PCIe
endpoint controllers)?

In epf_ntb_dw_edma_collect(), offset is checked with is_power_of_2(offset),
but not with IS_ALIGNED(offset, align). If an MW size such as SZ_4K is
configured on an EPC with a 64 KiB region_align, dma->submap[0].size and the
starting BAR offset next for subsequent DMA submaps will not be aligned to
align, and backing_size in epf_ntb_dma_bar_init() will also be unaligned.

When epf_ntb_dma_set_bar() or vntb_epf_mw_set_trans() later calls
epf_ntb_dma_set_bar_locked() -> pci_epc_set_bar(),
dw_pcie_ep_validate_submap() rejects the submap array:

drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_validate_submap(=
) {
	for (i =3D 0; i < num_submap; i++) {
		size =3D submap[i].size;

		if (!size)
			return -EINVAL;

		if (!IS_ALIGNED(size, align) || !IS_ALIGNED(off, align))
			return -EINVAL;
}

Could epf_ntb_dw_edma_collect() also check !IS_ALIGNED(offset, align) before
accepting offset?

[ ... ]

> @@ -551,7 +592,7 @@ static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
>  		return -EOPNOTSUPP;
> =20
>  	barno =3D ntb->epf_ntb_bar[BAR_DMA];
> -	mapped_size =3D dma->ctrl.submap.size;
> +	mapped_size =3D dma->ctrl.submap.offset + dma->ctrl.submap.size;
>  	/*
>  	 * Submaps cannot be installed until the host assigns the BAR address.
>  	 * Use address 0 for the temporary BAR Match Mode mapping, as is done

[ ... ]

> @@ -1936,6 +2008,16 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *n=
dev, int pidx, int idx,
>  	dev =3D &ndev->dev;
>  	barno =3D ntb->epf_ntb_bar[BAR_MW1 + idx];
>  	epf_bar =3D &ntb->epf->bar[barno];
> +	if (epf_ntb_dma_shares_bar(ntb, barno)) {
> +		/* DMA submaps start after the configured MW size. */
> +		if (size !=3D ntb->mws_size[idx])
> +			return -EINVAL;
> +
> +		guard(mutex)(&ntb->dma->lock);
> +
> +		return epf_ntb_dma_set_bar_locked(ntb, &addr);
> +	}
> +
>  	epf_bar->phys_addr =3D addr;
>  	epf_bar->barno =3D barno;
>  	epf_bar->size =3D size;
> @@ -2134,15 +2216,17 @@ static int vntb_epf_mw_get_align(struct ntb_dev *=
ndev, int pidx, int idx,
>  			resource_size_t *size_max)
>  {
>  	struct epf_ntb *ntb =3D ntb_ndev(ndev);
> +	enum pci_barno barno =3D ntb->epf_ntb_bar[BAR_MW1 + idx];
> +	u64 size =3D ntb->mws_size[idx];
> =20
>  	if (addr_align)
>  		*addr_align =3D SZ_4K;
> =20
>  	if (size_align)
> -		*size_align =3D 1;
> +		*size_align =3D epf_ntb_dma_shares_bar(ntb, barno) ? size : 1;
> =20
>  	if (size_max)
> -		*size_max =3D ntb->mws_size[idx];
> +		*size_max =3D size;
> =20
>  	return 0;
>  }

[Severity: High]
Can reporting *size_align =3D size while keeping *addr_align =3D SZ_4K in
vntb_epf_mw_get_align() cause an oversized inbound BAR mapping or an
unaligned submap physical address in vntb_epf_mw_set_trans()?

In drivers/ntb/ntb_transport.c:ntb_set_mw(), the translation size and the
allocated buffer size are rounded using different alignment values:

	rc =3D ntb_mw_get_align(nt->ndev, PIDX, num_mw, &xlat_align,
			      &xlat_align_size, NULL);
	if (rc)
		return rc;

	xlat_size =3D round_up(size, xlat_align_size);
	buff_size =3D round_up(size, xlat_align);

When the requested size (from the peer's MW size scratchpad or max_mw_size)
is smaller than ntb->mws_size[idx], ntb_set_mw() allocates only buff_size
(rounded to SZ_4K) but calls ntb_mw_set_trans() -> vntb_epf_mw_set_trans()
with xlat_size =3D=3D ntb->mws_size[idx]. vntb_epf_mw_set_trans() then maps=
 the
full ntb->mws_size[idx] window in dma->submap[0] starting at mw->dma_addr,
exposing memory past the end of the allocated buffer to the remote PCIe hos=
t.

Furthermore, when vntb_epf_mw_set_trans() installs addr into
dma->submap[0].phys_addr, dw_pcie_ep_validate_submap() requires
IS_ALIGNED(submap[0].phys_addr, align) where align is features->align. On
controllers where features->align > SZ_4K, buffers allocated by NTB clients
using *addr_align =3D SZ_4K can fail validation in pci_epc_set_bar() with
-EINVAL.

Should vntb_epf_mw_get_align() ensure *addr_align accounts for both
features->align and the shared MW size requirements?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021042229.2280=
937-1-den@valinux.co.jp?part=3D6
