Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FD22F0680
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 20:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778270632; cv=none; b=gTGJJ844pOpDOS6e3Z4hR+6ZEDEr+VCZNnaB/IPIjDkMvBU4xGK3sOfzVOn+Gn6fQpWCWGl2gAFrjEd0BRFMaBvHgLVieN5JJp8lxxhJ+iG+xhovpik/rdi3Nmh7tcJhMiLwEdcb1etP6+qcXnPERrtxq4LjDXnM4oN4WYOACho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778270632; c=relaxed/simple;
	bh=l59vJd2IC/wcrjIDYyYhP5FAMAaAYWBdyRI+ajevnOU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WBxIUcZVqfTK9jPdT8MkNZN14d4DZGvo1cIEbMxZIJB4cKuacTWRa4zqTItES1SROSSwGoQddoMXZbZzVX1GznDlTHyx1thZhmgGPzCnTBS+lZSBFjYpDIcTb1AYvhhngIViKrXnzjKx7ncwaZjbYafxuAbO7qN7O+vUs4qouVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKzwgDzb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKzwgDzb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E20C2BCB0;
	Fri,  8 May 2026 20:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778270632;
	bh=l59vJd2IC/wcrjIDYyYhP5FAMAaAYWBdyRI+ajevnOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QKzwgDzbtLZw6YjxdW9K1AzLoI0no4HmIaGM6SsKLlb2tx0QZoEZRRS42MBAb7NoZ
	 mc4nX2mb/CXmXb6gTBUphdl85yeNNSWcTWCE799Y1gwatgiSMzOdL+ofiVQC1qMgDE
	 JMQQtxmSt7AwQuVKGS8etO5Qqdyi66vepEJ4zAnim2BMtqam0tFyjA8KW4vRbXdl7w
	 y1bVruuXurCoQuie3f5E34ikkypZcMBG/LOoI2u5LPc8PTgk/XAXcCYApsl7ynUHQO
	 NX6Zhkki/RTKLLQM3GDvHR/LltdImZJgbXiCHXLDpLsbhAdy3LIb+mTNLXE+2hWqCJ
	 jh9Ns/8+FINIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/7] vfio/pci: Add PCIe TPH interface with capability
 query
Reply-To: sashiko@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260508064053.37529-5-fengchengwen@huawei.com>
References: <20260508064053.37529-5-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 20:03:51 +0000
Message-Id: <20260508200351.D3E20C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] UAPI Backwards Compatibility Breakage and Buffer Overflow Risk
- [High] Missing memory_lock Causes Hardware State Races During Reset
- [Medium] UAPI Bloat / Bypassing VFIO_DEVICE_FEATURE Framework
- [Medium] Incorrect Module Parameter Scope Limits Vendor Drivers
--

commit 83318520665fc31c05135b8adff081970464291e
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add PCIe TPH interface with capability query
   =20
Add VFIO_DEVICE_PCI_TPH IOCTL to allow userspace to query device TPH
capabilities, supported modes, and steering tag table information.

> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 0c771064c0b84..40bf5aa9fd0be 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -60,6 +60,12 @@ static bool disable_denylist;
>  module_param(disable_denylist, bool, 0444);
>  MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disa=
bling the denylist allows binding to devices with known errata that may lea=
d to exploitable stability or security issues when accessed by untrusted us=
ers.");
> =20
> +#ifdef CONFIG_PCIE_TPH
> +static bool enable_unsafe_tph_ds_mode;
> +module_param(enable_unsafe_tph_ds_mode, bool, 0444);

Vendor-specific VFIO drivers (such as mlx5_vfio_pci or hisi_vfio_pci) load
the shared vfio_pci_core.ko library directly and do not depend on vfio_pci.=
ko.

If users of these vendor drivers want to enable unsafe TPH DS mode, they
have no way to do so unless they explicitly load the generic vfio_pci drive=
r,
which alters the core state for all bound devices.

Should this parameter reside directly in vfio_pci_core.c instead?

