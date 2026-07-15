Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266AF4248D9;
	Wed, 15 Jul 2026 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138729; cv=none; b=GiJGJLgQAKHpvBOclKZKHNaNbcWKaQfuFiIAT67R1bcoDPgv8N3BHhGP5iTokzKpesTt03Key0x/r1TrGd3MkHKs45pi1FBFUZMaghHT8OBxPRNBqoGfDpmAy2QvHNgUDABPPA92Jw9BlhLlmz8yi/8tofkmAQUsMn7CBifJQvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138729; c=relaxed/simple;
	bh=u/LJG2v9yK4rXlfBUgngM0do2Vxdb3J59mTawCcOBqs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HUf8qyIf1jeVJUZ3RyJYPwStKzeaZt8S9nyejU8NKegTbhgRt2w9Bf0AOBNolsPjbt14k1nLKFzoA2t9X54UDXo9T992DinsPgQZDScKIP2BIsgPOhSOTO9HCpBg66Cn1ZZyiwjI/eO6SdQTFxT83EfyS6UGO9GSXpdZKOC32bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ja2+r2p/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ja2+r2p/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDD61F00A3A;
	Wed, 15 Jul 2026 18:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784138721;
	bh=ig/B6QjU77l5xhM6Lrkfy9E9lwaRaDySKPMjuR+C1vE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ja2+r2p/zANKk7ot5pk+zFxvuVDnQ6Ldek2g19H/HTGiBcx9orl1O2GGeAVgdmzpx
	 1dNc3vIqjPaxJ7ob+vZAbl1Zk5kbCtckioZ3DlEGOuqScuISwzzBYoerJuNCsQzZtI
	 xTo8uxJ2PX/ynv+BhvuTPP1Lchrj7zv8RuryKhE7vFxFnCNi/dGbGuEjqDhAvFGjeT
	 Kp4r/zZQDmoQMI8GpjhXhTzoQw4/1A7z2UZNGYe3XxDN99Biu/SYfyFQC5I/hXtZWo
	 kuIWQUc3qYoMep2OIAQr0/vh78vn5oOSo8KQbuC7rbat5KI1ooxSfClKDIPJD1j2Lh
	 Dk7B/xQu9gr4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/9] PCI/P2PDMA: Split pool-related cleanup out of
 pci_p2pdma_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: dri-devel@lists.freedesktop.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260715174737.15287-2-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-2-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:05:20 +0000
Message-Id: <20260715180521.3CDD61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Skipping `synchronize_rcu()` when `p2pdma->pool` is NULL causes a =
Use-After-Free of the devres-managed `pci_p2pdma` structure and its `map_ty=
pes` xarray for concurrent RCU readers.
--

--- Patch [1]: [PATCH v5 1/9] PCI/P2PDMA: Split pool-related cleanup out of=
 pci_p2pdma_release() ---
commit d0b08915340cc1e9c83ccd0a7d506d8fb8505da6
Author: Matt Evans <matt@ozlabs.org>

PCI/P2PDMA: Split pool-related cleanup out of pci_p2pdma_release()

This patch splits the pool-related release code into a new
pci_p2pdma_release_pool() function. This prepares for future compile-time
selection of a null implementation during planned refactoring.

> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index b2d5266f86530..498bca2574193 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c

[ ... ]

> @@ -226,6 +226,17 @@ static const struct dev_pagemap_ops p2pdma_pgmap_ops=
 =3D {
>  	.folio_free =3D p2pdma_folio_free,
>  };
> =20
> +static void pci_p2pdma_release_pool(struct pci_dev *pdev,
> +				    struct pci_p2pdma *p2pdma)
> +{
> +	if (!p2pdma->pool)
> +		return;
> +
> +	synchronize_rcu();

[Severity: High]
This is a pre-existing issue, but does skipping synchronize_rcu() here when
the pool is empty cause a use-after-free for concurrent RCU readers?

If a driver initializes P2P DMA but does not add resources, the pool
remains uninitialized. When the driver unbinds, devres cleanup triggers
pci_p2pdma_release(), which clears pdev->p2pdma and then calls this helper.

Since the pool is missing, the early return entirely bypasses the RCU grace
period. When pci_p2pdma_release() finishes, devres immediately frees the
pci_p2pdma structure.

Concurrently, another thread executing pci_p2pdma_map_type() might take the
RCU read lock, dereference the old pdev->p2pdma pointer, and access the
freed memory via the map_types xarray.

Moving synchronize_rcu() into this pool-specific helper seems to imply that
the grace period only protects the pool, when it actually protects the
overall pci_p2pdma structure. Should synchronize_rcu() be moved back out to
pci_p2pdma_release() so it executes unconditionally?

> +	gen_pool_destroy(p2pdma->pool);
> +	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
> +}
> +
>  static void pci_p2pdma_release(void *data)
>  {
>  	struct pci_dev *pdev =3D data;
> @@ -237,15 +248,8 @@ static void pci_p2pdma_release(void *data)
> =20
>  	/* Flush and disable pci_alloc_p2p_mem() */
>  	pdev->p2pdma =3D NULL;
> -	if (p2pdma->pool)
> -		synchronize_rcu();
> +	pci_p2pdma_release_pool(pdev, p2pdma);
>  	xa_destroy(&p2pdma->map_types);
> -
> -	if (!p2pdma->pool)
> -		return;
> -
> -	gen_pool_destroy(p2pdma->pool);
> -	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715174737.1528=
7-1-matt@ozlabs.org?part=3D1
