Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286595;
	b=yEjNhsg4ecO1QrhDdi1n5Am5+m4i4CD73br5xeO7rBVCgZamXT8q8trWRXklBqfdGrti
	 2CR34RK0u/8dThbi9gRWJY4/cVQ5c+g9EegnzTxbmZed+9LnstzX4fS7mrZrd3y24Akyj
	 /Hqet4e3u6vbcmKPsOH2a4EmR6Gfw+cf4vLTqIbJLGRp5tZQo67IW1jfBs9+e5b+lMXJL
	 fVGWQqlldmGwC38dSrHRx5gLGxlIlgt8F6SH4kC6q+Z7FCFFLF5lSWc3wI9ZkqLggAVOE
	 Wm4K+lUKkMStAzJwlxRfNAvofs2morwQh65b8mAjB5dDIr6hClRaawSHkGYDh/dWsVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286595;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8hCPj/oAZiufRTRyv8W8+WAyKUGgDcejkK8Ec4MwjYw=;
	b=BmtZ/iDGMc2plAzpJPXwYICXk/OqsOrjid4lMnYnHRBl0gr3BJCGunDNKuyBOGHNsmid
	 HGI6/fKKLUPtc4gLwAeKFlUIQj5HHsVTYjKrSIGlbAa2gLKh1kxK5sJ/hYHdDXTTASGSf
	 hTJ8uetEprVEIyogMHYeGD9Us949/9sHMkhCc04FmNwCUkJYEMXvEukMVzcqKwjbuvY90
	 Ml/pyJcZ41yon7HA5wNKaLn1LwY1KtzwRUXXuY0N9IHTmbdXjOvMoE4fQB3EFjGzK1DDp
	 wBKQeLIIYGiUdL1LsrqVU1QidoUeoJj1c1yCQgotv+QWMJ42QC3gRkJgDAS/q166mvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4ZKZXvF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87994606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4ZKZXvF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C15A1F01825;
	Thu, 29 Oct 2026 15:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793286595;
	bh=8hCPj/oAZiufRTRyv8W8+WAyKUGgDcejkK8Ec4MwjYw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=g4ZKZXvFAPj+Jcwe1Xi/mBVLqsU6kic/958x5Yn7la5pCcNT+A2AvuuaquMJk8/b7
	 DDRvwme59hEz0KpDFzJKUzwyvBauMMIKivOrdg9O0dV3R0xgs8RwK+pqM+emetzhz3
	 gwYOQJCI2KEdhbI4PgMhG1TYNPaaw99+YLLe1+atDjXhcgc4cQDTSPA/V2Zm1l937+
	 CYqnWzyB9GI+QqI0mjBXdoVG3t2x0woBihblWt10If0T2aBSnJRzW3cG0vyJ+eYbo3
	 G7vk+p4YH88Q6fyMav6ty2MCHrLHScfw7zQrxpzFJy24q83hJgUHDkOAD2AiG7Yvym
	 +eavkQGPBq1jQ==
Message-ID: <sashiko-outbox-189584@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 07/18] cxl: Share HDM decoder register unpacking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261029145703.2185231-8-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-8-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:09:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Factor common HDM register parsing into cxl_hdm_unpack_decoder().
> Validate range and interleave parameters in locals before publishing the
> decoder configuration, including enable and lock flags. Reject nonzero
> ranges whose end overflows the address space while preserving the
> zero-size range representation.
>=20
> Read decoder base and size registers low then high through a shared
> helper used by enumeration and the reset snapshot.
>=20
> Read switch target lists and endpoint DPA skip in their respective
> branches of init_hdm_decoder().
>=20
> Preserve the decoder ID allocated by cxl_decoder_init() when publishing
> the parsed configuration.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029145703.2185=
231-1-smadhavan@nvidia.com?part=3D7

