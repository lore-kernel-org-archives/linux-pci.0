Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39F1274FD1;
	Thu,  9 Jul 2026 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612020; cv=none; b=g0dvKjwkObNBjlcjzs8QwVUu721trEIdKOy9+lwiCfgqIymKi4M4PZijxI1P43w7bV+4lHIUXYq3+KTUwuLfY1rdNOkXc8dRnPOZB91nR023+gMtjQAFO4svOOm+h2tA/93nn/hYCgU63ZNhnGBiwsWWmoULAJ20MQAf9aggpns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612020; c=relaxed/simple;
	bh=rpTPAQO8B2j0SuxiCO2nTIwL6jv0aW/9C/ORSgLsHNU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mHjzCuYtWkwWXGNSnv3NYkjTlQEytM5cnzLC/dk9+q3z7NeN/zRMC6UT3HOvW5/7udkHo57I82nqfhl1w3A1/1pL1m9InGYTDjdOz8NWGfA3RE5PEJi1HbGRv8+ZNuQ0wFs8OnEHPBVH4fH7z4uDGIePSCNWXBfU8RM3SnO1JAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muERIO6C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muERIO6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522331F000E9;
	Thu,  9 Jul 2026 15:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783612019;
	bh=hia3ZzYxJbVWfdQouoVfTdODNDb+brOfP3M+wdoFBgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=muERIO6CROCHEuaOf/YBVq8CSscsrqqNMR+wpAwAJuPhWeoTqNuRhb76dTzkEqXn7
	 3m248FV4UZfrt9Zg7+RMrEBDIBRcjvWiXkwv3Ta/2Cb8OiQt3ZNsjicd70hrp/uUz7
	 650HEgUwfYjhHSp7TtXQy0UXnew89N8t0pxXNJO93SCz0DOR9YY5cJgwvoEXBQPX8u
	 iRPYLhNgH8H7eeeP0ytdl20gMj9xltsGCRiquwJaKyATyoX3/cE+Ktw2zq0E1QssmQ
	 N1+UaT2+KMd4fx8Sw2at1ISNrOglh1K+03Pm/vgDobKf+bHYqepaHnNdz/C2Gbdd+R
	 CX+TIi1B7v6ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/10] dmaengine: dw-edma: Use common
 dw_edma_core_start() for both eDMA and HDMA
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260709-edma_ll-v5-8-e199053d4300@nxp.com>
References: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
 <20260709-edma_ll-v5-8-e199053d4300@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:46:58 +0000
Message-Id: <20260709154659.522331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition and lockdep violation in dw_edma_device_resume via =
lockless virt-dma list access
--

--- Patch [8]: [PATCH v5 08/10] dmaengine: dw-edma: Use common dw_edma_core=
_start() for both eDMA and HDMA ---
commit bffbb7894cff6d55d1d7037fe698320bf5288b87
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Use common dw_edma_core_start() for both eDMA and HDMA

This patch consolidates the eDMA and HDMA start routines by introducing a
common dw_edma_core_start() function. It removes the now-redundant start
callbacks from the eDMA and HDMA core structures.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 2652ad8e7a8f6..f52d9fd18e573 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c

[ ... ]

> @@ -183,7 +211,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan=
 *chan)
>  	if (!child)
>  		return 0;
> =20
> -	dw_edma_core_start(dw, child, !desc->xfer_sz);
> +	dw_edma_core_start(child, !desc->xfer_sz);

[Severity: High]
This is a pre-existing issue, but can this lead to a race condition and
lockdep splat when called from dw_edma_device_resume()?

When the client driver calls dmaengine_resume(), it reaches
dw_edma_device_resume(). This function evaluates if the channel is paused,
and calls dw_edma_start_transfer() without acquiring chan->vc.lock:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_resume() {
	...
	} else {
		chan->status =3D EDMA_ST_BUSY;
		dw_edma_start_transfer(chan);
	}
}

Inside dw_edma_start_transfer(), vchan_next_desc() is called, which
immediately trips lockdep_assert_held(&vc->lock).=20

If an in-flight or delayed interrupt triggers dw_edma_done_interrupt()
concurrently, both paths may execute dw_edma_start_transfer() simultaneously
on the same descriptor, which could result in double list_del() and kfree()
on the chunk.

Should dw_edma_device_resume() take the chan->vc.lock before calling
dw_edma_start_transfer()?

>  	desc->xfer_sz +=3D child->xfer_sz;
>  	dw_edma_free_burst(child);
>  	list_del(&child->list);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-edma_ll-v5=
-0-e199053d4300@nxp.com?part=3D8
