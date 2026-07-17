Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F9C223DCE;
	Fri, 17 Jul 2026 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784327426; cv=none; b=OPgZq31vxXxScEmrM1yLi4mG5LtSKd9XYoeaONpZ+zvXEEnqHin+hOofDoo0imWI8nPLtGq5agISTyhbjyj+SEqme83ypLN0FmUPzJB6wRrq3TnffQ7CbV+0gvb4INJMQXRiRcq11wtZG/TWyjTirkaxiYjUDaIZZwcMT/ff4sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784327426; c=relaxed/simple;
	bh=ZBAB0k1Tk7jH8+ku9r213ytppkPaXnSIRXQoJHcdmr8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h4tmfBbCtYZX1I938zi6aJTgZH6Wy3beAWbinXDJRiwezWIlw1W6rfUEnn5dwgcyzpJCfUJfbyr033Z4RF68OT8Apz/butXsZAm9kk59N8SAh5jyYqHtkMfvSCAbPdrDmJCwsD/6XOh877JYZTUxyybe7U50w5Ht0xgWk66teiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUTFgKc4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUTFgKc4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB8A1F000E9;
	Fri, 17 Jul 2026 22:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784327424;
	bh=mNwLyfPs2lQZ9PQtGKwWN9h+4lSSmNVFn368M6bSYac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mUTFgKc4da1FP6maBqMH960Xdc65jxZCI/gb5pjbKpkVkI1i4+bdVE69oAAJHVyaf
	 wx+t91E2YO02kfJLyINnHMSvkSiGKikJ4ulYT5PpV38FJpDhQT73EOznEnwLjpHJc7
	 PBZhZQJJJcQtJj9nFT8dx4xw9xGIn8oKL2fOS/dXM+whBEpenH3HyJKKHZWZFV58Fb
	 ZCkaGw+eKQS9L36u0M56eWpJBJ6xEi1wY1siujaFfRfLfJm79HrNF/c8Cp++Dp8xcD
	 rfM2DjYuwYkuTAHVNEp8ZbJ6oZAt6GqbBTHDCTyY1lf3lmZZqypfFiC91ijjhti51W
	 VZLd0s+VHqH/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/6] dmaengine: switchtec-dma: fix double-free in
 switchtec_dma_free_desc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260717221001.361421-2-logang@deltatee.com>
References: <20260717221001.361421-1-logang@deltatee.com>
 <20260717221001.361421-2-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 22:30:24 +0000
Message-Id: <20260717223024.9BB8A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Allocated descriptor and coherent DMA memory resources are permane=
ntly leaked if hardware channel enablement fails in `switchtec_dma_alloc_ch=
an_resources()`.
- [High] Multiple memory leaks of `switchtec_dma_chan` structures in driver=
 initialization error paths.
--

--- Patch [1]: [PATCH v1 1/6] dmaengine: switchtec-dma: fix double-free in =
switchtec_dma_free_desc() ---
commit 36a3a50ecff021c64b2470dc8539fa5396858275
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix double-free in switchtec_dma_free_desc()

switchtec_dma_free_desc() frees swdma_chan->hw_sq, hw_cq, and every
desc_ring[] entry without clearing the pointers afterward. If
switchtec_dma_alloc_chan_resources() fails partway through and calls
it during unwind, then a later retry of alloc_chan_resources() fails
in switchtec_dma_alloc_desc() before reallocating one of those
pointers, its own failure path calls switchtec_dma_free_desc() again
and frees the same, already-freed pointers a second time.

NULL out each pointer as it's freed so a subsequent call is a no-op
for anything already released.

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

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing I noticed
that if hardware enablement fails in switchtec_dma_alloc_chan_resources(),
the resources allocated by switchtec_dma_alloc_desc() appear to be permanen=
tly
leaked:

drivers/dma/switchtec_dma.c:switchtec_dma_alloc_chan_resources() {
	rc =3D switchtec_dma_alloc_desc(swdma_chan);
	if (rc)
		return rc;

	rc =3D enable_channel(swdma_chan);
	if (rc)
		return rc;
    ...
}

Since the DMA framework does not automatically clean up if
device_alloc_chan_resources fails, does this need a call to
switchtec_dma_free_desc() in the error path?

[Severity: High]
This is also a pre-existing issue, but I spotted a memory leak of the chann=
el
structures during driver initialization:

drivers/dma/switchtec_dma.c:switchtec_dma_chans_enumerate() {
    ...
err_exit:
	for (i =3D 0; i < chan_cnt; i++)
		switchtec_dma_chan_free(pdev, swdma_dev->swdma_chans[i]);

	kfree(swdma_dev->swdma_chans);
    ...
}

Since switchtec_dma_chan_free() stops the channel and frees IRQs but does n=
ot
kfree the switchtec_dma_chan struct itself, does this permanently leak the
successfully initialized channel structs?

Similarly, in switchtec_dma_create(), if dma_async_device_register() fails:

drivers/dma/switchtec_dma.c:switchtec_dma_create() {
    ...
err_chans_release_exit:
	switchtec_dma_chans_release(pdev, swdma_dev);

err_exit:
    ...
	kfree(swdma_dev);
    ...
}

The array and channel structs are missed here since they are only normally =
freed
in the device_release callback. Does this path also need to kfree the array
and channel elements?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717221001.3614=
21-1-logang@deltatee.com?part=3D1
