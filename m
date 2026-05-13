Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53FA357D0D
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 03:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778642664; cv=none; b=fVEe14smDyG4E+jbh+CUqErSn81C5bb0qC34A779QFVU/r7yOmZwC78m/WDAN7jzwZY73AJVyPkDCJOZ7txx8Ckc4B+0f8WXjsFhYkmsAugn3se+xdIVyAixUOioMj+EIP0oYNwyvP4iV4saY7zV0TFxdjH7yDGOH3Im/oWWLoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778642664; c=relaxed/simple;
	bh=i5L4QdNWBgfBsSPDUx6ZlPtZz4s003INAcRT3ugW1RY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hRlnMx0+htfKxvWNCO0Hd+S7kUmXj3etEzeohXb9V+jd0bDqGJj6988bThA0+rnJ2P4HDgL90xrt72fOPHvbGRQ+kSHEDB2h5btYsR/KalL5AXrmRY48tjmkdBGCTfexN3e9xZ7FkFQfNnQL2JbuY1/f/1Ow005Y5k6YIO+rcdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEsxjzp+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEsxjzp+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A921C2BCB0;
	Wed, 13 May 2026 03:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778642664;
	bh=i5L4QdNWBgfBsSPDUx6ZlPtZz4s003INAcRT3ugW1RY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DEsxjzp+c4sRo15PD3fn/OgFd9bw9bO+lbimM6wIrNDVR9h7lRHDUJKZ68sxlHWZq
	 XSYX6jCCQqED8YAEe+kGp1ponoa6Yo8nBsv2Yi/VJnwsZr2Dc8z4XXQldv/pG3Be3C
	 gBngmnh74LbySFKjNNgRkd3UKt9Lho5smIq2BLFkl3UhwJuG0N+2f6HZBTc7p+FLnR
	 DWPufw/ZhBZYxDadgQfsNu3lRyug0OWJXgX10iJrNF+Issr5vzdn+g9oKKiqu5IJ5W
	 bOnl/P2UheAsmCf5fZs4gyN/1w3RD5bvP44eKijzvi+LjlF+mneib5s2mQz6bo/Q/H
	 zhj3eSMkp9NYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/16] vfio/pci: Preserve vfio-pci device files
 across Live Update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vipin Sharma" <vipinsh@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260511234802.2280368-3-vipinsh@google.com>
References: <20260511234802.2280368-3-vipinsh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 03:24:23 +0000
Message-Id: <20260513032424.5A921C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Time-of-Check to Time-of-Use (TOCTOU) race condition when validati=
ng `vdev->irq_type`.
- [High] Post-freeze access vulnerability allows userspace to re-activate t=
he device.
- [High] Silent failure of `vfio_pci_core_try_reset()` leaves the device in=
 an inconsistent state.
- [Medium] Missing `kho_is_enabled()` check before calling KHO preservation=
 APIs.
- [Medium] Missing INTx disable before device reset may cause spurious inte=
rrupts.
--

commit 8744f868d8d8c3c92253e4db7b371be095529dce
Author: Vipin Sharma <vipinsh@google.com>

vfio/pci: Preserve vfio-pci device files across Live Update

Implement the live update file handler callbacks to preserve a vfio-pci
device across a Live Update. State about each device is serialized into
a new ABI struct vfio_pci_core_device_ser and preserved using KHO and LUO.

> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vf=
io_pci_liveupdate.c
> index 1c74854600ea4..5cc57bf39dbee 100644
> --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c

[ ... ]

> +static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *=
args)
>  {
> -	return -EOPNOTSUPP;
> +	struct vfio_device *device =3D vfio_device_from_file(args->file);
> +	struct vfio_pci_core_device_ser *ser;
> +	struct vfio_pci_core_device *vdev;
> +	struct pci_dev *pdev;
> +
> +	vdev =3D container_of(device, struct vfio_pci_core_device, vdev);
> +	pdev =3D vdev->pdev;
> +
> +	ser =3D kho_alloc_preserve(sizeof(*ser));

Is it safe to call kho_alloc_preserve() without first checking if the KHO
subsystem is enabled via kho_is_enabled()?

Unconditionally allocating and preserving memory might add tracking state to
folios that will never be utilized if the subsystem is disabled.

[ ... ]

> +static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *ar=
gs)
> +{
> +	struct vfio_device *device =3D vfio_device_from_file(args->file);
> +	struct vfio_pci_core_device *vdev;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	vdev =3D container_of(device, struct vfio_pci_core_device, vdev);
> +	pdev =3D vdev->pdev;
> +
> +	guard(mutex)(&device->dev_set->lock);
> +
> +	/*
> +	 * Userspace must disable interrupts on the device prior to freeze so
> +	 * that the device does not send any interrupts until new interrupt
> +	 * handlers have been established by the next kernel.
> +	 */
> +	if (vdev->irq_type !=3D VFIO_PCI_NUM_IRQS) {

Does this check need to hold vdev->igate?

Without the mutex, could a concurrent ioctl() such as VFIO_DEVICE_SET_IRQS
modify the irq_type immediately after this check passes, allowing the device
to generate interrupts during kexec?

> +		pci_err(pdev, "Freeze failed! Interrupts are still enabled.\n");
> +		return -EINVAL;
> +	}
> +
> +	guard(rwsem_write)(&vdev->memory_lock);

[ ... ]

> +	/*
> +	 * Reset is a temporary measure to provide kernel after kexec a clean
> +	 * device while VFIO live update work is under development and not
> +	 * fully supported.  It will go away once continuous DMA support is
> +	 * added to device preservation.
> +	 */
> +	vfio_pci_zap_bars(vdev);
> +	ret =3D pci_load_saved_state(pdev, vdev->pci_saved_state);
> +	if (ret)
> +		return ret;
> +	pci_clear_master(pdev);

Does the PCI_COMMAND register need to have PCI_COMMAND_INTX_DISABLE explici=
tly
written prior to calling vfio_pci_core_try_reset()?

I noticed that the standard disable path in vfio_pci_core_disable() does th=
is
to prevent spurious interrupts from firing during the hardware reset.

> +	vfio_pci_core_try_reset(vdev);

If vfio_pci_core_try_reset() silently fails because it cannot acquire the P=
CI
locks or because the device does not support reset, the kexec will still
proceed.

Could this allow the next kernel to inherit a device that still has active =
DMA
engines or internal state?

> +	pci_restore_state(pdev);
> +	return 0;
> +}

Once vfio_pci_liveupdate_freeze() completes and releases the locks, what
prevents userspace threads from issuing new write(), mmap(), or ioctl() cal=
ls
on the device file descriptor?

Because kexec doesn't freeze userspace tasks, could a concurrent thread
re-enable DMA and interrupts on the device right before the kexec jump,
risking memory corruption in the successor kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511234802.2280=
368-1-vipinsh@google.com?part=3D2
