Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDC83803C8
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779742590; cv=none; b=FqtmRHifmq7SDfUhWDbGieRe8T10au306/zaQup2pdX7JqAlDFPvszN0eqIxnhi4uhOKAtZQuuE9YQElSp2G+yoCWFOcHRWdXBMa0pesPL6OR7y5vosrSketZDPGtIpfiianIrfzSMge7i9hyYo/VEnSRR/0FHPuXuEOMOX6dqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779742590; c=relaxed/simple;
	bh=1n6xqkkx8nM0M21Z8vUXe3F1d1LnfrvMAssq6iwg7U0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qkYCPmCDtp/1WAnXvpbbTTH1box7DwAMOKG3z5pznYesNT8YPYqtAL6h63kGM0t3EdTa2wrMRS79z5F4wWetasj61RnBbTuPbUwHggRdCnmfzuJN9Ie3vTiCbjTLeEAGzBnLcvR4OkaTYSTA7phz/rEeaKZB01r7qKBnBpSu1wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fh1Lb7Gb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fh1Lb7Gb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4431F000E9;
	Mon, 25 May 2026 20:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779742588;
	bh=mj49iokE2zlvgMGSexMI3TXFrHxMBiVsTP9fmUxxIdQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fh1Lb7Gb44ntZezWMVNiOCJlBjF/jYB+8Lmxyr61MCcxM7KgrGjrs3bLeJ/9BTcb9
	 Mc62CINZKdxSXwkb2CsbMFzfHyMbIwz3B98EtmTsQSC3vzrLo3qZOEVGSqfJZ7kw6h
	 bYj/+9FTe9Xa9PMAqJW8Y7Ooxws4yQKS2ncGfPC59C4wKFs4hyD70YaGB/lBZq17qq
	 l9b61gQ5ClEgtZpNCok30BZ7DwEkRRDuYqZ+GSjL32rsspWo/ibtMeJOb6XK8TLJ+o
	 6+h6qMzVBdERDYLdkrVN41A3PjAvB3/y60s6LNpF6PDhfiZKzIgFyBIGazlEZhil9J
	 Kxzp22mXkm8vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] iommu/vt-d: Fail probe on ATS configuration
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260525184347.4059549-5-praan@google.com>
References: <20260525184347.4059549-5-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 20:56:28 +0000
Message-Id: <20260525205628.CD4431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional RB-tree removal on error path causes tree corruption=
 for non-ATS devices.
--

commit b8810979b183c84268a61e16cca0cbf36d0ac97a
Author: Pranjal Shrivastava <praan@google.com>

iommu/vt-d: Fail probe on ATS configuration failure

Updates the Intel vt-d driver to strictly handle ats configuration by faili=
ng
the device probe if pci_prepare_ats() returns an error. It also throws a
warning if pci_enable_ats() fails during enablement, treating it as a bug.

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
This is a pre-existing issue, but does unconditional removal of the rb-node
on the error path cause tree corruption for non-ats devices?

If a device does not support ats, the info structure skips the
device_rbtree_insert() call here, leaving info->node zero-initialized.

However, if a subsequent operation like intel_pasid_alloc_table() fails,
the error path jumps to clear_rbtree:

intel_iommu_probe_device()
    ...
    clear_rbtree:
            device_rbtree_remove(info);
    free:
            kfree(info);

Calling device_rbtree_remove() on this zero-initialized node causes the
rb-tree logic to treat it as a root node with no parent, ultimately
overwriting the actual tree root with null and corrupting the device_rbtree.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525184347.4059=
549-1-praan@google.com?part=3D4
