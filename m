Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F1141BA61;
	Wed, 15 Jul 2026 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138631; cv=none; b=TIJf98cQDtRc+3qZp7e+F+uzPi5TSb69T1rnHeTKjildQr+tH/XsfTCYsvxkMVbZsMsEopWQJQgWUaw1/sxjytDY0OKLuCX8Tud4cuzmaC/ICz1zMY+XgAwiuV0Kr+Jc2WtZT85YSwcqLQLQXQwC3tLGBko6vs4Unos/qtj7wUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138631; c=relaxed/simple;
	bh=G4me3BS0cPKR8kIGzoCDaPN0ShhEcPC9ZbKviQ94+5Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ohNZjHTX+mvRpsWxwCblkJ1iy3w/pLxm6w+U2NwQxcv3Cb6QxydqfEcPaiYkZsX825DLP6rp6g7b/DrDdE6edUDYOhqoSzKZGPQs5KV8sr3wES0QE7lJXb/l5kL2JN5yEJCrQRi7ATbJsVmHS1gzRv9kk8KQ0WPRUA4TIVilQQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LM+XKe5L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LM+XKe5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50161F000E9;
	Wed, 15 Jul 2026 18:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784138610;
	bh=CJf1T9Sn4t5DNWf2vegcNJqYhDuTkVAr506bg49Dfj4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LM+XKe5LNQ075Sj5RY6MjsEcrCthq9U5bNvRi39IlueKCRy9yaKsZbRwfOVBw9Bj5
	 qudaeoc7gEC22hi/O+Y5DLmqPNQYBaqDhx0TIX5RpmrvTmmqDcfuODyUq/4QBGtTl2
	 ZziQSc+rBlKq8Z+9J4cMUvd8zs9Mj4lrR0C5Lq7RUCyC01UlRdY1yxDAcq7HS6JN2g
	 GJuN+Yq15UFgTEe/ssG32Y86VOIhD49BdPmd0T2mfiB4ZyJWlWDaRfydKpSaN4bAh7
	 fdzjkiftKpBNf+VMadhHd1+fVdMbMc8JlYWfTyOLgGXRpXOG9kxR5TbiYNwVwE6W+O
	 CUxZmvknSIPeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260715174737.15287-3-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-3-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:03:29 +0000
Message-Id: <20260715180329.C50161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Skipping `synchronize_rcu()` when `p2pdma->pool` is NULL causes a =
Use-After-Free of `pdev->p2pdma` and its XArray.
--

--- Patch [2]: [PATCH v5 2/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE ---
commit 963552636d1deb6dc48ba93e918ef61646e05d1a
Author: Matt Evans <matt@ozlabs.org>

PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE

This commit introduces CONFIG_PCI_P2PDMA_CORE and refactors the basic
provider functionality into a new p2pdma_core.c file. This allows drivers
to use pcim_p2pdma_provider() without a hard dependency on the full P2P DMA
management features.

> diff --git a/drivers/pci/p2pdma_core.c b/drivers/pci/p2pdma_core.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/pci/p2pdma_core.c
[ ... ]
> +static void pci_p2pdma_release(void *data)
> +{
> +	struct pci_dev *pdev =3D data;
> +	struct pci_p2pdma *p2pdma;
> +
> +	p2pdma =3D rcu_dereference_protected(pdev->p2pdma, 1);
> +	if (!p2pdma)
> +		return;
> +
> +	/* Flush and disable pci_alloc_p2p_mem() */
> +	pdev->p2pdma =3D NULL;
> +	pci_p2pdma_release_pool(pdev, p2pdma);
> +	xa_destroy(&p2pdma->map_types);
> +}

[Severity: High]
This is a pre-existing issue, but does skipping synchronize_rcu() when the
pool is NULL lead to a use-after-free?

Looking at pci_p2pdma_release_pool() in drivers/pci/p2pdma.c, it skips
synchronize_rcu() if the pool has not been set up:

void pci_p2pdma_release_pool(struct pci_dev *pdev, struct pci_p2pdma *p2pdm=
a)
{
        if (!p2pdma->pool)
                return;

        synchronize_rcu();
        gen_pool_destroy(p2pdma->pool);
        sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
}

If a driver initializes P2PDMA without setting up a pool, p2pdma->pool
will be NULL. When the device is unbound, devres executes
pci_p2pdma_release().

Because pci_p2pdma_release_pool() returns early, synchronize_rcu() is
skipped. pci_p2pdma_release() then immediately calls
xa_destroy(&p2pdma->map_types) and the p2pdma structure is freed.

Could concurrent RCU readers, such as pci_p2pdma_map_type() during a
DMA-BUF mapping, access the destroyed xarray or the freed struct and
trigger a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715174737.1528=
7-1-matt@ozlabs.org?part=3D2
