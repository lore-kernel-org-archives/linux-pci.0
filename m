Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040663F86EE;
	Thu, 28 May 2026 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981427; cv=none; b=l8vCx/AE1CYNzoSDo9Q+0DawT3H8Z2zdZqCCjf8O11R30MqYM/oVaz4n1KqOJ60znPqTxBigGXul0o06KObr2JSMS2Cat8f7w/iS2x2WXks4V7B4fJJPVDI2MpIJuAgvZrlVrEBM1SMlQS+bO/d/hErorv0ruLXF3h+QaFdlY3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981427; c=relaxed/simple;
	bh=dwA0YTqr4NyC5rutMAr6SkJTYr7pTZ92MDNppgAdAg8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=enQifuyennopkMAKlamMPHUI/CPStwyjfT/QctKFiU5J6QGb1yXtDaubOu/V0eIQ+Ykh5NnM69mJFbzIU0No88hc1lymSIRSKPxFMRBM6U0eW0KZeL70iYvvWphW4pSAQKLtTx16ZqklR2R6yzHS5D8MWF5xXYJhzMuqI9nkkqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxZ0NPFF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxZ0NPFF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE851F000E9;
	Thu, 28 May 2026 15:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779981426;
	bh=rq15zvGSndm/umeaMOKzXIRp6RgjyCc8b3wTSZ+PTyg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lxZ0NPFFHjRaSQKNR4mrF0VgAXOPk9ozakZzMgn3v7zdNnb35v61pqEXzCXxPSWUl
	 pBUCtcgO+SvIacchxkMytNEIdrUmJhI5HHjPIHxAi6+asU74kWQlQySJX6vgw9Pves
	 KwzZv7U4sY7Es82HdXxkcQUt60pUMZMGYFJhfTrezcnYfJiYTi352FoaE435siIdQB
	 yUKAOjtUgly05UTtvccI6t6wO/p1hmyTC/kkbB5RxZHQaUUPGx59bJlg7NORqAqtqV
	 II3HxBeOnzqAYRvfjslw3McL7JK6NqwIvyH/qlh8sSxLyLFh+55VNSJfLxHK/QkdC7
	 Rg5BlKbgECx3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 6/8] vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST_CONFIG
 for PCIe TPH ST configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260528124649.14732-7-fengchengwen@huawei.com>
References: <20260528124649.14732-7-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 15:17:05 +0000
Message-Id: <20260528151706.5BE851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The ioctl handler accesses device hardware registers without ensur=
ing the device is in the D0 power state, which can cause host crashes.
- [Medium] The shadow ST table is not populated with the initial hardware s=
tate, leading to hardware state corruption upon rollback.
- [Low] Mixing goto-based error handling with scope-based cleanup (`guard()=
`) violates kernel cleanup guidelines.
- [Low] Shadow ST table memory is allocated unconditionally during device i=
nitialization, ignoring the module parameter gate.
--

commit f65e8a2860b984f5dfa0664d516582dd9981c329
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST_CONFIG for PCIe TPH ST configurati=
on
   =20
This commit adds a new VFIO device feature to allow userspace to configure
PCIe TPH Steering Tag table entries. It implements a shadow ST table to cac=
he
entries and introduces a module parameter to gate the feature.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 050e7542952ed..c9035c0acaf08 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c

[ ... ]

> @@ -1551,6 +1563,116 @@ static int vfio_pci_core_feature_token(struct vfi=
o_pci_core_device *vdev,
>  	return 0;
>  }
> =20
> +static int vfio_pci_tph_st_shadow_size(struct vfio_pci_core_device *vdev)

[ ... ]

> +static int vfio_pci_tph_init(struct vfio_pci_core_device *vdev)
> +{
> +	vdev->tph_st_entries =3D vfio_pci_tph_st_shadow_size(vdev);
> +	vdev->tph_st_shadow =3D NULL;
> +
> +	if (vdev->tph_st_entries) {
> +		vdev->tph_st_shadow =3D kcalloc(vdev->tph_st_entries, sizeof(u16),
> +					      GFP_KERNEL);

[Severity: Low]
Since this feature is gated by the enable_unsafe_tph module parameter during
ioctl execution, should this memory allocation also be gated by that parame=
ter?

If the feature is disabled (the default), this allocates memory for every
TPH-capable device that will never be used.

> +		if (!vdev->tph_st_shadow)
> +			return -ENOMEM;
> +	}
> +
> +	mutex_init(&vdev->tph_lock);
> +
> +	return 0;
> +}

