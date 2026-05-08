Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCD113D503
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778199532; cv=none; b=RQLZWBBm/KnBiALUi+aXRfYqHAwl6WRUp+QgdqcPTceyWRZBLQdIf2zA42v83xdAP9hH0aHGSveKNBFc2mJvOCDlYeh1yvEbrleJdlP72XHQzf6IpUjXfkJe3IeR0oirYzRShAXlW/6DoDeh5AUr8xjXGxS7VmfFpFxVidKtVMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778199532; c=relaxed/simple;
	bh=GRbEotYv0cJ4tISa+sPIbvo89JoBD1zJIIEmd1XeKI0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oC1Hof/qBjICMPNZA/g2pHAm6VBOVML4Imcbh5jeaEqw4r5YA/wvPhqwmURxV0s8BDpqFxa+FUOEtE9gmAE6xr1tB2GWzVw6faBY8oWeKDUd8SrsV0ZzCAOtCNLVD/qwRIm4OD7uU0Vw9eG0GB6UXu5vFJ+39ssJAorshlDQjF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZmn3bLS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZmn3bLS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA4FC2BCB2;
	Fri,  8 May 2026 00:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778199532;
	bh=GRbEotYv0cJ4tISa+sPIbvo89JoBD1zJIIEmd1XeKI0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VZmn3bLS2w7D2KMnARbNdciGZCJfQ+iDkhp23LsY+HPJrtnfxLwnlpK+zHmk0ocf0
	 ubI92wtx8eClyLBZxlKlqeB3Rc5R4I4BGk4HJ5za2BR1QqEDYXnP5bMtUy0HWq8tmO
	 jHAn1507D0sMKRV27sCeN0aai0RB4VJISVew8ygIJ96MnokDyZu7kuzyAD36pbAwSS
	 NlGJXwHNBFnw1WxoLc27lA4Ox+jtr0UIBzz9HwEGQws+juUD59cLOuP5LVFkLg3ojX
	 gEKXcggfY8ceCHHIDPKTSlQ79TQP8oa4JgrBJnDWRAksKu8zfX+BkLVaqkDkaYFidV
	 CuV2FccXTU6/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/6] vfio/pci: Add PCIe TPH GET_ST interface
Reply-To: sashiko@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260507130956.34441-6-fengchengwen@huawei.com>
References: <20260507130956.34441-6-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 00:18:51 +0000
Message-Id: <20260508001852.6EA4FC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing op->argsz validation before copying the st structure from u=
ser space.
--

commit 3e63e4fb1478346ccd55bac2783b7a7e1dce2cc3
Author: Chengwen Feng <fengchengwen@huawei.com>
vfio/pci: Add PCIe TPH GET_ST interface

Add support to batch get CPU steering tags for device-specific TPH mode
that does not implement an ST table. This interface requires enabling the
'enable_unsafe_tph_ds_mode' module parameter.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -1533,6 +1533,77 @@ static int vfio_pci_tph_disable(struct vfio_pci_co=
re_device *vdev)
> +static int vfio_pci_tph_get_st(struct vfio_pci_core_device *vdev,
> +			       struct vfio_device_pci_tph_op *op,
> +			       void __user *uarg)
> +{
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	struct vfio_pci_tph_entry *ents;
> +	struct vfio_pci_tph_st st;
> +	enum tph_mem_type mtype;
> +	size_t size, ents_off;
> +	int i, err;
> +
> +	if (!enable_unsafe_tph_ds_mode ||
> +		pcie_tph_get_st_table_loc(pdev) !=3D PCI_TPH_LOC_NONE)
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&st, uarg, sizeof(st)))
> +		return -EFAULT;

Should this code validate op->argsz before copying the structure from user
space?

If a user program passes an argsz that is smaller than sizeof(st), and
the provided pointer happens to be at the very end of a mapped page,
copy_from_user() will attempt to read into unmapped memory and return
-EFAULT instead of the expected -EINVAL.

Other VFIO ioctl implementations, such as vfio_pci_tph_enable(), check
op->argsz before calling copy_from_user().

> +
> +	/* Check reserved fields are zero */
> +	if (memchr_inv(&st.reserved, 0, sizeof(st.reserved)))
> +		return -EINVAL;
> +
> +	if (!st.count || st.count > VFIO_PCI_TPH_MAX_ENTRIES)
> +		return -EINVAL;
> +
> +	size =3D st.count * sizeof(*ents);
> +	if (op->argsz < offsetofend(struct vfio_device_pci_tph_op, st) + size)
> +		return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507130956.3444=
1-1-fengchengwen@huawei.com?part=3D5
