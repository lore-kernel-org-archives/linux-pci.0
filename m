Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60634423A9D;
	Thu,  9 Jul 2026 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611968; cv=none; b=mI8EkLAFz043yVVcQpzPpqWd+o6u4gYZ5dN2kcQvurOMrFand8ngGoeR1fgbo2Xjw7hvAJwPidFUWzeLV+hZt83qw/Wb19pI/QVXyuzl3tsDeEtEOPMwkwzOS+Tvp6SGiRnx9Yf9bNVcFt3LuedYyqxTkVleMUfDnyvbCs8UB+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611968; c=relaxed/simple;
	bh=6TrpzfXyoeXsmKixolpgCOJS5kgAJQgEFJ7Lp2UBYrE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LKFWOx4L4hlPCH+Ri5TetJanTmqpM1a8vRGcvrq5Trqs9MchrEuRdFSWEun1AYt3DnQJmT0yqMeALdNYpEI3TH2m28Key4ALhCJPm8ND+ZmqtUjXw7k2thlxpGuhFPLPcthG9OPbKD/rRe0tYfk8eXKgx3WTpvWlKwce5w8JmpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTMQKUyI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTMQKUyI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FDC1F000E9;
	Thu,  9 Jul 2026 15:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611965;
	bh=Noa+5loFXBxWp9tNFxLP/47QfKU8SMpt6+g2znB+m4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hTMQKUyIvp1cnPUVwkNIIyLIeB0Ti+J5z5vjcxnkld/mHl8Z3KQZY5Lp0xKw959mv
	 nHfVb0keDJ/YA3j49r6FandGabHc7Yfb4mzVV3JJUpCVEsbDwKktL8Tu7vM4nI/Zzv
	 rT8mINq4+d6AJahlXAsW8LTU6PczG4qxsawgFnOzZoK7kXY6AVOaf19M+2V5MmBjaN
	 QgTRpw2rei94DmynCiWZBYMsn7sNonsJXziRe7fWj46RIqJckmh6ESL827aqrM/+3q
	 0J7ZX0CuPnKdl9r0SZykreuEq6Ce8x0PUQcT0f5wVi8C9k6TUCTehocSTM3VF+mhcW
	 tv969ie80wIwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/10] dmaengine: dw-edma: Use burst array instead of
 linked list
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org
In-Reply-To: <20260709-edma_ll-v5-9-e199053d4300@nxp.com>
References: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
 <20260709-edma_ll-v5-9-e199053d4300@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:46:05 +0000
Message-Id: <20260709154605.89FDC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch breaks DMA transfers in non-linked-list (`non_ll`) mode =
for multi-burst transfers by ignoring `bursts_max` and erroneously grouping=
 multiple bursts into a single chunk.
- [High] Premature scatter-gather loop termination leaves trailing zero-ini=
tialized bursts that are blindly submitted to the DMA hardware.
--

--- Patch [9]: [PATCH v5 09/10] dmaengine: dw-edma: Use burst array instead=
 of linked list ---
commit e4c02e28044af675e21dc05442589d1431ab18b6
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Use burst array instead of linked list

The commit replaces the linked list used for DMA descriptor bursts with a
pre-allocated burst array inside each chunk. This simplifies the descriptor
layout and eliminates multiple kzalloc() calls.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index f52d9fd18e573..01bee22fe3b3e 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -166,23 +103,17 @@ static void vchan_free_desc(struct virt_dma_desc *v=
desc)
>  static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan =3D chunk->chan;
> -	struct dw_edma_burst *child;
>  	u32 i =3D 0;
> -	int j;
> =20
>  	if (chan->non_ll) {
> -		child =3D list_first_entry_or_null(&chunk->burst->list,
> -						 struct dw_edma_burst, list);
> -		if (child)
> -			chan->dw->core->non_ll_start(chunk->chan, child);
> +		if (chunk->nburst =3D=3D 1)
> +			chan->dw->core->non_ll_start(chunk->chan, &chunk->burst[0]);

[Severity: High]
If a client submits a transfer with cnt > 1 on a non-LL channel, the alloca=
tion
logic below sets nburst > 1.

When nburst > 1, this condition fails and the DMA hardware is never started.

Does this silently drop non-linked-list multi-burst transfers?

>  		return;
>  	}
> =20
> -	j =3D chunk->bursts_alloc;
> -	list_for_each_entry(child, &chunk->burst->list, list) {
> -		j--;
> -		dw_edma_core_ll_data(chan, child, i++, chunk->cb, !j);
> -	}
> +	for (i =3D 0; i < chunk->nburst; i++)
> +		dw_edma_core_ll_data(chan, &chunk->burst[i], i, chunk->cb,
> +				     i =3D=3D chunk->nburst - 1);

[Severity: High]
In dw_edma_device_transfer(), if the scatter-gather chain finishes early, t=
he
loop breaks.

However, chunk->nburst is not updated to reflect the actual populated count.

This causes dw_edma_core_start() to iterate over and submit the trailing
zero-initialized descriptors (sz 0, sar 0, dar 0).

Could this loop submit uninitialized descriptors to the hardware?

[ ... ]

> @@ -530,15 +456,15 @@ dw_edma_device_transfer(struct dw_edma_transfer *xf=
er,
>  		if (xfer->type =3D=3D EDMA_XFER_SCATTER_GATHER && !sg)
>  			break;
> =20
> -		if (chunk->bursts_alloc =3D=3D bursts_max) {
> -			chunk =3D dw_edma_alloc_chunk(desc);
> +		if (!(i % chan->ll_max)) {
> +			u32 n =3D min(cnt - i, chan->ll_max);
> +
> +			chunk =3D dw_edma_alloc_chunk(desc, n);

[Severity: High]
For non-LL mode transfers, using chan->ll_max instead of bursts_max causes
chunks to be allocated with a larger nburst than the expected bursts_max =
=3D 1.

This leads to the hardware start routine silently dropping the transfer.

Is it intentional to use chan->ll_max here instead of bursts_max?

>  			if (unlikely(!chunk))
>  				goto err_alloc;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-edma_ll-v5=
-0-e199053d4300@nxp.com?part=3D9
