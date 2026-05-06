Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56E030DD1C
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 21:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778103545; cv=none; b=VhcdgdKgKIUECrWCYLRko/Rs8kwKrFHQdpPrxmzuxeSJeaiTCDRUURk5nMqmdRChjck2MCqN5z58XpPaCsq9G4Xfw6O+vzkcc9lTyGpbSW32LNyg+79XSkX28WK9aJS2FsiYh4gYg0+BmPqOSdcWezN/XeeGf16Tg9KAY/tc/bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778103545; c=relaxed/simple;
	bh=fgm1VB5hMDEWMYRVyBNiGO46LvPuKc6Cthgp19m9ozM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WWKFz9xv3LWKAuOBftIvCFqlkYJgJV+hyf10w0Wnvbo6y8kIPe4dCrCh8I48yXE3gMdE5w4RCsRna2vuV8UrY12gjo3n/qXo9FBU7cY4baDTnWLFBQ9Irgc4Kks9eRG/Ru/4NPG/YN5/6k+Yj37ScDNkpWMrPE7rIGBxLm8rSC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLhjzHJt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLhjzHJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB8BC2BCB0;
	Wed,  6 May 2026 21:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778103545;
	bh=fgm1VB5hMDEWMYRVyBNiGO46LvPuKc6Cthgp19m9ozM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YLhjzHJtqMTeH9u7pfhzMfJff4Wz/GXm2JVJU21kR11h7HVR2tgytU3Pkz8L1YFib
	 X/k/Yz/oiArb4cwlwofkuw9WyvvI5p/ds8A41siBd9iZgh7pR8Utd5qUhjlthIsSlf
	 u2RSvLJuQUFpwp8BW0OJJHaui7oy+Og4rjS1TcBvkZamogftSM5FbnhD7fVIUz2hka
	 o7yfzCvxYiSVFEfAMb4Cyl6ihJqRf+ovdImYpgpE6FRa9P5Z1AazEWn86eRDVhJD82
	 eKvHnkCfv3isQSH7MVCvYH2zfWwFH7gQz0cBKvQCG1KS0o5JzEP9wTWVYesQlL5CyM
	 uT29rJWI/JWcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/9] dmaengine: Add API to combine configuration and
 preparation (sg and single)
Reply-To: sashiko@lists.linux.dev
To: "Frank Li" <Frank.Li@nxp.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260506-dma_prep_config-v4-1-85b3d22babff@nxp.com>
References: <20260506-dma_prep_config-v4-1-85b3d22babff@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 21:39:04 +0000
Message-Id: <20260506213905.1CB8BC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The implementation contradicts the commit message regarding the =
fallback behavior when config is NULL.
- [Low] Device configuration side effects are applied before verifying if t=
he channel supports the preparation callback.
--

commit ba8a363576907f3e47dc9c928c997d667ec117f9
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: Add API to combine configuration and preparation (sg and single)

This commit introduces combined API functions for DMA configuration and
preparation to simplify operations where parameters must be adjusted per
transfer. It adds dmaengine_prep_config_single() and
dmaengine_prep_config_sg(), along with a new device_prep_config_sg
callback.

> Previously, configuration and preparation required two separate calls. Th=
is
> works well when configuration is done only once during initialization.
>
> However, in cases where the burst length or source/destination address mu=
st
> be adjusted for each transfer, calling two functions is verbose and
> requires additional locking to ensure both steps complete atomically.
>
> Add a new API dmaengine_prep_config_single() and dmaengine_prep_config_sg=
()
> and callback device_prep_config_sg() that combines configuration and
> preparation into a single operation. If the configuration argument is
> passed as NULL, fall back to the existing implementation.

This isn't a bug, but the commit message description doesn't exactly match
the implementation.

Looking at the code, if a driver implements the new device_prep_config_sg
callback, it will be called unconditionally, even if the config argument is
NULL. It does not fall back to the existing implementation in that scenario.

While the code behavior appears structurally correct (since drivers moving
to the new API might remove their old device_prep_slave_sg callback), could
the commit message be updated to clarify this? Clarifying that config can
be NULL might prevent driver authors from assuming it is always valid,
avoiding potential null pointer dereferences.

> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index b3d251c9734e9..defa377d2ef54 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h

[ ... ]

> @@ -974,22 +979,44 @@ static inline bool is_slave_direction(enum dma_tran=
sfer_direction direction)
>  	       (direction =3D=3D DMA_DEV_TO_DEV);
>  }
> =20
> -static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_singl=
e(
> -	struct dma_chan *chan, dma_addr_t buf, size_t len,
> -	enum dma_transfer_direction dir, unsigned long flags)
> +static inline struct dma_async_tx_descriptor *
> +dmaengine_prep_config_single(struct dma_chan *chan, dma_addr_t buf, size=
_t len,
> +			     enum dma_transfer_direction dir,
> +			     unsigned long flags,
> +			     struct dma_slave_config *config)
>  {
>  	struct scatterlist sg;
> +
> +	if (!chan || !chan->device)
> +		return NULL;
> +
>  	sg_init_table(&sg, 1);
>  	sg_dma_address(&sg) =3D buf;
>  	sg_dma_len(&sg) =3D len;
> =20
> -	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
> +	if (chan->device->device_prep_config_sg)
> +		return chan->device->device_prep_config_sg(chan, &sg, 1, dir,
> +							   flags, config);
> +
> +	if (config)
> +		if (dmaengine_slave_config(chan, config))
> +			return NULL;
> +
> +	if (!chan->device->device_prep_slave_sg)
>  		return NULL;

Does this apply device configuration side effects before verifying if the
channel actually supports the preparation callback?

If device_prep_slave_sg is missing, the function correctly aborts and
returns NULL. However, the hardware or software channel state might have
already been mutated by the earlier dmaengine_slave_config() call on a
channel that cannot actually process the transfer.

Would it be safer to check for the presence of device_prep_slave_sg before
attempting the configuration fallback?

[ ... ]

> @@ -1010,17 +1037,37 @@ static inline struct dma_async_tx_descriptor *dma=
engine_prep_peripheral_dma_vec(
>  							    dir, flags);
>  }
> =20
> -static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
> -	struct dma_chan *chan, struct scatterlist *sgl,	unsigned int sg_len,
> -	enum dma_transfer_direction dir, unsigned long flags)
> +static inline struct dma_async_tx_descriptor *
> +dmaengine_prep_config_sg(struct dma_chan *chan, struct scatterlist *sgl,
> +			 unsigned int sg_len, enum dma_transfer_direction dir,
> +			 unsigned long flags, struct dma_slave_config *config)
>  {
> -	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
> +	if (!chan || !chan->device)
> +		return NULL;
> +
> +	if (chan->device->device_prep_config_sg)
> +		return chan->device->device_prep_config_sg(chan, sgl, sg_len,
> +				dir, flags, config);
> +
> +	if (config)
> +		if (dmaengine_slave_config(chan, config))
> +			return NULL;
> +
> +	if (!chan->device->device_prep_slave_sg)
>  		return NULL;

This has the same potential configuration side effect ordering issue as
dmaengine_prep_config_single() above. Should the device_prep_slave_sg check
happen before calling dmaengine_slave_config()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506-dma_prep_c=
onfig-v4-0-85b3d22babff@nxp.com?part=3D1
