Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F52F3B5F63;
	Tue, 28 Jul 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260114; cv=none; b=JExAnjhpKkvdCGplsHpMg2sHcbaDgCUzpJ+B6YW5zmSue5gIJOIdJNSZtzqTef3WYJqKnlra5pJYUWt2ancDSO9RyWZ3G6eSGCYjxU5KrWAwDogg1HQx5nnJjyegshvdueIgkVD8kPsu20I369HWZQCtrC4KWR4baD4n+12hIRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260114; c=relaxed/simple;
	bh=XZrIwxEJe7vh568v5zVuUJrm69vi5zgClUmvFuIImlU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZE8N1njPcRO6h6uY1C3X4RtaGn+7kD5iKQH7F4U3Of1L9kJROERTvrADbA2zfiWmEIGlXIPgVPDDFP2sXfzXAVY3e89fqbqvLLiTTbv3nF8fbowGE4FRBVXvgQyvoG3N12fzpr3DOvqGjeUEm6LS10OLnFXv5cJWqSC2xvcQXAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLC9x+Ey; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLC9x+Ey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F651F00A3A;
	Tue, 28 Jul 2026 17:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260113;
	bh=xVlu875BfYZszl0P/7trdFDWGEQuWI2pWWv2KX6bf8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bLC9x+EyWKPaON0NaGbfQGdRR1qjElwGQ0/7zrH5B3lxJ7PMplx/vxjf7H1aY9hF3
	 j92+rBdFvbhjtWO5NwTk24g+7ql8WjkeOa/wIxiZ1wkcjfbbkH0BRHp8+qqG/X/N/l
	 6zObaYfsql+O9M/KDsS3V1Cl+qSwBvw9dYZJIQa9GOIjVAvLtQ1CUuAs2uPPaqKN1e
	 740NUX/h6BzB58N86YkGXJFPAhOF17223uwlddMI7q4ZSa2yE55loX4ukdvHLy5bDN
	 cu/PJ6q0RQg1P1c4xCuor6tw7KfwvX0UN38uV7av/SzJKdjwLRgs3YVieFUc8snqwn
	 +WJKlXhbi6c9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/12] dmaengine: switchtec-dma: halt channel on
 alloc_chan_resources error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260728171523.112244-5-logang@deltatee.com>
References: <20260728171523.112244-1-logang@deltatee.com>
 <20260728171523.112244-5-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:35:12 +0000
Message-Id: <20260728173512.F3F651F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Intentionally leaking descriptors to prevent hardware UAF leaves d=
angling pointers in the channel structure, causing a UAF if a subsequent al=
location fails, or a permanent leak if it succeeds.

Pre-existing issues:
- [Critical] Zeroing DMA base registers while the channel fails to halt red=
irects active DMA transactions to physical address 0.
- [High] Holding a spinlock while polling for up to 100ms violates core ker=
nel locking rules and can trigger softlockups.
--

--- Patch [4]: [PATCH v4 04/12] dmaengine: switchtec-dma: halt channel on a=
lloc_chan_resources error ---
commit 886fa8092e9d55e67d82b2e1ee9d1125fcadac6d
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: halt channel on alloc_chan_resources error

This patch modifies the error unwind path in channel allocation to call
switchtec_dma_chan_stop() before disabling the channel. This prevents a
hardware use-after-free by ensuring the channel is successfully halted
before freeing the descriptor rings. If the halt fails, it skips freeing
the rings.

Link: https://lore.kernel.org/dmaengine/20260717223647.F0A051F000E9@smtp.ke=
rnel.org
Link: https://lore.kernel.org/dmaengine/20260727185101.D221C1F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index cbbc9ad082471..25b988e9b4afb 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1047,6 +1047,10 @@ static int switchtec_dma_alloc_chan_resources(stru=
ct dma_chan *chan)
>  	swdma_chan->comp_ring_active =3D false;
>  	spin_unlock_bh(&swdma_chan->complete_lock);
>  err_disable_channel:
> +	if (switchtec_dma_chan_stop(swdma_chan)) {

[Severity: Critical]
This is a pre-existing issue, but does writing 0 to the DMA base registers
redirect active DMA transactions to physical address 0x0?

Looking at switchtec_dma_chan_stop(), if the halt times out, the registers
are still cleared:

drivers/dma/switchtec_dma.c:switchtec_dma_chan_stop() {
        rc =3D halt_channel(swdma_chan);
        ...
        if (rc)
                pci_err(pdev, "Channel %d halt timed out...");

        writel(0, &swdma_chan->mmio_chan_fw->sq_base_lo);
        ...
}

Since the channel is still unhalted and active, modifying these live
registers might cause ongoing or pending hardware DMA descriptor fetches to
target physical address 0x0.


[Severity: High]
This is a pre-existing issue, but can this call chain trigger softlockups
by holding a spinlock for up to 100ms?

switchtec_dma_chan_stop() calls halt_channel(), which acquires a spinlock
before polling:

drivers/dma/switchtec_dma.c:halt_channel() {
        spin_lock(&swdma_chan->hw_ctrl_lock);
        writeb(SWITCHTEC_CHAN_CTRL_HALT, &chan_hw->ctrl);
        ret =3D wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_HALTED, tr=
ue);
        spin_unlock(&swdma_chan->hw_ctrl_lock);
}

And wait_for_chan_status() performs a 100ms atomic polling loop:

drivers/dma/switchtec_dma.c:wait_for_chan_status() {
        return readl_poll_timeout_atomic(&chan_hw->status, status,
                                         ..., 10, 100 * USEC_PER_MSEC);
}

Holding the spinlock disables preemption for the duration of the timeout,
which might cause severe scheduling latency spikes.

> +		disable_channel(swdma_chan);
> +		return rc;

[Severity: High]
When returning here, the descriptors are intentionally leaked to prevent a
hardware use-after-free, but do the pointers in swdma_chan remain populated?

If a subsequent allocation fails in switchtec_dma_alloc_desc(), it will call
switchtec_dma_free_desc() which frees these exact pointers while the hardwa=
re
might still be accessing them.=20

If the allocation succeeds, the pointers will be overwritten:

drivers/dma/switchtec_dma.c:switchtec_dma_alloc_desc() {
        swdma_chan->hw_sq =3D dma_alloc_coherent(..., GFP_NOWAIT);
}

Could this lead to a use-after-free on a subsequent allocation error, or a
permanent memory leak if the pointers are overwritten?

> +	}
>  	disable_channel(swdma_chan);
>  err_free_desc:
>  	switchtec_dma_free_desc(swdma_chan);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728171523.1122=
44-1-logang@deltatee.com?part=3D4
