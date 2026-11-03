Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741487;
	b=b7xb9FdQ1T7+gvUBDs4XAO16nhdFYjZTbdidi4SgAmabQfleqJt/iPVkPgK+IL4BG9Wl
	 XozALot7F+e+PX6unouylo2Se2fHfr9rM7zugCm0Nc40/Fzp8xnMRZi1cjMH4e7A/Vg/a
	 nlAas6Z8nS32Q0j+QlgiSQL40FwoMPECBvoig5iGobCb3IMNHrCOaUMNYgVnBexKy+9eS
	 Zlr5mYsxbGcG2GTP9gMMqohvs/SB3h2Ysmcrkx/WUctlaoA6M1L5FmpMP/sQ4k/XYayVC
	 DvPHapMQhWXq+BOKGk2jnIQuJVYeRFo5vWOxN/ZhechBkKrobeDVSE6rXuuUHL0JgHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741487;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X3D0A/fbW2lwR12TOPybhrpYw+mlQJMx6oq2yN6oTLU=;
	b=Fq8KOAOPjKa39Qp6xF7E1vUTbwMPu+XIOsJS4FtoDsMhmVVWfAyqL3oWddyNWkPwoqBW
	 ADHykuWkMImliIKEJgXvRZeQMlhLSDw0fdhvJF7DNgiPJplUKY0dRwQ8PYrTQ6yj58Yoz
	 lsPxAJfl7EXo4hYymShI9UR45rrFZTdVSJ7tGSc0mE546fFM+i9TM/FJB1BDRSwHTHGz8
	 nFRVKffay/uqMW0/92GoNp+nylvX/jxE0V5BjKMM2kN9kBev6MaemZnI2Q0fZddjf28XV
	 zU97tgvhEBuCkObQLkl4znUgvGAqQWgpeuzqstJkszYu1pE4UqciV3izY1GK8vuHfng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FGabsBF7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1C6606A324
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 21:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FGabsBF7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423EB1F000C1;
	Tue,  3 Nov 2026 21:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741487;
	bh=X3D0A/fbW2lwR12TOPybhrpYw+mlQJMx6oq2yN6oTLU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FGabsBF7v+a0HSMrCeJeT2eoB5q2yXiglzGcHcWx+/+LLzsqCfveUAlCi5N60EzAJ
	 Lu2aWpF0H6V226KUA8uu4xbpCtfoXvvJ9D9sTchGCdTmeBEp15/EAMZXRbHw/CiKIj
	 kYSZnLsIPefRDWEpxmR0M/Q+R405S8aJpxIIIuu+5HKRFwE1SbBBNCNmZdib/taz9o
	 qWQNbZO70NsolQDdXSIkH8KU0e8bn4I7WjtIyN51BpQ3pkSNJNTRg6PRa9DwLJUDzX
	 RZDn1gwrStkFClhMQPp7z1dQi0GLHzuJ1wyQlcnhQG0ROJo8Lx58FiX8hs6k3AULFI
	 YIUlW/GHVwMXA==
Message-ID: <sashiko-outbox-196055@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] PCI: replace chan->device->dev with
 dmaengine_get_provider_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com, =?utf-8?b?b3BlbiBsaXN0OlBDSSBFTkRQT0lOVCBTVUJT?=
 =?utf-8?b?WVNURU0=?= <linux-pci@vger.kernel.org>
In-Reply-To: <20261103212924.1780217-1-Frank.Li@oss.nxp.com>
References: <20261103212924.1780217-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 21:31:26 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Use the dmaengine_get_provider_device() API instead of directly
> accessing chan->device->dev to get the DMA provider device.
>=20
> No functional change. Prepare make to struct dma_device private to the DMA
> engine.
>=20
> Assisted-by: LLM
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103212924.1780=
217-1-Frank.Li@oss.nxp.com?part=3D1

