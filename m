Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8117F2820A9
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785685517; cv=none; b=ra72VdCPKN3PdC5sy/plnIP5x9Fk3a/8kO4QASW5cIEbdlKXaC2ZSfer+x6xdZEYy2DAercIvZ2l7tLzE52Y2yJEtXrI35V+flFsit3xFnRi5dkZmTAsuD9iKtAilXsDOHoRrawS0GLoWBFTzPacH5dFLmN0oOwqEBI5yXbMmu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785685517; c=relaxed/simple;
	bh=cLpEB/xpxohlha0Ec229j2Xecklf9A5PDPpHfwi32yE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GMNn9TQcUCU/GaZQOplckCqt0Zz+z/msMDHGwgzwP0FL78dO12+Ts+zZ71MLk6xFrRMyEJ4zN9TMc1svc1mre6oRNLcuP63doekzmOR8YJWZaBtmGCOr4FZVH7nwoZJ6xmyByLmPv93W4fDld787Fhduec/O+5RIF1myMgbo3QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmGheb7r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmGheb7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15371F000E9;
	Sun,  2 Aug 2026 15:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785685516;
	bh=7SRYSw1UMoHQY/6191Jw7oD6eCtMMTKF5mijUeJ8oyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SmGheb7rkN0EyPhOpIbTkjEwKlwY74YOdzf2CDDHhQoAX02xbk5gr53NlFu1l1Duf
	 EZRZ62OypeKSgG5eRATIav4Cl1VHIm9NQ4QnuD3Uf/a4kSJHAVbu3w4JmR1qDbtLxr
	 9RmIzE2RTtWMEnLK1iy1+5u/UNx4yx6ssAwy+cfpAxN6H5JVxURfODgzInHeADjfBn
	 b34GcveVk+e4BEbUN9p6M5A+usTTqIY9mahR6FaOyl3pGSr7w5kOJ6N9gfuniWKiJn
	 C0HGLTDlGnLDFNsp31yGcYEx/BSuFZi9utB5MsyLBFmOQGRN7sgJDeokYG6yq5pqun
	 bvvejSTtLc3bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/13] PCI: Account for Direct Translated P2P in ACS
 isolation checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260802-fix-p2p-acs-v1-4-a7c5eb64fff6@nvidia.com>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-4-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 15:45:15 +0000
Message-Id: <20260802154515.F15371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> PCIe r7.0, sec 6.12.3:
>=20
>   peer-to-peer Memory Requests whose Address Type (AT) field indicates a
>   Translated address must be routed to the peer Port/Function without
>   redirection, regardless of ACS P2P Request Redirect and ACS P2P Egress
>   Control settings.
>=20
> Request Redirect therefore does not isolate devices below a Port with
> ACS Direct Translated P2P enabled.
>=20
> Sec 6.12.1.1 makes such a Request an ACS Violation once Translation
> Blocking is enabled, and that error "must take precedence over ... ACS
> P2P control mechanisms". Report isolation only in that case. Without
> Translation Blocking, devices below such a Port now share an IOMMU
> group.
>=20
> Fixes: ad805758c0eb ("PCI: add ACS validation utility")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802-fix-p2p-ac=
s-v1-0-a7c5eb64fff6@nvidia.com?part=3D4

