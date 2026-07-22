Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BC32CCC5
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784700858; cv=none; b=cJAYw/ZUDelUC62g3grXaAo1Xq1t0Widq1YKZbB6IVbZSySiw+3AOvioF25XPrRF7DaHSthGiZqjAJGvw26ufQI9AK/O9J0mkOTHZ7Y8oxvcnZaGP3VevM96F9WnU9bcnNV4jflb58QmIVSvU7GmwwYRT1l3vTPOpzF461tgm3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784700858; c=relaxed/simple;
	bh=TANF1oL4P9dguaai1U0g7ciAYG1vuXbV4FHf1/9DDU0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BiJQC1QFCEMtI/CarDgmuEESS8jVlUqkIbZ6u27I71JDeXCIrX7MZ3VSAt3xzkVjTNixyCBM/lU3EbQR71lN4Et0z0+egvJ1C7VLhxtRPECJ/hAv/H2VjlwK9CEWJN8Aw4Ft/SIfoJUAtmPvOaX8g9qrdAZf2oyHyC7U86fhpM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BesAd0T1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BesAd0T1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FECE1F000E9;
	Wed, 22 Jul 2026 06:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784700856;
	bh=yRr3+gKC8SotdP+jakqbpilGRdqdYElYIftTo6EVdb0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BesAd0T1HRGt+HNzdEZY1dZZwIzZyqjRbvVV5qrBqPzb5k9vlfDhfoV82LExL2VkB
	 nWa1RCafllvkxAOmFgXfC2nrybxbEX/G+I7I8I8Aa0CLqqTMPuRbXLwh3q9QNqnTiw
	 ySHeaue3LGZ+csr7M7GnXrwCfUjkTN7aMvhbUxUkKzhnILa3ePxoyFdTyfYkyvRPxn
	 kJAh05Q+5kkmPRctjwwUkpJjcNsP81sHOY+7KGFOjNbInXZhbr4pV9K8LDeuBQ5Jbq
	 TzOs6pSUc+w5f85f3atnsdDc62KdiFm08OjB9fy/Y9HQMGUj/2ZkTFLAR8Dd+n90OA
	 Ep+pO7XhxpT1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] bus: mhi: ep: Add mhi_cntrl->flush_async()
 callback to flush the async read/write
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260722-mhi-ep-flush-v3-1-d855e715264e@oss.qualcomm.com>
References: <20260722-mhi-ep-flush-v3-0-d855e715264e@oss.qualcomm.com>
 <20260722-mhi-ep-flush-v3-1-d855e715264e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 06:14:16 +0000
Message-Id: <20260722061416.7FECE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] Lock gap in `mhi_ep_remove()` during `flush_async()` allows the ho=
st to restart the channel and bypass teardown synchronization.
- [High] Memory leak of TRE buffers and SKBs if `flush_async` cancels DMA o=
perations.

Pre-existing issues:
- [High] Missing `flush_async()` in `mhi_ep_abort_transfer()`, `STOP_CHAN`,=
 and `RESET_CHAN` leaves UAF and introduces NULL pointer dereference.
- [High] Inconsistent locking for `xfer_cb` leading to potential AB-BA dead=
locks in client drivers.
- [High] Use-Before-Initialization race condition due to early `xfer_cb` pu=
blication in `probe()`.
- [High] Invalid Memory Free (`kfree()` used on a `kmem_cache` object).
- [Medium] Duplicate `-ENOTCONN` notifications sent to client driver.
--

--- Patch [1]: [PATCH v3 1/3] bus: mhi: ep: Add mhi_cntrl->flush_async() ca=
llback to flush the async read/write ---
commit 8e4fde6115727693f6dc8095e55dc40c2cd91987
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

bus: mhi: ep: Add mhi_cntrl->flush_async() callback to flush the async read=
/write

This commit introduces a flush_async callback to the MHI endpoint controller
and calls it during device removal. This ensures that any pending asynchron=
ous
DMA read or write operations are completed before disconnecting the channel=
s.
The change aims to prevent use-after-free issues that occur when DMA
callbacks trigger after channel teardown.

> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 0277e1ab11988..b94c571f01d88 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -1620,6 +1621,22 @@ static void mhi_ep_remove(struct device *dev)
>  	if (mhi_dev->dev_type =3D=3D MHI_DEVICE_CONTROLLER)
>  		return;
> =20
> +	/* Disable the channels to prevent new transfers */
> +	for (dir =3D 0; dir < 2; dir++) {
> +		mhi_chan =3D dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
> +
> +		if (!mhi_chan)
> +			continue;
> +
> +		mutex_lock(&mhi_chan->lock);
> +		mhi_chan->state =3D MHI_CH_STATE_DISABLED;
> +		mutex_unlock(&mhi_chan->lock);
> +	}
> +
> +	/* Flush in-flight transfers before notifying disconnect */
> +	if (mhi_cntrl->flush_async)
> +		mhi_cntrl->flush_async(mhi_cntrl);

[Severity: High]
Does dropping the channel locks while calling the blocking flush_async
callback leave a window where the host could restart the channel?

If a START_CHAN command is processed during this gap,
mhi_ep_process_cmd_ring() could reacquire the lock and set the state back to
MHI_CH_STATE_RUNNING. This would allow new DMA operations to be queued
before the xfer_cb is cleared later in this function, potentially leading to
a use-after-free.

[Severity: High]
If the controller implements flush_async() by cancelling pending transfers
(for example, via dmaengine_terminate_async()), could this cause a memory
leak?

Since the MHI EP core doesn't appear to track pending operations, abandoning
the buffers allocated from tre_buf_cache without invoking their completion
callbacks might leak both the TRE buffers and associated SKBs.

[Severity: High]
This is a pre-existing issue, but since flush_async() is being added here to
handle pending transfers, should it also be called when the host resets or
stops a channel?

During host commands like RESET_CHAN or STOP_CHAN, or during power down via
mhi_ep_abort_transfer(), channels are disabled without flushing pending DMA
transfers. For instance, in mhi_ep_process_cmd_ring() handling a RESET_CHAN,
mhi_ep_ring_reset() frees ring->ring_cache and sets it to NULL. If an
in-flight async DMA read subsequently completes, mhi_ep_read_completion()
will dereference this NULL ring_cache.

>  	/* Disconnect the channels associated with the driver */
>  	for (dir =3D 0; dir < 2; dir++) {
>  		mhi_chan =3D dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
> @@ -1635,7 +1652,6 @@ static void mhi_ep_remove(struct device *dev)
>  			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
>  		}

[Severity: Medium]
This is a pre-existing issue, but does this lead to duplicate -ENOTCONN
notifications being sent to the client driver during power down?

When mhi_ep_abort_transfer() is called, it sends an initial -ENOTCONN via
xfer_cb but leaves the callback set. Device destruction then synchronously
invokes mhi_ep_remove(), which finds the callback still valid and sends a
second -ENOTCONN notification.

[Severity: High]
This isn't a bug introduced by this patch, but is there an inconsistent
locking expectation for xfer_cb that could lead to deadlocks in client
drivers?

The callback is invoked with mhi_chan->lock held in mhi_ep_process_ch_ring(=
),
but it is called locklessly from the workqueue in mhi_ep_skb_completion().
If a client driver responds to a receive callback by queueing a new buffer
via mhi_ep_queue_skb() (which acquires mhi_chan->lock), it could self-deadl=
ock
when called from the locked context.

[Severity: High]
This isn't a bug introduced by this patch, but could the xfer_cb be called
before the client driver has finished initializing?

In mhi_ep_probe(), xfer_cb is assigned to the channel before the client
driver's probe function completes:

mhi_ep_probe() {
    ...
    ul_chan->xfer_cb =3D mhi_drv->ul_xfer_cb;
    dl_chan->xfer_cb =3D mhi_drv->dl_xfer_cb;

    return mhi_drv->probe(mhi_dev, mhi_dev->id);
}

If the host sends an early doorbell interrupt, mhi_ep_ch_ring_worker() could
start processing the ring and invoke the callback on a client structure that
is not fully initialized.

[Severity: High]
This is a pre-existing issue, but is kfree() being used incorrectly on an
object allocated from a slab cache?

In mhi_ep_ch_ring_worker(), if the ring is stopped concurrently, the iterat=
or
is freed using kfree():

mhi_ep_ch_ring_worker() {
    ...
    if (!ring->started) {
        mutex_unlock(&chan->lock);
        kfree(itr);
        continue;
    }
}

However, the iterator was allocated from the mhi_cntrl->ring_item_cache via
kmem_cache_zalloc(), so this might cause slab memory corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-mhi-ep-flu=
sh-v3-0-d855e715264e@oss.qualcomm.com?part=3D1
