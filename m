Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905796;
	b=n2Ud/eFFN3LQSGNvrys1aISN84qXrF+FKFkOAm4khH/l/ceSR/kK++7prFsfH8gXB9SI
	 kgoj7ii02HR/9AS+FjIS2SKg1dHheqWUmvFHE2Xpk5O7vVd8A1KB3h1dQHYq89k2iMS21
	 55LHNATf32n54cQpCcUu1PoRyLEPikm+vsl5JR0L/evCcqagclSyzh1HsHwxw1rYDfWwy
	 Rq8Bx9jsNCF75myRXmy0CMY2s8OTl0TYJSW6WJd75g6CkYIc9ngf+EHNE12QM5Qq9mynP
	 pkI/YmtaZiqXXrYzAphPWuMKvsxwubu1joF6SRVUsy6qhh73EC41rfMxEfMUwsmKYKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905796;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HeHTgWcexDLeRy+g7KHRWDzi+s3KsRUpV9pH7lPmrk4=;
	b=U991jFG2veAwp1H2mzBD2I55AGXVTWhng0Hu5eVTVDqXYD4GUA3d1xTrW4HFMzddaGYl
	 Jig9QirChm6W9UQJcERe06r20XGdSRVIpURk2KdwFIHPgTe5BWR1DCVI8sw6eaxZnUWz9
	 oZQBrhl46hWWdRJJB9MVUjA2RU1mPj4xe0GKHXS02jemEXZsfLTBcr9SuPUECtJ2yqIIZ
	 UHRj+udwW7PVR2V/geKf36kMDKmF9U0bwcEoKrlAeigkTupGAAKMiwPxtF04ls7jzXtdn
	 xcQhfZIyAsd/9C4bKMVQswrY73SWsAfKt6isHwKY6BkuVd/ZmHhmlB6zzzUiVHJ7FBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uimbfj0D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F1E606A326
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 19:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uimbfj0D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C23E1F000C1;
	Thu,  5 Nov 2026 19:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793905795;
	bh=HeHTgWcexDLeRy+g7KHRWDzi+s3KsRUpV9pH7lPmrk4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Uimbfj0Dv1pUEkAICUjjhl9o498xqRhSXjrplqXlltyOZ5FF+xrsJdAKA8NbZ8jUJ
	 uRFfr7LJCHsPu3//kdunHz0fHTk1XxpkdOgXKxzZaFSJrmecy7Kg9be2H3ghSwy+ju
	 7e109YHzH5NLrB+/N3rKjZ9Xnas04WGyGUZXmf9UGsWl2Ssp7kziGVFRyeuErYy4JQ
	 73QrPn7j9RKHLGpzzTZgOZoRT6T7VlkcqHyrSmpIDRVOH03aquS7hVWOi1AUqhKGEM
	 S7Omdn5q2BwmDxn7oQQDYS7QLuwV7pYGczCGT3DvzVx2NCZS9+jBd3P8zcWdEQhnVE
	 cOHZ7L0xUONfg==
Message-ID: <sashiko-outbox-199817@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 08/19] cxl: Move cxl_rwsem into built-in code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261105185917.2667656-9-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:09:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Keep the region and DPA locks available to built-in CXL state management
> when cxl_core is modular.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105185917.2667=
656-1-smadhavan@nvidia.com?part=3D8

