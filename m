Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A933C3C19;
	Wed,  8 Jul 2026 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536444; cv=none; b=rdHCONPIaiM8AhIldybmy5WCOvyZBpoXmD3P4nqI/W5msGtJNm+PqPzLfrfm+2q0rndggwL0RVjV2vWvEgXZ2xOfQLqIIL5Ced4Kq3dw1KmRnE+mqiQFrMlH18kw7wesWr4zzqNKiGuGKuL9105b7XIkgt6cWu0qsPfI+2XH8SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536444; c=relaxed/simple;
	bh=7LQLeV41DzW3QMMpofP8idSv7vDpH9Uie0dUSX6gyds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OUhfDTJYURcz78d0PoY+dr2pDI/tPcSv55QRQkRgCuQkeLDaFt90pGn4nh9c/IAaMUaehAZJ9MP/p6YezW0YM6ZGGD24CnmOjgScGmNU+wNx1QsdwKUW0FfEe44MC6xuHHZO5fjcl0EOPqtUKdDUMpzn2WpriiIxwUHA8GjIOrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgvSochV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgvSochV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925E81F000E9;
	Wed,  8 Jul 2026 18:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783536442;
	bh=dikXtWBDo5SMKR6Te2NzkEJMhWuM7bvbrXP9M3ZWEmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MgvSochV9lpgDlOCqfuD1iM/u6lvvCeba/wrVYHZpvfU6wz/A/NmAp9giOSPc5Ztk
	 az9xBcJnQV+4Ga9M8RrINrfZQY4f2S1WdCDWugPCpTpxFsjmGi3Kfo4Ztt0pGGxTcU
	 SMIvtNkjsjVfpQr0CqOy9Mr/OduV4xVcIVHf/eQV2BDwJrJNsBRAIC1rde8LKsfMJ8
	 bDijj4DTopvLfEMThLxI4sWWfq2SsoDboOOnhf9sgrHBStwAH6JUhSEQ53vbnTkXma
	 z9bITlilxEeNmPlF+3Xija8jQnumB4j8rqzM+DeXPYICToRqwuXypeywHGkMaUJVdJ
	 KjYt+M1LJiwMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/10] dmaengine: dw-edma: Move control field update
 of DMA link to the last step
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260708-edma_ll-v4-1-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
 <20260708-edma_ll-v4-1-cc128f0afb61@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 18:47:21 +0000
Message-Id: <20260708184721.925E81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The lockless update to the `control` field in the local DMA desc=
riptor is vulnerable to compiler tearing due to the `__packed` attribute, u=
ndermining the hardware synchronization intended by this patch.
--

--- Patch [1]: [PATCH v4 01/10] dmaengine: dw-edma: Move control field upda=
te of DMA link to the last step ---
commit baf2c8f9cfe7a0520e9aa385d467515afdd0b585
Author: Frank Li <Frank.Li@nxp.com>
dmaengine: dw-edma: Move control field update of DMA link to the last step

This commit modifies the initialization order of DMA link list entries
so that the control field, which includes the ready bit, is written last
after a dma_wmb(). This prepares the driver to support updating link
entries while the DMA is actively running.

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
Since struct dw_edma_v0_lli is marked as __packed, is it possible for the
compiler to tear this lli->control assignment into multiple byte-sized
stores on some architectures with strict alignment rules?

If the DMA engine is running and observes a torn write, it could read a
partially updated control word. While the commit message notes concurrent
updates aren't enabled yet, would using WRITE_ONCE() (along with any
necessary casting to avoid packed-member warnings) ensure this
synchronization flag is written indivisibly once concurrent hardware access
is enabled?

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
Does this llp->control assignment have the same tearing vulnerability
due to struct dw_edma_v0_llp being __packed?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-edma_ll-v4=
-0-cc128f0afb61@nxp.com?part=3D1
