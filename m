Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6193B3C05;
	Mon, 31 Aug 2026 22:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788213865; cv=none; b=Z9Kum9E7yWTUzy+vT9SoySwMZrDBrfeO3o8vbl5zZceWrz6Ll3NorX9nlUMq90vARdZz5yF5bzFOVrkf+0oDD/Mr02tLqcXjdDzcqjJBW5ab9Aq23n41BGPI0XKwKjwGDHqSWrVSf1eEIseZ8nLgN7a430NJFm6PJblbYhTLotE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788213865; c=relaxed/simple;
	bh=72x5jFQ6I8Crt5XlI5K4kCBkNAAhHeAOzNpxHDANRMQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kh8hTsnrbDnGpOk88SAoBLjGtaaK29mEiFu+zjFjvCsJYaOxYqQYwpiP5cgkO5kDbdHRp01SzMHPnz7h9whunHH5HGUl0Py5vDYF1g6V2ONb1HeYBsBlbOMqfGUsIiyAO2FI8Kg9nPQJLnR5aTUUvZDYFACaPUvQ9pEDOzm97fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8hOnke8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8hOnke8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846361F000E9;
	Mon, 31 Aug 2026 22:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788213860;
	bh=bOvJIYUPNxFJLvNnCJ7NLU7ZGtC4XKjzK7AKUmXWY+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I8hOnke8LaQCSOEuTX2zwxDj1EsU93Dod5boISKIkzUQQfYgkcuTeahc3a5nLluC5
	 L48h/TDxr6dVogF1psiBQT42m9trbfPi93iTxp1d3BGNt+IvhgFVlM9uzhnvaWgVuA
	 6n/mCbu26xioRaDIILCglQeOHcumyZlMCtGFa5dzBdNnaVdJ1FbLhOn4M4n3pJHzTp
	 b5BKUT4oI9q23ub46hf8e4zr7AHVgAqe69Y42sRQBjGJwFoE/deOcbFN+65cbUkY9K
	 ndkFKPWct1Fr4l0uhs/HAFE1KZlxyqR0lU1rOykBzLwDLrdWDMg2gc7qK+Gj8Fc5s9
	 djjiHcyTXqGSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/12] dmaengine: switchtec-dma: halt channel on
 alloc_chan_resources error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260831191403.207631-5-logang@deltatee.com>
References: <20260831191403.207631-1-logang@deltatee.com>
 <20260831191403.207631-5-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:04:19 +0000
Message-Id: <20260831220420.846361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Zeroing DMA base registers when hardware fails to halt redirec=
ts runaway DMA to physical address 0x0.
- [High] Intentional descriptor leak leaves stale pointers intact, causing =
Use-After-Free of active DMA memory during allocation retries.
- [High] Mishandling of `-ENODEV` causes a deterministic, permanent memory =
leak of descriptor rings upon device hot-unplug.
- [High] The mitigation for `unhalt_channel()` timeout is completely bypass=
ed because `halt_channel()` instantly returns success.
- [High] The intentional memory leak on channel initialization timeout crea=
tes an unbounded memory exhaustion vector if allocation is retried.
- [Medium] The error path needlessly leaks purely software-backed structure=
s (`desc_ring`) when attempting to leak hardware rings.
--

commit 28f07bd0419a79f1993daba83975c013aac2cba4
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: halt channel on alloc_chan_resources error

The error-unwind path called disable_channel() before freeing the
descriptor rings, but that only clears the enable bit with an
unflushed write -- it doesn't halt the channel or clear its DMA base
address registers. If unhalt_channel() timed out, the channel's actual
state is unknown at that point, so nothing guarantees the hardware
isn't still touching the rings when they're freed.

