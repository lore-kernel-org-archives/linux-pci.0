Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7434CCDCE;
	Mon, 31 Aug 2026 21:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211687; cv=none; b=k2JS51GVKQHg79xJ3MYTvR71+yPASh4RyhNzcPdDJCkKTZF/HfgiUCt7GoM3E4OMnYRIRQtN+zD9lKg/vKY2YWk2i9yUT/XrwpvIfeuuvl8R7pIQu1e9sgM4f2jE2dp+j10kSLCo74n/cwtJIUbjAABrH89SD2SJI2yOFAxDdzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211687; c=relaxed/simple;
	bh=Nw6XTmxC8xAvWpS/9X/vHFFYc0uFZdlzfT3+ufHsN2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fyI/QJPWnjJ69YP8MpmDwVTKvVpEY0ri/n3FMi5olDkS2w1gW10fwPgcNp9KUO6AjMiqpjl6fbNFiWNO6SdJPKSlY3jBJ+EHR83Iv5+ung8EN7F5sgL4aIFaOwz3AXHSsoJ1u1ZuHtfT/zVG85WOz8HcW0oWtF0znJhylCvaGaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSJD1vVP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSJD1vVP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07EB1F000E9;
	Mon, 31 Aug 2026 21:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211685;
	bh=5HDEIQ3W7sMc1LOSALNk2fbz2x9ECVrHLVy423m6kJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aSJD1vVPuuNbDzCaRJ6uTRRppOTkpkEFNwx9stD5UjE/XrN1krme1UnNg7iGL3SaI
	 ZSWktkqJB38MYG3GG/8AbXu3Dmg+YnCi2rzyHDf8zBMmNzeqGmLiaLiLh5zNITfhvm
	 7+zKwj5NBR/rmvsf8ruTG8Aj6PZgRjIv/VdVJo3u6p5eogE+T650F899EncvoRhtfL
	 ORZRc76tj3AEnOIIHWUbKm2iVpD/P2PWZDwxbq2HX6YC38IBVYXiUszvcaZf3CkwoJ
	 HU4B2+Vxf10h43rXNxY+/k358Hy7aR+w26cSezxIZp1xt9auVlPWaVIU8pq73XyS+7
	 pHxNfD6efLD5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/12] dmaengine: switchtec-dma: fix double-free in
 switchtec_dma_free_desc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260831191403.207631-2-logang@deltatee.com>
References: <20260831191403.207631-1-logang@deltatee.com>
 <20260831191403.207631-2-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:28:04 +0000
Message-Id: <20260831212804.F07EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] switchtec_dma_prep_desc() acquires and returns with a spinlock hel=
d, violating the dmaengine API and causing inevitable deadlocks.
--

commit 35f30174e5a3e6b3e6f62a9f94873f8da95cfc36
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix double-free in switchtec_dma_free_desc()

This commit prevents a double-free in switchtec_dma_free_desc() by setting
hw_sq, hw_cq, and desc_ring entries to NULL after freeing them. This fixes
an issue during channel resource allocation failures where unwind paths
could attempt to free already-released pointers.

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index c133535d37656..a10818efba4e5 100644
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
[ ... ]

While reviewing this file, I noticed a separate issue in
switchtec_dma_prep_desc():

drivers/dma/switchtec_dma.c:switchtec_dma_prep_desc() {
	spin_lock_bh(&swdma_chan->submit_lock);

	if (!swdma_chan->ring_active)
		goto err_unlock;
	...
	/* return with the lock held, it will be released in tx_submit */

	return &desc->txd;
}

[Severity: High]
This isn't a bug introduced by this patch, but does returning with the
submit_lock held violate the dmaengine API contract and cause deadlocks?

The dmaengine API allows clients to batch multiple descriptor preparations
before submitting them. If a client calls the prep function consecutively,
would the second call attempt to re-acquire the same non-recursive spinlock
and deadlock the CPU?

Additionally, the dmaengine API allows aborting and dropping descriptors
on error before submission. If a prepared descriptor is discarded on a
client error path, would the lock remain permanently held?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831191403.2076=
31-1-logang@deltatee.com?part=3D1
