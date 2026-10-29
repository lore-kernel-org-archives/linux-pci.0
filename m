Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245327;
	b=ZUHT6U+l+KrOXZHLaE/qOJr9pztskj9w88KDlV9aALUb3rM1P+eDxbQuZLGGxP2HvzVK
	 5cWG0yOyzof8vu75IDGjzURQzbqukkTv93LjIZwOAOz1YPIZafuteEOaLzkgxUUZ0ccpG
	 ySiYhp/QPGCe6orgvgsUh7b6MQyRRhb2ebER/dND0Xu7SpHrbr5jqS3FNJqSDP3nusMQL
	 gfPQdzURc9xXwNdxPnRaNslZZBIk3dTRx8Nqhug3HUtO1HLYBinKu2Zd2cannExcZFTh7
	 gtVfNTiWhyG0Mqua/JdSxVOna9/0V8LaSY5e4aergn6tnlvI09wcMiCjWKUh3NprVRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245327;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PV5ZD1zS1p8UpL6yXjPlqmdprBj6rkVqwj7gcCtFbEU=;
	b=Wey/GBMPEjO0EqoSX97skVlKfWDAMMgKqoPrBjOoFgsxk4inngncqEUF3WSzNoLwEF1U
	 gMXLQ9gwjU+IaXwTWrCgSUL4zGsO2hZOu+3hiNXq4eJ0MO6QkwJDJJMfKp9XcDDk6ACRB
	 hWW0zMpZeMSHtzV6gjf6d0XJCnra2yirDYZnLI8vHPLjM+FWfgbXOjoP0RqBgo+XKgjYV
	 6FFMKg53DES8nzz3GU+vih1ylilwjwnICM5erHLpHjqJE3Bt0jol6/GPAsVbD6Zgq2wQb
	 aJUCNUmI0cCZuXuo0xEk+ZfkTnbCd592GOhXMI5aoi/EMp3NKgSwF0dfJrJJB+RFr8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfhuW3P6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1EE606A31E
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 03:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfhuW3P6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B0C1F01828;
	Thu, 29 Oct 2026 03:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793245327;
	bh=PV5ZD1zS1p8UpL6yXjPlqmdprBj6rkVqwj7gcCtFbEU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KfhuW3P6XI5FxXyo8KshH4CRVQ8JAyGJlVVffZd2ggc1qjxpIxQvn5DGZ8jQpmS+/
	 wsBEhCvWKB/tkh0ztNUVINzM/9SL1yXJxtn8UrfyCZS0wIuCRmIw4NuLWXhGIqXfEh
	 jZCd157Qxz1hNyJ2fbISvpu8fnSD8PnUwvrHbKObYv/M6AakGBngjpLQt+4PmsJeR2
	 zEwzPVY8O5o2cVGhKOmZfw7quThOI34H4ippJqio6CYuOjQFIxYfGen8KS099rR4CE
	 TI4PHVcHvMV4ch1ekeci1VayAiieNK2o8KEnj3D3+4UcSis1ib/I9F0iWkn++hnM60
	 kXn0l/JUFHTbA==
Message-ID: <sashiko-outbox-188678@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] PCI/pwrctrl: Enable pwrctrl for devices powered by
 a power domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029-b4-t264-igpu-pci-v1-2-4d843dda0b02@nvidia.com>
References: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
 <20261029-b4-t264-igpu-pci-v1-2-4d843dda0b02@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 03:42:06 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Update pci_pwrctrl_is_required to return true for devices that require a
> power domain specified by the power-domains property, such as the
> integrated GPU on Tegra264.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-b4-t264-ig=
pu-pci-v1-0-4d843dda0b02@nvidia.com?part=3D2