[ ... ]

> +static int vfio_pci_core_feature_tph_st_config(
> +			struct vfio_pci_core_device *vdev,
> +			u32 flags,
> +			struct vfio_device_feature_tph_st_config __user *arg,
> +			size_t argsz)
> +{
> +	struct vfio_device_feature_tph_st_config config;
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	void __user *uptr;
> +	int i, idx, ret;
> +	size_t sz;
> +	u16 *sts;
> +
> +	if (!enable_unsafe_tph || !vdev->tph_st_shadow)
> +		return -EOPNOTSUPP;
> +
> +	ret =3D vfio_check_feature(flags, argsz,
> +				 VFIO_DEVICE_FEATURE_SET |
> +				 VFIO_DEVICE_FEATURE_PROBE,
> +				 sizeof(config));
> +	if (ret <=3D 0)
> +		return ret;
> +
> +	if (copy_from_user(&config, arg, sizeof(config)))
> +		return -EFAULT;
> +
> +	if (config.count =3D=3D 0 || config.index >=3D vdev->tph_st_entries ||
> +		config.count > vdev->tph_st_entries ||
> +		config.index + config.count > vdev->tph_st_entries ||
> +		config.reserved !=3D 0)
> +		return -EINVAL;
> +
> +	guard(mutex)(&vdev->tph_lock);

[Severity: Low]
Is it okay to mix guard() based locking with goto-based error handling in t=
he
same function?

According to include/linux/cleanup.h, the expectation is to convert all
resources to scope-based cleanup or convert none of them. This code uses a
goto rollback pattern and manual kfree() alongside guard().

> +
> +	uptr =3D u64_to_user_ptr(config.data_uptr);
> +	sts =3D memdup_array_user(uptr, config.count, sizeof(u16));
> +	sz =3D config.count * sizeof(u16);
> +	if (IS_ERR(sts))
> +		return PTR_ERR(sts);
> +
> +	if (pcie_tph_enabled_req_type(pdev) =3D=3D PCI_TPH_REQ_DISABLE) {
> +		memcpy(&vdev->tph_st_shadow[config.index], sts, sz);
> +		kfree(sts);
> +		return 0;
> +	}
> +
> +	for (i =3D 0; i < config.count; i++) {
> +		idx =3D config.index + i;
> +		ret =3D pcie_tph_set_st_entry(pdev, idx, sts[i]);

[Severity: High]
Does this code need to ensure the device is in the D0 power state before
accessing its hardware registers?

The ioctl handler directly calls pcie_tph_set_st_entry() which accesses the
device's PCI configuration space or memory-mapped MSI-X table. If userspace
has placed the device into a low-power state (like D3hot) and no runtime PM
reference is acquired here, accessing MMIO regions could result in Unsuppor=
ted
Requests and potentially trigger a fatal machine check exception.

> +		if (ret)
> +			goto rollback;
> +	}
> +
> +	memcpy(&vdev->tph_st_shadow[config.index], sts, sz);
> +	kfree(sts);
> +	return 0;
> +
> +rollback:
> +	while (i-- > 0) {
> +		idx =3D config.index + i;
> +		pcie_tph_set_st_entry(pdev, idx, vdev->tph_st_shadow[idx]);

[Severity: Medium]
Will this rollback write zeros to the hardware during the first ioctl call?

The shadow ST table vdev->tph_st_shadow is allocated with kcalloc and never
synchronized with the initial hardware state. If a batch write fails after
successfully modifying some entries, this rollback loop appears to write the
zeroed shadow contents back to the hardware, potentially overwriting valid
BIOS- or host-configured ST entries instead of their true initial values.

> +	}
> +	kfree(sts);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528124649.1473=
2-1-fengchengwen@huawei.com?part=3D6
