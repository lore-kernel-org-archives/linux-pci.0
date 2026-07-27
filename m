Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10D64248AC;
	Mon, 27 Jul 2026 20:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182822; cv=none; b=jOa1PD2ov6WR0XPVkWaqvUJFK0w6T1oMP4Iag0THZ13OgO2uiFs906uHynjo7VyV8UJAE2kg3hAKtARMTeP/OpapliVSWP6x2hgylrrCiI29eiHJYRlI5eZo8o1PGo/8r4qh0qhuv8uO2R9qxowKsSkPaT+U3kvvS5bvm9oHw/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182822; c=relaxed/simple;
	bh=9lMBIt9JzLYor/8jU1paTN05CWh0pExCXgGe54v+MHo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tM735Q9qRugCrISyPGgXehNcYFNXrQ+n2AbaCg1IWUUa6Tc8NVKXSpArtJS1TeTK1M7IKmGXZFnKZBVqkI2VpOyh2mIxeMQ1JePxlp7e+7p8S+6qzBklSDp8CO7eZc13MJorrcfSHQm1Fh9LOVZDk0zUUC/UuDs5SThsBmYuSSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQjUm52v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQjUm52v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FEBC1F00A3A;
	Mon, 27 Jul 2026 20:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785182820;
	bh=KwUcdDxYplkOmTwya6GwP9bI8zKV8hTZuxuskwdEgis=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZQjUm52v/iNw8ByRmj/Vk0IMLJmXxgZ7L6LoSz+Vyx84uKo1UjUiHFqitpOzkKhya
	 Su0dp+jhlke3seUxXcHtiVNat5UWYh7t3T2m/XvNEOGphU0onx2iZLbRDGZm45z8Pp
	 fWUi62NpXAnDyStd/g8GYsrU0YBlVGH6HMPiA8XxjPXFaZIJ2mWIsKUKaL43ACZV/y
	 Q9SjRb1zWeOlT6k9QCq2WA1u62zSRdE9A9yTDZru64Y+1pBN7VfNEUHi/kNXE0Eo9n
	 hq0VBX0QG1oIigt9av6jEXCRvdryYrY4hDNfe4bBqUwABhH7zr4Q9PVY+QdlIYjOYL
	 +xV1U3nRsGR0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/11] dmaengine: ioat: disable relaxed ordering
 before registering the device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260727181526.9672-10-logang@deltatee.com>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-10-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 20:06:58 +0000
Message-Id: <20260727200659.9FEBC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Fallback from MSI-X to MSI leaves MSI-X enabled, breaking interrup=
t delivery.
- [High] Possible Use-After-Free of `device` in shared interrupt handler on=
 probe failure.
- [High] Global IDA leak in the dma_async_device_register error path.
- [Medium] Hardware prefetch limit is configured after the DMA device is ex=
posed.
- [Medium] Sysfs kobject 'quickdata' is added after device uevent (TOCTOU r=
ace).
--

--- Patch [9]: [PATCH v3 09/11] dmaengine: ioat: disable relaxed ordering b=
efore registering the device ---
commit bae11619501364346652f2b925166039da65e184
Author: Logan Gunthorpe <logang@deltatee.com>
Subject: dmaengine: ioat: disable relaxed ordering before registering the d=
evice

Moves the capability read/write ahead of dma_async_device_register() so
failure doesn't leave dangling registered devices.

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
> +
> +	ioat_kobject_add(ioat_dma, &ioat_ktype);
> +

[Severity: Medium]
This isn't a bug introduced by this patch, but doesn't this create a
TOCTOU race?  The sysfs kobject 'quickdata' and its attributes are added
after dma_async_device_register() has already emitted the KOBJ_ADD uevent.
Could userspace tools reacting to the uevent miss these sysfs attributes?

> +	if (dca)
> +		ioat_dma->dca =3D ioat_dca_init(pdev, ioat_dma->reg_base);
> +
>  	if (ioat_dma->cap & IOAT_CAP_DPS)
>  		writeb(ioat_pending_level + 1,
>  		       ioat_dma->reg_base + IOAT_PREFETCH_LIMIT_OFFSET);

[Severity: Medium]
This isn't a bug introduced by this patch, but is it safe to configure the
hardware prefetch limit after the DMA device has already been exposed?
Since dma_async_device_register() makes the channels available, could
concurrent DMA clients submit and execute operations with uninitialized or
stale prefetch hardware states before this writeb() occurs?


Additionally, while reviewing this code, I noticed a few pre-existing issues
outside the modified context:

[Severity: High]
This isn't a bug introduced by this patch, but in ioat_pci_probe(), the
device struct is manually freed if ioat3_dma_probe() fails:

drivers/dma/ioat/init.c:ioat_pci_probe() {
    ...
	err =3D ioat3_dma_probe(device, ioat_dca_enabled);
	if (err) {
		for (i =3D 0; i < IOAT_MAX_CHANS; i++)
			kfree(device->idx[i]);
		kfree(device);
		dev_err(dev, "Intel(R) I/OAT DMA Engine init failed\n");
		return -ENODEV;
	}
    ...
}

However, ioat_dma_setup_interrupts() allocates IRQs using
devm_request_irq(). Because the IRQs are devm-managed, they are not actually
unregistered until ioat_pci_probe() returns. Doesn't this create a window
where a shared interrupt could trigger ioat_dma_do_interrupt(), which
then casts and dereferences the already freed device pointer?

drivers/dma/ioat/dma.c:ioat_dma_do_interrupt() {
	struct ioatdma_device *instance =3D data;
    ...
	intrctrl =3D readb(instance->reg_base + IOAT_INTRCTRL_OFFSET);
    ...
}


[Severity: High]
This isn't a bug introduced by this patch, but when falling back from MSI-X
to MSI in ioat_dma_setup_interrupts(), is MSI-X properly disabled?

drivers/dma/ioat/init.c:ioat_dma_setup_interrupts() {
    ...
	err =3D pci_enable_msix_exact(pdev, ioat_dma->msix_entries, msixcnt);
	if (err)
		goto msi;

	for (i =3D 0; i < msixcnt; i++) {
        ...
		err =3D devm_request_irq(dev, msix->vector, ...);
		if (err) {
			for (j =3D 0; j < i; j++) {
                ...
				devm_free_irq(dev, msix->vector, ioat_chan);
			}
			goto msi;
		}
	}
    ...
}

If devm_request_irq() fails, the code frees the requested IRQs and jumps
to the msi label. However, it doesn't call pci_disable_msix(). Since the
device is still programmed for MSI-X, pci_enable_msi() will fail, and
the fallback will continue to INTx. Will the device ever generate INTx
interrupts if it was left with MSI-X enabled?


[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
dma_async_device_register() leak the global device IDA?

drivers/dma/dmaengine.c:dma_async_device_register() {
    ...
err_out:
	/* if we never registered a channel just release the idr */
	if (!device->chancnt) {
		ida_free(&dma_ida, device->dev_id);
		return rc;
	}

	list_for_each_entry(chan, &device->channels, device_node) {
    ...
}

If dma_async_device_register() successfully registers at least one channel
but fails on a subsequent one (so device->chancnt is greater than 0), it ju=
mps
to err_out. The error path explicitly skips calling ida_free() because
device->chancnt is greater than 0. Does this permanently leak the global
IDA for this device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727181526.9672=
-1-logang@deltatee.com?part=3D9
