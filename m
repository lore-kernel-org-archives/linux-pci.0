Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB003C8C71
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322275; cv=none; b=Os+e1JBsucAdOUdEhgM9mqYlTWeWgGxRgZH0rxl0DfDUVa/6GjC1tQAfLmOOPf6OK0wr2bXgBbteOxCki3YuDyTVoDzU6GMWnzzk+Q4W4s/8DSnmfeYqMnDtf5zCW9O+THFZNuPmEdPhc4KdolMeWgiIZvEi24QHzvnD8wINNOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322275; c=relaxed/simple;
	bh=NRj4TZyV91L5D/ZZo5711y7U4ZusHW4cX0hJKGLh0t8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RNieixwLULcDBp0eLP3h2Xx0DGzbQbj/R66Jfz58ldb7U1jROIcRwPy/U8Xz5xkaLuOA5H2KOAVWC87AXVGL0DjePNRYi+u4QRFruHfIkYXSxLHsLcViabbBB+F7MB0XFTZpMpkTlEsvPFfaWAl/jc0sCgWZRrZnVDRI14x03ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcwfEzQi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcwfEzQi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907831F00893;
	Mon,  1 Jun 2026 13:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322273;
	bh=7mjQLyjZp39S7OhmVHQhHCvpMsL32X3f6qb0L/lvuJE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kcwfEzQiev6i0TtnHJKs+xK1RBYpsetwzX6q361Y2qOf3k+Df7+IthLpgAbtlQ+Y1
	 orO9+HN2AXYxNvLLeQIGhnwMgTpuhYep2NznazTvqTirRVb19P8RSXUxV+5wPQH4X3
	 QBJ17SSB/BujyqhGTJmsRmAhvJha8bCQfws7GTmJ47VzUDYx7Jnw4dtjQS9DtOSHmp
	 JoEtAL0t+tOC1PyXNz45kmcwQ7RWh/JVMvMv5uJ+bhDrODFtv7YR9A1i8doCH2NC1x
	 oY1nS9QYTt81aM35e9RxjY/ncWicYRF8rF+UA2aMnAVXRu6cIxDrQ0B6RV1U+M8QJV
	 jdPtGnT9eudGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] iommu/amd: Clear aliases before setting the
 rlookup_table to NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260601134204.2150602-2-praan@google.com>
References: <20260601134204.2150602-2-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 13:57:53 +0000
Message-Id: <20260601135753.907831F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Moving setup_aliases() before clearing the primary DTE incorrectly=
 copies the active (uncleared) DTE to DMA aliases, failing to clear them.
- [Medium] Reordering setup_aliases() before clearing rlookup_table exposes=
 a missing dev_data error path, causing log spam and aborting alias iterati=
on.
--

commit 3c05610e625a1605bf16151c884edcdce09fdf2d
Author: Pranjal Shrivastava <praan@google.com>

iommu/amd: Clear aliases before setting the rlookup_table to NULL

In iommu_ignore_device(), clearing the primary devid in the lookup table
before calling setup_aliases() causes rlookup_amd_iommu() to fail for
aliases. This commit moves the setup_aliases() call before clearing the
rlookup_table entry.

Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel=
.org/
Signed-off-by: Pranjal Shrivastava <praan@google.com>

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index f1333071da103..a94de66a885e7 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -745,10 +745,12 @@ static void iommu_ignore_device(struct amd_iommu *i=
ommu, struct device *dev)
>  		return;
> =20
>  	devid =3D PCI_SBDF_TO_DEVID(sbdf);
> -	pci_seg->rlookup_table[devid] =3D NULL;
> -	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
> =20
> +	/* Clear aliases while rlookup is still valid */
>  	setup_aliases(iommu, dev);

[Severity: High]
Does this copy the active DTE instead of the cleared DTE to the DMA aliases?

By moving the call to setup_aliases() before the memset() that clears the
primary Device Table Entry (DTE), setup_aliases() will read the primary
device's uncleared DTE and write this active DTE to the aliases.

Then memset() clears only the primary DTE, leaving the aliases retaining
their old active translations. Could this lead to unauthorized DMA or hardw=
are
use-after-free if the domain's page tables are subsequently freed?

[Severity: Medium]
Does this reordering also expose a missing dev_data error path when
iommu_ignore_device() is called during early initialization?

If this is called from an early initialization error path before dev_data is
set, dev_data will be NULL. Previously, because rlookup_table[devid] was set
to NULL first, rlookup_amd_iommu() inside clone_alias() would return NULL a=
nd
safely exit without further processing.

With this patch, rlookup_table is still valid when setup_aliases() is calle=
d,
so clone_alias() proceeds and hits the check:

drivers/iommu/amd/iommu.c:clone_alias() {
    ...
    dev_data =3D dev_iommu_priv_get(&pdev->dev);
    if (!dev_data) {
        pr_err("%s : Failed to get dev_data for 0x%x\n", __func__, devid);
        ret =3D -EINVAL;
        goto out;
    }
    ...
}

Returning -EINVAL causes pci_for_each_dma_alias() to immediately abort its
iteration. Can this cause unintended log spam and prevent the remaining
aliases from being processed?

> +
> +	pci_seg->rlookup_table[devid] =3D NULL;
> +	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601134204.2150=
602-1-praan@google.com?part=3D1
