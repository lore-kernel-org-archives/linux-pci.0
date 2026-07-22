Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677F833BBCD
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 06:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701133; cv=none; b=IXaMtJOJAqw9nrIpQ27KF9ohZHGh9GGGiOHtfhNgmyHjrS8NRtTJXcUB93TV6K/aXQI1RYtq7fmzoSL+HPzuqmzs92hJBGyqPUVkQeOASNECc16FxmAWTbFJ/uLo6QnnBTr3MUhK2V1LuO27/Ff0ffQvkIe7YrtjLEcx111Jbwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701133; c=relaxed/simple;
	bh=HM2sCG/XQBVCOp1yUkAIM0mS0fzNhzz7CvZ0eEje4aU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mFIZVCyf0XuhqSZTu1Td5wgBPjn+6kKiZZiqYkY6MfQoGjoWDIgdZ05gRw+ubUj3nEpiIlYWVZ0yvMcmBdsxBTPuj7Z4P6mdDQkYIoZ78KyRLNhmCrtqkbkf5b/TvNyB2RpW1HASH8YCvRqZVpAMPdhq/yMZb21SObSsu/VQLhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOQ1x/EI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOQ1x/EI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AC31F000E9;
	Wed, 22 Jul 2026 06:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784701130;
	bh=2raFDeJdwxJTpHTQY5LhPj/vibLywdVIqPG6UbMg85U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XOQ1x/EImEgshcHnYNTKiY6O+3Zsastgt59c3tls7NuXsinik1oUetGod81q//38A
	 A6zcimweOdBaxYwhDiEcNZ8tsWsDR3aS+qhKfZY5hCQjsGt228Q6KEMcTeT6/z60sn
	 TpfYtFJsgbrvSxK5e5oDY1jHqJHCeA+NMTbBGAREjolcp4qj8LLZTjIofSLXUXHcwS
	 kHob63KU9WP63Kj5vcwcxvkAOwUuVoqzovGdoEV78JfKa1hxJBBPD1qNHGQ2nObvW5
	 86oq+jzOvdXBJfXbkfC8eH5OlifV6qXgbLWmLCb48ea+jAWtC86YNm+xsFRTfMYYt2
	 x5fBHVnUnDrOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] bus: mhi: ep: Flush async transfers before
 notifying disconnect in mhi_ep_abort_transfer()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260722-mhi-ep-flush-v3-2-d855e715264e@oss.qualcomm.com>
References: <20260722-mhi-ep-flush-v3-0-d855e715264e@oss.qualcomm.com>
 <20260722-mhi-ep-flush-v3-2-d855e715264e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 06:18:49 +0000
Message-Id: <20260722061849.E8AC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Race condition in split loop design leaves channel in RUNNING stat=
e after disconnect notification.

Pre-existing issues:
- [Critical] STOP and RESET handlers lack flush_async() leading to UAF and =
deterministic NULL pointer dereference.
- [High] Late IRQ re-queues ch_ring_work causing UAF and freed memory acces=
s during DL channel processing.
- [High] Double -ENOTCONN disconnect notification triggers potential double=
-free in client drivers.
--

--- Patch [2]: [PATCH v3 2/3] bus: mhi: ep: Flush async transfers before no=
tifying disconnect in mhi_ep_abort_transfer() ---
commit f2f701565f9c8f759ea3acdcd7ee4b4c1972f847
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

bus: mhi: ep: Flush async transfers before notifying disconnect in mhi_ep_a=
bort_transfer()

mhi_ep_abort_transfer() modifies the abort process by first disabling
channels, draining workqueues and async transfers, and then notifying
clients. This aims to prevent UAFs caused by trailing completions.

> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index b94c571f01d88..51735f87017f0 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -1025,26 +1025,37 @@ static void mhi_ep_abort_transfer(struct mhi_ep_c=
ntrl *mhi_cntrl)
>  	struct mhi_ep_chan *mhi_chan;
>  	int i;
> =20
> -	/* Stop all the channels */
> +	/* Disable all the channels to prevent new transfers */
> +	for (i =3D 0; i < mhi_cntrl->max_chan; i++) {
> +		mhi_chan =3D &mhi_cntrl->mhi_chan[i];
> +		if (!mhi_chan->ring.started)
> +			continue;

[Severity: High]
Since this loop skips unstarted channels, is it possible for an unstarted
channel to be started during the flush_workqueue() below?

If cmd_ring_work processes a START_CHAN_CMD during the flush, it could
start a previously unstarted channel and unconditionally set its state to
MHI_CH_STATE_RUNNING. The second loop would then observe the channel as
started, send the -ENOTCONN notification, but leave the channel in the
RUNNING state since it was bypassed by the first loop. This could allow
the channel to continue processing transfers and deliver trailing success
callbacks after the client has freed its resources.

> +
> +		mutex_lock(&mhi_chan->lock);
> +		mhi_chan->state =3D MHI_CH_STATE_DISABLED;
> +		mutex_unlock(&mhi_chan->lock);
> +	}
> +
> +	/* Drain ring workers and in-flight transfers before notifying disconne=
ct */
> +	flush_workqueue(mhi_cntrl->wq);

