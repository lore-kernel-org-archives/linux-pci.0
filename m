Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7343D79E3
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326087; cv=none; b=dzijC8ySc9gZ+dBHqlnJ2BSMqtG7zBhDa6u/sGXkj4FOoknqaXtH4VWCLfSCjV4Y05WNwZVHgOKp7RInP6b2e0G8CkQbCRRVcc3c2CKuZOHDVa8VP3uxfrPleqBgEHrWsGmJektBwjl50YFW5RX4Ao0EINcXOMwHygFDiFk0QWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326087; c=relaxed/simple;
	bh=XrL4p4JT6U5G/ML5WGHDqRdtB/SdZuHvc4pkYqo/TLY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PnkzUVppZYZ0q5ZwT8fAVPgiEZ3rmIZppOOQb5RmTVXXSC0UjNIJ59rNXw5IkjbByene/KeTNSDMCA7vgCBQvk6TVuBnDtDnQ1WThMD5YI9Fl2BceUgNOn72p73+/R9DeyqJnVfhasbWjIU+wXbhnvPpRz62zFDzKdkkt7i2qYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CucT5EUp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CucT5EUp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E04E1F00893;
	Mon,  1 Jun 2026 15:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780326086;
	bh=Gv2pWzOxGsXWEUo/1oJVhqkoDuHEkkoVBTm0NzMJ1ts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CucT5EUpN6PFYRFz2Le8NQjk4HGQCeB4qenR5tgxx475P+f1hjUBJ3RxWrpC9BiqT
	 PEUZ6d2frcJbeC8jrSn/oZQlsgjMAiPdqua9M9NxZEXAR/fyQnWyajfdny+vhz8Ji7
	 dq19aYLFLXba6ws9keQp2bGxSRq9rttpgH67AWuVYtvFn439eDEj3za6MXaDF9VLti
	 dTnOwcIe3LtNqRqpvwsDmpjoGpdT8vAskVnfEEJ+RsnYwbKxRHpEJZACAx1AV+ZBZy
	 FDq8GTz31jj+ZBenXGcD2zjqriVUceS8utp06vsgKGcOKnwvy4Xxzphi47aTdLhJDZ
	 nPyDm1mq2PigA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] iommu/amd: Fail probe on ATS configuration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260601134204.2150602-6-praan@google.com>
References: <20260601134204.2150602-6-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 15:01:25 +0000
Message-Id: <20260601150126.3E04E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added WARN_ON(ret) in pdev_enable_cap_ats() can be spuri=
ously triggered for SR-IOV Virtual Functions (VFs) if the Physical Function=
 (PF) was not properly configured for ATS.
--

commit 40ae1c6d486f021eadc253f746299ffa4ca11dff
Author: Pranjal Shrivastava <praan@google.com>

iommu/amd: Fail probe on ATS configuration failure

This commit updates the AMD IOMMU driver to call pci_prepare_ats() during
device probe, failing the probe if it returns an error. It also adds a
WARN_ON() in pdev_enable_cap_ats() to catch failures from pci_enable_ats().

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 4ef6024c5a4ea..783f53cb85996 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -566,10 +566,17 @@ static inline int pdev_enable_cap_ats(struct pci_de=
v *pdev)
>  	if (amd_iommu_iotlb_sup &&
>  	    (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_ATS_SUP)) {
>  		ret =3D pci_enable_ats(pdev, PAGE_SHIFT);
> -		if (!ret) {
> -			dev_data->ats_enabled =3D 1;
> -			dev_data->ats_qdep    =3D pci_ats_queue_depth(pdev);
> -		}
> +
> +		/*
> +		 * pci_enable_ats() should not fail here because earlier
> +		 * checks have already verified support & config.
> +		 */
> +		if (WARN_ON(ret))
> +			return ret;

[Severity: High]
Can this WARN_ON() trigger spuriously for SR-IOV Virtual Functions (VFs) if
the Physical Function (PF) was not properly configured for ATS?

Looking at pci_prepare_ats(), it has a fast-path that returns 0 immediately
for VFs without checking or configuring the PF's Smallest Translation Unit
(STU):

int pci_prepare_ats(struct pci_dev *dev, int ps)
{
    ...
    if (dev->is_virtfn)
        return 0;
    ...
}

Later, when pdev_enable_cap_ats() calls pci_enable_ats() for the VF, the
actual validation happens there:

int pci_enable_ats(struct pci_dev *dev, int ps)
{
    ...
    if (pdev->ats_stu !=3D ps)
        return -EINVAL;
    ...
}

If the PF failed its IOMMU probe or was explicitly bypassed by the driver,
its ats_stu would remain 0.

When VFs are subsequently probed, pci_prepare_ats() would blindly succeed,
but pci_enable_ats() would fail with -EINVAL, triggering this new WARN_ON().

Could this lead to unnecessary bug reports or kernel crashes on systems
configured with panic_on_warn?

> +
> +		dev_data->ats_enabled =3D 1;
> +		dev_data->ats_qdep    =3D pci_ats_queue_depth(pdev);
> +		ret =3D 0;
>  	}
> =20
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601134204.2150=
602-1-praan@google.com?part=3D5
