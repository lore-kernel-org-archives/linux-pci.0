Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03B03C2794;
	Mon, 27 Jul 2026 19:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785179722; cv=none; b=YTXH/ELuGQe9+1iaWvQS6lU0xccah1AgpegRO4CGj0nKtrz9JyjYtZVK1D2X+ZSadXpRC43/9qtJ8UTMOD0b9aBOqRvA6VsPZ2CBpGg3yAjxvDN+92RyLknXj/OiyLw2juVgXCArpiD+8A92f8yMSSR5vKCK5BF+N1VDoDgpf0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785179722; c=relaxed/simple;
	bh=AxVdyCa9pmsilS3LMvvpgrQFBqdUTouTtQLGhhvwjak=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cnaS8tIFvMQWYNfWZsmvhNgC87pFf8YT27efxRqtLNMFsysyfMRmJ9m7Sy0kpKncHUBTgr+qgJS+3yWTMJMBi9JyLdSmo7hhYIsdvdPmU8VTkVIRDViDvvHYYmUC9TXQJIPrATXeAcH4wXVWFAILqRhdUXu9uz7w4x9XfSZAhag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/+iRVDT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/+iRVDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792801F000E9;
	Mon, 27 Jul 2026 19:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785179720;
	bh=XMcXvGB8wNJBeKxFQbbS79yfgRzWS1iQKc6NZBV3ELM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m/+iRVDTlYBOBbi46GW5c2AldMhIl1r4j2FHfOnfZaFOrzzyy4dgaA+zmyNBmED8M
	 qciYM6mHaLZFjJboAB+q6XDJGsBFc6/RtF59B2anbyE5CnSejj01B+Y19SWQV0tsCI
	 ULU+mxF+i9o8HrqrwDXKSqrZFHigyMnJROsvXjNjNCOHOT05wx9I13o6ruLesKExRh
	 p+uqoKciDa5z+ewJ1sbQfT7E09KEmwJw68fvyFLj0pMnP/ErvdiEkgwKPUuUGoJTlj
	 T8jfQ1i1a5OFRqNhCDNa79pPKcYIpfY6bPnlOwKOYyVDx4BbEKTfEXgQHHvYY+wwOp
	 nGZx2J2Y8iWpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/11] dmaengine: switchtec-dma: make
 switchtec_dma_chans_release() void
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260727181526.9672-6-logang@deltatee.com>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-6-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:15:19 +0000
Message-Id: <20260727191520.792801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a missi=
ng NULL check for ioremap() in switchtec_dma_create().
--

--- Patch [5]: [PATCH v3 05/11] dmaengine: switchtec-dma: make switchtec_dm=
a_chans_release() void ---
commit a207649bc05f965ee7cc3627c9764631e52253cb
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: make switchtec_dma_chans_release() void

This commit updates the return type of switchtec_dma_chans_release() to voi=
d,
as the function always returned 0 and its return value was never checked by
callers.

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 13efd4189bbb4..c752a1b05871d 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1165,15 +1165,13 @@ static int switchtec_dma_chan_free(struct pci_dev=
 *pdev,

[ ... ]

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
This is a pre-existing issue, but while reviewing this file I noticed a
missing NULL check for ioremap() in switchtec_dma_create():

	swdma_dev->bar =3D ioremap(pci_resource_start(pdev, 0),
				 pci_resource_len(pdev, 0));

	RCU_INIT_POINTER(swdma_dev->pdev, pdev);

	nr_vecs =3D pci_msix_vec_count(pdev);
	rc =3D pci_alloc_irq_vectors(pdev, nr_vecs, nr_vecs, PCI_IRQ_MSIX);
	if (rc < 0)
		goto err_exit;

	irq =3D readw(swdma_dev->bar + SWITCHTEC_REG_CHAN_STS_VEC);

If ioremap() fails during device probe and returns NULL, does this cause a
kernel panic when swdma_dev->bar is dereferenced by readw()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727181526.9672=
-1-logang@deltatee.com?part=3D5
