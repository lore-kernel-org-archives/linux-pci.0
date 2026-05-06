Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264953101A7
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778110273; cv=none; b=ms67sMxfw2NQV2RmmlWa8wCeDoH5YTyrggoAO4MZ8FoXQvG4pLEhtaz6JwJgmeB9pLYTmJ5wjXRhU1AIko0RTuewcW3a9L9F/JCDtElv0EGwloVAby5LuR5ADl3J1qRpCDHOWLjjPQVjb2pNcbxktigsxZ6nV1DGlWjO7KfU1uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778110273; c=relaxed/simple;
	bh=WDRtaiHJDNouq2a9RNbKkwQg+pk/9GWDs5IpEqe7Xh4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U/04JW2CRa3Fqi3ppRcK77QlaBxXaL3hAAaB3YR+m5jD+VKMslvStGCGowajCdQwnn5t1mbvjvr9p1A+wE25TnVDhgJTKG1YL3cxRba/DnAOTpztjd/kQy1jHdLN0mow696kbgqo9l/lhHnyeA7TXgEa20fWHJWNtvTgh+ei6Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIW+U9KM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIW+U9KM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4EFC2BCB0;
	Wed,  6 May 2026 23:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778110273;
	bh=WDRtaiHJDNouq2a9RNbKkwQg+pk/9GWDs5IpEqe7Xh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cIW+U9KMvJRfnLXFnhlhA5ShtABCvIJHvPSI9VPju8rC1TyeZTxATdix/+GNWpaUd
	 e9CZgarZdDBIRKoiH8gPGuXF9ZFccR8MzKWo1/4QfapK14ufgB0YoW+DCiazM3mpvM
	 y7o7B8jPJxPH5YQHrba5sqa70i3kg7RB1wjU//fE8dp8PR5A7Aw3E6rnG6HmC3GWU6
	 G+58gc6LCnNNCLlH7uXDUAHzuGKELbYJmX0eqOosq/4T8x5NRYwxK6Hk1ShccVl/oh
	 rYJtYU5G52zvzXe5LXbVMTQ6GNzVAFFFgM8Ny46Toemz9usqLcE0/hx2XiNIX0iPhw
	 Vu7ImtIq2WZFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 9/9] crypto: atmel: Use
 dmaengine_prep_config_single() API
Reply-To: sashiko@lists.linux.dev
To: "Frank Li" <Frank.Li@nxp.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260506-dma_prep_config-v4-9-85b3d22babff@nxp.com>
References: <20260506-dma_prep_config-v4-9-85b3d22babff@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 23:31:12 +0000
Message-Id: <20260506233112.CF4EFC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The commit message incorrectly references `dmaengine_prep_config=
_single()` instead of `dmaengine_prep_config_sg()`.
- [Medium] DMA configuration errors are masked as Out-Of-Memory (-ENOMEM) e=
rrors, contradicting the 'No functional change' claim.
--

commit 321a15c31b7c3672b47256b90654c736d1c61477
Author: Frank Li <Frank.Li@nxp.com>

crypto: atmel: Use dmaengine_prep_config_single() API

This commit updates the atmel-aes driver to use a combined DMA preparation =
API
instead of calling configuration and preparation functions separately. The
commit message claims there is no functional change.

> crypto: atmel: Use dmaengine_prep_config_single() API
>=20
> Using new API dmaengine_prep_config_single() to simple code.

This isn't a bug, but the commit message references
dmaengine_prep_config_single() here and in the subject line, while the actu=
al
code uses dmaengine_prep_config_sg().

> diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
> index b393689400b4c..d890b5a277b9c 100644
> --- a/drivers/crypto/atmel-aes.c
> +++ b/drivers/crypto/atmel-aes.c

[ ... ]

> @@ -820,12 +819,9 @@ static int atmel_aes_dma_transfer_start(struct atmel=
_aes_dev *dd,
>  		return -EINVAL;
>  	}
> =20
> -	err =3D dmaengine_slave_config(dma->chan, &config);
> -	if (err)
> -		return err;
> -
> -	desc =3D dmaengine_prep_slave_sg(dma->chan, dma->sg, dma->sg_len, dir,
> -				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	desc =3D dmaengine_prep_config_sg(dma->chan, dma->sg, dma->sg_len, dir,
> +					DMA_PREP_INTERRUPT | DMA_CTRL_ACK,
> +					&config);
>  	if (!desc)
>  		return -ENOMEM;

The commit message mentions "No functional change", but does this alter the
error code propagated on configuration failures?

Previously, if dmaengine_slave_config() failed, its specific error code was
returned directly to the caller. Now, dmaengine_prep_config_sg() internally
calls dmaengine_slave_config() and returns NULL on failure, which is
unconditionally mapped to -ENOMEM here.

Could this lead to DMA configuration errors being incorrectly reported as
out-of-memory errors to the upper crypto layers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506-dma_prep_c=
onfig-v4-0-85b3d22babff@nxp.com?part=3D9
