Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEB0C2EA
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 00:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780015711; cv=none; b=li6u7tlCdAN2ZM0ADjeLDPsZgMPRvsdbeTYLktLkYFMaiCIf7fatw+e2Om9aEw20kmEiikje7MOigalPkRuNrQKp9d3oDsdYErH1JziqhB139Feur1DoKjVHWmN/hIMXUiSpadjB4THcK0GUhDLHnBgYaIlQ7t/x4Ep2L5qZyYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780015711; c=relaxed/simple;
	bh=P05Efk0nwWhxQy9GwcYKgX+5dLTU2czm0OFYOOg0N7c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KtbS7lUo9U7BQukl/TpLjhTVffyAcxrC1+33XVR7mOHAZuI8dYf03IuQC6pw9ZLjyRnlQX0zyvcSAAaETgyhS0JRsnFp9X954slTSle61I027RZaV5oHNVwEegQ2nwbiO9UUYigc6TQ5sM/LEEjZxA8BXuiLXue5yUaUnVojUFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxdH0+QZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxdH0+QZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4834C1F00A3A;
	Fri, 29 May 2026 00:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780015710;
	bh=VEogFjMTce+bVqvn9rTLBlYCWbofUW59WpF+CDT7dAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mxdH0+QZzncJc+PfT2N2CxD6N1CAfzvhMZ4N2gRPmrbBBzvj2r10ttTZn2DhTsa8X
	 klEtkYjY3P/unq9iaCOwFmJeoMMW8Ww+nYvLAnN92uGObVNTDpjbg8wGYBtyoPgL8/
	 IrLoQ18fAH9LlFznPF/RR1hAfw6JBtfeqMtldSF1TAfm3iFEYJz2GYt5uIL85yfIi+
	 FTbW8to0yQhCylv+uIQyHgRbGMyIu0KC6H2s5F7ngyur+a8Ty0oQmTbiTgPBgVdBV9
	 2gBnUL5//8/gCunY1nVbaQcUmGaLeLN5Zl113H5ciC/HwueqYKbhAYcCUToZe/u/bd
	 9GCc2aicxZWaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/7] iommu/amd: Fail probe on ATS configuration
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260528202353.3422206-8-praan@google.com>
References: <20260528202353.3422206-8-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 00:48:29 +0000
Message-Id: <20260529004830.4834C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Redundant double execution of iommu_ignore_device() on the iommu_in=
it_device() failure path.

Pre-existing issues:
- [High] Error paths in amd_iommu_probe_device() fail to restore the device=
's MSI domain, permanently breaking interrupts.
--

commit 2c1c09bb5d6ece72e15df4a61c4ade971f95f48f
Author: Pranjal Shrivastava <praan@google.com>

iommu/amd: Fail probe on ATS configuration failure

This commit updates the AMD IOMMU driver to handle ATS configuration
more strictly by failing the device probe if pci_prepare_ats() returns
an error. It also adds a warning if pci_enable_ats() fails during
enablement and ensures iommu_ignore_device() is called on all probe
failures.

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 84cad43dc188c..b74c4504bee39 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c

[ ... ]

> @@ -2502,10 +2508,22 @@ static struct iommu_device *amd_iommu_probe_devic=
e(struct device *dev)
>  	else
>  		dev_data->max_irqs =3D MAX_IRQS_PER_TABLE_512;
> =20
> -	if (dev_is_pci(dev))
> -		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
> +	if (dev_is_pci(dev)) {
> +		struct pci_dev *pdev =3D to_pci_dev(dev);
> +
> +		if (pci_ats_supported(pdev)) {
> +			ret =3D pci_prepare_ats(pdev, PAGE_SHIFT);
> +			if (ret) {
> +				iommu_dev =3D ERR_PTR(ret);
> +				goto out_err;

[Severity: High]
This isn't a bug introduced by this patch, but error paths here don't
seem to restore the device's MSI domain.

Earlier in amd_iommu_probe_device(), amd_iommu_set_pci_msi_domain()
overwrites dev->msi.domain with the IOMMU's IRQ remapping domain. If
pci_prepare_ats() fails, we jump to out_err and call
iommu_ignore_device() which clears the rlookup mapping.

Since dev->msi.domain is never restored, could this leave the device in
a state where the PCI subsystem will attempt to allocate MSIs using the
IOMMU's domain, but fail with -EINVAL because the device is ignored by
the IOMMU?

> +			}
> +		}
> +	}
> =20
>  out_err:
> +	if (IS_ERR(iommu_dev))
> +		iommu_ignore_device(iommu, dev);

[Severity: Low]
Does this result in iommu_ignore_device() being called twice when
iommu_init_device() fails?

Looking earlier in amd_iommu_probe_device():

	ret =3D iommu_init_device(iommu, dev);
	if (ret) {
		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
		iommu_dev =3D ERR_PTR(ret);
		iommu_ignore_device(iommu, dev);
		goto out_err;
	}

Since IS_ERR(iommu_dev) is true when arriving at out_err from the
iommu_init_device() error path, it looks like iommu_ignore_device()
will be executed a second time. Can we remove the earlier call?

> +
>  	return iommu_dev;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528202353.3422=
206-1-praan@google.com?part=3D7
