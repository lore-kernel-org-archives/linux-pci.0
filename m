Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583603E1689
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327839; cv=none; b=jSiI8ZjraV+4J+weplC+zwrGdXU6gEeQTGaQ62IZ4qlIn2F8554zd89rNI/WV59i8gFX6779lkx6eqlrJlhzh3gd/ehqxtzEDc9qFmVfIg3qK+2J8KAtwcib+CT2q6cMAgcGclSLvQubdsflUEsUcwWHzXsexccECLJitcVhaBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327839; c=relaxed/simple;
	bh=jm2CdHO7Q7tMsfwer6JEaelAcGRvX9oy4ZooAbqlq1c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CpmPe5Fljc97np6t1CrkUWADNu1ZgTWTXfhHLreD6BZKvUCmQSwoVxYY6e4d/MfGu/s67lwSdqoOInAsZPoeVLJ6O2r7htfcEy3Fxl0TsjtGrpHw606oEIGdtENY7syLZsAEt+YcOr8ms+q4gg2c1An/C+u58DCwltrKcOuQhyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaOUJLBw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaOUJLBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C861F00893;
	Mon,  1 Jun 2026 15:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780327832;
	bh=UA3B050AIBMKj8KioTnO04NUJYVea+xMFHDWiecDEeg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jaOUJLBwK8BI6MPTfV65okGQBONQnqHGVtsGNa4QLb5f7vwWWk29Nso2y0E2GcopB
	 myoWglvWZJxGg8jATJXKzaPIgWAYzP3pqbPjHx1P9Z2ZbIociLKQyhA0Znd0ba8aSj
	 QdvIe1wOmBs+w0YfvFLpn1Rkbpw7FYOeVPKoY7VonBvD1zFgzOkLBZsLPI84jCkwKj
	 UXz5Efe1QT0jwdpXutgw4dKxB2rRz8VRl4nk1HjjlCbllGeqd79mR17JUo80/x4hiP
	 K4rRE8WIBgqpU3MmFxz7tinMXZ9QofhLfWu0temxuca0U45hbEkQt6cwF/UjE8QowT
	 TpWei0UZ+k4Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/5] iommu/vt-d: Fail probe on ATS configuration
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260601143644.2358771-6-praan@google.com>
References: <20260601143644.2358771-6-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 15:30:31 +0000
Message-Id: <20260601153032.36C861F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional call to `device_rbtree_remove(info)` in the error pa=
th causes rbtree corruption for non-ATS devices.
--

commit 73f5ec2d0aa9d509723e686b4cbf5b853c3a39c6
Author: Pranjal Shrivastava <praan@google.com>

    iommu/vt-d: Fail probe on ATS configuration failure
   =20
    Update the Intel VT-d driver to handle ATS configuration and enablement
    more strictly. Specifically, update the device probe to fail if
    pci_prepare_ats() returns an error. This ensures that any ATS-capable
    master reaching the attach phase is guaranteed to have a valid config.

> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 4d0e65bc131d7..22308e4911e1f 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
[ ... ]
> @@ -3288,7 +3294,10 @@ static struct iommu_device *intel_iommu_probe_devi=
ce(struct device *dev)
> =20
>  	dev_iommu_priv_set(dev, info);
>  	if (pdev && pci_ats_supported(pdev)) {
> -		pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
> +		ret =3D pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
> +		if (ret)
> +			goto free;
> +
>  		ret =3D device_rbtree_insert(iommu, info);
>  		if (ret)
>  			goto free;

[Severity: High]
This is a pre-existing issue, but does the error path in this function
unconditionally call device_rbtree_remove() on failure, even for non-ATS
devices?

If intel_pasid_alloc_table() fails later in intel_iommu_probe_device(), it
jumps to clear_rbtree:

        if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
                ret =3D intel_pasid_alloc_table(dev);
                if (ret) {
                        dev_err(dev, "PASID table allocation failed\n");
                        goto clear_rbtree;
                }

clear_rbtree unconditionally removes the info from the rbtree:

clear_rbtree:
        device_rbtree_remove(info);

Since info->node is zero-initialized via kzalloc_obj(), calling rb_erase()
on it for a non-ATS device (which was never inserted into the rbtree) causes
the rbtree implementation to treat it as a root node and overwrite
iommu->device_rbtree.rb_node with NULL.

This silently destroys the entire rbtree and detaches all previously
registered ATS devices. Could we add a check to verify if the device was
actually inserted before calling device_rbtree_remove(info)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601143644.2358=
771-1-praan@google.com?part=3D5
