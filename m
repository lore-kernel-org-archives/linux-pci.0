Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354503DD520;
	Mon, 27 Jul 2026 20:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785183815; cv=none; b=WAT2jC/pPDLSeGLvUQFVwn6Mky+DSRA5Gjcn23LNQx5EYX8XfWZCsthwhsf06YuOesbMDpprET9pIfegjCdPbHeA65Z7O4nGLVxFiA0kKTU4KFenN+VaoiLpbQyzOpup0/vGxw/djOB0JwYIrZpk2GBzz3ckZc+vfNz+GHxipZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785183815; c=relaxed/simple;
	bh=9LN74NiOxgY2LWt79cbRMnTuaUCLOm8DKrKI53tPUes=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rC3JEGbB94cciXsqFkWsrEkhMzP/BjlgxiH8T2KiDfqW72AlwyIRY8zky7gjhDfqSovk6nxxsX7vG14BzL+Cv6VW3t7g5616RfqY9QAbRM/0QZaBYhiByPhZmsMQYERgeSjesu7xvsOvsVuBF1knQrXodeTF3AGgdGLtyTzDaKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=So3MwnUx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="So3MwnUx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8F81F000E9;
	Mon, 27 Jul 2026 20:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785183813;
	bh=fqYAI6MMMS6W2N1VSC5+yhw6aOIwTzMIi2Y8o60JoS0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=So3MwnUxlCChw8UzQ8T0p96aTCR0RX8hsW2f2XMtE4hNUIyJo5cdDx7iiDFXnhqOc
	 AKWh17gaSQgqiL2/unBYrckY3Vb4eNdG7/OlYCVRFRD/TuwxInz4LkhFFF11wH1ctG
	 VjQCwhlxeNARER05cbRuamxG063LJXkZV/dDRK2Hp0IRibGdOn35eKAStq17pOO+3y
	 Ex3kbOcjdDxHl0jWcIw5RZMxsPvadLlHtrT6z73lhM8rNZQ8TGiIJ1WWy1sOeh3Zs/
	 +wTRZGkhuwJMU2miTyXN7mIOr62EviWtQYjFbgdsy6GNV7E9DEXlK3PChsUZfyHkqO
	 pYtq7DHDJr9hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/11] dmaengine: plx_dma: fix NULL pointer deref in
 plx_dma_isr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260727181526.9672-12-logang@deltatee.com>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-12-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 20:23:33 +0000
Message-Id: <20260727202333.9F8F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Client callbacks are invoked with the driver's primary spinlock he=
ld, causing deadlocks if the callback initiates a new DMA transaction.
- [High] `plx_dma_prep_memcpy` returns with a spinlock held, violating API =
boundaries and causing deadlocks on multiple descriptor preparations.
- [High] Softirq deadlock due to failing to disable bottom halves before ac=
quiring a spinlock in process context.
- [High] Missing read memory barrier after checking DMA descriptor status c=
an lead to reading stale payload data.
--

--- Patch [11]: [PATCH v3 11/11] dmaengine: plx_dma: fix NULL pointer deref=
 in plx_dma_isr() ---
commit 95d7de134f15bc6f73a67b043a21039f2fc9965a
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: plx_dma: fix NULL pointer deref in plx_dma_isr()

plx_dma_create() registered the interrupt handler with request_irq()
before initializing plxdev->bar. If the device raised an interrupt in
that window, plx_dma_isr() would dereference the still-NULL bar.

Move the bar assignment ahead of request_irq() so everything the
handler can touch is initialized before it can run.

Link: https://lore.kernel.org/all/20260610112121.676561-1-jjy600901@snu.ac.=
kr

> diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
> index 84941a918b01f..409898e92c320 100644
> --- a/drivers/dma/plx_dma.c
> +++ b/drivers/dma/plx_dma.c
> @@ -504,17 +504,17 @@ static int plx_dma_create(struct pci_dev *pdev)
>  	if (!plxdev)
>  		return -ENOMEM;
> =20
> -	rc =3D request_irq(pci_irq_vector(pdev, 0), plx_dma_isr, 0,
> -			 KBUILD_MODNAME, plxdev);
> -	if (rc)
> -		goto free_plx;
> -
>  	spin_lock_init(&plxdev->ring_lock);
>  	tasklet_setup(&plxdev->desc_task, plx_dma_desc_task);
> =20
>  	RCU_INIT_POINTER(plxdev->pdev, pdev);
>  	plxdev->bar =3D pcim_iomap_table(pdev)[0];
> =20
> +	rc =3D request_irq(pci_irq_vector(pdev, 0), plx_dma_isr, 0,
> +			 KBUILD_MODNAME, plxdev);
> +	if (rc)
> +		goto free_plx;
> +
>  	dma =3D &plxdev->dma_dev;
>  	INIT_LIST_HEAD(&dma->channels);
>  	dma_cap_set(DMA_MEMCPY, dma->cap_mask);

While reviewing this patch, I noticed a few pre-existing issues in this dri=
ver:

drivers/dma/plx_dma.c:plx_dma_process_desc() {
[ ... ]
	spin_lock(&plxdev->ring_lock);

[Severity: High]
This isn't a bug introduced by this patch, but can this cause a softirq
deadlock?

plx_dma_tx_status() is typically called from process context and invokes
plx_dma_process_desc(), which acquires this lock without disabling bottom
halves.

If a hardware interrupt occurs, plx_dma_isr() schedules a tasklet. Upon
returning from the interrupt, the tasklet executes in softirq context on the
same CPU and calls plx_dma_process_desc(), which attempts to acquire the
already-held non-recursive spinlock.

[ ... ]
		flags =3D le32_to_cpu(READ_ONCE(desc->hw->flags_and_size));

		if (flags & PLX_DESC_FLAG_VALID)
			break;

[Severity: High]
This isn't a bug introduced by this patch, but is a dma_rmb() needed here?

Without a read memory barrier after verifying the descriptor is marked valid
by the device, the CPU could speculatively reorder subsequent memory reads
before the status check completes. Could this lead to a client callback
reading stale payload data from the DMA destination buffer?

[ ... ]
		dmaengine_desc_get_callback_invoke(&desc->txd, &res);

[Severity: High]
This is a pre-existing issue, but could this cause a deadlock?

The client callback is invoked synchronously while plxdev->ring_lock is
held. If the client completion callback issues a new DMA transaction by
calling dmaengine_prep_*, it will call into plx_dma_prep_memcpy() which
attempts to acquire the same spinlock.

}


drivers/dma/plx_dma.c:plx_dma_prep_memcpy() {
[ ... ]
	spin_lock_bh(&plxdev->ring_lock);
[ ... ]
	/* return with the lock held, it will be released in tx_submit */

	return &plxdesc->txd;
}

[Severity: High]
This isn't a bug introduced by this patch, but does returning with the
spinlock held violate the dmaengine API contract?

If a client prepares two descriptors sequentially before submitting (e.g.,
calling prep() then prep() again), the second call will deadlock trying to
acquire the already-held lock. This also forces clients into an atomic
context between prep and submit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727181526.9672=
-1-logang@deltatee.com?part=3D11
