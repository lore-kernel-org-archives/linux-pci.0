Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286326;
	b=05eqwklVHjm6W4uj18BhLbgHbRSZPWeen2ElnyrA8usOafpkPhLetZ+vnrua9ogRLv1N
	 YGGIo8iAbQMQWyi20kwf6W/DdZsqZwksTKT9kV84GLRNSpa69d4Oa1WVkR8IHBThGcAWW
	 BygRtRXJFvqk9Qp8bZSmm9RmnBO4YmRFKPiKd2J3S3RUYXCPSvi17T9mHsxKr2puZoCXF
	 UKwPzenK90jS63adX4DRI1RfrSsGixNJ6yi8vljCar0fTKa/RtKhgJ6rSyMp6S6r8rKeh
	 84+xXDWAWyqS/FHXjNBoRtGV9mjzgj5e7zxqoGX1kqgHZIYrKuoTgjHnWtjmQdYDOEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286326;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=75FJV/obhAoNl3wBroANUcEk1P9xuHLfQtpxK0R6exQ=;
	b=iPt5Y2Gn17t5FeX2cpClqFnRoeDrippNJeRiOGo40tamGH/KFk4P9VAyNbJxAq9K+rbb
	 UcUifin9x/Bx4GCChDr/GtmJ1ZVZKmG+x1H0hvS28ruj5DCBkyKQfxH/zP2p0GlkXAtrv
	 leuy6jrbTp0rLrMoJ5/F6FwNrmIixXXiUlC7uIw8PemgTlGRFMvdtx+vJYJUHac5P8cVD
	 71Vkk6CigH4kckpHrXgirZYSochEpl6DnQXji/ENOHzMrIsT/vgRDVdh0Z+JQcCbEzguv
	 ZHwZnCsz6hodcya8szs0PteL89PjG9UE8qqGjh7BON6aW1lljajiggpgcTgCKrFi6dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eY+SDXio;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4707606A31C
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eY+SDXio
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748621F01825;
	Thu, 29 Oct 2026 15:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793286325;
	bh=75FJV/obhAoNl3wBroANUcEk1P9xuHLfQtpxK0R6exQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=eY+SDXioa5WxdVbYM+q9lMlUVlnrUKv8Al+k7iXLESZ8guGThNNO0ABVe0u8wF8AU
	 qseNjs17JOe5P5CbBLPMLxRTXmDkgUgfDVkkpF1bPP9YIkR4IXycv8GRm8mZSkfPm/
	 VO2HW0bYvMR43W2KhjNppBrt7z5H6lKi2qpYDfrcvN3xRcGmVUFYXKaPpY2eRP/E+I
	 r8MbqnLt4ao9zzs/A1CTT8+zuKXrTsPWc/5G5CUExhjvRGq6UTXrxse0mGeoVutJes
	 3WoLhINbuoUDdKUJ177cbsvsus4ewpL0rEzit1gXBdQ0LQZqUQwoKAHcAz+gBAYT8s
	 qGhOi3wZq86rQ==
Message-ID: <sashiko-outbox-189575@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 12/18] PCI/CXL: Add CXL Device Reset sequencing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261029145703.2185231-13-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-13-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:05:25 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Implement CXL Device Reset for eligible Type 2 devices: disable CXL.cache,
> perform supported writeback, drain transactions, prepare the IOMMU,
> initiate reset with Memory Clear enabled, and wait for completion.
>=20
> Observe the 100 ms post-reset quiet period before polling Status2, and
> treat an all-ones read as not ready. Treat Control2 command bits as
> transient state, restore cache policy on exit, preserve the primary error,
> and abort when IOMMU preparation fails.
>=20
> Reuse Device DVSEC discovery from cache initialization and keep the
> reset entry point declaration private to PCI core.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029145703.2185=
231-1-smadhavan@nvidia.com?part=3D12

