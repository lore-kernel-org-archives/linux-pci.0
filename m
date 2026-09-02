Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF434314D34;
	Wed,  2 Sep 2026 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330791; cv=none; b=aaGQDHc3M75B95du0nkpRLlIYvSKhx9c0ippa5Jbo0dywDOoURJ3/z6COyOl9zdHSuSnZFEkUD1FHXFFo0N45kF37pgXiY+Rtvhxi6fYzP07KkVGMqKPwGh13ekMRLVyeWxYRVXldlaHGBd30oZmjWRxrg4WmXrHAZyrRd2pNTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330791; c=relaxed/simple;
	bh=OidBU9azT3V8TNtrCKK0sHS87UNn4DSnpcc/GIQKWc0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ob6CNKQUobancVtF9UnyqU2xqot0mAIhbFgaT+v1Cj2tSMwAPAejL4FoLg1iWRji9xGeNamTRU6pE+KjQ4GbbNDwT1jvvC/t3t5FHKPqJBlQlDbNNqmxMdwydHDzyzH5WRVeGlux0W8WJk45epbL6CKlBjYOB1qnv8vdTBQhuXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QojoMMGo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QojoMMGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116BD1F000E9;
	Wed,  2 Sep 2026 06:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788330790;
	bh=WLrwLtjGrFo3EMBzOTU1pW9wsbnEnTspQ808B4NxdiU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QojoMMGoVXthTgGdFMD0vYZ/Ge8Z0tq0NNLXUNsOi2+bqR0WjXOxivO4MJzQ7Kd+w
	 5migX/VJrdMZ92FAbdfOYuSavn6ZAWv5j2fMRdGSIoK3D5anlvOFuSwTBL3WGI4IDn
	 vE1qJ4k03ZwPOGHYyOMLdqlRWSKK1rRH8eXIgurou/walAwQf7d8DMqbxCJ8epblGm
	 JOTpHP4Y/nxvtiNqXwDCw/7QNMTfygrAkV16ha0HYh7+s9Af5lwGSi4Tw+qZGEOWzG
	 bGIP0roEtDWiVyKLTWK30FA98fAwMGYneKrBK0sDVbchE8pDemVdrCZnBbgGhXOifl
	 Xp2fXQlors4Xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/10] dmaengine: ioat: disable relaxed ordering
 before registering the device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260902062153.31048-9-logang@deltatee.com>
References: <20260902062153.31048-1-logang@deltatee.com>
 <20260902062153.31048-9-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 06:33:09 +0000
Message-Id: <20260902063310.116BD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free of `ioat_chan` and `ioatdma_device` structures on `=
ioat3_dma_probe` error path.
--

commit 5181bf41c6d9f7fa2de9a1b9a5e45637220e6c4f
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: ioat: disable relaxed ordering before registering the device

This patch reorders the initialization sequence in ioat3_dma_probe(). It
moves the PCIe relaxed ordering configuration before dma_async_device_regis=
ter()
to prevent leaving a dangling DMA device registration on the error path.

Link: https://lore.kernel.org/dmaengine/20260707165906.249F41F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> index 737496391109e..a57024c4b066e 100644
> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
[ ... ]
> @@ -1194,6 +1185,15 @@ static int ioat3_dma_probe(struct ioatdma_device *=
ioat_dma, int dca)
>  		goto err_disable_interrupts;
>  	}
> =20
> +	err =3D dma_async_device_register(&ioat_dma->dma_dev);
> +	if (err)
> +		goto err_disable_interrupts;

[Severity: High]
This isn't a bug introduced by this patch, but could this error path lead
to a use-after-free if a shared interrupt fires?

If ioat3_dma_probe() fails here, it returns the error back to
ioat_pci_probe(), which immediately frees the device and its channels
manually:

drivers/dma/ioat/init.c:ioat_pci_probe() {
    ...
    for (i =3D 0; i < IOAT_MAX_CHANS; i++)
        kfree(device->idx[i]);
    kfree(device);
    ...
}

However, the interrupts were previously registered using devm_request_irq()
in ioat_dma_setup_interrupts():

drivers/dma/ioat/init.c:ioat_dma_setup_interrupts() {
    ...
    err =3D devm_request_irq(dev, pdev->irq, ioat_dma_do_interrupt,
                           IRQF_SHARED, "ioat-intx", ioat_dma);
    ...
}

Because devm managed resources are not cleaned up until the callbacks run
after the probe function returns, the IRQ handler remains active during
this window.

If a shared interrupt or pending MSI/MSI-X fires before devres cleans up
the IRQ, will the handler dereference the already-freed ioatdma_device and
ioat_chan structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902062153.3104=
8-1-logang@deltatee.com?part=3D8