[Severity: High]
This is a pre-existing issue, but can late doorbell interrupts repopulate
the workqueue after it is flushed?

flush_workqueue() is called here, but hardware interrupts are not masked
until mhi_ep_mmio_mask_interrupts() is called later in
mhi_ep_abort_transfer(). A late interrupt could queue ch_ring_work again.

When mhi_ep_process_ch_ring() executes for a DL channel, it lacks a
MHI_CH_STATE_RUNNING check:

drivers/bus/mhi/ep/main.c:mhi_ep_process_ch_ring() {
    ...
		/* DL channel */
		result.dir =3D mhi_chan->dir;
		mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
    ...
}

This could unconditionally invoke xfer_cb() after the disconnect loop has
notified the client with -ENOTCONN, potentially resulting in a
Use-After-Free. Additionally, if ch_ring_work runs after
mhi_ep_destroy_device() completes, mhi_chan->mhi_dev will be a dangling
pointer.

> +	if (mhi_cntrl->flush_async)
> +		mhi_cntrl->flush_async(mhi_cntrl);

[Severity: Critical]
This is a pre-existing issue, but does mhi_ep_process_cmd_ring() also need
to drain async transfers during STOP and RESET commands?

While the global abort path drains in-flight transfers, the per-channel
STOP and RESET command handlers in mhi_ep_process_cmd_ring() send
-ENOTCONN disconnect notifications without calling flush_async().

For example, during a RESET command, the handler calls mhi_ep_ring_reset()
which immediately frees ring->ring_cache:

drivers/bus/mhi/ep/ring.c:mhi_ep_ring_reset() {
    ...
	kfree(ring->ring_cache);
	ring->ring_cache =3D NULL;
    ...
}

Trailing async DMA completions could then invoke mhi_ep_skb_completion() or
mhi_ep_read_completion(), which dereference
ring->ring_cache[ring->rd_offset], causing a NULL pointer dereference.

> +
> +	/* Send channel disconnect status to client drivers */
>  	for (i =3D 0; i < mhi_cntrl->max_chan; i++) {
>  		mhi_chan =3D &mhi_cntrl->mhi_chan[i];
>  		if (!mhi_chan->ring.started)
>  			continue;
> =20
>  		mutex_lock(&mhi_chan->lock);
> -		/* Send channel disconnect status to client drivers */
>  		if (mhi_chan->xfer_cb) {
>  			result.transaction_status =3D -ENOTCONN;
>  			result.bytes_xferd =3D 0;
>  			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
>  		}

[Severity: High]
This is a pre-existing issue, but should mhi_chan->xfer_cb be set to NULL
here to prevent double -ENOTCONN notifications?

The callback pointer is left populated, and immediately afterwards
device_for_each_child() triggers device destruction. This unbinds the
client driver and invokes its bus remove callback, mhi_ep_remove():

drivers/bus/mhi/ep/main.c:mhi_ep_remove() {
    ...
		if (mhi_chan->xfer_cb) {
			result.transaction_status =3D -ENOTCONN;
			result.bytes_xferd =3D 0;
			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
		}

		mhi_chan->xfer_cb =3D NULL;
    ...
}

Since the client driver may clean up its per-transfer resources on the
first -ENOTCONN, could delivering the teardown event a second time risk
double-free bugs in the client driver?

> -
> -		mhi_chan->state =3D MHI_CH_STATE_DISABLED;
>  		mutex_unlock(&mhi_chan->lock);
>  	}
> =20
> -	flush_workqueue(mhi_cntrl->wq);
> -
>  	/* Destroy devices associated with all channels */
>  	device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_ep_destroy_de=
vice);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-mhi-ep-flu=
sh-v3-0-d855e715264e@oss.qualcomm.com?part=3D2
