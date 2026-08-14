Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8515522D7A1
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 02:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786674853; cv=none; b=qT0jZUezAVQ5bDBXEieenOGnEZ7dhg2LbOiSFTEvoy5Q473UlTbg4Xn9+FKREGObpfRDFLwUWZcZxdxHH4qSDmfQSM8UgYmMM35gxvTHYAhAuc0dGU643Hd/zM6wKEb9Z+useFDtnV8RXKvjY7KRAeZA5U8/0UjDV3WbXGB4Oyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786674853; c=relaxed/simple;
	bh=hxp552K2Au50rgnem/LU+C0T95YsJjGdc+XiVSNp6U0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jNehyAtExhtLdpFCpA4YJ+rsED2nITAsJ5LW+2WeiE2R10k1ugjO+/3QrXdjCHHNkwtmIVMKTkawS2TofK4RNkWI8+sXYck0b5OmLJrzysnGwzzPoQ94/tcfoDwP9ghVbxezCIXpZdNDTk2Pdk/IcLP68O7/mQWuYNoVIjKKDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRgwhviH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRgwhviH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60821F000E9;
	Fri, 14 Aug 2026 02:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786674852;
	bh=C3Jc3XRwkgKKe8SnrHtdKXtHJBEgdPKJAPDp45hs92A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mRgwhviHH0PcOlOXr7t8NM5wIegjI4gnQGBtRk1NXkP3joGqqvQlNQVzcasPLQx0i
	 QJ4DbG5hWb1U+bAcJgo26GkRy39o+N6nEKiYYTeJfG1ta56QuLxGUF7F9crnlKcE78
	 IkygZut7gSBJ37RyCLqPY0DxwRu3BbB1rj4ZRe4PKrfFEdubU1zy4RyFeVEyFtt+Ro
	 RhgeVq9UKw2C08dwkkN1TUmS1xypgSZRcn1U+7iTNJWuBEmW9melS/grVIltZdIHV7
	 zC5quDMG0i8x+f6VUzbhEMrj8fIHWiQXNAXbKJiZWfG2NOf3hke8duG63yW8gicGTT
	 iu5wadh3qxIxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260814015647.3370124-3-praan@google.com>
References: <20260814015647.3370124-1-praan@google.com>
 <20260814015647.3370124-3-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 02:34:11 +0000
Message-Id: <20260814023411.D60821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The condition `if (dev_iommu_priv_get(dev))` in `iommu_disable_dev=
ice_dma()` always evaluates to false on the probe error path, making the al=
ias DTE cleanup dead code.
- [High] Lockless execution of atomic DTE write helpers risks silent update=
 failures and IRQ remapping corruption.

Pre-existing issues:
- [High] Missing hardware IOMMU cache flush after disabling device DMA.
--

--- Patch [2]: [PATCH v2 2/5] iommu/amd: Fix DTE clearing and rename iommu_=
ignore_device() ---
commit fe0ff8dabc53d6febbad3289c8dca1c1bf0c2df2
Author: Pranjal Shrivastava <praan@google.com>

iommu/amd: Fix DTE clearing and rename iommu_ignore_device()

This commit replaces the manual memset of the primary Device Table Entry
with a dedicated helper to avoid torn writes. It explicitly clears the
DTE lower and upper bits, and renames the function to
iommu_disable_device_dma.

Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel=
.org/

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index ef21fbd9c9a89..91d551f29ed12 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c

[ ... ]

> @@ -2243,6 +2227,41 @@ static void dev_update_dte(struct iommu_dev_data *=
dev_data, bool set)
>  		clear_dte_entry(iommu, dev_data);
>  }
> =20
> +/*
> + * Invalidate a DTE by clearing the Valid bit first.
> + * Note: Not to be used on a fully probed device with
> + * live dev_data.
> + */
> +static void amd_iommu_disable_dte(struct dev_table_entry *ptr)
> +{
> +	struct dev_table_entry new =3D {};
> +
> +	write_dte_lower128(ptr, &new);
> +	write_dte_upper128(ptr, &new);
> +}

[Severity: High]
Does this sequence need to be protected by a lock?

Looking at write_dte_upper128(), it performs a read-modify-write of the
interrupt mask:

write_dte_upper128(ptr, new)
    old.data128[1] =3D ptr->data128[1];
    new->data[2] &=3D ~DTE_DATA2_INTR_MASK;
    new->data[2] |=3D old.data[2] & DTE_DATA2_INTR_MASK;
    amd_iommu_atomic128_set(&ptr->data128[1], new->data128[1]);

The comments in write_dte_upper128() mention this requires being inside
a spin_lock(&dev_data->dte_lock) context. If this is called locklessly,
could a concurrent modification (such as clone_aliases() from another
device probing) cause the underlying cmpxchg16b to silently fail or
corrupt the IRQ remapping masks?

> +
> +static void iommu_disable_device_dma(struct amd_iommu *iommu, struct dev=
ice *dev)
> +{
> +	struct amd_iommu_pci_seg *pci_seg =3D iommu->pci_seg;
> +	struct dev_table_entry *dev_table =3D get_dev_table(iommu);
> +	int devid, sbdf;
> +
> +	sbdf =3D get_device_sbdf_id(dev);
> +	if (sbdf < 0)
> +		return;
> +
> +	devid =3D PCI_SBDF_TO_DEVID(sbdf);
> +
> +	/* Clear the primary DTE */
> +	amd_iommu_disable_dte(&dev_table[devid]);

[Severity: High]
This is a pre-existing issue, but does the IOMMU hardware cache need to be
flushed after clearing the primary DTE in memory here?

Since the DTE is cleared in memory without a subsequent hardware flush
command (like iommu_flush_dte_sync() or iommu_completion_wait()) before
returning, could the IOMMU hardware continue using the old cached DTE and
retain DMA privileges on failure paths?

> +
> +	/* Clone the cleared DTE to all aliases before wiping the rlookup */
> +	if (dev_iommu_priv_get(dev))
> +		clone_aliases(iommu, dev);

[Severity: High]
Will this condition ever be true when called from the probe error path?

Looking at amd_iommu_probe_device(), it calls iommu_disable_device_dma()
only when iommu_init_device() fails:

amd_iommu_probe_device()
    dev_data =3D iommu_init_device(iommu, dev, devid);
    if (IS_ERR(dev_data)) {
        ...
        goto err_deinit;

err_deinit:
    iommu_disable_device_dma(iommu, dev);

Since dev_iommu_priv_set() is called inside iommu_init_device(), if the
initialization fails, dev_iommu_priv_get(dev) would return NULL.=20
Doesn't this mean clone_aliases() is completely skipped during cleanup on
this error path, leaving DMA aliases active?

> +
> +	pci_seg->rlookup_table[devid] =3D NULL;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814015647.3370=
124-1-praan@google.com?part=3D2
