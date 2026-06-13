Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB121EE7C6;
	Sat, 13 Jun 2026 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781373535; cv=none; b=pxlHOoMCtTY6OYSXy9PP5h6cGY6T+33dtTIae1Yu3hHfu/0mn4cQTTeppXZ+j2+SB+vyC0kGq16SKuaW8I1Fdyj3frIN2TesGBRSQTEPUXyWcxeXmLZalVtaZSVx8x6TGkOXWnKy+OCCMhucpHZmNZs8PPzn9GIBfkbEFSCpJ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781373535; c=relaxed/simple;
	bh=ruOXF/n4c94stJyv2jdMOlOcQL525y5kXrKMfBYjX20=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l2ohviQURlYsVzGU5y6vhorVPmCzRD0RCB6eglLFarkkjLshmccHC3an3/5t77m16DFi8uKdbpAu4zaBGDYXrq/rCcNQPI+L4WfNdZMHwwkKtsSNDfCn72tZ0mOeGDLczlbs5mAIXl3D27gStH2HuAJ4p0/KAzuv5RtvaidJIHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihClCT7f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihClCT7f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E7D1F000E9;
	Sat, 13 Jun 2026 17:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781373533;
	bh=fzAbWFIlKsVBTYkcBZIPTwZkjHWT1u18E8bKHRYs4oI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ihClCT7fIPE5pfTq8RGhxjzPn1ib8/8RtPpkCfce4wfHBDCOcuiemd9MguOzQF80D
	 /uy/F3jpFxWE6eyDP5hGioliH/kfOn4ICnssfjtgholHtM2wt6ek30Yihd5GRJoywl
	 hZTA+natjIGF6eUKuQT7kLUGswLa04F3gwZE7rRzPKfslOe0hTTl+aPIzMcO7w0Eq7
	 bgGV19sxzQ/PoOJLwdwqnO7PSZbG0GyqHgrHIUExOm3BKYohTRWZAkTWq2f9/Z69KK
	 3LepNC+2nIpscRvmcT5efG9tXDnmlHWmRM7nY7CFlMy79n8KwNrBn39vlvPmmoxm6f
	 g/ZozNNh9z2ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/3] vfio/pci: Allow userspace to set a virtual
 Device Serial Number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Arya" <pranjal.arya@oss.qualcomm.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260613-pcie_vfio-v1-2-09168188f3f2@oss.qualcomm.com>
References: <20260613-pcie_vfio-v1-2-09168188f3f2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 17:58:52 +0000
Message-Id: <20260613175853.59E7D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The VFIO_DEVICE_FEATURE_PCI_DSN ioctl can cause an out-of-bounds h=
eap read or write on the `vdev->vconfig` buffer if a device exposes a DSN c=
apability near the end of its PCIe configuration space.
- [Medium] UAPI documentation states `serial_number` is in little-endian wi=
re order, but the implementation processes it as a host-endian `u64`.
- [Medium] The use of `WRITE_ONCE()` on the writer side does not prevent te=
aring because the concurrent reader side uses `memcpy()`, leading to a data=
 race.
--

commit 519ac218356009252a82c7aa68a221467812de3f
Author: Pranjal Arya <pranjal.arya@oss.qualcomm.com>

vfio/pci: Allow userspace to set a virtual Device Serial Number

This patch adds a VFIO_DEVICE_FEATURE_PCI_DSN device feature that lets the
trusted userspace VMM GET or SET the 64-bit serial number presented in the
device's virtualized config space.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index 24dfeb43cb714..60c19129c8145 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -2078,3 +2078,62 @@ bool vfio_pci_core_range_intersect_range(loff_t bu=
f_start, size_t buf_cnt,
[ ... ]
> +int vfio_pci_core_feature_dsn(struct vfio_pci_core_device *vdev, u32 fla=
gs,
> +			      void __user *arg, size_t argsz)
> +{
[ ... ]
> +	pos =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DSN);
> +	if (!pos)
> +		return -ENOTTY;
> +
> +	ret =3D vfio_check_feature(flags, argsz,
> +				 VFIO_DEVICE_FEATURE_GET |
> +				 VFIO_DEVICE_FEATURE_SET,
> +				 sizeof(dsn));
> +	if (ret !=3D 1)
> +		return ret;
> +
> +	vserial =3D (__le32 *)&vdev->vconfig[pos + PCI_DSN_LOW_DW];

