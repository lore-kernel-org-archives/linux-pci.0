Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6101A6808;
	Wed, 13 May 2026 22:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778710656; cv=none; b=rzmwQ+61TFEOzX2eFGIbyST0UhvFMWE6vp0eI//DQ56ipve6yavBIXK8X91An9DVR+JBUgIZeRufzKm/4/iTfEgMKE/llNLYPT0DPBwc6Nn8MH4Jd8La1cH7qfInSCazqooBREr1rCDlGjR7Z0wSCZIfzI3AiJM/5HH71m2lftw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778710656; c=relaxed/simple;
	bh=j2JAT8iJ0OX2hgxLa9bhcFJssnJ2VuqS9i5kRa9oxe8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CB6Vbu6Wt2zPghIgfHttAnb4w2QGIc3rOPoUkeDdDKj5e7K8MZodSsvIvYQaZ0RP4e0V5tRexA1CgrTDiY+fry6o64NBg31Pwl0aaEfjkUyIyr9rlgN9bb05ew8N642RrOiLpNX48fLs+n/V9qA9gkj3dkgqYaQzgLsWmL+fUeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJbdvDXC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJbdvDXC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D635C19425;
	Wed, 13 May 2026 22:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778710656;
	bh=j2JAT8iJ0OX2hgxLa9bhcFJssnJ2VuqS9i5kRa9oxe8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bJbdvDXCdBNM5qrWGGxd94hul9TDkBT4pPk+lFK3GrxfyzPP8yhFAQH3ARoBB/xaE
	 EwMi3T/KNsstlKnyskF9QIh360DYe81d2Sch95j7tEs9TFNgGNCoAUBOBXnJ1WV410
	 D/xjE33JHsJmGccM7E7bfW/nhsuxgullBkAxIItENQEbk3SRjkI/L+nCnS3XExYm4S
	 QlIrwWoUVmFEOJ+pPreVNolEDwxU7e9qgvslqgpwfEJqFF9c7OwxgzuIn+mErqCiqY
	 I+zm9hXAMlX+xE9hwol6uVcVkHaGeL1Sij8C1iFu9Nw14Wq+dymLpIK5iQupLsPBOs
	 iz4jgLi0wpz9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 22/23] dmaengine: sdxi: MSI/MSI-X vector allocation
 and mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260511-sdxi-base-v2-22-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-22-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 22:17:35 +0000
Message-Id: <20260513221736.2D635C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Hardware is stopped AFTER tearing down active software context=
s, leading to use-after-free and DMA corruption.
- [High] Missing pci_free_irq_vectors() in error paths and during unregistr=
ation.
- [High] sdxi_alloc_vector() incorrectly allocates vector 0, conflicting wi=
th the dedicated error log interrupt.
--

commit e45016c3a6e72f74d9db1a7a06247322707bec64
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: MSI/MSI-X vector allocation and mapping
   =20
During PCI probe, allocate a vector per context supported by the function
as reported by the capability register, plus one for the error log
interrupt. Introduce sdxi_alloc_vector() and sdxi_free_vector() which are
wrappers around the IDA tracking the allocated vector range. Also introduce
sdxi_vector_to_irq() to translate the device-relative index to the Linux
IRQ number.

> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index cc289b271ae22..79bd776394790 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c

[ ... ]

> @@ -347,5 +349,7 @@ void sdxi_unregister(struct device *dev)
>  		sdxi_cxt_exit(cxt);
>  	xa_destroy(&sdxi->client_cxts);
> =20
> +	ida_destroy(&sdxi->vectors);
> +
>  	sdxi_dev_stop(sdxi);
>  }

This isn't an issue introduced by this patch, but does this sequence lead t=
o a
use-after-free?

sdxi_unregister() iterates over client_cxts and calls sdxi_cxt_exit() for a=
ll
active contexts, which frees their descriptor rings and control structures.
Only afterwards does it call sdxi_dev_stop() to stop the hardware.

Because the hardware is still active, it may continue to write to the freed
DMA memory. Additionally, since the DMA engine unregistration happens later
via devres, active DMA channels will still hold pointers to the freed
contexts, leading to a double-free when devres triggers
sdxi_dma_free_chan_resources().

> diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
> index 0f72cd359cf5c..67e28b8d7f94d 100644
> --- a/drivers/dma/sdxi/pci.c
> +++ b/drivers/dma/sdxi/pci.c

[ ... ]

> @@ -49,12 +52,35 @@ static int sdxi_pci_init(struct sdxi_dev *sdxi)
>  		return dev_err_probe(dev, PTR_ERR(sdxi->dbs),
>  				     "failed to map doorbell region\n");
> =20
> +	/*
> +	 * Allocate the minimum required set of vectors plus one for
> +	 * each client context supported by the function.
> +	 */
> +	cap1_max_cxt =3D FIELD_GET(SDXI_MMIO_CAP1_MAX_CXT,
> +				 sdxi_read64(sdxi, SDXI_MMIO_CAP1));
> +	vecs =3D pci_alloc_irq_vectors(pdev, SDXI_MIN_VECTORS,
> +				     SDXI_MIN_VECTORS + cap1_max_cxt,
> +				     PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +	if (vecs < 0)
> +		return dev_err_probe(dev, vecs,
> +				     "failed to allocate MSIs (max_cxt=3D%u)\n",
> +				     cap1_max_cxt);
> +
> +	sdxi->nr_vectors =3D vecs;

Are the allocated IRQ vectors leaked on error paths and driver unbind?

Looking at sdxi_register() in drivers/dma/sdxi/device.c, if
sdxi_device_init() fails after sdxi->bus_ops->init() succeeds:

sdxi_register()
    err =3D sdxi->bus_ops->init(sdxi);
    if (err)
        return err;

    return sdxi_device_init(sdxi);

There does not seem to be a way to free the vectors since sdxi_bus_ops lacks
a deinit callback. Similarly, sdxi_unregister() cannot release the IRQ
vectors when the driver unbinds.

> diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
> index 1786da7642cc8..11773162c023d 100644
> --- a/drivers/dma/sdxi/sdxi.h
> +++ b/drivers/dma/sdxi/sdxi.h

[ ... ]

> @@ -59,12 +80,48 @@ struct sdxi_dev {
>  	struct dma_pool *cxt_ctl_pool;
>  	struct dma_pool *cst_blk_pool;
> =20
> +	unsigned int nr_vectors;
> +	struct ida vectors;
> +
>  	struct sdxi_cxt *admin_cxt;
>  	struct xarray client_cxts; /* context id -> (struct sdxi_cxt *) */
> =20
>  	const struct sdxi_bus_ops *bus_ops;
>  };
> =20
> +/**
> + * sdxi_alloc_vector() - Allocate an interrupt vector.
> + *
> + * A vector that will have the same lifetime as the device does not
> + * need to be released explicitly. Otherwise the vector must be
> + * released with sdxi_free_vector().
> + */
> +static inline int sdxi_alloc_vector(struct sdxi_dev *sdxi)
> +{
> +	return ida_alloc_max(&sdxi->vectors, sdxi->nr_vectors - 1,
> +			     GFP_KERNEL);
> +}

Will this code allocate vector 0 and conflict with the error log interrupt?

The commit message and SDXI_ERROR_VECTOR define vector 0 as reserved for the
error log interrupt. However, ida_alloc_max() starts searching for free IDs
at index 0.

Since vector 0 is never pre-allocated or explicitly reserved in the IDA
during initialization, the first caller to sdxi_alloc_vector() will be
mistakenly assigned vector 0, causing completion interrupts and error log
interrupts to conflict.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D22
