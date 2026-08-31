Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8097E3A7193;
	Mon, 31 Aug 2026 21:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788213109; cv=none; b=FPKlV1rBwHzVeT0kWzqxUjkKp2Vl6UCekdbczf+Bv1Eg5RXZ49N54W55DlB9m82RhUXRXRxgUS3z6f/ZJfFsokryk6sA+1G7GvqCpoZoCMe5YhhnZihfY8jHxOxX1NXE1Y9weuXx62eRyDl30bcujBJwfi+gSiak4TB8DstrKh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788213109; c=relaxed/simple;
	bh=Tcg6eZmO8d0Tlm4u1p5bMWUwhjyRFqGp2AxI2+/LNXw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KAcCJWBXN3k+eMfKBxECvVX8W5RO5UP3K/gjsQj22TyLBtrZg/nLdYcVm5n0nD55uany2LLaxVMw15r/bc1amlI8S50ai2NjIKsa/0R+j1FRnnsc6uuNZRF+F6dkrYhUJAnHoLr0jrdrBv0xBwTfH6LS+zzK/N9fo4vqRgJ4LQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuetseCv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuetseCv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC931F000E9;
	Mon, 31 Aug 2026 21:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788213106;
	bh=inFG7vCK9weH1i7XRSWpKuR3G88n6g0Ep4wLmlA/p2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RuetseCvis6g18HkmgkThAay1GGrM+58Jl5XIDInC8iZEC+G3MymCRQRf2ULxptb9
	 BslfTj7e+qX3ZX+BXkQcC20fiotVVJlKShP8dlwfa6S29sKW0tnSwbvx8qKOxD/ouR
	 mZzL4k2Po5oS2mc4j225RQEyS+H5NZn3Lby5SgSQsmcE2Zbn/2BLp1Nii504VsogoU
	 Vj8a1IAeTD+LzOdOiKentSI3C1OKOusNVys6O0Tlk4eZ8rsrUgA5mfpX27BtvwyUJ9
	 e8fk5LoLyfn5SqwJ5fV3oNs0R0rYjERcZxHlD+SgceHM+YgoppzZKaXsehD1YEijFR
	 1R7PDrHZJdf7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/12] dmaengine: switchtec-dma: always clear DMA
 base registers on chan_stop()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260831191403.207631-4-logang@deltatee.com>
References: <20260831191403.207631-1-logang@deltatee.com>
 <20260831191403.207631-4-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:51:45 +0000
Message-Id: <20260831215146.4EC931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Clearing DMA base registers to 0 redirects runaway DMA to physical=
 address 0, causing critical memory corruption.
- [High] Unconditional memory leak of DMA descriptor rings during device ho=
t-unplug because -ENODEV is treated as a halt timeout.
- [High] Dangling pointers allow intentionally leaked DMA memory to be acci=
dentally freed on subsequent channel allocation failure, risking hardware m=
emory corruption.

Pre-existing issues:
- [Critical] Client data buffers can be trashed by runaway hardware because=
 pending descriptors are aborted and unmapped despite a halt failure.
--

commit 76ff5cafd116d5c109fd77135de2f45efb9196b7
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: always clear DMA base registers on chan_stop()

Attempt the register clear regardless of whether the halt was successful,
and have switchtec_dma_chan_stop() return the halt result. In case of failu=
re,
descriptor rings are intentionally leaked to prevent buggy hardware from
trashing freed memory.

