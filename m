Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2600A3D3492;
	Mon, 27 Jul 2026 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180514; cv=none; b=GQCCx1qyhF5qJK6Edx0Pxev+qcJ2C/hHca7Y1acrGYnoar2eBDzCfUP8cE2bWx/u7kPfiXj2Ap8HFgP0IE9PbSEdxkmFHrOz8hnopnnGBqQbVeDVISIRLKHQLV/OIDHCC5D3/Pt/0vxDBJ8QoJKcXuBRzoJzl7LiTsVSM9ZHLrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180514; c=relaxed/simple;
	bh=pt7c+IYrZmhDZJAOgqhniP5f4g0dsusOojerIR3qS8I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kWPOpCGA3TJQtYP05HixzcVbgTwnhM6SbhxgJwtKwRdfe4E9RlWUSHFcNUSDYzBsBlyzlAkzCHTeA2UI82Y9AGY5GGq/PgIGpk+xii9ASuDUzEj9H4UABfftV3Z5LE19UI0mLwFXdAITuT4lwyiuM26mMdEzui0EDRUp2p7qAMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJUpLiHt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJUpLiHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C991F000E9;
	Mon, 27 Jul 2026 19:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785180513;
	bh=/XJwn/dWibDwAlxOkqgsayA2XnzIY/6xKk9OywdbbAc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DJUpLiHtoCFnyQ/E2hAxgHhbwkDwnjwzwZcB9+90Ckg+ivi7qQoOxhikXNxH0DANL
	 NrxoS0PexPASE3nVvzvGxsZDOpVewNPuMqaLhc+0cDBxbidyadPIukdJ1bZQnyD9Ek
	 41h34WwDxX2lkBic6ah7EcogA4Dws26EKIwPEWFFt3FFtp8aiiwfWZB3yneVxdWj5i
	 auXeHFwr8VPZFAKSbXc9SafOAid4WNJn9/okhhJ95Kj1YJmNi1K0aWqxnR4XSzs+0h
	 Rz5qVozFCcMq5qQrJokSm5RfPOxRWHYkC3/xw9uJSWCNgtmpfRE7eX4AmhaWyTLnAg
	 fVBmy357isZng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/11] dmaengine: switchtec-dma: fix chan_status_irq
 cleanup on create() error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260727181526.9672-7-logang@deltatee.com>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-7-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:28:32 +0000
Message-Id: <20260727192832.B1C991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unmapping `swdma_dev->bar` after `dma_async_device_unregister` cau=
ses a use-after-free.
- [High] Missing NULL check after `ioremap()` in `switchtec_dma_create` lea=
ds to a NULL pointer dereference on failure.
- [High] The DMA channel list is initialized after the status IRQ is reques=
ted, allowing an early interrupt to trigger a NULL pointer dereference.
- [High] In the error paths of `switchtec_dma_create()`, DMA channels are f=
reed while the status IRQ remains registered, causing a Use-After-Free.
- [High] Invoking client callbacks while holding a driver spinlock causes a=
 recursive locking deadlock if the callback re-enters the driver.
- [High] Incorrect teardown sequence in device remove risks hangs or crashe=
s for active DMA clients.
--

--- Patch [6]: [PATCH v3 06/11] dmaengine: switchtec-dma: fix chan_status_i=
rq cleanup on create() error ---
commit 4abb826d6d25e80cfa344cde79ed065a727edad5
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix chan_status_irq cleanup on create() error

This patch initializes chan_status_irq to -1 and uses the non-negative
value to determine when to call pci_free_irq() instead of free_irq().
This prevents freeing the wrong Linux IRQ and ensures the handler is
properly unregistered when the vector index is 0.

Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index c752a1b05871d..31feb2816e79b 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1248,6 +1248,8 @@ static int switchtec_dma_create(struct pci_dev *pde=
v)
>  	if (!swdma_dev)
>  		return -ENOMEM;
> =20
> +	swdma_dev->chan_status_irq =3D -1;
> +
>  	swdma_dev->bar =3D ioremap(pci_resource_start(pdev, 0),
>  				 pci_resource_len(pdev, 0));

