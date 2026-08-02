Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBFD2FE0F
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785684890; cv=none; b=m2Rw/gFBP/8T4tqvYRc91zt2ovSIiDDHE9hvkpEopUAza4SeVLHJiH895OcL716nHq661ZxRcSGhTPyM/U5yStqg+G88hjvbDGyWXs5Pqu89zNesVUIh4M6GiJX7cxPiVDuAM7odCCkSSb5582gtOWEZTISNh66XrUi0+ITOYc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785684890; c=relaxed/simple;
	bh=CvQmdhxAJGlNjA9cID6z7v3xBBEZkhmyO7zPaIP58is=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fQ4VaEvTiUMr0gF9Zm23B1HWRDxispB1luveGMlVP2ph0owWuyKvHu5PqnX/YGO06qb2/7eLSC9pvJb4BY3n/JztsjDTYN1+V2O3nb4ItndiJtEjo+RPxEsN82/bkilpBKdGApeCzWiV3VxpnqfNo+cSP83HCEJAyKpHs/scEfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnN7q7sk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnN7q7sk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4051F000E9;
	Sun,  2 Aug 2026 15:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785684888;
	bh=CvQmdhxAJGlNjA9cID6z7v3xBBEZkhmyO7zPaIP58is=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WnN7q7skqIUfeGEn35uNYzITttqztnWBIAr8R/n6Xa91QXJuVWx+T2XkChuQSZT+/
	 53vdK97fzxMmfBpUQZJkJnPuBBRWYYzDL4ACciFLI+5CqoBWV15Y7jumCrfcBb+R2B
	 VbkhPbhkLv2nQHdPQRLHbDxcx+ppCLXaTK/gdh+12NWUF6h/C6p5SDkdrzWPRSCzIj
	 r6PgoENmMk6abLgs1knAAH1LOTIeuf2k06D3v44cRaEtETUmdodnZTvqNerY3tvP2Z
	 gJHF+tCet4Bpo06bC4N0hX23DlLw9G8OnbYETrUbjksk67AOaJWPG/9Amavli94mBj
	 b3VjCbDgtml2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/13] PCI/P2PDMA: Report ACS ports when the paths share
 no upstream bridge
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260802-fix-p2p-acs-v1-2-a7c5eb64fff6@nvidia.com>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-2-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 15:34:48 +0000
Message-Id: <20260802153448.BC4051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> A provider and a client below different Root Ports share no upstream
> bridge, so the search ends without a match and the walk takes the
> host-bridge route directly. Neither path is examined for ACS, so no
> redirect diagnostic is emitted and the host-bridge whitelist warning
> stays suppressed.
>=20
> Examine the paths before taking that route, so every redirecting port is
> named in the pci=3Ddisable_acs_redir=3D hint. The mapping type is unchang=
ed.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802-fix-p2p-ac=
s-v1-0-a7c5eb64fff6@nvidia.com?part=3D2

