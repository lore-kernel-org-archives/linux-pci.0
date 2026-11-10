Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285252;
	b=lrqttbaNDIUJInS6ACuM32KG8kmiH1vLcnIy08HtzixtGbfW3ouZR1/qjXxj2BOacVX9
	 PmF2lyp02naFGyyHzRxpODsckHQ2HFkSsLGqEKyYmk8ItAR6zCVal4ky1BLAw1k3xwhfB
	 6yWrk3r3m0cmmgGQXeKIWzzLKw4/2bY03AdkY7j5SIxcbVkE70o3Xg8S6ABrYhCAUCUFL
	 ZVt0IQuxbq0B/fUcu4xQ2wStd9ByEnZMMInAKZkHtvcrt4BM6sHxXTAE7ds0VAfwBO/n1
	 N6uBZkR9HsF8E8tF1xBt1KmleIjVyNOgwvRjpNUpP5P4efSK6zsf/N5diRnkt5c5UAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285252;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AshAl4OXougadyVJP4TTq8ro15mnEANQcP8mLfhnY6g=;
	b=EnuI0s/5MoixYrIkcIGDck+wq3l1lo7zBocwGaXOZU9sbSjtHxd+tJS5Htg2XzCtKBcw
	 N41wNYiQR80SiIfhTNeNfZjnYBDPXEF2S/ZFXWfwFThmXvHutHASqxcoaE73B+oqQqAqs
	 rKWfT6WrBU6v5S/nFMVdI1VKFm57QyYBcIHo2crxamcq5WrY+rYaCZW3TpmNcaBGQbKRg
	 wJpsZXKyHZosvmuhzsE+tDl7mybuyPRmmWmh2eEohcsvJCS7n5p9wrSeI5xn4JvMZPW5l
	 pLhVECg8dCMbYtkb/m9Xl8Yora54LlA2lFrH6cPCVt2AvP5vSQp7fg4vFCUkghYuJNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6lzOZOt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCFB606A338
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6lzOZOt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FC61F0089F;
	Tue, 10 Nov 2026 04:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285251;
	bh=AshAl4OXougadyVJP4TTq8ro15mnEANQcP8mLfhnY6g=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=K6lzOZOtEQbnFubrAd5noLw4M578lD9QecjWWKL41PgEJNjvRyg9GYxy67Tw0Mpbs
	 ODNTgDZTOlZbFY6bsQTIKtrDvqdnLg8XI7JjwSkkzeDmF3XDf1xZi62eeuXr9wCh63
	 EtP8pndYuVPU4SAsqJCIIlluiWZkTqExropaU+wFKdY1QwTOOOuSLNohkseHFoKwD5
	 HGv/N6vai/xKucm8R0Ix6ZLC7Yp3SMcWNhbBL/gYY0YSqzLTUbOPCaJjyU1zM1Gl6t
	 k6jGS0yg4Fb0iC1biCQot3SGdFDg5RJcLmIzuaNNjPsuryKFI16UNIJOgsG7BGJLGi
	 SjW34eDvrQOhw==
Message-ID: <sashiko-outbox-206212@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/25] rust: create basic untrusted data API
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261110041832.1730924-3-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:34:11 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Benno Lossin <benno.lossin@proton.me>
>=20
> When the kernel receives external data (e.g. from userspace), it usually
> is a very bad idea to directly use the data for logic decision in the
> kernel. For this reason, such data should be explicitly marked and
> validated before making decision based on its value.
>=20
> The `Untrusted<T>` wrapper type marks a value of type `T` as untrusted.
> The particular meaning of "untrusted" highly depends on the type `T`.
> For example `T =3D u8` ensures that the value of the byte cannot be
> retrieved. However, `T =3D [u8]` still allows to access the length of the
> slice. Similarly, `T =3D KVec<U>` allows modifications.
>=20
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Message-ID: <20250814124424.516191-3-lossin@kernel.org>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D2

