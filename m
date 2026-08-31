Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F1D375F95;
	Mon, 31 Aug 2026 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215715; cv=none; b=cvwDr4c+2ONBvqJeXhcIGsIsZg7nhqcOA1cKQhIi3isjjeuTVc9tWLk06OTxQHMkRKdL3V43wkuSTv7CP19dA1RbaK/Oaz8+II8zQ28yBnO2ggcgQ2Xf+9fFYIQ1Zi9L5ZxytWhDyb7y79z0hT6kNSCtPoG+otlftgKWC40VtAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215715; c=relaxed/simple;
	bh=xxjsYQYXXkIxZzRpiNF2SIqhZPC1bkuSlLTKIrSHLfg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UVyDQ8E0gIePxEDrvHxGUnEkGOYO9y8GLjOM2g74Ca+aen9fXoFXd9XzFZ8u+PWktbvpWhlkhqSvs2LEYGA5OEKZauFWAqm0/6quZNX6Jv0OoYoRpK57/wiUvX/kZNs8npuD8R2DRLREzRDJ/NQ8aDGK/03SlWtdVB5QV0HTCjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HusuoxG1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HusuoxG1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BB71F000E9;
	Mon, 31 Aug 2026 22:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788215714;
	bh=tF0OYLuPWwihy+vR5660ruY+uuiMQk0LpExChy9aanQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HusuoxG1kwMYIY546O4bGyhg9sQy2PRvaihE/8jr6vpX4oVIAwEQrocxH3YG/vhJH
	 MYNURg3ocSsB6McruA01aRyiTAiRBgZF30DmqU2v9X04GDr0g1ucWP3696zjCumGA2
	 rvlGUt3U1ysEtLxDJRprCTDKM8TMwNTydOXeZ0lcfkfnd/ZYgCd6wCqBzsLKGCft2p
	 +w0ljh/YiAq8xqC4AvG3Y+tg6mqqShYqmzpzW21lG0wkVoJq0WD8ei+flRuoVZj+88
	 IsHmucmIL00R6zOscEt0ZdEpjCdold5xPEY4Fr54vggocvtPmOvA6Z0x2xMg2aB10w
	 q9oaEsEayhm7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/12] dmaengine: switchtec-dma: fix chan_status_irq
 cleanup on create() error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260831191403.207631-8-logang@deltatee.com>
References: <20260831191403.207631-1-logang@deltatee.com>
 <20260831191403.207631-8-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:35:11 +0000
Message-Id: <20260831223512.26BB71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unchecked return value of ioremap() can lead to a NULL pointer der=
eference.
- [High] Interrupt handler is registered before the DMA channels list is in=
itialized, risking a NULL pointer dereference.
- [High] DMA device is unregistered after channels and IRQs are torn down.
- [High] Holding a spinlock while busy-waiting for up to 100 milliseconds d=
isables preemption for an unacceptable duration, potentially causing RCU st=
alls or soft lockups.
- [Medium] The return value of dma_set_mask_and_coherent() is ignored.
- [Medium] Missing put_device() causes reference count leak on the device s=
tructure in the error path of switchtec_dma_create().
--

commit 789f2f9ebf1e9dd9f52e2557e403d93f922154be
Author: Logan Gunthorpe <logang@deltatee.com>
Subject: dmaengine: switchtec-dma: fix chan_status_irq cleanup on create() =
error

This commit ensures that chan_status_irq is properly cleaned up on error by
using pci_free_irq() instead of free_irq(). It also initializes the IRQ vec=
tor
index to -1 so that a valid index of 0 is no longer skipped during cleanup.

Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index c30530ba78caf..3068d9de4e6d3 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1262,6 +1262,8 @@ static int switchtec_dma_create(struct pci_dev *pde=
v)
>  	if (!swdma_dev)
>  		return -ENOMEM;
> =20
> +	swdma_dev->chan_status_irq =3D -1;
> +
>  	swdma_dev->bar =3D ioremap(pci_resource_start(pdev, 0),
>  				 pci_resource_len(pdev, 0));

[Severity: High]
This is a pre-existing issue, but shouldn't we check the return value of=20
ioremap() here?

