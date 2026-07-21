Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5743254BD;
	Tue, 21 Jul 2026 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651799; cv=none; b=ChtRqnLt/9U/aN3PrP83dr00pNokxR+IwakkcYYANetA07cHGIjscCcMh2GXYXjU1SLYv2o+WXlY0QiaN+FTeGqBfOG2pHV68rLsfbaEqCk9om/V21jyLU1PacC2SiSsdEOMgDSacS9na/MvT4xWBqKVVdAXg9hXWDdAAYm9DHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651799; c=relaxed/simple;
	bh=dQBRuTQNIPTlB0snqosTGQWNXzuMTeePAkASfMwNGMg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZwpD5vZFzddX7b02CVJBkDEhHSYWNijzU0E+D+tev1KN9O0CjkJoHsSbyaSBqQfWLuizTwm3navpvC2vdXn4RiKCOzU8ink775CEILM0fgMZnymkWtW23ROzQLPLlOKqDIwUDUYjmx5DPFEnux94rI3g/pJqOEhrdLrNOgqwgPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XB2e9rXx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XB2e9rXx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905601F000E9;
	Tue, 21 Jul 2026 16:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784651797;
	bh=dptWaGrz99xJ8FmC83NpagCyFHvs6A+N8YRLNh+gCw4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XB2e9rXxrBkC0ocmE1NrX8sSaBxsW1pFUx/SacVSMxNZEw4d0uH9jwr8zwdMd5Z/m
	 tM3NXh1CHcVLg9AV4LX8e6x9PXWjPcm6NZAcb6UZc8giD/LZkIYDN3IiOg09RrUv47
	 EJYM6X9xmU0CMMjVvgzdpadauSwnYcNE1kIMGcH2jFu8LgSnkJvjfEi4EEXtN+cMuy
	 bewzj/M5DNwZhfIwKHFZcY09hy/BTIeo+BOW6EEH0yz50NiA9x3CfVUlfbT5ToTC3t
	 hUvu13SBp9LPgXj4l73ky3+xTt2K3p44P+9AgsN4cATzDsaGdcpxq4Q81GUccK35VG
	 3pAQ8TSrI2SEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/11] dmaengine: switchtec-dma: fix use-after-free
 of swdma_dev in remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260721155739.62120-8-logang@deltatee.com>
References: <20260721155739.62120-1-logang@deltatee.com>
 <20260721155739.62120-8-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 16:36:37 +0000
Message-Id: <20260721163637.905601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect IRQ cleanup in `switchtec_dma_create` error path using `=
free_irq` with a hardware vector index instead of `pci_free_irq`.
- [High] Pending DMA transactions are not aborted during device removal, po=
tentially causing DMA clients to hang indefinitely.
- [High] Missing bounds check on the hardware-provided channel count allows=
 out-of-bounds MMIO accesses.
- [Medium] Missing `put_device(dma->dev)` in the `switchtec_dma_create` err=
or path causes a reference count leak on the PCI device.
--

--- Patch [7]: [PATCH v2 07/11] dmaengine: switchtec-dma: fix use-after-fre=
e of swdma_dev in remove() ---
commit 0e37b79ac2f6503c0a4dc42c7b0cf19efff70cbd
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix use-after-free of swdma_dev in remove()

This patch fixes a use-after-free regression in switchtec_dma_remove() by
caching the PCI BAR in a local variable before dma_async_device_unregister()
is called, avoiding access to swdma_dev after it is freed.

Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 2a1ae27bd1a69..a7e25cb7c0b9f 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
[ ... ]
> @@ -1388,7 +1389,7 @@ static void switchtec_dma_remove(struct pci_dev *pd=
ev)
> =20
>  	dma_async_device_unregister(&swdma_dev->dma_dev);
> =20
> -	iounmap(swdma_dev->bar);
> +	iounmap(bar);
>  	pci_release_mem_regions(pdev);
>  	pci_disable_device(pdev);
>  }

While reviewing this patch, I noticed a few pre-existing issues in the driv=
er
that might be worth addressing.

drivers/dma/switchtec_dma.c:switchtec_dma_create() {
    ...
    chan_cnt =3D readl(swdma_dev->bar + SWITCHTEC_REG_CHAN_CNT);

[Severity: High]
This is a pre-existing issue, but is it safe to use this hardware-provided
channel count without bounds checking?

If the endpoint returns an unexpectedly large channel count, this value is
later used in switchtec_dma_chan_init() to calculate MMIO offsets:

    swdma_chan->mmio_chan_fw =3D
        swdma_dev->bar + SWITCHTEC_DMAC_CHAN_CFG_STS_OFFSET +
        i * SWITCHTEC_DMA_CHAN_FW_REGS_SIZE;

Since chan_cnt is never validated against the mapped length of the PCI BAR,
could this result in out-of-bounds MMIO accesses?

    if (!chan_cnt) {
        pci_err(pdev, "No channel configured.\n");
        rc =3D -ENXIO;
        goto err_exit;
    }
    ...
err_chans_release_exit:
    switchtec_dma_chans_unlist(swdma_dev);
    switchtec_dma_chans_release(pdev, swdma_dev);
    switchtec_dma_chans_free(swdma_dev);

[Severity: Medium]
This is another pre-existing issue, but does this error path leak the device
reference count?

If dma_async_device_register() fails earlier in this function, we jump here,
but there is no call to put_device() to balance the get_device() called
previously. This could leave the PCI device with an elevated reference count
permanently.

err_exit:
    if (swdma_dev->chan_status_irq)
        free_irq(swdma_dev->chan_status_irq, swdma_dev);

[Severity: High]
This is a pre-existing issue, but could this lead to a use-after-free
if an interrupt fires?

The code requests the IRQ using pci_request_irq() with a hardware vector
index, but attempts to free it here with free_irq() using that same vector
index instead of the global Linux IRQ number. Since free_irq() expects a
global IRQ number, it may fail to free the interrupt. The handler would
remain registered while swdma_dev is freed right after this.

Also, if the hardware uses vector 0, the if statement skips cleanup entirel=
y.
Should this use pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev)
instead?

    iounmap(swdma_dev->bar);
    kfree(swdma_dev);
    return rc;
}


drivers/dma/switchtec_dma.c:switchtec_dma_chan_free() {
    ...
    pci_free_irq(pdev, swdma_chan->irq, swdma_chan);
    tasklet_kill(&swdma_chan->desc_task);

    switchtec_dma_chan_stop(swdma_chan);

[Severity: High]
This is a pre-existing issue, but does removing the device without aborting
pending transactions cause DMA clients to hang indefinitely?

If a client is blocking on a completion object (e.g., via
wait_for_completion), and the device is removed, the IRQ is freed and the
hardware is stopped here. However, active descriptor rings aren't traversed
to report DMA_TRANS_ABORTED. Can this prevent the client from ever unbindin=
g?

    return 0;
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721155739.6212=
0-1-logang@deltatee.com?part=3D7
