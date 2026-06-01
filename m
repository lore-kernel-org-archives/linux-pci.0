Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918723BCD1A
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324246; cv=none; b=FtVPkXClx28fSp96L26dZsbav8IKqpSqxAXvgJAgtd18HrIr7emLKfQYp7I2qFmq4BLEWv5sTjfvpfT+G48b1lGxwj/yj2GDe5TrZHVqjQcZQgLRi063C60Gl0eUpKvVPFu1DJ/3yqEVGBg9dXVeRjIW33JjiKKnz3LDaAq96gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324246; c=relaxed/simple;
	bh=X7k1Wgigc4dwyBc3DX8M+8a4zopa6h/qT3M78LhgZxc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P/f6lvrmqXZFipqIYDujwbQpZ3Q2D5FIqHop47I6MIoATEx7aEYSi/EJdwsO1MG+9AzNvrqQl6W3DhL97xCtJl2cS/UhRjKga+BsjKzYcBVFV0wmGKx7HFneuSW8zbk7ix2sunAHnZe++XWE+VRTW+iPvr4pZxKzsWFwphTAgQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKBDcnum; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKBDcnum"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE501F00893;
	Mon,  1 Jun 2026 14:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780324245;
	bh=X7wWfPcd4S1C4MJsBh0CKZHrnkJGUOw+KTjRyhSXH7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aKBDcnumCqAa7kgVyYnNCi8HkUaUJP+Z5LJZZGQ0buMJ+2KNSaLvqqfiNIA/ZzOf9
	 JEFflLgbjwxY6FTZu3mgPTzOfiSjxM+OzLBkTIqmM7azK7TlAxHkleaNVa2IdqPF+C
	 vNPfP1DlBsGwSVEqM1DN+1N+BO/oNHGkFTBFV3q9y0WvTspAB30KrM/MAYr6HjjTJ6
	 TYFuqjkqoZdgLfnL8nbqpQGJvVL4u/SyL/hCFhOa6+KQSYy2MLuVbTB5kMKsT6EavO
	 v+JqhhNjAs+DBPztjmNy4m6Fkq/UGd9Quw1/3BqQ6gzGETKCpxhD9e8Qe0N3yC6nEg
	 wPzDu6FE44Mcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] iommu/amd: Split probe error paths to preserve IRQ
 remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260601134204.2150602-4-praan@google.com>
References: <20260601134204.2150602-4-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 14:30:44 +0000
Message-Id: <20260601143045.1CE501F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] `iommu_ignore_device()` suffers from dead code and incorrect reord=
ering, resulting in broken alias clearance, log spam, and unsafe non-atomic=
 DTE clearing (torn writes).
- [Low] The commit silently fixes a build failure by adding a missing `dev_=
data` variable declaration that was used in the previous commit, breaking g=
it bisect.

Pre-existing issues:
- [High] Skipping configuration on `PD_MODE_NONE` leaves `dev_data->max_irq=
s` uninitialized (0), completely breaking IRQ remapping.
--

commit b695f2fee16ac1c72b6f21b22dedf39b5ec55656
Author: Pranjal Shrivastava <praan@google.com>

iommu/amd: Split probe error paths to preserve IRQ remapping

This commit splits the error paths in amd_iommu_probe_device() to ensure
proper initialization failures clear the device, while configuration failur=
es
like PD_MODE_NONE preserve the rlookup_table entry for IRQ remapping.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel=
.org/
Suggested-by: Ankit Soni <ankit.soni@amd.com>

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 9b5861e241d71..c3b3750d4a22d 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -737,6 +737,7 @@ static int iommu_init_device(struct amd_iommu *iommu,=
 struct device *dev)
>  static void iommu_ignore_device(struct amd_iommu *iommu, struct device *=
dev)
>  {
>  	struct amd_iommu_pci_seg *pci_seg =3D iommu->pci_seg;
> +	struct iommu_dev_data *dev_data =3D dev_iommu_priv_get(dev);

[Severity: Low]
Does this silently fix a build failure from a previous commit?

It appears the preceding commit in this series introduced the use of dev_da=
ta
in iommu_ignore_device() but failed to declare it. Adding the declaration h=
ere
fixes the build, but breaks bisectability between the two commits.

Could this fix be squashed into the commit that introduced the bug to ensure
the series remains fully bisectable?

[Severity: High]
Is dev_data always NULL when iommu_ignore_device() is called here?

Since iommu_ignore_device() is exclusively invoked from the error path of
amd_iommu_probe_device() when iommu_init_device() fails, dev_data will be
NULL because iommu_init_device() fails before dev_iommu_priv_set() is calle=
d.

If dev_data is NULL, the atomic DTE clearing block in this function becomes
dead code, and it falls back to the unsafe memset(), which risks torn writes
on live hardware:

drivers/iommu/amd/iommu.c:iommu_ignore_device() {
    ...
    if (dev_data) {
        struct dev_table_entry new =3D {};
        amd_iommu_make_clear_dte(dev_data, &new);
        update_dte256(iommu, dev_data, &new);
    } else {
        memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
    }
    ...
}

Additionally, because setup_aliases() is unconditionally called before this,
its internal clone_alias() will abort on the NULL dev_data and generate pr_=
err
log spam without actually clearing the alias DTEs.

[ ... ]

> @@ -2512,6 +2512,10 @@ static struct iommu_device *amd_iommu_probe_device=
(struct device *dev)
>  	if (dev_is_pci(dev))
>  		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
> =20
> +	return iommu_dev;
> +
> +err_deinit:
> +	iommu_ignore_device(iommu, dev);
>  out_err:

[Severity: High]
This is a pre-existing issue, but does skipping the device configuration
leave max_irqs uninitialized?

The commit message notes that configuration failures like PD_MODE_NONE
skip iommu_ignore_device() to preserve the rlookup_table entry for IRQ
remapping.

However, because amd_iommu_probe_device() jumps directly to out_err on
PD_MODE_NONE, it bypasses the initialization of dev_data->max_irqs, leaving
it at 0.

Later, when alloc_irq_index() tries to allocate an IRQ, it relies on max_ir=
qs:

drivers/iommu/amd/iommu.c:alloc_irq_index() {
    ...
    for (index =3D ALIGN(table->min_index, alignment), c =3D 0;
         index < max_irqs;) {
    ...
}

Since max_irqs is 0, the loop is skipped and it returns -ENOSPC, which
completely breaks IRQ allocation for the device, defeating the purpose
of preserving the rlookup entry.

>  	return iommu_dev;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601134204.2150=
602-1-praan@google.com?part=3D3
