Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5904C8FFC;
	Tue, 21 Jul 2026 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651133; cv=none; b=m5kNAX6gotfloD7O3+JBSJG0OS8eMQ1h4uQwkK1nHtxF+j/jOr/j1zDCzdPoMNKZZqke+Rpq+3Zg/txwSJjCUFXlhUu3DQiYqsQz9i/7Kt3A85/FqE6n5SmEFvBnblIzbF75lhGpA+v/jrD1m1uxWEyMqF2Av0TSEUQ6LD/s4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651133; c=relaxed/simple;
	bh=73QYEl3T7U2aDAfu+aLsq+H7/ZktyWK823wA1OWjZRY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XhfVLN9pk4/QNXM+YxNrGNUkwLqvaVGnIsdFfiLVEQO5IGcQWCPr6pIJmKEUOnMNeti+ckBwkp3iAwtw+IxASczkZidzJ9qoeZWW97LBXcOijlzrm+v4XhbO/WrlKfL+jHokAArKcv6ze3+t6EvXD8n8PbdorDZcipEvod0lpt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rw9TpkUl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rw9TpkUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA01A1F01560;
	Tue, 21 Jul 2026 16:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784651132;
	bh=jWe0hakeeWSbej/uSxmrXaLuEz4kZpBy3aYeGIKN2iA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rw9TpkUlVvmzBNg7NpsXw98v1fCtBwXV9Vfj8mwBF62f5rw5GIe0itJ0C0qLgtS/S
	 hy5HkAC+6pPP08yBkyYu7QeclKsS+6GkGmBsFnmwgyPytZ15ryKTJVOaUiWCRWvRXj
	 abkCkJdHqK0cN988fkdpolM00zlHOdKKMHjcTd1jPQFlUDbp2jBibHmV+IyF7uJ+r/
	 kB+Gg1XIn3KOSGc3VEHjcuBMmEdnSflJMv7YD4FC0NRGW3unqttREZETTxLIxVxRlY
	 wro2HgKugX+Ueo51I4eBFQJHaBw/2dXSyC5QhmMxStScskH1ddDyzaN948DTikrFA7
	 dnUx6aJzFizLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/11] dmaengine: switchtec-dma: halt channel on
 alloc_chan_resources error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260721155739.62120-4-logang@deltatee.com>
References: <20260721155739.62120-1-logang@deltatee.com>
 <20260721155739.62120-4-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 16:25:31 +0000
Message-Id: <20260721162531.BA01A1F01560@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Early return in `switchtec_dma_chan_stop()` on hardware timeou=
t fails to clear DMA base registers, leading to a Use-After-Free of DMA mem=
ory by the active hardware when descriptors are unconditionally freed.
- [High] The completion handler `switchtec_dma_cleanup_completed()` synchro=
nously invokes client callbacks while holding the `complete_lock` spinlock,=
 creating a severe deadlock hazard.
- [High] The driver intentionally leaves the `submit_lock` spinlock locked =
when returning from `switchtec_dma_prep_desc()`, requiring the client to su=
bmit the descriptor to release it. This breaks DMA API semantics and risks =
permanent deadlock.
- [High] Holding a spinlock while busy-waiting for hardware status for up t=
o 100ms severely degrades system scheduling latency.
--

--- Patch [3]: [PATCH v2 03/11] dmaengine: switchtec-dma: halt channel on a=
lloc_chan_resources error ---
commit 53cba0d04c9fe827ca20ae65df9b3ba987573e8e
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: halt channel on alloc_chan_resources error

This commit modifies the error unwind path in
switchtec_dma_alloc_chan_resources() to call switchtec_dma_chan_stop()
before freeing descriptors, aiming to halt the channel and clear DMA base
registers.

Link: https://lore.kernel.org/dmaengine/20260717223647.F0A051F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index f77da31aeb65e..107769cca772f 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1040,6 +1040,7 @@ static int switchtec_dma_alloc_chan_resources(struc=
t dma_chan *chan)
>  	swdma_chan->comp_ring_active =3D false;
>  	spin_unlock_bh(&swdma_chan->complete_lock);
>  err_disable_channel:
> +	switchtec_dma_chan_stop(swdma_chan);

[Severity: Critical]
This isn't a bug introduced by this patch, but does this error path risk a
DMA use-after-free if the hardware becomes unresponsive?

Looking at switchtec_dma_chan_stop():

drivers/dma/switchtec_dma.c:switchtec_dma_chan_stop() {
        rc =3D halt_channel(swdma_chan);
        if (rc)
                return;

        // ...
        writel(0, &swdma_chan->mmio_chan_fw->sq_base_lo);
        // ...
}

If halt_channel() times out and returns an error, switchtec_dma_chan_stop()
returns early and bypasses clearing the DMA base registers. The error path
then proceeds to blindly free the descriptor rings via
switchtec_dma_free_desc().

If the hardware later resumes, couldn't it overwrite the freed system memory
using the uncleared physical addresses?

>  	disable_channel(swdma_chan);
>  err_free_desc:
>  	switchtec_dma_free_desc(swdma_chan);

[ ... ]

[Severity: High]
This is a pre-existing issue, but is it safe to invoke client callbacks whi=
le
holding the completion spinlock?

drivers/dma/switchtec_dma.c:switchtec_dma_cleanup_completed() {
        spin_lock_bh(&swdma_chan->complete_lock);
        // ...
        dmaengine_desc_get_callback_invoke(&desc->txd, &res);
        // ...
        spin_unlock_bh(&swdma_chan->complete_lock);
}

If a client callback calls standard DMA engine APIs like
dmaengine_terminate_all() to handle errors, those driver functions will
attempt to acquire the exact same non-recursive complete_lock. Does this
create a deadlock hazard?


[Severity: High]
This isn't a bug introduced by this patch, but does switchtec_dma_prep_desc=
()
leak a spinlock to the caller?

drivers/dma/switchtec_dma.c:switchtec_dma_prep_desc() {
        spin_lock_bh(&swdma_chan->submit_lock);
        // ...
        /* return with the lock held, it will be released in tx_submit */
        return &desc->txd;
}

The DMA Engine API does not guarantee that a prepared descriptor will be
submitted. If a client aborts and discards the descriptor before submission,
does this leave the CPU permanently deadlocked with bottom-halves disabled?

Also, if a client attempts to prepare multiple segments in sequence before
submitting them, wouldn't the second call to switchtec_dma_prep_desc()
attempt to acquire the already-held submit_lock?


[Severity: High]
This is a pre-existing issue, but does the channel halting logic introduce
massive scheduling latency spikes?

drivers/dma/switchtec_dma.c:halt_channel() {
        spin_lock(&swdma_chan->hw_ctrl_lock);
        writeb(SWITCHTEC_CHAN_CTRL_HALT, &chan_hw->ctrl);
        ret =3D wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_HALTED, tr=
ue);
        spin_unlock(&swdma_chan->hw_ctrl_lock);
}

The wait_for_chan_status() function uses readl_poll_timeout_atomic() with a
100ms timeout.

If the hardware is slow or unresponsive, will the CPU be trapped in a
busy-wait loop with preemption disabled for up to 100 milliseconds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721155739.6212=
0-1-logang@deltatee.com?part=3D3
