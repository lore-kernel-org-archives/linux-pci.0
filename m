Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C37643304E;
	Mon, 27 Jul 2026 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176913; cv=none; b=n6JNVm/TaqGTMWr3S/UTNNZk4cgcHYl4jWlZ9hoF6O5mc1jshWD52FYsdooqWRntMgH+5K9sYSHWWBDRgtlboX3y5u5BERRMoauMhpP+sfgb+9XIPgE7DsJZQHoB9oLfyRLvbLKqf9iTnsvuzBO1nYH/D1KJhXaFifbjw4NIKx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176913; c=relaxed/simple;
	bh=Hs3DY4upjGJvONj2Du4oOW7C3o1tmE8ZPcBwWlNSxNk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r1+fLb5wjY9/H35kuoRu4Iprv3Yp/3dFXxVaeY9+4OcJP/Uz2fbLZL5Z/xIJnPt3EHg+GUeMhCVAdXSjN/CxMVzT+N/ES0kvsuOKHXwRiW/zCz1CFfKRFKz0swICwms4WJBhe4YSRxvNjOOIS3IhOK9Bt8aAgJFVlKTrx8oGKbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRd4EzgD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRd4EzgD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D26F1F00A3A;
	Mon, 27 Jul 2026 18:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785176911;
	bh=uR57bGq99TS8tn0R1CgfhTWckKDDtMA5+e2b5iVmUZk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YRd4EzgDvl4XoYA6oxeC0nPHEg2ayf67gIWNcrkQsSoHkDWWDiHC3PzqV9QvBrR2Q
	 5Op5W6+AWdKAHYWRwn9odz6UcKr/6135eXc5KhXLB5DPeaGlTUqcWptDpFYuUTZ9ci
	 4e3za03ftUeWNhyEbZv5TwzbTWGIXQHyjLwLUMsJoJNPM7i4k+KkQ648dWP+SzVDbN
	 n9lspOij45VZMaIsdXLQcdQmZ+Jl5YqBstqgeZhW5ifB+NGB4x7I8kJT46P2tKolEl
	 PPnjbnX3TgVS1T+pCAzDeanjim+zgsskNUKutU3lhIEuyURbgMCrtYcCnwL52xi8Se
	 aSC/zLGrX6W9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/11] dmaengine: switchtec-dma: fix double-free in
 switchtec_dma_free_desc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260727181526.9672-2-logang@deltatee.com>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-2-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:28:31 +0000
Message-Id: <20260727182831.9D26F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of DMA channel resources on error paths in switchtec_d=
ma_alloc_chan_resources()
- [High] Memory leak of channel structures (swdma_chan) and pointer array o=
n driver probe error
- [High] Incorrect IRQ teardown using free_irq() with a raw MSI-X vector in=
dex instead of pci_free_irq()
--

--- Patch [1]: [PATCH v3 01/11] dmaengine: switchtec-dma: fix double-free i=
n switchtec_dma_free_desc() ---
commit e34f78c4f91061f06369e0d37a6d5d75685edb26
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix double-free in switchtec_dma_free_desc()

switchtec_dma_free_desc() frees swdma_chan->hw_sq, hw_cq, and every
desc_ring[] entry without clearing the pointers afterward. This patch
NULLs out each pointer as it's freed so a subsequent call is a no-op
for anything already released.

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 3ef9286406159..a4a7d66d042de 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -886,14 +886,18 @@ static void switchtec_dma_free_desc(struct switchte=
c_dma_chan *swdma_chan)
>  	if (swdma_chan->hw_sq)
>  		dma_free_coherent(swdma_dev->dma_dev.dev, size,
>  				  swdma_chan->hw_sq, swdma_chan->dma_addr_sq);
> +	swdma_chan->hw_sq =3D NULL;
> =20
>  	size =3D SWITCHTEC_DMA_CQ_SIZE * sizeof(*swdma_chan->hw_cq);
>  	if (swdma_chan->hw_cq)
>  		dma_free_coherent(swdma_dev->dma_dev.dev, size,
>  				  swdma_chan->hw_cq, swdma_chan->dma_addr_cq);
> +	swdma_chan->hw_cq =3D NULL;
> =20
> -	for (i =3D 0; i < SWITCHTEC_DMA_RING_SIZE; i++)
> +	for (i =3D 0; i < SWITCHTEC_DMA_RING_SIZE; i++) {
>  		kfree(swdma_chan->desc_ring[i]);
> +		swdma_chan->desc_ring[i] =3D NULL;
> +	}
>  }
> =20
>  static int switchtec_dma_alloc_desc(struct switchtec_dma_chan *swdma_cha=
n)

[Severity: High]
This isn't a bug introduced by this patch, but does
switchtec_dma_alloc_chan_resources() leak DMA channel resources on error
paths?

If switchtec_dma_alloc_desc() succeeds but a subsequent step like
enable_channel() fails, the driver returns the error code immediately:

switchtec_dma_alloc_chan_resources() {
	...
	rc =3D enable_channel(swdma_chan);
	if (rc)
		return rc;
	...
}

Does this fail to call switchtec_dma_free_desc() to free the resources
successfully allocated earlier in the function? Since the dmaengine core
does not automatically invoke the cleanup routine for partial failures,
could these resources be permanently leaked?

[Severity: High]
This is a pre-existing issue, but I noticed a potential memory leak of
channel structures on driver probe error.

If switchtec_dma_chans_enumerate() fails partway through, the error path
iterates over initialized channels and calls switchtec_dma_chan_free(),
but it doesn't seem to free the individual channel elements:

switchtec_dma_chans_enumerate() {
	...
err_exit:
	for (i =3D 0; i < chan_cnt; i++)
		switchtec_dma_chan_free(pdev, swdma_dev->swdma_chans[i]);

	kfree(swdma_dev->swdma_chans);
	...
}

Furthermore, if dma_async_device_register() fails in switchtec_dma_create(),
does the error path forget to free the channel pointer array or the
structures it points to?

switchtec_dma_create() {
	...
err_chans_release_exit:
	switchtec_dma_chans_release(pdev, swdma_dev);
	...
}

[Severity: High]
This is a pre-existing issue, but is the driver using free_irq() incorrectly
with a raw vector index instead of pci_free_irq() during teardown?

If switchtec_dma_create() encounters an error after successfully requesting
the channel status IRQ, it branches to err_exit and calls free_irq():

switchtec_dma_create() {
	...
err_exit:
	if (swdma_dev->chan_status_irq)
		free_irq(swdma_dev->chan_status_irq, swdma_dev);
	...
}

Is swdma_dev->chan_status_irq holding the raw hardware index rather than
the Linux IRQ number? Could this incorrectly free an unrelated system
interrupt and leak the originally requested IRQ?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727181526.9672=
-1-logang@deltatee.com?part=3D1
