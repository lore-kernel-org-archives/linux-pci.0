Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0CBAD24;
	Fri, 17 Jul 2026 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784327539; cv=none; b=cEH15eQJiGM3dwuGfyNVxGRDBeb4DEps87Xx5lzWuVk91/kMy3FEqOdC7QzTgAwUVqrztip7C2jwBtDBw7W5iZgv7xVJ+meEIsaUmp3RzAUP0aPj9FoOfWs+N+g8876J9trchlGn6b1SFkjpQesG9Gon/kkgzb5/gJNZYW7W/dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784327539; c=relaxed/simple;
	bh=p7bOMOpw+xfv/07SdT4JrCg9kVrFDi4HOjF0JxzT0wc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EC2jzOmfmHCiicYG9fxmtzX5ztSkcp4DJu/tN6+1Q0+CjqL23ntZxriMvxM6oCzTj70HxB9wnW5ZdH4vWwUxf0XXjcIhAxj3FQNXiu2jhpX8+QpjUgFJMVcvOIoSTHFQyVRg5xrzSwQuGl32o974//IZn2mJ/QnP06mdbT2wiEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifRLF5J2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifRLF5J2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FBF1F000E9;
	Fri, 17 Jul 2026 22:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784327538;
	bh=ImCShKQ8fPlrJ8743zFlOWBHfvDnwSQXGUOJ+CzPnA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ifRLF5J2uGAWbvTEmCBneAWaASg0WTmYTYSGrwE9hLV9aeNZNIQ2iElW6kHU7oCEx
	 SvFiHbR2kjQ8LfRQbp+632xpCTxg8CoDLFHXlnGjzYluqrcZKPV6TJqz3XeGoeHjzR
	 AkZCzDAOBpXjeG5TgvDstF7loHq80AHd8IjLROgGespyz8QBY+QSFT2/mQIaZdXHT3
	 TZdAeIPcDvE6Jm+blYN+Ncaokez2ACZ2+9+Ei1GdZS/Rw4GeOJJPIMrLijTYtT44dL
	 ESNXTL2IWuR1/Stg6vAapW4nz4Fivma0JqNRzI+/v/fV8t8w9Z/AHYsK5DF5h+mfNS
	 a6LspUeYHSphg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/6] dmaengine: plx_dma: fix NULL pointer deref in
 plx_dma_isr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260717221001.361421-7-logang@deltatee.com>
References: <20260717221001.361421-1-logang@deltatee.com>
 <20260717221001.361421-7-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 22:32:17 +0000
Message-Id: <20260717223217.B6FBF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] API Contract Violation: `plx_dma_prep_memcpy` returns with a s=
pinlock held.
- [High] Deadlock during client callback execution due to held spinlock in =
`plx_dma_process_desc`.
- [High] Memory leak of the descriptor ring in `plx_dma_alloc_chan_resource=
s` on error path.
- [High] Deadlock due to missing bottom-half disable when taking spinlock i=
n `plx_dma_process_desc`.
- [High] Hardware state corruption due to a 16-bit write to a 32-bit MMIO r=
egister (`PLX_REG_CTRL`).
- [Medium] Missing `dma_rmb()` memory barrier after reading the DMA complet=
ion flag.
--

--- Patch [6]: [PATCH v1 6/6] dmaengine: plx_dma: fix NULL pointer deref in=
 plx_dma_isr() ---
commit bd1bd202047866d5b31f34772f932d4e070c9fd6
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: plx_dma: fix NULL pointer deref in plx_dma_isr()

This patch fixes a NULL pointer dereference in plx_dma_isr(). It moves the
bar assignment ahead of request_irq() to ensure the interrupt handler doesn=
't
run before plxdev->bar is initialized.

Link: https://lore.kernel.org/all/20260610112121.676561-1-jjy600901@snu.ac.=
kr/T/#u

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

While reviewing this driver, I noticed a few pre-existing issues in other
functions that might need attention:

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to invoke the
client callback while holding the spinlock in plx_dma_process_desc()?

