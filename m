Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BBB3655C0
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290306; cv=none; b=FJYRZNTgfQ+heBgUUMtYofVQOrO/yCh0FaQ92FBOeC5+AWKPp54/nZCQBEbmKpYUsqTIgQ9Ib0XpoACSoRnXNFbH/CY8feWgPJUQlBBpZHQ5tEX4jwS4XbVPKT+UVrOUJruwCq9uBuvlF1sKyzxp7MICxLvkfX2ht/gT+IuT9Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290306; c=relaxed/simple;
	bh=d49MHNqbLJ+90WqqWoCNa2LhQ8UOnfoq3PU/v5TCwPU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sPKyGlzLYNo1ynJqv+seRo4QcHekjvUDMkK5amdomf3EbgasOgTcaEozmG3XvjXcRq1PRCgGabMrMQA/VEp03i8hFpkshWz4Yd/W+gHZH0cDvvcsmUUtU6/IaRuKmkbrGgIEjAvcLUoENyEiCcGoeWfYnSEIQaENQLrXl8LNCyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcN9//CA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcN9//CA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBEE1F00A3D;
	Sun,  5 Jul 2026 22:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783290305;
	bh=CiAOYOAxp06oadh3Z8p+rqvydnHmaoGhTr9hxh7HdzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lcN9//CAaly38srksPz0C1KlA7RrJIJyaxwQHcO/Sk3AZL1rVS5zIZMyw1N0BZ2Bu
	 xP1HCNcnvMQI/4tqCJ6UoyORUJn8NQEHRuBNbXpof7yTR/xTWawVzaH909bRRH0aHv
	 gp37eA+gzsQadHAtpk9IrHejOLh1qGaHKeZfAO4r6uVgBrYzx6LmnGbnS+cJKXgsUe
	 Bq2sknFSDrNXp619KW8nV+gRvd0D29BjpBdYG6BIK/1UufJLGCJdh71lGRX98zQivs
	 TpcErz+TQ1xPClzX2bDq8D7jCLqSFMev1vgu7MdNHQS1eEwJPkoTzM7R4pCWEdMAWd
	 i4TtqWR2JBetw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/15] PCI/TSM: Add device interface security DMA
 enable/disable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dan Williams" <djbw@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260705220819.2472765-13-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-13-djbw@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 22:25:04 +0000
Message-Id: <20260705222505.2CBEE1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Missing NULL pointer check for optional `ops->disable_dma` in `pci=
_tsm_disable_dma()`.
- [Medium] TSM flags are defined as bit masks instead of bit numbers, misus=
ing bitops APIs and creating a latent out-of-bounds write hazard.
- [Low] Invalid member access syntax in `__must_hold()` lock annotations ca=
uses build failures for static analysis tools.

Pre-existing issues:
- [High] Missing NULL pointer checks for optional TSM operations (`run`, `u=
nlock`) in the TSM core.
--

commit b2823259422c2c0267dccac4b1d9d8a5703f85ac
Author: Dan Williams <djbw@kernel.org>

PCI/TSM: Add device interface security DMA enable/disable

This patch adds helper functions to enable and disable device access to
private memory for the PCI TSM interface. It also introduces a new flag
to track when DMA access is enabled for a given device.

> diff --git a/drivers/pci/tsm/core.c b/drivers/pci/tsm/core.c
> --- a/drivers/pci/tsm/core.c
> +++ b/drivers/pci/tsm/core.c
> @@ -754,6 +754,48 @@ static ssize_t unlock_store(struct device *dev, stru=
ct device_attribute *attr,
>  }
>  static DEVICE_ATTR_WO(unlock);
> =20
> +/* pci_dma_configure() helper to finalize access to private memory. */
> +int pci_tsm_enable_dma(struct pci_dev *pdev) __must_hold(&pdev->dev->mut=
ex)

[Severity: Low]
Does this __must_hold() annotation cause build failures with static analysis
tools?

The dev field in struct pci_dev is an embedded struct device, not a
pointer, so it looks like this should use the dot operator instead of the
arrow operator for accessing the mutex.

> +{
> +	struct device *dev =3D &pdev->dev;
> +	const struct pci_tsm_ops *ops;
> +	int rc;

[ ... ]

> +	ops =3D to_pci_tsm_ops(pdev->tsm);
> +	if (!ops->enable_dma)
> +		return 0;
> +
> +	rc =3D ops->enable_dma(pdev);
> +	if (rc =3D=3D 0)
> +		set_bit(PCI_TSM_F_DMA, &pdev->tsm->flags);

[Severity: Medium]
Can this corrupt memory?

The set_bit() function expects a bit number as its argument, but the
PCI_TSM_F_DMA flag is defined as a bit mask. Passing the evaluated mask
value instead of the bit index causes it to set the wrong bit in the flags
field.

If a future flag shifts by 64, wouldn't passing 64 to set_bit() write past
the end of the unsigned long flags field and silently corrupt adjacent
memory?

> +	return rc;
> +}
> +
> +/*
> + * pci_dma_cleanup() helper to block private memory access as device is
> + * going idle
> + */
> +void pci_tsm_disable_dma(struct pci_dev *pdev) __must_hold(&pdev->dev->m=
utex)

[Severity: Low]
Is this __must_hold() annotation affected by the same embedded struct access
issue mentioned in pci_tsm_enable_dma()?

> +{
> +	const struct pci_tsm_ops *ops;
> +
> +	if (!pdev->tsm)
> +		return;
> +
> +	if (!test_and_clear_bit(PCI_TSM_F_DMA, &pdev->tsm->flags))
> +		return;
> +
> +	ops =3D to_pci_tsm_ops(pdev->tsm);
> +	ops->disable_dma(pdev);

[Severity: High]
Will this crash if a backend driver implements enable_dma but leaves
disable_dma as NULL?

The disable_dma pointer is unconditionally dereferenced here, whereas
pci_tsm_enable_dma() checks for the presence of the enable_dma callback
before calling it.

> +}

[ ... ]

> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h

[ ... ]

> @@ -102,6 +104,8 @@ struct pci_tdi {
> =20
>  /* Private operation acknowledged, future ioremap will use private alias=
 */
>  #define PCI_TSM_F_ACCEPT (1UL << 0)
> +/* DMA access to private memory enabled */
> +#define PCI_TSM_F_DMA (1UL << 1)

[Severity: Medium]
Is this flag intended to be used with atomic bitops?

Because it is defined as a bit mask instead of a bit number, using it with
functions like set_bit() or test_and_clear_bit() will operate on bit 2
instead of bit 1.

[ ... ]

While reviewing this patch, I also noticed a potential issue in the
existing TSM core code:

drivers/pci/tsm/core.c:pci_tsm_accept() {
    ...
    rc =3D to_pci_tsm_ops(pdev->tsm)->run(pdev);
    if (rc)
        return rc;
    ...
}

[Severity: High]
This is a pre-existing issue, but could this cause a kernel panic if a
backend driver omits the optional run or unlock callbacks?

The code in pci_tsm_accept() and pci_tsm_unlock() seems to unconditionally
dereference these pointers without checking if they are NULL, similar to
the disable_dma issue mentioned above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705220819.2472=
765-1-djbw@kernel.org?part=3D12
