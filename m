Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9577171B1;
	Sat,  6 Jun 2026 00:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704760; cv=none; b=G6iBCzTaLHtASojAEQ3XKs8BeR+uxKXkl1wAT1kMaz+bH6EapFmeAIfMc6Q8fDZBdp/kA8ChlscO83n5T6gU5hoq4aoiNYhZbkedXEmE35QFwbrfYYQg+nGvZodc9Yrn6Gupr6SOrcrXiQhzTuL5Ly8+tfc0pnlv1vNKoaYAJQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704760; c=relaxed/simple;
	bh=011n+4hmv35WzogHcsbWt0FxC8Mi5Cja1cp4SfG4T4E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hfW3w5/55TD3ZNKVPqNXevUw1IkocgJUiZFDdwjrLuqEPaPBJLshQ30C3U0MplEZPdEmFMQGaFs4QUvBrr1JcCotc1PV4eqrSUWi2UUA9Xl91ntuL1qztidQRbm175jDmzcrYgU6iJ5nGwDYEfb6DUxW3LSuV0IQ8dRK4VRUXfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXaBAn5K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXaBAn5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1DF1F00893;
	Sat,  6 Jun 2026 00:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780704759;
	bh=swL97dqDEbCFeJeg5Re4xD96rCwhi/3ZYUte5BqTKCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aXaBAn5Ke81bT9YOHKvDcbMEig6OmlAk+7fxkcgc/EH0Hr8WLdJRWcB2Ww8oetgF8
	 4GX53ORPwRCRPO4RJd1szJy8s4g6AeFqAtZnql+FQVdmiJzTSDgByOxydpJJa5Qp3x
	 OBGb7pHlUbNBwvpIxlUrIPqyn7t3hQnEJ2Q14R9Lz1uXrAYeUW+4FA3QZ4PJ+7cWsM
	 3pPfjIVTdwAibN1B2JUEel3ff+OX94bTZ5GULtsz72NyHWxvR1AFV2Ua6RTQsbL8gd
	 i1sGK0RtlX8DODZQ8iAE2omQm+s5azAg0Yy08s64O10rrnz2eb25QH9ijzWjOkEW/R
	 dDicRx7g+My1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/23] dmaengine: sdxi: Complete administrative
 context jump start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260605-sdxi-base-v3-10-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-10-4d38ca2bdffe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:12:38 +0000
Message-Id: <20260606001239.6F1DF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing explicit device stop/reset on probe failure leads to DMA u=
se-after-free
--

commit 416e2a783d5f21c412d3a7e804c33d0f978dad21
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Complete administrative context jump start

This commit introduces a helper to push the administrative context
doorbell. It then updates the device activation sequence to start
the admin context by pushing this doorbell after the device becomes
active.

> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index e8f087f758fde..b875d8cdb58af 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
> @@ -269,7 +269,20 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
>  	 * SDXI 1.0 4.1.8.9: Set MMIO_CTL0.fn_gsr to GSRV_ACTIVE and
>  	 * wait for MMIO_STS0.fn_gsv to reach GSV_ACTIVE or GSV_ERROR.
>  	 */
> -	return sdxi_dev_start(sdxi);
> +	err =3D sdxi_dev_start(sdxi);
> +	if (err)
> +		return err;

[Severity: High]
This is a pre-existing issue, but does this error path in sdxi_fn_activate()
leave the hardware active while its DMA-mapped structures are freed?

If sdxi_dev_start() fails during initialization, such as by timing out while
waiting for the device to transition to the active state, the function
returns an error and the device probe fails.

The devres framework then executes cleanup actions in reverse order of their
registration. This causes devres to free the DMA-coherent memory allocated
for the L1/L2 tables and the admin context before it invokes the PCI cleanup
that calls pcim_disable_device() to stop bus mastering.

During this window, the hardware device has been commanded to become active
and retains the pointers to the now-freed DMA memory. If the device complet=
es
its transition and performs any DMA operations, could it corrupt freed kern=
el
memory and lead to a DMA use-after-free?

Should the device be explicitly commanded to stop or reset in the error
handling path before returning?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-sdxi-base-=
v3-0-4d38ca2bdffe@amd.com?part=3D10