Link: https://lore.kernel.org/dmaengine/20260721162531.BA01A1F01560@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index e55fe9ff7e2c5..e2bb65237d2c9 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -543,26 +543,33 @@ switchtec_dma_abort_desc(struct switchtec_dma_chan =
*swdma_chan, int force)
>  	spin_unlock_bh(&swdma_chan->complete_lock);
>  }
> =20
> -static void switchtec_dma_chan_stop(struct switchtec_dma_chan *swdma_cha=
n)
> +static int switchtec_dma_chan_stop(struct switchtec_dma_chan *swdma_chan)
>  {
> +	struct pci_dev *pdev;
>  	int rc;
> =20
>  	rc =3D halt_channel(swdma_chan);
> -	if (rc)
> -		return;
> =20
>  	rcu_read_lock();
> -	if (!rcu_dereference(swdma_chan->swdma_dev->pdev)) {
> +	pdev =3D rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
>  		rcu_read_unlock();
> -		return;
> +		return rc;
>  	}
> =20
> +	if (rc)
> +		pci_err(pdev,
> +			"Channel %d halt timed out, clearing DMA base registers anyway\n",
> +			swdma_chan->index);
> +
>  	writel(0, &swdma_chan->mmio_chan_fw->sq_base_lo);
>  	writel(0, &swdma_chan->mmio_chan_fw->sq_base_hi);
>  	writel(0, &swdma_chan->mmio_chan_fw->cq_base_lo);
>  	writel(0, &swdma_chan->mmio_chan_fw->cq_base_hi);

[Severity: High]
If the channel fails to halt (times out), writing 0 to sq_base and cq_base
will point the hardware's queues to physical address 0.

If the active hardware fetches a descriptor or writes a completion, does th=
is
redirect runaway DMA to corrupt physical memory at address 0 instead of wri=
ting
to the intentionally leaked descriptor rings?

> =20
>  	rcu_read_unlock();
> +
> +	return rc;
>  }

[ ... ]

> @@ -1050,6 +1057,7 @@ static void switchtec_dma_free_chan_resources(struc=
t dma_chan *chan)
>  {
>  	struct switchtec_dma_chan *swdma_chan =3D
>  		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +	int rc;
> =20
>  	spin_lock_bh(&swdma_chan->submit_lock);
>  	swdma_chan->ring_active =3D false;
> @@ -1059,9 +1067,10 @@ static void switchtec_dma_free_chan_resources(stru=
ct dma_chan *chan)
>  	swdma_chan->comp_ring_active =3D false;
>  	spin_unlock_bh(&swdma_chan->complete_lock);
> =20
> -	switchtec_dma_chan_stop(swdma_chan);
> +	rc =3D switchtec_dma_chan_stop(swdma_chan);
>  	switchtec_dma_abort_desc(swdma_chan, 0);

[Severity: Critical]
This is a pre-existing issue, but does calling switchtec_dma_abort_desc()
here defeat the purpose of leaking the descriptor memory?

If switchtec_dma_chan_stop() times out due to a hardware hang, this code
still unconditionally calls dma_descriptor_unmap() and invokes client
callbacks with DMA_TRANS_ABORTED:

switchtec_dma_abort_desc()
    ...
    dma_cookie_complete(&desc->txd);
    dma_descriptor_unmap(&desc->txd);
    if (!force)
        dmaengine_desc_get_callback_invoke(&desc->txd, &res);

Could this cause clients to free or reuse their data buffers while the
runaway hardware is still actively writing to or reading from them?

> -	switchtec_dma_free_desc(swdma_chan);
> +	if (!rc)
> +		switchtec_dma_free_desc(swdma_chan);

[Severity: High]
If the PCI device is removed (e.g. hot-unplug), pdev is set to NULL, and
switchtec_dma_chan_stop() detects this and returns -ENODEV.

Does treating -ENODEV as a hardware halt failure here intentionally skip
switchtec_dma_free_desc(), causing a permanent memory leak of the DMA
descriptor rings during normal device unbind?

[Severity: High]
If switchtec_dma_chan_stop() times out, the descriptor memory is
intentionally leaked by skipping switchtec_dma_free_desc(), but the pointers
(hw_sq, hw_cq, desc_ring) are not cleared to NULL in the struct.

If a client subsequently allocates the channel again, and any part of the
new allocation fails:

switchtec_dma_alloc_desc()
    swdma_chan->hw_sq =3D dma_alloc_coherent(swdma_dev->dma_dev.dev, size,
                                           &swdma_chan->dma_addr_sq,
                                           GFP_NOWAIT);
    if (!swdma_chan->hw_sq) {
        rc =3D -ENOMEM;
        goto free_and_exit;
    }

Would the error path (free_and_exit) call switchtec_dma_free_desc() and
erroneously free the old, leaked memory that the runaway hardware might
still be writing to?

> =20
>  	disable_channel(swdma_chan);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831191403.2076=
31-1-logang@deltatee.com?part=3D3
