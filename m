Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441240;
	b=KHCW6UcxyH0d7g4mk/eKQpOr0CaBNVZXSVM6TK16YvRTjK1EntJA1upl+UYvxdZkOyia
	 1ORfLqwKZdNv5MNjOAHUQi/Zi6RJwuvaQwXm+coCJO84TRJ3n5a4z11baF6mWYjJWU7Eb
	 WVDm26ctL6wFPLv9vDzEX9SVD/Qex0hifiWVJr7DBJ3eNPdGNhnUkN692TJa0mgHGIjqb
	 hbs1iw5trQZYMhKz9DwNDNNTuBI2mf4T1/IS1Df4ICjzkl7EGSxrBown1wUVpb0ghXibY
	 Dvjc/FJDKetLQQDNhr0Ty+E7+VUgg8F02Ftd8CHV11wWpZwzWHzgkjLpe5uGvfUnilQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441240;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hWNwR9LvFxD10mvfJKkrPL3z0R5vhKJZZgj63DN7SPs=;
	b=QrO1dPPuFXq54dlvsGMEthFd1QkIlv0NnPR/UdfzU2GySyL+MurK9CQ86BqXot+T9QT7
	 MuOfWNX9qbUZw0bKlh+LTzzWQRte4SpIF55G6hTX8QzvGCuo8A87JnSvbkYnyjyiqLPKw
	 8RHJfrf69I4Uh2fqaHc+JxBKX0gudIEOvBAG6KxIYv6ldLaUFrFbKXwKNmMV266G3t1S9
	 YEDdcsTAKn/ziAaOcNKPn3GaiGLcmkFGeCiOZKTKYvPydy59cOZT88JpvT5kgqjfRMpKZ
	 aY66PCtxqOz3f7Wfs6ZEZ+iZrjn3dy2cEb35sIVTaq2TsBYxsZK2ipv5moF4wvXJ5gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uij5559J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F040606A324
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 23:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uij5559J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B40A1F00A05;
	Wed, 11 Nov 2026 23:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441239;
	bh=hWNwR9LvFxD10mvfJKkrPL3z0R5vhKJZZgj63DN7SPs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Uij5559JhbwuKo9CH0QqhpEohctx9rTEEzdfP9TxI4BjfHtwNlvv9a+KCOxwSIEXQ
	 mRh/TYwDXC/zJJpQygTyZ0ya7RubksSTklY/2A7oCKAzptP9rxxAEW5cvoCmFU7ffs
	 jVfsB3Ba9Xd5+XASC+dYjLjAx0Vb5o8/DU9SQt4VkkQhaVtfsjOv9sWUnMMmvVw8hu
	 qsOSL9LCH4s4A1t/iJ9zptcv2e+Oz7R7UBQjUnHvHNkZ89KZdShDy8zgavvoG7Qk+H
	 pM61f2Mnc0AL32P5+ctfzAaTELWUk+aKIqKBjqr9UthZ5dv+jF/7hTgVTjW7zqNppv
	 aYpMrU2UAPJ+w==
Message-ID: <sashiko-outbox-209865@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/11] rust: pci: add num_vf(), to return number of
 VFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Song" <xinmengs@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261111223337.508989-5-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
 <20261111223337.508989-5-xinmengs@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 23:53:59 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Peter Colberg <peter@colberg.org>
>=20
> Add a method to return the number of Virtual Functions (VF) enabled for
> a Physical Function (PF).
>=20
> Expose the query in the PCI core callback context and return u16,
> matching the type of the VF count stored by the PCI core.
>=20
> Signed-off-by: Peter Colberg <peter@colberg.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111223337.5089=
89-1-xinmengs@nvidia.com?part=3D4

