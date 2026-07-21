Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F373E49FB;
	Tue, 21 Jul 2026 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651076; cv=none; b=JIyEJ3COPd2DNoo+YubXzcxOxr0oOyR2467YSu35EUZ34xbQ0eaTVinDa5bFGGFwxc2g4Hl9hQd7H0sMlAwthvsv6u0B2JPQ4CMAgeGYESsym/M5gOp4zy3pE6LJpMLl4ZkGvMseNTt4EIvh80JPjPI3sNxoV0rnJPG1xEVZ7J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651076; c=relaxed/simple;
	bh=dDwWFhC+tuu4+IvCWR8U30wpiIjBVURdmCzbh7FyhvM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U5UBwjj4RT/SFyB2aLFXXN35vr5xNwEzc2aDor80QoL77mwWRF6A+GXlYUpOZ4mAzwwBiqrXpG/PgLAolhZRcytkpOqe/PvUHdEbydpRZA3mgTe/zPtooJySOuutxYYRrbmtKKcmovVZaC3x/8koVdPwRA6XSKuh1VJEvGzhLfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIEDyUan; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIEDyUan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390941F00A3A;
	Tue, 21 Jul 2026 16:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784651074;
	bh=HEEuGVSMvoEAHjKPgkMA6ncQro32RtQ+quUxFpLI9aw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CIEDyUanfO43WZHlVFddlp17z57tixIJx6LzbTZwOjh3LgHVYKHc1MCmeDwCNpAf8
	 6De3htNuLExGr7CmkMSZnwxC0aLpQVWLSd/TLVILorwY1/nUdelA7VLyT+vggsQoO+
	 VhqeG/5Qq8DOwXCoQiNeeHCmB5OuxMyLx0UoNv5qhxcjI4IBr2/FFDtPhjDm+Q76Q5
	 y1smFXC5vGqZLaqp/CyhB5kYcWvy1fj2EjycejgumfV4oCYqidK2o6wiMd6V4ThK7b
	 wtIqCgV2eY3LeYM3jilSEx/Au8sy62Kp1lUKvSXgysg059b/gVASUo2zIaWduneE61
	 GQ6kopRlmdQtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/11] dmaengine: switchtec-dma: make
 switchtec_dma_chans_release() void
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260721155739.62120-6-logang@deltatee.com>
References: <20260721155739.62120-1-logang@deltatee.com>
 <20260721155739.62120-6-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 16:24:33 +0000
Message-Id: <20260721162434.390941F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The return value of `ioremap()` is not checked for NULL in `switch=
tec_dma_create`.
--

--- Patch [5]: [PATCH v2 05/11] dmaengine: switchtec-dma: make switchtec_dm=
a_chans_release() void ---
commit f0ba8482174958251130470e113a8f5fc0e207f1
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: make switchtec_dma_chans_release() void

It always returned 0, and no caller checked it.

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 13efd4189bbb4..c752a1b05871d 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1165,15 +1165,13 @@ static int switchtec_dma_chan_free(struct pci_dev=
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
> =20
>  static void switchtec_dma_chans_free(struct switchtec_dma_dev *swdma_dev)

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing I noticed a
pre-existing issue in switchtec_dma_create():

drivers/dma/switchtec_dma.c:switchtec_dma_create() {
        ...
        swdma_dev->bar =3D ioremap(pci_resource_start(pdev, 0),
                                 pci_resource_len(pdev, 0));

        RCU_INIT_POINTER(swdma_dev->pdev, pdev);

        nr_vecs =3D pci_msix_vec_count(pdev);
        rc =3D pci_alloc_irq_vectors(pdev, nr_vecs, nr_vecs, PCI_IRQ_MSIX);
        if (rc < 0)
                goto err_exit;

        irq =3D readw(swdma_dev->bar + SWITCHTEC_REG_CHAN_STS_VEC);
        ...
}

Does this code check if ioremap() returns NULL?

If ioremap() fails due to memory pressure or physical address space
exhaustion, swdma_dev->bar will be NULL.

The readw() call will then dereference this NULL pointer, which causes
a kernel oops on the device probe path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721155739.6212=
0-1-logang@deltatee.com?part=3D5
