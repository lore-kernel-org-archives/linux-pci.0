Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8027C26ED4F;
	Fri, 28 Aug 2026 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937873; cv=none; b=T6GbDyxGKeCRcj9MwfN2HOsCJvB1zWlFKPOIJtqMRfu0xeY2OQI8RjjhrVHVF+KYMvkti+7xkJCjyujdj9EjPfI8YZFsFd56R3tUcyE6E8irLk8Oh3BLN2ifo4BxT9BJZIE8em5yF9DRPhg5yYPgq+Tn7YGuM5iKAdQpKYimi2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937873; c=relaxed/simple;
	bh=HxeigZgStQBlWpK8/YyI4VfZcqgs+u84/BbfIYRiEuc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GjJc43Paim175xW55vdjJJ3Bc7sfrnjxPMTJJ6621sZb1Qc9yLXyYbcUIDFiXOSf83PCPGrSiA5GW0CEyh9HPixQTT7o/pSvSN10rt8iGdzYb0VJX9cywPY5lsQXHseaFC6nWKlIRY5Kv0qusUm3V/wWaSqPb14F/lOVdwrHMmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFCmV8AH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFCmV8AH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016061F000E9;
	Fri, 28 Aug 2026 17:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787937872;
	bh=L0qUfdT0Nmv1l2/0B+doLBGKundGX9vURCyVLlV26Os=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kFCmV8AHKQbJ3vdq+816kDTRd0K6O1+5KdxQcdvKtDHNHGYvRmMMwurytv0RjL6mH
	 gsB8KY8ezWvkiTb2OVLZ8hSkVk4bh4FQREhVcHg0rhgrFnb0q6txF6xXn/PX+UnIyw
	 D+HVlVUu5WqYvmcI+3HvYsNUPcX9ERAKwIg62u3ydRouGx4rKRTT0cSvUlC5SvNZNk
	 frRXOSsBj+gLOTLmAlIHg7PH8p/1+fOx6/i/nDFcwsvnXKIah6KTUBNzIkuRoegHXm
	 IFvUxoZNnnjuI2Wm7dDx9D95+KC+Pab8fmeJE3Gs14sJhge9Yj+QfEFu/1OMJwmQ8O
	 Qmf6xpX3HIJRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20260828170932.2735807-6-den@valinux.co.jp>
References: <20260828170932.2735807-1-den@valinux.co.jp>
 <20260828170932.2735807-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 17:24:31 +0000
Message-Id: <20260828172432.016061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unaligned MMIO offset provided by untrusted device causes alignmen=
t fault and kernel panic.
- [Medium] Unsupported DMA extensions or insufficient IRQs cause the core N=
TB device probe to fail entirely, rather than gracefully falling back to a =
non-DMA mode.
- [Low] The macro or enum value DW_EDMA_CHIP_PARTIAL is not declared in the=
 kernel tree.
--

commit 47ea035773d643574d3bec0ab584f66f7879214f
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_hw_epf: Discover vNTB-embedded DMA

This commit allows a vNTB PCI function to expose endpoint-local DMA channels
to its host. It decodes the extension, registers advertised channels, and
dispatches on the advertised DMA type.

Link: https://lore.kernel.org/r/20260312165005.1148676-1-den@valinux.co.jp/
Link: https://lore.kernel.org/r/20260813063757.3131865-9-den@valinux.co.jp/

> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_=
epf.c
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
[ ... ]
> +static bool ntb_epf_dma_region_parse(struct ntb_epf_dev *ndev, u32 base,
> +				     bool optional,
> +				     struct ntb_epf_dma_region *region)
> +{
> +	resource_size_t bar_len;
> +	u32 bar, offset, size;
> +
> +	bar =3D readl(ndev->ctrl_reg + NTB_EPF_DMA_REGION_BAR(base));
> +	offset =3D readl(ndev->ctrl_reg + NTB_EPF_DMA_REGION_OFFSET(base));

[Severity: High]
Is offset validated for alignment here? Since this is read directly from
the untrusted device configuration space, a malicious or buggy endpoint cou=
ld
provide an unaligned offset.

[ ... ]
> +static int ntb_epf_dw_edma_map_region(struct pci_dev *pdev,
> +				      struct ntb_epf_dma_region *region)
> +{
> +	region->vaddr =3D pci_iomap_range(pdev, region->bar, region->offset,
> +					region->size);

[Severity: High]
If the region->offset provided by the endpoint is unaligned, does mapping
it via pci_iomap_range() yield an unaligned virtual address?

The dw_edma driver subsequently uses 32-bit accessors (readl) on this
mapping, which can cause an alignment fault (synchronous external abort) and
kernel panic.

[ ... ]
> +static int ntb_epf_dw_edma_init(struct ntb_epf_dev *ndev)
> +{
[ ... ]
> +	chip->dev =3D ndev->dev;
> +	chip->ops =3D &ntb_epf_dw_edma_ops;
> +	chip->flags =3D DW_EDMA_CHIP_PARTIAL;

[Severity: Low]
Does this code build? It looks like DW_EDMA_CHIP_PARTIAL is not declared
in the kernel tree. This might be a leftover from an unmerged or modified
prerequisite patch series.

[ ... ]
> +static int ntb_epf_dma_parse(struct ntb_epf_dev *ndev)
> +{
[ ... ]
> +	switch (type) {
> +	case NTB_EPF_DMA_TYPE_DW_EDMA:
> +		ret =3D ntb_epf_dw_edma_parse(ndev, length);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}

[Severity: Medium]
If the endpoint exposes a newer or unrecognized DMA type, this returns
-EOPNOTSUPP and causes the core NTB device probe to fail entirely.

Would it be better to gracefully fall back to a non-DMA mode so core NTB
functionality (doorbells, memory windows) remains available?

[ ... ]
>  	int i;
> =20
> -	irq =3D pci_alloc_irq_vectors(pdev, msi_min, msi_max, PCI_IRQ_MSIX);
> +	irq =3D pci_alloc_irq_vectors(pdev, msi_min + dma_irqs,
> +				    msi_max + dma_irqs, PCI_IRQ_MSIX);

[Severity: Medium]
This now strictly requires dma_irqs to be available. If a constrained host
platform lacks enough MSI/MSI-X vectors to satisfy the msi_min + dma_irqs
requirement, pci_alloc_irq_vectors() will fail.

Can we allow the initialization to proceed without DMA support in this
scenario instead of aborting the whole probe?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828170932.2735=
807-1-den@valinux.co.jp?part=3D5
