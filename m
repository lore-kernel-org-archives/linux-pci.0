Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810834;
	b=AbZTwt1YAyaKXt9fIa3JYcUqsgQIN4U03wQu5wAHmxBSJNDr2lwCiZad4IbUhcS8bYeO
	 FmkizbamOXuLrRFTEPOncdKxpzTqvVC3P/ypXn4616G4RHEBUFcwIrBdSBamsrgHr1meL
	 Gk0m2eBX4x8dd5augz4sk8Re8R8sqPa8G357YLbvN7vT2ZdrU0S9AfmYEEfj81KKWAkvN
	 +mhFkW88bA45f4DY9y9gS3wITUefs/jPgPomWWfr2WOtXVKLCEUE9ke/0DgZ0KbLb52Dr
	 8tUk0/OdNS06KiA2326zYNADjuQqQ8t3kRAWTGIgv2H4pjguLLDecxo54KO4gZUMw4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810834;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l8vo9PzksxUeqCMCdcZ0lPdiwP4q4S83LNgWEKSKu1E=;
	b=wZ+Uo7JPy9/ewijWOeiF0XGPCSh2eEbs6dGBq7M3cVyGqpXo72LRwq6nmLcycEK9SpjY
	 /1LUiYpe5aA63T945LLXtSD7bid9vHaBxKZ3KV7LGVCQBonS6CYWkgzmRH9kCiP5aorel
	 5mkkBkOaf2ePEielKsw8cddWRWGK1InW08A3e61Q8ICPZrDVAI7P2N9xNTKsU+zMnmkz/
	 +6VpHYwpJwI05IKsU7dbtbJhAlMVw+rHxsxcfPwc3uQaJetYOcUpNMU2ZlMpfjYkcGz20
	 99j7kn+z/Q3QGSkaN2/IjSus1VdTKTFtAEBGPy28YVprvdXS4nvyRJ96lWdVfdoSiGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ev7PFO+w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED4D6083616;
	Wed,  4 Nov 2026 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ev7PFO+w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B905C1F000C1;
	Wed,  4 Nov 2026 16:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793810834;
	bh=l8vo9PzksxUeqCMCdcZ0lPdiwP4q4S83LNgWEKSKu1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ev7PFO+w+qCa9ym+2R5eqiU+mFBjDM/dW8jCWMhmL2EuP7jDdN4Nv0A5v6oBfOTvD
	 2O6YBO/ZIZg3Z0FDFiMne90n3DL0BroP1Qw9LU3rliGiD8X75lxH34cB2e6gmQnKPo
	 YU84YQa4uIDhKFDf+lVJAv6MT/JI2b9/T8khCkN0F9xgTwZaN4UtxOq9LfO+5mkZ+Z
	 78E5ZQINjgnzq+d9VfVS68+h3LQ6lI89o/fzcZ70TQMwNZBTn6NgpEjftVh/IesGhj
	 l9gBbUVC3+8wyZFbEf+V8YpxkrsGC3WXXovbJtKoakOJ89XxRVAqyZiRJCnZw4eVTo
	 k1mgNW0x11MQw==
Message-ID: <sashiko-outbox-197681@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/7] dmaengine: dw-edma: Dynamically append requests
 while running
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261104161227.1742005-7-den@valinux.co.jp>
References: <20261104161227.1742005-1-den@valinux.co.jp>
 <20261104161227.1742005-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:47:13 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] dmaengine: dw-edma: premature completion in dw_edma_ll_advance() o=
n append
- [Medium] dmaengine: dw-edma: stranded or aborted queued descriptors on LL=
 reset
--

commit 09d38b6dc815a996191d342c3fb4a8c29aef4401
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Dynamically append requests while running

