Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996658;
	b=kUeGM46jR4TBR3vVQb36BJIe0i1jXryPyMvvPmhqiIx/VRdvWkEBHDKXV94MwC3hMZw0
	 wW0cutpgT3ps8l+wsNrYX56YOk1TU9+zG/YgVgvjPcMyy9jd97FO4YQuHJmBVNlTCs84E
	 k/tR/4Ayho8iYKG9ivqZG01vOGxvALDyOYcgnoz9haK4ydnNMFMp9IrWNM/TCLioBhehJ
	 MruZp4P8fzCch+bBEhXL1JucojdSmye/C6eMcbNlEjG7XiQ5zBT4Mm6LLELp4v6ghgO4C
	 37ig2sFUw+ACLzK/V0gK/Iwk0khPfmTQbh6y0zH+H1Yx+STGWgTooIyx1jg0IZHd2OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996658;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BxN9xog44Um+/N9BCyQsEgVXPgXEYz5A8h3cz0p9HbY=;
	b=JzxBBebIkWGZD38Jl4v9ByFPnHSSaxaN7V+zusIecX4TJb8At+JY1ny8ym+fMGtxWgrL
	 DLnPhbcgTiZCL7snwVJKiBKH/mwY2znloI3djaJ+1gdG484XEd4sjrYsz590nlHcJ8wDX
	 rl/+HXKdeJ3aLs+kfKspaD06pGU44T53PcidhpL946uUbyjndaS9vNXmYXE4kaYTRK4Hw
	 TIUa/d2bBNGHWHCBrMFWkEpUr6NypryhYCUsQDLVPrCDZ3ALwkJByjRugV+1CgjtDCuMy
	 WNtRjax+Rle4OIE/wX3X8dxbG7JiVjD9aDAmy4GOAdXEfu2jxeOZ2a19AkUGAr5WZhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NNwmGLzb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22E5606A325
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NNwmGLzb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635DF1F000C4;
	Wed, 18 Nov 2026 10:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794996658;
	bh=BxN9xog44Um+/N9BCyQsEgVXPgXEYz5A8h3cz0p9HbY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NNwmGLzbC2bDn2nMVJlW/30j9BVsyt8ZxNSe9jTEq3G+7THy/a6iVU6zvwm5Ux+Vp
	 8gvlLNjtq4bWlit9BI9fgWRRFKqtKAM8NcA8sFwEudE4eKTAV0kl3cnBqiHAaKWxfj
	 bJATbAMHpM9PxgkRjEOoi1evj4UCme60zY/j30bJaKh0w0cKW7fttcFpOeSRTUYfSd
	 KBQKEXHsVeqhiK04wEms7dxohO8rfYk7Vasd5mBsBtFjym63A7Y6Zb6sKJpDdMNuYe
	 ika2xVfLk8Zm2/2C5y2TjJDqzC8AOzMa9FX61JzutnFkIKDRN3anj5iW4rRVBQ21Bt
	 /GBzvMMuAhPdw==
Message-ID: <sashiko-outbox-220660@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] LF-18678 PCI: Add quirk to fix byte-swapped class code
 on ARA240 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Ghetu" <stefan.ghetu@nxp.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261118100406.600995-1-stefan.ghetu@nxp.com>
References: <20261118100406.600995-1-stefan.ghetu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 10:10:57 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Richard Zhu <hongxing.zhu@nxp.com>
>=20
> The ARA240 PCIe endpoint device (1e58:0002) reports an incorrect,
> byte-swapped class code of 0x000012 instead of 0x120000 (Processing
> Accelerator). This causes the device to appear as an unclassified
> device (class 0x00) rather than a processing accelerator (class 0x12).
>=20
> On ARM platforms, the kernel may refuse to assign BARs to unclassified
> devices, preventing the ARA240 from functioning properly. The device
> cannot be initialized and remains unusable.
>=20
> Add a PCI quirk to force the correct class code during early device
> enumeration, allowing proper resource assignment and device operation.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118100406.6009=
95-1-stefan.ghetu@nxp.com?part=3D1