[ ... ]

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 3f8d093aacf8a..0e97b128fd637 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -1461,6 +1463,54 @@ static int vfio_pci_ioctl_ioeventfd(struct vfio_pc=
i_core_device *vdev,
>  				  ioeventfd.fd);
>  }
> =20
> +static int vfio_pci_tph_get_cap(struct vfio_pci_core_device *vdev,
> +				struct vfio_device_pci_tph_op *op,
> +				void __user *uarg)
> +{
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	struct vfio_pci_tph_cap cap =3D {0};
> +	u8 mode;
> +
> +	if (op->argsz < offsetofend(struct vfio_device_pci_tph_op, cap))
> +		return -EINVAL;

If struct vfio_pci_tph_cap is extended in future kernel releases, offsetofe=
nd()
will increase. Will new kernels reject valid requests from older userspace
binaries with -EINVAL, breaking backwards compatibility?

> +
> +	mode =3D pcie_tph_get_st_modes(pdev);
> +	/* Hide unsafe device-specific (DS) mode by default */
> +	if (!enable_unsafe_tph_ds_mode)
> +		mode &=3D ~PCI_TPH_CAP_ST_DS;
> +	if (mode =3D=3D 0 || mode =3D=3D PCI_TPH_CAP_ST_NS)
> +		return -EOPNOTSUPP;
> +
> +	if (mode & PCI_TPH_CAP_ST_IV)
> +		cap.supported_modes |=3D VFIO_PCI_TPH_MODE_IV;
> +	if (mode & PCI_TPH_CAP_ST_DS)
> +		cap.supported_modes |=3D VFIO_PCI_TPH_MODE_DS;
> +	cap.st_table_sz =3D pcie_tph_get_st_table_size(pdev);
> +
> +	if (copy_to_user(uarg, &cap, sizeof(cap)))

If the capability structure grows in the future, will the kernel write beyo=
nd
the bounds of an older userspace application's allocated buffer?

> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
> +			      void __user *uarg)
> +{
> +	struct vfio_device_pci_tph_op op =3D {0};
> +	size_t minsz =3D sizeof(op.argsz) + sizeof(op.op);
> +
> +	if (copy_from_user(&op, uarg, minsz))
> +		return -EFAULT;
> +
> +	switch (op.op) {
> +	case VFIO_PCI_TPH_GET_CAP:
> +		return vfio_pci_tph_get_cap(vdev, &op, uarg + minsz);

This handler does not acquire down_read(&vdev->memory_lock). Does this allow
TPH IOCTLs to run concurrently with a PCI hot reset
(VFIO_DEVICE_PCI_HOT_RESET) which takes the write lock via
vfio_pci_zap_and_down_write_memory_lock()?

Concurrent execution could allow vfio_pci_tph_get_cap() to read configurati=
on
space while the secondary bus is in reset, yielding bogus data.

More importantly, later in this series when vfio_pci_tph_set_st() is added =
to
write directly to the MSI-X table via MMIO, performing MMIO writes to a dev=
ice
actively undergoing reset can cause PCI Master Aborts. On certain platforms,
this can trigger AER panics or EEH isolation.

[ ... ]
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5de618a3a5eee..81da2bd0c21b0 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
[ ... ]
> +/**
> + * VFIO_DEVICE_PCI_TPH - _IO(VFIO_TYPE, VFIO_BASE + 22)
> + *
> + * IOCTL for managing PCIe TLP Processing Hints (TPH) on
> + * a VFIO-assigned PCI device. Provides operations to query
> + * device capabilities, enable/disable TPH, retrieve CPU's
> + * steering tags, and program steering tag tables.
> + *
> + * Return: 0 on success, negative errno on failure.
> + *         -EOPNOTSUPP: Operation not supported
> + *         -ENODEV: Device or required functionality not present
> + *         -EINVAL: Invalid argument or TPH not supported
> + */
> +#define VFIO_DEVICE_PCI_TPH	_IO(VFIO_TYPE, VFIO_BASE + 22)

This introduces a new top-level IOCTL to manage PCIe TPH capabilities inste=
ad
of using the standard VFIO_DEVICE_FEATURE IOCTL.

Could this be implemented using VFIO_DEVICE_FEATURE, which was explicitly
designed to act as a unified multiplexer for querying and setting new device
features, to avoid unnecessarily bloating the UAPI namespace and duplicating
boilerplate for sizing and feature discovery?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508064053.3752=
9-1-fengchengwen@huawei.com?part=3D4
