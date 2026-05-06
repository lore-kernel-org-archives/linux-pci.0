Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3B630AAD8
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 19:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778095290; cv=none; b=nUss9p+K1TQJ5du+89aIJwzPzTd8bJcKm6Vq2npQgMtVcJ1LJBo6+RxD7eWBXhJruRV2qPX+PQMaI6TYIF+pPMNoGiaYSH7/YPyoAgqKmajblC0TYRf9LRkXeoxdzCCvCgwhSEqRDBzdg1QNht+XmOvsYPMwcvoEoxqfGwBne1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778095290; c=relaxed/simple;
	bh=VCjxNZC5KsDGrQRuvPvDWXpl9BQzPFlVMO9L0XAf7j8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BUSBUBPXOAgdax5rLUWb1lI4P709OgM47HMYDxcVANJEBn4yVL1KgYR9s2uq5c/SGXwMb407AoHa3/4Ma62u5lKMuLQyTkWzAScGTtjHX50hpO90tRoJgnC+BRiNAXmqEEIjm0Oqmg0kLgkC3ksMQnHZO4aZLipDvgntiey14xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qux6WVDN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qux6WVDN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E18C2BCB0;
	Wed,  6 May 2026 19:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778095289;
	bh=VCjxNZC5KsDGrQRuvPvDWXpl9BQzPFlVMO9L0XAf7j8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qux6WVDNaJXjyh2oqABszrnulXMGpj4SEhE6we+NA+03yAtN6k8YIE7oWc2tZopDC
	 roJeomhUr/LuSBZRNtSXcARhUoT3lddNMbA7miTti0dWQN2jooDjPG5iEZk/1KuYl9
	 676CqHrQCbtV2CqO+KTiE+oemDNzenbCYfwNtCWkmcFDdHWWUUE2wnHWNGi6hKM4IZ
	 N0kj4sFEU0Rd/8oV313i9zFc8dy5n+aSfZ2MnRYinkpH5HVfxYaCvoyUjBy2eM7Osu
	 guZiwLI35KKRvCbzj2Cn14Z2Pb1c6wfGNHbUp0FQuMdSfLNne8y7ILNJrBDgKPoLlK
	 ltEeq1M/6aa5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/6] vfio/pci: Add PCIe TPH enable/disable support
Reply-To: sashiko@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260506094623.29327-5-fengchengwen@huawei.com>
References: <20260506094623.29327-5-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 19:21:29 +0000
Message-Id: <20260506192129.A1E18C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Incorrect `argsz` validation in `vfio_pci_tph_enable()` incorrectl=
y adds the structure size twice, breaking the UAPI.
- [High] Missing locking in `vfio_pci_ioctl_tph()` leads to config space an=
d `pci_dev` bitfield data corruption.
- [High] Disabling TPH after registering the device exposes it to userspace=
 races.
- [High] TPH state is not explicitly disabled when the VFIO device is close=
d, leading to state inconsistencies and subsequent failures.
--

commit c8b020c06b71ba6da131d464466e50c2b03f622b
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add PCIe TPH enable/disable support

This patch adds support to enable and disable the TPH function with mode
selection. It restricts the unsafe device-specific TPH mode via a module
parameter and disables TPH when taking over device ownership.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index d98d04bad4a39..69f666d20c4af 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c

[ ... ]

> @@ -1492,6 +1492,43 @@ static int vfio_pci_tph_get_cap(struct vfio_pci_co=
re_device *vdev,
>  	return 0;
>  }
> =20
> +static int vfio_pci_tph_enable(struct vfio_pci_core_device *vdev,
> +			      struct vfio_device_pci_tph_op *op,
> +			      void __user *uarg)
> +{
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	struct vfio_pci_tph_ctrl ctrl;
> +	int mode;
> +
> +	if (op->argsz < offsetofend(struct vfio_device_pci_tph_op, ctrl) +
> +			sizeof(struct vfio_pci_tph_ctrl))
> +		return -EINVAL;

Since offsetofend(TYPE, MEMBER) already includes the size of the ctrl membe=
r,
does adding sizeof(struct vfio_pci_tph_ctrl) a second time require more
bytes than the actual structure size?

Could this cause the check to reject valid userspace calls that provide the
exact structure size?

> +
> +	if (copy_from_user(&ctrl, uarg, sizeof(ctrl)))
> +		return -EFAULT;
> +
> +	if (ctrl.mode !=3D VFIO_PCI_TPH_MODE_IV &&
> +	    ctrl.mode !=3D VFIO_PCI_TPH_MODE_DS)
> +		return -EINVAL;
> +
> +	if (ctrl.mode =3D=3D VFIO_PCI_TPH_MODE_DS && !enable_unsafe_tph_ds_mode)
> +		return -EOPNOTSUPP;
> +
> +	/* Reserved must be zero */
> +	if (memchr_inv(ctrl.reserved, 0, sizeof(ctrl.reserved)))
> +		return -EINVAL;
> +
> +	mode =3D (ctrl.mode =3D=3D VFIO_PCI_TPH_MODE_IV) ? PCI_TPH_ST_IV_MODE :
> +						     PCI_TPH_ST_DS_MODE;
> +	return pcie_enable_tph(pdev, mode);
> +}

If userspace enables TPH but crashes or closes the file descriptor without
manually disabling it, is the TPH state left enabled since the release path
does not call pcie_disable_tph()?

If the device is opened again, could subsequent attempts to enable TPH fail
with -EBUSY because pcie_enable_tph() sees it already enabled?

> +
> +static int vfio_pci_tph_disable(struct vfio_pci_core_device *vdev)
> +{
> +	pcie_disable_tph(vdev->pdev);
> +	return 0;
> +}
> +
>  static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
>  			      void __user *uarg)
>  {
> @@ -1504,6 +1541,10 @@ static int vfio_pci_ioctl_tph(struct vfio_pci_core=
_device *vdev,
>  	switch (op.op) {
>  	case VFIO_PCI_TPH_GET_CAP:
>  		return vfio_pci_tph_get_cap(vdev, &op, uarg + minsz);
> +	case VFIO_PCI_TPH_ENABLE:
> +		return vfio_pci_tph_enable(vdev, &op, uarg + minsz);
> +	case VFIO_PCI_TPH_DISABLE:
> +		return vfio_pci_tph_disable(vdev);

Because vfio_pci_ioctl_tph() handles these ioctls locklessly without
holding vdev->igate, does concurrently calling pcie_enable_tph() cause a
data race on the pdev->tph_enabled bitfield?

Could this concurrently overwrite adjacent critical bitfields in
struct pci_dev like msi_enabled or is_managed?

>  	default:
>  		/* Other ops are not implemented yet */
>  		return -EINVAL;

[ ... ]

> @@ -2259,6 +2300,8 @@ int vfio_pci_core_register_device(struct vfio_pci_c=
ore_device *vdev)
>  	ret =3D vfio_register_group_dev(&vdev->vdev);
>  	if (ret)
>  		goto out_power;
> +	/* Disable TPH when taking over ownership of the device */
> +	pcie_disable_tph(pdev);

Is it safe to call pcie_disable_tph() after vfio_register_group_dev()?

Since the device becomes visible to userspace once registered, could a
userspace process instantly open the device and enable TPH, racing with this
initialization thread and overwriting the user's configuration?

Should hardware state initialization happen before publishing the device to
userspace?

>  	return 0;
> =20
>  out_power:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506094623.2932=
7-1-fengchengwen@huawei.com?part=3D4
