Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B772B3749E3;
	Tue,  9 Jun 2026 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033921; cv=none; b=O4tcDljf5tn0IrXcee7LM6UUq0Pt5JYy/cveOBeR4hXtCmu8duEQsKfr0468EszRCsLcXD4VSlejqNLzE/Tyw0WA+g/8swoQPW3DTqsLpbek+Uz0j/HZXzsoKtm13J/gMhRP1jZrTw/XoAr7CjzfrQ+UjEe0NtfyDfkZT6xNnUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033921; c=relaxed/simple;
	bh=KvcEEYxvmOUiI9cyXcsotZyuHFEm3wyLZfm+ZnhTj9M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J8jDjfx4WCHZKyCzSYO5jGfk9sCAGoH+OXz5DjDxYiLnJU+wASMRAmUKOinlQVEFSkKubddZsUt0zJ+9zrdSGbfeDnxR50OyRZPym21sE/uHmkpjaG92GoLrQhEpxv/2ZkU4BORSwwDMZcWiGBYlcUcKpTn68PMe0wNH2S85hwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofsq1F39; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofsq1F39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1CF1F00898;
	Tue,  9 Jun 2026 19:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781033920;
	bh=uz4+gr3D38V6VQkkwrqcxD5qQqSaLTJdwMBY/wQjwGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ofsq1F398P7m1z50wqpqJzIu9C/LSAyeXc/MqrtPPV9wNYWn8zLPxtcWDc0pH/7Ww
	 suCiqZXvlZG3tkTftRNbcIoZSPaJELJ4VXrDZTDWJ55WH0jh1MPkoQEOpnFCTXJSKw
	 Y5fSbyiibXmAfR6ZNagLp20maVxMHXVnSdggbVRtCy+7XackeiRTtQj/8FvhYW+fhl
	 VvdU86lSmI1Rtr4FCpz3D6nbKd7aTIGbgCiFPcLOnKM6u/mAg5zlM2coP8GJqhOxm6
	 SRCGa1cPRKh4ow1wd5VvO9bK2ynPsRrOgiy3clL3WAYdUbeMbAWnrRuG0UG20yJjlx
	 8+G8vl0wY28Aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/5] dma-buf: add optional get_tph() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260608185646.4085127-4-zhipingz@meta.com>
References: <20260608185646.4085127-4-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 19:38:39 +0000
Message-Id: <20260609193840.4A1CF1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `get_tph` callback takes `struct dma_buf *` instead of `struct=
 dma_buf_attachment *`, failing to account for per-attachment mappings and =
dynamic buffer migrations.
- [High] The new `get_tph` operation lacks a corresponding core API wrapper=
 function in `dma-buf.c` and is omitted from the subsystem locking document=
ation.
--

commit 4644c9f73b091302efc6ec2a805dcc7affb8aaf6
Author: Zhiping Zhang <zhipingz@meta.com>

dma-buf: add optional get_tph() callback

This commit adds an optional get_tph callback to the dma-buf ops so an
exporter can return PCIe TPH (TLP Processing Hints) metadata to an importer.
The API provides a discoverable negotiation point between exporter and
importer.

> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index d1203da56fc5f..8437dbe4a83ec 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -113,6 +113,37 @@ struct dma_buf_ops {
>  	 */
>  	void (*unpin)(struct dma_buf_attachment *attach);
> =20
> +	/**
> +	 * @get_tph:
> +	 * @dmabuf: DMA buffer for which to retrieve TPH metadata
> +	 * @extended: false to request the 8-bit ST namespace, true to request
> +	 *            the 16-bit Extended ST namespace
> +	 * @steering_tag: Returns the raw TPH steering tag for the requested
> +	 *                namespace
> +	 * @ph: Returns the TPH processing hint (2-bit value)
> +	 *
> +	 * Return the TPH (TLP Processing Hints) metadata associated with this
> +	 * DMA buffer for the requested steering-tag namespace. 8-bit ST and
> +	 * 16-bit Extended ST are distinct namespaces in the PCIe TPH ST table
> +	 * and may both be present with different values, so the exporter must
> +	 * select the value that matches @extended and must not substitute one
> +	 * for the other.
> +	 *
> +	 * The exporter owns the completing address space for @dmabuf and
> +	 * therefore decides whether it can derive meaningful TPH metadata for
> +	 * that completer. The dma-buf core treats the returned ST/PH tuple as
> +	 * opaque transport metadata; importers that support TPH place it on
> +	 * outbound TLPs, while exporters that cannot derive a useful tuple
> +	 * simply return -EOPNOTSUPP.
> +	 *
> +	 * Return 0 on success, or -EOPNOTSUPP if no metadata is available for
> +	 * the requested namespace.
> +	 *
> +	 * This callback is optional.
> +	 */
> +	int (*get_tph)(struct dma_buf *dmabuf, bool extended,
> +		       u16 *steering_tag, u8 *ph);

[Severity: High]
Does this callback need to take a struct dma_buf_attachment * instead of a
struct dma_buf *?

A dma-buf's physical backing storage is only stable in the context of a map=
ped
attachment. Exporters might provide device memory to a peer-to-peer capable
importer, but system memory to another importer. Furthermore, dynamic dma-b=
ufs
can migrate their backing storage between VRAM and system memory, which cha=
nges
the completer and the correct Steering Tag.

By querying TPH metadata on the global dma_buf object without an attachment
context, the exporter cannot know which importer's mapping is being queried.
Can this prevent the exporter from returning the correct completing address
space's Steering Tag?

[Severity: High]
Should this new operation have a corresponding core API wrapper function ex=
ported
in drivers/dma-buf/dma-buf.c and documented in the locking convention block?

In the dma-buf architecture, ops are typically encapsulated behind core wra=
ppers
to enforce cross-subsystem locking, validate inputs, and handle tracing. By
omitting the wrapper, importers are forced to bypass the core API and
dereference the ops structure directly:

drivers/infiniband/hw/mlx5/mr.c:get_tph_mr_dmabuf() {
    ...
    ret =3D dmabuf->ops->get_tph(dmabuf, extended, &steering_tag, &local_ph=
);
    ...
}

Does the lack of a wrapper function like dma_buf_get_tph() violate the expe=
cted
API encapsulation for dma-buf operations?

>  	/**
>  	 * @map_dma_buf:
>  	 *

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608185646.4085=
127-1-zhipingz@meta.com?part=3D3
