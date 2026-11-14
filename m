Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616604;
	b=RL6uK8/Th+yv6SiKkQGRYhtMpLNx+a8F04iekBleyqVmft3XMI1Mjytw+4jyMH/UbdxA
	 ogV9ldHCIbXRrGq5P1/dj26de0g5Bthl86X5luI4huGIbSz3jfL7IXk5DZ8cMR99Ra4wC
	 UTU7fEyaDmYk7g0tjaxkkdHSx1vPuio9Dv/5X8W9kODMcqmwKhoqaa8icZ6nd40ibyJuj
	 Fo7XHoLFJ6z++5HTxgR2LQbrgP8zPNVL/FVA5OwUMnoEGjeWgHpFUjO9jF3m5r+RcufJ0
	 4j97nSjHB+3QAH1aeQiF6nHt1j6RrpOMS2nSfn7Mf/rhRNeYKXutwlX2TvJeH6N/m8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616604;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Yp+Sk7rDpnMv0lHiRbr7ZiMUlaSaAn1mQuoQeSDbEd4=;
	b=1AUL2/J0YWXDGfJq8cP3WjO7PZnZdhv7V5U7Xw92Xs5C1avZrt0+4yYSXPsbkOCjn3L+
	 Ea0SlQh9374pK3D+glqVkvMzUvXDgASlhZfkYCwIIKJC9eJxazv5A1vRug4levnkLnxbc
	 s06rXeHzNUNjDOeYSolCyPzR9TSTLhVZvoPCftGXzgum/+Ybifsj9lAZYrMHdMGQSEs8I
	 Ak0ZEaAH/geauDPwQI3pVXjsD8W0+R9+LW9as8SAeXcm+uysZ2zdgWmoMt2a/8dF+l1li
	 5K6/6nbfj+O82ABXUNTy4BhmMtRCtPtNldrqfn0WPuicZJPLQnSorKBfgnhoKCVfGbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T08khdWj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330BF606A32E
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 00:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T08khdWj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DCD1F000C4;
	Sat, 14 Nov 2026 00:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616604;
	bh=Yp+Sk7rDpnMv0lHiRbr7ZiMUlaSaAn1mQuoQeSDbEd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T08khdWj3VwAp+xMgtz4/6fHawJDCJaJtNZp4R/OxcfnYUFbugcdtXn7z5ZCtj1Pd
	 9gKdEBLTIdI4ms+5BaNc0SrTALZ0X0u+nqDI/UQtljnsqW65n0wugqJJvCvcOkcoye
	 jupT/8pDBM8AhkTBwubxRHICp1Hv7rJXDb/cI0gMYvYRVRkhhD6AN8XapZS0DxRDR/
	 MWMstjGofK1t6X0cBZmQi930odE5jWrHa+dhe5Ouymk7Hu8Zwz8EvvWlvxlzPB5UUA
	 FgETJCmw+5qTRyX8URDR0Fj8qoOkNcyJf1yY+qXnqvG7qVgHvlO4o5FvSb3Pn2kOCC
	 WtLsnKzHearxQ==
Message-ID: <sashiko-outbox-213937@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 3/3] PCI: rockchip-host: Recover downstream
 configuration access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Thompson" <matt@boondocker.io>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261113-rfc-b4-v1-3-b91dcb502250@boondocker.io>
References: <20261113-rfc-b4-v1-0-b91dcb502250@boondocker.io>
 <20261113-rfc-b4-v1-3-b91dcb502250@boondocker.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 00:36:43 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Matt Thompson <matt@boondocker.io>
>=20
> The link status can change between the readiness check and a downstream
> PCI configuration read. A link that reports up can also fail to return
> a usable completion.
>=20
> On arm64, annotate downstream loads for all three access widths so a
> synchronous external abort returns PCIBIOS_DEVICE_NOT_FOUND with all-ones
> data. Keep little-endian conversion and I/O read ordering on success.
>=20
> After retraining, the controller can continue to block configuration
> traffic until its AXI link-down latch is cleared. Clear the latch before
> downstream config reads and writes once the link readiness checks pass.
>=20
> Link: https://lore.kernel.org/linux-pci/20261024-rockchip-pcie-resume-v1-=
2-58e54a5cf5f1@iav.lv/
>=20
> Signed-off-by: Matt Thompson <matt@boondocker.io>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-rfc-b4-v1-=
0-b91dcb502250@boondocker.io?part=3D3

