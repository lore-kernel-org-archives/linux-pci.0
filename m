Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9A522D7A1;
	Thu, 28 May 2026 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779986544; cv=none; b=e23+fpP4ZHpsOu7o0uSm5WtllkSSVeZXMVRxRt8vXv2M1qgjPNJOqnpw01Rx04adIxZQ7KkWWtr/L4Z206FzhPVhFCNQBT982f3YaHFoXxuKLpKh4r3dJ9vppbdBpE02b1KGfSKI7pGYSYMnmmYoCp49QGXLB+d35guBxmMB2X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779986544; c=relaxed/simple;
	bh=1Zfxy4VSnagYxaLcyEMlrt47aCI1UBsSVx7CHmc0ZKg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mxfvN38d6Ih51bte2Hj0sYEotLfYx070xC/kmhvz1IrzpOAlhf4UWmfDvDcWHBetvCU4pzvChVQM3hCOT3s+bC//huW1qJOGdk94apcjFqH1XLpWiEmEGaxmAcR9mjtUsWAmrCChNlyh7RFpGO/YZS4rf0kK+MNCco4uA3kyq04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbMJpinJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbMJpinJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184121F000E9;
	Thu, 28 May 2026 16:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779986543;
	bh=fJpY33Zx414L+id2YXWf1f4tdUltkl6t8DS4leef1Zg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SbMJpinJc+XcXm3K3GkwcUB2zQbUem9iP7bNRmzVo1kZhwS3po3HSkrQKGOe7M+Ns
	 m5AfIZ8SJLfKhQI7y9rAGJPPjXi3NyuEncihs2Hy0Z43PHyScshVFVLqsMiUBnSQV0
	 lOX2LYV6jLTbqDrHfYb9fgBVUC/aXIW0swVZXxfUFCKqRCOmpu9NRgSX9IIe3tdZk9
	 y9EKkYSYmrGDP2a+nW01h6Sma8lhu1/bWXTtFhuNF1WO8yIj0sGmcYDxZ1Pp9P9oqc
	 gdsE/WMuv0UUsv0ZadM3ysXyFK/ryANiq20prGDerZEqLee+OgGCk4CkzXk65gq7PR
	 VdfgDCa1aOK+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 8/8] vfio/pci: Virtualize PCIe TPH capability
 registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260528124649.14732-9-fengchengwen@huawei.com>
References: <20260528124649.14732-9-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 16:42:22 +0000
Message-Id: <20260528164223.184121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Unconditional overwrite of hardware ST Table destroys guest's =
native configuration.
- [High] Silent dropping of partial writes and ST table configuration in TP=
H config space.
- [High] Modifying ST Table entries while the TPH Requester is enabled.
- [High] Concurrent modification of `struct pci_dev` bitfields (`tph_enable=
d` vs. `msix_enabled`) without a shared lock.
- [Medium] Mixing `goto`-based error handling and `guard()` scope-based cle=
anup in the same function.
- [Low] Masking operations on an uninitialized stack variable when `vfio_di=
rect_config_read()` fails.
- [Low] Destroying the `tph_lock` mutex before the final operation it seria=
lizes.
- [Low] Comment incorrectly identifies the `PCI_TPH_CTRL` offset.
--

commit 597ad56e8c1a479406f7f445961a108159c417c8
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Virtualize PCIe TPH capability registers

Implement read/write virtualization for PCIe TPH Extended Capability:
1. Read path: Mask out extended requester bit if hardware does not support
   extended ST, to hide unavailable capability from userspace.
2. Write path: Validate TPH mode and requester configuration, mediate TPH
   enable/disable requests. Sync shadow ST table to hardware after
   successful TPH enabling.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index a10ed733f0e3a..bed3794e6033d 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c

[ ... ]

