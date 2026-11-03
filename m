Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731472;
	b=r6KMtYysF/msxAP+WolKSDKewQZJmdEfmsh92j1pzrEfg5GKY4jfGT6Hy3efGFI8tvYd
	 Zb0ycDGOoCJnaKYYL92QdXBwl6rCGTYQDKkdaiRfJCg04LNSdn/Zq7ZqgLRS7yYlfWX4l
	 3EBC4JFL1Bopv52ky7//Ne6Kba5na7FWoeBTetujKeHx+Xy6DpuHzDG1h2DxI7dUdr1+T
	 MOEUI3P3rMZtPV/2vGHDztVJgrGSDSYjeyl7J0Qm1TRsHK6/Sc92FJ7/m4M9xv1aPd6M5
	 3/O+6u0x+N8/qphcsqp2tBoDWlVseuTD30lG+FMQDxHrsipB9lVqffU5B2qc8Tfsb1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731472;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JgyZaPYGkU/56jV2mlgVZyZwYd4UbmuNnnj4Uw5GdYQ=;
	b=uWH69OBfyJ1+5O/Svg7q3kYHmWIUIoFl6DlW8tbKaG9Hjw9YFwlsU4cMuf8mU3liq+CE
	 XhFSiShT/eZdSNbsCQDkPs2IX/lm7069YPuuuFAsJsg4MNuQTh+rAPHLSMYFQNbOsALzR
	 QsyY59VOppKq9fHKvfhNyTYRleo+QWBP8/tw+h7SU8k+u+NvbvsxQqCc4P7UDN0PQfjcR
	 rTBpMav1PHiNswmJj6UlWARiNH1Dn5DvlDAc6HC8v0vIndwt2Uz3nJ/WjG0CXP3wQDDTv
	 QFL2ghErqT/kk6NbRP+GkBWA5+qfCcLZUfSn/ZBvyKCTPUoEvKJZuli37+e3IS2ZgyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2wGX+uw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F39A606A333
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2wGX+uw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A99B1F000C1;
	Tue,  3 Nov 2026 18:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793731471;
	bh=JgyZaPYGkU/56jV2mlgVZyZwYd4UbmuNnnj4Uw5GdYQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F2wGX+uwvDbZLa2keQtL5TcT2lEOLiMnPLyokMyO0hTGil4YOt9vDG5GsJMnpjNu0
	 l3YdBqBMKV79ATdFjbopzPzp3Jm0NuYh6lZL2qwk4stiuuCaa8WnB0vsfzTgXBkyB5
	 LmfuoigUOd3UJ6HF+5SOdHRim84CLU61chJzH5uZ2sH2QfyRY2yRDq5bwxhAUMkFu9
	 cNs+SnaUsdoa5kzgxCEOGoQ677YvqWr3YP4+ju5n4uJJCxcGOL2ZQ2gsQ8Iyc07XD6
	 0vghb07oj2hAH7JD1SHDfWiRJPzmZUiXayzgxpanJKOstqXb+PeXimICAOXRYQMZn0
	 Nl8OtgKHvg74A==
Message-ID: <sashiko-outbox-195859@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/5] iommu: Pass in gdev's blocked state to
 iommu_deinit_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <2e6bc70edf141ea3a067079951736d086740ca01.1793729707.git.nicolinc@nvidia.com>
References: <cover.1793729707.git.nicolinc@nvidia.com>
 <2e6bc70edf141ea3a067079951736d086740ca01.1793729707.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 18:44:31 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> iommu_deinit_device() parks the device on the driver's release_domain and
> passes group->domain to its attach_dev() callback as the old domain. That
> is only correct while the device is still attached to group->domain.
>=20
> A subsequent change keeps a device blocked on group->blocking_domain after
> a failed reset, so the old domain has to follow the device's blocked stat=
e.
> The group_device holding that state is freed by __iommu_group_free_device=
()
> before iommu_deinit_device() runs, so read it at the call site and pass it
> in.
>=20
> No functional change.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793729707.gi=
t.nicolinc@nvidia.com?part=3D4

