Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54C5343885;
	Tue, 28 Jul 2026 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260087; cv=none; b=HGc4DmBscqGU7NZb/JozwhUwg8knRiezPAH0qrYcKKGdOVwooaM+D1lirNMCtG0QOVGwXkl53aEt1x7rSfIX6p7Eit6eqZqOikKLzSS2auPa0TijGG4nRgo0i9fmin9GJYrc2npHfLuKVAOLrNIti940VSh5ImAUZu92fsgtVqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260087; c=relaxed/simple;
	bh=dGIg9U7LUpSCo1hDKJa+liYDJAKwN0JsT/oDyCvShHg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FaW0fgrrRohyPBRNfR/m1RiALYlg8cAHyvIZ0cUbWyIQIOseiHuQta5zG+f5TOpHWuGOMzSLkXKaUZgKxkoRskiBG882i0hBTBu/Zx/sW+iWj4LjUFm+YAbh/nVPbInlW8dC7nlT3z3lqftTxkoSKfECDDbLKZ+tzQxPmHNopbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hz09+Z+n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hz09+Z+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353A21F00A3A;
	Tue, 28 Jul 2026 17:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260086;
	bh=PdRdBFOOf/eKn0ccTeBuAFpWui7L3GsugLpnxxnl7hE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hz09+Z+nk9VcL5bZX2b+XPMrQX2/kKjzqliN+Yi1IgdTDncSgvxMlD/ScJxzoGXZ8
	 2u4s4trKkW3boPI/jXFY0oIqY/bKNtrM4RW2jMoWbJGsYwYl9KIbLMzU7JJomyDC2L
	 v1iT2WOkgcxAqBKl15VaLUTW+twptUpTnC1VEFIEyAlvLimGAiWX/0o579b1iTfBJy
	 c2Q0DFsLelKGSXLvI9ctDgH7/mt9A1o5iMaMfTSK7Ci91r+QlpEn3O1wc2Gt0YOuDN
	 ucQ0i8VRZLq6MKbZMC5z04oXk06i+NItXyCeW0rZZgg08bLjLJp3IyXJc5GbHwhP8A
	 x8Op/pHKPFh3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/12] dmaengine: switchtec-dma: fix double-free in
 switchtec_dma_free_desc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260728171523.112244-2-logang@deltatee.com>
References: <20260728171523.112244-1-logang@deltatee.com>
 <20260728171523.112244-2-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:34:45 +0000
Message-Id: <20260728173446.353A21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing resource cleanup on error paths in switchtec_dma_alloc_cha=
n_resources() causes memory leak of DMA descriptors and rings.
--

--- Patch [1]: [PATCH v4 01/12] dmaengine: switchtec-dma: fix double-free i=
n switchtec_dma_free_desc() ---
commit 5f9c3413d8c3e6b409c7cf9c3bd9dfaa071f19f6
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix double-free in switchtec_dma_free_desc()

This commit fixes a double-free in switchtec_dma_free_desc() by setting the
pointers to NULL after freeing them. This ensures that any subsequent calls
to the function are a no-op for resources that have already been released.

> If switchtec_dma_alloc_chan_resources() fails partway through and calls
> it during unwind, then a later retry of alloc_chan_resources() fails
> in switchtec_dma_alloc_desc() before reallocating one of those

[Severity: High]
This is a pre-existing issue, but does switchtec_dma_alloc_chan_resources()
actually call switchtec_dma_free_desc() during unwind?

If switchtec_dma_alloc_desc() succeeds, but a subsequent step fails:

drivers/dma/switchtec_dma.c:switchtec_dma_alloc_chan_resources() {
    ...
	rc =3D switchtec_dma_alloc_desc(swdma_chan);
	if (rc)
		return rc;

	rc =3D enable_channel(swdma_chan);
	if (rc)
		return rc;

	rc =3D reset_channel(swdma_chan);
	if (rc)
		return rc;

	rc =3D unhalt_channel(swdma_chan);
	if (rc)
		return rc;
    ...
}

It appears we return early without unwinding the allocations made by
switchtec_dma_alloc_desc(). Since the DMA engine core does not automatically
invoke device_free_chan_resources() when device_alloc_chan_resources()
fails, does this result in a permanent leak of the DMA descriptors and
rings?

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 3ef9286406159..a4a7d66d042de 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
[ ... ]
> @@ -886,14 +886,18 @@ static void switchtec_dma_free_desc(struct switchte=
c_dma_chan *swdma_chan)
>  	if (swdma_chan->hw_sq)
>  		dma_free_coherent(swdma_dev->dma_dev.dev, size,
>  				  swdma_chan->hw_sq, swdma_chan->dma_addr_sq);
> +	swdma_chan->hw_sq =3D NULL;
> =20
>  	size =3D SWITCHTEC_DMA_CQ_SIZE * sizeof(*swdma_chan->hw_cq);
>  	if (swdma_chan->hw_cq)
>  		dma_free_coherent(swdma_dev->dma_dev.dev, size,
>  				  swdma_chan->hw_cq, swdma_chan->dma_addr_cq);
> +	swdma_chan->hw_cq =3D NULL;
> =20
> -	for (i =3D 0; i < SWITCHTEC_DMA_RING_SIZE; i++)
> +	for (i =3D 0; i < SWITCHTEC_DMA_RING_SIZE; i++) {
>  		kfree(swdma_chan->desc_ring[i]);
> +		swdma_chan->desc_ring[i] =3D NULL;
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728171523.1122=
44-1-logang@deltatee.com?part=3D1
