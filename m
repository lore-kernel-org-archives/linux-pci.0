Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245374;
	b=iDeme2zNhnzN8wdAfHYg8MB36Y4h9SoKYjj5uWyu9gYyghU7n8h/kieboJGU0YsKuC5o
	 8hFq18fpcGLnRCzN6G6muMWd3YncGI9NBKuK1uTFUwVpuSO4qWawOg3Fi6awfUPqeLmSb
	 d9UqGMesSEVbCYISzPJidWXNj3pyXji6LsWyV5xBjO+lpG6gvCpmX0WCJ/NzLo9MQVguB
	 9xhyf5Mhd+kYVbHVGR0u/CJjeAnrBBmVYUp/BYSk8EjfZt4nLLOe7rzd0UNaT9aBI2yYk
	 ZxzBsT9iVzObdWvUyAd2XN7KmaV5mMuYlI3ckIWZZbpBtpD7ir9Qn0SLXZPlswm1HXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245374;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=StH3F7dhFQFYvpts6r8NxqqpOn2x0gom1yMEYmVG6K8=;
	b=A243s+zRwvhlhcMYxUZI+S8qg0I09teGfVWn06PrtJNdPtMYcCaLvwt+5tLviSCmZuS6
	 nVNzUCPih84bVuYon8YVccyzBLuQYyMAZPWXAvtZZzmbV+L6GvHB919zpxlVCn5+RDHl2
	 wr71nzo91lYOvMUjG9W/G/k1XSZ1Os49bPkI4iTJh8IYgbwRF7GAYVP0cgX8/ToFSAWV4
	 LXhobO1m+qnQBpdYO6oQDY8sDg7ODRG6Bu7jmKkJSqu/nPmizb8XAm5e04KiRyE5k7246
	 1UlS8/TWr2bzw7Yo74xzBtLftZoARTWwo6WhXxaolzEdDXp7gypH38dPxg+FXRmni6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kmXaaYBn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46902606A31C
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 03:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kmXaaYBn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36751F01825;
	Thu, 29 Oct 2026 03:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793245373;
	bh=StH3F7dhFQFYvpts6r8NxqqpOn2x0gom1yMEYmVG6K8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kmXaaYBnLWIGzyo/YPtyvOuGV/dsHX4xxSN2c5F4dtmXWtwhaswsxxM7Qv6Vx7iaH
	 zKoMo3Z+Xc1TASyJzKK+w4nU+UkSTKpdAUMktJhvlfQRd0l66MvL8TXEz47Aa0exEd
	 l/QUMKcm32sS6udFxx8H2OxjVDtyENp42NtGs89L9sIs57xgjGvJ4PxnNcWKsataCn
	 9upLV3UCi/OB8nsaZVK44IeI83Y6HGd3nI0sYCH++x1eXMOdorM6/4BWvJelmWrEoj
	 hg+qfH9v7yP3zTwu9jt8zYWJVwWe4o0Q6bIwfkeHXIMU1w9PLAnekbarluHdeVQcQM
	 y9xNQyuShWMMA==
Message-ID: <sashiko-outbox-188679@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] PCI: tegra264: Power endpoint devices before
 enumeration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029-b4-t264-igpu-pci-v1-4-4d843dda0b02@nvidia.com>
References: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
 <20261029-b4-t264-igpu-pci-v1-4-4d843dda0b02@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 03:42:53 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add calls into the PCI pwrctrl framework to do required power sequencing
> for endpoint devices before attempting to enumerate them, and select
> PCI_PWRCTRL_GENERIC in Kconfig.
>=20
> This is required for the integrated GB10B GPU on Tegra264 that requires
> a power domain to be enabled before it appears on the PCI bus.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-b4-t264-ig=
pu-pci-v1-0-4d843dda0b02@nvidia.com?part=3D4

