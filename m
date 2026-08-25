Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C3446A611
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667942; cv=none; b=UQ2nNVXHarCqfTC2/H8jCvy51GlTcpRNmsAri4oMYfuDWNXWuvOhIq87CY95o+A6Xtg01F/jctPZhUU4wDDA2krCfIOGtk+5wbYQ8pWjnJmcn6s3Myp6FmIcM+bwANizppmWpIw6HpXLgcA5rWm+0xtp0Vr5jtgGo5vpTbYMnBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667942; c=relaxed/simple;
	bh=AI33x29Qrtvg8nMvC43FuDe1D5Ilk6WEiTwgnSYqX5g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q6X6h8A2HnfFsSugxBL60OORws9HxNAVe7F9fV/gGtzFMBDZj0XbIpsxonEuZbOoQmz3YyrnWNlnG1rpzx2UdbAZYs307xZUa1Fx6EaD4c/guZBH0C8LzTfzM3Flyy62WO6Jb3kFT+1sSG2YG8PFdFOkpk8O5rV+SPq+3hzZjgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCDBSxZh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCDBSxZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652471F000E9;
	Tue, 25 Aug 2026 14:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787667940;
	bh=7hbI24ms9RkkwO15qFUCVSir8dtwhCc0FGuXaa3nsks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fCDBSxZh41v71CfrEJbIzb183F87hCp8LJYsltVKyWuoaohC+ssFE7ugbv/3cf8Dq
	 dv/HxWXoQvTPya1lPFXlTsg7FinfTpe8BlmSNNgSsdbBp0RyNqxOQUbGDYeqRaKGS1
	 IG54jFUHUDh/aD2J4R2Ch36zGbfmrniu4C4L+PMKEmCZ59q8OnbD+yFpfLPsh+b6wf
	 49DZF/aDmMYN3SBQnzxt2rrbNJMwwCqKBVbZu41SOQ4W+CSU8eTZGaia8JPrP7Ptfz
	 N7LttqyNU+88AeU7hbguEkvBEAmoq1Gp+jaEvQ84GoJ554byvgsYSjx1Tzv6oKR9K7
	 vF6B0qibX8Fkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2] PCI/MSI: Don't touch the MSI-X table while the Link
 is contained
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vidya Sagar" <vidyas@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260825140952.4066140-1-vidyas@nvidia.com>
References: <20260817195626.3091331-1-vidyas@nvidia.com>
 <20260825140952.4066140-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 14:25:39 +0000
Message-Id: <20260825142540.652471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The early `pci_msi_dev_inaccessible()` check in `pci_msix_write_tp=
h_tag()` leaves a large race window across lock acquisitions, leading to an=
 unconditional flush read on an inaccessible device.
- [High] Silently skipping writes in `pci_msix_write_vector_ctrl()` exposes=
 callers like `pci_write_msg_msix()` to partial MMIO updates and unconditio=
nal flush reads.
--

--- Patch [1]: [PATCH V2] PCI/MSI: Don't touch the MSI-X table while the Li=
nk is contained ---
commit 170aedad1f36f8c51175a3888ba22b67ee4a98ef
Author: Vidya Sagar <vidyas@nvidia.com>

PCI/MSI: Don't touch the MSI-X table while the Link is contained

The MSI-X Table lives in device MMIO space behind a BAR, so it is only
reachable while the Link is up. This patch skips hardware accesses to
the MSI-X table when the device is not in pci_channel_io_normal to prevent
DPC escalations caused by Unsupported Requests. It also modifies
pci_msix_write_tph_tag() to return -EIO to let the caller disable TPH.

> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 80a9db417dc87..0ebe153937ccc 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
[ ... ]
> @@ -954,6 +954,14 @@ int pci_msix_write_tph_tag(struct pci_dev *pdev, uns=
igned int index, u16 tag)
>  	if (!pdev->msix_enabled)
>  		return -ENXIO;
> =20
> +	/*
> +	 * The tag update below is a write to the MSI-X Table followed by a
> +	 * flush read, neither of which can be completed while the Link is
> +	 * contained. Let the caller disable TPH instead.
> +	 */
> +	if (pci_msi_dev_inaccessible(pdev))
> +		return -EIO;
> +

[Severity: High]
Since this check happens before acquiring msi_descs_lock and irq_desc->lock
in pci_msix_write_tph_tag(), does it leave a race window where the device
could become inaccessible after the check?

If a DPC event occurs while waiting for the locks, it looks like the
subsequent unconditional flush read:

drivers/pci/msi/msi.c:pci_msix_write_tph_tag() {
    ...
	/* Flush the write */
	readl(pci_msix_desc_addr(msi_desc));
    ...
}

would still execute on an inaccessible device, potentially triggering the
exact DPC escalation this patch aims to prevent.

>  	virq =3D msi_get_virq(&pdev->dev, index);
>  	if (!virq)
>  		return -ENXIO;
> diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
> index 0b420b319f50f..c3194d8425c88 100644
> --- a/drivers/pci/msi/msi.h
> +++ b/drivers/pci/msi/msi.h
[ ... ]
> @@ -36,6 +50,9 @@ static inline void pci_msix_write_vector_ctrl(struct ms=
i_desc *desc, u32 ctrl)
>  {
>  	void __iomem *desc_addr =3D pci_msix_desc_addr(desc);
> =20
> +	if (pci_msi_dev_inaccessible(msi_desc_to_pci_dev(desc)))
> +		return;
> +

[Severity: High]
If this silently skips the vector control write, does it expose callers like
pci_write_msg_msix() to partial MMIO updates and unconditional flush reads?

Looking at pci_write_msg_msix(), if the mask write is silently skipped,
would the subsequent address and data writes, as well as the flush read,
still execute unconditionally:

drivers/pci/msi/msi.c:pci_write_msg_msix() {
    ...
	writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
	writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
	writel(msg->data, base + PCI_MSIX_ENTRY_DATA);

	if (unmasked)
		pci_msix_write_vector_ctrl(desc, ctrl);

	/* Ensure that the writes are visible in the device */
	readl(base + PCI_MSIX_ENTRY_DATA);
    ...
}

Could this trigger an Unsupported Request and the DPC escalation if the link
is contained?

>  	if (desc->pci.msi_attrib.can_mask)
>  		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825140952.4066=
140-1-vidyas@nvidia.com?part=3D1
