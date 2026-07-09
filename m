Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D132E7373;
	Thu,  9 Jul 2026 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611867; cv=none; b=NDDkVgIAEbYoEhgFAuW1HdGSrUbzJRHtG6oTW30cLW8GSJWtfttP7c4Qm2bO6oaVcF9/FUwthl5VwykMGTguIF3p5y9G6ixFFQg6wTxAXSVLLrJhWMTaZRU9Qfym9dEKMm8QsUpAgrO3UuYU7Z4yJWJvt7VEPFKa8edcopgplTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611867; c=relaxed/simple;
	bh=TmBaWxsFRcXQozNfj0x4RR83E1vKa4lPcGTdjd//sUI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q1VCBtbXBnJZUQc/4m9NtkL1U2KOk+XPzpOe6Zv6QbAVFhE2VfCymTgo7Vv6mx3sMIah8qgJR3z4d9EXFSMMC7KE2L0cP9HbHnZOy4Ba9wHG4YIJ2i8C3KlkDYk+Ztzwg3+4vdN1+gynjoodbYr1GwSlMT6vcrpaCxXIeQVx0sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFf8kizI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFf8kizI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270B71F000E9;
	Thu,  9 Jul 2026 15:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611865;
	bh=4Kttj66JbGjZxb/CmYuNjyqQcLRbuDOyZvCzdv9O21U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LFf8kizIY6AN1hDbOzSssvjs3gvkgpWL2RvvTJSHogdbsX7H9xWsfBHXGS9GtT3/t
	 4CTjDBVccQ8PGTzP88gCPCqBv2kPcIweDslxoFOSQbwj1orMznncimNNrn1imc8j5e
	 6FZV8FsA3EkCxtkS3734u5w3Ywy1SEYbtGDqMsx3DK2Vm/2iQq4EhMF57rc/csyxA1
	 VE3M5ZfO4Y6qkXoGTKQkMACOWRL9qL23ipoEfdPjpetGQtMWVINPNVe8oVpREWctbC
	 806eYkrZASkT+TSdyeK7bF79Cu1VbYZzFmA8qA6jvzu9XYxCDRM72dBzriEad9+FCq
	 QjOA9pC3F55BQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/10] dmaengine: dw-edma: Move control field update
 of DMA link to the last step
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260709-edma_ll-v5-1-e199053d4300@nxp.com>
References: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
 <20260709-edma_ll-v5-1-e199053d4300@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:44:24 +0000
Message-Id: <20260709154425.270B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Non-atomic plain C assignment to a `__packed` struct member intr=
oduces store tearing, breaking the intended synchronization.
--

--- Patch [1]: [PATCH v5 01/10] dmaengine: dw-edma: Move control field upda=
te of DMA link to the last step ---
commit cd43406fa1746a861753879aacc2a23e61b13ce6
Author: Frank Li <Frank.Li@nxp.com>
Subject: dmaengine: dw-edma: Move control field update of DMA link to the l=
ast step

This commit moves the control field update of the DMA link list entry to the
end of the sequence. It adds a dma_wmb() barrier to ensure correct memory
write ordering, which prepares the driver for supporting link entry updates
during DMA operation.

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
Could this assignment tear on strict-alignment architectures?

Since struct dw_edma_v0_lli is defined as __packed without an __aligned()
attribute, the compiler may assume an alignment of 1. This means a plain C
assignment could be compiled into multiple byte-sized stores (such as strb =
on
ARM).

If the store tears, could the hardware observe the CB bit as ready before t=
he
rest of the control word is fully written, leading to a corrupted control
state being processed?

>  	} else {
>  		struct dw_edma_v0_lli __iomem *lli =3D chunk->ll_region.vaddr.io + ofs;
> =20
> -		writel(control, &lli->control);
>  		writel(size, &lli->transfer_size);
>  		writeq(sar, &lli->sar.reg);
>  		writeq(dar, &lli->dar.reg);
> +		writel(control, &lli->control);
>  	}
>  }

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
Are we facing the same store tearing issue here since struct dw_edma_v0_llp
is also __packed?

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
Might this assignment also tear on strict-alignment architectures, as
struct dw_hdma_v0_lli is marked as __packed?

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
Would this assignment also be susceptible to store tearing due to
struct dw_hdma_v0_llp being __packed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-edma_ll-v5=
-0-e199053d4300@nxp.com?part=3D1
