Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB9E3101A6;
	Mon, 28 Sep 2026 01:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559690; cv=none; b=MA66Vc2obJsMucYA4nJjeKZrcY8eXTst5Pp4I7AA4cBTiKB9p2Il1g6K2VU2ZqfOSLnf9AIYY1tO8lYQ49ymtelEUsDgagLTzea02xOppEB0Mh/Q/10iRvuN3Q5SFzn43dP/LSR5AxqThm/ZMzNUhj2YUQt2u29oNnuTMVYtT44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559690; c=relaxed/simple;
	bh=4r9PrqNJrYf2aflSBP+gznOQUzIaQDale1DSwlADyuU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E6hZeE/J3V3UbFF6IvzkB4wNm9jMb/JaG43P9opTHvpTKFzlcwyNA77thTRULq0cDcpXzB9+OMMGjjNpioKkTY78751bsKXFb7hR4D0ptUDSDPgPCl8dsJym1BdslWVKQfgbmKKrzjiCnbZqsaDhdv1681oa8IcV3/8GXDW4goE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9dvD+L4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9dvD+L4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06A81F000FF;
	Mon, 28 Sep 2026 01:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790559689;
	bh=4r9PrqNJrYf2aflSBP+gznOQUzIaQDale1DSwlADyuU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K9dvD+L4Fr/Pktfryf/ea5+L4V61zSgKiByYbWlqDYWaa45yT7jPU3fEK0roX13gh
	 T+Eue5ZSYIStQg10t+LXzFRWJGR6xJn1PkO5JxnKDhNG1enUnWkVU5PnMtQz4k0I2U
	 qSzaAsXrW4wT1CEJUs7ixuxME/eEdlB9t8IADpM7T/95Iw+l0l9CdLstcImTso7r38
	 JHq0kD2JAYiXXs5XjrFt7ugvD2JU4YBCMDiBlIL+mMf3C1opaOjrNb3G7AVd/aDQNh
	 7bNZ7zaQe+t7qBYZM4qjlkbDnDyh8vuWmAOeo9Z6rnqpNPr/8jgLffKw04bfRZqxwO
	 en0qHwjmnv5Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/22] rust: validate: add `Validate` trait
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, linux-cxl@vger.kernel.org, gary@garyguo.net
In-Reply-To: <20260928011123.450800-5-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:41:28 +0000
Message-Id: <20260928014128.E06A81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Benno Lossin <benno.lossin@proton.me>
>=20
> Introduce the `Validate<Input>` trait and functions to validate
> `Untrusted<T>` using said trait. This allows one to access the inner
> value of `Untrusted<T>` via `validate{,_ref,_mut}` functions which
> subsequently delegate the validation to user-implemented `Validate`
> trait.
>=20
> The `Validate` trait is the only entry point for validation code, making
> it easy to spot where data is being validated.
>=20
> The reason for restricting the types that can be inputs to
> `Validate::validate` is to be able to have the `validate...` functions
> on `Untrusted`. This is also the reason for the suggestions in the
> `Usage in API Design` section in the commit that introduced
> `Untrusted<T>`.
>=20
> The `Validate::validate()` function allows additional context to be
> passed, which can be used as part of the validation process. For example
> comparing data against already negotiated information.
>=20
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Message-ID: <20250814124424.516191-4-lossin@kernel.org>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D4

