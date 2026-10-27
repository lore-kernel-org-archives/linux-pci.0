Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118548;
	b=HmQ3t1LfVUcw/qF/4cvSJtkDjKc4IiiWQR+DM+YSvI2r7wU30DA2t+HnS+SsPnJRiOni
	 +uyGz0lqwINk/SgcteY0/7GF/pE42VZfHXua6SMYTd8o4xX3dlAK90u5L6EnjUWO2QcMA
	 Ir8vXSZoy44YsVtdgEWiwhnjdkft1lnUib/vyWvCnLxjgqo2aDo8peZR0kSu/28YPj+mr
	 qZ2iDencXWHO8fnlVBpdLCxrpqT4gO1kTZuqX2Ji++2KGuytnbHyC7t4AqT4Nd4AXFmDs
	 TvU4mGRqIzASrTbRZojcj/DOPbvPxBhfOWnAUkYVqctmYBb9vIDpnwPHVgxoQO4bwTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118548;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ex1BgbTwaVZ2VLHW94kgyl5P+fiuF6LyzqCFjgH+GEA=;
	b=FacB90mYgbkjKtDHh0iMtcKHbzP8KKozFZhqlUq+tzLkg6PSUHKQjd7qxq8ZbGVfwEdS
	 UH0Os3PrDmkYfA2+lSbOLazyL4G2PxNBhgpibbiNRp0Z67pgfMg6KbDJJAN96GLOBT2Nm
	 3+zAdABWBlT8kKSWge0p4U07BgLyQWDxOLUiE+ADuniw6yAmUcNqDrEVjgCNQBXHUgWDC
	 1R9STr1NeKDx7XDNna2RxZWwYdkJVRkZNAIvTN6hlwNPepteD9Dg+Ym/3Mlb1mKBlP53u
	 Saho3afJx1Cm+QlHIi3qiRIGZumDTpmsyDdoXDSOHXKclI8mxP42P5MXKrlXPdzbQCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Brxwy6uv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2FA606A320
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Brxwy6uv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE031F01829;
	Tue, 27 Oct 2026 16:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793118547;
	bh=ex1BgbTwaVZ2VLHW94kgyl5P+fiuF6LyzqCFjgH+GEA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Brxwy6uv8pBhl9JXWqctyatLI+ArmwzMRvVopB/QVs+5W0bbrxJDeR4i9Is/lgX54
	 CcPD0pWMPcAXWWMxwkJ3xGLAS/F1jRBIi8tHHiTk8joQYTfiMNGipeDYAsjb5usrtE
	 w4Go8Vj3/5SVfpKKABdMB3AGctoFCfeRly1MABXF/bpm60snOHrrkB+mmh8uHUZCN4
	 us/xYLKUX8fB54XsIqsTGaI+Fa4QtDyWd+WBKQvOCcyBVAwZSiRibCI448L7qc1tzk
	 3hg4sTWAwZYHvCWxDYaNjrJRjnPy65QMGjHgZn/uQZpM5xAzTZyCQldvy15VkTAdVT
	 tNI3i8cdtnytw==
Message-ID: <sashiko-outbox-186914@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] drm/amdgpu: Match VFCT using initial PCI bus
 number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027-vfct-regression-v4-2-0e7190e39c2c@amd.com>
References: <20261027-vfct-regression-v4-0-0e7190e39c2c@amd.com>
 <20261027-vfct-regression-v4-2-0e7190e39c2c@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 16:29:07 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> VFCT records the PCI bus number from BIOS POST. The current bus number
> can change after PCI core renumbers the bus, while accepting a mismatch
> based only on device identity can select the wrong VFCT image when
> matching devices are present. Compare against the bus number captured
> from the firmware bus assignment before bridge renumbering.
>=20
> Reported-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
> Closes: https://lore.kernel.org/amd-gfx/20261014080523.186533-1-rezanikza=
dch@gmail.com/
> Fixes: 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with soft=
 filter")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-vfct-regre=
ssion-v4-1-0e7190e39c2c@amd.com?part=3D2