[Severity: High]
This is a pre-existing issue, but does ioremap() need a NULL check here?

If it fails under memory pressure and returns NULL, swdma_dev->bar will be
assigned NULL.

Shortly after, the code executes:

    irq =3D readw(swdma_dev->bar + SWITCHTEC_REG_CHAN_STS_VEC);

Will this lead to an immediate NULL pointer dereference?

[ ... ]

> @@ -1322,8 +1324,8 @@ static int switchtec_dma_create(struct pci_dev *pde=
v)
>  	switchtec_dma_chans_free(swdma_dev);
> =20
>  err_exit:
> -	if (swdma_dev->chan_status_irq)
> -		free_irq(swdma_dev->chan_status_irq, swdma_dev);
> +	if (swdma_dev->chan_status_irq >=3D 0)
> +		pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);

[Severity: High]
This isn't a bug introduced by this patch, but can this error path lead to a
use-after-free?

If dma_async_device_register() fails, the code jumps to
err_chans_release_exit, which calls switchtec_dma_chans_free(). This frees
the channel structures but leaves them linked in dma_dev->channels.

The status IRQ remains registered until pci_free_irq() is called here.

If an interrupt fires during this window, will
switchtec_dma_chan_status_isr() iterate the list and access the freed
channel objects?

> =20
>  	iounmap(swdma_dev->bar);
>  	kfree(swdma_dev);

While reviewing this file, I noticed a few other pre-existing issues.

[Severity: High]
This is a pre-existing issue, but could an early interrupt trigger a NULL
pointer dereference?

In switchtec_dma_create(), pci_request_irq() is called before the channel
list is initialized:

switchtec_dma_create()
    ...
    rc =3D pci_request_irq(pdev, irq, NULL, switchtec_dma_chan_status_isr, =
...);

If an interrupt fires immediately, switchtec_dma_chan_status_isr() will
execute:

switchtec_dma_chan_status_isr()
    ...
    list_for_each_entry(chan, &dma_dev->channels, device_node) {

Since swdma_dev was allocated with kzalloc_obj(), the list head is NULL.

Does iterating this uninitialized list bypass termination checks and crash?


[Severity: High]
This isn't a bug introduced by this patch, but can unmapping swdma_dev->bar
after unregistering the DMA device cause a use-after-free?

Looking at switchtec_dma_remove(), dma_async_device_unregister() is called
before iounmap():

switchtec_dma_remove()
    ...
    dma_async_device_unregister(&swdma_dev->dma_dev);
    iounmap(swdma_dev->bar);
    ...

When dma_async_device_unregister() drops the final reference to the DMA
device, it triggers the release callback:

switchtec_dma_release()
    ...
    kfree(swdma_dev);

Will this sequence cause iounmap() to dereference the freed swdma_dev
structure?


[Severity: High]
This is a pre-existing issue, but can invoking client callbacks while
holding the driver spinlock cause a recursive locking deadlock?

Looking at switchtec_dma_cleanup_completed():

    spin_lock_bh(&swdma_chan->complete_lock);
    ...
    dmaengine_desc_get_callback_invoke(&desc->txd, &res);

If the client callback re-enters the driver API, for example by calling
dmaengine_tx_status(), it will execute switchtec_dma_tx_status(), which
again calls switchtec_dma_cleanup_completed().

Since complete_lock is a non-recursive spinlock, will this inner call
attempt to acquire it and lead to an immediate self-deadlock?


[Severity: High]
This isn't a bug introduced by this patch, but is the teardown sequence in
switchtec_dma_remove() correct?

switchtec_dma_remove()
    ...
    switchtec_dma_chans_release(pdev, swdma_dev);
    ...
    dma_async_device_unregister(&swdma_dev->dma_dev);

Here, switchtec_dma_chans_release() halts the hardware and frees channel IR=
Qs
before dma_async_device_unregister() safely quiesces the DMA engine.

Will this inverted teardown destroy the hardware state while the DMA core
still considers the device active, causing active clients to hang waiting
for completions or crash if they submit new requests?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727181526.9672=
-1-logang@deltatee.com?part=3D6
