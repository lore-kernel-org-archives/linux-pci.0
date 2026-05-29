Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC229AAFD
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065050; cv=none; b=qtmY0TiSSya+Wk0BQSXyNpZmMxe4juLtsojnodefeikIddKGsWW6D9SRcgmlsVK/OQdazHnrfDH/zlfEqQBeMqe1OBw1qqet6T9bp1Rn7hDyOjDvULVStDonUH2y6h8vDPyz1Wboh0HooOi3aCI9/ylwr1hCaSvg15fqdcCTEo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065050; c=relaxed/simple;
	bh=VmHZouFFFIUxdx2cYWvSw1y8DVy4mcatDS+pnUzWwlI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vB7fJQOmr9fvoX7oyv5poCs45NV2flOQ1jMnAw1SkOMSSCXuzc0nJVLQ6hile/K9w+GBIq4hUmMQHZ0xrlxJFL9r+xCjJPsU3YFVblhdzTXr7Q8c/1imXyeNKsmQtWSFX2GZB43OU4Nv1bloswd9vKzLsN2tXOx7hP99yz5ke08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkGnbxQ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkGnbxQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8471F00893;
	Fri, 29 May 2026 14:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780065049;
	bh=O7N7MyN8KHRVGDicApsBDchsjRkwG/FhSXrOTQROno0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NkGnbxQ5duoOOwnsHUJEVZHM7Rg2zKxkaUaXf02yws7HQE699nKjhdDKeVH58VvdE
	 Acdbo5NKT4IZ3gt9XziUKBtLCeHOyhmJIXJy7hHeOisHEu5sZbSD0oH7FskQT3aIL5
	 fWXG1gz0w7R1RefOzphlr7NRG0L8je2FQwH1icAY3jPn8d5tsmG60pW5a7+pY6xK9L
	 ZN/wAp8Vk4XkGV8da1MijZGfv7Ct38NgSeIEq00gD9OSDesE0d7KGXp1bJrByyRr5x
	 RWLaseSSut0N1aPja2jdCN+jEVbDt0h36l93v4cMcc5j5DFLvDqSUywS/n3s81/8Gk
	 RBvijAll1auhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/6] iommu/vt-d: Fail probe on ATS configuration
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260529111208.387412-6-praan@google.com>
References: <20260529111208.387412-6-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 14:30:48 +0000
Message-Id: <20260529143048.ED8471F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional call to `device_rbtree_remove()` for an uninserted `=
rb_node` corrupts the IOMMU device rbtree.
--

commit 28c5be83fdd5509a29185b7292f784b77e8d22e7
Author: Pranjal Shrivastava <praan@google.com>

iommu/vt-d: Fail probe on ATS configuration failure

Update the Intel VT-d driver to handle ATS configuration strictly by failing
the device probe if pci_prepare_ats() returns an error. Also, add a WARN_ON
in iommu_enable_pci_ats() to catch enablement failures.

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
This is a pre-existing issue, but I wanted to ask about the error handling
paths in this function. If a device does not support ATS or isn't a PCI
device, device_rbtree_insert() is skipped here.

However, if a subsequent initialization step fails, such as allocating the
PASID table:

intel_iommu_probe_device() {
	...
	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
		ret =3D intel_pasid_alloc_table(dev);
		if (ret) {
			dev_err(dev, "PASID table allocation failed\n");
			goto clear_rbtree;
		}
	...
clear_rbtree:
	device_rbtree_remove(info);
free:
	kfree(info);
	...
}

Does this unconditionally call device_rbtree_remove() on a zero-initialized
and uninserted rb_node?

If rb_erase() is called on this uninserted node, could it treat the zeroed
node as the root and overwrite the actual rbtree root with NULL, corrupting
the IOMMU device tracking tree and dropping previously probed ATS devices?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529111208.3874=
12-1-praan@google.com?part=3D5
