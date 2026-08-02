Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A482395DBF
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785685853; cv=none; b=Yyf5u1ROSDXZKBfCDEqqxHYOBuZpCSkM+jNyYHEq56kNp8Y1Zx53oTLcDAmFs5DtMIrUOMLSK04bUa6DPzofOrchdBwyLwOFTiuHH82qAtP0T6ZyGq/P4OsTa61sR6HIY5YUw7+m+aXBz3MPpy4L0xRug1Vp4bvfzar/4eHKAQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785685853; c=relaxed/simple;
	bh=jbtjG2iwrY4Vm48rvmDVMacAnTcueCosg99BtnDNTnI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C//o3HcEnuv7k2J//z7i9nuzAPhuEvZScKtJ/BURAVqXo+nfl1Eb00oYxPHVvJW/9/RUO5HKuDX2y7rcDZ+dxkdCGzOZj7mntirhTPn5SWJ0o6snXS2nuQrcjtswiCBq7OjRH9H2I7OQZw1gOlu0wJifGbjw/mtcGEwweYk1V5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoivzLgh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoivzLgh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07E01F000E9;
	Sun,  2 Aug 2026 15:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785685851;
	bh=jbtjG2iwrY4Vm48rvmDVMacAnTcueCosg99BtnDNTnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FoivzLghMGDlhx6Yq9W6UT1jCdpaLK5vtPva8v/C1Y6qXMf5hW28u/EznVbd6ZEO9
	 dggKywSN2Z0lR/cmIj0vj+uLgsGoy+pWNzrhK6gzDkxKUwxv2Setmx9r9PxTcAp4dB
	 iRH0v8bcAYXAm4OXVM+yFE6NZFTE2gVBy+y1UMVZwjRzTSgEn/qXWskxiPYTi4+rnA
	 c78VydiHL5FeK9kLKhXUsVd4zvr4ia9a1RjjSzHKc31oINSVYUd/ZxD4QLObMO0bmP
	 ELhG6rkHb9ZVZNhzJ0z3SdeC12t+gVoWdZC2L2701wbgVOVrhHHkJm9DYJUfG5GDun
	 0w8bcJpWbcrGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/13] PCI: Account for ACS egress control in isolation
 checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260802-fix-p2p-acs-v1-6-a7c5eb64fff6@nvidia.com>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-6-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 15:50:51 +0000
Message-Id: <20260802155051.B07E01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> pci_acs_enabled() treats P2P Request Redirect as effective whenever its
> control bit is set. PCIe r7.0, sec 6.12.3, table 6-11 lets an enabled
> Egress Control Vector override it: a clear vector bit routes the request
> directly.
>=20
> IOMMU grouping uses this check to prove peer requests cannot bypass the
> IOMMU, but cannot know every applicable vector bit, so Request Redirect
> gives no such guarantee while Egress Control is enabled.
>=20
> Report Request Redirect as ineffective there, merging the devices into
> one IOMMU group, and report no isolation when the register cannot be
> read. Apply the same rule to the Intel SPT PCH quirk.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802-fix-p2p-ac=
s-v1-0-a7c5eb64fff6@nvidia.com?part=3D6