Link: https://lore.kernel.org/dmaengine/20260717223647.F0A051F000E9@smtp.ke=
rnel.org
Link: https://lore.kernel.org/dmaengine/20260727185101.D221C1F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index e2bb65237d2c9..2d5ba194c99a1 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1047,6 +1047,10 @@ static int switchtec_dma_alloc_chan_resources(stru=
ct dma_chan *chan)
>  	swdma_chan->comp_ring_active =3D false;
>  	spin_unlock_bh(&swdma_chan->complete_lock);
>  err_disable_channel:
> +	if (switchtec_dma_chan_stop(swdma_chan)) {

[Severity: High]
Is the mitigation for an unhalt_channel() timeout bypassed here?

If unhalt_channel() times out, the SWITCHTEC_CHAN_STS_HALTED bit remains 1.

When switchtec_dma_chan_stop() subsequently calls halt_channel():

drivers/dma/switchtec_dma.c:halt_channel() {
    ...
	ret =3D wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_HALTED, true);
    ...
}

Because the bit is already 1, wait_for_chan_status() instantly returns 0.

Does this cause the error path to mistakenly perceive a successful halt and
proceed to free the descriptor rings while the hardware state is unknown?

[Severity: Critical]
Does zeroing the DMA base registers when the hardware fails to halt redirect
runaway DMA to physical address 0x0?

Looking at switchtec_dma_chan_stop():

drivers/dma/switchtec_dma.c:switchtec_dma_chan_stop() {
    ...
	if (rc)
		pci_err(pdev,
			"Channel %d halt timed out, clearing DMA base registers anyway\n",
			swdma_chan->index);

	writel(0, &swdma_chan->mmio_chan_fw->sq_base_lo);
    ...
}

If the hardware is unhalted and active, and it dynamically fetches the zero=
ed
base addresses, can it begin performing DMA at physical address 0x0, causing
severe memory corruption?

> +		disable_channel(swdma_chan);
> +		return rc;

[Severity: High]
Does this intentional memory leak on timeout create an unbounded memory
exhaustion vector?

If a client driver repeatedly retries alloc_chan_resources after it fails
with -ETIMEDOUT, could each attempt continuously leak kernel memory until t=
he
system is exhausted?

[Severity: Medium]
Does this error path needlessly leak purely software-backed structures?

While returning early prevents buggy hardware from writing to the physical
rings, this broadly skips freeing desc_ring.

Since the hardware has no knowledge of this purely software-backed array, c=
an
this leak kernel memory unnecessarily?

[Severity: High]
Can this intentional descriptor leak leave stale pointers intact, leading to
a use-after-free during allocation retries?

If a client retries alloc_chan_resources after a timeout, the pointers for
hw_cq and desc_ring are not cleared.

When switchtec_dma_alloc_desc() is called again:

drivers/dma/switchtec_dma.c:switchtec_dma_alloc_desc() {
    ...
	swdma_chan->hw_sq =3D dma_alloc_coherent(swdma_dev->dma_dev.dev, size,
					       &swdma_chan->dma_addr_sq,
					       GFP_NOWAIT);
	if (!swdma_chan->hw_sq) {
		rc =3D -ENOMEM;
		goto free_and_exit;
	}
    ...
}

If the coherent allocation for hw_sq fails (e.g., -ENOMEM), the error path
calls switchtec_dma_free_desc().

Since hw_cq still holds the stale pointer to the leaked ring, would it be
erroneously freed while the unhalted hardware might still be actively writi=
ng
to it?

> +	}
>  	disable_channel(swdma_chan);
>  err_free_desc:
>  	switchtec_dma_free_desc(swdma_chan);

[Severity: High]
Does mishandling -ENODEV cause a permanent memory leak of the descriptor
rings upon device hot-unplug?

Looking at switchtec_dma_free_chan_resources():

drivers/dma/switchtec_dma.c:switchtec_dma_free_chan_resources() {
    ...
	rc =3D switchtec_dma_chan_stop(swdma_chan);
	switchtec_dma_abort_desc(swdma_chan, 0);
	if (!rc)
		switchtec_dma_free_desc(swdma_chan);
    ...
}

If the device is removed and switchtec_dma_chan_stop() returns -ENODEV from
halt_channel(), does the !rc check evaluate to false and permanently skip
freeing the descriptors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831191403.2076=
31-1-logang@deltatee.com?part=3D4
