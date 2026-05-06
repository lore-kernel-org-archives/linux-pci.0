Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDFA24A06D
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778105825; cv=none; b=Xo8D7+QcASqxkW3FndQ813EPcY/j63PXsOGr/6ihxxkOPv2Wbg2LgHh6Q8vzpffXQmPbwGLLS7VzxJAR6CfzS8G3NSJneXym0IJUmMy7Flu4MS02uTuN6GqyYtPj/tB19VWMOFPM+KKtypHNBhSIJGv10F2MqATVGCttG2TW26E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778105825; c=relaxed/simple;
	bh=Ii0mxlTmWvvbFelyxNowT+cEEtcD/zNY4NzXEDs5Abo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CJBt2EpgjK/GvhuzEsoKLuLbbJ6NSSkPDJczKZQodxVfLge34phFXaERDPPxmhp7Fo21jGFN8rftGbARRxnHILAUwIgnKGXhNoH/EGrnU6Jd/H4A54N+znkKl22otVERWV5WX1L5/wY3GJytLgVAIsSxy+FI6AINoezaEdrfNQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtiJwkJP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtiJwkJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B33C2BCB0;
	Wed,  6 May 2026 22:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778105825;
	bh=Ii0mxlTmWvvbFelyxNowT+cEEtcD/zNY4NzXEDs5Abo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mtiJwkJPEqo2OP0RocdKGUO1lUGLQHuB06eHDFJ/cuOhKEziMMu4SlXT/UYO5qazo
	 ziYreSUi1Lp1hpZzEQPlFSZqReFKKyObKMIXR9QnyqiGRKKog5sjM41F+joTyWsYgy
	 hTacWwQ8S6NfyGBIjJF9KiGGGBxfdkh3yBrO/h3knCClHFp6JI+oURALna+bIYVSNV
	 b/bDPvMOLDSCe97a48mbMGpZtVJCHq2AQks3lzJf+7ZUkjckA+POZHzFDjHPLV7IZx
	 VVg21P8H50NTe78kO6zmTLJ6xMe5hzwcYK8azGuRpW3ARbQsh8NWUN7qxl68RJrwRB
	 wtKLB6moIxt6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/9] dmaengine: dw-edma: Use new
 .device_prep_config_sg() callback
Reply-To: sashiko@lists.linux.dev
To: "Frank Li" <Frank.Li@nxp.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260506-dma_prep_config-v4-4-85b3d22babff@nxp.com>
References: <20260506-dma_prep_config-v4-4-85b3d22babff@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 22:17:04 +0000
Message-Id: <20260506221705.53B33C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The return value of dw_edma_device_config() is ignored, leading to=
 silent preparation failures and corrupted state.
- [High] Lockless modification of shared channel configuration causes a rac=
e condition during concurrent descriptor preparation.
--

commit 72239068fd086ad95d773ab05d33c4df60a82fea
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Use new .device_prep_config_sg() callback

This commit introduces the .device_prep_config_sg() callback for the
dw-edma driver. It combines configuration and scatter-gather descriptor
preparation into a single step.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index c2feb3adc79fa..f7f58b0010e26 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -577,10 +577,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xf=
er)
>  }
> =20
>  static struct dma_async_tx_descriptor *
> -dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist =
*sgl,
> -			     unsigned int len,
> -			     enum dma_transfer_direction direction,
> -			     unsigned long flags, void *context)
> +dw_edma_device_prep_config_sg(struct dma_chan *dchan, struct scatterlist=
 *sgl,
> +			      unsigned int len,
> +			      enum dma_transfer_direction direction,
> +			      unsigned long flags,
> +			      struct dma_slave_config *config)
>  {
>  	struct dw_edma_transfer xfer;
> =20
> @@ -591,6 +592,9 @@ dw_edma_device_prep_slave_sg(struct dma_chan *dchan, =
struct scatterlist *sgl,
>  	xfer.flags =3D flags;
>  	xfer.type =3D EDMA_XFER_SCATTER_GATHER;
> =20
> +	if (config)
> +		dw_edma_device_config(dchan, config);

dw_edma_device_config() can return an error code like -EINVAL if the
configuration is invalid. Does ignoring this return value cause the transfer
to be scheduled with a corrupted or stale state? Should this return NULL if
the configuration fails?

Also, the new .device_prep_config_sg callback is often used to allow lockle=
ss
descriptor preparation. However, dw_edma_device_config() modifies shared
channel state:

dw_edma_device_config() {
	...
	chan->non_ll =3D false;
	...
	memcpy(&chan->config, config, sizeof(*config));
	chan->configured =3D true;
	...
}

If multiple threads prepare transfers concurrently, can this cause a data
race resulting in corrupted descriptors?

> +
>  	return dw_edma_device_transfer(&xfer);
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506-dma_prep_c=
onfig-v4-0-85b3d22babff@nxp.com?part=3D4
