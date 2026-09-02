Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C3938D686;
	Wed,  2 Sep 2026 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331233; cv=none; b=hEDmttDVNzFYAYTAH4zAhAqxy1aJADtMXRgS9TzvLguU1Vv5mWrOB+sEsKMTn3+v21avPMFrtCqAi1/w1+9Vfrxaxbe0HCocQws7Tcj0xbsi5dW8QhR0cMERwJ0H7MSxkHSUdTHvK+ZNu4wtDYIFJc30hdn5jM3Sfj0m6aeailM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331233; c=relaxed/simple;
	bh=5r0Hfqz1r/cQkfXyVRiCnnbVEtTuOK1jGhTyRa6vowg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n8KQPZG18F5dA77dJ/KegWIBNhZb3CJU6ZVWQhSST5F0vkficxlU3qfjs4uDdfwTbOy0BNBrp6OrGgcSS3R+GA/9bEnpOwz8t3V9L0BryqgzhoxuufP9W8crYOz/wk1L4k8Q5Qw9PKqyOjllAzKzYaoG2qVEiVSf8VvwBy1m4gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCSo2UwH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCSo2UwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFDA1F000E9;
	Wed,  2 Sep 2026 06:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788331229;
	bh=XaZ8RKhh9AxleUR4Vju55gkgqThrBoS3YTrN5pk6xH0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VCSo2UwHrqoYDVGGK7w1SgwPvEn5l3pE2v/tww/1sW/BSValVm23uIcrS+J0cZouy
	 USebYwgJiLavsxrvKWc3Qjeku1aB3yb7pYYSWIxvNZRf3eEYxXB+9hep4yPW/DotW6
	 UZgVsY9ZsKqs2Da5/wZ+yUydINPLlV8nZJ/fwhYgWDF7K0ioohGGAHZFHVZtK45l11
	 AFX/sFe8waxRvEfD+XlkGVUm8q/i9+XrlqRhwtpf1esZAef0FOYIwuI66jEyIC5vGG
	 oikaRtvsN2oU9Be2yrBD1bbeL6QQdPgexB2zq8W0MrbKDqi79Wd5sTHuvoSo1DbewS
	 hVKa8SCgkqn9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/10] dmaengine: plx_dma: fix NULL pointer deref in
 plx_dma_isr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260902062153.31048-11-logang@deltatee.com>
References: <20260902062153.31048-1-logang@deltatee.com>
 <20260902062153.31048-11-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 06:40:28 +0000
Message-Id: <20260902064029.7BFDA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential deadlock in `plx_dma_process_desc()` due to missing bott=
om-half disabling.
- [High] `plx_dma_prep_memcpy()` acquires a spinlock and returns with it he=
ld, breaking the DMA Engine API contract.
- [High] Unbounded busy-wait loop spanning up to 1000ms inside an RCU read-=
side critical section.
- [High] Missing `dma_rmb()` in `plx_dma_process_desc()` before processing =
completion data.
- [Medium] Memory leak of `desc_ring` and its inner descriptor objects in t=
he `plx_dma_alloc_chan_resources()` error path.
--

commit dbf39b912829e6113fcfa314a5a4384936eccf12
Author: Logan Gunthorpe <logang@deltatee.com>
Subject: dmaengine: plx_dma: fix NULL pointer deref in plx_dma_isr()

plx_dma_create() registered the interrupt handler with request_irq()
before initializing plxdev->bar. If the device raised an interrupt in
that window, plx_dma_isr() would dereference the still-NULL bar.
This commit moves the bar assignment before request_irq() to fix the issue.

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

While reviewing this file, I noticed a few pre-existing issues in other
functions that might need attention.

> static void plx_dma_process_desc(struct plx_dma_dev *plxdev)
> {
[ ... ]
> 	spin_lock(&plxdev->ring_lock);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but does using spin_lock() here instead of
spin_lock_bh() create a deadlock vulnerability? plx_dma_tx_status() calls
this function from process context. If an interrupt fires and triggers the
plx_dma_desc_task tasklet on the same CPU, wouldn't it attempt to acquire
this same lock, deadlocking the system?

[ ... ]
> 	while (plxdev->tail !=3D plxdev->head) {
> 		desc =3D plx_dma_get_desc(plxdev, plxdev->tail);
>=20
> 		flags =3D le32_to_cpu(READ_ONCE(desc->hw->flags_and_size));
>=20
> 		if (flags & PLX_DESC_FLAG_VALID)
> 			break;
            ^^^^^

[Severity: High]
This isn't a bug introduced by this patch, but should there be a dma_rmb()
inserted directly after this break statement? Without a read memory barrier,
weakly-ordered CPUs might speculatively read the destination buffer before
the status read completes, which could cause data corruption.

[ ... ]

> static struct dma_async_tx_descriptor *plx_dma_prep_memcpy(struct dma_cha=
n *c,
> 		dma_addr_t dma_dst, dma_addr_t dma_src, size_t len,
> 		unsigned long flags)
> 	__acquires(plxdev->ring_lock)
> {
[ ... ]
> 	spin_lock_bh(&plxdev->ring_lock);
[ ... ]
> 	/* return with the lock held, it will be released in tx_submit */
>=20
> 	return &plxdesc->txd;

[Severity: High]
This isn't a bug introduced by this patch, but does returning with a
spinlock held break the DMA Engine API contract? The API allows clients to
prepare multiple descriptors before submission. If a client prepares two
descriptors sequentially, won't the second call deadlock trying to acquire
ring_lock? Also, if a client prepares a descriptor but aborts without
calling submit, wouldn't the lock leak and permanently leave softirqs
disabled on that CPU?

[ ... ]

> static void plx_dma_stop(struct plx_dma_dev *plxdev)
> {
> 	rcu_read_lock();
[ ... ]
> 	__plx_dma_stop(plxdev);
[ ... ]
> }

and __plx_dma_stop() does:

> static void __plx_dma_stop(struct plx_dma_dev *plxdev)
> {
> 	unsigned long timeout =3D jiffies + msecs_to_jiffies(1000);
[ ... ]
> 	while (!time_after(jiffies, timeout)) {
> 		val =3D readl(plxdev->bar + PLX_REG_CTRL);
> 		if (val & PLX_REG_CTRL_GRACEFUL_PAUSE_DONE)
> 			break;
>=20
> 		cpu_relax();
> 	}
        ^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but this performs an unbounded delay of up to
1000ms inside the RCU read-side critical section established by
plx_dma_stop(). Could spinning for such a long duration block RCU grace
periods and severely degrade system stability?

[ ... ]

> static int plx_dma_alloc_chan_resources(struct dma_chan *chan)
> {
[ ... ]
> 	rc =3D plx_dma_alloc_desc(plxdev);
> 	if (rc)
> 		goto out_free_hw_ring;
>=20
> 	rcu_read_lock();
> 	if (!rcu_dereference(plxdev->pdev)) {
> 		rcu_read_unlock();
> 		rc =3D -ENODEV;
> 		goto out_free_hw_ring;
                ^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
This isn't a bug introduced by this patch, but does this error path leak
the desc_ring array and its 2048 dynamically allocated descriptor objects?
It jumps to out_free_hw_ring, which frees hw_ring but skips the cleanup
loop needed to destroy desc_ring.

[ ... ]
> out_free_hw_ring:
> 	dma_free_coherent(plxdev->dma_dev.dev, ring_sz, plxdev->hw_ring,
> 			  plxdev->hw_ring_dma);
> 	return rc;
> }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902062153.3104=
8-1-logang@deltatee.com?part=3D10
