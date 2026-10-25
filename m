Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792902659;
	b=sIx8WOADdmDqnxYZzw0yIpPHdKbT0PwtRCXjYsj5t1M5bPT9Jq8zyXzewCVlYZ2EVC7t
	 Uixlpcel0WXGwS5ON+vNLiGHtsU2bMBNMsuO4VafWEiXHH+lxAtRD6jnA6zLoJX5AlNsL
	 vNuGwEv2cFoey9IZSucZEC2bC0Y2HeQ0LHHkIsbrRHuWCuxQREPaqrMpvI3nmKgGoW0nN
	 3tNCqoDgGA5jlVjkUPT1EbakKXZKVtmYVmgxpK49LXEB9IOVCPJjO4yxDXAqj4R/CmY/H
	 yHJ0slyysFx6beNWGSteEjeNJXgMXguRqYJUOZWuWyQHdgIzxf5Gs0h4Ytvtt71yd9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792902659;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xNam6zOCCeXr84iPsTXH9sbrwx6tFz6jDif/UN2LT3E=;
	b=XAVbE5vONKdzvcfV5r+hZur5XQ0WjRxsHalln5XgZ6NBGZQI8yDPwH3+jB836Exn+ahw
	 +8q0/bjm0i/xJDkJWgz8fvlKU79p293HlU7uWJlmnbanC2zzl4T+NhoSkyc6qT+oKaRHI
	 NdC0oQcmBD7Qgp2CdOQXcNsrAJob72Z4zyEJMaJlXGL9U4brqeaIpUJWYhd7SnzpV75t5
	 zwhLNAZwlKcjWi3fIEcLNB55h54Rd82uKCO/7KewXtwYHG8R+gDIUO33L/bHC0zeTyAsT
	 BX3xXDrypg4WwqbgB404ZCe7qcnoJwOFev8gkJnejI3xVSE0zZrbs/8XDsYvsqb9cPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LJTQ6J4Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17F7606A31A
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LJTQ6J4Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D761F01825;
	Sun, 25 Oct 2026 04:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792902658;
	bh=xNam6zOCCeXr84iPsTXH9sbrwx6tFz6jDif/UN2LT3E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LJTQ6J4QobvHP1p0Z9KXcBvOyM0mGdiRe57iCVlUiyfj/MAQ2v4hOS2uuP9dnT76l
	 3w7P0xo7p02ggh6jZbiBvJq8J2znw2JEjA8jIqOV3LHjhEkx3rYnpmKG4uQ3xOttHc
	 25Uy3+il5aw71/onTiCOCSSl/JC8napVAeJP7KTTYBCuhWjubd3tx1/QZgqBRK1orl
	 y7hyGjuEXOj71ocAxKLP0KPSq/IHoCd7HbyNRq2vRWJVi3RfzVq03c6gT6qnyV0iKl
	 R3uXPWBeWrxOa52Qy+LneR1RROtkkJEdA6yt21pZXFQuTvExBSX9IQDY7A1AQMDrW+
	 mqurhur+XSebw==
Message-ID: <sashiko-outbox-184067@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/13] platform/apple-gmux: Add check to detect FSS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>
In-Reply-To: <20261025040046.1602-8-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
 <20261025040046.1602-8-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 04:30:57 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> On MMIO macs, there is feature called FSS, we assume its
> a display syncing technology between internal links
> (for example 5K iMacs).
>=20
> We detect it and then warn the user about it, if its broken/unavailable.
>=20
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025040046.1602=
-1-atharvatiwarilinuxdev@gmail.com?part=3D7

