Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB903B8BCB
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341985; cv=none; b=s4Uk8pVDJfWOTNDlHi2aI2tFrQktc6plzWA1WtnOawt6qjjWLOKVvzlI9WIWatakbpskR2pvstx6ya69WhIYPXqdUWiwH1ol2cO/yiQUMt6HfvBaJfBq9+enCh5jliqWZKfiDJU1VWeBAQk9AqG9N3/zdsmTwdKhCbCgHONoFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341985; c=relaxed/simple;
	bh=56IcZpK+G/E6GnI5mfcHcEf5IpcGyLTH31Fs4qKhvRg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lsHp2a27DQmMiuvF3uQOSzi19ZObfwddRHbHYCjUrW9kkaN4IU4xHc+d/0W+yThWUeewoJc28N472YLKUbqa9awWBlLDRe36r/bmrX6M2vc03vXyIGHwQGc6S+ul0i46EY0yVIvWBDG+W5KL51+wllx8thrWpJ6ad4AeOSVOcyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atvBLsA7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atvBLsA7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAB01F000E9;
	Fri, 21 Aug 2026 19:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341983;
	bh=62rRljJwNT7v8yNRK7ewD8My39N4778WJ3FjeWnCXrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=atvBLsA7JYZ7JLTyAQHyUalsJfTkgRD4NhKkCVLnakNl2VO9W0zHGMUfTqUA+QeER
	 9prolzPLkFoISV9zOPCfAM+o0DhiaRdvRQgyNf2tJt2FOSE+aOUNJ33jYk3SzrkCKR
	 goi5v9J8gvQQnJikKGFPgjb1R5fhFzvt/R/xVg3+3+KAtafOaqNayl6M3cWp3B44rp
	 PeS77kf1dqzsqAHAw4Mpiqi/Pue9lLNichYhKhltv6nGapaKrXuT2tfIhHOPAfLqyB
	 Gzi/qt9sNRT8DwLXc1NE7aS5XwVvvRjcsypijPxf300+oxPpbtNRZsq4+x/+26mDPM
	 wqGtkBf4R1xDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/18] PCI/P2PDMA: Do not tear down the allocate
 attribute on registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-1-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-1-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 19:53:03 +0000
Message-Id: <20260821195303.8FAB01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> pci_p2pdma_add_resource() installs pci_p2pdma_unmap_mappings() as a devres
> action with the devres allocated p2p_pgmap as its data, and only then adds
> the range to the pool:
>=20
> 	error =3D devm_add_action_or_reset(&pdev->dev, pci_p2pdma_unmap_mappings,
> 					 p2p_pgmap);
> 	if (error)
> 		goto pages_free;
>=20
> 	p2pdma =3D rcu_dereference_protected(pdev->p2pdma, 1);
> 	error =3D gen_pool_add_owner(p2pdma->pool, ...);
> 	if (error)
> 		goto pages_free;
> [ ... ]
>=20
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Fixes: 7e9c7ef83d78 ("PCI/P2PDMA: Allow userspace VMA allocations through=
 sysfs")
> Fixes: f58ef9d1d135 ("PCI/P2PDMA: Separate the mmap() support from the co=
re logic")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-fix-p2p-ac=
s-v4-0-v4-0-94426b96de73@nvidia.com?part=3D1

