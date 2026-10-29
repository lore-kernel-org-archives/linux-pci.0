Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245327;
	b=C/pSH6qthJlRBMm++dAkfa1FmKwtdzLUJ5FEedm93jH0LPbwx6EtKxrf8ET3RnBYaGMJ
	 6Hj8ukFUqoMa0/SkqDn3IWD/UexLPjUYgA3RWmtGAV3jrgllCa2vXEvPudyVW1T/ENpRk
	 j/I5Oqb4C0NMamP+bSAFWQXPc7jIFJkRsIEbd9FWE3LGBZ2zkPW1hnSoIf0ezICUEDv1H
	 Gz9mGf9S9tm456mkBSJHCjr1YjJHSXG9NvPv3OUlv7WWJGDmaVkbO8ME79zosAVCUpRkD
	 ty/jOWTLl9LkZYJjZtSgrMFXPDW+SD8eWinWOYDtMH7/6o7+HAizVjFr36zjXz0mivw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245327;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ffsLdL4Q2SvvYmdTuw4+1hJvyGWbco4LCh2zOZa3jMs=;
	b=TujEkXDkob8Q40IHXqEIhfSiFE+E6IFs14gkZ1irUXyya9JhLM2arjNIfyouhBOnlZWX
	 9F9f2LzsYno8ycd1Ix1+RGuMvChknoBiEpQ3POPSH+2SXrpBEHy1GnHBowMNDvXh2hZx8
	 cwKJT5I4sCaWqh31hI+d6klARJydysUMJVo1Om6nhFsj+iTeLuLWb2xEhHO8BaybqUX/o
	 0LgMFSbc/RRDwaqzlNzOwuyoFxGSqJzWUgiBfBOK6grHbPi8pXwvZSnrfYoZ/3XE0JAol
	 xD8ilfXot7+BGE+8VMadx817d1bmYZG4kn6oJn28PMBHcKKg4d3bUZw9dr6vDHuACSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHcnY0Pw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE77E606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 03:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHcnY0Pw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D9F1F01825;
	Thu, 29 Oct 2026 03:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793245326;
	bh=ffsLdL4Q2SvvYmdTuw4+1hJvyGWbco4LCh2zOZa3jMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SHcnY0Pw2WCSENI6pcRgZi+i3TO2AYFS6Sg+XxGWeaZ1rz/68QpWbX6ptUTho65O0
	 491e86+gd4kFIjdUPI1FUBPd69/nmm1Tio2idqd6ihVDTmie+5gq3varOih0z4o0OE
	 ufKZ2V67hFX868eF4sIuKm96104cdgnx4NhsmKtcT/wm0PUDHaKD9OTmw8vo/0Jmke
	 PNzj9QHNhYDoV7HifMZZkwGXFrkvFmsQ4H9qjyNsz+xq80h7N5N1YORi9tik+UMQFo
	 Y6o8tcikNdDNhkjqWpU3PpWRD4/JVt8DGKqsrceDqHARS7tsaA+dqGa04DFjXafDyP
	 9gdez/dsANcYA==
Message-ID: <sashiko-outbox-188677@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] arm64: tegra: Enable and mark the Tegra264 GPU PCIe
 controller as ATS supported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029-b4-t264-igpu-pci-v1-6-4d843dda0b02@nvidia.com>
References: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
 <20261029-b4-t264-igpu-pci-v1-6-4d843dda0b02@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 03:42:05 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> PCIe C0 connects to the integrated GPU and is internal to the SoC.
> Therefore enable it directly in the SoC device tree file.
>=20
> At the same time, mark it as ats-supported -- the GPU issues ATS
> requests and this is required to enable their handling.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-b4-t264-ig=
pu-pci-v1-0-4d843dda0b02@nvidia.com?part=3D6

