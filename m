Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774527;
	b=XkHNbjLB0xUojhW+vmd4pVgl6BO4NUljGD6miAesAFSMi1pR1wgBFpTo0lBKldfEiyrM
	 2YYl47b1lFbiPA5ep/MFtv4VuGQTikTHUqZFmHnH4mvOGVJ+JLz/YlqtFhlppmsm1fDBC
	 fviTXo9W4AeTuxWwJ4K1JgSaAPX5uH0eEHGmGdtUG24/veMuYP6+KRdlKD4MOL/3cSGt8
	 YjVYVCmt1FpvOKHSpixqViQIAwVkly5xtx9iL6calrGiOD9B4dO75/XJYR2de9v7M+0/J
	 AXuO/6YNLedk38vZ2Q8LkaV3F9tETSHoj9kLUH4/jH142ktyM2Dd3/jbN7FJWG8ugLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774527;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WmVkda6wpNYL9WqNtk43JZZ5526Y/f6CIjrjD2KzyKg=;
	b=twqm9sYm3H1HgFJJnpPMPWpDDG+pc65jIfjvNX7mMuu+X2/O7pGsAoO29l2jrhqPgKkN
	 VHodkDfFFeh/k31TOoqOm0UHqbqFINiZtT3975iRB8CpADtLZT72uFnkJT+Zj+o8TAfxF
	 Hhv3WlmEpE47RMSURGkbshvFD374k/JbPM5WBJWdtjXFkkNOWnZhn8dyUvhaYHf7fNEOL
	 8NyNFM0wGYdC/MDpwnG6bVaXOUsHklSsAcw4+p526ftRTcyLx/kDQmtpmHvaBVkRUC57W
	 /YH7ExQPlRKInYwnQv2CdNPkidxkxDgvbCI+GOsnZzb6pVm5RcKKeA4VKHUAv72RdqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gFeuKOoN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34062606A330
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gFeuKOoN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC13D1F000C1;
	Fri, 27 Nov 2026 10:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774526;
	bh=WmVkda6wpNYL9WqNtk43JZZ5526Y/f6CIjrjD2KzyKg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=gFeuKOoNfA4IglimEMBSrioGPOXU+qfeRtljZfVhvCwHU53nCvse9Flh40efXX2eS
	 wBZwh0a21n+BW32V7zxxeO0Z3ODaRPk72D+2bIZpZgtY00Y3KSw9g+XQOnuvHVnTqP
	 7Uelx9Xp9O+DxU/ZRpWcCo7+A8C7x+XxPx+vbC4Fn8dE0C8VNpQV1JUZtyJcCyQRlP
	 i1H8PAsIVFWZLcBWgDkUAB71XhK4c/lDoLwMvExyprFgGSdEgVH5MofHlLprbvL5wl
	 hfvU56f60AELok4MAtRgl1nZwR7mTzelXz5uW26BAC2qyTspHIpoMoIMdRJCkJ9TeX
	 3pS/A6GMVTg2A==
Message-ID: <sashiko-outbox-237073@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: j721e: Properly check the error of a syscon lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anton Protopopov" <a.s.protopopov@gmail.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261127101915.1348807-1-a.s.protopopov@gmail.com>
References: <20261127101915.1348807-1-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:15:26 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The syscon_regmap_lookup_by_phandle_optional() function returns NULL
> only when the property is missing (-ENODEV). On other errors it returns
> an error pointer. The j721e_pcie_ctrl_init() function checks only for
> NULL and passes an error pointer to j721e_enable_acspcie_refclk(),
> which uses it as a regmap. Propagate the error instead.
>=20
> Fixes: 82c4be4168e2 ("PCI: j721e: Enable ACSPCIE Refclk if "ti,syscon-acs=
pcie-proxy-ctrl" exists")
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127101915.1348=
807-1-a.s.protopopov@gmail.com?part=3D1
