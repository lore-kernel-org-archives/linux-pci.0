Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792556792;
	b=o87zquz+J7KxMWQqvtt/MaojSsIrW7Ut8+sE5N4JWtBser4N1KHwIRg0rcq4tuL7UpsI
	 PvPI4Gc1gm82Xwo32iTRQ3hdmhrR0mxtq2l7PaLSE80J5RP3scVuF4C1S7meYqZKyOsEH
	 kh0gWdxztK7CIV6fSSSI5IRuWMwDeGL8VfBLRVDtHg+x2cgPaChdVY7LuSyQyt+CqM5MP
	 OdsxEMRXkpVb6a0+ajIXsK1Xo+NLpaqww5sEuw82P3iQKO2MMlwurnenlZXcyTvlMRksa
	 0ZMursIk3u1ZmNG1E3+C05xmoFmK3pQMVl7lmda2qzp8q3Mq6pkKff9gPvKxv4VtHUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556792;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+jcKnVYuqFoSl9mm3gUiToUW8nQeAjri4DZljLPLHug=;
	b=GV4MlogW7i7H33Jl96MFTjQpAQtdTuxrmwVkDkC3j8EsEMhrgrQNV3VXNXYMMw2rEEW1
	 txmsQ5CS6zTGJx5Vl7ljDPXWyhOTckeo4/7lV2l4FQ70O4jSxWyX/0josZUWnFfBMgpAW
	 waokrJ++HOC+LBYcPXlnZZun72JuCXQw1vbU+m62mgLvyV7SiGEuNuLxTQw/I7yPUzUSe
	 vTjkQ0dwEqSDf09Y7xk/cNyG3F8D2w4HeYY7Vo0Tx2wNgBCVbZxAxDTIgycLD0NoCk7RQ
	 BNgBjPA69MEWfs6h44EG/MrOELlZ8iC+b7d8R9vBcmfbGrvrDtBk7tK0oOmEQc+WLqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Lpp/RYSu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D439606A319
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 04:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lpp/RYSu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39F21F000C9;
	Wed, 21 Oct 2026 04:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792556792;
	bh=+jcKnVYuqFoSl9mm3gUiToUW8nQeAjri4DZljLPLHug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lpp/RYSu9LYPBiDnuRqzBGfH829y6fJECUYDIJ5eRIpFcdrb8+r6W4+ESAOh1ZvsT
	 WOjv5Fg0qQLpFgpKXndwt+HBgT+6Rrog3b70+AU04LPVN5N3aX+6BbgjGsupm11cr6
	 rAp+r/W6fQJprffeTbHTcJlmSpsUmVHtGqvm9RkPPjlGgEWK+F9Ghj20y9rUC7HqgS
	 J5JhJqA6CSZDEf/LioSaRq632+KknjqvWrCeksqad4pJj3vk4XltXaHMsswkrRtcvg
	 K8R/tC4ZqNCKSAJW1y3kdhMvYmMETjoQE08rftaFU27iot5zcdRWuSYiO0YBDeaISJ
	 2DG6Pxz0AqDFA==
Message-ID: <sashiko-outbox-179780@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/10] NTB: ntb_hw_epf: Use the shared NTB control
 layout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261021042229.2280937-9-den@valinux.co.jp>
References: <20261021042229.2280937-1-den@valinux.co.jp>
 <20261021042229.2280937-9-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 04:26:31 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Currently, ntb_hw_epf.c duplicates the endpoint control layout with
> hard-coded register offsets.
>=20
> Use the shared struct and macros in pci-epf-ntb.h and derive offsets
> with offsetof().
>=20
> No functional changes.
>=20
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021042229.2280=
937-1-den@valinux.co.jp?part=3D8