This commit updates dw_edma_start_transfer() and
dw_edma_device_issue_pending() to append descriptors into free LL ring slots
while a channel is already busy, and updates dw_edma_core_reset_ll() and
dw_edma_device_resume() to handle multiple pending descriptors in the LL
ring.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index e2f2a535d5ad1..69b5488282de3 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -111,8 +111,22 @@ static void dw_edma_complete_vdesc(struct virt_dma_d=
esc *vd,
> =20
>  static void dw_edma_core_reset_ll(struct dw_edma_chan *chan)
>  {
> +	struct virt_dma_desc *vd, *tmp;
>  	u32 i;
> =20
> +	/*
> +	 * We cannot tell which pending entries completed before the reset.
> +	 * Abort their descriptors to avoid repeating a transfer.
> +	 */
> +	list_for_each_entry_safe(vd, tmp, &chan->vc.desc_issued, node) {
> +		struct dw_edma_desc *desc =3D vd2dw_edma_desc(vd);
> +
> +		if (desc->start_burst =3D=3D desc->done_burst)
> +			continue;
> +
> +		dw_edma_complete_vdesc(vd, DMA_TRANS_ABORTED);
> +	}

[Severity: Medium]
What happens to unstarted descriptors that remain in chan->vc.desc_issued
when a hardware abort occurs?

When dw_edma_device_issue_pending() moves submitted descriptors to
chan->vc.desc_issued and dw_edma_start_transfer() fills the LL ring, any
trailing descriptors stay in chan->vc.desc_issued with start_burst =3D=3D 0=
 and
done_burst =3D=3D 0.

If an abort occurs on an earlier in-flight descriptor,
dw_edma_core_reset_ll() skips those unstarted descriptors because
desc->start_burst =3D=3D desc->done_burst, leaving them in chan->vc.desc_is=
sued.
However, dw_edma_abort_interrupt() then transitions the channel straight to
EDMA_ST_IDLE without starting them:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_abort_interrupt() {
	...
	if (!chan->non_ll)
		dw_edma_core_reset_ll(chan);
	dw_edma_set_request(chan, EDMA_REQ_NONE);
	chan->status =3D EDMA_ST_IDLE;
	spin_unlock_irqrestore(&chan->vc.lock, flags);
}

Won't those remaining descriptors stay stranded in chan->vc.desc_issued on =
an
idle channel unless the client later issues another transfer?

Also, if an earlier descriptor in the ring raised DW_EDMA_DEFERRED_DONE
before a subsequent entry raised DW_EDMA_DEFERRED_ABORT, dw_edma_irq_work()
processes DW_EDMA_DEFERRED_DONE first:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_irq_work() {
		if (events & DW_EDMA_DEFERRED_DONE) {
			if (chan->non_ll)
				dw_edma_done_interrupt(chan);
			else
				dw_edma_ll_interrupt(chan);
		}
		if (events & DW_EDMA_DEFERRED_ABORT)
			dw_edma_abort_interrupt(chan);
}

In that case, dw_edma_ll_interrupt() -> dw_edma_ll_advance() reclaims the
completed slots and calls dw_edma_start_transfer(), publishing the waiting
unstarted descriptors into the LL ring (setting start_burst > 0), only for
dw_edma_abort_interrupt() -> dw_edma_core_reset_ll() to immediately abort
them in the same work pass.

[ ... ]

> @@ -610,11 +638,16 @@ static void dw_edma_device_issue_pending(struct dma=
_chan *dchan)
> =20
>  	spin_lock_irqsave(&chan->vc.lock, flags);
>  	if (chan->configured && vchan_issue_pending(&chan->vc) &&
> -	    chan->request =3D=3D EDMA_REQ_NONE &&
> -	    chan->status =3D=3D EDMA_ST_IDLE) {
> -		chan->status =3D EDMA_ST_BUSY;
> -		dw_edma_start_transfer(chan);
> -		dw_edma_core_ch_maybe_doorbell(chan);
> +	    chan->request =3D=3D EDMA_REQ_NONE) {
> +		if (chan->status =3D=3D EDMA_ST_IDLE) {
> +			chan->status =3D EDMA_ST_BUSY;
> +			dw_edma_start_transfer(chan);
> +			dw_edma_core_ch_maybe_doorbell(chan);
> +		} else if (!chan->non_ll &&
> +			   chan->status =3D=3D EDMA_ST_BUSY) {
> +			dw_edma_start_transfer(chan);
> +			dw_edma_ll_advance(chan, false);
> +		}
>  	}
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>  }

[Severity: High]
Could calling dw_edma_ll_advance(chan, false) immediately after appending n=
ew
LL entries here cause an in-flight descriptor to be completed prematurely?

When a first dw_edma_device_issue_pending() call transitions the channel fr=
om
EDMA_ST_IDLE to EDMA_ST_BUSY and rings the doorbell, the hardware channel
status can briefly continue to report DMA_COMPLETE with transfer_size =3D=
=3D 0
before the engine begins fetching the entry at ll_done.

If a second dw_edma_device_issue_pending() call runs during that window,
dw_edma_start_transfer() appends a second entry (making used >=3D 2) and ca=
lls
dw_edma_ll_advance(chan, false):

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_ll_advance() {
	...
	stopped =3D dw_edma_ll_stopped(chan);
	/*
	 * HDMA updates LLP at watermark events while running. Use running
	 * samples only when processing an LL interrupt.
	 */
	if (stopped || event)
		dw_edma_ll_consume(chan, dw_edma_core_ll_cur_idx(chan),
				   stopped);
}

Because dw_edma_ll_stopped(chan) and dw_edma_core_ll_cur_idx(chan) are
separate MMIO reads, dw_edma_ll_stopped(chan) can observe the stale
post-doorbell stopped state (stopped =3D true) just before the engine starts
processing the first entry at ll_done and advances DMA_LLP to ll_done + 1
while the payload transfer is still in flight.

Passing idx =3D ll_done + 1 and stopped =3D true to dw_edma_ll_consume() th=
en
uses the stopped boundary (idx instead of idx - 1) and bypasses the
(!stopped && done =3D=3D used) check:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_ll_boundary() {
	...
	/* After a stop, LLP points past the completed entries. */
	if (stopped)
		return idx =3D=3D chan->ll_max ? 0 : idx;

	/*
	 * DMA_LLP can advance before payload completion. Keep the boundary
	 * one entry behind it, wrapping at the start of the ring.
	 */
	return (idx + chan->ll_max - 1) % chan->ll_max;
}

Wouldn't that advance chan->ll_done past the first entry and complete the
first descriptor with DMA_TRANS_NOERROR while hardware is still transferring
its payload, as well as ring a duplicate doorbell at the end of
dw_edma_ll_advance()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161227.1742=
005-1-den@valinux.co.jp?part=3D6
