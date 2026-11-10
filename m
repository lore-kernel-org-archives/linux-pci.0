Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284794;
	b=DR5SWgZXAEr0BFwMSEjrqRQcnisgNVeP1wfnG7lciqbrziVCmcG7mhTYTpNu4IUNenMK
	 4l72QYaWFDcWMZCF5Cyic9EY0fN1tUBDbdkMQfmcstVzQElPGjYILiOLl7rvjlc4wzsSQ
	 erFhduHm4R2qFxe98MvnVJ7jdDuV2eW4vmzkvOIY7rGAi9QUM/OY8cg0KhE512KU7eBeb
	 tzT7NXrtmLxSQkK28PoCgUfLD2GIyQHcqo1icNk3LjBhv3HUU0yH1qJ+OUP220ybdN0Tt
	 GFoaTBbtq0VFVqbOJsjaXFop5pBtaDMMTUWI3WxH8afjsWYQNDiC2eNYTc+MogIs6MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284794;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=co0aejwE4kHN04AT/RO2nF2ay0+LPtSRPQv4r+7BkR8=;
	b=z7ODaXzr05hBdoF96oFa8tKSU7nbj4JA4CHJZQea85lLWInaC+WPTN207rgbFPqWQZBD
	 PlVrHZ7EXgfFZFdQdZg0j/5HNG99ciQ6DHR67PAYSYDn27GMx5BCgHypXT437vmFwPByt
	 bu1RgtGF8tXCvVfRxSLD4RnR+ijaB2xvlL1LXzrEPEcP7CgDpYZc84ld90pGwD9Btpo7V
	 ZYzu5kXNb4j4dPa/ZEFpYuULcfMC7DpLtyKjmrn355jGn1S6BD1ZZY2gZ6BIYhKvyVcQi
	 gkFVGGGVaJVO02uY3NnGSTxEmuCptc4v8ZqI/yiH3yfWVpGOZ1Uz6GQMcVdC63evN5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sw7UKA3R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48F5606A729
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sw7UKA3R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234541F0089F;
	Tue, 10 Nov 2026 04:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284794;
	bh=co0aejwE4kHN04AT/RO2nF2ay0+LPtSRPQv4r+7BkR8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Sw7UKA3Rrg7/DjytLALRXHraRN/klo6pB8MW4OE0AZc9vu2zcxoAqO5iaTBTXxFpa
	 lYrPM7gf+Fr5lr0wbPCWvU4R6qIYw4eZm61+QcncD43y6kJCDOuXxpHfUgcfylzlH8
	 xeT4z+Hcdo/SuXsvD68Ib+KQHDAwTEX7f0qy6lQuNBXd3fMlu9B7U98QMERi1yoObd
	 HZkk8oXbIajaRHsWExNfSHXqo1UYi49Vq79IeR21IKvWd6F4EWmIEgaucIZjDFfa3z
	 f2KlvnqXUL1eOnc1mOCE9wLonNztp844t4NnhdEuSeerl6AOzdYlceGbSehZgQsKuM
	 VfFpxnZ9YyO7g==
Message-ID: <sashiko-outbox-206197@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/25] rust: validate: add `Validate` trait
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261110041832.1730924-4-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-4-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:26:33 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D3

