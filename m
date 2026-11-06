Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964415;
	b=WJEZ8+eKtOQE89Hc5x1C86i9GAXPRHjCGXffBFGkhzh3TbvqeAnXA94Cg7bIZ1RgIDyN
	 c+NpWh6gx7HilwiF0i8QUsXkXmxu3AV2rP/3fuxiUAaaGwEnn33aEK88TKWfqco1uyNiH
	 h7OW61wmgZmNOkPaZojcsj1Re5QVlXz4W9BhQfdI3N907Mx7yX/+r/h4x/2kILK0p2zzR
	 4wyKxCil/5Ap9hJ2teWZ6FM/if6HAY7+znILczwHyO63zsi2J3P3GypoiolQ1vBcDBG+N
	 fAw43DvbZFTPzcFUxi5IZ+dvjrmFo7IxAHLUKUarWzUFTCzhOWqhBNFs14yQCPhj9IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964415;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=W/2tGafo1T2Ae15uL+UDC12ICrWiVwDGtu/FxXzKZWE=;
	b=pfpB7t4mu/8O39HKKncr4GpVRXTeWqqEyVKobketZodbH0i4I/K9wu3ZHmF+oKYocqJP
	 2Z6pUP2XNWPl6sN6iLbBb1mQWLRVmrZIBlIh6jyKcyc6lKZtR0ThtAzWiPbGFxdTg4sPX
	 +KPxbr0o8Y257xIKRR8juwMsbnMffKjagWSKdYBvxz8qErJmCkwugJk4Cl9LAnoV81ceY
	 NGeY+zKQffTPqBnn2aVyjkfe/5MgRacAxwTRv8i7g8ECaVaksIZ4ANHeyO6L0IfR6IP9Y
	 g+VgcxfLIzXhjSXgW+me/Yk5W1LZwj+oNmI68SGOpRF6U4h2sVEXdndvK15224QVPZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxX6qidW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA9B606A326;
	Fri,  6 Nov 2026 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxX6qidW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3B61F0089F;
	Fri,  6 Nov 2026 11:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793964414;
	bh=W/2tGafo1T2Ae15uL+UDC12ICrWiVwDGtu/FxXzKZWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VxX6qidWTj7yi+Nj8RnYzNerq3ADUc2zS4wwHvssS3byFJApaVD6AG1a685NuIG1k
	 aypALBQ4TeLIZWC0WB2q5m+/ZNXZ3KEVlcS5bWGLkyqrln/mdjkwNCL4YXaAwNpxyB
	 dngNjmR1A+hFk1ECizPOPlUZTi4pmk4xg4dXWQLklH3hisHuIkqFNny/PhYX9W5RuU
	 ZCGn2nTS+g6rQZ56PBdozJ5CnWHouKiHUJM1yM5HukMKL2/lfpILuHPggfxFHRcNT1
	 EU2DYOU693fJTko3ZGdxnz4wOf4FpWztAcCslGe4iTO13lPHdgnS6/jI3334tSKMes
	 fB23THSen9JQg==
Message-ID: <sashiko-outbox-201313@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] cxl/pci: Guard decoder accesses after reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261106111829.55823-3-icheng@nvidia.com>
References: <20261106111829.55823-1-icheng@nvidia.com>
 <20261106111829.55823-3-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:26:53 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] cxl/pci: missing Fixes trailer for cxl_reset_done() bug fix
--

commit d141a119957d4d69fa73f6cabf565bbf7fc50833
Author: Richard Cheng <icheng@nvidia.com>

> cxl/pci: Guard decoder accesses after reset
>
> cxl_reset_done() runs even when PCI state restoration is skipped.
> Reading HDM decoder registers while the device is inaccessible can
> trigger another error.
>
> Skip decoder checks if the PCI Command read fails, returns all ones, or
> Memory Space Enable is clear.
>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

[Severity: Low]
This fixes an unconditional post-reset HDM decoder MMIO read in
cxl_reset_done().  Should this include:

  Fixes: 934edcd436dc ("cxl: Add post-reset warning if reset results in los=
s of previously committed HDM decoders")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106111829.5582=
3-1-icheng@nvidia.com?part=3D2
