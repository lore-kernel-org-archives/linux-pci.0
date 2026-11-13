Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531489;
	b=ZCeLlnL68aeTNzDxiJj6y6htcOXU+4+qMJHNYXLEmCMtnbgV7o8v5AOyFv93EcrBB1+/
	 VG54QxtK9HazgpXj3eUuqeNpGguH8OgU15Gi5c98bO5X0G2HNDh98JU50ps+o3mWHoHm7
	 BPvcVOqgMIM4SmuEk2jAMdqqW/kVW3w+kYvpx0pzwfjlAUlwcEBxrA2vQ0UZ0PsnYnNEx
	 RFw/DS2ur6gn62kDTkQ4uSlRNZNAJ1hJkvWmd17mBBSNKG8cx3q9ctjHwct+xwZZzZxTu
	 8EROSqx4ZN59NH3eKl4npHYITMTlN3dzxO296SLg6NLKM8bGaMwKo+0VOpnaMPfnTMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531489;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8RZtCUQG2PyWjzBH37MhR+5h5enhcK7w8pcdmGoof+E=;
	b=QFaoau1DuFneiQXFoR/VTcre37NEGXkxjEOe1DUvccRscNMaDbM1cpCPxFKmVe2QUK6V
	 grQuwr4DKKLUxqSKWu6vwX0OtXN2Jy1ykge0RsAU2gMX3bo7uLrFQ2bjOxsQcqaniQpXi
	 dXT9Cya4PtG63oWwQ8vaa0GNc13USLQHcWSOVui7c5J2KgOcTXqSLDEgS81wyCDp7hCYg
	 USi7GyWisUnIBi0/t682xZAlg6LXoDr7Vaqn9Hsi2suE2QolxSndb0DW08tLywbJvZfxu
	 2R6H+q6m7a03orRbXwhD4G9EhdFANjgK3TmXyrE+AEyS1hhNpYY99vo1qcyXZJTp/MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXUYuPPC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B9D60A3808
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXUYuPPC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A8C1F000C4;
	Fri, 13 Nov 2026 00:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531488;
	bh=8RZtCUQG2PyWjzBH37MhR+5h5enhcK7w8pcdmGoof+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CXUYuPPCdLeYMZ9nDtyN7TzEb2asmNl5CTFuLmnDCVUu9NwhrrvBQdM7XgE10UgZE
	 k4oCqn+WWWoz/X3l4BlZYan/fsQbktAMgKR2jPoQZTG7ugFh1Fb5wvIznQvIQCn5En
	 b+WhlG6PoeDKCdNv7YQy4/ExNo7QTYzfSAAcwWM6nLbuFsmfpC+lsAlsfZdvUXuKQY
	 hGxz/mcTFHDnHQ9RvgLLfSjw5TsrXZid60PWGIJjUBnobz1Rn1skaib/lwtSFHZSyL
	 XFrI58NdE+qNWosI8wUPp+7cqASgh6YVsKjHaLMhDaWpFtaLuGCL360BkiAPyhuZiR
	 m8L43rH6BkvPg==
Message-ID: <sashiko-outbox-212020@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/3] drm/radeon: Match VFCT using initial PCI bus
 number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261112-vfct-regression-v7-3-69b1e0cf45c2@amd.com>
References: <20261112-vfct-regression-v7-0-69b1e0cf45c2@amd.com>
 <20261112-vfct-regression-v7-3-69b1e0cf45c2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 00:58:08 +0000
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
> Fixes: 4059e2f02c8a ("drm/radeon: Fix VFCT bus number matching with soft =
filter")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-vfct-regre=
ssion-v7-0-69b1e0cf45c2@amd.com?part=3D3

