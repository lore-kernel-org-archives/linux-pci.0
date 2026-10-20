Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505448;
	b=inzEIc0RFQRY8h0BwmNIJCokEhYKJHodQZBWa1SCnpbvbH37znfe8VcC+4FZC4gk22OJ
	 MfSIcsBh0xZNVUJ3QITwHoQafy9uuRoUYmmmr5ptBKLulmsTiLU2bQcCo1c7d6wHrkwzU
	 ETzJ86UOHNktZ1HmgBIZV3M8Dza/f0TA4TGCdx/SmSL20X64QK/5Kz7YzPkalae8+FplM
	 wfswCGwUZl+on7OeTouaid0a2wyQwMgjGP/jOTx/ZBxoDp1dvh3Nwr915zN6BqQygyis5
	 SgjOBI4ZmWpAoI8EV7o0yTJqflB1noT1SDRwWNjM/ImafxCFEdUHSnI6s70vcGGcTZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505448;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zLc8iF59jusVA54iwdfAmvSSUdI99/CAHaMzv3tMbHs=;
	b=bXf4qnVj8ExzC3fGWVryPhaym/XIs4czOydWb2UpWQkXE5KmSA+J6jrNzwnKccCPQDK9
	 qreu7TSIJoCw+/nV0xLObS60LK2m1WWKLAFGp6vKhyMTFO3TXGvjXnnOOs/IEvsryVTGq
	 1g9aubt8pEU9lK5VRHilnN2s8mOaNp/2jsZ0UIB+wRGklPp9nZEBP75E2paumGDXMkVtT
	 uSVRaCOdX0nMe9L/eTkRHJdx8w34bvaGhQ5DKS6mwKkT3NYFhjBsyIKWZ1RlXmF2frEEI
	 +c0W/DnSUHCnhI7bRancrX7MroL9fC2An3CRaAlgzVhZcvm7qBx1sfO1fAHzM9bkCgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2BZAYTB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE9A606A31F
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2BZAYTB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180F21F000C4;
	Tue, 20 Oct 2026 14:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505448;
	bh=zLc8iF59jusVA54iwdfAmvSSUdI99/CAHaMzv3tMbHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j2BZAYTBEq0arxdvoMZcpiJNsIKZ58R3Em7NBK4nanLconatg5I//TvkAvslxnrNf
	 AtqkAiD7U3ha89Ud1Odhxk+qdtKZLIbSNBFdYCqtGl3YBrRU1ISSTbkfcIyPGlZRKA
	 PQi4/9gsOpDtEayg1hPUiXfp2Qp60KTTIYM8F2c3NKZcG140h3P1je1xRmqRS0u+Lp
	 4IyZwtcZ6WGVmHWK7opA7kVV1yYKSE/Z4dzD1K2f0mYOCVlXQUQXNaHdV6QsrpRdVk
	 JiHbklLsigphNTNmB8OSaEwYlH8fxOBkdo7q1nxH4G3i47GB7Jb6h52N/11N6F6eLx
	 kXNsJqNanjwNg==
Message-ID: <sashiko-outbox-179090@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drm/amdgpu: Match VFCT using initial PCI bus
 number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020-vfct-regression-v2-2-d2394d11450a@amd.com>
References: <20261020-vfct-regression-v2-0-d2394d11450a@amd.com>
 <20261020-vfct-regression-v2-2-d2394d11450a@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:10:47 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-vfct-regre=
ssion-v2-0-d2394d11450a@amd.com?part=3D2

