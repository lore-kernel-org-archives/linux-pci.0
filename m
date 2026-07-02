Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5851138C2AA;
	Thu,  2 Jul 2026 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783028417; cv=none; b=apekC1zg4p+WiVmMkMaWzQUklrPVdnhsJEnPtZ+v0gB30Ighlfiv4qO+J+DszCyusksNJC7YjqWYVK5i/16X/OhPRqmeJ1FoSfokL2I0pe/aoGllLSs+k8xs2z9QqrPMvXknFRQByur0ikVMPUmYpjrv/SR/AH8/usZP1qvPLdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783028417; c=relaxed/simple;
	bh=uQ0OI1LrVYlyIGYRdlOeSzV305Aoqq1Lipc5pXO3ESU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JBtGqet+PtyGXOIb4wXKA+3Ro+7+XuwMBrWtYJuq3anX6LfsefC9hheF7c/i+sQ0zi/E78k9JZVgQymWYr2K+OwMS0cXjZ7bqWenVfJfTEjgDF2zOtnPVmkc/YB45MsI/pzZ10wdkRmwbZQAN3jo//OmUUTSs1S8Qmy1JRlQJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFInOqzq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFInOqzq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79121F000E9;
	Thu,  2 Jul 2026 21:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783028416;
	bh=53B/u5Oi9+ySFk9NNzlVBxe1WWsmENvFv29PxgvNvjo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DFInOqzqj+tbxdjXGXq8RGQz0yLjkB3q1nXX70xqGAV76oC0/NL+6sH/pDMWmoomC
	 p5g7WG9fgT7VRsaW9p2VOHjbK6B3f45tMZJbru9a7oJ5zj5EAOvKBJ/a4ny3LDan53
	 0OQS5o9iuiugCK2poXxFSOh6KIhTJlvlDEXZAgKOR6CPgjyFg6SZhICxe1O6Gi3qLq
	 LD7wUHB7zVdSFB3a4InBJYuaym7QFx4p29nwxKrdn/KIVPcMjupLrZd7lKAy7gMz6k
	 JmNcikuAIKFX+3yrhex3iPb8NW8CL/kzl7fbu8EnDBUUXMWNY7WqRnnIuWIZc8Zha3
	 28pFqkrHjg6ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/10] dmaengine: dw-edma: Use burst array instead of
 linked list
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260702-edma_ll-v3-9-877aa463740c@nxp.com>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
 <20260702-edma_ll-v3-9-877aa463740c@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 21:40:15 +0000
Message-Id: <20260702214015.A79121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Early loop termination during scatter-gather mapping leaves traili=
ng bursts uninitialized, leading to invalid DMA hardware configuration and =
silent hangs.

Pre-existing issues:
- [High] Missing spinlock in dw_edma_device_resume() leads to list corrupti=
on, data races, and lockdep warnings.
--

commit a2364f066e8539a3a2c9d2afab52db8336748992
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Use burst array instead of linked list
   =20
Creating a DMA descriptor requires at least three kzalloc() calls because
each burst is allocated as a linked-list node. Allocate a burst array when
creating each chunk to simplify the code and eliminate one kzalloc() call.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index f52d9fd18e573..01bee22fe3b3e 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
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
Does this loop iterate over uninitialized bursts if the scatter-gather
loop in dw_edma_device_transfer() terminates early?

In dw_edma_device_transfer(), if the loop breaks early because !sg,
chunk->nburst remains at its originally allocated count rather than the
actual number of initialized elements.

Since the irq flag is only set on the very last element
(i =3D=3D chunk->nburst - 1), and that element might be uninitialized, could
this program the DMA hardware with zero-sized transfers and cause a
silent hang?

> =20
>  	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
> =20
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
>  			if (unlikely(!chunk))
>  				goto err_alloc;
>  		}

[Severity: High]
This is a pre-existing issue, but looking at dw_edma_device_resume(),
it appears to modify state and access lists without taking the channel's
virtual spinlock:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_resume() {
    ...
	} else {
		chan->status =3D EDMA_ST_BUSY;
		dw_edma_start_transfer(chan);
	}
    ...
}

Since dw_edma_start_transfer() eventually calls vchan_next_desc() which
expects lockdep_assert_held(&vc->lock), and hardware interrupts could fire
simultaneously calling dw_edma_done_interrupt(), can this lead to list
corruption and data races?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-edma_ll-v3=
-0-877aa463740c@nxp.com?part=3D9
