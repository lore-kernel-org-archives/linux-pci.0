Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482FE33CEA7;
	Thu,  2 Jul 2026 21:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027915; cv=none; b=EcXwYbMOY77vW+x4llrXpoInnYCzovUh1GEpOo3N1Wq0qPO/Lt/Of0TVPvzBUUNjv+wfW/VCfMnjDhA0rn2T8wRRXz/hA1GUvKN6Oy4ZkHjk2Q3zsqDS3djmrQd99gbZhHlgmVkIh5UlHukYvrkLuLRfBzihyF14N56j/Jjqygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027915; c=relaxed/simple;
	bh=xm6v90l40TEhqr3Tup0OlU+9z3OKIiJg4t1T9aCIFas=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oAbWspcTC/b38R+yAVa74Gj1jbD+/zCWBo08BGBI5VDZpymSj8G2RAk8CUDw//Qr7QVyZVIeAkUiZac3aVb8KgKnsFT5iZDA0x1dymeE4T8wOlS2MgP4AjQ59LpeH7ZWU864XCk/QFf46iunSdBuB8BoWlm/gEOt+l+kJ92eL9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8ruexqP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8ruexqP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4651F000E9;
	Thu,  2 Jul 2026 21:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783027913;
	bh=ewVV/GgiMVFmxR+Tri/xOgyBkJ7z55u3EEIsmz/7xRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e8ruexqPH14uofA0Tf1dhu9g2et3/BXN17y5tUb9+K6Lfd3KdBJ99zfJsviuxnN4d
	 YIPU4AgdXZmmMC6dxMDePDwxHKlT0KYafcl5b2mll+eCsvI5N4OLMF5+5RIJL7KsxM
	 rnAy94JR4GEChugBVCV9v3z5iG9WopzS8ugduplhCOFgJMhV3YCe9jYIwfra0RwU2I
	 +h/Emps+1mggJr/8mwhIIW5YxMXj8ddXTmzL5kYoP/wk7HN/cYurfR6bpALw8j4/mM
	 82dlySZiFUbJQFVlKMWBfmhnNjtQOS8dDz06Su+W0t2X9QjD1MVYCH3sngfxy0QiSZ
	 Si7hS7cWcv5uQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/10] dmaengine: dw-edma: Move control field update
 of DMA link to the last step
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260702-edma_ll-v3-1-877aa463740c@nxp.com>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
 <20260702-edma_ll-v3-1-877aa463740c@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 21:31:52 +0000
Message-Id: <20260702213153.9E4651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The DMA descriptor's `control` field is updated locklessly via p=
lain assignment, which can cause compiler store tearing and violate the mem=
ory write ordering guarantees intended by the patch.
--

commit f34c073c93dcf4643e941a0c9907083868d8f064
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Move control field update of DMA link to the last step

This commit moves the control field update to the end of the descriptor
programming sequence and adds a memory barrier. The goal is to ensure the
descriptor is fully written before the ready bit in the control field is
set, preparing the driver for concurrent descriptor updates while the DMA
is running.

> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/=
dw-edma-v0-core.c
> index cfdd6463252e6..ee5c3c317557b 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -284,17 +284,18 @@ static void dw_edma_v0_write_ll_data(struct dw_edma=
_chunk *chunk, int i,
>  	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
>  		struct dw_edma_v0_lli *lli =3D chunk->ll_region.vaddr.mem + ofs;
> =20
> -		lli->control =3D control;
>  		lli->transfer_size =3D size;
>  		lli->sar.reg =3D sar;
>  		lli->dar.reg =3D dar;
> +		dma_wmb();
> +		lli->control =3D control;

[Severity: Medium]
Could this plain assignment cause compiler store tearing and violate the
intended memory ordering?

Because struct dw_edma_v0_lli is __packed and lacks an explicit __aligned
attribute, the compiler assumes a 1-byte alignment. On architectures
compiled with strict alignment, this 32-bit assignment might be split into
four separate byte-sized stores.

If byte 0 is written first, the hardware could see the ready bit set
before the remaining control bits are written, bypassing the safety of the
preceding dma_wmb(). Would it be safer to use WRITE_ONCE() or a proper
accessor here to guarantee a single 32-bit store?

[ ... ]

> @@ -306,13 +307,14 @@ static void dw_edma_v0_write_ll_link(struct dw_edma=
_chunk *chunk,
>  	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
>  		struct dw_edma_v0_llp *llp =3D chunk->ll_region.vaddr.mem + ofs;
> =20
> -		llp->control =3D control;
>  		llp->llp.reg =3D pointer;
> +		dma_wmb();
> +		llp->control =3D control;

[Severity: Medium]
Does this assignment suffer from the same store tearing issue as the link
data descriptor above, given struct dw_edma_v0_llp is also __packed?

> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/=
dw-hdma-v0-core.c
> index 632abb8b481cf..1201f1ab5f359 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -160,17 +160,18 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma=
_chunk *chunk, int i,
>  	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
>  		struct dw_hdma_v0_lli *lli =3D chunk->ll_region.vaddr.mem + ofs;
> =20
> -		lli->control =3D control;
>  		lli->transfer_size =3D size;
>  		lli->sar.reg =3D sar;
>  		lli->dar.reg =3D dar;
> +		dma_wmb();
> +		lli->control =3D control;

[Severity: Medium]
Could the same store tearing occur here in dw_hdma_v0_write_ll_data,
since struct dw_hdma_v0_lli is also __packed?

[ ... ]

> @@ -182,13 +183,14 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma=
_chunk *chunk,
>  	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
>  		struct dw_hdma_v0_llp *llp =3D chunk->ll_region.vaddr.mem + ofs;
> =20
> -		llp->control =3D control;
>  		llp->llp.reg =3D pointer;
> +		dma_wmb();
> +		llp->control =3D control;

[Severity: Medium]
Could the same store tearing occur here in dw_hdma_v0_write_ll_link,
since struct dw_hdma_v0_llp is also __packed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-edma_ll-v3=
-0-877aa463740c@nxp.com?part=3D1