drivers/dma/plx_dma.c:plx_dma_process_desc() {
...
	spin_lock(&plxdev->ring_lock);

	while (plxdev->tail !=3D plxdev->head) {
		desc =3D plx_dma_get_desc(plxdev, plxdev->tail);
...
		dmaengine_desc_get_callback_invoke(&desc->txd, &res);
...
	spin_unlock(&plxdev->ring_lock);
}

If a DMA client prepares a new transfer from its completion callback using
dmaengine_prep_dma_memcpy(), it will attempt to re-acquire this same
ring_lock in plx_dma_prep_memcpy(), causing a deadlock. This also affects
plx_dma_abort_desc() which does the same.

[Severity: Critical]
This is a pre-existing issue, but does plx_dma_prep_memcpy() intentionally
return with the spinlock held?

drivers/dma/plx_dma.c:plx_dma_prep_memcpy() {
...
	spin_lock_bh(&plxdev->ring_lock);
...
	/* return with the lock held, it will be released in tx_submit */
	return &plxdesc->txd;
}

If a client prepares multiple descriptors in sequence before submitting the=
m,
the second call to prep_memcpy() will deadlock trying to acquire the lock
that the first call left held. Furthermore, any client that sleeps, allocat=
es
memory with GFP_KERNEL, or takes a mutex between prep and submit will trigg=
er
a scheduling while atomic panic.

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
plx_dma_alloc_chan_resources() leak the descriptor ring?

drivers/dma/plx_dma.c:plx_dma_alloc_chan_resources() {
...
	rc =3D plx_dma_alloc_desc(plxdev);
	if (rc)
		goto out_free_hw_ring;

	rcu_read_lock();
	if (!rcu_dereference(plxdev->pdev)) {
		rcu_read_unlock();
		rc =3D -ENODEV;
		goto out_free_hw_ring;
	}
...
out_free_hw_ring:
	dma_free_coherent(plxdev->dma_dev.dev, ring_sz, plxdev->hw_ring,
			  plxdev->hw_ring_dma);
	return rc;
}

If rcu_dereference(plxdev->pdev) evaluates to false, the code jumps to
out_free_hw_ring. This frees hw_ring, but fails to free the newly allocated
desc_ring array and its descriptors, causing a memory leak.

[Severity: High]
This is a pre-existing issue, but should plx_dma_process_desc() use
spin_lock_bh() instead of spin_lock()?

drivers/dma/plx_dma.c:plx_dma_process_desc() {
...
	spin_lock(&plxdev->ring_lock);
...
}

This function can be called from process context via plx_dma_tx_status().
Because bottom halves are left enabled, a softirq can interrupt the lock
holder and schedule the driver's tasklet (plx_dma_desc_task) on the same CP=
U,
which will attempt to acquire the lock and deadlock.

[Severity: High]
This isn't a bug introduced by this patch, but should plx_dma_issue_pending=
()
use writel() instead of writew()?

drivers/dma/plx_dma.c:plx_dma_issue_pending() {
...
	writew(PLX_REG_CTRL_START_VAL, plxdev->bar + PLX_REG_CTRL);
...
}

PLX_REG_CTRL is treated as a 32-bit register elsewhere in the driver (e.g. =
in
__plx_dma_stop). Writing a 16-bit value to a 32-bit MMIO target might cause
partial register updates or undefined hardware behavior.

[Severity: Medium]
This is a pre-existing issue, but is a dma_rmb() memory barrier needed after
reading the descriptor status?

drivers/dma/plx_dma.c:plx_dma_process_desc() {
...
		flags =3D le32_to_cpu(READ_ONCE(desc->hw->flags_and_size));

		if (flags & PLX_DESC_FLAG_VALID)
			break;
...
}

On architectures with relaxed read ordering, reading the completion flag
without a subsequent dma_rmb() might allow the CPU to speculatively read
stale payload data from before the DMA transfer was actually completed by
the hardware.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717221001.3614=
21-1-logang@deltatee.com?part=3D6
