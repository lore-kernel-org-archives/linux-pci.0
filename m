Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794059976;
	b=nyV4BmbJv2PWwEe3fqXx5Tx7/Df2TMvz5IU59G4waM9Qd4XfNQRxWTVAi1B4V2Xp1sdw
	 5aL1vk4guBR2szzISmhpOK94bXHpcxNxZqBWpd8gMUe80VbBRbfDwTr6aL8Wqsgtzdm/l
	 ojQLFGSKTJPVX2mK+1TQ81BSpw1rgaCt89OX7RB+7jRADCbd6uB6C7qHcMXQuB78u5FY7
	 RhRhJk5Pyr6s0/J2+OkkRuxRU5BaKm6Ek3c3DtnvG5jifS8tkynpUWIvvBL8C+7/33OJ5
	 YcTO9q5PpA/keisMjGP+jNR2MIT0S/JW5SxXt7h1B6bp79BK7EylIMZSHVXyEUHJqbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794059976;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GF0+i5D7FV32pba9/7vqWbZgU5Tb0bNbRx6w5TkDr0Y=;
	b=uKet2sHdPwfEws/11xXxi71gJsA9kVmxLWmy9ExO0tSgAjY8E+xPIRr81VV2AK9Htwn1
	 toHoVFpsFn1F6LxtQPgxxNiZZBpATxWjqVquHGXci+KHeErvmPM+U5jg3Ppr85GjfdCMH
	 GTsZVZpGxK7tpPNf5dSpPzwgBZk9GwPnjAqt/BdLa7URlq+Bwu9ZYBnScteS7jXdqtxmD
	 9N/wWBPncjlRhIyXVo64J8pC2xDr3dUXlat5hKBDKyLkdJsRFSCynMRv0ozlNVQmDp8g6
	 Nik6NhzpEI50A6n80QtR+GgRSr8GTlzBYLZ4PvDwqAyEgnCzBVlPXZDMWKg/j+w72bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oPMY4g6f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B22606A32C;
	Sat,  7 Nov 2026 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oPMY4g6f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378161F0089F;
	Sat,  7 Nov 2026 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794059975;
	bh=GF0+i5D7FV32pba9/7vqWbZgU5Tb0bNbRx6w5TkDr0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oPMY4g6fdECAQzYSegJfDMd6fAdQopndSrpMnp9U0QVORlR1wyA1g04j+A41309uR
	 CETopQr4yexwaATl3ktTbspdnJD+gBuyxkU2KQ9lvDVkWmo/vk0A/a9mNf12EbOIjj
	 0LeoL7PQ1qqhzBGOuDxCIiWYqGDsKDw3A3945J6gm2EpMBOmDEJ/VM5FNu+x+6vEgp
	 3drWAsHjjIGLdKUZW2DR1qMeSU6A1EFhzAXSuhHl+9N0y0WzeDvANRWEF/5ZyVzxVX
	 EUj/iONMCVRhZEBYfIByd2YPVYnsHU0+/p4QpO12e+koAqxAPVfMhrXl3U/ymjMPpS
	 H3Cs1RlZdZbcg==
Message-ID: <sashiko-outbox-202935@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/7] dmaengine: dw-edma: Dynamically append requests
 while running
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261107133027.364237-7-den@valinux.co.jp>
References: <20261107133027.364237-1-den@valinux.co.jp>
 <20261107133027.364237-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 13:59:34 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] dmaengine: dw-edma: stranded or aborted queued descriptors on
  LL reset
--

commit a60bb88e6010e30a59b85799859be8d9e37e8b49
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Dynamically append requests while running

This commit allows dw_edma_device_issue_pending() to append new linked-list
entries while a channel is running and aborts in-flight descriptors when
resetting the ring.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 1d13a25663eff..bcf4fca345914 100644
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
Does this leave unstarted descriptors in chan->vc.desc_issued stranded on an
idle channel after a hardware abort?

When issued descriptors exceed the free LL ring capacity, dw_edma_start_tra=
nsfer()
stops once dw_edma_core_get_free_num(chan) reaches zero, leaving trailing
descriptors in chan->vc.desc_issued with start_burst =3D=3D 0 and done_burs=
t =3D=3D 0.
When dw_edma_abort_interrupt() runs, dw_edma_core_reset_ll() skips those
unstarted descriptors, and dw_edma_abort_interrupt() then sets chan->status=
 to
EDMA_ST_IDLE without starting them:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_abort_interrupt() {
    ...
	if (!chan->non_ll)
		dw_edma_core_reset_ll(chan);
	dw_edma_set_request(chan, EDMA_REQ_NONE);
	chan->status =3D EDMA_ST_IDLE;
	spin_unlock_irqrestore(&chan->vc.lock, flags);
}

Because the client already called dma_async_issue_pending() for those
descriptors, they never execute or complete unless another transfer is issu=
ed
later.

Conversely, if both DW_EDMA_DEFERRED_DONE and DW_EDMA_DEFERRED_ABORT are
pending in dw_edma_irq_work(), dw_edma_ll_interrupt() runs first and calls
dw_edma_ll_advance() -> dw_edma_start_transfer(), which publishes those
waiting descriptors into the freed LL slots (setting start_burst > 0) right
before dw_edma_abort_interrupt() -> dw_edma_core_reset_ll() aborts them with
DMA_TRANS_ABORTED.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107133027.3642=
37-1-den@valinux.co.jp?part=3D6
