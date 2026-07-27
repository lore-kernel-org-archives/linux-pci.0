Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CE343304A;
	Mon, 27 Jul 2026 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176912; cv=none; b=mpU1ccHHVkxZLhxSLVZlOw5RT0T4rI6sV0TORl0Gg6WLn4C/PIOS4l5I4oR93ferTNK8nhoJFcB1uYIlDPe8JV9mw2JzjOcax3jN4JEhgIc4K0jyzmM6dTQl3no5dR0f8WeQM1rxG7yCmnnyypCZXsvUkNFzhST5oaWt8DEYl+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176912; c=relaxed/simple;
	bh=PRWalR8uGIE7nhUei23NNzOrwYHYXuuxkwJ05nWHXyY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hm5zWKnE0mxOQke9ft9ho8H/wsdBzll99O7IOrle32MHBHrRkdHoUopohBihmTX0mePmj9fG2UIZ6Ten0uNCMxcAQOa/Yin3edOqGwFL3/NrSlKu/FS618jM/93sqrqokrT/36MBtpiTSUWipR0VzZZvsbp/Y2iWJqEeVpdJ3vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOcwlFnb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOcwlFnb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B6B1F000E9;
	Mon, 27 Jul 2026 18:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785176911;
	bh=AG6CLt8qofw1njFZrjwrPlz2AXBG1XjhfdMh3zI6iM8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cOcwlFnbliYB8d9ZfsdJEoTnuZqzV6mHlL36CIjV4+enN0ICkL+CwiW2clAgyq19Y
	 eFQFT7pIztdNaJFp3ZqeXYkTD/0dLzGE10hjO0Y3W2nnVNnl7A/XPzdU5S5nSzz0zp
	 vEm1HiSaRyfznqYM4gmSnE7d1Hb87os+x4IDduQPpeO5Kl0NoR0PETLiSHvUssrM9G
	 /eohCBa93RL+fg7h7Y2IFtP93MSfBi+Y1jTt4keZCzlG7BzgiL78HEEDmWJqeswLv+
	 Yba5sRWwwEc7j/BhxehR7Jf3WldwaATvQ8NrMf2ERamtn8BYP9aoFaOEIUTdHOgvBS
	 wxRiPVcYbnAlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/6] dmaengine: ioat: disable relaxed ordering before
 registering the device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260727174837.6645-5-logang@deltatee.com>
References: <20260727174837.6645-1-logang@deltatee.com>
 <20260727174837.6645-5-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:28:30 +0000
Message-Id: <20260727182830.D1B6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] IRQ handler Use-After-Free in probe error path due to mixing devre=
s IRQ registration with manual kfree.
- [High] Use-After-Free on `ioatdma_chan` due to missing kobject `.release`=
 function and unconditional kfree.
- [High] Legacy MSI/MSI-X vectors leak on error paths and interrupt fallbac=
k, causing device dysfunction and resource exhaustion.
--

--- Patch [4]: [PATCH v1 4/6] dmaengine: ioat: disable relaxed ordering bef=
ore registering the device ---
commit eb15a8e1f4e218e8537f96abc3be35c46bf67999
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: ioat: disable relaxed ordering before registering the device

This commit fixes a dangling device registration in the error path of
ioat3_dma_probe(). By moving the relaxed ordering disablement before
dma_async_device_register(), it ensures the device is safely registered
only when subsequent initialization steps cannot fail.

Link: https://lore.kernel.org/dmaengine/20260707165906.249F41F000E9@smtp.ke=
rnel.org/T/#u

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

[Severity: High]
This isn't a bug introduced by this patch, but doesn't this error path lead=
 to
a use-after-free?

If dma_async_device_register() fails here and we jump to
err_disable_interrupts, the probe fails and ioat_pci_probe() will manually
call kfree() on the device and channel structures before returning:

drivers/dma/ioat/init.c:ioat_pci_probe() {
    ...
    for (i =3D 0; i < IOAT_MAX_CHANS; i++)
        kfree(device->idx[i]);
    kfree(device);
    ...
}

However, because devm_request_irq() was used earlier to register the interr=
upt
handler, devres will only unregister the IRQ after the probe function fully
returns. If a shared interrupt fires in this window, ioat_dma_do_interrupt()
will dereference the freed instance pointer causing a use-after-free.

[Severity: High]
This is a pre-existing issue, but does the error handling properly clean up
MSI/MSI-X vectors?

If we jump to err_disable_interrupts and fail probe, or during normal unbin=
d,
the driver masks hardware interrupts but fails to call pci_disable_msi() or
pci_disable_msix(). For example in ioat_dma_remove():

drivers/dma/ioat/init.c:ioat_dma_remove() {
    ...
    ioat_disable_interrupts(ioat_dma);
    ...
}

This permanently leaks the allocated IRQ vectors. Also, if devm_request_irq=
()
fails during MSI-X setup, the driver jumps to the msi fallback label without
calling pci_disable_msix(). This breaks INTx generation since the device wi=
ll
not assert INTx while MSI-X is active.

> +	ioat_kobject_add(ioat_dma, &ioat_ktype);
> +

[Severity: High]
This is a pre-existing issue, but is it safe to embed kobjects here without=
 a
release function?

When ioat_kobject_add() adds the kobject with ioat_ktype:

drivers/dma/ioat/sysfs.c:ioat_ktype {
    const struct kobj_type ioat_ktype =3D {
        .sysfs_ops =3D &ioat_sysfs_ops,
        .default_groups =3D ioat_groups,
    };
}

It is missing the required .release function. When the driver is unbound,
release_ioatdma() unconditionally frees the channel structures:

drivers/dma/ioat/init.c:release_ioatdma() {
    ...
    for (i =3D 0; i < IOAT_MAX_CHANS; i++)
        kfree(d->idx[i]);
    ...
}

If unprivileged userspace holds a sysfs file open while the device is unbou=
nd,
the kobject refcount is still elevated. When userspace later closes the fil=
e,
kobject_put() will attempt to drop the final reference and access the alrea=
dy
freed memory.

> +	if (dca)
> +		ioat_dma->dca =3D ioat_dca_init(pdev, ioat_dma->reg_base);
> +
>  	if (ioat_dma->cap & IOAT_CAP_DPS)
>  		writeb(ioat_pending_level + 1,
>  		       ioat_dma->reg_base + IOAT_PREFETCH_LIMIT_OFFSET);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727174837.6645=
-1-logang@deltatee.com?part=3D4
