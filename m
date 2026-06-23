Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01B82C21E6;
	Tue, 23 Jun 2026 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205648; cv=none; b=NsA2R9WaIqRACLOGE4GZpSs0EMn2DfmyNBKxIJEBrVTgg51OyGiI6ewdlpLro4+5sOgwKJiKCsoqfkk4fCnte0Ygw5IxSd41PJlG84uy+U5vbzl7G6OqU+RVs5VF0Tw89TZF1W41+BuSVatDbRhZAWhtjewEwSiYCv/6HSYl5UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205648; c=relaxed/simple;
	bh=ENXLyCfGuYIUVLYsA+yFzlxLefbHHiRKD6uQlfyPRH8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mLK2DyTwwe6XWRJ3YCnNCyEpVgrtrMG8h2Ru9UnNOqWpqFAQ8wGaKBtLxD4uGtjtoPMlsjqd+dENectMwfi98xyoi+xOrFCZGe7E943Ua2cfFDap7o2uoYYl+fSstTk3gfx/6/m6UXcgveh1xRwxNlrcD1b4EzuNYsE4W7zIwH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brF3R+kb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brF3R+kb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBFD1F000E9;
	Tue, 23 Jun 2026 09:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782205647;
	bh=g+GPvH4aE522azUbo+53bsqHi9/zN7fUhLycPvAOEaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=brF3R+kbXpuwVo3Gp8/eBbhxNcl7e9si41LgwPB9DYW4rOOqha7dhK4weDomSWDrF
	 TR+Sbqy4pSCLRKBD5qimEI+RMMv4lI5K133DGem2lX5URu699qTjFFP1/LvIaq9IBc
	 HisisICrKQFr5ickBdTjfpx7h7pEg48xn3lKJcaiKCi90EMRvzhYDpz5JZ4gevOxwQ
	 sqRV1xZv3d1UmL1JBm6tT3+/6I6fCDtycEIKydh+sUUAaUg45bZdAKwW+9RkPDo9iw
	 PmL+fvkVxPjotHvVMtWvc+l+1gnHFNNkSqaUmGnIdmCdIRyvU8gCn4v4YMQLUqjtWS
	 JLxOzWVGxMNQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v18 07/12] PCI/TPH: Add pcie_tph_supported()
 helper to check TPH capability attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260623085048.51139-8-fengchengwen@huawei.com>
References: <20260623085048.51139-1-fengchengwen@huawei.com>
 <20260623085048.51139-8-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 09:07:26 +0000
Message-Id: <20260623090727.3FBFD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `pcie_tph_supported()` helper ignores the system-wide `pci_t=
ph_disabled` flag, causing VFIO to incorrectly expose an unusable TPH capab=
ility to guests.
--

commit 8a6b48383e4674ff26e8119bccd07a94e9e6b180
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Add pcie_tph_supported() helper to check TPH capability attributes

This commit adds the pcie_tph_supported() helper to check if a PCI device
has a valid TPH capability or Extended TPH support. The helper is intended
for use by VFIO to query TPH existence and capabilities uniformly.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c

[ ... ]

> @@ -596,3 +596,22 @@ void pci_tph_init(struct pci_dev *pdev)
>  	save_size =3D sizeof(u32) + num_entries * sizeof(u16);
>  	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
>  }

[ ... ]

> +/**
> + * pcie_tph_supported - Check TPH capability attribute
> + * @pdev: PCI device to query
> + * @want_ext: false - check TPH cap exists; true - check EXT_TPH support
> + *
> + * Return: true on matched condition, false otherwise
> + */
> +bool pcie_tph_supported(struct pci_dev *pdev, bool want_ext)
> +{
> +	if (!pdev->tph_cap)
> +		return false;
> +

[Severity: Medium]
Should this function also check the system-wide pci_tph_disabled flag?

If the host administrator explicitly disables TPH via the notph boot
parameter, pci_tph_disabled is set to true. Because this helper only
checks pdev->tph_cap, it appears VFIO will still evaluate this as true
and expose a "zombie" TPH capability to guests.

The guest would see the capability but silently fail to enable it since
VFIO's configuration intercept correctly enforces pci_tph_disabled.

Would it be better to return false here if pci_tph_disabled is set, so
we respect the administrator's global disable intent and avoid exposing
unusable capabilities to guests?

> +	if (!want_ext)
> +		return true;
> +
> +	return pdev->tph_ext_support;
> +}
> +EXPORT_SYMBOL(pcie_tph_supported);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623085048.5113=
9-1-fengchengwen@huawei.com?part=3D7
