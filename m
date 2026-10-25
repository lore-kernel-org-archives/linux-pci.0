Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792902450;
	b=3xMM6TFyM6gp6qlmQNKpSRHcc/BHcB2F11T/5jk+VyxyaNYGLY217LXwDHYBtr99TnIW
	 JtGMUiBO8hvw3yzebL52WbM9Rtb9wbnqO2cx6gytjMtbZEusWR8ZZ47PsDzZO9duFsq1C
	 u3nUdwEbDEX6WGOk2XDybHJQoMDilxoToIlIsLcyhjLyNHGNHwx79Bi1JXasCuwG/CSH6
	 BTAV9Ha2iBH2f5W8w5eUnn4nCdiVGcPOXZnR3BYojcNyWpNfZsmCmZcLEznGii5UM+AdV
	 v9dYUPewysLvH/lkG/74qah/CthIHMOIRmWLxWIPTPKmQXxFzpzjkj0IJm9NFKl5OkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792902450;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=20ZLKBnT3bPboGlBNgLE/muRWPscqV5jgHNHq1NqpO0=;
	b=X+7YcWSuX3PF9RJ0ieUE5qKNJ6ElAYrXO3I5b4jAQCIefMRCMEWLFURkycyN3Eo0pfNY
	 gDKGIftWNvQWUJwixCVUhCTOeHbxaxhAcgj/YzREs63E5GzJu6ntA33H8s7cZfBDO2kOd
	 Mq/M2Yeeh+tmP8zVzbHc16N8LUsQ/oooptbGDBXW+dMaulwXV/Fuy9S4jUXqtHIKtOvdX
	 TFXlJIpbaPgJKlgoa+Rs0NG9mFdYvRcDVnsbaGco+7WJfS18XkL/RnrzLuSkQ58Kv7a8n
	 BfhTOFZySVBbvV571Pf+0b0oqCZX2U6N/osZlLBW79p8TPPhmzijerUQWyLco3rDg+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VprqfZ9C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15300606A31A
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VprqfZ9C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE631F01825;
	Sun, 25 Oct 2026 04:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792902449;
	bh=20ZLKBnT3bPboGlBNgLE/muRWPscqV5jgHNHq1NqpO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VprqfZ9CaN8T21RgjWsXyrOO1h6RXLfnh0zLpGfFI0ThFcVvYQLlCywlOtFTtO7in
	 tgTgrsMvHvb99+Z64mIOP3N9svdZDZS8azVL/Hp1/CuRWEWohcS4iJ2HgkXfJjGdTB
	 Vtczy3HLimoaOtbpKurspp8Er2Bgt7F3Z3KVfggnUIW0t5SX3zhhYqoEOD4YlVIfzE
	 Yslrt63ZrXFqpZs6hiC3hkNXHL43uaUTxjyvMVdS+lWCUzyMVMsuazmMrr0CHNyyXm
	 WiaU7l24u26q68B3Lb9C/VReclebb0LJDozYiO/UDyc19R06vqCV9cSu1LufwGp70v
	 zFiNwdOXdZS2w==
Message-ID: <sashiko-outbox-184063@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/13] platform/apple-gmux: Fix MMIO interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261025040046.1602-4-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
 <20261025040046.1602-4-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 04:27:29 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] platform/x86: apple-gmux: missing unlock on timeout in gmux_mmio_r=
ead8/32()
- [High] platform/x86: apple-gmux: uninitialized return in gmux_mmio_read8/=
32()
--

commit b2c93280b42eef5a3e3e707b2033f83778f7828f
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

platform/apple-gmux: Fix MMIO interface

This patch updates the apple-gmux MMIO helpers to sleep for 1ms per poll
iteration in gmux_mmio_wait(), check for wait timeouts before performing MM=
IO
reads and writes, and wait before writing in gmux_mmio_write32().

> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/app=
le-gmux.c
> index 4e8786a5e58ec..076ed7ba6af90 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c

[ ... ]

> @@ -250,12 +250,14 @@ static u8 gmux_mmio_read8(struct apple_gmux_data *g=
mux_data, int port)
>  	u8 val;
> =20
>  	mutex_lock(&gmux_data->index_lock);
> -	gmux_mmio_wait(gmux_data);
> -	iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
> -	iowrite8(GMUX_MMIO_READ | sizeof(val),
> -		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
> -	gmux_mmio_wait(gmux_data);
> -	val =3D ioread8(gmux_data->iomem_base);
> +	if (gmux_mmio_wait(gmux_data)) {
> +		iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
> +		iowrite8(GMUX_MMIO_READ | sizeof(val),
> +			gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
> +		if (!gmux_mmio_wait(gmux_data))
> +			return 0;

[Severity: High]
Does this early return in gmux_mmio_read8() in
drivers/platform/x86/apple-gmux.c leave gmux_data->index_lock locked when t=
he
second gmux_mmio_wait(gmux_data) call times out and returns 0?

The same early return while holding gmux_data->index_lock also appears in
gmux_mmio_read32() below, which will cause subsequent GMIO accesses to
deadlock on mutex_lock(&gmux_data->index_lock).

> +		val =3D ioread8(gmux_data->iomem_base);
> +	}
>  	mutex_unlock(&gmux_data->index_lock);
> =20
>  	return val;
>  }

[ ... ]

> @@ -281,12 +286,16 @@ static u32 gmux_mmio_read32(struct apple_gmux_data =
*gmux_data, int port)
>  	u32 val;
> =20
>  	mutex_lock(&gmux_data->index_lock);
> -	gmux_mmio_wait(gmux_data);
> -	iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
> -	iowrite8(GMUX_MMIO_READ | sizeof(val),
> -		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
> -	gmux_mmio_wait(gmux_data);
> -	val =3D ioread32be(gmux_data->iomem_base);
> +
> +	if (gmux_mmio_wait(gmux_data)) {
> +		iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
> +		iowrite8(GMUX_MMIO_READ | sizeof(val),
> +			gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
> +		if (!gmux_mmio_wait(gmux_data))
> +			return 0;
> +
> +		val =3D ioread32be(gmux_data->iomem_base);
> +	}
>  	mutex_unlock(&gmux_data->index_lock);
> =20
>  	return val;
>  }

[Severity: High]
Can gmux_mmio_read32() and gmux_mmio_read8() in
drivers/platform/x86/apple-gmux.c return an uninitialized val if the initial
gmux_mmio_wait(gmux_data) call times out and returns 0?

In both functions, val is declared without an initializer and is only
assigned inside the if (gmux_mmio_wait(gmux_data)) block before being
returned after mutex_unlock(&gmux_data->index_lock). Could val be initializ=
ed
to 0 (and returned after unlocking on both timeout paths)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025040046.1602=
-1-atharvatiwarilinuxdev@gmail.com?part=3D3
