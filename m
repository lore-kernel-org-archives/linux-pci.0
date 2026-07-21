Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A58F46D2D6;
	Tue, 21 Jul 2026 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651232; cv=none; b=jCftBAItz0l9OhFAmwLwKgrTF5WsXWGEo2J7lQInzKaO0YH36GbAUNjXWU6zP2/z/PgNDP3El+BF9zgrs/W/9l9LQXVa/cXyvxBac0tzo8a+dc7p4il+bKs717noWy4GGb4zC5cqS3kprIg+fENBxRvQej4SbFP/uJtzTTrc8hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651232; c=relaxed/simple;
	bh=0t6/H/Q6l3WzHqqf5WeZF3vjDv1NOGxJ5G5JyftPQ3Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bLnY2JP+VpqY5VHEEBNuIkM5LMNN+PUkJVsFrazK/SKFJDWUtwZtoNMtZEJwFMGMHCJQ2AdpJPNG+MwnT7fYkGJXu3h8YpQRC+WwgObYrPCkAusbinZ3iA6HmiiWRkQuRdD9a8P7RaCGxnNEyG43uA7hCrp4cg2e97OqSSTbrvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1YJd+R4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1YJd+R4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3431F000E9;
	Tue, 21 Jul 2026 16:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784651231;
	bh=1TjxBs8C56xDChZ4mWkXGjj9QFV9h5PPg5QkY/R52Co=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F1YJd+R4ptqrPD83h3kjI2Lo/pDPQ1OqG0+y1umhLovMAT2F2TEqOx/o9UZxViM1f
	 nLnBF9U8kucRgaY1NDNh9foAFYyQenfUucPfBRKIhrh2RjSRPlhwNRqArgbEpDCFVt
	 J0kPA9PF0Ckv8gHL3CPXsPSZMZKYAZSv+U/h1LeMTyrqP48VKZpHweArRvDgCX6sK7
	 WXFbvqziC+RZJPUVytIzx2t2TS0jX1lxyGwjF+yJJwbc3wW4qRD8/n8jUOJsb+pLcN
	 65/k093ois3T8Zlp9dIkkBEmuTOyoySwGQhoIlVrgy6sY+fJs9hZwuZo9QH0YKS4B3
	 OWac2ipjekNJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/11] dmaengine: switchtec-dma: fix double-free in
 switchtec_dma_free_desc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260721155739.62120-2-logang@deltatee.com>
References: <20260721155739.62120-1-logang@deltatee.com>
 <20260721155739.62120-2-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 16:27:10 +0000
Message-Id: <20260721162711.3D3431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of DMA channel resources on error path in `switchtec_d=
ma_alloc_chan_resources()`.
- [High] Memory leak of `switchtec_dma_chan` structures and channel arrays =
on module probe error paths.
- [High] Deadlock due to client callback invocation while holding `complete=
_lock`.
- [High] `switchtec_dma_prep_desc()` returns with `submit_lock` held, preve=
nting clients from preparing multiple descriptors.
- [High] Unsafe atomic delays of up to 100ms with a spinlock held and a 60m=
s mdelay in atomic context.
- [Medium] Large contiguous 1MB DMA memory allocations use GFP_NOWAIT in a =
sleepable context, risking allocation failure.
--

--- Patch [1]: [PATCH v2 01/11] dmaengine: switchtec-dma: fix double-free i=
n switchtec_dma_free_desc() ---
commit 4a5b609a9359892c57ed414c821b1570151f6b0b
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix double-free in switchtec_dma_free_desc()

This commit adds NULL assignments to the hw_sq, hw_cq, and desc_ring pointe=
rs
after they are freed in switchtec_dma_free_desc(). This fixes a double-free
bug that occurs if switchtec_dma_alloc_chan_resources() fails during unwind
and a subsequent retry also fails, calling the free function a second time.

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 3ef9286406159..a4a7d66d042de 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
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
> =20
>  static int switchtec_dma_alloc_desc(struct switchtec_dma_chan *swdma_cha=
n)

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
switchtec_dma_alloc_chan_resources() leak the descriptors?

If enable_channel() fails after switchtec_dma_alloc_desc() has already allo=
cated
resources, the code returns immediately:

drivers/dma/switchtec_dma.c:switchtec_dma_alloc_chan_resources() {
    ...
	rc =3D enable_channel(swdma_chan);
	if (rc)
		return rc;
    ...
}

