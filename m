Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079184;
	b=GtrxCtb7GKRgg7xb7GWanIySaY+UFfsTopuMNDaqdkd2fM7UNXcNjBKgA4BvetVJOcfb
	 tV7Z18HTZgErT400NZai9c8my+z8YtsxTu53DixULJU/tDjAm21ZKRxMbzOKb5nYUyAqD
	 FMl3n/+N94tqZj5vTwdhbCMahKJmfqWpR+k1uL2qhe3Qz8nNmY98p555AdyE8tsMhTdO8
	 Now8zmmUIi/dWHf9FPoy2seHIRJps9SpFpBl1yJy3OwMOVYxRsvYEU9gYhpbl32tnJPij
	 rNv7HCNNVABuGNL204fdYfvbUK8SbMzy44uxKDkOIth+nZO5hk/6EInDJBrCtpAIqgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079184;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m5jvH13BvHRw6OBrLXhz3Y+H8CGv10ITzl6kRwTbalA=;
	b=A4zwKTJcrXc801OINQHzielgnJ+CHBtBZBP9fX38/Zawx6Ft8+/GTBuXdYoStPtYGRSs
	 qgFZ2MRQrHuklnzMTHcNO/3N9z0FyC8JJJtWJgP2Vorle3RqCWLVwwBSpEXhVuV7M/tQv
	 PzEPceQxectFQeySrZujzFSvoMe5LbrovA+auMdnnad/lGv2uSSOIdYUeIpPcZEPGgVzv
	 B+fHjw333Nl8NJYLA+qukn5ozJQslfLVRxj8tURVW+eCDk7kW66+i4797wkHHfuF7+H5s
	 8TPCM8kuGEKcjcRRa/0ChDrOm+3dkwm78vdWH6M21b4Eqje8ZZXgs7qNrUpeaHy3neQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dt8fbVWg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809A6606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dt8fbVWg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAEE1F01825;
	Tue, 27 Oct 2026 05:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079184;
	bh=m5jvH13BvHRw6OBrLXhz3Y+H8CGv10ITzl6kRwTbalA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dt8fbVWguo7q8jzV0btWN0/CFLGr2OSNNz31RsZ2AHzKVhSWsLty+VCQnceudjHVo
	 xpA4CHI4Y5GntvhaZXrqHmOsGArAE+EZ+KZg+rQVM6riZ0MSoxXN6U2N932zuqPtj3
	 6t/VHqAA2Bk0jERrlsZW9rTHkIMefixz2sTdq6IrvFYdHZfj3Vb5MZOEP1OHLwrShB
	 QNZ3PCtJKMe5CGej7c/htqSKFAGdDn3SuiKG810Aedz/O6ldE+DymVttYBH7TVXAs1
	 hGPP7fID4myosIXiGnZeXk/FImJYINtpfBp+RjnMG3XYAgy6STkwU/ACUeuw12Hqrh
	 JaCSRd2g0sHsA==
Message-ID: <sashiko-outbox-186120@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/23] rust: validate: add `Validate` trait
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261027052536.1722081-4-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-4-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:33:03 +0000
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

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D3

