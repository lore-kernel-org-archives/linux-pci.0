Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9350525B098
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780598094; cv=none; b=YFnT5hbiN/7JWyAa5HCRB8uQLa3Pb7Gw1NFdh4C/4BqJHlw43IFGugt1dFPrDlLhOXSZGb9CmwQ9LztCY38qV3mip5d8iEecGCH5mWprOm+F7mNZJ5CiEiR0D9pWEbCEsiDUermEXPBt7EXepRA6HWspGQrS/X5jnRSc2ZXLC2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780598094; c=relaxed/simple;
	bh=9KnrFzJCQqKmA4zZD397xl18lBMfPyxxIRWtLIyr4J0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eQczrPfckb9/GHS76SO1xEI7uTC/yl/q/DMAX0tjxALfe884LVt3ApsOVePaA6zccWVrV4qn3lTU96v8PSFkInByF02nKXetEBkkuZ/ZfH0rBVjjKHsAgHzpppcpmt8CX6ytyLUURUMx28st7dCoL0+BdQ8zb4wLktISMvWAxU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBOjt0ID; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBOjt0ID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD021F00893;
	Thu,  4 Jun 2026 18:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780598093;
	bh=qPpO0w+jd19d50aJ+3CYEE2zIDspddv7+ruBAVLiDeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XBOjt0ID3Onp1zKUWjJPvtfcs/hozaB0B8iBAeIZ5xRqkOV3KqEHEbW/2wOFo6ZJH
	 D9HsdrWuU62ttmm6dObhEGpKGZG0OcQgqzKtRdmdju/WI45uNzwkI9SFBPF7dPpujq
	 utNrk16o6FOgBRmRSSN3QKoC9RBLxBwvZz88+cM/h8/JEBPvkh7j4Njv/92HEXJrw0
	 Jwq1wSax51DZGEpAW+9x/1cPs4wBaqs2urAR/eFLCd8Dtbk4XJ6Ak09LBQZtFPKr/C
	 EGG8nhcHWQa0JxHz7EMYwZRgzgr1Uu4et0XFgKjT1hiWUU11ACAoTEZlW3inJUXRmM
	 0+/lM3KQkhxRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/4] iommu/vt-d: Fail probe on ATS configuration
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260604182116.3179005-5-praan@google.com>
References: <20260604182116.3179005-5-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 18:34:52 +0000
Message-Id: <20260604183452.DFD021F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional rbtree removal of an unlinked node on error paths in=
 `intel_iommu_probe_device()` empties the device tracking tree.
--

commit edcf0a64984f0847eb81ddb322f530951d47a01a
Author: Pranjal Shrivastava <praan@google.com>

iommu/vt-d: Fail probe on ATS configuration failure

Update the Intel VT-d driver to handle ATS configuration and enablement
more strictly. Specifically, update the device probe to fail if
pci_prepare_ats() returns an error. This ensures that any ATS-capable
master reaching the attach phase is guaranteed to have a valid config.

> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index c3d18cd77d2f1..9242cd9651307 100644
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
This is a pre-existing issue, but unconditional rbtree removal of an unlink=
ed
node on error paths in intel_iommu_probe_device() empties the device
tracking tree.

If a device does not support ATS, it skips the device_rbtree_insert() call
above. If a subsequent failure occurs, such as intel_pasid_alloc_table()
failing, the error path jumps to clear_rbtree and unconditionally calls
device_rbtree_remove():

intel_iommu_probe_device() {
    ...
    clear_rbtree:
        device_rbtree_remove(info);
}

This function directly invokes rb_erase() without verifying whether the node
is actually linked to the tree:

device_rbtree_remove() {
    ...
    rb_erase(&info->node, &iommu->device_rbtree);
}

Because the node is unlinked and completely zero-initialized, the parent
pointer evaluates to NULL. The rbtree implementation treats the node as the
tree's root and overwrites the root with NULL, completely clearing the IOMMU
device tracking tree.

Could we add a check to verify the node is actually linked before calling
rb_erase(), or only jump to clear_rbtree if the node was successfully
inserted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604182116.3179=
005-1-praan@google.com?part=3D4
