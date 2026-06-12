Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A8212B143
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254106; cv=none; b=tLzsTQpcj7/3O8LQQAzhNReaNWjOE8H81EawRsXp8NgP7/Rpuxgbm4gDFhXY0gU8aWwQP9/H5aE2iTAuQDNIsMBxF+go8JS6KGGWqtP7jrPphipnktklAshAwQ6CHmKw7CVI5wmLIP144VclDN2uDt4Fy6e190ATEt305ZZUB0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254106; c=relaxed/simple;
	bh=0Ak1/fRjH8fxjMPZWCZileUPKweprqfzDifXqZ6GUQg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r5hR6BLe2NhE4ZyU3rqKYwKsuM2vpXbrxKuyyNruSWonrhTI8PMhccMw3zCvwpcg/W3qO4Qyn21KUhpSNOkZpF7/+jw1AAmJAAHw127+A79doAvo7yFkN6AqRnWvk7R89wSuLjUm+m/waewYjo7cpK/ia5ODV7tSN6ieS3lzsHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSu/kgl3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSu/kgl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DE91F00A3A;
	Fri, 12 Jun 2026 08:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781254104;
	bh=1FMEOm2MaI3cCtppgRk+r3+7Lugs4QOF6Pt5RyldXwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HSu/kgl3Fx4GNTinHh70p012MC+K4Cyg9aHznFpbRDu8Ld33QRx6goNT3HItH7Vv8
	 W3sHtj9hk1swGI746zk6q4Ap/+DG31AI3SZ+IHKHay4na8G/pR2lDmgpQCoy5zxj33
	 G7SqDKKSRWWiYzOIO9qP/gP1Cg2aGmPLzCjFkjxfgE4Slkn/REpTtJb5myog/LYnMC
	 4i1aPLbyYFNCP/haqUM2QzWuExpgQJoG4o6Z2FADg/mvFqhmgSdcgKRGbixtyYu+07
	 jM7UVNVJ3OSJkTI3WClwVnBHHsaYMwkLDqhNsN3PoECZk2Mp06b4/W9GzI+Gp4epKX
	 HQKTjahAUpuSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Use RCU_INIT_POINTER() to clear
 pdev->p2pdma
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260612083452.1639-1-lirongqing@baidu.com>
References: <20260612083452.1639-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 08:48:24 +0000
Message-Id: <20260612084824.A3DE91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] pci_p2pdma_release() skips synchronize_rcu() when p2pdma->pool is =
NULL, causing a use-after-free of the devm-allocated p2pdma structure and c=
orruption of its map_types xarray for concurrent RCU readers.
- [High] Missing devres action removal in pci_p2pdma_add_resource() error p=
aths causes Use-After-Free of p2p_pgmap during devres teardown.
--

commit eb4ec2c32d602512abbeccbe720637cf83f85cb6
Author: Li RongQing <lirongqing@baidu.com>

PCI/P2PDMA: Use RCU_INIT_POINTER() to clear pdev->p2pdma

Since pdev->p2pdma is an RCU-protected pointer, directly assigning
NULL to it violates RCU semantics and triggers sparse static analysis
warnings.

Fix this by using RCU_INIT_POINTER() instead of a raw assignment,
ensuring proper RCU annotations and consistency with the subsequent
synchronize_rcu() call.

> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 7c898542af8d5..fd98624208c50 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -236,7 +236,7 @@ static void pci_p2pdma_release(void *data)
>  		return;
> =20
>  	/* Flush and disable pci_alloc_p2p_mem() */
> -	pdev->p2pdma =3D NULL;
> +	RCU_INIT_POINTER(pdev->p2pdma, NULL);
>  	if (p2pdma->pool)
>  		synchronize_rcu();

[Severity: High]
This isn't a bug introduced by this patch, but could skipping
synchronize_rcu() here result in a use-after-free for concurrent RCU reader=
s?

If p2pdma->pool is NULL, synchronize_rcu() is bypassed before destroying the
map_types xarray and returning. Since the p2pdma structure is managed by
devres, it will be freed shortly after this callback returns.

If concurrent RCU readers (like those executing pci_p2pdma_map_type()) obta=
in
the pointer just before it is cleared, will they continue to access the fre=
ed
map_types xarray and p2pdma structure?

>  	xa_destroy(&p2pdma->map_types);


While reviewing this file, I noticed another pre-existing issue in
pci_p2pdma_add_resource():

drivers/pci/p2pdma.c:pci_p2pdma_add_resource()
{
[ ... ]
	error =3D devm_add_action_or_reset(&pdev->dev, pci_p2pdma_unmap_mappings,
					 p2p_pgmap);
	if (error)
		goto pages_free;

	p2pdma =3D rcu_dereference_protected(pdev->p2pdma, 1);
	error =3D gen_pool_add_owner(p2pdma->pool, (unsigned long)addr,
			pci_bus_address(pdev, bar) + offset,
			range_len(&pgmap->range), dev_to_node(&pdev->dev),
			&pgmap->ref);
	if (error)
		goto pages_free;
[ ... ]
pages_free:
	devm_memunmap_pages(&pdev->dev, pgmap);
pgmap_free:
	devm_kfree(&pdev->dev, p2p_pgmap);

[Severity: High]
This is also a pre-existing issue, but are we leaving a dangling pointer in
the devres list here?

If gen_pool_add_owner() fails, the code jumps to the pages_free label and
explicitly frees p2p_pgmap via devm_kfree(). However, the devres action
pci_p2pdma_unmap_mappings is not removed.

During devres teardown, the registered action will execute and call
pci_p2pdma_unmap_mappings() with the freed p2p_pgmap pointer. This
dereferences p2p_pgmap->mem->owner->kobj, resulting in a use-after-free.

Would it be safer to use devm_remove_action() here to prevent this?

	return error;
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612083452.1639=
-1-lirongqing@baidu.com?part=3D1
