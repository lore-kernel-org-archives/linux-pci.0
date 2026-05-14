Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9F925B0BA;
	Thu, 14 May 2026 01:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723370; cv=none; b=a08nzKLZ0qBtiPsrzlWfc8az84NwIrdB2prVn21Ck2ETORkwW/Fq13DzpoHgWHdfSquAR08hWZfPvP/rxkC7HWwLfZ1jvXpTtWRDgxDD2qSswycuAMoDNChUItLOtXZdD15r998siqZZ5TOe6Zcck5g2tvenWHL8zsgWOv9G9DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723370; c=relaxed/simple;
	bh=mhIgowFJ/NsjjgimUMPdzodKvuhjEXH3/32vBatMPR8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dFnQu4lJfkz1eqdJ4yUcv1iLoiTlZswu7d8QbpTVpeCF7mKViIBOGV7CuKTO4ceOUwUGXG7i0gatbaf2V1+i+VKmoGM8sPj4TkEY19aqQ2UIWzaO1IuQ+ifbulEh+5369PHtXK1A6fD4hjmCInrh+7zSc/ZlZDRh3xtMGwv49Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/GaKFj7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/GaKFj7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6C2C19425;
	Thu, 14 May 2026 01:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778723369;
	bh=mhIgowFJ/NsjjgimUMPdzodKvuhjEXH3/32vBatMPR8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=W/GaKFj79nddJanysnTGVv0wLCr6CLSodE93+jhA6kS7k5/eSiqk2+vqtffuhHdi+
	 Siz0DRqZGeIWfcuy8IbK8ihO8KeljBv/zzPfVlaAzmgqw4bRD7QNdLr8RoVMADy6et
	 B/+zk6J2aw2fEs3YyIMXbA5IYsjzElhy2kIj/0ro+9sMDr8oM2SzXTP8WTdd/+Jfpk
	 sT/C6l+WpoelcnasXwCllDPyfOJLkj90LTuNAJaoMV/xG73Fnx53DY6LUGjkxrsAY9
	 p0BjzAsCvQdMF7JJ9GpmOH/zLNJnHz+qPVFSLuvP7Y4S62K8UjvR6Hbgp+8/OuCIxl
	 HzwnWDzVJyMMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 9/9] crypto: atmel: Use
 dmaengine_prep_config_single() API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Frank Li" <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260512-dma_prep_config-v5-9-26865bf7d935@nxp.com>
References: <20260512-dma_prep_config-v5-9-26865bf7d935@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 01:49:23 +0000
Message-Id: <20260514014929.7F6C2C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Mismatch between the commit message and the actual API used.
- [Medium] The patch masks specific DMA configuration error codes, uncondit=
ionally returning -ENOMEM on failure.
--

commit 05fb1a88b098522438016a4c4b3491605a64cf5f
Author: Frank Li <Frank.Li@nxp.com>

crypto: atmel: Use dmaengine_prep_config_single() API

This commit refactors atmel_aes_dma_transfer_start() to use a new combined
DMA engine API for configuration and scatterlist preparation. The commit
message notes that this is intended to simplify the code with no functional
change.

> crypto: atmel: Use dmaengine_prep_config_single() API
>=20
> Using new API dmaengine_prep_config_single() to simple code.

This isn't a bug, but the commit message and subject mention
dmaengine_prep_config_single(), while the code actually introduces and uses
dmaengine_prep_config_sg().

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

The commit message states there is no functional change, but does this alter
the error propagation?

In the original code, if dmaengine_slave_config() failed, its specific error
code was returned to the caller. Looking at the definition of
dmaengine_prep_config_sg(), it returns NULL if the underlying
dmaengine_slave_config() call fails:

include/linux/dmaengine.h:dmaengine_prep_config_sg() {
        ...
        if (config)
                if (dmaengine_slave_config(chan, config))
                        return NULL;
        ...
}

Since atmel_aes_dma_transfer_start() now handles a NULL return by returning
-ENOMEM, might this mask configuration errors by presenting them as
out-of-memory failures instead of their original error codes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512-dma_prep_c=
onfig-v5-0-26865bf7d935@nxp.com?part=3D9
