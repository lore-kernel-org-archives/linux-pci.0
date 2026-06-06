Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2451C199385;
	Sat,  6 Jun 2026 00:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780705370; cv=none; b=hAnUxdYxEwVQ2iM4dEoChB4tE+fF+NzUxT2UjXxikMrCCt0hpoPkOTp+bty09i8oXT93RdpcWK72JiTFQbCDiyPPUM6IvHU2bIp729d0Zr7Euk8Al5UW+c4RJo2W113tLCHSSngHEk9J45du67Z84OEfIxvk3lDDD4RGQspEPDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780705370; c=relaxed/simple;
	bh=jB5iNEmDjf6EW9KcP+YJLwWKvrfcpWkMTGgIt7zKDpU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=agw/JPybPQ0pQMm2yV10O+ChuS0QMzmN3NS2YF91PPQjYJI+IAT5GcTaCPXZOPTwJPXqAVor385HhGVvazeQREfkRvdiAanbX1eFjxJS2y2bJVJh9reVu+QWEl2SkLJ0UXPz2fWwl+AorU/L4c4Zhd+CB3t0uj8A/QWB4Gl+9yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avy6G10z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avy6G10z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDA71F00893;
	Sat,  6 Jun 2026 00:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780705368;
	bh=DBfD3CfCkfF8zT8GCRswpOw+X+oxnk7tG8v487CC6wQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=avy6G10zMSnjoYj90qE15tlgdFSum+fBWgGmxi7iycVB7OgvKHJcRLpTYDzAH2wrp
	 sILHQ2lqxNWErZ0b5Nfru1iv2xoOtoVff0pcg1VXDUTfyQ/lHEFYcHgd9/WtCiPBPl
	 9ky/BfK+ezvaLb93gfVa3LMggGkv5FAuQvxdlNMRAmKVgytpqTPgrEq031HhLTGG9I
	 vvtKHXki4tsHIhB9GFieE7XdXMdJCbnsgIJbFfMek8dH1H5EFeK5ybkpkqxrsXFVpO
	 fmpiw3T/Zw4TzJyp+I8+EgfCoWBinZH3pInlVs3IdIH7hLwobOxWv7jinyySfDh647
	 IYI1HWz1ioVzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 19/23] dmaengine: sdxi: Provide context start and
 stop APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260605-sdxi-base-v3-19-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-19-4d38ca2bdffe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:22:48 +0000
Message-Id: <20260606002248.8BDA71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Silent failures in `sdxi_stop_cxt` do not stop the hardware bu=
t provide no error to the caller, leading to subsequent use-after-free of c=
ontext resources.
- [High] DMA memory use-after-free triggered by `sdxi_completion_poll` time=
out in `sdxi_start_cxt` and `sdxi_stop_cxt`.
--

commit 6a36436cc92c4877bfb050c28457f1ac8dbaf6a2
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Provide context start and stop APIs

This commit introduces high-level context start and stop APIs for SDXI.
These APIs encapsulate submitting administrative descriptors and waiting
for completion signaling.

> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index 9b0984842d9a7..afd3414163428 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c

[ ... ]

> +int sdxi_start_cxt(struct sdxi_cxt *cxt)
> +{
> +	struct sdxi_cxt *adm =3D to_admin_cxt(cxt);
> +	struct sdxi_desc *desc;

[ ... ]

> +	sdxi_completion_attach(desc, sc);
> +	sdxi_desc_make_valid(desc);
> +	sdxi_cxt_push_doorbell(adm, sdxi_ring_resv_dbval(&resv));
> +
> +	return sdxi_completion_poll(sc);
> +}

[Severity: High]
If sdxi_completion_poll() times out here, does this return early and
trigger the scope-based cleanup of the sdxi_completion structure?

If the hardware operation is just delayed and not actually aborted, could
the hardware later write to this completion block address after it has
been freed back to the DMA pool?

> +void sdxi_stop_cxt(struct sdxi_cxt *cxt)
> +{
> +	struct sdxi_cxt *adm =3D to_admin_cxt(cxt);
> +	struct sdxi_desc *stop, *sync;
> +	struct sdxi_ring_resv resv;
> +	int err;
> +
> +	might_sleep();
> +
> +	struct sdxi_completion *sc __free(sdxi_completion) =3D
> +		sdxi_completion_alloc(cxt->sdxi);
> +
> +	if (!sc)
> +		return;

[Severity: Critical]
Since sdxi_stop_cxt() returns void, do these silent early returns leave
the caller unaware that the hardware context was never actually stopped?

If a caller proceeds to tear down the context and free its backing
descriptor ring and memory, could the active DMA engine continue processing
descriptors and corrupt memory?

> +	/* This is not how to stop the admin context. */
> +	if (WARN_ON(adm =3D=3D cxt))
> +		return;
> +
> +	err =3D sdxi_ring_reserve(adm->ring_state, 2, &resv);
> +	if (WARN_ON_ONCE(err))
> +		return;

[Severity: Critical]
Similarly, if reserving space in the admin ring fails here, the function
returns silently without stopping the hardware. Could this lead to the same
scenario where context memory is freed while still in use by the hardware?

> +	stop =3D sdxi_ring_resv_next(&resv);
> +	sync =3D sdxi_ring_resv_next(&resv);

[ ... ]

> +	sdxi_completion_attach(sync, sc);
> +	sdxi_desc_make_valid(stop);
> +	sdxi_desc_make_valid(sync);
> +	sdxi_cxt_push_doorbell(adm, sdxi_ring_resv_dbval(&resv));
> +
> +	WARN_ON(sdxi_completion_poll(sc));
> +}

[Severity: High]
Just as in sdxi_start_cxt(), if the poll function times out here, does the
early return free the in-use DMA memory without aborting the pending DMA
stop/sync operation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-sdxi-base-=
v3-0-4d38ca2bdffe@amd.com?part=3D19
