Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04A22D9792
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 19:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342379; cv=none; b=THFW6TDx4Y4Mv/Qh+2j8ZLKbXxlpKKa9h+lLRezJ3r5gMrpGePWHesQQCy4Ugub7Dpv9uyxdRBi9AuNN6KsXaK8M1LL5h8BO0vcohH5euhUuJRfdr/aq41UxA16iJuOZPYhvg4JQn+ATSNyIsWoKwjoTXjLH3sTWKnsO1nPYngs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342379; c=relaxed/simple;
	bh=vaMRAiphVFYXY/Fmr6UdUsoUxmNzY2XP+kbyMfQyxIw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ik1PLwGc34tc05cAb+yo4bb1+fgPUiUjNchoMmmCohCv9ap5Kjp6jJ3t9PgGGseDfVilD1Wv+bl6T3TErCg8brSl5uNtIzshd33hCzp9Edaxh5ciwPTTklD/XdE/KoAj8jvr2wv4d7Ngah2sduyKc7ro+2Y3zTf31ke+1uFPc30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JV5u8oZL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JV5u8oZL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510581F000E9;
	Fri, 21 Aug 2026 19:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787342378;
	bh=DSpK7GPWt5lga+0Utqc0fY/5GhEh2iZnq+G+YhiVzgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JV5u8oZLCJS9YvO7AeZoOrrZ+3iEPFEi8lKxLTJAE3av168vdpWNpvRt7yvwKIc/M
	 zyDrVud/vMpbUUCP8CIkEWbsgAypQWRTTXYRI1lVoC995DGF+hJ0XKW1DODG3+xgDw
	 1W7u6BgLFKejXn1hdB0XHhcHmWVZHYzRaEAsZ7VNSSo6R4iMJNOAI2GRJ4f5/iYlyI
	 9impzy6Bvqjn95I0RaHeJ36qmcD9AfVZBc8oRMZyze2laqsQTxIin5SSc0+kSE+NuW
	 OLKoGmS87zvwABsLgt2GMbT8CGjihLlXM+s/LB8/lJ3UhWRGbS5RljR7IJap74ZGN1
	 k92MplIqhl0IQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/18] PCI/P2PDMA: Restrict the p2pmem search to pool
 backed providers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-3-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-3-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 19:59:37 +0000
Message-Id: <20260821195938.510581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> pci_p2pmem_find_many() exists to pick a provider that the caller will
> then allocate from with pci_alloc_p2pmem(), which goes straight to the
> gen_pool:
>=20
> 	ret =3D (void *)gen_pool_alloc_owner(p2pdma->pool, size, (void **) &ref);
>=20
> pci_has_p2pmem() does not ask for that pool, only for the published flag.
> The two used to be equivalent, because a provider could only exist by way
> of pci_p2pdma_add_resource(), which always creates the pool.
>=20
> pcim_p2pdma_init() broke that. It registers a provider for the DMABUF
> path and never creates a pool, so pdev->p2pdma is set while
> p2pdma->pool stays NULL. Nothing publishes such a provider today, so the
> search cannot return one yet, but the flag alone no longer says what the
> caller needs.
>=20
> Ask for the pool as well, so the search covers the providers its result
> is used for. A later patch documents the pdev->p2pdma lifetime and RCU
> rules.
>=20
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-fix-p2p-ac=
s-v4-0-v4-0-94426b96de73@nvidia.com?part=3D3

