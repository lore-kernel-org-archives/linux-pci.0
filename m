Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA472E6CB3;
	Mon, 27 Jul 2026 19:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785179166; cv=none; b=rONBbGYQ/XI0dtGBOrhiPUWogPeSkgpNCAy5hE+okCaWaH3RKzt3sA2CEKmHHbC90xr/q1EX7RegwDB8JZAS627U5CcEZbRItPXqe0s7I1sCCfysQmcvHsuJiVmxbM8goC6SqsqTdTz6Fa0InNVpuyPF9ZHpr1bqaZej/6VkKR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785179166; c=relaxed/simple;
	bh=9HIEYNExZe6MffJPs4uzkL9Lzs/bVjGMLBCqMTEgxXY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GBrFW9TsEJ4vbdbQsJ4DFkEu4zmER8vc9Zv971sGgXmJz8OrmhmkP2iV4MUy2kR7OYELnUpjj7hKg2kTXRb4iByeS6LuYRxO3yHUGvh+jYzdRVlzI48kF7h/UDl9sh0X5FwJkjcuJZki7XAi4S039BxKrOHLmX6RRIRrvBDanC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4AHtXT+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4AHtXT+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397DB1F000E9;
	Mon, 27 Jul 2026 19:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785179164;
	bh=oYJFTZWaGWYf6ytIfr/L17wGT95sReNEIi4qfqw0P3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N4AHtXT+ArmrZsJ3IYa6Jz15cb2wKcsUxfy/TXdcl/L7vtBXlA1S+vo8ptEoIIKUF
	 8UcG20SiWFpsjw238nnHneqQXUKTdcDyY3ZABJXJLXiO5yoezPYb+6d5aNqX6BSd59
	 AmJxzZ8Z5nSkiQKohxRP0AfOV5BMFJsGM9I4vEcNi0V1k0/c4n3N88eDAv1hB1ma69
	 I5+AW6KiXttphnDzEVlmYidwttCekk+bPdyeT4IBHbkEO5SwAxSMNe24IMuUntunCF
	 Nk9k04cy35HVNGY1Mi/6Z7kmF5GN065SaLaPJRqaDIco9vLNqFerkNuVCOyNu1J/nc
	 O7F21LlgaeivA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/11] dmaengine: switchtec-dma: fix channel leak on
 registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260727181526.9672-5-logang@deltatee.com>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-5-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:06:03 +0000
Message-Id: <20260727190604.397DB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] Freeing DMA channels in error paths leaves dangling pointers in th=
e `dma_dev->channels` list, leading to a Use-After-Free when accessed by th=
e active channel status ISR.

Pre-existing issues:
- [High] The `switchtec_dma_remove()` function dereferences `swdma_dev` aft=
er it has been freed by the `device_release` callback.
- [High] Registering the channel status ISR before initializing the channel=
 list head causes a NULL pointer dereference.
- [High] Pre-existing deadlock if a client callback attempts to abort or te=
rminate the DMA channel.
- [High] Incorrect IRQ free API in `switchtec_dma_create()` error path guar=
antees an IRQ leak and subsequent Use-After-Free.
- [Medium] Missing `put_device()` in `switchtec_dma_create()` error path ca=
uses a reference count leak for the PCI device.
- [Medium] Missing `pci_free_irq_vectors()` on error paths in `switchtec_dm=
a_create()` leaks MSI-X vectors.
--

--- Patch [4]: [PATCH v3 04/11] dmaengine: switchtec-dma: fix channel leak =
on registration failure ---
commit 58dd78b5d9196a368d9b2914fdfb2256ea81eef1
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix channel leak on registration failure

switchtec_dma_chans_release() is called in three places but the
underlying memory is not freed in all of those places. In order to
clean this up, introduce a switchtec_dma_chans_free() helper that
will free the memory.

Link: https://lore.kernel.org/dmaengine/20260717223024.9BB8A1F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 107769cca772f..13efd4189bbb4 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1176,6 +1176,16 @@ static int switchtec_dma_chans_release(struct pci_=
dev *pdev,
>  	return 0;
>  }
> =20
> +static void switchtec_dma_chans_free(struct switchtec_dma_dev *swdma_dev)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < swdma_dev->chan_cnt; i++)
> +		kfree(swdma_dev->swdma_chans[i]);

[Severity: High]
Does this code leak dangling pointers in the dma_dev->channels list?

The newly introduced switchtec_dma_chans_free() frees each swdma_chan but f=
ails
to call list_del(&chan->device_node). If an interrupt occurs (e.g. spurious=
 or
shared) before the ISR is disabled (or indefinitely if the ISR cleanup fail=
s),
switchtec_dma_chan_status_isr() will iterate over this list and deference t=
he
freed memory, leading to a Use-After-Free.

[ ... ]

