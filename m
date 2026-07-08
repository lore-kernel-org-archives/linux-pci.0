Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4002237C0F9;
	Wed,  8 Jul 2026 18:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536585; cv=none; b=SBydCc6bOGf+oM3z0dcPYGnmU+Wxv+DIbxUgS4lPn1r77gH0jxT0NvfTIE8qYfeGwZb0yZNMOAJtztsj09+xZYb75JWu03DRY2avQVGfMb7kIkB11y/MInWEmEgqKLaWS58DNbfuKzbUl2Av3xQ2HZBR3qkb8lfIKO6lPw0ALzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536585; c=relaxed/simple;
	bh=5PhGChqIPPMQp4xWjFpFYC8kIzuuSx7QXn62O7lXvVA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G5itg5ip61DsyBOWUu0+p73Wf33CFa4AZmK7HZSo89aR6IqrOEQj1/IKeTKiASj5Z15eCcKAXkODCu/7+at2ubbp8GKjhVHVJ8rSe9lrLLxfEtnM8jRV+pJ+Q0MYtRXlp/tTBOsijbhioKWcac6FGQY48b7Mp+JzHGGMMwPyc0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SI3eZIkp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SI3eZIkp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F171F000E9;
	Wed,  8 Jul 2026 18:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783536584;
	bh=Cty63/z88jEVhceG7935CFPE1q5l+K61l51l9Ne/4sI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SI3eZIkp24SpkjbKnxmQZQRlPh2+zPOVZtQ0tsF2bY3h1JMvzEzf7KZHSu/JZld78
	 YERY0P1btChAdL77rDo9YqX+KUC8xuMI1/L8uXOgyDDApFhwYPTGSmiAlCKH0DF8B5
	 RGI8ODi2s5e1DzgQsOU0UWRDAbvb2G99aYRTxXu/VNNP67BZ8ZQB6E2X4Kt1W89f1K
	 iXQTEPUlElvCde3POw/PYdpYA6G46FqspNY3UoZqW+6YFt+qd0adFXtsHCUK09p1mI
	 wziiF4gshLjC94e/lE9nbArQGxJcQza322AGW4JYmki+q9nLzt158+Yj/c6ivh9r+j
	 XPXMulcl/2Ggg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/10] dmaengine: dw-edma: Use burst array instead of
 linked list
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, vkoul@kernel.org
In-Reply-To: <20260708-edma_ll-v4-9-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
 <20260708-edma_ll-v4-9-cc128f0afb61@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 18:49:43 +0000
Message-Id: <20260708184943.99F171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Multi-burst transfers in non-LL (non-Linked-List) mode will silent=
ly hang because bursts are incorrectly grouped, leading to hardware program=
ming being bypassed.
- [High] Early termination of scatter-gather iteration leaves uninitialized=
 bursts in the pre-allocated chunk array, leading to zero-filled descriptor=
s being submitted to hardware.
--

--- Patch [9]: [PATCH v4 09/10] dmaengine: dw-edma: Use burst array instead=
 of linked list ---
commit baa518039c3b11326baa6f39333dddc50d2d6b4f
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Use burst array instead of linked list

Creating a DMA descriptor requires at least three kzalloc() calls because
each burst is allocated as a linked-list node. Since the number of bursts
is already known when the descriptor is created, a linked list is not
necessary. Allocate a burst array when creating each chunk to simplify the
code and eliminate one kzalloc() call.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -530,15 +456,15 @@ dw_edma_device_transfer(struct dw_edma_transfer *xf=
er,
>  		if (xfer->type =3D=3D EDMA_XFER_SCATTER_GATHER && !sg)
>  			break;

[Severity: High]
If this loop breaks early, chunk->nburst retains the pre-allocated max
size (n) without being updated to match the actual number of populated burs=
ts.

Will the subsequent hardware programming loop in dw_edma_core_start()
iterate up to the unadjusted chunk->nburst, inadvertently submitting
zero-filled descriptors and setting the completion flag on the wrong burst?

> =20
> -		if (chunk->bursts_alloc =3D=3D bursts_max) {
> -			chunk =3D dw_edma_alloc_chunk(desc);
> +		if (!(i % chan->ll_max)) {
> +			u32 n =3D min(cnt - i, chan->ll_max);
> +
> +			chunk =3D dw_edma_alloc_chunk(desc, n);

[Severity: High]
The previous code used bursts_max to limit chunk sizes here, restricting
non-LL mode transfers to 1 burst per chunk. This new chunk sizing logic
unconditionally allocates up to chan->ll_max.

For multi-segment non-LL transfers, will chunk->nburst now exceed 1?

If so, when dw_edma_core_start() runs:

    if (chan->non_ll) {
        if (chunk->nburst =3D=3D 1)
            chan->dw->core->non_ll_start(chunk->chan, &chunk->burst[0]);
        return;
    }

Might this cause the function to silently return without starting the
hardware, permanently hanging the transfer?

>  			if (unlikely(!chunk))
>  				goto err_alloc;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-edma_ll-v4=
-0-cc128f0afb61@nxp.com?part=3D9
