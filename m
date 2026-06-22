Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D68C3438BA;
	Mon, 22 Jun 2026 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154800; cv=none; b=e21pC8armNgM9XPzvzEUadfTFnrAEtXE/fGxGY0bjnwus+n2mrEYDFm9gaVOMYKL9FmnSmnCpzCTt1iTW/XcXw6Ju4pyg8PgVnQCkewbRl2ogBO8nol0rC9BcT5TJny+WU2evbrVlRP1RZEJtkdg4UXFaYPlMTt8AgthKx7wv70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154800; c=relaxed/simple;
	bh=nO/YVZU9l9GuhZ+V6ZcVnQbiMEZxLinyVhOSzR2/YM8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AAVjO5V8E2yHbT//AsaWjud7SDc0t65QKvrNCE5qD8ltxC3YpaiMkNnc7vtxRtomfX3b0GmjA3Ec2chMWkKC5kSYMjeiltDULTdjaXRQm7C2gKUhFGvUwq4eXBhm/2Q3mgZpDq9AL6vly/ujHzPRb2eTekl4yPaA6jc225DK0+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyrNnRh5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyrNnRh5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB711F000E9;
	Mon, 22 Jun 2026 18:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782154799;
	bh=v5QBm6qa+OqHLLGjLCx8x8n2JJYamc2t3YH+owipFrk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hyrNnRh5RKp+NgtQl9D4RhF/tXtwC62hEfYjjmcP4XpXIek8WkYqWvo0Wn3OeDEon
	 K0ZwVg9i75ZQRaMLiOOUHWrn3IuoSN4YtZZ0esUIgD5Vn2OBq9HP51mVvlXI/6iMCE
	 QfRhd95mFRFVJHZISRmPj0nwmLOMwRC+1ijAvqMpxfsjOQDKQXqLSW2b9SHAON6aMv
	 CWCcxHN8uFGcp+ElWpZ7sjC9/aElTVFsgss8MVFNuOftsuywR6J0hMBa5lULhqxpKw
	 1RZm97SZr7FpAc2zDH7rySxo4DJMDJ2rq/g7MEdSV83Vn41+Zbmx8ReS0YwcdKWPWH
	 rSjnHeC/VwIEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/4] dma-buf: add optional get_pci_tph() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260622184211.2229399-3-zhipingz@meta.com>
References: <20260622184211.2229399-1-zhipingz@meta.com>
 <20260622184211.2229399-3-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 18:59:58 +0000
Message-Id: <20260622185958.7EB711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The centralized DMA-BUF locking conventions documentation was not u=
pdated for the new `get_pci_tph` API.
--

commit 558f8ccf1c7e2c892ffa9049e917832eaa82ea77
Author: Zhiping Zhang <zhipingz@meta.com>

dma-buf: add optional get_pci_tph() callback

This commit introduces an optional get_pci_tph callback in dma_buf_ops and a
wrapper function dma_buf_get_pci_tph() to retrieve PCIe TLP Processing Hint=
s.
This allows importers to request TPH namespaces that exporters can emit.
The wrapper function requires the DMA-buf reservation lock to be held.

> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index d504c636dc294..7a4c9b0d5dab4 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
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
Since this wrapper and the new get_pci_tph() callback require the dma-buf
reservation lock to be held, should they be added to the centralized
"DOC: locking convention" list in drivers/dma-buf/dma-buf.c? The documentat=
ion
under "Convention for importers" and "Convention for exporters" lists other
functions that require this lock, but the new get_pci_tph API was omitted.

> +
> +	if (!dmabuf->ops->get_pci_tph)
> +		return -EOPNOTSUPP;
> +
> +	return dmabuf->ops->get_pci_tph(dmabuf, extended, steering_tag, ph);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622184211.2229=
399-1-zhipingz@meta.com?part=3D2
