Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285FF347536;
	Mon, 13 Jul 2026 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963313; cv=none; b=XxoDPbmbm9jhIls1xK7PIw/J9HH69+08ccqIwn8c68b1M6eEOjpPnDcAWDFzZninFLoe7zzB92Bc96rxZPYsreFWj6sLMsCgoS9i2tDt2qJWkm7o2q1sFDMS5XVfK71iOmfKVOPxFtTml06ozwDflrjAlfL0ip5q91LE/I7xYXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963313; c=relaxed/simple;
	bh=VaunfQ/e6sC9NCGkubdy6D49j/TN9tYTme1o0ulMURo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i/2r5b5ahO/xdGl4FJqbhCVTbPkqGwrqAOSJvZN+J95Rge8tmFanHmiIytN4r+LFo9h2/O94sgztAzj26VMI521Dt0e0804Ylm9M2Uxaak38gVbzuqH/xcrMPsuyAcABS/u8dWsy8B0cWyyrc+kzl+rp/LRb0TaoTycRc5qgc4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRRWgYTC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRRWgYTC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B8A1F000E9;
	Mon, 13 Jul 2026 17:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783963311;
	bh=KtzniS4S2SEveFRnCWgspZpvD/ummeoQ7/M85E9eZzo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QRRWgYTCprOVDFCpEv28cEBn0orhAvt1bZ4WpA8y4dBDH8PKoZU1EIGsyxM5BH1X1
	 wdmBNtwij2ybdjCXOwOMmjGZdcZ8Z4cyXQFtrSSO4yzyYT/Ozn++LBW5xC1AR8cbKC
	 IUd55ShbUtczWGvTcSV6ccRcQX6NOyBrX0KrRoSKT2/FYwayYkHZDp07gUQOpZ1Fdo
	 m9L/uD6V85Ga09PryWb/XZaJ22wEJwIwSGMEEK+gNopuHwTKtyoN1MWnKcYrK1Zpru
	 8J9aEOJZSIWOG0/WQDF0IxE7zYitKhiFj50orfTNw/Q6GrVK26feiEqtaxtNCkPe6w
	 Jw0VMgpiVNWdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/10] dmaengine: dw-edma: Add non_ll_start()
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260713-edma_ll-v7-7-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
 <20260713-edma_ll-v7-7-6fb7498c901e@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:21:50 +0000
Message-Id: <20260713172151.65B8A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The first burst and chunk are systematically ignored and dropped d=
uring DMA transfers, causing transfers to silently fail.
- [High] Data race and list corruption due to accessing channel state and v=
irt-dma structures without holding the `chan->vc.lock`.
--

--- Patch [7]: [PATCH v7 07/10] dmaengine: dw-edma: Add non_ll_start() call=
back ---
commit 7dc5c95dae459bfa0e6a411b33405e84c6e8c394
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Add non_ll_start() callback

This commit adds a non_ll_start() callback and moves common non-linked-list
channel handling into the EDMA core so it can be shared by both EDMA and
HDMA. It also prepares for the upcoming reorganization of the burst and chu=
nk
structures.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-=
edma-core.h
> index bab4d49c92feb..e18d6e827c2c9 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
[ ... ]
> @@ -201,7 +202,16 @@ dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, =
enum dw_edma_dir dir,
>  static inline
>  void dw_edma_core_start(struct dw_edma *dw, struct dw_edma_chunk *chunk,=
 bool first)
>  {
> -	dw->core->start(chunk, first);
> +	if (chunk->chan->non_ll) {
> +		struct dw_edma_burst *child;
> +
> +		child =3D list_first_entry_or_null(&chunk->burst->list,
> +						 struct dw_edma_burst, list);

[Severity: High]
This isn't a bug introduced by this patch, but does this skip the first bur=
st?

The driver implements linked lists by treating the first allocated element's
list member as the head of the list for subsequent elements, instead of usi=
ng
a standalone struct list_head. When standard Linux list macros like
list_first_entry_or_null() are used on &chunk->burst->list, they
automatically skip the head node.

If only one burst is allocated in non-LL mode, would this return NULL and
silently skip starting the transfer?

> +		if (child)
> +			dw->core->non_ll_start(chunk->chan, child);
> +	} else {
> +		dw->core->start(chunk, first);
> +	}
>  }

[Severity: High]
This is a pre-existing issue, but can data races and list corruption occur
due to accessing channel state and virt-dma structures without holding the
chan->vc.lock?

For example, when calling dmaengine_resume() on a DMA channel, the driver's
dw_edma_device_resume() calls dw_edma_start_transfer(). This reads from the
virt-dma lists without holding chan->vc.lock:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_resume() {
    ...
    chan->status =3D EDMA_ST_BUSY;
    dw_edma_start_transfer(chan);
    ...
}

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_start_transfer() {
    ...
    vd =3D vchan_next_desc(&chan->vc);
    ...
}

Concurrently, dw_edma_done_interrupt() handles completed descriptors and
modifies the same lists under vc.lock, causing a direct data race.

Additionally, dw_edma_device_terminate_all() mutates chan->request and
chan->status locklessly.

Could this lead to list corruption or kernel panics when racing with
interrupt handlers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-edma_ll-v7=
-0-6fb7498c901e@nxp.com?part=3D7
