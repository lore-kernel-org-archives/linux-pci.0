Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C283A381C;
	Tue, 28 Jul 2026 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785261018; cv=none; b=ts4zdk5zYBZJmz2q/Fq/6mBUK5TQHytFwfonEaMfdFzzAKcw2186NjDwlOhe+63D7vs1I1Npj7yodRrvg9oXYSY5bMYN8Qu9xWvTrcAWLLZLkeE+bEe66rCk/5+MQoUeTYtgVJISQgubfzH4v61q45yAXSxaGFkrjHIgwIiOazE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785261018; c=relaxed/simple;
	bh=K2+cgIzaAWeerCUe1GPtFOjwBRVcbmTYWvC8U+9LBE8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a28JTC2VTZ5clvpC9BsNs98+2D150t3Ycy5/mjsfq9hTQY9YBFuBEHYbwuMKu3Kqbtb1QhtVveJRNJ0Elw/r/43zjehhPZ0RPsnmX90Q7cR9deQWfT5e02RgADycgGnmtxo8waMa/mn2IOYuiljds8s8SW+CLGrk2gJPWhR9ZiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4bjOqAI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4bjOqAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703BC1F000E9;
	Tue, 28 Jul 2026 17:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785261016;
	bh=lzhPncJ0fGgm6eOuDU+LOtzVaZsdNcwtihdFowi4Udw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a4bjOqAIhUhpmuIcmGsrGRje69Mnv6HLHZhzTXgq4mVHaS9PP/2pBZFiVVzgWp7J5
	 5pZHC+9HO1L0oB/1uthYRR72OTf4W/hsxeo/qviZqk4ikqFWPw3aFCqPWlaA2Agsan
	 cvxAcgEiehMBWGzuPcFOkBxYtoE/I0K5Qu4QYaOr+G2dS271Nl5zqK43U4he/3BFoe
	 e5GE72YVB61cdoKK+HC6EpbbrmcF0/+IdwhNGJAyiJdMRbBCjipYp/Ud8sWGG+/Spn
	 2asLItmAanskul9kUPGDX0k3JdN+5sXnSI3o1VnHqp10S3B5lc+rZrtuxhejjIqscH
	 eQ1/oJx5YXmlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/12] dmaengine: plx_dma: fix NULL pointer deref in
 plx_dma_isr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260728171523.112244-13-logang@deltatee.com>
References: <20260728171523.112244-1-logang@deltatee.com>
 <20260728171523.112244-13-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:50:15 +0000
Message-Id: <20260728175016.703BC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lock is held across DMA API boundaries (`prep` to `submit`), preve=
nting descriptor batching and causing deadlocks.
- [High] Recursive deadlock when invoking client callbacks from `plx_dma_pr=
ocess_desc`.
- [High] Softirq preemption deadlock in `plx_dma_process_desc` due to missi=
ng `spin_lock_bh`.
- [High] 1-Second busy-wait loop inside an RCU read-side critical section.
- [Medium] Memory leak of `desc_ring` array and descriptors in `plx_dma_all=
oc_chan_resources` error path.
--

--- Patch [12]: [PATCH v4 12/12] dmaengine: plx_dma: fix NULL pointer deref=
 in plx_dma_isr() ---
commit 255ac134d3a6a355b0f9fd6a9df9b4e6a75d09d7
Author: Logan Gunthorpe <logang@deltatee.com>
Subject: dmaengine: plx_dma: fix NULL pointer deref in plx_dma_isr()

plx_dma_create() registered the interrupt handler with request_irq()
before initializing plxdev->bar. If the device raised an interrupt in
that window, plx_dma_isr() would dereference the still-NULL bar.
This patch moves the bar assignment ahead of request_irq() so everything the
handler can touch is initialized before it can run.

Link: https://lore.kernel.org/all/20260610112121.676561-1-jjy600901@snu.ac.=
kr

> diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
> index 84941a918b01f..409898e92c320 100644
> --- a/drivers/dma/plx_dma.c
> +++ b/drivers/dma/plx_dma.c

[ ... ]

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

[ ... ]

While reviewing this patch, I noticed a few pre-existing issues in the same
file that might be worth addressing:

