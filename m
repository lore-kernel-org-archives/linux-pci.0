Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E443C0A1F;
	Mon, 27 Jul 2026 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785178263; cv=none; b=jWP6q6rJRGF9hApXdBq1iWW98rQ8egWmeguFaLNJ3V1ZIB9+dEKYEopAgqxQ2nm30pCJJAfMeCfpDqr5Xn/cTXd8d+ScI3/eDPN0uarqBaP0QkRwYYQr/FxJgjhOjaqtyPrABkvm/hFYom5LByphaIe1Jwmy+BAVNuGJaLXQD/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785178263; c=relaxed/simple;
	bh=Vro2OjEqRvTsPwXf6L+d9eqD6mu2et4+V4tOfacTu/k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oyoCVuUubgC/yyGHopUDJkQr5zsrVaVsqKrjEd1mvXVg9KH1JJuEaidKL44VZA7+2BfYU9xfm/PzXdnbe+nA6Aus1em/yFHnzinMRErxgmeA8br6C9BNwH2YzAi8jsYHcYc32hjFuDxos+eD/OjeQW3VleJ+os9Trmo1mr2I1EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqLGO5Cx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqLGO5Cx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D221C1F000E9;
	Mon, 27 Jul 2026 18:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785178262;
	bh=jPRUZYIOtDAfhr7afr1rCR64A773ZsbAxZcdQniv+pA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fqLGO5Cx2lRhxNczynrqaeGRfpT3LmKNrSzFP05MzBjMuY/TrxV9b4jTXMBGZQBH9
	 HS/BtdbI6AuKpRJEzS6h2MSB04j/vR0Mkp/iU2Wf+bhWKA/0ZgAjmkNUf+UInqZhwj
	 DPU0Y/S70uwHULx7ME3EWq+WP2VscwRsiy8rtQpxwA7CbyvAFJZRpIkBaYXF8/bpD5
	 ArcpWGNUao9lTNcIxtvFCcleq7L2ZZu+laoGaOcL7sxDUiu5cWxJQSgzbnaYrWF2v3
	 e/qN7ZJZ/QVpZxbroPxsN9dbWkzew4LXf7RcCTEU6WS9Kao7i4KLYThZTxeh9mlUZv
	 ZEnSDP+hpT6TA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/11] dmaengine: switchtec-dma: halt channel on
 alloc_chan_resources error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260727181526.9672-4-logang@deltatee.com>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-4-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:51:00 +0000
Message-Id: <20260727185101.D221C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Incomplete fix / DMA Use-After-Free due to early return in switcht=
ec_dma_chan_stop() on halt timeout.

Pre-existing issues:
- [High] Soft lockup and severe latency spikes due to 100ms atomic busy-wai=
ting under a spinlock.
- [High] Extreme allocation brittleness due to requesting 32,768 descriptor=
s with GFP_NOWAIT.
- [High] DMA Use-After-Free in switchtec_dma_free_chan_resources() due to i=
ncorrect teardown ordering.
- [High] Massive Use-After-Free of swdma_dev during driver removal.
--

--- Patch [3]: [PATCH v3 03/11] dmaengine: switchtec-dma: halt channel on a=
lloc_chan_resources error ---
commit 647e1927ea58080fcbb88ef03dd8a74aa7555178
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: halt channel on alloc_chan_resources error

The commit adds a call to switchtec_dma_chan_stop() on the error-unwind
path of switchtec_dma_alloc_chan_resources(). This aims to synchronously=20
halt the channel and clear DMA base registers before freeing the
descriptors, preventing a potential use-after-free if the hardware=20
continues accessing the rings.

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
>  	disable_channel(swdma_chan);
>  err_free_desc:
>  	switchtec_dma_free_desc(swdma_chan);

[Severity: High]
Does this completely resolve the use-after-free if the hardware is=20
unresponsive?

Looking at switchtec_dma_chan_stop(), if halt_channel() times out, the=20
function returns early without clearing the DMA base registers:

drivers/dma/switchtec_dma.c:switchtec_dma_chan_stop() {
        rc =3D halt_channel(swdma_chan);
        if (rc)
                return;
        ...
        writel(0, &swdma_chan->mmio_chan_fw->sq_base_lo);
        ...
}

If that happens, execution continues to disable_channel() which does an
unflushed write, and then switchtec_dma_free_desc() unconditionally frees
the descriptors while the hardware might still be accessing them.


[Severity: High]
This is a pre-existing issue, but can this lead to soft lockups or severe=20
latency spikes?

In halt_channel(), wait_for_chan_status() is called while holding a spinloc=
k:

drivers/dma/switchtec_dma.c:halt_channel() {
        spin_lock(&swdma_chan->hw_ctrl_lock);
        writeb(SWITCHTEC_CHAN_CTRL_HALT, &chan_hw->ctrl);
        ret =3D wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_HALTED, tr=
ue);
        spin_unlock(&swdma_chan->hw_ctrl_lock);
        ...
}

wait_for_chan_status() uses readl_poll_timeout_atomic() with a 100ms timeou=
t.
Is it safe to block preemption for up to 100 milliseconds if the hardware=20
is slow to respond?


[Severity: High]
This isn't a bug introduced by this patch, but does this allocation strateg=
y=20
cause issues under memory pressure?

drivers/dma/switchtec_dma.c:switchtec_dma_alloc_desc() {
        for (i =3D 0; i < SWITCHTEC_DMA_RING_SIZE; i++) {
                desc =3D kzalloc_obj(*desc, GFP_NOWAIT);
                if (!desc) {
        ...
}

SWITCHTEC_DMA_RING_SIZE is 32,768. Iteratively requesting 32,768 allocation=
s=20
with GFP_NOWAIT forbids sleeping and memory reclaim. Could this rapidly=20
drain atomic memory pools and fail on slightly fragmented systems?


[Severity: High]
This is a pre-existing issue, but could this teardown ordering result in=20
a use-after-free?

drivers/dma/switchtec_dma.c:switchtec_dma_free_chan_resources() {
        switchtec_dma_chan_stop(swdma_chan);
        switchtec_dma_abort_desc(swdma_chan, 0);
        switchtec_dma_free_desc(swdma_chan);
       =20
        disable_channel(swdma_chan);
        ...
}

If switchtec_dma_chan_stop() times out and fails to halt the channel,=20
the descriptors are freed by switchtec_dma_free_desc() before the=20
channel enable bit is cleared by disable_channel(). Could the active=20
hardware continue executing and corrupt the freed descriptor memory?


[Severity: High]
This is a pre-existing issue, but does this sequence cause a use-after-free=
=20
of swdma_dev?

drivers/dma/switchtec_dma.c:switchtec_dma_remove() {
        ...
        dma_async_device_unregister(&swdma_dev->dma_dev);
       =20
        iounmap(swdma_dev->bar);
        ...
}

If dma_async_device_unregister() drops the last reference to the DMA device,
it synchronously invokes the release callback, switchtec_dma_release(),=20
which frees swdma_dev. Does this mean iounmap(swdma_dev->bar) will=20
dereference the freed swdma_dev pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727181526.9672=
-1-logang@deltatee.com?part=3D3
