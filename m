Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505741EEE6;
	Fri, 10 Jul 2026 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702624; cv=none; b=p+GUcjhpKVZ0JALlw98iAruUf+pke59NNdsGceWRx5k7um1c9llPcyPefHhZFzFBJ+NuU2zSKAaaRbgx+NAwmTrGBKGvuXWQYZBY/n1v4y7PhR2XaMPnSJYz1FYzhG2PIPUn2tdtPkCaSd/YV8h+YJk58ncPe9ton9Xf/u+W23w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702624; c=relaxed/simple;
	bh=mw8rFvPqtL2zhx7JrhRohGgJj5kPn31bX1YGM7j/3Z8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F5Pu0gOPu9UwFX7nJNNvZikbQtLvup7yM2L5pEwBY61k7NGk+fIAtRJRCSIanx1V0u4aaZqSiTN3iupvDBRLVMh/rgGF7bfAAmhVUczO/0SyTB0535YOyofIf03G9q+4osLOrg5NpEEwqXyqcMa+Mu/SE3Aa/gtT/th+MTqwRWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a30SEYiJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a30SEYiJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9A41F000E9;
	Fri, 10 Jul 2026 16:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783702623;
	bh=U8HSJgBXXn634zeaytaA9h2t9Pig74HCq9jl3J3suoc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a30SEYiJwENb8WI6zz33oYyMX3KStjucz2UStDgWSnCZvCKM34r/pl6dVGsGFhXxq
	 LtkB6NNh6idU6C1tMXJ+UtkoUJCba2yarhIm/ceg2EbR3GUJGbH2ARPleH822OkM+0
	 eAGAJ7N4QthpIRsUa+AuecFJivm/oZbx+kmtLtTEVVw3iX6oA+cDj359/RgkL6Ybab
	 bnvMmWffeY/Q3LjR1LqM/6R5V43QouUzaUy8nzY3pP2KzA+ua0b38+1GV2xyMj0INr
	 T4UWqE3qaUIG766ZdLMEanzzHJinh+/FYb4zWQgA2yjYvTwbpjGz5i1adiwnD7fTrS
	 Qp77TRQSQGiOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/10] dmaengine: dw-edma: Move control field update
 of DMA link to the last step
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org
In-Reply-To: <20260710-edma_ll-v6-1-1471d278b73a@nxp.com>
References: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
 <20260710-edma_ll-v6-1-1471d278b73a@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 16:57:02 +0000
Message-Id: <20260710165702.9E9A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Lockless publication of the DMA descriptor is unsafe due to pote=
ntial store tearing on a `__packed` struct member.
--

--- Patch [1]: [PATCH v6 01/10] dmaengine: dw-edma: Move control field upda=
te of DMA link to the last step ---
commit 80982af6bca567bb6b3c646360920bbd045cd88a
Author: Frank Li <Frank.Li@nxp.com>
Subject: dmaengine: dw-edma: Move control field update of DMA link to the l=
ast step

The control field in a DMA link list entry must be updated as the final
step because it includes the CB bit, which indicates whether the entry is
ready. Add dma_wmb() to ensure the correct memory write ordering.

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
This is a pre-existing issue, but since struct dw_edma_v0_lli is marked
__packed, could the compiler tear this plain 32-bit assignment into multiple
byte-wise stores on strict-alignment architectures?

The goal of this patch is to safely publish the descriptor to the hardware =
by
updating the control field last. Would using WRITE_ONCE() be appropriate he=
re
to guarantee a single atomic store and prevent compiler reordering?

If the DMA engine fetches a partially updated control word where the ready =
bit
is set but other control bits are stale, it might cause a hardware malfunct=
ion
once concurrent descriptor updates are fully supported.

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
This is a pre-existing issue, but the same risk appears here for llp->contr=
ol
since struct dw_edma_v0_llp is also __packed. Is WRITE_ONCE() also needed h=
ere
to prevent store tearing?

[ ... ]

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
This is a pre-existing issue, but is there a similar store tearing risk in
dw_hdma_v0_write_ll_data() due to struct dw_hdma_v0_lli being __packed?

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
This is a pre-existing issue, but a plain assignment is also used here on t=
he
__packed struct dw_hdma_v0_llp. Should this assignment be updated to ensure
atomic publication as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-edma_ll-v6=
-0-1471d278b73a@nxp.com?part=3D1