In drivers/dma/plx_dma.c:plx_dma_prep_memcpy():
> 	spin_lock_bh(&plxdev->ring_lock);
> ...
> 	return &plxdesc->txd;

In drivers/dma/plx_dma.c:plx_dma_tx_submit():
> 	spin_unlock_bh(&plxdev->ring_lock);
>=20
> 	return cookie;

[Severity: High]
This is a pre-existing issue, but does holding ring_lock across DMA API
boundaries prevent descriptor batching?

If a client prepares two consecutive transfers before submitting them, woul=
dn't
the second plx_dma_prep_memcpy() call recursively attempt to acquire the
non-recursive ring_lock held by the first call, causing an immediate deadlo=
ck?

In drivers/dma/plx_dma.c:plx_dma_process_desc():
> 	spin_lock(&plxdev->ring_lock);
>=20
> 	while (plxdev->tail !=3D plxdev->head) {
> ...
> 		dmaengine_desc_get_callback_invoke(&desc->txd, &res);
> ...
> 	}
>=20
> 	spin_unlock(&plxdev->ring_lock);

[Severity: High]
This is a pre-existing issue, but is it safe to invoke client callbacks whi=
le
holding ring_lock?

If a completion callback attempts to prepare a new transfer via
dmaengine_prep_dma_memcpy(), it will invoke plx_dma_prep_memcpy() which
attempts to acquire spin_lock_bh(&plxdev->ring_lock).

Would this cause an immediate recursive deadlock?

In drivers/dma/plx_dma.c:plx_dma_process_desc():
> 	spin_lock(&plxdev->ring_lock);

[Severity: High]
This is a pre-existing issue, but could acquiring ring_lock without disabli=
ng
softirqs lead to a preemption deadlock?

If plx_dma_process_desc() is called from process context via
plx_dma_tx_status(), a hardware interrupt could preempt the thread while the
lock is held and schedule the tasklet.

Would the softirq tasklet then spin forever in plx_dma_desc_task() trying
to acquire ring_lock?

In drivers/dma/plx_dma.c:plx_dma_stop():
> 	rcu_read_lock();
> 	if (!rcu_dereference(plxdev->pdev)) {
> 		rcu_read_unlock();
> 		return;
> 	}
>=20
> 	__plx_dma_stop(plxdev);
>=20
> 	rcu_read_unlock();

In drivers/dma/plx_dma.c:__plx_dma_stop():
> 	unsigned long timeout =3D jiffies + msecs_to_jiffies(1000);
> ...
> 	while (!time_after(jiffies, timeout)) {
> 		val =3D readl(plxdev->bar + PLX_REG_CTRL);
> 		if (val & PLX_REG_CTRL_GRACEFUL_PAUSE_DONE)
> 			break;
>=20
> 		cpu_relax();
> 	}

[Severity: High]
This is a pre-existing issue, but does __plx_dma_stop() spin for up to a se=
cond
inside an RCU read-side critical section?

Since plx_dma_stop() takes rcu_read_lock() and calls __plx_dma_stop(), wait=
ing
for up to 1000 milliseconds using cpu_relax() could cause massive scheduling
latency spikes.

Could this explicitly block RCU grace periods and preemptions on
non-PREEMPT_RCU systems, potentially triggering RCU stall panics?

In drivers/dma/plx_dma.c:plx_dma_alloc_chan_resources():
> 	rc =3D plx_dma_alloc_desc(plxdev);
> 	if (rc)
> 		goto out_free_hw_ring;
>=20
> 	rcu_read_lock();
> 	if (!rcu_dereference(plxdev->pdev)) {
> 		rcu_read_unlock();
> 		rc =3D -ENODEV;
> 		goto out_free_hw_ring;
> 	}
> ...
> out_free_hw_ring:
> 	dma_free_coherent(plxdev->dma_dev.dev, ring_sz, plxdev->hw_ring,
> 			  plxdev->hw_ring_dma);
> 	return rc;

[Severity: Medium]
This is a pre-existing issue, but does this error path leak the desc_ring a=
rray
and its associated descriptors?

If the check for rcu_dereference(plxdev->pdev) fails, it jumps to
out_free_hw_ring.

Since this only frees the DMA coherent memory hw_ring, are the allocated
descriptors completely leaked?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728171523.1122=
44-1-logang@deltatee.com?part=3D12
