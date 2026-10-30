Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373669;
	b=IWGPux4yDIXwgJQTJA15bq+4SAo7vZpk62ihRON7Kgtr4DsCsvyZ6B/X9undo+AflwT4
	 lyRRvDR5inIiewgHzZU6W+P6i/bOLVTjjx8V248uK681wyNgY5S3Ga7S2TLYwzV7dX+v7
	 rnFrMYSWzgiIcJWZ5+cbqGd8kirJG2tu5cMyTSd6a1qi94pGtKm7L3vC6HLHgeM0pQ8PS
	 zImpqsWJ8cae9vYNLWG370fRpWd10TZr6qQLJ6FLnxOIzoi9kBRysWMkY82QtVKUjxFKW
	 vk8hmC5PoB+CtiICW2YePs0jcqKBsXhiDYw9Wxm4hMlvYUnhF50KurtOBm8ezNTuvpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373669;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AEmwirg2N+MYyFC3UFJdbyP92DW9FOyPFo6hEKBZTqA=;
	b=RbXJ4OHWaHboADw2MVgV62suSeqGrVMoBMWTwWjFi5SaWNWjXYd02Tjse3awt1Dbdz/q
	 uyszmzPknHb4JuUiFfTvrRkhJtieVT1pk7eRrkz6vtZyaN64IJJ2z+IJhQXZPVWwmiIC6
	 lEY1XdtpYMecy0SSusPWA594QzsYBIvj9ObTZohIZr5uO/17G5nYgHbaTaCa0Iky8g0f/
	 TsFH5lNQvl3zFCG9CB7QLu9lqPI2AVYMFfZED7qWkp3D6QTg0n3rgnHsOfeBZl/kMTLKJ
	 uXUOrohtX3fyXcwpp6D5c/BAf2WHJVeR0y3xDOl00zG7jX6T8K5zpAnlYbTW8FMwUhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hjGHgaTU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE81606A31E;
	Fri, 30 Oct 2026 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hjGHgaTU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FE11F00A02;
	Fri, 30 Oct 2026 15:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373668;
	bh=AEmwirg2N+MYyFC3UFJdbyP92DW9FOyPFo6hEKBZTqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hjGHgaTU1gzina+KAiGPMDmMo5RmoIDYtYCC8Y501EAHELELhya/inqoXjwlUdxWy
	 rIgo3dAKdoBq42UpAIHV/PMWeze9BuG8ZtDMAJirfaihZEZ0Ba/CZIQVGaS/c7nSXq
	 ajiL87pVbLsvToGDYLGGGUfET+I6EITA1iIWpgh0Y/a5E1ByMAcA5TRhata6uXz5k8
	 sxv4YiC/ah+GACbPYfMGRr4FOZziPImVo5mXQkUnO6Y8iZ0uF/6RxBebI+m4U/ue/h
	 yYn+lcIj3Vn9DliBwZpcP11xiCCMVcfmQWDizrtb2B+NiUi7holZgeZjh5JWfJdNYl
	 EPwC57nH3FPWw==
Message-ID: <sashiko-outbox-191157@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/5] dmaengine: dw-edma: Use HDMA watermark
 interrupts as LL progress
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261030150742.2586776-4-den@valinux.co.jp>
References: <20261030150742.2586776-1-den@valinux.co.jp>
 <20261030150742.2586776-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:21:08 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dmaengine: dw-edma: non-LL watermark unmasked in dw_hdma_v0_core=
_int_setup()
--

commit 5e1e3ed55b7d4e9a83bc0d3c9ec3bbccd4a0395c
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma: Use HDMA watermark interrupts as LL progress

This commit enables HDMA watermark interrupts on linked-list entries that
request an interrupt, configures local or remote interrupt delivery, and
routes watermark events to the linked-list progress handler.

> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/=
dw-hdma-v0-core.c
> index aa430219d0af2..7ca5afa181fe5 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -58,7 +58,8 @@ static u32 dw_hdma_v0_core_int_setup(struct dw_edma_cha=
n *chan, u32 val)
>  {
>  	val &=3D ~(HDMA_V0_LOCAL_ABORT_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN |
>  		 HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_REMOTE_STOP_INT_EN |
> -		 HDMA_V0_ABORT_INT_MASK | HDMA_V0_STOP_INT_MASK);
> +		 HDMA_V0_ABORT_INT_MASK | HDMA_V0_WATERMARK_INT_MASK |
> +		 HDMA_V0_STOP_INT_MASK);
> =20
>  	/*
>  	 * HDMA_INT_STATUS.STOP and .ABORT are latched only when LSIE and
> @@ -68,10 +69,14 @@ static u32 dw_hdma_v0_core_int_setup(struct dw_edma_c=
han *chan, u32 val)
>  	 */
>  	val |=3D HDMA_V0_LOCAL_ABORT_INT_EN | HDMA_V0_LOCAL_STOP_INT_EN;
> =20
> -	if (chan->irq_mode =3D=3D DW_EDMA_CH_IRQ_REMOTE)
> +	if (chan->irq_mode =3D=3D DW_EDMA_CH_IRQ_REMOTE) {
> +		if (!chan->non_ll)
> +			val |=3D HDMA_V0_WATERMARK_INT_MASK;
> +
>  		val |=3D HDMA_V0_REMOTE_ABORT_INT_EN |
>  		       HDMA_V0_REMOTE_STOP_INT_EN |
>  		       HDMA_V0_ABORT_INT_MASK | HDMA_V0_STOP_INT_MASK;
> +	}
> =20
>  	return val;
>  }

[Severity: Medium]
In dw_hdma_v0_core_int_setup(), HDMA_V0_WATERMARK_INT_MASK is unconditional=
ly
cleared at the start of the function, unmasking the local watermark interru=
pt
pin. Later, it is only set back to 1 (masked) when chan->irq_mode is
DW_EDMA_CH_IRQ_REMOTE and !chan->non_ll.

When a channel is started in non-LL mode via:

  dw_edma_device_issue_pending()
    -> dw_edma_start_transfer()
      -> dw_edma_core_start()
        -> dw_hdma_v0_core_non_ll_start()
          -> dw_hdma_v0_core_int_setup()

chan->non_ll is true, which leaves HDMA_V0_WATERMARK_INT_MASK cleared (0,
unmasked) in both DW_EDMA_CH_IRQ_LOCAL and DW_EDMA_CH_IRQ_REMOTE modes.

In remote IRQ mode, all local interrupt pins are expected to be masked. In
addition, if a watermark interrupt fires on a non-LL channel (for instance,=
 if
the hardware watermark_en register is non-zero), dw_hdma_v0_core_handle_int=
()
will report DW_EDMA_IRQ_PROGRESS, causing dw_edma_done_interrupt() to
prematurely complete the active non-LL burst while the channel is still
running.

Should HDMA_V0_WATERMARK_INT_MASK be set whenever chan->non_ll is true or
chan->irq_mode =3D=3D DW_EDMA_CH_IRQ_REMOTE, so that local watermark interr=
upts
are only unmasked for LL channels in local IRQ mode?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030150742.2586=
776-1-den@valinux.co.jp?part=3D3
