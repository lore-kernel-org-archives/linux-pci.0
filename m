Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC0824E4C6;
	Fri, 10 Jul 2026 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702602; cv=none; b=ny6I/+kCVJfu1XHGtBwISqYbIm4FmPgB5KJCQ7gT6vCDqBLDMg54sVCZXMViuI0416S7rGxoPQ362cMfSvAkyJgXOUtQ0NW7ebRLixTf0wJ3rIje6shrP1KczNRc3Ac7VWBv9+LJzNj8ZEYmzCNnXmq1yUzd8LkGg7JXsX+x8OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702602; c=relaxed/simple;
	bh=j4JN5Am7coga55SqxqlCCKOEZx7XHoaUJOlhVgUlaHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gE5BJvkns7WS7/ti9ADBH2n2RQeQW4Ec/Q3sLcgCKzyruekHZb/srgWKAnKZLWc4d4jvqk2z0knQrNpM7VyJBO1wM6XvCBb6d5tJru6c+DewrazxviZlHqYE7pROGBocPawJjBfQoYPNqEbGozY9NAmiydnL8zyR8mY0Rj/yk8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sn5k84cO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sn5k84cO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58E61F000E9;
	Fri, 10 Jul 2026 16:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783702601;
	bh=YTVvV5NuZgF0/3N9MthDYQpRUf7t3lgUjDm5qEEd+98=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sn5k84cOOMuBDAahJy+D+Pj5BGSou9D63WiptxHVJLKHy8RSiEikj7YWEOX5zZhFS
	 vC4ioj4ButntwHplWR6RsrAZJ4CG7lPOYe+0iD/rCOFhaMzu7qyjcX7izwYc/+Xkm5
	 JJgLYvWhzRV8cK+74SAwBtmTDWPFpnbUotP14LzOAnkbjeNI199YhQtSioKI4Elk13
	 soQTVO8lBZ63osRip8YPjj5jYZxtExnp3u4BgsC86q7QBauJiu3gq+tnKMOjkHeJRu
	 QYiWWGe6uRoxSc5WpuFu5Y+f1x27q1LpOc0XOQtMysQ8BIGyLjNZShJHS6GOkTAtOX
	 wUw0q6LeW1ptw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/10] dmaengine: dw-edma: Pass down dw_edma_chan to
 reduce one level of indirection
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, vkoul@kernel.org
In-Reply-To: <20260710-edma_ll-v6-4-1471d278b73a@nxp.com>
References: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
 <20260710-edma_ll-v6-4-1471d278b73a@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 16:56:40 +0000
Message-Id: <20260710165640.C58E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a preex=
isting endianness bug in local DMA descriptor initialization for big-endian=
 architectures, leading to memory corruption.
--

--- Patch [4]: [PATCH v6 04/10] dmaengine: dw-edma: Pass down dw_edma_chan =
to reduce one level of indirection ---
commit 8719a22bd4ff9eee44469b7d4192520551bd05a3
Author: Frank Li <Frank.Li@nxp.com>

    dmaengine: dw-edma: Pass down dw_edma_chan to reduce one level of indir=
ection
   =20
    Some helper functions do not use any information from dw_edma_chunk, so
    passing a dw_edma_chan pointer directly avoids an unnecessary level of
    pointer dereferencing and simplifies data access.

> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/=
dw-edma-v0-core.c
> index 51e50f1fdcac4..c341aa5343417 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -276,13 +276,12 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_i=
rq, enum dw_edma_dir dir,
>  	return ret;
>  }
> =20
> -static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
> +static void dw_edma_v0_write_ll_data(struct dw_edma_chan *chan, int i,
>  				     u32 control, u32 size, u64 sar, u64 dar)
>  {
>  	ptrdiff_t ofs =3D i * sizeof(struct dw_edma_v0_lli);
> -	struct dw_edma_chan *chan =3D chunk->chan;
> =20
> -	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
> +	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
>  		struct dw_edma_v0_lli *lli =3D chan->ll_region.vaddr.mem + ofs;
> =20
>  		lli->transfer_size =3D size;

[Severity: High]
This problem wasn't introduced by this patch, but there is a preexisting
endianness bug in local DMA descriptor initialization for big-endian
architectures here.

Since the hardware expects little-endian values, does assigning native CPU
values directly to the memory-mapped descriptor structs in the local path
corrupt the DMA layout on big-endian CPUs?

The non-local path correctly uses writel() and writeq() which perform
implicit CPU-to-LE conversions, but writing 64-bit values natively to the
reg union member places the most-significant bits into the lsb field on
big-endian systems:

dw_edma_v0_write_ll_data() {
    ...
    if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
        ...
        lli->transfer_size =3D size;
        lli->sar.reg =3D sar;
        lli->dar.reg =3D dar;
        dma_wmb();
        lli->control =3D control;
    ...
}

This could cause the DMA controller to read mangled addresses and swapped
transfer sizes, potentially leading to memory corruption.

The same pattern appears to be present in dw_edma_v0_write_ll_link(),
dw_hdma_v0_write_ll_data(), and dw_hdma_v0_write_ll_link().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-edma_ll-v6=
-0-1471d278b73a@nxp.com?part=3D4
