Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587470;
	b=iPvaWzdjj7NSx11KJCQMwGyrmjTjyFbc6iPlfZW4xOomZsIQrtj2ZZz8okCuT6hjJPs3
	 kcT7QjHBTtW3A6sMZ/Kw8UWR5dkWejD8sIqV9ZR+cvD/9F7JPt+COG3+mYKjRDNJyJt7W
	 fcZ/ZZA8RH9hJSBN+wifBkTaFtFvgLjCyGJbrqdErQ5rMt/1EjmVQ55XmK8t+zi5c+BCi
	 eplIw6fqJqLAcBKioLxKBhd4PnXxCHOmoa936pS4XPPJ238J3LxqqKyC/hZqnUzYXIhhX
	 dPbtDiKAfBzNojZypcryc1ELfeTDnMVT0oekHahJEIm8PXbmmmiSY1UShjDMnFrU/mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587470;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yrPSJ4XUF+sgpcoIVCeL93n0BkwIYFZn5XjGdZFdUAk=;
	b=X/qidNvGG0Nr0NiE36n7q37nP626OTEvhxH9fpOBrRYUvqcPVgCyP1sCBJiNWdMRKiF2
	 2TnIFd7KLjAeQhDWbnZmh9Gn5VKDaP9WtyIXlfDlspenk48rkJqyI8JiJb/zRMqYvAmEY
	 LNkkVgOJFPZEcS+h5yPoR5pfHz665V9Awg+MrLwoI+rdXs4VnGHaHl9+v10JXAvT3DlOM
	 SM9eT8p/0ZXdsgWVQ4KX6DsWZpFH5rAjKm5oFTe3PdvxSdVHvR7paX3LyxBtrfKM7Urdt
	 0jLcHPohVy0rXSPHPfy7CY/y7OpSzszwTPYHrnzkuRJRPH+hMkj3vQ2hBvWHU+GctHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozYH2cA4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB760A2611
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozYH2cA4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381991F000C4;
	Wed, 21 Oct 2026 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792587469;
	bh=yrPSJ4XUF+sgpcoIVCeL93n0BkwIYFZn5XjGdZFdUAk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ozYH2cA4nG68luSaY2fQLqYPNxUOGuyz3eywOUnJ1/gnwv7nuQTvgKqBo5kzbChfi
	 HnDKyhugDOGIuEG/DzpLN9ejw2cjQH9/G3lzn/wzHmuxezw6h/MP36dqmDx+LQ+L4E
	 629+IzoFm9hx4U2ISY9x3FI/m3jb41jNNKVuMJTsif7Wh2sl+F/kUUK2wE2o77Bl9z
	 PSMPoEgD7dxpfyByPHxKgDp54LJs9qDNz8xhRjTwhpRSbARVE4ZAlIRhae4KIWTzXX
	 pRzwko/7volmQlqQWA+vBIw1pOc/eFjfcuygeuIRDyBmUJ1kIrmTmTGb1XRnBZsMbm
	 ZioXt1gZmIEPg==
Message-ID: <sashiko-outbox-180283@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/7] linux/log2.h: Add 64-bit
 roundup/down_pow_of_two64() variants
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261021124956.4250-6-ilpo.jarvinen@linux.intel.com>
References: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com>
 <20261021124956.4250-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 12:57:48 +0000
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
- [Medium] log2: 32-bit 1UL shift overflow in roundup/down_pow_of_two64()
--

commit 43925e5ad2f800f4d000698aad5a8426cb02653d
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

linux/log2.h: Add 64-bit roundup/down_pow_of_two64() variants

This commit adds 64-bit roundup_pow_of_two64() and rounddown_pow_of_two64()
helpers in include/linux/log2.h so 64-bit inputs are not truncated to
unsigned long on 32-bit architectures.

> diff --git a/include/linux/log2.h b/include/linux/log2.h
> index e17ceb32e0c97..180e5702f6779 100644
> --- a/include/linux/log2.h
> +++ b/include/linux/log2.h

[ ... ]

> @@ -163,6 +183,23 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
>  	__ilog2_u64(n)			\
>   )
> =20
> +/**
> + * roundup_pow_of_two64 - round the given value up to nearest power of t=
wo
> + * @n: parameter
> + *
> + * round the given value up to the nearest power of two
> + * - the result is undefined when n =3D=3D 0
> + * - this can be used to initialise global variables from constant data
> + */
> +#define roundup_pow_of_two64(n)			\
> +(						\
> +	__builtin_constant_p(n) ? (		\
> +		((n) =3D=3D 1) ? 1 :		\
> +		(1UL << (ilog2((n) - 1) + 1))	\
> +				   ) :		\
> +	__roundup_pow_of_two64(n)		\
> + )
> +
>  /**
>   * roundup_pow_of_two - round the given value up to nearest power of two
>   * @n: parameter
> @@ -180,6 +217,21 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
>  	__roundup_pow_of_two(n)			\
>   )
> =20
> +/**
> + * rounddown_pow_of_two64 - round the given value down to nearest power =
of two
> + * @n: parameter
> + *
> + * round the given value down to the nearest power of two
> + * - the result is undefined when n =3D=3D 0
> + * - this can be used to initialise global variables from constant data
> + */
> +#define rounddown_pow_of_two64(n)		\
> +(						\
> +	__builtin_constant_p(n) ? (		\
> +		(1UL << ilog2(n))) :		\
> +	__rounddown_pow_of_two64(n)		\
> + )

[Severity: Medium]
In include/linux/log2.h, __roundup_pow_of_two64() and
__rounddown_pow_of_two64() shift 1ULL, but the __builtin_constant_p(n)
branches in roundup_pow_of_two64() and rounddown_pow_of_two64() still shift
1UL:

	(1UL << (ilog2((n) - 1) + 1))

and:

	(1UL << ilog2(n))

On 32-bit architectures where unsigned long is 32 bits wide, the left shift
is evaluated in the type of its left operand (unsigned long) before the
conditional expression is converted to u64. When n is a compile-time consta=
nt
with n > (1ULL << 31) in roundup_pow_of_two64(n) or n >=3D (1ULL << 32) in
rounddown_pow_of_two64(n), the shift count is at least 32, which overflows
the 32-bit 1UL operand and triggers a shift-count-overflow warning while
truncating the result.

Should both __builtin_constant_p(n) branches use 1ULL instead of 1UL (and
1ULL for the (n) =3D=3D 1 case in roundup_pow_of_two64())?

> +
>  /**
>   * rounddown_pow_of_two - round the given value down to nearest power of=
 two
>   * @n: parameter

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021124956.4250=
-1-ilpo.jarvinen@linux.intel.com?part=3D5
