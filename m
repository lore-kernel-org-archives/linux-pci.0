Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57A2146588;
	Wed, 13 May 2026 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778638809; cv=none; b=LtrNiQdWJZ8bw1MNtaweUxcI7nPMd5/+u77X80ALX+eqz0S7IxZZRbQnKKoQNHI4ruate4TynwB7VKyxWd4XbPvViiV9mWaSI6S/xaE+brKcrDzunEXocooaSzk5NFJP4QZTSQasfKy0SxDk49E9NhzLqaK9BEOuO0vDxK3/txo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778638809; c=relaxed/simple;
	bh=oJRZD2R5Q+su3BrG4e0aUYgo/7agh7h1UKz1nZVPIlo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OFkWZ1Z8Tmry8NoaCIEbTuNgytD/vFY9HZ8HhrYQIZyRy6PXQiLYLm27yj6wNqN/PSwTqWuj9PvzFSnpVhoxEdD6Ji9LTOSEmcp72dB349e16b7XTbToez1JeBrTCufSY+/lrcK1cwREg2O5S0SnRN3sqv9x3MpmYTAVLduSitw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iva7/ziM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iva7/ziM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A3EC2BCB0;
	Wed, 13 May 2026 02:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778638809;
	bh=oJRZD2R5Q+su3BrG4e0aUYgo/7agh7h1UKz1nZVPIlo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Iva7/ziMgAXeMbKBLcsQ+cm3RpTlbBMityb0f2XUTvF1hGwzBoCHtCdE3d5CqzPnM
	 kMXzny5a1Oi0MXRYTmE7oHUQMiKGC6lP1V3qvZO/23sycWz2OIkxgB8PQIc/2AtMUL
	 K9HkfPFLiveCAmQ0hB+oYCWWwrSkJ5JpILz7ogBZYc1E+V9bCIozfFRPK+5eIbENhM
	 HPDET+qwlExvA2MHC633K1ld+Ha7g1c7hSPQlTOWdDij/dBnIU5OeiizDgM4DZxiI6
	 EWXELo9xXwAYzDG5WOaeNqp+u3DNr/QGHfWSfAcXL7xvlHmpEJEnnL8D6NoemHut6g
	 zmnjJFzIgw0/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/23] dmaengine: sdxi: Allocate administrative
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260511-sdxi-base-v2-7-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-7-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 02:20:08 +0000
Message-Id: <20260513022009.22A3EC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect error check for `dma_pool_zalloc()` allocation using the=
 DMA handle instead of the virtual address.
--

commit 67ceee55512586a3fbe30b9f642ed7c90819e736
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Allocate administrative context

This commit creates the control structure hierarchy in memory for the
per-function administrative context. It uses devres to queue the cleanup
since the admin context is a device-scope resource.

> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> new file mode 100644
> index 0000000000000..27821cfaf0311
> --- /dev/null
> +++ b/drivers/dma/sdxi/context.c

[ ... ]

> +/* Allocate a context and its control structure hierarchy in memory. */
> +static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
> +{

[ ... ]

> +	cxt->cxt_ctl =3D dma_pool_zalloc(sdxi->cxt_ctl_pool, GFP_KERNEL,
> +				       &cxt->cxt_ctl_dma);
> +	if (!cxt->cxt_ctl_dma)
> +		return NULL;

Could this incorrectly treat a valid allocation as a failure?

A DMA handle of 0 is a valid DMA address on many hardware platforms and
IOMMU configurations. If dma_pool_zalloc() succeeds and returns a DMA
address of 0, checking the DMA handle might falsely trigger this error
path and return NULL.

Should this check the returned virtual address (!cxt->cxt_ctl) instead,
similar to how the subsequent cxt_sts and write_index allocations are
validated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D7
