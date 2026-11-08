Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135604;
	b=Ff/oIdLNcf9VturBtxO2416gEk+RTVgcqL+Mc9Ui6ElmhZJVC3T8DggHTyChqcWR6D8x
	 bnARbrWNW6UuBylZHgb6oApOcqbbG2P1VRoOUgJC/s5GT4CG5ruwflfp4r+t6+y8oXbW1
	 JJI66RZ3aJRYypfKk+DFMwYocF16z7XhDllxpBWnQa34gAxSPsRPL23HprHuL7eCBsV1U
	 WxhpYY4123Ipd/pDZw9QFr/e7EoX35bplAbiUfhwIvZ+WhC/O9ntO5NOAfZ5IwXucKvsp
	 ohlh4rNqFS7cJq5DG2inz6cTOYgKOQmGpJvBMbKxs8pfx46gHH4JA6U3ui90dMOiskg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135604;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mDrcr7etSzQF+eaDqG+7YvVWlFSNFs5TZCRMvX6g0Eg=;
	b=rSopb+tw5KHayH0zuZoJDElu+XMh2B2/i5lGamLbXmXwrkmuONQ7YqXCYrZ3qA/DQ7GK
	 9NSleGNMgzzEksUx9fiaeLGpZo8H8L2Ee4qlYkWDdG54gXpc4K863qa354qdCPeuwrbTT
	 jmXqrXdm+Y6pc6lDA++X11h+Fh6k3oVnuyuOVMyw5KwIU9rwxtIxqbEbSIHzxOYaiT9Aw
	 CagQhXzFNGkq1B7majSutCTfRVDAZGk3cKpf/1eSqvs7EgPKFOLz5QRnifuVZOuNYAcGX
	 fis9flnHPts9p7TX8VlgySFpslmNr9fb3eJ1RY5llBcBdi7TBqfilO6AT+D+ZyGrB1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QID3huY8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C57606A31C
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QID3huY8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9AE1F0089F;
	Sun,  8 Nov 2026 11:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794135604;
	bh=mDrcr7etSzQF+eaDqG+7YvVWlFSNFs5TZCRMvX6g0Eg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=QID3huY8R2XWelqLQXaezjJRIQIyoOAcql2VvLqSyYw3G1pSpepEpTiwnqZdaI+Eo
	 JHTBbBAegRnMH8+Og19u3X/LwAnmec3WQMyGPi4oPO0/J16RYthneKP4DMuMDKnECp
	 h69a9djTaO9Of2nok8vLwJ1Spyqo9xSYNhYA73oKOgJR86oHoSgt/OkdXWHwSjcweU
	 hGZsTXfX99+LO1vNKb8wsc2ZvDOazGTkW4KJlUxstY3GKmC04syvT/xvKem8WY2Ylg
	 GEWFGKoHKnQh0Q1rDZtJ1lQVwqnh9g2MmMG18eB67tJFA13TZK2viiPfiXl3JYWri2
	 +gT3TsbacNbQA==
Message-ID: <sashiko-outbox-203686@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] PCI: thunder-pem, hisi, thunder-ecam: Fix ECAM
 config window use-after-free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongyan Xu" <getshell@seu.edu.cn>, linux-pci@vger.kernel.org
In-Reply-To: <20261108105640.875-4-getshell@seu.edu.cn>
References: <20261108105640.875-1-getshell@seu.edu.cn>
 <20261108105640.875-4-getshell@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 11:00:03 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> thunder-pem, hisi and thunder-ecam set .probe =3D pci_host_common_probe b=
ut
> have no ->remove, so unbinding only runs devres_release_all():
> gen_pci_unmap_cfg() -> pci_ecam_free() frees the ECAM config window while
> the bus tree stays registered - only pci_remove_bus() unlinks a bus, and
> only pci_host_common_remove() reaches it for a root bus.  The next config
> access in pci_ecam_map_bus() reads cfg->ops->bus_shift.
> Trigger: DT overlay removal of the node that supplied or enabled it.
>=20
> Fix: give each driver the same .remove =3D pci_host_common_remove that
> pci-host-generic.c got in commit 01fcb7f777a9 ("PCI: Add support for
> unbinding the generic PCI host controller"), so the unlink comes first.
>=20
> Fixes: f12b76e56ada ("PCI: thunder: Add PCIe host driver for ThunderX pro=
cessors")
> Fixes: a2ec1996098c ("PCI: hisi: Add DT almost-ECAM support for Hip06/Hip=
07 host controllers")
> Fixes: 7b6e7ba8e81a ("PCI: thunder: Add driver for ThunderX-pass{1,2} on-=
chip devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108105640.875-=
1-getshell@seu.edu.cn?part=3D3

