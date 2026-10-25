Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792903228;
	b=13Uda+RLgxQk3BwHXHflK5rjTunFOKnf6OtDPUYbTyzrqtHYAkiy+4oai7iIogCNwhtf
	 d7wQuV96TrTARIAzLm0Zmn6VougnmjxBUn0WgS2/MKYttzSBOKehEe3oY2fmqWV4IceMS
	 C4wOWAVCNxJ7ErelrYzbgvrhfOeHQPnS38UVJoqNnHRyebyWp3QooAm0kt9Ml2IEcG6X/
	 NIddUhyuWHYfSMdeao9WFwLUUlwTUrvKM0uzQyQ/B69KL9xwNwpjNsTieb+yekqcAmHcm
	 H2DLa9k8dKciFoOHppUl3QWCkga1OhWSBQ7gaiCO3717nXR2fo/ErvJG3eaG2IiyOZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792903228;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ow1sr0ySG+5XDIxNahFaZ2FvZsHoJ7LrFYwoMMDtRww=;
	b=Dyc9c9KkEv+QHUG109NLVhTd0VBHdhE1DMJSocmUNZmeczYfv5ytTLRaQ2Wd3MjtpAYW
	 wJRJBnd2rLm6VFL5aKFrJf7kuG6OHSM82BRfkhYbiFpIjhwRgZDGuiDAwQ8HIfLm/maYV
	 qVa+l/0o80hLaDfnoJ0FGCKeyq6C3ECWOKje6eOpr/TaQgrl2w5+WoVL6qAgs+PyP4Yvg
	 tVPAIKIqD+c0UjBmY+bLnMnqxDdOIouMCSfXyDeH7JcOmfYzRtgE1gk3DOyvUbGYKWjnL
	 CIjMf4Ys/mgOtYaYl2LWBiBUKKK3UZbNZ+QhVSZ726POomqqcwOiXcTuYYVKj8Z9xHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="e/ZAM5gD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1CC606A31A
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e/ZAM5gD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0E71F01825;
	Sun, 25 Oct 2026 04:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792903228;
	bh=Ow1sr0ySG+5XDIxNahFaZ2FvZsHoJ7LrFYwoMMDtRww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e/ZAM5gD2zCQLrI/P1zjo/5Msu4N4tKn36DAs705SxCEgg1VWSqXRTTQ2DdV0l7lZ
	 AJJytgifRCvT6EYovcBM+8F1EQTCpTGWVL61cSTgrnAudoHNKKfIsiYrr846wFoZvo
	 EnxxM1csEf+jcWWAGqzhtYdLaOfga5iVsW0u7eSH11+9fK3k5F/795BMI+xHt0vQnr
	 1lkCFBImQBfhqA+DMGKC4TscEX0SxGJl3E8egemYEcmq4u3eNPhKYkPW/Q+WP6neB9
	 vRfjpZM7QIsERyG1kyBYQthhCrxl2rX60V4fyn5Zvin9rMC7qE6DnOfEf2uFRNLH3T
	 7QykFukY8XAuw==
Message-ID: <sashiko-outbox-184074@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/13] drm/amdgpu: Catch register access while GMUX
 keeps the GPU off
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261025040046.1602-11-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
 <20261025040046.1602-11-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 04:40:27 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/amdgpu: missing skip_hw_access check in amdgpu_device_indirect=
_rreg_ext()
--

commit 68a505d63bba52b15e530c1a5a5c68524afaf59d
Author: Andre Eikmeyer <dev@deq.rocks>

drm/amdgpu: Catch register access while GMUX keeps the GPU off

This commit tracks when the GPU is powered off via GMUX during runtime
suspend by setting adev->gmux_off, and skips and reports register accesses =
in
amdgpu_device_skip_hw_access() and indirect PCIe register access helpers to
prevent hanging the PEG link.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_reg_access.c
> index 7468855c16a25..bb5dbeb7fa721 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> @@ -594,6 +594,9 @@ u32 amdgpu_device_indirect_rreg(struct amdgpu_device =
*adev, u32 reg_addr)
>  	void __iomem *pcie_data_offset;
>  	u32 r;
> =20
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return 0;
> +
>  	pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
>  	pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
> =20
> @@ -677,6 +680,12 @@ u64 amdgpu_device_indirect_rreg64(struct amdgpu_devi=
ce *adev, u32 reg_addr)
>  	void __iomem *pcie_data_offset;
>  	u64 r;
> =20
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return 0;
> +
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return 0;

[Severity: High]
Was one of these duplicate amdgpu_device_skip_hw_access(adev) checks in
amdgpu_device_indirect_rreg64() intended for amdgpu_device_indirect_rreg_ex=
t()
just above it?

Currently amdgpu_device_indirect_rreg_ext() in
drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c is the only indirect PCIe
register accessor without this guard:

u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev, u64 reg_add=
r)
{
	unsigned long flags, pcie_index, pcie_index_hi, pcie_data;
	u32 r;
	void __iomem *pcie_index_offset;
	void __iomem *pcie_index_hi_offset;
	void __iomem *pcie_data_offset;

	if (unlikely(!adev->nbio.funcs)) {
		...
	}
	...
	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
	pcie_index_offset =3D (void __iomem *)adev->rmmio + pcie_index * 4;
	pcie_data_offset =3D (void __iomem *)adev->rmmio + pcie_data * 4;
	...
	writel(reg_addr, pcie_index_offset);
	readl(pcie_index_offset);

If RREG32_PCIE_EXT() -> amdgpu_reg_pcie_ext_rd32() ->
amdgpu_device_indirect_rreg_ext() is called while adev->gmux_off or
adev->no_hw_access is true, won't it still perform MMIO accesses on
adev->rmmio?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025040046.1602=
-1-atharvatiwarilinuxdev@gmail.com?part=3D10
