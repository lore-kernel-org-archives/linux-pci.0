Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8C39460;
	Fri, 17 Jul 2026 22:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784327809; cv=none; b=gLPrzyWpXVEKbb6r07Pv9gfLA5ST80eqCXWw27WAFuQuK0uGB7ru6w34z+t4ifbeAXFusqIC8hmtej5EW2RVR/+j8D17RO/20T17f1jeo++cCu9WbnAeMhJ67tAcCPD6y+t3dVu2XJREYfYdD0owTiWaFJJ/HTrhfolBujTqtjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784327809; c=relaxed/simple;
	bh=M/fbP72IEhNOynbdD3VTnam1+q2EHGXoTDXoFtuyXQc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lcQjQLzv2tCj0OvzUF54+LXq4v+Lq7XhTEbzxaIPk3dmCTxv6kKmIKtwyZrFcJeZd3tdrfSgSlMEjaBNgMeCMXa6xCc/IpSyLoWvS8FNf8XKgZa0Y5zKQqMH+QdFuiYvnFdf/S95p6T+2MH1EEDO1qUWAjlnhp9JFBA21Kag4QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEfgu8Vx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEfgu8Vx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A051F000E9;
	Fri, 17 Jul 2026 22:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784327808;
	bh=B9tp015uQ1JtgSxgrw8uH7ANCfP+jP3J66t8C2bACxA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YEfgu8VxTSVBODxvU4yTgJVZ6N0aQcCy++cGuIdsvhoXuns0LO8NotuoTn6SsvcB8
	 3n6J3yXQ4L3nsCH3GrHuuW5VBYprgCDC2/XWJPHZHeVseIT7SZhkh1/dDd8GJoizwy
	 cU/edAKWTOtGY14oMO18Vlps4WPmwObAf/YXzcjfj/BlSXS+zQ1fG/LnFqYHx3W0o8
	 3oDImduzpn61hk9HxTgyrfqqBk5Oj17eku1CUVMKSX4BU23+daeyrgALlBGRkPruLL
	 Xt9NIF8oAyR0hFq08El40ntSIYybi+j/I3f0cwkbCb+KM/POuFDAivpSQVUagJX/t6
	 GLU8Jl8LtORug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/6] dmaengine: switchtec-dma: fix resource leak in
 alloc_chan_resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260717221001.361421-3-logang@deltatee.com>
References: <20260717221001.361421-1-logang@deltatee.com>
 <20260717221001.361421-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 22:36:47 +0000
Message-Id: <20260717223647.F0A051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The error path in switchtec_dma_alloc_chan_resources() frees descr=
iptor rings without halting the hardware channel or clearing DMA base addre=
sses, leading to a potential DMA use-after-free.
--

--- Patch [2]: [PATCH v1 2/6] dmaengine: switchtec-dma: fix resource leak i=
n alloc_chan_resources ---
commit eaf75ddb364eba320691aad49bebc8922067a94b
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix resource leak in alloc_chan_resources

This commit adds an error-unwind path to switchtec_dma_alloc_chan_resources=
()
to handle failures during initialization. It disables the channel and frees
the descriptor rings to prevent resource leaks when setup fails.

Link: https://lore.kernel.org/dmaengine/20260707165555.350951F000E9@smtp.ke=
rnel.org/T/#u

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c

[ ... ]

> @@ -988,15 +988,15 @@ static int switchtec_dma_alloc_chan_resources(struc=
t dma_chan *chan)
>  	rc =3D reset_channel(swdma_chan);
>  	if (rc)
> -		return rc;
> +		goto err_disable_channel;
> =20
>  	rc =3D unhalt_channel(swdma_chan);
>  	if (rc)
> -		return rc;
> +		goto err_disable_channel;

[ ... ]

> +err_ring_inactive:
> +	spin_lock_bh(&swdma_chan->submit_lock);
> +	swdma_chan->ring_active =3D false;
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +
> +	spin_lock_bh(&swdma_chan->complete_lock);
> +	swdma_chan->comp_ring_active =3D false;
> +	spin_unlock_bh(&swdma_chan->complete_lock);
> +err_disable_channel:
> +	disable_channel(swdma_chan);
> +err_free_desc:
> +	switchtec_dma_free_desc(swdma_chan);
> +	return rc;
>  }

[Severity: High]
If unhalt_channel() times out and returns an error, we jump here and free
the descriptor rings. Does this risk a DMA use-after-free?

Looking at disable_channel(), it merely clears an enable bit via a posted,
unflushed PCIe write. Because this unwind path skips switchtec_dma_chan_sto=
p()
(which is used in the normal teardown path to synchronously halt the channel
and clear the base registers), couldn't the hardware complete the unhalt
command and access the descriptor rings right after they are freed?

Should this error path ensure the channel is fully stopped and DMA base
addresses are cleared before freeing the coherent DMA memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717221001.3614=
21-1-logang@deltatee.com?part=3D2
