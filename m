Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC2C353A91
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 19:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342208; cv=none; b=sLKjnjaMBJt8uy5Cl0Y1RSh8CzxS7T1ct0xXQiQbEE+23vV5iBOVqFqx3RSIIVQnriiVpgJsijFN0d2e8/fprsIt3sDw/hykUmGg86EEibPtqC+QDVUs1+bj0T62DnxfVjooqatABAtUCjVOUOC3zM4kGNNJ+hbQgY9fHY5kHq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342208; c=relaxed/simple;
	bh=zRyRefhQiYjKtA1KNTI/iDD3l6+OguoPGp7ms60qB8c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=txidUkiPHaCmVR1Nysfnj9W1bBzMOW3BpK5gUFTF8XBXbE5LbZOSkvAeRonpUoPavH0WOkvnuilanzmTWgtCDNmvasg9F1ROkIscC+J7mINnS7pgceJJX/GsdyjxhkMGsZw3igy91/PJduHAVq8ejGJXtwr/F4Vte0vT72EhVKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcbbYo1J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcbbYo1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19D81F000E9;
	Fri, 21 Aug 2026 19:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787342207;
	bh=NKcmcvQLd/HT66pUeZkXOXO9d53FSeeKhlR7KNLt/Dw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TcbbYo1JnuQoIcnjkq/Cm5j5igcmLmdk/TF4USqv8FGQHX4kSHLxhC5vfpWeTDCAF
	 3CSV7+DjXvH3DqcEJIoRBLRr/QSJUT0ExdhuqwZp1IOadYaMFLyvlNju+eGCjiFKRd
	 R5VoSuKKfI4w6A2G1mNu3/mamOQspPZjAt5B0lJ3UVK7idj/Ifj7hcHhE+iHK+dstX
	 hrqwjGz+fiRUvS3ePA9t/M5P058L4ZmkwCkdaiv4fCgnwqx8xqheRTZxA8+pTNNw9q
	 YrQVVhcsBeQCTSVoiYoR4hsQiZ+vtltPsTpP7sc7GSxhjp4vgzyEYO14SDz0Oa7vDn
	 4EXZdVH/OBeLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/18] PCI/P2PDMA: Document the pdev->p2pdma lifetime
 and RCU rules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-5-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-5-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 19:56:46 +0000
Message-Id: <20260821195646.E19D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free of `p2p_pgmap` in `pci_alloc_p2pmem()` due to incor=
rect devres execution ordering.
--

--- Patch [5]: [PATCH v4 05/18] PCI/P2PDMA: Document the pdev->p2pdma lifet=
ime and RCU rules ---
commit 158fe7a750e98e97967829dbed7785e91ba2a835
Author: Leon Romanovsky <leon@kernel.org>

PCI/P2PDMA: Document the pdev->p2pdma lifetime and RCU rules

This commit documents the lifetime, publication, and teardown rules
for pdev->p2pdma, clarifying how the RCU grace period protects the
pci_p2pdma object and its gen_pool from concurrent access during
driver unbind.

> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index a77ef9deb3c65..49bc8cf062409 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
[ ... ]
> @@ -235,9 +268,19 @@ static void pci_p2pdma_release(void *data)
>  	if (!p2pdma)
>  		return;
> =20
> -	/* Flush and disable pci_alloc_p2p_mem() */
> +	/*
> +	 * Stop new RCU readers and wait for readers that observed p2pdma before
> +	 * allowing devres to free it. This is required even without a pool,
> +	 * because pci_has_p2pmem() dereferences every non-NULL p2pdma it finds.
> +	 * For a pool-backed provider this also fences gen_pool_destroy().
> +	 */

[Severity: High]
This is a pre-existing issue, but could this devres teardown ordering
lead to a use-after-free of p2p_pgmap in pci_alloc_p2pmem()?

Since pcim_p2pdma_init() registers pci_p2pdma_release() before
pci_p2pdma_add_resource() allocates p2p_pgmap via devm_kzalloc(),
devres LIFO ordering means p2p_pgmap is freed before pci_p2pdma_release()
is executed to clear pdev->p2pdma and destroy the gen_pool.

If a concurrent call to pci_alloc_p2pmem() occurs while the provider
driver unbinds, could it retrieve a chunk from gen_pool pointing to the
already freed p2p_pgmap->ref and pass it to percpu_ref_tryget_live_rcu(ref),
dereferencing a dangling pointer?

>  	RCU_INIT_POINTER(pdev->p2pdma, NULL);
>  	synchronize_rcu();
> +
> +	/*
> +	 * The grace period also ensures no RCU reader can still be accessing
> +	 * map_types here.
> +	 */
>  	xa_destroy(&p2pdma->map_types);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-fix-p2p-ac=
s-v4-0-v4-0-94426b96de73@nvidia.com?part=3D5
