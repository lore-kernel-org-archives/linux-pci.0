Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943683C2774;
	Tue, 28 Jul 2026 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260650; cv=none; b=C2cBTV3m67xjT5+KUJwQsh3lH+kY8vpDpuO4yK8ZgjoO83VOiBxdy3VRhT1vDSb/MsfsDo0TyCZ9Z/7ctoDdEF9VQLEizXCUwZgQUPSy1l8qkgY5UM1RB41uxOyCZDyzGYd4x111g75L7Fu93t0BFkjwJtsxUkI2q4mVHo45LeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260650; c=relaxed/simple;
	bh=/+UStUj6uDGhpn175Oqws/dbt4DHMwDsidUohRu95iQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D9lTsJuBgirsiB9+2DAcliyu7VC2Pk9G7GPtlA+S1eDDaoPMRbYgT5KPXDwXHwanhy8DiK2jWbSmhh9ZDzG64AzREmfQHyYvm/f8shGTmrBunbHcJb23Injz0nkI66C8YNOUpj374l0gFCCoK86lTseLgFLzDV2iD9C/lnAGux0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0gH9f3I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0gH9f3I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5F71F00AC4;
	Tue, 28 Jul 2026 17:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260649;
	bh=RQIwIV2hCnCXDCD/lQyxUn66+N9xgUECkSxQV8nIhUs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J0gH9f3IZtw+anAn1rIFt/5UksdlFq3nBZnYPSkqotguIASVuX91PZeJY5Ku9uPRX
	 E6gMZAiVnHCLH2Il8K4Km456Yh/bj2lkzoMXCD3jTP2GKJknThvcoJYMlcY6xrYkzk
	 7M/CSpsQHYTukFcFiLYuquAavuUEetfxi7BSJn0TcFaNpvn2YoTgT6OAiM6hIlX5Cb
	 8dR4ZrDUGdy/6pwsnEdvRj0U/iewFSlRM3Dziwanjt8bf38fgESSIVaD1JVwcioyrE
	 pLaB/cv4oVILaLp2rNvFjBm4Un1wMLIlD4MtxTqCbtzOcgWqPJxH6fDMFjQhRibTq/
	 PiCPdWXlE0kKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/12] dmaengine: switchtec-dma: make
 switchtec_dma_chans_release() void
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260728171523.112244-7-logang@deltatee.com>
References: <20260728171523.112244-1-logang@deltatee.com>
 <20260728171523.112244-7-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:44:08 +0000
Message-Id: <20260728174409.4C5F71F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Leaking DMA descriptors and ring buffers when channel stop fails (=
e.g., during device hot-unplug or module unload).

Pre-existing issues:
- [High] Hardware resources (IRQs and tasklets) are released before the DMA=
 device is unregistered, allowing clients to request or use unbacked channe=
ls.
--

--- Patch [6]: [PATCH v4 06/12] dmaengine: switchtec-dma: make switchtec_dm=
a_chans_release() void ---
commit 4ae99d5104edb85994c22547e64122fc62df38cb
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: make switchtec_dma_chans_release() void

switchtec_dma_chans_release() always returned 0, and no caller
checked it.

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 48da269198f3f..63e60de9f86dc 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1177,15 +1177,13 @@ static int switchtec_dma_chan_free(struct pci_dev=
 *pdev,
>  	return 0;
>  }
> =20
> -static int switchtec_dma_chans_release(struct pci_dev *pdev,
> -				       struct switchtec_dma_dev *swdma_dev)
> +static void switchtec_dma_chans_release(struct pci_dev *pdev,
> +					struct switchtec_dma_dev *swdma_dev)
>  {
>  	int i;
> =20
>  	for (i =3D 0; i < swdma_dev->chan_cnt; i++)
>  		switchtec_dma_chan_free(pdev, swdma_dev->swdma_chans[i]);
> -
> -	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but hardware resources (IRQs and tasklets) are
released before the DMA device is unregistered, allowing clients to request=
 or
use unbacked channels.

In switchtec_dma_remove(), switchtec_dma_chans_release() is called first, w=
hich
frees all per-channel IRQs and kills their descriptor tasklets:

drivers/dma/switchtec_dma.c:switchtec_dma_remove() {
	...
	switchtec_dma_chans_release(pdev, swdma_dev);
	rcu_assign_pointer(swdma_dev->pdev, NULL);
	synchronize_rcu();
	pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);
	pci_free_irq_vectors(pdev);
	dma_async_device_unregister(&swdma_dev->dma_dev);
}

Could this cause active DMA transfers to hang forever without completion, s=
ince
the DMA device is not unregistered from the core until much later?

Because the device is still in the DMA engine channel table, could a client
theoretically request a new channel in this window?

[Severity: High]
Does this code leak DMA descriptors and ring buffers when channel stop fail=
s?

In switchtec_dma_free_chan_resources(), if switchtec_dma_chan_stop() return=
s a
non-zero error (like -ENODEV during hot-unplug), the cleanup of descriptor
memory is completely skipped:

drivers/dma/switchtec_dma.c:switchtec_dma_free_chan_resources() {
	...
	rc =3D switchtec_dma_chan_stop(swdma_chan);
	switchtec_dma_abort_desc(swdma_chan, 0);
	if (!rc)
		switchtec_dma_free_desc(swdma_chan);
}

During switchtec_dma_remove(), swdma_dev->pdev is set to NULL before
dma_async_device_unregister() is called. When dma_async_device_unregister()
subsequently cleans up active channels, it invokes
switchtec_dma_free_chan_resources().

Because pdev is NULL, switchtec_dma_chan_stop() returns -ENODEV. The code c=
hecks
if (!rc) and skips switchtec_dma_free_desc(), leaking the resources.

A similar issue appears to exist in the error path of
switchtec_dma_alloc_chan_resources() if the channel stop returns an error:

drivers/dma/switchtec_dma.c:switchtec_dma_alloc_chan_resources() {
	...
err_disable_channel:
	if (switchtec_dma_chan_stop(swdma_chan)) {
		disable_channel(swdma_chan);
		return rc;
	}
	disable_channel(swdma_chan);
err_free_desc:
	switchtec_dma_free_desc(swdma_chan);
}

Can this leak memory for every active channel on standard device teardown or
hot-unplug?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728171523.1122=
44-1-logang@deltatee.com?part=3D6
