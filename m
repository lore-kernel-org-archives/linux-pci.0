Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88FA38D3F2;
	Wed,  2 Sep 2026 06:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330897; cv=none; b=HYrK3x1WrEZLFb8G4hxzdmCpipbxUXDYV/i6vi6n7l85C5bQxbKurtCACO/SiJGzkrCoAjFRSipBlz/g8Gi/G3D/6h/SZXJFrftok2bTuFTiR+PRBKSsWpQ68YS/0LmAWiI6CzZixgl8K6yIH0HizXd05YNUWzGR71mvdULIO+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330897; c=relaxed/simple;
	bh=sxv+t7QEdqRawlC9WROHZUJdNTqE8Y5dkfl+46wgun4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YyOwf9BkYsu8DNkxNYUS5fppxdoWC2Fkqkqnewu90Fsl3gABlSzUpYA9dbr9LnroxtelU4wG036N7IHEtWg7AoOJJv6/fhjD8AbIFaEHLXzMDMLAfqxIjZt5wUZ0nXbskWSSziLgZSZTrZ/ryPGaGFAkL8Wgi9uIB+5vppl99Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rr04QbEU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rr04QbEU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C11B1F000E9;
	Wed,  2 Sep 2026 06:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788330896;
	bh=PK3BU/9xRl8YL0nfkNQTFyIpwRw6fICW9Hk2F7X0BHM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rr04QbEU5+hFQ0q9LrNxlsQG+7Gp28w0WFD5ycIxf9I6ZtCtngYPLwbQsuf8cSCdt
	 brFpLp2HUcT3JOFDeUmUbS7Tt1ILAbA2oZ15UqRQ0q7qfuylml3bEZYYQuYr/UYmEP
	 S2h9mXTKrXXoE7zl4CqeQfWFt3weoDGzyCKOlVyHQj7+hrgsMWtKGUv6kFBOwl3RkY
	 rU8XZYKK20pSfdkRRNYXYmU/jmAcAyrh2n6m2KGtcs+1ViXlQLzsLCTDfrPUNNPRjm
	 QGFI7Vq2q4s2gVz9HNhVEYhAMx40lfxeenUypTzFvBAy2HaD1Qz6SZ2zy3o9cxMei7
	 TygPXZDvmpM3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/10] dmaengine: switchtec-dma: fix chan_status_irq
 cleanup on create() error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260902062153.31048-6-logang@deltatee.com>
References: <20260902062153.31048-1-logang@deltatee.com>
 <20260902062153.31048-6-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 06:34:55 +0000
Message-Id: <20260902063456.2C11B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing pci_free_irq_vectors() in the error paths of switchtec_dma=
_create() violates strict PCI subsystem guidelines.
- [High] Missing NULL check for the result of ioremap() leads to a potentia=
l NULL pointer dereference.
--

commit c928a877b10b083c93ce575c29fbbff0e54d5b5a
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix chan_status_irq cleanup on create() error

This commit replaces free_irq() with pci_free_irq() to correctly free MSI-X
vectors. It also changes the default initialization of chan_status_irq to -1
so that index 0 is not skipped during cleanup.

Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 17bbf85bcb169..430b09fa5102e 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1249,6 +1249,8 @@ static int switchtec_dma_create(struct pci_dev *pde=
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
This isn't a bug introduced by this patch, but does ioremap() need to be
checked for failure?

If ioremap() fails and returns NULL, swdma_dev->bar is assigned NULL. A bit
later in switchtec_dma_create(), swdma_dev->bar is dereferenced uncondition=
ally
when reading the IRQ vector:

    irq =3D readw(swdma_dev->bar + SWITCHTEC_REG_CHAN_STS_VEC);

Could this result in a NULL pointer dereference?

[ ... ]

> @@ -1323,8 +1325,8 @@ static int switchtec_dma_create(struct pci_dev *pde=
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

[Severity: High]
This is a pre-existing issue, but does this error path need to free the IRQ
vectors?

In switchtec_dma_create(), if an error occurs after pci_alloc_irq_vectors()
succeeds, control jumps to err_exit and the function returns without calling
pci_free_irq_vectors().

Does this leak IRQ resources on error paths?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902062153.3104=
8-1-logang@deltatee.com?part=3D5
