Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687443B1EFE
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771956; cv=none; b=ZE4BHwYNaCpNL076ApObN3BQyDlWnLHf1zyZr7XH+N5cwQzcdx6X2qSG4Wo98vF5i12grq5g5GRtpiaPpu1Iiyva8pPcIlN7ZIf4P/ezKgXLvjQsQJlQRnAgDqpllag9m0iMjkaykxtl8W4ZZLuZ5Agmx2nXQOiVgpHnkpNwlxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771956; c=relaxed/simple;
	bh=kunZh0ILTa9MlbCsqHzXVbkJUiY7hAdskHRMnLkTUeU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z2SuhVPez24HHoELRAlNwQm+Gu7ZCgifHV5nrBBhpbsbXbId4cgvZoI9FsbMxZ+VYuWyq3enHvnimCVkEF8qltzrU4F0AkxzepXgPh+0xLmJJlp0sBSwp1Kq6A+hLB4XlDSq4+ycYLy/vjaZTm1FMB/C/5NVA/gCKLr4jBl0Vxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Idt5B3Gy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Idt5B3Gy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3873C1F000E9;
	Thu, 18 Jun 2026 08:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781771954;
	bh=VpK9Fe6yy83k2RH15kiPKILr7KxQh1Bjd3S/cKBCqus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Idt5B3GyLdM2l5X+EikGBT6GZbtTxeuu6bPlyaRa/GYEs31suh7LhOp6kTQn0CEM9
	 OR9LIur0YyjR2wmRO0tF5FeotUruI7W7QJXcEJWIA9XWipwdBNQTmB/Olw/0sPkAhe
	 OdRBrElZAe4WnKBf1usQZUrOTOIKqYENH42FVbrAmB15ToQqPCaacGyxcYhoiAvK/F
	 9p3hVXKpg1Ykyw6ZBmv7SXtJ8bQ2/npZzLGheLY248pXkKhjWRF71Pl7ACp8F/CrlN
	 BZKdnMzK0MmwKu5KS8dXwWtL2oQ7jDpdtvlA8vsBMWfcYiZKhPxxQnY0Y1FbSRXzMe
	 B1YNKDRSPgRTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvme-pci: fix CMB mapping when CMBSZ Size field is zero
Reply-To: sashiko-reviews@lists.linux.dev
To: kangfenglong <kangfenglong@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260618082616.20656-1-kangfenglong@huawei.com>
References: <20260618082616.20656-1-kangfenglong@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 08:39:13 +0000
Message-Id: <20260618083914.3873C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A 64-bit shift overflow in `nvme_cmb_size_unit()` causes undefined=
 behavior and integer overflow, allowing a malicious device or surprise rem=
oval to bypass the patch's zero-size check.
--

commit cff061918a7d037b79313b9dd26c4235a518f58f
Author: kangfenglong <kangfenglong@huawei.com>

nvme-pci: fix CMB mapping when CMBSZ Size field is zero

This commit restores a check for a zero SZ field to verify the controller
actually has a CMB before proceeding with mapping. This prevents size
from defaulting to the entire remaining BAR and triggering memory
hotplug alignment warnings.

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index e6267a6aa3801..14f0f141df5bb 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1838,6 +1838,8 @@ static void nvme_map_cmb(struct nvme_dev *dev)
>  	dev->cmbsz =3D readl(dev->bar + NVME_REG_CMBSZ);
>  	if (!dev->cmbsz)
>  		return;
> +	if (!nvme_cmb_size(dev))
> +		return;
>  	dev->cmbloc =3D readl(dev->bar + NVME_REG_CMBLOC);
> =20
>  	size =3D nvme_cmb_size_unit(dev) * nvme_cmb_size(dev);

[Severity: High]
This is a pre-existing issue, but could this multiplication still silently
overflow to zero and bypass the new zero-size check?

If a device advertises a Size Units (SZU) of 12 and a Size (SZ) of 16,
nvme_cmb_size_unit() calculates 1ULL << 60. The multiplication here
then becomes (1ULL << 60) * 16, which mathematically equals 1ULL << 64.
This wraps around to exactly 0 in a 64-bit unsigned integer. Since SZ is 16,
the new nvme_cmb_size(dev) check is passed, but size still becomes 0,
potentially triggering the same pci_p2pdma_add_resource() issue this
patch aims to fix.

Additionally, if the PCIe device is surprise-removed, readl() returns
0xFFFFFFFF, resulting in SZU =3D 15. The shift calculation in
nvme_cmb_size_unit():

    return 1ULL << (12 + 4 * szu);

evaluates to 1ULL << 72. This is undefined behavior and can result in an
unaligned size being passed down.

Does this calculation need further bounds checking or validation to handle
integer overflows and surprise removals?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618082616.2065=
6-1-kangfenglong@huawei.com?part=3D1
