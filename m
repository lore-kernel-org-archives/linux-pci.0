Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB3A30E85B;
	Wed,  2 Sep 2026 06:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331077; cv=none; b=R0ivXhyRlDptckHLofeIP48G6MBUNnJ1vrNRZDD4CA+B1sxbGHhYyQ9+zh7uFcH/TtITsuUQa6MRIovPTll3FeCZZPHz6B9TWOxY//xkw4kwSlGd0UR8D1A4r14bzT5jO8/uBImJuxUSqYz9xy59aqjAvURkKYkjiOH56rYq54Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331077; c=relaxed/simple;
	bh=K4ig7z6zdJZeD7XBymGi/wW8Hi4gYTe1QVzReojFGN0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OCHsGdhf0w/Pk31hmWw8Xl5atUH02Y73yuivQMyGlS6TiDD/M735tEqc8osAWuj0/N6cIaXCIbojw9b8levrTCRW/Oo9h0+61ZNmN7u6XSekGZ8y1BPF0Mhz7s6b+qN7SnnZB6sb+Am/XcfiEd93qNx+N5HEREmDcARuBGB5uc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQNjADXz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQNjADXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FAA1F000E9;
	Wed,  2 Sep 2026 06:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788331076;
	bh=d3u90BQrpdqVwrGSQjGR7s0gPQgLm2ayGwqMHEA5kD4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nQNjADXziOj26Klzm8GoxiKIZvVByAxvaZe8KzBDmBAMlINRmzikUdLTOY1L6/riU
	 3H/mRbaDO1revXIhuh9jLLchSdoOZDdaDJK4DwEdqRSDPdhykL/RQ9QwR58OwLY8Xi
	 mYnSG46+YytAx/wmqT1mc0NwYe9+tZyDTkpW7+Boex94DhXj57u3Raao5cNg82Dxu3
	 aenoUf0SBfYpXP9SuNaJgzPuIEX5XCM5HsOdlzWv3m5Xc9P9id0c23bPs52Rv8cA8z
	 qI8AZJavsgSdMOLiYcul+vasYrHg55l1zazRmz93FeCVKlqLYTf7+4Q5h8IIYuxAXF
	 Iirs0+8XIkbpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/10] dmaengine: switchtec-dma: fix use-after-free
 of swdma_dev in remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260902062153.31048-8-logang@deltatee.com>
References: <20260902062153.31048-1-logang@deltatee.com>
 <20260902062153.31048-8-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 06:37:55 +0000
Message-Id: <20260902063756.08FAA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unchecked ioremap() return value leading to potential NULL pointer=
 dereference
- [High] Spinlock held across DMA engine API boundaries leading to deadlock=
 on sequential prep
- [High] The driver invokes the client's completion callback with `complete=
_lock` held, leading to a self-deadlock if the client interacts with the ch=
annel.
--

commit f727848a55e557b0732eca07f63de472baae9774
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix use-after-free of swdma_dev in remove()

Fixes a use-after-free bug in switchtec_dma_remove() where swdma_dev->bar
was used after dma_async_device_unregister() could have freed swdma_dev.
The patch caches bar in a local variable before unregistering the DMA devic=
e.

Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 63f80e2a5b6f4..d390949b843cd 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1380,6 +1380,7 @@ static int switchtec_dma_probe(struct pci_dev *pdev,
>  static void switchtec_dma_remove(struct pci_dev *pdev)
>  {
>  	struct switchtec_dma_dev *swdma_dev =3D pci_get_drvdata(pdev);
> +	void __iomem *bar =3D swdma_dev->bar;
> =20
>  	switchtec_dma_chans_release(pdev, swdma_dev);
> =20
> @@ -1392,7 +1393,7 @@ static void switchtec_dma_remove(struct pci_dev *pd=
ev)
> =20
>  	dma_async_device_unregister(&swdma_dev->dma_dev);
> =20
> -	iounmap(swdma_dev->bar);
> +	iounmap(bar);
>  	pci_release_mem_regions(pdev);
>  	pci_disable_device(pdev);
>  }

While reviewing this patch, I noticed some pre-existing issues in the same
file.

drivers/dma/switchtec_dma.c:switchtec_dma_create() {
...
	swdma_dev->bar =3D ioremap(pci_resource_start(pdev, 0),
				 pci_resource_len(pdev, 0));

	RCU_INIT_POINTER(swdma_dev->pdev, pdev);

	nr_vecs =3D pci_msix_vec_count(pdev);
	rc =3D pci_alloc_irq_vectors(pdev, nr_vecs, nr_vecs, PCI_IRQ_MSIX);
	if (rc < 0)
		goto err_exit;

	irq =3D readw(swdma_dev->bar + SWITCHTEC_REG_CHAN_STS_VEC);
...
}

[Severity: High]
This is a pre-existing issue, but is the return value of ioremap() checked
here?

If memory mapping fails and returns NULL, calling readw() on
swdma_dev->bar + SWITCHTEC_REG_CHAN_STS_VEC will result in a NULL pointer
dereference and kernel panic during device probe.


drivers/dma/switchtec_dma.c:switchtec_dma_prep_desc() {
...
	spin_lock_bh(&swdma_chan->submit_lock);

	if (!swdma_chan->ring_active)
		goto err_unlock;
...
	/* return with the lock held, it will be released in tx_submit */

	return &desc->txd;
...
}

drivers/dma/switchtec_dma.c:switchtec_dma_tx_submit() {
...
	cookie =3D dma_cookie_assign(desc);

	spin_unlock_bh(&swdma_chan->submit_lock);

	return cookie;
}

[Severity: High]
This isn't a bug introduced by this patch, but could holding the spinlock
across the DMA engine API boundaries lead to a deadlock on sequential prep
calls?

If a generic client calls prep_memcpy() twice in a row before submitting,
wouldn't the second call self-deadlock the CPU attempting to acquire the
already-held swdma_chan->submit_lock?

Also, does this permanently leak the lock if a client prepares a descriptor
but frees it instead of submitting?


drivers/dma/switchtec_dma.c:switchtec_dma_cleanup_completed() {
...
	do {
		spin_lock_bh(&swdma_chan->complete_lock);
...
		do {
			dma_cookie_complete(&desc->txd);
			dma_descriptor_unmap(&desc->txd);
			dmaengine_desc_get_callback_invoke(&desc->txd, &res);
...
}

[Severity: High]
While this is a pre-existing issue, does invoking the client's completion
callback with complete_lock held expose the system to a self-deadlock?

It is legal for DMA clients to interact with the channel from their
completion callback, such as checking the status via
dmaengine_tx_status() or calling dmaengine_terminate_all().

If a client does this, the call routes to switchtec_dma_tx_status() or
switchtec_dma_terminate_all(), both of which attempt to acquire the same
complete_lock, resulting in a permanent self-deadlock on the same CPU.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902062153.3104=
8-1-logang@deltatee.com?part=3D7
