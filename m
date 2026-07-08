Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50D73C278A;
	Wed,  8 Jul 2026 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537001; cv=none; b=s4Z62SEupT69KK5HiNIhTmCE47pol8mC31khrTH+vu6AeY34c1I7orEhV+IjVJyHK/lK9qz9emIgHTF1tOLfuj5tj/kgsBhUev9RL0xqAwmD2MtqQ6sM8byBb0iX1o9+ujvbeHAIyg6hTLGGp9njK2/b6dxECR65T0lURo94Wys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537001; c=relaxed/simple;
	bh=RS4kJNWymJdN2wioN6Axi8Lm7H6TFOPDjhlzjrXLC14=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TaKe3ItDaeF7tAoR8QUT758KOfl9y3Mq6bFY6mMkKIYKqOGXbEcVy0+kytplPItP9st/VsVzhJs2PwY5QbE9gsQZuKwFHit4icmNXDcgUbrCSrmZbLG2CCnNKUE4qpv8xgRRm6ToCOwhyZYYlJR9bXOgSrphXq6OlbVyfmw1exQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDc8ORba; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDc8ORba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86621F000E9;
	Wed,  8 Jul 2026 18:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783537000;
	bh=0XUIH4RJMhVQt68irKmT6vSajtys2aF4ZUGzpwvpgSs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TDc8ORba0GhpJf7ZG9Kvy/FxphFSGcWcBgvt5JvgYBkqIL12zpq5HbEq8KCBRODSh
	 BaiPcocnmoijeoj7t0+qpkR/ukBDcqRaviEx47zGHx1gHUjR0PH5to5JFHc3ukQ1B3
	 auMydsqhH5QoOc1JV9vHMSxex9QqHXBhiCLAVrmSRCceNe38vNIFUh6mza492XDz3m
	 Q4gLanhRj9crbMb1kyaYod01w1Dyv6gSl5F0zCgvhlsgYoG15OcqhOpdHXj52Q6Qim
	 D7OqUUDKY37+wQPiVKepqHTNITGTOK8nas8Xdp+41UrwlZJAGygGDRy3VFWxjK6rTQ
	 Yb1xYrABbCEbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/10] dmaengine: dw-edma: Use common
 dw_edma_core_start() for both eDMA and HDMA
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: Frank.Li@kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260708-edma_ll-v4-8-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
 <20260708-edma_ll-v4-8-cc128f0afb61@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 18:56:39 +0000
Message-Id: <20260708185639.D86621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing lock protection in `dw_edma_device_resume` leading to virt=
ual channel list corruption.
--

--- Patch [8]: [PATCH v4 08/10] dmaengine: dw-edma: Use common dw_edma_core=
_start() for both eDMA and HDMA ---
commit e9a2a1385b7b45deaf7871886aa181ac959a00b4
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Use common dw_edma_core_start() for both eDMA and HDMA

This commit consolidates the start functionality by introducing a common
dw_edma_core_start() for both eDMA and HDMA. It removes the separate
.start() callbacks in the eDMA and HDMA cores.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 2652ad8e7a8f6..f52d9fd18e573 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -163,9 +163,37 @@ static void vchan_free_desc(struct virt_dma_desc *vd=
esc)
>  	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
>  }
> =20
[ ... ]
> +
>  static int dw_edma_start_transfer(struct dw_edma_chan *chan)
>  {
> -	struct dw_edma *dw =3D chan->dw;
>  	struct dw_edma_chunk *child;
>  	struct dw_edma_desc *desc;
>  	struct virt_dma_desc *vd;

[Severity: High]
This isn't a bug introduced by this patch, but does dw_edma_start_transfer()
have a structural data race when called from dw_edma_device_resume()?

When a client calls dmaengine_resume(), dw_edma_device_resume() executes
dw_edma_start_transfer() without acquiring chan->vc.lock.

In dw_edma_start_transfer(), vchan_next_desc() reads the desc_issued list.

If a client concurrently calls dmaengine_issue_pending(), the driver will
acquire chan->vc.lock and modify the desc_issued list using
vchan_issue_pending().

Can this lead to linked list corruption or a use-after-free when one
thread mutates the list while another reads it unprotected?

> @@ -183,7 +211,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan=
 *chan)
>  	if (!child)
>  		return 0;
> =20
> -	dw_edma_core_start(dw, child, !desc->xfer_sz);
> +	dw_edma_core_start(child, !desc->xfer_sz);
>  	desc->xfer_sz +=3D child->xfer_sz;
>  	dw_edma_free_burst(child);
>  	list_del(&child->list);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-edma_ll-v4=
-0-cc128f0afb61@nxp.com?part=3D8
