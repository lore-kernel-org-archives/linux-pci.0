Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C82372EDB;
	Fri, 10 Jul 2026 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783703318; cv=none; b=cuVDiD6HIIilZu6X8MxL2VDWbYzE/Asf6CCtDcfXCZzMZAowIaLS9LH3rLy+lkjjdAcsOgTR66JmlQzCikHfk4zxzpmGP9W/ks1TBQz52EJsbzv6gxiFm31ecjupYr3l+jNd1BskVhRv2o8lssKcQoZVfnKCDr5Sw9ioZBRaJuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783703318; c=relaxed/simple;
	bh=cbdTD4LNdtaYIciu/PLq/aQSgXLCeORVJUSexNODIc8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rs3qTPy9BF4/8gRsY429bS3vbrttL42Zwx4wUz/c7W8gp3bnUByWMKxqLIGyyGZUP/ZZrJJJhqoOzJcyrsNzUPde5Gl+kFAIIdkFg8SQ1Ohrp8cM080Fkr5EqUb9VQxHTwjtHVPdAxgnKNG6bJ3MhweRTWQrqxdD/KfvmuFbDII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjgRVSlN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjgRVSlN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C423E1F000E9;
	Fri, 10 Jul 2026 17:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783703317;
	bh=hhPbd1UCtd/0zITFksdr7GEBYN5kVbAXeYXNDGLHc4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jjgRVSlNFXmCql/94JtcLrR/pKYijeR7fm9h2buYS1b/vMUNdZSdcn0PySGKwjjlC
	 jLCy/5W9qzqWgEoJf2YuLJeDUZrTZSOEmuogjJACTAALhDX2SoBjDG7+o0lhxC8NG9
	 W6/7pNhumkvDFMeqHsGegwFDcVUjDKje21Z5OOzCFM8/4ZQrwWP5F3bGdVXNLdLBxj
	 ArmxpOEknu69hmNolmQr3uhWthqoOmuX4rQxioViWjJPqeHjtvVcsCjHyAgntBIAP1
	 b8GScY2O+FSntfxFTHZRSt/lokUAWF3xkHgKpNeFYonR2TQBB/lT5KnVQVwfK9i10G
	 3Wo9y6FXAbHrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/10] dmaengine: dw-edma: Remove struct
 dw_edma_chunk
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260710-edma_ll-v6-10-1471d278b73a@nxp.com>
References: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
 <20260710-edma_ll-v6-10-1471d278b73a@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 17:08:36 +0000
Message-Id: <20260710170836.C423E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Refactoring from bounded chunk arrays to a monolithic descriptor a=
rray introduces unbounded high-order atomic memory allocations that are pro=
ne to failure under fragmentation.

Pre-existing issues:
- [High] Pre-existing locking violation: `dw_edma_device_resume` invokes `d=
w_edma_start_transfer` without acquiring the virtual channel lock.
--

--- Patch [10]: [PATCH v6 10/10] dmaengine: dw-edma: Remove struct dw_edma_=
chunk ---
commit 04c138d15d0c47167bf151873232daba3b9881ad
Author: Frank Li <Frank.Li@nxp.com>
Subject: dmaengine: dw-edma: Remove struct dw_edma_chunk

This commit simplifies the DMA descriptor layout by removing the
dw_edma_chunk linked-list layer. The burst array is now allocated
directly within dw_edma_desc to reduce the number of allocations
required per descriptor.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 202862a828b4d..30eeb7bffad80 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c

[ ... ]

> -static struct dw_edma_desc *dw_edma_alloc_desc(struct dw_edma_chan *chan)
> +static struct dw_edma_desc *
> +dw_edma_alloc_desc(struct dw_edma_chan *chan, size_t nburst)
>  {
>  	struct dw_edma_desc *desc;
> =20
> -	desc =3D kzalloc_obj(*desc, GFP_NOWAIT);
> +	desc =3D kzalloc_flex(*desc, burst, nburst, GFP_NOWAIT);

[Severity: High]
Will this monolithic allocation approach cause large DMA transfers to fail?

In dw_edma_device_transfer(), the total burst count is passed directly here
as nburst without chunking. For large scatter-gather transfers, nburst could
be very large.

Since GFP_NOWAIT cannot sleep or reclaim memory, won't these large atomic
allocations fail reliably under memory fragmentation?

>  	if (unlikely(!desc))
>  		return NULL;
> =20
>  	desc->chan =3D chan;
> -
> -	INIT_LIST_HEAD(&desc->chunk_list);
> +	desc->nburst =3D nburst;
> +	desc->cb =3D true;

[ ... ]

>  static int dw_edma_start_transfer(struct dw_edma_chan *chan)
>  {
> -	struct dw_edma_chunk *child;
>  	struct dw_edma_desc *desc;
>  	struct virt_dma_desc *vd;
> =20
>  	vd =3D vchan_next_desc(&chan->vc);

[Severity: High]
This is a pre-existing issue, but is it safe for dw_edma_device_resume()
to call dw_edma_start_transfer() without holding the virtual channel lock?

dw_edma_start_transfer() calls vchan_next_desc() here, which actively unlin=
ks
entries from the list.

If dw_edma_device_resume() bypasses spin_lock_irqsave(&chan->vc.lock) and a
concurrent hardware interrupt occurs, could this corrupt the virtual channel
lists?

>  	if (!vd)
>  		return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-edma_ll-v6=
-0-1471d278b73a@nxp.com?part=3D10
