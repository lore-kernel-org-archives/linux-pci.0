Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E35834A3D6;
	Tue, 14 Jul 2026 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026221; cv=none; b=OHOZTk5xN7TZGEwiTb8W6675tdIFBqGRlOZHjR+mAM0Qy9LxY2bhQmtdHsTbZgQ3MbTE7YhuYCyx3ErfYVQPCkakoGKmJSaQjY0SqIxlZoH1JzIzSnimk1fZSBG9qH5tlSpfj84IA4ytG8cj79m8c6isyDOZLLEw8iX20Hp2+98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026221; c=relaxed/simple;
	bh=JH1s3+2fTTFYpfkiPKDzClX4xe4rRo1wxP3z+YbAhSg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nn1l54vrlsEUOlFDSvHLtYg58YIP5nWTu2G4k6MSRb55QfgsQwS9Alkd34aX5UVcrAdGFVhneL8Yb0fw55AFzZwrMfPbfxDta9ZPKIlh8nPBr5G5gkMn+vbSTNnd7YyUE/XbS8ymRdYte+eW6RLiK7FtIIODvA5p50iFVy9HqBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDsS1pZm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDsS1pZm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765521F000E9;
	Tue, 14 Jul 2026 10:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784026219;
	bh=rivpYrwIXe+BHfVoVyjRB3FTMfYuUvgKIZmVK9H6SGA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cDsS1pZmmA0lSeR7mAw9bXc5SS1anMuC/4yDltBQWclFDiuY0bGYH/94mE8cUhP72
	 MjotUJ/2q32iotJrZD4ttdnrI7zsVF/8SH7yh0Gaj10bQWTtr+qytPzsDV/fadKfS5
	 VrdbEiDLVYXBTgimwkAVODJwmQ0Tm2b2Okfuq20uq7KcadzSOe6khMHLPhHDc2kw7E
	 IsC9SZCJ0PunHX0mC4FSmsRam/8YelDFghxA6okTYONd2JlAA1gkW7xRBBSZvEnBR+
	 Sj7bwkg1qHk5GirH73NiHtaSUO6qVVf+ZWzNpzZlccWlhoPGXRxDrr5h5dieUEC5dD
	 c/B5V5Czkm2oQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 02/16] dma-buf: add optional get_pci_tph() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260714104325.54444-3-fengchengwen@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
 <20260714104325.54444-3-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:50:19 +0000
Message-Id: <20260714105019.765521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The kernel-doc comment references a non-existent callback `move_not=
ify` in `struct dma_buf_attach_ops`.
--

--- Patch [2]: [PATCH v20 02/16] dma-buf: add optional get_pci_tph() callba=
ck ---
commit 799bc3a75b6c6b1dc555780b54878e41e3161d8b
Author: Zhiping Zhang <zhipingz@meta.com>

dma-buf: add optional get_pci_tph() callback

This commit adds an optional get_pci_tph callback to dma_buf_ops and a
corresponding wrapper function dma_buf_get_pci_tph() for importers. It
allows importers to query the exporter for PCIe TLP Processing Hint
namespaces and matching ST/PH tuples.

> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index d504c636dc294..e8314ed240d33 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
[ ... ]
> @@ -1144,6 +1146,36 @@ void dma_buf_unpin(struct dma_buf_attachment *atta=
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
> + *
> + * The returned steering tag and processing hint are only valid until the
> + * exporter invalidates the current mapping (signalled to the importer v=
ia
> + * &dma_buf_attach_ops.move_notify). Importers must re-query after a new

[Severity: Low]
This isn't a bug, but there is no move_notify callback in
struct dma_buf_attach_ops. Should this reference the invalidate_mappings
callback instead?

> + * mapping is established following invalidation.
> + */
> +int dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
> +			u16 *steering_tag, u8 *ph)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714104325.5444=
4-1-fengchengwen@huawei.com?part=3D2