> @@ -1317,6 +1321,7 @@ static int switchtec_dma_create(struct pci_dev *pde=
v)
> =20
>  err_chans_release_exit:
>  	switchtec_dma_chans_release(pdev, swdma_dev);
> +	switchtec_dma_chans_free(swdma_dev);

[Severity: Medium]
This is a pre-existing issue, but does this error path leak the PCI device
reference count?

During probe, switchtec_dma_create() acquires the reference via
get_device(&pdev->dev). If dma_async_device_register() fails, the execution
jumps here. This path cleanly frees memory but fails to call put_device(dma=
->dev),
which leaks the reference count and prevents clean teardown on hot-unplug.

> =20
>  err_exit:
>  	if (swdma_dev->chan_status_irq)

[Severity: High]
This is a pre-existing issue, but does this incorrect IRQ free API guarantee
an IRQ leak and subsequent Use-After-Free?

switchtec_dma_create() requests an MSI-X vector via pci_request_irq() using
the hardware vector index (e.g. 0). However, this error path calls free_irq=
()
instead of pci_free_irq().

This attempts to free the Linux IRQ number corresponding to the index (0),
which fails silently. Furthermore, because it's index 0, the
if (swdma_dev->chan_status_irq) condition prevents the free from even execu=
ting.
The ISR remains registered after swdma_dev is kfreed, leading to a UAF when
the IRQ fires.

[Severity: Medium]
This is a pre-existing issue, but does this error path also leak MSI-X vect=
ors?

If pci_alloc_irq_vectors() succeeds, but subsequent steps like pci_request_=
irq()
or switchtec_dma_chans_enumerate() fail, the execution jumps to the err_exit
label. The error cleanup omits pci_free_irq_vectors(), leaking the allocated
vectors.

[ ... ]

For switchtec_dma_remove():

> static void switchtec_dma_remove(struct pci_dev *pdev)
> {
> 	struct switchtec_dma_dev *swdma_dev =3D pci_get_drvdata(pdev);
>=20
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
>=20
> 	iounmap(swdma_dev->bar);

[Severity: High]
This is a pre-existing issue, but does this dereference swdma_dev after it =
has
been freed?

During driver unbind, dma_async_device_unregister() drops the last reference
to the DMA device, which synchronously invokes switchtec_dma_release(). This
callback frees swdma_dev via kfree(swdma_dev). Immediately after, this
function attempts to access swdma_dev->bar in the iounmap() call, causing a
Use-After-Free.

For switchtec_dma_create():

> 	rc =3D pci_request_irq(pdev, irq, NULL, switchtec_dma_chan_status_isr,
> 			     swdma_dev, KBUILD_MODNAME);
> 	if (rc)
> 		goto err_exit;
>=20
> 	swdma_dev->chan_status_irq =3D irq;
>=20
> 	chan_cnt =3D readl(swdma_dev->bar + SWITCHTEC_REG_CHAN_CNT);
> 	if (!chan_cnt) {
> 		pci_err(pdev, "No channel configured.\n");
> 		rc =3D -ENXIO;
> 		goto err_exit;
> 	}
>=20
> 	chan_cnt =3D switchtec_dma_chans_enumerate(swdma_dev, pdev, chan_cnt);

[Severity: High]
This is a pre-existing issue, but does registering the channel status ISR
before initializing the channel list head cause a NULL pointer dereference?

switchtec_dma_create() calls pci_request_irq() to register the ISR, then
proceeds to switchtec_dma_chans_enumerate() which calls
INIT_LIST_HEAD(&dma->channels).

Because dma_dev is allocated with kzalloc_obj, the channels.next pointer is
initially NULL. If an interrupt fires during this narrow window,
list_for_each_entry() in the ISR will compute a negative offset from NULL a=
nd
attempt to dereference it, leading to an immediate kernel panic.

For switchtec_dma_cleanup_completed():

> static void
> switchtec_dma_cleanup_completed(struct switchtec_dma_chan *swdma_chan)
> {
> [ ... ]
> 		do {
> 			dma_cookie_complete(&desc->txd);
> 			dma_descriptor_unmap(&desc->txd);
> 			dmaengine_desc_get_callback_invoke(&desc->txd, &res);

[Severity: High]
This is a pre-existing issue, but can this cause a deadlock if a client cal=
lback
attempts to abort or terminate the DMA channel?

switchtec_dma_cleanup_completed() acquires swdma_chan->complete_lock with
spin_lock_bh() and invokes the client callback synchronously here.

If the client calls dmaengine_terminate_all(), it invokes:

static int switchtec_dma_terminate_all(struct dma_chan *chan)
{
	struct switchtec_dma_chan *swdma_chan =3D
		container_of(chan, struct switchtec_dma_chan, dma_chan);

	spin_lock_bh(&swdma_chan->complete_lock);

This attempts to re-acquire the exact same complete_lock unconditionally, c=
ausing
a self-deadlock on a single CPU core.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727181526.9672=
-1-logang@deltatee.com?part=3D4
