Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8337343885;
	Tue, 28 Jul 2026 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260392; cv=none; b=VOjUgNZHj5XYZGSr1DwUfRvPDC/7AVXC7P2ClhIvs7x/vwKFkqjdyrOHbEIa5Bx3dELqKgMsbZjyB5m/2HlNxstmy8AeCwB+IW+nzzaNxVv6cIAZR2jDk6q3dzB17vG9PBE2sfM4zFKDRwlkxo8G9R1wcZPW7Qu3VMUe7u048Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260392; c=relaxed/simple;
	bh=wfoSdOM3kwbqV3x2rYTIhvOEklMbO8OwaI1ajLqbrc4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MmbMVvqZg5Fn0fV+k8UTHOUxgvLnLGK4YSz1smXOFEuS1TmV8rv3a1LkqmctTo4yl14qZfysgN9w3EjGXaK/qnHzqwO/G8J4zkBvl6WovtyI1ObhbMZT+nC2LvVFj/G2wVyXN5hf7uqJJG3eUmdjkwEICFfaXuRTrDgdM6X3ISs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwjtJ2TX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwjtJ2TX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA651F000E9;
	Tue, 28 Jul 2026 17:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260390;
	bh=5eKGY2logg3Xmm9RetMcdnL+ZZvRZ05/kPmCxcGyaYQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IwjtJ2TXwdTFpiIVneMsifK0Ad1oknn+LWYVsVrb88iRvHBUFo/BJXkSoq+3FHVTU
	 12iqJ3Lu685f9bYX2SqxQYvhcs/CDXYm/9sY5h8TAVRY6zyOJsqjLgVNGaKHHTm/qz
	 ziHuFce547sOkKNz2byCtaJ3QGF/3r/a/WFdwpMRlOqHQnf2kty1A6ffZrcpR5mN8R
	 x6bv3zN3BTroYoiQEZxQ6MovG+NWR7o/yXdxnz0BCOj7iFrkFp0jUywRgw7PoEjb27
	 UQp2oc9RFmd4ES0CkkhiEMNQdPMTjYNYE3+N11yTheiXvNQ82IltdnjO1lC4RxaQLi
	 5w4ZVqVus359Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/12] dmaengine: switchtec-dma: fix chan_status_irq
 cleanup on create() error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260728171523.112244-8-logang@deltatee.com>
References: <20260728171523.112244-1-logang@deltatee.com>
 <20260728171523.112244-8-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:39:49 +0000
Message-Id: <20260728173949.CCA651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free of `swdma_dev` in `switchtec_dma_remove()` due to t=
eardown ordering.
- [High] Missing validation of `ioremap()` return value leads to NULL point=
er dereference.
- [High] IRQ handler registered before data structures are initialized lead=
ing to a NULL pointer dereference.
- [High] Unvalidated hardware register `chan_cnt` leads to out-of-bounds MM=
IO accesses.
--

--- Patch [7]: [PATCH v4 07/12] dmaengine: switchtec-dma: fix chan_status_i=
rq cleanup on create() error ---
commit 52eb1f3ef1524cf69a5b20f4b681533c108b4f8f
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix chan_status_irq cleanup on create() error

This commit fixes the cleanup of chan_status_irq in the create() error
path. It properly initializes the irq index to -1 and uses pci_free_irq()
instead of free_irq() to ensure the correct Linux IRQ is freed.

Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 63e60de9f86dc..6ab2c62b52fd8 100644
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
> =20

[Severity: High]
This is a pre-existing issue, but is it possible for ioremap() to fail here?

If the mapping fails due to exhausted vmalloc space, it returns a NULL poin=
ter.
Shortly after this, the code calls readw(swdma_dev->bar + SWITCHTEC_REG_CHA=
N_STS_VEC),
which would result in an unconditional NULL pointer dereference.

Should there be a check for swdma_dev->bar being NULL before proceeding?

> @@ -1336,8 +1338,8 @@ static int switchtec_dma_create(struct pci_dev *pde=
v)
>  	switchtec_dma_chans_free(swdma_dev);
> =20
>  err_exit:
> -	if (swdma_dev->chan_status_irq)
> -		free_irq(swdma_dev->chan_status_irq, swdma_dev);
> +	if (swdma_dev->chan_status_irq >=3D 0)
> +		pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);
> =20
>  	iounmap(swdma_dev->bar);
>  	kfree(swdma_dev);

While reviewing this patch, I noticed a few other pre-existing issues in the
surrounding code:

[Severity: High]
This isn't a bug introduced by this patch, but could this lead to an
uninitialized list dereference if an interrupt fires early?

In switchtec_dma_create(), pci_request_irq() is called and enables
switchtec_dma_chan_status_isr before the dma->channels list is initialized
by INIT_LIST_HEAD().

If an interrupt fires during this window, switchtec_dma_chan_status_isr() w=
ill
iterate over the zero-initialized dma_dev->channels list:

switchtec_dma_chan_status_isr()
    list_for_each_entry(chan, &dma_dev->channels, device_node) {

Since swdma_dev was allocated with kzalloc_obj, the next pointer is NULL,
which would cause an invalid pointer dereference when evaluating
chan->dev->device.

Should the IRQ be requested after the channel list is fully initialized?

[Severity: High]
This isn't a bug introduced by this patch, but does this code trust the
hardware register chan_cnt too much?

The driver reads chan_cnt directly from SWITCHTEC_REG_CHAN_CNT:

switchtec_dma_create()
    chan_cnt =3D readl(swdma_dev->bar + SWITCHTEC_REG_CHAN_CNT);

This count is then used in switchtec_dma_chans_enumerate() to calculate MMIO
offsets via pointer arithmetic:

switchtec_dma_chan_init()
    swdma_chan->mmio_chan_fw =3D swdma_dev->bar + SWITCHTEC_DMAC_CHAN_CFG_S=
TS_OFFSET +
                               i * SWITCHTEC_DMA_CHAN_FW_REGS_SIZE;

If a faulty or maliciously crafted PCI endpoint provides a dangerously large
chan_cnt, could this cause the driver to read and write far outside the saf=
ely
allocated ioremap region?

Should chan_cnt be validated against the actual size of the mapped PCI BAR?

[Severity: High]
This isn't a bug introduced by this patch, but is there a use-after-free
during device teardown?

During module unload or device removal, switchtec_dma_remove() calls
dma_async_device_unregister(&swdma_dev->dma_dev).

This synchronously drops the reference count of the DMA device to 0 if there
are no active clients, which triggers the switchtec_dma_release() callback.

switchtec_dma_release()
    kfree(swdma_dev);

Immediately following this, switchtec_dma_remove() continues teardown:

switchtec_dma_remove()
    dma_async_device_unregister(&swdma_dev->dma_dev);
    iounmap(swdma_dev->bar);

Because swdma_dev has already been freed, does accessing the bar member for
unmapping result in a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728171523.1122=
44-1-logang@deltatee.com?part=3D7
