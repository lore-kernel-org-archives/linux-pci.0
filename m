Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792565323;
	b=RTuAZN9lH3ejZiYLHqA+7Q3fQvCWy7BK0/lGgMbMbtnpmyKFS2J7lbGps3V8HkFwXlUm
	 AHuJHVMeJ5bVQjhHkwrf6UcXfRyY+WGQEhzI99wbpEtOIxgYzxgOc2u15kyfmIiAO0bG3
	 bpFWcUMFe95jnpWYod40NeTfvYbE0sTavyDrFfKoqAQI9sK2mu0O6Axm/rsUrdCCSdRxS
	 Iq7QbZTd8c622ukYCumScCk3ZjNh2XVXZmSTD91pjtgNoFFDwKxl+841Q4lizFdHNOfHF
	 I3JeMXCumMi4wV4WGz/lfPK5veU+1v9hZpDX0Qbs1XXpN20YIvXtGfy2eX/LCYdyjdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565323;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wvDpOazIVTM1wxPA9rtj6WG3zy384P2ln3u9jQDQwac=;
	b=fXPoNbeJBQUF3gs2iRswXxqTR09QfMvaMuZfzSMzsDcFqR7jbhq96Lay7kBieL7xWWrb
	 /jrIwyvlXR2i+TYRtxZ+D51C14QISA9LFNkSESXW4KzhV3RXDJXhu/j6sJjYg3ob0JOmA
	 IjSHJK9UckhXJUgUBi3ssvnwH8S3CUrdI0l/2G/f414GV387k7lAGiIA+jGYx9lwVyNlg
	 ExAYxg+MU6jIZL901SilYjc2U6JISlVjiPGzugDBCLHkdeqqlp0UD6+OJmb/XQsz9Xvry
	 L9odStodfwhNasryRMup5B/BJ/mslMhJ+etCBTaqqFL/2TuCzmdkPOV86Vg7kr5/2tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E8uliqpz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE3D606A319
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E8uliqpz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDB11F000C9;
	Wed, 21 Oct 2026 06:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792565322;
	bh=wvDpOazIVTM1wxPA9rtj6WG3zy384P2ln3u9jQDQwac=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=E8uliqpzbDCLWnV5rdbbg2sOrQNKTyDYiqHfeiTdFT2Ro3yn+w/tWpeEzFe/tjHnt
	 53OeujwHwzJ+34xYsdVnhUxO2SzTsG+bNVtFQcgII6mvSy0bUTocc0fhxoQQOiYOjD
	 bKpKZCxFzsnF1LZc/GG3CSYC4sWNWPvvnKhChWn7mC9Tcfo6dVxFlcCTH25XnGupYg
	 pHQErYZ4rapla//ZbPZZ2bmochpErfN1FelkHPD55E+a6Awfzql11ssFpB+6BAxesR
	 7h477RDf1PC8Zq61dL6K8vde0hh1YGn7oohko7fFa3/qRqlLzHym+jyl+MQR5ejOnW
	 PigIqvD/JGFWQ==
Message-ID: <sashiko-outbox-179844@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] PCI: tegra194: Avoid full Endpoint reinit on
 PERST#
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261021061903.1269605-3-mmaddireddy@nvidia.com>
References: <20261021061903.1269605-1-mmaddireddy@nvidia.com>
 <20261021061903.1269605-3-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 06:48:42 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Tegra194 and Tegra234 lose controller register state across PERST#, but
> the driver remains bound. The common DWC initialization path now
> restores those registers while preserving its software resources. Tegra
> therefore no longer needs to call dw_pcie_ep_cleanup() on each PERST#
> cycle.
>=20
> Remove the per-reset dw_pcie_ep_cleanup() call. The existing
> dw_pcie_ep_init_registers() entry point now restores reset-lost
> registers after the first initialization while retaining software
> resources until final driver teardown. The allocation guards already
> reuse the bitmaps, address array and per-function descriptors; this
> change also avoids repeating the full debugfs/eDMA teardown and setup.
>=20
> Keep the EPF deinit notification in the PERST# deassert path after
> REFCLK is available and core reset has been deasserted, because EPF
> deinit callbacks can clear BARs and need register access. The final
> dw_pcie_ep_deinit() during driver removal still performs full cleanup.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021061903.1269=
605-1-mmaddireddy@nvidia.com?part=3D2