[Severity: High]
Does this code risk an out-of-bounds heap read or write on vdev->vconfig?

pci_find_ext_capability() only guarantees that the 4-byte capability header
fits within pdev->cfg_size. If a device exposes a DSN capability near the
end of its PCIe configuration space (for example, at offset 4092), pos will
be 4092.

Since vdev->vconfig is allocated with exactly pdev->cfg_size bytes, accessi=
ng
pos + PCI_DSN_LOW_DW (offset 4) will calculate a pointer completely out of
bounds, causing the subsequent operations to access adjacent kernel heap me=
mory.

> +
> +	if (flags & VFIO_DEVICE_FEATURE_SET) {
> +		if (copy_from_user(&dsn, arg, sizeof(dsn)))
> +			return -EFAULT;
> +
> +		/*
> +		 * The config-space read path (vfio_default_config_read())
> +		 * does not hold a lock, and a guest reads the DSN as two
> +		 * 32-bit dwords.  Store each dword with WRITE_ONCE() so a
> +		 * concurrent guest read observes a consistent dword; a guest
> +		 * reading the two halves around this update may see an
> +		 * old/new mix, exactly as hardware may tear a 64-bit read of
> +		 * a register pair.  This matches the DSN's read-only,
> +		 * advisory nature.  Serializing concurrent SET callers is the
> +		 * userspace VMM's responsibility.
> +		 */
> +		WRITE_ONCE(vserial[0], cpu_to_le32(lower_32_bits(dsn.serial_number)));
> +		WRITE_ONCE(vserial[1], cpu_to_le32(upper_32_bits(dsn.serial_number)));

[Severity: Medium]
Does using WRITE_ONCE() here actually prevent torn reads by the guest?

The comments state this is to ensure a concurrent guest read observes a
consistent dword. However, the guest config-space read path in
vfio_default_config_read() uses memcpy(), which performs plain, non-atomic
memory accesses.

Because the compiler and processor are free to split the memcpy() load into
byte-sized operations, WRITE_ONCE() on the writer side does not guarantee
that the reader will observe an atomic 32-bit read.

> +		return 0;
> +	}
[ ... ]
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5de618a3a5eee..e5b8dfd3833f6 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1511,6 +1511,24 @@ struct vfio_device_feature_bus_master {
[ ... ]
> +/**
> + * Upon VFIO_DEVICE_FEATURE_SET, set the PCIe Device Serial Number (DSN)
> + * presented to the user (guest) in the device's virtualized config spac=
e.
> + * By default vfio-pci scrubs the physical DSN to zero so the host devic=
e's
> + * unique identifier is not leaked; this feature lets the hypervisor pre=
sent
> + * a chosen, per-VM synthetic serial instead (for example a stable but
> + * non-host-identifying value for migration).
> + *
> + * Upon VFIO_DEVICE_FEATURE_GET, read back the currently presented seria=
l.
> + *
> + * The feature is only available for devices that expose a DSN capabilit=
y.
> + * serial_number is the 64-bit serial in little-endian wire order.
> + */
> +struct vfio_device_feature_pci_dsn {
> +	__aligned_u64 serial_number;
> +};

[Severity: Medium]
Is there an endianness mismatch between this documentation and the
implementation?

The documentation states serial_number is the 64-bit serial in little-endian
wire order. However, vfio_pci_core_feature_dsn() treats it as a host-endian
value when extracting halves:

    WRITE_ONCE(vserial[0], cpu_to_le32(lower_32_bits(dsn.serial_number)));

If a userspace program on a big-endian system follows the documentation and
provides a pre-formatted little-endian value, the kernel will interpret it =
as
a big-endian integer, incorrectly extract the halves, and store garbled byt=
es
into the virtual config space.

Should the documentation be updated to indicate a host-endian 64-bit intege=
r,
or should the code be changed to expect an __le64 type?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613-pcie_vfio-=
v1-0-09168188f3f2@oss.qualcomm.com?part=3D2
