Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E872DF3DA;
	Tue, 30 Jun 2026 23:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860491; cv=none; b=MR1D4wfWHy3H2ex8MteRTxauieFHO62KXeST1IrjkvXVAtFvikY1rnTDGFz8uPQYTpLVXcVj7uUu3MBIRJfwsQMqE+J7Be5/D/U9ngs36eJoVcn0yO/LPHRgAIHsradvsB7CwSEZwRlxGC7MWTfqV5MrE1ZlEBw7uaw/t8QGKp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860491; c=relaxed/simple;
	bh=lbwayHLyKaxoCSC4ZlDiAfGvoLf72jfrhPKZjEugBVA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cIiLQMOCY5zx+1jNv+yFHjrrZ9MrbqGAKXGvSmiTFVFYqkYhqFii0Hl595RrDO8/kbOeuNyx3Q2xgxNko9XREdquIxZeOKAlfZhixkyPHc9mkl3YNyOWKT9gUCngahS1FisSJ5fr6auSjddwQCFrYkypZRKUBVBju/TgiGr2CRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFrRqqP9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFrRqqP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63ED71F000E9;
	Tue, 30 Jun 2026 23:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782860489;
	bh=h7/rUadFnk6bFerkVUrWSluDDuNjcx7d02Lw705w0BQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SFrRqqP9DAe4/CZpJ8SEJlXWCF3d8XQfIeXYVsmKvUtdczAZUN53X3QFdhD1LvWKJ
	 GhxUETZfq/F9dQT9aNor9xj78dTC3r9jFJtLXOt85u2NwwLxyR9qjbXnnU5CVexldT
	 10kMfYWxq5IjV1dxE/HNlsxTW9eoh5pwFm7L9WyS7/05EQhU7Zf1J3LGbfDPldhF1u
	 5cPkeYA0NSW+pvwODWwoULhupeWGrML19s+2P5gEYMpRz/yNVBLF/gssGt+b3SrNCi
	 N2qnu+4pczk6DSOu0ZwqFIv7m0b7DJmLIisBzWh6M6eAFs2DC+s1kCQHgPbAJBKBWs
	 0OHRD3UXBJBVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/4] dma-buf: add optional get_pci_tph() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org
In-Reply-To: <20260630224328.3218796-3-zhipingz@meta.com>
References: <20260630224328.3218796-1-zhipingz@meta.com>
 <20260630224328.3218796-3-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 23:01:28 +0000
Message-Id: <20260630230129.63ED71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added dma-buf API `dma_buf_get_pci_tph()` and its corresp=
onding `get_pci_tph` callback are missing from the centralized dma-buf lock=
ing convention documentation.
--

commit aa25de1b77cd2b1778e96e6bffe1b1b6ce39fd9c
Author: Zhiping Zhang <zhipingz@meta.com>

dma-buf: add optional get_pci_tph() callback

This commit adds an optional get_pci_tph callback to dma_buf_ops and a
corresponding wrapper function dma_buf_get_pci_tph() for importers. These
allow importers to retrieve PCIe TLP Processing Hint (TPH) metadata for
peer-to-peer DMA. Both the callback and the wrapper require the dma-buf
reservation lock to be held.

> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index d504c636dc294..7a4c9b0d5dab4 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
[ ... ]
> @@ -1144,6 +1144,31 @@ void dma_buf_unpin(struct dma_buf_attachment *atta=
ch)
>  }
>  EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
> =20
> +/**
> + * dma_buf_get_pci_tph - Retrieve PCIe TLP Processing Hint (TPH) metadata
> + * @dmabuf: DMA buffer to query
> + * @extended: false for 8-bit ST, true for 16-bit Extended ST
> + * @steering_tag: returns the raw steering tag for the requested namespa=
ce
> + * @ph: returns the TPH processing hint
> + *
> + * Wrapper for the optional &dma_buf_ops.get_pci_tph callback.
> + *
> + * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
> + * exporter does not implement the callback or has no metadata for the
> + * requested namespace.
> + */
> +int dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
> +			u16 *steering_tag, u8 *ph)
> +{
> +	dma_resv_assert_held(dmabuf->resv);

[Severity: Low]
This isn't a bug, but should dma_buf_get_pci_tph() be added to the list of
functions in the "DOC: locking convention" block earlier in this file?

The centralized documentation block serves as a single source of truth for
importers by listing all functions that require the dma-buf reservation loc=
k,
such as dma_buf_pin() and dma_buf_vmap(). Adding this new function to that
list would help keep the locking documentation complete.

> +
> +	if (!dmabuf->ops->get_pci_tph)
> +		return -EOPNOTSUPP;
> +
> +	return dmabuf->ops->get_pci_tph(dmabuf, extended, steering_tag, ph);
> +}
> +EXPORT_SYMBOL_NS_GPL(dma_buf_get_pci_tph, "DMA_BUF");

[ ... ]

> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index d1203da56fc5f..53b2686ad8fc6 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
[ ... ]
> @@ -113,6 +113,26 @@ struct dma_buf_ops {
>  	 */
>  	void (*unpin)(struct dma_buf_attachment *attach);
> =20
> +	/**
> +	 * @get_pci_tph:
> +	 *
> +	 * Retrieve PCIe TLP Processing Hint (TPH) steering metadata for
> +	 * this buffer so an importer can program a matching ST/PH hint on
> +	 * outbound TLPs targeting the exporter for peer-to-peer DMA.
> +	 *
> +	 * @dmabuf: DMA buffer for which to retrieve TPH metadata
> +	 * @extended: false for 8-bit ST, true for 16-bit Extended ST
> +	 * @steering_tag: Returns the raw TPH steering tag for the requested
> +	 *                namespace
> +	 * @ph: Returns the TPH processing hint (2-bit value)
> +	 *
> +	 * Optional callback for dma_buf_get_pci_tph(). Called with
> +	 * &dma_buf.resv held. Returns 0 on success or -EOPNOTSUPP when
> +	 * the exporter has no metadata for the requested namespace.
> +	 */
> +	int (*get_pci_tph)(struct dma_buf *dmabuf, bool extended,
> +			   u16 *steering_tag, u8 *ph);

[Severity: Low]
Similarly, should &dma_buf_ops.get_pci_tph() be appended to the list of
callbacks in the same "DOC: locking convention" block?

The existing documentation explicitly calls out exporter callbacks that are
invoked with the locked dma-buf reservation, so updating it here would keep
the locking contract documentation consistent.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630224328.3218=
796-1-zhipingz@meta.com?part=3D2
