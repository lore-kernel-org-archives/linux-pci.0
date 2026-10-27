Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079278;
	b=UwdSUod/dvxI6iG6dwwLgLubDbVFE6fw7GjgcKm8ovqOS3VdBFBUUCFzpTkJ7AiGJYGt
	 UZEfhrnpW00XRcnTxE567oT4PY3XvtHAditxGZRWXnWJrX6XdNPTqoUZeR4udwQAkm0Yi
	 egpClseDKaHGHqk3uq+Xq8+sXQDY1NWfHbjmk7ZjQoo0ZsAwVzc3xPUFpmJlHGNQ/te+S
	 87dQdLxT5pBv/rL3OxTdlepd1Xhsx8GnDEJt6Omccrdph5nhBzpymirXziSDf/BEggPhh
	 8jsqhDdfkS/6qNrXo2D76jKsgfcORk0bu/Qg8P15XuWqdqygw/8QHolw8MhDhVbxhow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079278;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mr+2kR3Czx2gXEabbZXj3S3IwLsJbNX8fckeRnvpPyM=;
	b=caANoXERz/LYyiLw8plsb+QKlItNLRpjOpGRzTYT3YeNk+yEtUB88x27j622RY2V5zlr
	 iFA2lMPdJJQbRDoaitW+s2klOa66P6ikVmHcA3QlH87gnZoNZcOVjObXNmDOzK6dKJJxC
	 l+9fF1cOxorMpyV8wbEwdxSMZHYUBk5hOU8sTdwR8zFLyecewWKAMIiUw/sdd2SxPKJTp
	 s1D5aB71oWGgC+zbtTUa/aJvJpzcCpWg/6EldXaHflStpHpyJ3v7mlpvAh4YE2SetP3Nc
	 kLKb3Ql6HnmIpEfm1vIwjlJzSjOyWeeFUNoH9mgLI99pKB6+lJ6NEx30es8zt8RwpnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ti3p8njA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5C606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ti3p8njA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA311F01825;
	Tue, 27 Oct 2026 05:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079277;
	bh=mr+2kR3Czx2gXEabbZXj3S3IwLsJbNX8fckeRnvpPyM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Ti3p8njAtt9h322hwTCA6OrwznEddLg8klnMdr8UWUW75YwzXgaHFJMkZEpoo6t0P
	 +0+rhjz9h/q+PlDJP71P+H+rGBhfO9Ohcg05d+9BCQ9Y59/NKT3UNdu5bgvE6fe0CH
	 b5PHjwLi+HqZgrabhXBKZ5FGJP8rZVpy/oeX0gM81SIOtjTJsKNFbyonGj1zcJZvzY
	 NduBDVIO/yHqNWQbTAoitsd0o2+Z/H9LVzZeWkZCXvCCcPQMXcvD48NaI4e+GwEHZV
	 mPJmtHPI2prDKR7oXoLcomNkQSwWvrmnVs+MqNhU6UTr9SyhzbiEHMzT6m9jhwkXBf
	 jk76AIWhqBiog==
Message-ID: <sashiko-outbox-186125@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/23] rust: add bindings for hash.h
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261027052536.1722081-8-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-8-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:34:37 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D7

