Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111F5377AB5;
	Mon, 31 Aug 2026 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212331; cv=none; b=Af1smaKH3NLY/NvItETunR1wjKLod9K8QxZQKpwM/dU/0DCL237CzOb5SszU+9oqGGRUOpD9o1d5Xyc9/eXNPJ3fc+sKObnx8Mf7hhs1b0TM4JVXc5Qfy1FM9jtXx2y0+wHXuaaoavWbJLeeyHYZ32tiD1CqqSvaJoBOG9Q77vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212331; c=relaxed/simple;
	bh=khu5zQuQK2tXoclNTaZssES5J4GYZsSrp1gQN14EP1w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qZJ72lj7u0nIrRzu2KoA6c1i57glpff2tyKanoZj+QFjfot32E8M7ImIgDGK+Q5aLX+3f5J356FfVLsnJJXqHF3aDmx8b6Bqm6EXEqDUi3nV6GMtFDj1xq2DFDx1+zDZXyO7zXbgv5OA/lqJ2bSSEkj3Pk4EpegrR8+CHgNJb38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwkH0A4/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwkH0A4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645A51F000E9;
	Mon, 31 Aug 2026 21:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788212329;
	bh=Y8jIlRGxs+SS2e4hAVSBElXsp1pzBk5E4Rx8i/JC7xk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fwkH0A4/hk/C9sxShN+I9QmsLEeuHAbCw14V/z5v7mYQVeAI+lsJ1SskLpUd19tHc
	 gbW5XKlp7bw7xQDjjI7luFzKcZ+u80HkV0mUlf6Mau7h8gE4jA7SVdscLzjLLBGGHq
	 mebSlP52CP2XUR1sP4mRRCPCYomdP7/Ye+G4rgRdWMvVa6dlqMwRij/UR3AQJdcN7j
	 mQy6ZTA1q/TUFiiMc7eR7pqm3x2C1zeXlUZTb24PdroI4G7cENH6Sv6xCA96MzyyQU
	 cHz1+d17drJ+h8wdKke0Ez7KjOw2OpDwEp7L42YIDU+rDkgjnVhPA49iVg1QXO/mcI
	 QlfXPkcfGHc2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/12] dmaengine: switchtec-dma: fix resource leak in
 alloc_chan_resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260831191403.207631-3-logang@deltatee.com>
References: <20260831191403.207631-1-logang@deltatee.com>
 <20260831191403.207631-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:38:48 +0000
Message-Id: <20260831213849.645A51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] switchtec_dma_remove() tears down hardware resources before unregi=
stering the DMA device, exposing a race window where new clients can reques=
t channels on a dying device.
- [High] The driver holds a spinlock between dmaengine prep_desc and tx_sub=
mit, violating dmaengine semantics and risking deadlocks.
- [High] The driver performs massive allocations using GFP_NOWAIT in proces=
s context, which is highly likely to fail under memory pressure.
--

commit dac58125b9c3b4ce36e518a88347266e281e5a57
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix resource leak in alloc_chan_resources

This commit fixes a resource leak in switchtec_dma_alloc_chan_resources()
where descriptor rings and coherent DMA memory were not freed on failure.
It adds an error-unwind path to properly disable the channel and free the
resources since the dmaengine core does not handle this automatically.

Link: https://lore.kernel.org/dmaengine/20260707165555.350951F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index a10818efba4e5..e55fe9ff7e2c5 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c

[ ... ]

While reviewing this code, I noticed a few pre-existing issues in the driver
that might need attention:

drivers/dma/switchtec_dma.c:switchtec_dma_remove() {
...
> 	switchtec_dma_chans_release(pdev, swdma_dev);
>=20
> 	rcu_assign_pointer(swdma_dev->pdev, NULL);
> 	synchronize_rcu();
>=20
> 	pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);
>=20
> 	pci_free_irq_vectors(pdev);
>=20
> 	dma_async_device_unregister(&swdma_dev->dma_dev);

[Severity: High]
This isn't a bug introduced by this patch, but does this teardown order exp=
ose
a race window where new clients can request channels on a dying device?

If a concurrent client requests a channel via dma_request_chan() during
switchtec_dma_remove(), the DMA core will route it to this device because it
has not yet been unregistered.

The client will then trigger switchtec_dma_alloc_chan_resources(), which
re-activates a channel whose IRQs and tasklets were already permanently
destroyed by switchtec_dma_chans_release().

Should dma_async_device_unregister() be called first to safely detach the
device from the subsystem before destroying local hardware resources?


drivers/dma/switchtec_dma.c:switchtec_dma_prep_desc() {
...
> 	spin_lock_bh(&swdma_chan->submit_lock);
>=20
> 	if (!swdma_chan->ring_active)
> 		goto err_unlock;

and in switchtec_dma_tx_submit():

> 	spin_unlock_bh(&swdma_chan->submit_lock);
>=20
> 	return cookie;

[Severity: High]
This is a pre-existing issue, but could holding submit_lock across dmaengine
API boundaries risk deadlocks?

If a client attempts to prepare multiple descriptors sequentially before
submitting them (batching prep operations), wouldn't the second call to
dmaengine_prep_dma_memcpy() attempt to acquire the exact same lock and
deadlock?

Furthermore, this leaves the caller's CPU permanently locked with softirqs
disabled if the client prepares a descriptor but aborts before submitting i=
t.
The dmaengine API explicitly allows batching of prep operations.


drivers/dma/switchtec_dma.c:switchtec_dma_alloc_desc() {
...
> 	swdma_chan->hw_sq =3D dma_alloc_coherent(swdma_dev->dma_dev.dev, size,
> 					       &swdma_chan->dma_addr_sq,
> 					       GFP_NOWAIT);
...
> 	for (i =3D 0; i < SWITCHTEC_DMA_RING_SIZE; i++) {
> 		desc =3D kzalloc_obj(*desc, GFP_NOWAIT);
> 		if (!desc) {
> 			rc =3D -ENOMEM;
> 			goto free_and_exit;
> 		}

[Severity: High]
This isn't a bug introduced by this patch, but could these allocations use
GFP_KERNEL instead?

Because switchtec_dma_alloc_chan_resources() is called in process context a=
nd
is allowed to sleep, using GFP_NOWAIT here performs massive allocations
without direct reclaim.

The driver attempts to allocate 1MB of coherent DMA memory and performs 32,=
768
consecutive atomic allocations, which seems highly likely to fail on
fragmented or loaded systems under memory pressure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831191403.2076=
31-1-logang@deltatee.com?part=3D2
