Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E5727E05F
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342567; cv=none; b=RYAD0eZjXVQsppvpSdg6p9QaegIMhESDvufw651VcjjMoN4CrGYBdqczXCrZhi/DtDm3S8pQwkLj29GGtfUNpbu2O6BRtoE6cb5IbSeM/LqXCjTHAWQ2Wri9rJo6JRyqivHV0o2wSPYsUG1TWJVI30d8Ytw4MG4ink89Dda6k8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342567; c=relaxed/simple;
	bh=023OWK8x/iH9+TkCuBR7YnSBtypWsqoJdVWJ76HOZjM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mrcg5tPuQwBc//xYhZxQ/CB30BkgLKGvkI7C8Wi3/rlttFqfPQihhLl94EAsRVeUYEUvBRSIsfwJVqoWq1RwpQuHwiYuYLsitPKNvx8uTzYq7p+FNDbLAKPtLvYp8lIXweRZuLwhhmkf7vFXRm2nqbCIzl6eUdl2NLPZmhvYfJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jY+s6kur; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jY+s6kur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423701F000E9;
	Fri, 21 Aug 2026 20:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787342566;
	bh=20I2dV+GofUXEBscYF18UynmOi6NpWxqVM1VrHCCbcU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jY+s6kurRP36cdf5Gcpsf12WY8O4qV3ZCwicsxLI8UPw3p1UaR5qnNxo/rrnU7u+Q
	 oTVsKmh6YyAY7gl4Jg0lgLspilTCvfGg/15fKwsSgTAjzcGF4oP6JhJtBhkdS5kh5s
	 QFo+qeh+rlUzKowa3KsuFl9Y5zzJ05vx6l2tx037jfJ/1IBHSaGTiJV6sDvns/eLbw
	 gAUyY6joCpBLWlT0S5rABy7TQWmsnzkO5VqO0XKdfk9EFgYsQygwXdUqQ8VwzGWvSg
	 AgNG696dtieEsvP61WKasSiFdwKi+BLRdnhf3hLG1DY04nSDtuPmm9ZtXxvKyeTE1N
	 UW8Qdy2j/kNdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/18] PCI/P2PDMA: Log detailed ACS routing
 diagnostics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-18-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-18-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:02:45 +0000
Message-Id: <20260821200246.423701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional debug logging in the high-frequency P2PDMA mapping f=
ast path causes severe log flooding.
--

--- Patch [18]: [PATCH v4 18/18] PCI/P2PDMA: Log detailed ACS routing diagn=
ostics ---
commit 6ad59be5d5d93d88cf70cbce85e9046d3c5b0adb
Author: Leon Romanovsky <leon@kernel.org>

    PCI/P2PDMA: Log detailed ACS routing diagnostics

This commit adds detailed ACS routing diagnostics to assist in identifying
P2PDMA mapping failures. It emits info-level logs covering path details,
ACS controls, and cache state.

> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index e54901d21d8a2..b79eb4ce09f47 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c

[ ... ]

> @@ -1237,23 +1467,38 @@ enum pci_p2pdma_map_type pci_p2pdma_map_type(stru=
ct p2pdma_provider *provider,
>  	struct pci_dev *pdev =3D to_pci_dev(provider->owner);
>  	struct pci_dev *client;
>  	struct pci_p2pdma *p2pdma;
> +	unsigned long cache_index;
> +	bool provider_state;
>  	int dist;
> =20
> -	if (!pdev->p2pdma)
> +	if (!pdev->p2pdma) {
> +		pci_info(pdev,
> +			 "P2PDMA ACS debug: map lookup rejected; provider state is absent\n");
>  		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
> +	}
> =20
> -	if (!dev_is_pci(dev))
> +	if (!dev_is_pci(dev)) {
> +		dev_info(dev,
> +			 "P2PDMA ACS debug: provider=3D%s map lookup rejected; client is not =
PCI\n",
> +			 pci_name(pdev));
>  		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
> +	}
> =20
>  	client =3D to_pci_dev(dev);
> +	cache_index =3D map_types_idx(client);
> =20
>  	rcu_read_lock();
>  	p2pdma =3D rcu_dereference(pdev->p2pdma);
> =20
>  	if (p2pdma)
>  		type =3D xa_to_value(xa_load(&p2pdma->map_types,
> -					   map_types_idx(client)));
> +					   cache_index));
> +	provider_state =3D !!p2pdma;
>  	rcu_read_unlock();
> +	pci_info(client,
> +		 "P2PDMA ACS debug: map lookup provider=3D%s index=3D%#lx cached=3D%s(=
%d) provider-state=3D%u\n",
> +		 pci_name(pdev), cache_index, pci_p2pdma_map_type_name(type),
> +		 type, provider_state);

[Severity: High]
Does this code risk flooding the kernel log buffer and causing severe perfo=
rmance
degradation?

Since pci_p2pdma_map_type() is invoked on the DMA mapping fast path (for
example, once per P2PDMA I/O request via pci_p2pdma_state() in dma_map_sg()
loops), this unconditional logging will execute on every single P2PDMA
map lookup even when a cached route is successfully used.

Will this saturate the kernel log buffer and cause severe printk/console lo=
ck
contention for any P2PDMA-capable block I/O or RDMA operation?

> =20
>  	if (type =3D=3D PCI_P2PDMA_MAP_UNKNOWN)
>  		return calc_map_type_and_dist(pdev, client, &dist, true);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-fix-p2p-ac=
s-v4-0-v4-0-94426b96de73@nvidia.com?part=3D18
