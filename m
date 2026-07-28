Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF603A83A8;
	Tue, 28 Jul 2026 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260886; cv=none; b=NVEcJTsuuebHvM1Oolbsw3WzdvyRBH/CKIDx0WA65wh61/eqgbX66+kZwtk8QbWHGRQZw5+6lYN6mrk96Mky1EPDWrLguCuiB/X0T6z+4JrS5Y7LMe4CVv9YV785Ac7hbIJ3Xg4OXrjhuBikrGO3G+Y2lzifxI/A7QBTBfTI5LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260886; c=relaxed/simple;
	bh=vXHDAYi7k31CMnmKp3WEERwzA06gBfdupQwVo6FfSzY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wy3b8ChGIsvbfPtHDpjaxZRQ7PThmgL8ofByw/2OViQLiPY2onXLlbOr6C43T0GXbmlIzaZ1RUqhsXDgs3SuXzrj0bHHYK4pGLli3wyNxQu8V4UQNAoTHThrQJ8tYP5189tyZC85G1LeJ+gtH3IhOOtPpJG3dXN7Z/gLsdpqUuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFSbKS94; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFSbKS94"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742BE1F000E9;
	Tue, 28 Jul 2026 17:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260883;
	bh=eqDX9Gaq3hTUaUI+dQ87Y99Tn2R3M4OjMvJRayoSSV8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dFSbKS94Sw5lyUSDKbiyh6iiN6onlPCeyC5Q7122qgsYdXVAZc1VHlC3pjeiMxjq/
	 TahC6sqTSDxItUyPi3XxY7xhXe2Gjzb5fNGUck6YvRH6GKE6cc1Zd8W6wgS9S8fLkB
	 9YvJmcgtUQAS07PcLyu0LSQZQtdFUm+fvEtmqOAaTODWoKyNFCiQYkkStJbmMtDLAE
	 nitwYKWyk2mjyzHmKf7QIbeaRtp1JXSO15eomGk0vqc+5zKgX9W6xSsPxWDFI0gBWf
	 ba76Mdn4aQsFFynp6JbLweUlIlUOWhQEH6HfAsTnnsA2nJRrZYAL0yH4BHxkNzMWqt
	 5f5uJyCrtkpUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/12] dmaengine: switchtec-dma: fix use-after-free
 of swdma_dev in remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260728171523.112244-10-logang@deltatee.com>
References: <20260728171523.112244-1-logang@deltatee.com>
 <20260728171523.112244-10-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:48:03 +0000
Message-Id: <20260728174803.742BE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] DMA coherent buffers and descriptor structures are permanently lea=
ked in `switchtec_dma_free_chan_resources()` if a channel is released after=
 device hot-unplug.
- [High] Missing NULL check for the result of `ioremap()` in `switchtec_dma=
_create()`.
--

--- Patch [9]: [PATCH v4 09/12] dmaengine: switchtec-dma: fix use-after-fre=
e of swdma_dev in remove() ---
commit 07d288b1e2418ad94452e6749769e4b45a0f0978
Author: Logan Gunthorpe <logang@deltatee.com>
Subject: dmaengine: switchtec-dma: fix use-after-free of swdma_dev in remov=
e()

This commit addresses a use-after-free by caching the bar address before
unregistering the device. During dma_async_device_unregister(), the last
reference to dma_dev can be dropped, synchronously freeing swdma_dev before
the original code used it for iounmap().

Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index ecf3a44d4dcc4..babb2bcb62084 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1393,6 +1393,7 @@ static int switchtec_dma_probe(struct pci_dev *pdev,
>  static void switchtec_dma_remove(struct pci_dev *pdev)
>  {
>  	struct switchtec_dma_dev *swdma_dev =3D pci_get_drvdata(pdev);
> +	void __iomem *bar =3D swdma_dev->bar;
> =20
>  	switchtec_dma_chans_release(pdev, swdma_dev);
> =20
> @@ -1405,7 +1406,7 @@ static void switchtec_dma_remove(struct pci_dev *pd=
ev)
> =20
>  	dma_async_device_unregister(&swdma_dev->dma_dev);
> =20
> -	iounmap(swdma_dev->bar);
> +	iounmap(bar);
>  	pci_release_mem_regions(pdev);
>  	pci_disable_device(pdev);
>  }

[Severity: High]
This is a pre-existing issue, but I noticed a missing NULL check for the
result of ioremap() in switchtec_dma_create():

drivers/dma/switchtec_dma.c:switchtec_dma_create() {
    swdma_dev->bar =3D ioremap(pci_resource_start(pdev, 0),
                             pci_resource_len(pdev, 0));
    ...
    irq =3D readw(swdma_dev->bar + SWITCHTEC_REG_CHAN_STS_VEC);
}

If ioremap() fails and returns NULL, could this result in a NULL pointer
dereference when we try to read from it?

[Severity: High]
This is a pre-existing issue, but does this code permanently leak DMA
coherent buffers and descriptor structures if a channel is released after
device hot-unplug?

drivers/dma/switchtec_dma.c:halt_channel() {
    pdev =3D rcu_dereference(swdma_chan->swdma_dev->pdev);
    if (!pdev) {
        ret =3D -ENODEV;
        goto unlock_and_exit;
    }
}

When pdev is NULL, halt_channel() returns -ENODEV, which propagates to
switchtec_dma_chan_stop().=20

Then in switchtec_dma_free_chan_resources():

    rc =3D switchtec_dma_chan_stop(swdma_chan);
    switchtec_dma_abort_desc(swdma_chan, 0);
    if (!rc)
        switchtec_dma_free_desc(swdma_chan);

Since switchtec_dma_chan_stop() returned -ENODEV (which is non-zero), the
call to switchtec_dma_free_desc() is skipped. While skipping cleanup might
make sense if hardware times out, is this intentional for hot-unplug cases
where the hardware is physically absent?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728171523.1122=
44-1-logang@deltatee.com?part=3D9
