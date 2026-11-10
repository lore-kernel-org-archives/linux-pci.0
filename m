Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284810;
	b=BhoOz6tqJGjuxA14dBmE/C4WqHXHqNpUHAWoWYWhoxvpYLsbSWZh4FB7wa8br1Tb0lKD
	 IO+Iiuua1uIc1gtC2YKjWi/M062N80wM7eGnGWTDVtPw6BsE2BkhcqKMgBmnATqkSbvXY
	 a/52sB0e2MlNLJaSsBhDVtoVUz2CfjW2EF3esev0a8waadOa3D+Z3eDn1hdfSbuX5R6ni
	 AAgMWUlvHZB5ME3KkgBcspDH7JFwTxKKb4eQK2Uv7t4HorVDB241At/mBPY19aFa4T/Vj
	 CfDC7skEUbItOy7mdqCqAP+S1sEzqKcn28wjm4XpQAqrW/b5fZ3Ym8RHXrWJBkOZRQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284810;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vQNwBiVP3xTDeOUsdledqbqghtxx94CCdrIUVRDDZZU=;
	b=e44PotIA5rs8tQRo37+I2KeIYF551IbBRrq94Yg15AKcJejngs+nXK0V9Y+1KTdgmXPS
	 ShOqQccIwdUD7chO9rBPx/75JdiCxLUW5Ue9EDadM/Ax6LYb2KXGZw8sxZWhRSJHydmKo
	 ySXKMXebZexszHV9QKLdm8wgaxjpu2U0QN3YvkfvVq2B/3dROH5JVHDtDhoNeT2sVB5li
	 XwSUEjRGCn8CaBsE4URgrFRPlZJiXrWqtC0v7dAOg/XcLBVGdGMJ/2cEFPRhp/TtJuTzu
	 K6g2MWWXoPOvl3ZTF+AKawj0pXf77BGPK4k3hzd/3isJt4gs6MbTf20LclPIZJ2ATdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FGW8YPhS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A01606A335
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FGW8YPhS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E7F1F0089F;
	Tue, 10 Nov 2026 04:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284809;
	bh=vQNwBiVP3xTDeOUsdledqbqghtxx94CCdrIUVRDDZZU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FGW8YPhS2TZZIip89Q0gfqy1lFi6I9ChcoO+nd55l2SUdP1S4e2UfNZ7uJf5AbvPY
	 oVd9YvplACOL9ydOAFh//pFBQBbo1TxXDgpKdm9/U2LMgyYsVzX+QxYvwM00cCRbPP
	 GRMYIqqDbIsauD2Fd9o+iCsFsNAuSVR2YAuUt6FTUF1ZDPO+gHx2MEcXYaLsvee3Yt
	 MXOjlMn80huZByfM2VoFM2YYzM2Jq8LCXN2vePN7FTyug38OXmzPydnuBIjAqB23u4
	 b2WyXJJxY/DhfVTOguWBmTU8g36JUXUoYgmfvN0fsU6hL1X+JWLYgexx5LVGv19XIZ
	 d2HMsV6oROsvQ==
Message-ID: <sashiko-outbox-206198@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/25] X.509: Make certificate parser public
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261110041832.1730924-5-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:26:49 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Lukas Wunner <lukas@wunner.de>
>=20
> The upcoming support for PCI device authentication with CMA-SPDM
> (PCIe r6.1 sec 6.31) requires validating the Subject Alternative Name
> in X.509 certificates.
>=20
> High-level functions for X.509 parsing such as key_create_or_update()
> throw away the internal, low-level struct x509_certificate after
> extracting the struct public_key and public_key_signature from it.
> The Subject Alternative Name is thus inaccessible when using those
> functions.
>=20
> Afford CMA-SPDM access to the Subject Alternative Name by making struct
> x509_certificate public, together with the functions for parsing an
> X.509 certificate into such a struct and freeing such a struct.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D4

