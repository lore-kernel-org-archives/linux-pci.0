Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A26114F70
	for <linux-pci@vger.kernel.org>; Sun, 30 Aug 2026 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788089484; cv=none; b=RRvbV8cRIoiNVpQ2mcbACplqCtNkKrQ5S/kuDkIsR5pZtyFAj2wDgOx8xB4jELqc/e1zB4UmAnfkhU3OlLa4dMW4g4WnhpumIVBvWzDmXcuDGzJ3+wHwc2WQdxPyefnX/UC4XlMOdCMqL5VaryDVpCXggkiQHKXRFLWtatL9jlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788089484; c=relaxed/simple;
	bh=XgmpxNHREaD9Wt4N5L+MBz2tFsHyOWMGASPsHPCiPqc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WfdX7G+/MFWMX/AaIIHhmU07L8O8ApsnsaP7+rMAoYYU/ji1ozM/6CsdLTgQmKVJRMqHK80bSYGJv25WdWCIldTivOxwdT06ht5Fz3cdcCDbQB0MSebi3yCcb/Tb+EKIdcVQmthIueygt/14VKwi91J8m35hoNgIXmW7ZZyxjn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSsJVg9D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSsJVg9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B9E1F000E9;
	Sun, 30 Aug 2026 11:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788089482;
	bh=leFy21Li/lN+EFDTPp8fxwayRYuUDbaDJg5/aplj1Vc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aSsJVg9D/pioOtld7I1VuOZQb7pWbdiiNncTPImu3ekMwqm/uVYpRKgrJEMC0a9T/
	 HHTW0T/mMfXwW2rm1CvK+9R/7HeA4Wzvd0Nb7H+PNrA21R6I27HlkRPfA25pB5AGNO
	 P0QGCtbC2imvkelvozm0nD/TswisMwxK4RvgdfWdP6A1JPoXtADlKoFVHSwzbfr5ks
	 s8vccvzWZODaC2ro40dvtk9UZunzImQ/axyNCP91ByhzIFYTFAnvuriAwBT1iBxOX2
	 /2xR9bhAY0lWo5ghApd5shJU439XMXZAVkaxkpSwguzR5w8hkQJ+IVD3+7/QZAP2Tv
	 Fs0AVKCitEoLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] PCI/P2PDMA: Restrict the p2pmem search to pool
 backed providers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260830-batch-p2p-fixes-v1-3-5044e8dfbe2e@nvidia.com>
References: <20260830-batch-p2p-fixes-v1-0-5044e8dfbe2e@nvidia.com>
 <20260830-batch-p2p-fixes-v1-3-5044e8dfbe2e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 11:31:22 +0000
Message-Id: <20260830113122.A9B9E1F000E9@smtp.kernel.org>
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
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830-batch-p2p-=
fixes-v1-0-5044e8dfbe2e@nvidia.com?part=3D3

