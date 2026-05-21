Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735E222332E;
	Thu, 21 May 2026 00:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779323522; cv=none; b=t8PCLoicX4Cwh92Ya/4ubNTuR6oqe3ox89qCMtlCWbbC+dFX+T0bMOdHiJUKQhu7PkYSQlD6Ykv6vDBiCD3LWbSI6/xbf7BBjt75rRmbCqpRObKcZ0wDITIH50uLz6dR3bVBkZ7ODgDHYsNj7kBqCGFluk+li8+9p94yQH6CEY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779323522; c=relaxed/simple;
	bh=IyBba+hARjxB1CZd3SNiua7WkbuaypKLi8pjtkbyoqM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rdTr4xjLRLRisBYFq0fo5ZTg1XfCBozVvNAQkQMtVL4WdKTJmiecNQB3hIgh6tnQW5qDQLsb+jsMUBCF6Rh1EBbIMmcCbC5HBE5x7q7P0ZGR9L2+4UoZNeq+x6ppiMBMG7KaUi8Poamu05315Pte1s/3+PegZAv7FX+oiTzRIJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+bStMkm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+bStMkm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88F11F000E9;
	Thu, 21 May 2026 00:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779323519;
	bh=B6HaYejqBYs36ZchYaYwGRtS8hgXdSXwNSnnFxZoYXk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S+bStMkm2cUFJVfiNsk0ne+i3xXxWhcDU2YIA2hTLkMCfWbDGNf1xGtYJPK2vz1Xg
	 3wUMXjnwU5yqHp+KKpqCKWFZHasyJq/q4EoqyG9aMtrR9WLKMlrEDR0wJzr0o/wJ9G
	 l+Xf9VhtwqZVA2wOaa7wGcB6umggXFkngiMNW6wDdAk5XVZ7MIKu1igs9of6tMpXLI
	 Y7X3wWsBT6jQdlE01HK1l95RbTgY7GyN88ZC7grLdfXm9n85rXl6TIqPddPSoCdREC
	 k+fLzq7viZgtjKfDNpEXREuroJFpuPA96WEo7BbqGAQF7+cPbASEDzWo5tZrhTxIjK
	 lgKJJMz2yTxlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/9] dmaengine: dw-edma: Use new
 .device_prep_config_sg() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org
In-Reply-To: <20260520-dma_prep_config-v6-4-06e49b7acb38@nxp.com>
References: <20260520-dma_prep_config-v6-4-06e49b7acb38@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 00:31:59 +0000
Message-Id: <20260521003159.A88F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added `dw_edma_device_prep_config_sg` callback modifies =
shared channel state locklessly, violating dmaengine API atomicity guarante=
es and potentially corrupting active hardware transfers.
--

commit 3f734236aec2497e34a2baf98f60bcd0cd1c6525
Author: Frank Li <Frank.Li@nxp.com>
dmaengine: dw-edma: Use new .device_prep_config_sg() callback

This commit replaces the device_prep_slave_sg callback with the new
device_prep_config_sg callback to combine configuration and descriptor
preparation.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index c2feb3adc79fa..92572dd8131e6 100644
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
> +	if (config && dw_edma_device_config(dchan, config))
> +		return NULL;

[Severity: High]
Does this introduce a data race on the shared channel state?

By implementing the device_prep_config_sg callback, the driver bypasses
the dmaengine core's per-channel spinlock, which normally protects
configuration and preparation.

However, dw_edma_device_config() modifies global channel state locklessly:

static int dw_edma_device_config(...)
{
        ...
        chan->non_ll =3D false;
        ...
        if (cfg_non_ll || non_ll)
                chan->non_ll =3D true;
        ...
        memcpy(&chan->config, config, sizeof(*config));
        ...
}

If multiple threads queue transfers concurrently, could this corrupt the
descriptor configuration?

More importantly, if a new transfer is prepared while the channel is active=
ly
executing, the interrupt handler might read the momentarily cleared or
overwritten chan->non_ll.

Could this cause the interrupt handler to invoke the wrong hardware routine
and desynchronize the hardware state?

> +
>  	return dw_edma_device_transfer(&xfer);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520-dma_prep_c=
onfig-v6-0-06e49b7acb38@nxp.com?part=3D4