Will this permanently leak the DMA descriptors and coherent memory since
switchtec_dma_free_desc() is not called?

[Severity: High]
This is a pre-existing issue, but does switchtec_dma_chan_free() skip freei=
ng
the channel structure itself?

If probe fails and calls switchtec_dma_chans_release() -> switchtec_dma_cha=
n_free(),
it stops the channel but never calls kfree(swdma_chan):

drivers/dma/switchtec_dma.c:switchtec_dma_chan_free() {
    ...
	switchtec_dma_chan_stop(swdma_chan);

	return 0;
}

Also, on module probe error paths, switchtec_dma_create() calls
switchtec_dma_chans_release() but doesn't free the swdma_dev->swdma_chans a=
rray:

drivers/dma/switchtec_dma.c:switchtec_dma_create() {
    ...
err_chans_release_exit:
	switchtec_dma_chans_release(pdev, swdma_dev);

err_exit:
	if (swdma_dev->chan_status_irq)
		free_irq(swdma_dev->chan_status_irq, swdma_dev);

	iounmap(swdma_dev->bar);
	kfree(swdma_dev);
	return rc;
}

Could this lead to memory leaks of the switchtec_dma_chan structures and the
swdma_chans array during early probe failures?

[Severity: High]
This isn't a bug introduced by this patch, but can we self-deadlock when in=
voking
the client callback?

In switchtec_dma_cleanup_completed(), the callback is invoked synchronously=
 while
holding complete_lock:

drivers/dma/switchtec_dma.c:switchtec_dma_cleanup_completed() {
    ...
		spin_lock_bh(&swdma_chan->complete_lock);
    ...
			dmaengine_desc_get_callback_invoke(&desc->txd, &res);
    ...
}

If the client callback checks TX status via dma_async_is_tx_complete(), it =
routes
to switchtec_dma_tx_status(), which calls switchtec_dma_cleanup_completed()=
 again.

Will this cause a deadlock when trying to reacquire complete_lock?

[Severity: High]
This is a pre-existing issue, but does switchtec_dma_prep_desc() return wit=
h a
spinlock held?

drivers/dma/switchtec_dma.c:switchtec_dma_prep_desc() {
    ...
	spin_lock_bh(&swdma_chan->submit_lock);
    ...
	/* return with the lock held, it will be released in tx_submit */

	return &desc->txd;
}

Does this violate the DMA engine API by preventing clients from preparing
multiple descriptors before submitting them?

If a client batches requests and calls prep twice, won't it self-deadlock on
submit_lock?

[Severity: High]
This isn't a bug introduced by this patch, but do we have unsafe delays in
atomic contexts?

In pause_reset_channel(), which is reachable from the device_terminate_all
callback (allowed in atomic context), there is a 60ms busy-wait:

drivers/dma/switchtec_dma.c:pause_reset_channel() {
    ...
	/* wait 60ms to ensure no pending CEs */
	mdelay(60);
    ...
}

Additionally, wait_for_chan_status() spins for up to 100ms while holding
hw_ctrl_lock:

drivers/dma/switchtec_dma.c:wait_for_chan_status() {
    ...
	return readl_poll_timeout_atomic(&chan_hw->status, status,
					 (set && (status & mask)) ||
					 (!set && !(status & mask)),
					 10, 100 * USEC_PER_MSEC);
}

Will these long atomic delays cause severe system latency spikes or soft lo=
ckups?

[Severity: Medium]
This is a pre-existing issue, but is it safe to use GFP_NOWAIT for large
allocations in switchtec_dma_alloc_desc()?

drivers/dma/switchtec_dma.c:switchtec_dma_alloc_desc() {
    ...
	size =3D SWITCHTEC_DMA_SQ_SIZE * sizeof(*swdma_chan->hw_sq);
	swdma_chan->hw_sq =3D dma_alloc_coherent(swdma_dev->dma_dev.dev, size,
					       &swdma_chan->dma_addr_sq,
					       GFP_NOWAIT);
    ...
}

Since device_alloc_chan_resources() is called under a mutex and is allowed =
to sleep,
could using GFP_NOWAIT here unnecessarily cause allocation failures under m=
emory
pressure since it prevents direct reclaim and compaction?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721155739.6212=
0-1-logang@deltatee.com?part=3D1