> @@ -313,6 +317,78 @@ static int vfio_virt_config_read(struct vfio_pci_cor=
e_device *vdev, int pos,
>  	return count;
>  }
> =20
> +static int vfio_pci_tph_config_read(struct vfio_pci_core_device *vdev, i=
nt pos,
> +				    int count, struct perm_bits *perm,
> +				    int offset, __le32 *val)
> +{
> +	const int target_byte =3D PCI_TPH_CAP + 1;
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	const u8 ext_bit =3D BIT(0);
> +	u8 *data =3D (u8 *)val;
> +	int byte_off;
> +	int ret;
> +
> +	if (pdev->tph_ext_requester || offset > target_byte ||
> +		offset + count <=3D target_byte)
> +		return vfio_direct_config_read(vdev, pos, count, perm,
> +					       offset, val);
> +
> +	ret =3D vfio_direct_config_read(vdev, pos, count, perm, offset, val);
> +
> +	/* Mask out TPH requester capability */
> +	byte_off =3D target_byte - offset;
> +	/* Defensive check: prevent out-of-bounds access */
> +	if (byte_off < count)
> +		data[byte_off] &=3D ~ext_bit;

[Severity: Low]
If vfio_direct_config_read() returns a negative error code, does this execu=
te
the bitwise mask on uninitialized stack data in val before returning? Even
though the upper layers discard the value on error, perhaps this should che=
ck
for ret < 0 before proceeding?

> +
> +	return ret;
> +}
> +
> +static int vfio_pci_tph_config_write(struct vfio_pci_core_device *vdev, =
int pos,
> +				     int count, struct perm_bits *perm,
> +				     int offset, __le32 val)
> +{
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	u32 data =3D le32_to_cpu(val);
> +	enum tph_req_policy policy;
> +	u8 mode, req;
> +	int i, ret;
> +
> +	if (!enable_unsafe_tph)
> +		return count;
> +
> +	/*
> +	 * TPH_CTRL (offset 4) register layout:
> +	 *   Byte 0 (offset 4): Bits [2:0] - ST Mode selection
> +	 *   Byte 1 (offset 5): Bits [1:0] - TPH Requester enable

[Severity: Low]
This isn't a bug, but the comment states the TPH_CTRL register is at offset=
 4.
Isn't PCI_TPH_CTRL actually at offset 8, while offset 4 is the PCI_TPH_CAP
register?

> +	 *
> +	 * Only intercept writes with count >=3D 2 which cover both control
> +	 * fields. Single-byte partial writes do not affect combined
> +	 * configuration.
> +	 */
> +	if (offset !=3D PCI_TPH_CTRL || count < 2)
> +		return count;

[Severity: High]
By returning count directly here, doesn't this silently drop all byte-wise
writes to the control register, as well as any writes to the ST Table if it=
 is
located within the TPH capability space (PCI_TPH_LOC_CAP)? The guest might
assume the writes succeeded, leading to a permanent hardware state mismatch.
Should this fallback to writing the unhandled cases instead of returning co=
unt
early?

> +
> +	guard(mutex)(&vdev->tph_lock);
> +
> +	mode =3D FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, data);
> +	req =3D FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, data);
> +	if (req =3D=3D PCI_TPH_REQ_TPH_ONLY || req =3D=3D PCI_TPH_REQ_EXT_TPH) {
> +		policy =3D (req =3D=3D PCI_TPH_REQ_TPH_ONLY) ?
> +			 TPH_REQ_STANDARD : TPH_REQ_EXTENDED;
> +		ret =3D pcie_enable_tph(pdev, mode, policy);

[Severity: High]
Is there a data race when setting pdev->tph_enabled inside pcie_enable_tph(=
)?
The tph_enabled flag shares the same unsigned int word in struct pci_dev as
msix_enabled. Since this path is only protected by vdev->tph_lock, if users=
pace
concurrently triggers VFIO_DEVICE_SET_IRQS (which mutates msix_enabled under
vdev->igate), could the compiler's read-modify-write on the shared bitfield
word silently corrupt these PCI device flags?

> +		if (ret =3D=3D 0 && vdev->tph_st_shadow) {
> +			for (i =3D 0; i < vdev->tph_st_entries; i++)
> +				pcie_tph_set_st_entry(pdev, i,
> +						      vdev->tph_st_shadow[i]);
> +		}

[Severity: High]
The PCIe Base Specification (6.17.3) states that software must not modify t=
he
Steering Tag Table while the TPH Requester Enable bit is 1. Since
pcie_enable_tph() sets the enable bit in hardware before this loop writes to
the ST Table, could this cause undefined hardware behavior or dropped TLPs?

[Severity: Critical]
Also, if a generic unmodified VM configures the ST Table natively via MMIO
without using the custom VFIO ioctl, tph_st_shadow will contain only its
default zeros. Won't this unconditional iteration wipe out the guest's valid
native ST tags with zeros at the exact moment TPH is enabled, permanently
corrupting the device state?

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 851e4d0828f2d..2a5cb945275ea 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c

[ ... ]

> @@ -1605,6 +1608,9 @@ static void vfio_pci_tph_deinit(struct vfio_pci_cor=
e_device *vdev)
>  	vdev->tph_st_entries =3D 0;
> =20
>  	mutex_destroy(&vdev->tph_lock);
> +
> +	/* Reset TPH status on session exit */
> +	pcie_disable_tph(vdev->pdev);
>  }

[Severity: Low]
Does it make sense to destroy the vdev->tph_lock mutex before calling
pcie_disable_tph()? Even though this runs sequentially during device teardo=
wn,
it seems semantically inverted to destroy the lock before manipulating the
hardware state it protects.

[ ... ]

> @@ -1645,6 +1651,13 @@ static int vfio_pci_core_feature_tph_st_config(
>  		config.reserved !=3D 0)
>  		return -EINVAL;
> =20
>  	guard(mutex)(&vdev->tph_lock);
> =20
>  	uptr =3D u64_to_user_ptr(config.data_uptr);
>  	sts =3D memdup_array_user(uptr, config.count, sizeof(u16));
>  	sz =3D config.count * sizeof(u16);
>  	if (IS_ERR(sts))
>  		return PTR_ERR(sts);
> =20
>  	if (pcie_tph_enabled_req_type(pdev) =3D=3D PCI_TPH_REQ_DISABLE) {
>  		memcpy(&vdev->tph_st_shadow[config.index], sts, sz);
>  		kfree(sts);
>  		return 0;
>  	}
> =20
>  	for (i =3D 0; i < config.count; i++) {
>  		idx =3D config.index + i;
>  		ret =3D pcie_tph_set_st_entry(pdev, idx, sts[i]);
>  		if (ret)
>  			goto rollback;
>  	}

[Severity: High]
This loop calls pcie_tph_set_st_entry() to modify hardware ST entries while
pcie_tph_enabled_req_type(pdev) !=3D PCI_TPH_REQ_DISABLE. Doesn't this viol=
ate
the PCIe spec by modifying the Steering Tag Table while the TPH Requester E=
nable
bit is 1?

[Severity: Medium]
According to the cleanup subsystem guidelines, mixing goto-based error hand=
ling
labels with scope-based guard() declarations in the same function is not al=
lowed.
Since guard(mutex)(&vdev->tph_lock) is used at the start of this block, and
goto rollback is used here for error handling, could this be refactored to
fully adopt scope-based cleanup like __free(kfree) for the sts array?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528124649.1473=
2-1-fengchengwen@huawei.com?part=3D8
