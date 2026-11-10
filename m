Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285021;
	b=W4r+xzLdkzF04lcpVeO00VLx0dEtJuxhS06c41M5rppApCvDzzBHYCfW5Q4DLlUppX+g
	 sIsQ8MbcCvbj7o88Tz6R7GowqGr+mOxEl/sdd/iXHio3c4DUafL81WBd6RE4Pg8QPxoGl
	 zxKv0nlzZKS6Jkj+MtxJ+r0K2GZmwclQHbINUdY2Hcdn3HtchgbSJinbyiSY4Ja9eTHVA
	 gYnsvZshgT7YDHr5nwOPGix+OyuUMUXReqlG/qIMtpwEkcIf9m3aSTmZxpUW24k0eX5W3
	 ofYnpBDNJ9ITUxWcKvltovjQI3U4837/65e1MhPKOIzozz7I1UEpfoHMavxM63Ajwdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285021;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U6lpqh0Qlvm9lkxAjOiSSFCfLwf1euhZNOYhXMx1YDM=;
	b=ibf2Ln70F9xhAdCBV8uohG3Aj8jEhvO2AW+45ZNmr+QU8OzVS/PseJnm2sJn7hLK6lUx
	 OEBHBDiEaaBgY5QyOwQt7My+3B4E09LDZNSE1/tynHr+NzTInbNDNVATw20f8T2lVyGQX
	 sFHvlLNpRH5GN2pYoQixbZAQUNYgYw6S2HQf96pbV1SH/j/QRImzA+J1f4RSXO7j+4+Kb
	 KkiVTjtHULZaaEriGXgO0t/EBHnKB6dQmAjHGn1goNOODTFiMacm1oSf/PS7sJVgbBvWs
	 uGpH6Umt8zV9D0I5Qfd8snMw13UcWz/G0JshlvoqQEe2FCaiWzaxUzavDOL+zV2bQNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EEGLQuld;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A7360A261A
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EEGLQuld
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01181F008A7;
	Tue, 10 Nov 2026 04:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285020;
	bh=U6lpqh0Qlvm9lkxAjOiSSFCfLwf1euhZNOYhXMx1YDM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=EEGLQuldH0jifyB5jaBubnvUWeZeLo6dfKdxEsQWkGYercFKBIDkzkBGsvajTsrIz
	 KJhMycSewYuK6DGZNuHXSBHcCXKvHFaL8d/Ow6d42RMmIHDg7FqdZqN0HJwtIV4l/P
	 TEWG2XsTZ9f7y4bRq8v7zBJd1AOEdhk2y9mMPvtxQYinTfdlc56FUet26jcb4OZSzJ
	 DtIry1D82yz6NmzaM/TQoBbQO6EMShiTGdqNmSZx0Er4wCkhJLY0szNMnkyfVLG83V
	 1V4xzw1TETG1iGGf0kY5JG9lqbL4gstIBXdAo6VZjG5Qa6gvb2F4kngBlAgsdPixUG
	 pRkV9CMXsWiow==
Message-ID: <sashiko-outbox-206205@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/25] rust: add bindings for hash.h
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261110041832.1730924-8-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-8-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:30:20 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Make the functions crypto_shash_descsize(), crypto_shash_digestsize()
> and crypto_free_shash() available to Rust.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D7

