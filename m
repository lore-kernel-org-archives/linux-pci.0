Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793762151;
	b=w1PxhEePJyJA2ci65ZMphsRCr3hrLwb3Slecug01t24Jegft86v8LAuIm3f5AWNJE4kx
	 TV9w5YXLOviMCYxNwQvAwbO9XLZrQjAqZQRX4E8onwC24MD3Ak4SgBtUzYEBBem7l8ogq
	 1SAGdvQOyKrJivvWIqWuiJf5KpigBk1klweBSEu6SCcjJcK+jp/Okzy47NwpXrImd71qA
	 XXupMqZp0XdK/I9I+BaGRAApnBql7hEeQTckheOqCxh8AlFZeYbgg7AOUWpMwpqYoNHLI
	 QZ6PH8AvxoIrkoaEg4sJWVRRAWu+CSxWbu7KL+2Uy94nn3FIzhxNG55AH89h+bgNnLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793762151;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uYJF07BCGEEpbrc+vXQyQ6V28x6DgLk6q4sUVWA5mto=;
	b=WnLy7tUSoBUqYGl/GNYr9aPA75mzabu7u1SS5oSplieWcvSjJUdPsp9rEHkcHW+XgJPb
	 rd+EQeyjlH2kiY1fgCVFLs/VIipqzQlh0KHydUblvv1T+LXpcRYHgHVZHNdt5F+tNgI3x
	 lAgcyCMLkjzNE0t3Cuzt9X3AVqu5VBSaAygrcRZIh+b9Oo5Wnavwc5Xc6viu4thyjfnLp
	 HkvY29WZ1tUJ19g7r6SegIyNkCcR4hxH5EjFb+LAgxblOJ6rjX8++2CqH2ByVnQEom60O
	 SrEBtDE5jvYJOndhOstuiXM7YTvp78VhD3WmTXGcWnkjQPyWxTNfGqVRc2tj2SWCd6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BiU/NEqc";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFF6606A31B;
	Wed,  4 Nov 2026 03:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BiU/NEqc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63661F000C1;
	Wed,  4 Nov 2026 03:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793762151;
	bh=uYJF07BCGEEpbrc+vXQyQ6V28x6DgLk6q4sUVWA5mto=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BiU/NEqcMeUMJ4Qb/pbwCr1zxm2CJZbHWhiwJwH1hNr8YPecLEug8V6U4Zq7LYj8U
	 KTa0qsIfflzicX8Q9utWTVdk20+dQNficz9AgKK1BFIo9Q7IfsqDzXilsg02BT43Or
	 h2S6THY4u4qCIfhiSp3IfiJDI5Z+WvXBhlJmzc2cC/J1rFNaJMLPynCbSlmapdKIdk
	 tQtiS6IvC/jDzn12LEEFtT9crYBfRtcP94WQT8XStar48zWSZH3vax/tWqWBVSxCV0
	 6PBOgYIOQjueiaqy22f7lFeCRB7rQUt6PRXGSj5wi/ZvfM4l813tkzY/+knJ5M3pDA
	 X7xvV9jvUNx7Q==
Message-ID: <sashiko-outbox-196592@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 24/25] dmaengine: sdxi: MSI/MSI-X vector allocation
 and mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261103-sdxi-base-v4-24-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-24-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:15:50 +0000
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
- [Low] dmaengine: sdxi: incomplete kernel-doc comments in sdxi.h
--

commit fccd22f95bf4bdc550267ac2709b80e00e1e9267
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: MSI/MSI-X vector allocation and mapping

This commit allocates MSI/MSI-X vectors for the SDXI error log interrupt
and client contexts, tracking non-reserved vectors with an IDA. It also
adds helpers to allocate, free, and map device-relative vector indices to
Linux IRQ numbers via a new get_irq bus operation.

> diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
> index aaa43eab00b33..07044d837d9af 100644
> --- a/drivers/dma/sdxi/sdxi.h
> +++ b/drivers/dma/sdxi/sdxi.h

[ ... ]

> @@ -69,6 +90,38 @@ struct sdxi_dev {
>  	const struct sdxi_bus_ops *bus_ops;
>  };
> =20
> +/**
> + * sdxi_alloc_vector() - Allocate an interrupt vector.
> + *
> + * A vector that will have the same lifetime as the device does not
> + * need to be released explicitly. Otherwise the vector must be
> + * released with sdxi_free_vector().
> + */
> +static inline int sdxi_alloc_vector(struct sdxi_dev *sdxi)
> +{
> +	return ida_alloc_range(&sdxi->vectors, SDXI_MIN_VECTORS,
> +			       sdxi->nr_vectors - 1, GFP_KERNEL);
> +}
> +
> +/**
> + * sdxi_free_vector() - Release a previously allocated index.
> + */
> +static inline void sdxi_free_vector(struct sdxi_dev *sdxi, unsigned int =
nr)
> +{
> +	ida_free(&sdxi->vectors, nr);
> +}
> +
> +/**
> + * sdxi_vector_to_irq() - Translate an allocated interrupt vector to
> + *                        Linux IRQ number suitable for passing to
> + *                        request_irq() et al.
> + */
> +static inline int sdxi_vector_to_irq(struct sdxi_dev *sdxi, unsigned int=
 nr)
> +{
> +	WARN_ON_ONCE(!ida_exists(&sdxi->vectors, nr));
> +	return sdxi->bus_ops->get_irq(sdxi, nr);
> +}

[Severity: Low]
sdxi_alloc_vector(), sdxi_free_vector(), and sdxi_vector_to_irq() in
drivers/dma/sdxi/sdxi.h use the /** kernel-doc comment marker without
describing the @sdxi and @nr parameters or including Return: sections for
sdxi_alloc_vector() and sdxi_vector_to_irq().

Running scripts/kernel-doc on drivers/dma/sdxi/sdxi.h (for example via
make HEADER_CHECK=3Ddrivers/dma/sdxi headercheck) emits kernel-doc warnings
for the undescribed parameters and missing return value descriptions.

Should these comments document @sdxi, @nr, and Return:, or use regular /*
comments instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D24
