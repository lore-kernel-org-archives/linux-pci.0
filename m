Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD1F3B9DA6;
	Tue, 28 Jul 2026 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260365; cv=none; b=G6Xi8yJsAwS8YPc2IZ+qmOYOqtPCLy4KVWyzon2enscw55p79aJxYrk/GY4GmwvlBIo/GWAqaPORvb5Wcp5X03PRk1g0iJ5e4sRUtW9MypCbE4qO1jbulFAR/51To9nSjOYppBnmKRA2U3KT432uaLDaJzUsgBx3lA3TT8RdtRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260365; c=relaxed/simple;
	bh=7jTqSmO5ZDk52jXu+RXb/ZcATgnjv7+miKKpkwyHqNs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tXJ7b+ckwx0W9khozE/9XljM/38Vhyt+SZL/N2BUWAwWKpLS2YS9+3nf33NaT7VNQMgOu/p3tyZ/X+W637+wER2xCBf61dkI8nJMA3V7odE1V/8i/vSWl7UIJXPmGubreHhdItVPkMCe/iie7IPxkbqOLzYksqiMwCcyQudWIqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lf/QXGSO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lf/QXGSO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048661F000E9;
	Tue, 28 Jul 2026 17:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260364;
	bh=HSja5rspdw9ABo23dl0N+PWkJpZjcSd89C5qw9nIxUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lf/QXGSOcTKVeUbcV7GGYzeo6WH5x3sQF2iUXt4ymj3m+/GGRj9NpxTZk4iQBD7N6
	 LXrRZhO7BZSvQCHrItx/wxVasOOdn2xYie1AinX2bjuyISvu18QHsEsBUK8z0Kwdb5
	 RvRcYk/qr0lNKM1LM1xnfQF39b4FrI3h/nL00ffHvuhxtt14uJ7oBO7QhmnV/sd2eC
	 9U5PjSayWM8UOYwXy2ppN2xgjwT7m3ug3np6fArLgE/+lsd46n0W2SJFsxrkjfjiJ3
	 gbCfhGTPfknYKsT++bDLaHJKuaATpQKDE3AVYsjlFoDT2Yaq2L6BOR77kYVzkS+doD
	 lVpLdjqpvS0zQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/12] dmaengine: switchtec-dma: disable channels
 before freeing on registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260728171523.112244-9-logang@deltatee.com>
References: <20260728171523.112244-1-logang@deltatee.com>
 <20260728171523.112244-9-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:39:23 +0000
Message-Id: <20260728173924.048661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The global channel status IRQ is requested too early in `switchtec=
_dma_create()`, exposing a NULL pointer dereference and race condition in t=
he ISR.
- [High] Use-after-free of `swdma_dev` in `switchtec_dma_remove()` due to s=
ynchronous free in the release callback.
- [High] Missing NULL check after `ioremap()` leads to a potential NULL poi=
nter dereference.
- [High] Missing `put_device()` in the error path of `switchtec_dma_create(=
)` causes a reference count leak of the PCI device.
--

--- Patch [8]: [PATCH v4 08/12] dmaengine: switchtec-dma: disable channels =
before freeing on registration failure ---
commit a7ad01b09e2b3565af60150b4c01bec6d5cae7ad
Author: Logan Gunthorpe <logang@deltatee.com>

    dmaengine: switchtec-dma: disable channels before freeing on registrati=
on failure
   =20
    When switchtec_dma_create() fails after channels have been added to
    dma_dev->channels (either from switchtec_dma_chans_enumerate()'s own
    error path, or from dma_async_device_register() failing), the channel
    status IRQ is still live while the channels are released and freed,
    so it can fire mid-teardown against channels that are only partially
    torn down.

    Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smt=
p.kernel.org
    Link: https://lore.kernel.org/dmaengine/20260721162822.05CDD1F000E9@smt=
p.kernel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 6ab2c62b52fd8..ecf3a44d4dcc4 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1198,6 +1198,15 @@ static void switchtec_dma_chans_free(struct switch=
tec_dma_dev *swdma_dev)
>  	kfree(swdma_dev->swdma_chans);
>  }
> =20
> +static void switchtec_dma_chans_disable(struct pci_dev *pdev,
> +					struct switchtec_dma_dev *swdma_dev)
> +{
> +	if (swdma_dev->chan_status_irq >=3D 0) {
> +		pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);
> +		swdma_dev->chan_status_irq =3D -1;
> +	}
> +}
> +

[Severity: High]
This isn't a bug introduced by this patch, but since we're fixing IRQ
teardown here, is it possible the IRQ is requested too early during setup?

Looking at switchtec_dma_create(), the IRQ is requested before the channel
list is initialized:

switchtec_dma_create()
    rc =3D pci_request_irq(pdev, irq, NULL, switchtec_dma_chan_status_isr, =
...);

If an interrupt fires immediately (e.g., from hardware state left by a
previous boot, or a spurious interrupt), the ISR will execute and iterate
over uninitialized memory:

switchtec_dma_chan_status_isr()
    list_for_each_entry(chan, &dma_dev->channels, device_node)

Could this cause a NULL pointer dereference in the ISR?

[ ... ]

> @@ -1334,6 +1344,7 @@ static int switchtec_dma_create(struct pci_dev *pde=
v)
>  	return 0;
> =20
>  err_chans_release_exit:
> +	switchtec_dma_chans_disable(pdev, swdma_dev);
>  	switchtec_dma_chans_release(pdev, swdma_dev);
>  	switchtec_dma_chans_free(swdma_dev);
> =20

[Severity: High]
This is a pre-existing issue, but does this error path leak the PCI device
reference?

Earlier in switchtec_dma_create(), a reference is taken:

switchtec_dma_create()
    dma->dev =3D get_device(&pdev->dev);

When jumping to err_chans_release_exit or err_exit, the code does not seem
to call put_device() to clean up this reference.


[Severity: High]
This is another pre-existing issue, but looking at the earlier portion of
switchtec_dma_create(), could a missing NULL check lead to a crash?

switchtec_dma_create()
    swdma_dev->bar =3D ioremap(pci_resource_start(pdev, 0),
                             pci_resource_len(pdev, 0));

    RCU_INIT_POINTER(swdma_dev->pdev, pdev);

If ioremap() fails and returns NULL, subsequent MMIO accesses using
swdma_dev->bar will unconditionally dereference it. Should there be a
validation check here?


[Severity: High]
This is also a pre-existing issue, but does switchtec_dma_remove() have a
use-after-free risk during device teardown?

Looking at switchtec_dma_remove():

switchtec_dma_remove()
    dma_async_device_unregister(&swdma_dev->dma_dev);
    iounmap(swdma_dev->bar);

If dma_async_device_unregister() drops the last reference, it will
synchronously call switchtec_dma_release(), which frees swdma_dev:

switchtec_dma_release()
    kfree(swdma_dev);

Is it safe to pass swdma_dev->bar to iounmap() after the unregister call has
potentially freed swdma_dev?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728171523.1122=
44-1-logang@deltatee.com?part=3D8