If ioremap() fails, swdma_dev->bar will be NULL. The code immediately proce=
eds
to dereference it via readw(swdma_dev->bar + SWITCHTEC_REG_CHAN_STS_VEC). C=
an=20
this lead to a NULL pointer dereference and kernel panic during device prob=
e?

[ ... ]

>  err_exit:
> -	if (swdma_dev->chan_status_irq)
> -		free_irq(swdma_dev->chan_status_irq, swdma_dev);
> +	if (swdma_dev->chan_status_irq >=3D 0)
> +		pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);
> =20
>  	iounmap(swdma_dev->bar);
>  	kfree(swdma_dev);
>  	return rc;

[Severity: Medium]
This is a pre-existing issue, but does this error path leak the device=20
reference?

Earlier in switchtec_dma_create(), a reference is acquired:

    dma->dev =3D get_device(&pdev->dev);

If dma_async_device_register() fails, the code jumps to=20
err_chans_release_exit and eventually falls through to err_exit, but=20
put_device(dma->dev) is never called. Since the device wasn't successfully=
=20
registered, switchtec_dma_release() won't be called to drop this reference.

In drivers/dma/switchtec_dma.c:switchtec_dma_probe():

    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
    rc =3D pci_request_mem_regions(pdev, KBUILD_MODNAME);

[Severity: Medium]
This is a pre-existing issue, but is the return value of=20
dma_set_mask_and_coherent() intentionally ignored here?

If the platform or IOMMU rejects the 64-bit mask, this function can fail.=20
Should the driver check the return value and gracefully fallback to 32-bit
DMA or fail the probe to prevent silent data corruption or IOMMU faults?

In drivers/dma/switchtec_dma.c:switchtec_dma_create():

    rc =3D pci_request_irq(pdev, irq, NULL, switchtec_dma_chan_status_isr,
                         swdma_dev, KBUILD_MODNAME);
    if (rc)
        goto err_exit;

[Severity: High]
This is a pre-existing issue, but does registering the interrupt handler he=
re=20
risk a NULL pointer dereference?

Later in switchtec_dma_create(), switchtec_dma_chans_enumerate() is called,=
=20
which initializes the dma->channels list:

    INIT_LIST_HEAD(&dma->channels);

At the time of IRQ registration, swdma_dev was allocated with kzalloc_obj()=
,=20
meaning dma_dev->channels.next is NULL. If an interrupt fires immediately=20
after registration, switchtec_dma_chan_status_isr() will execute:

    list_for_each_entry(chan, &dma_dev->channels, device_node) {

Since the list head is zeroed, this loop could underflow and dereference an=
=20
invalid pointer, leading to a kernel oops.

In drivers/dma/switchtec_dma.c:switchtec_dma_remove():

    switchtec_dma_chans_release(pdev, swdma_dev);
   =20
    rcu_assign_pointer(swdma_dev->pdev, NULL);
    synchronize_rcu();
   =20
    pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);
    pci_free_irq_vectors(pdev);
   =20
    dma_async_device_unregister(&swdma_dev->dma_dev);

[Severity: High]
This is a pre-existing issue, but is the DMA device unregistered too late in
the teardown process?

The driver initiates hardware teardown by stopping channels and freeing IRQs
before calling dma_async_device_unregister(). Tearing down hardware and IRQs
while the device is still exposed to the DMA engine subsystem can lead to=20
use-after-free, hanging clients, or hardware access races if a client=20
actively uses the DMA device during removal. Should the subsystem be=20
unregistered first?

In drivers/dma/switchtec_dma.c:wait_for_chan_status():

    return readl_poll_timeout_atomic(&chan_hw->status, status,
                                     (set && (status & mask)) ||
                                     (!set && !(status & mask)),
                                     10, 100 * USEC_PER_MSEC);

[Severity: High]
This is a pre-existing issue, but could this atomic poll loop cause soft
lockups or RCU stalls?

This function is called from halt_channel() while holding a spinlock:

    spin_lock(&swdma_chan->hw_ctrl_lock);
    writeb(SWITCHTEC_CHAN_CTRL_HALT, &chan_hw->ctrl);
    ret =3D wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_HALTED, true);
    spin_unlock(&swdma_chan->hw_ctrl_lock);

Since holding a spinlock disables preemption, blocking the CPU for up to 100
milliseconds without preemption could severely degrade system latency.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831191403.2076=
31-1-logang@deltatee.com?part=3D7
