Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFB3376462
	for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2026 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513478; cv=none; b=AtU1JvOQhbVuK2rE1YBmHyMz4uO4PoSWqVtaPFrLYhDbCqtd0OF631y5gUJAmwLx5BJkcQs7s0EysoRICXIxUGk7TAYXkCxdDrugFjc9BM+oVgztujonc3u2A1u5uSoDaJmciwNiyM17ToU4AhSplmiVATDdMbRFhrAucSnKW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513478; c=relaxed/simple;
	bh=53oLg0H7dPwIyQ71iC6fFfMcZcta/2raKHAhti7i0aI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LXGEZ+XrkqUuscyhxg2WyR14J8GpD8emdLBDeW8DNpFnkP1x9zhYMSCWSDNZ1cu/j3Zx94mMHNV5Yfzel/AqSOSMCiMVsz2RPjFEul1iK4ghBUjs2YmcmguKinYe8Qya0nIBLSoBPvb3g5QqOEeLYpFZYkEBz85/2lUL0DeGmcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZJkYuy7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZJkYuy7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599761F00898;
	Wed,  3 Jun 2026 19:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780513476;
	bh=mAih/9rrq5aXbmAZqm4vtf3M9k/eiRe626gDnWjkhB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EZJkYuy7815lI++WFdVrMTrYrFVhuszN4JY9p8XshVg/By8xpmsKB/ooZgL4njuXO
	 o8RHIAVNqvkSkSER3NuhItwYvSw+Oe+z3VkO+WEf5Lz3gzpPowX40aB1RALKslCfYH
	 QTWeAkei+K8hZIQejcf1WeOU/UTmGSsnewng3H3EG7Azu66YuA5o/7niWdAmxdaw2I
	 irxf6u045TYYISybARwb6sN05gWvCNzxabv2mbnWijAvE3F/ys8U6+cP0BIOE1skND
	 CwJNjyWis8/L45UfZUvJbz61ukBObfOEeglLwIvHgzkGtIqPEGDNJ/0WA6XyDHQD9B
	 F8izGn1R+PmeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 3/4] vfio/pci: Add a reset_done callback for
 vfio-pci driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260603182415.2324-4-alifm@linux.ibm.com>
References: <20260603182415.2324-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 19:04:35 +0000
Message-Id: <20260603190436.599761F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] The `reset_done` callback breaks standard device resets by irr=
eversibly overwriting the runtime PCI configuration space.
- [High] Concurrent execution of `vfio_pci_core_aer_reset_done` and `vfio_p=
ci_core_disable` leads to a Use-After-Free on `vdev->pci_saved_state`.
- [High] The `reset_done` callback is never invoked during AER error recove=
ry.
--

commit ea3a78b14c5b561020bd16d25cbb09f0536e6e7a
Author: Farhan Ali <alifm@linux.ibm.com>

vfio/pci: Add a reset_done callback for vfio-pci driver

On error recovery for a PCI device bound to vfio-pci driver, we want to
recover the state of the device to its last known saved state. The callback
restores the state of the device to its initial saved state.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 27642f10fe973..95af3e827ee05 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2290,6 +2290,17 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(st=
ruct pci_dev *pdev,
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
> =20
> +static void vfio_pci_core_aer_reset_done(struct pci_dev *pdev)
> +{
> +	struct vfio_pci_core_device *vdev =3D dev_get_drvdata(&pdev->dev);
> +
> +	if (!vdev->pci_saved_state)
> +		return;

[Severity: High]
Can this race with vfio_pci_core_disable() and cause a use-after-free on
vdev->pci_saved_state?

When a user closes the device fd, vfio_pci_core_disable() is invoked:

vfio_pci_core_disable()
    pci_load_and_free_saved_state(pdev, &vdev->pci_saved_state);

This frees the memory and sets the pointer to NULL without holding the PCI
device_lock.

Concurrently, if a system-initiated function reset occurs, the PCI core
holds device_lock and invokes this reset_done callback via
pci_dev_restore().

Because there is no common lock between these two paths, can the pointer be
freed by vfio_pci_core_disable() immediately after the NULL check here, but
before it is dereferenced in pci_load_saved_state()?

> +
> +	pci_load_saved_state(pdev, vdev->pci_saved_state);
> +	pci_restore_state(pdev);

[Severity: Critical]
Does this unintentionally overwrite the runtime PCI configuration space
during normal device resets?

The PCI core invokes reset_done at the end of standard PCI function resets
via pci_dev_restore(), which includes pci_try_reset_function() triggered by
the VFIO_DEVICE_RESET ioctl.

Normally, pci_try_reset_function() transparently saves the runtime state,
resets the device, and restores it.

However, restoring vdev->pci_saved_state here unconditionally applies the
state from when the device was initially opened. Could this revert all
runtime configuration changes made by a guest VM, such as BAR programming
and MSI-X enablement?

> +}
> +
>  int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
>  				  int nr_virtfn)

[ ... ]

> @@ -2354,6 +2365,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
> =20
>  const struct pci_error_handlers vfio_pci_core_err_handlers =3D {
>  	.error_detected =3D vfio_pci_core_aer_err_detected,
> +	.reset_done =3D vfio_pci_core_aer_reset_done,

[Severity: High]
Will this callback actually be invoked during AER error recovery?

The commit message mentions restoring the device state during PCIe AER error
recovery. However, the AER core in pcie_do_recovery() coordinates recovery
by calling .error_detected, .mmio_enabled, .slot_reset, and .resume.

It uses low-level hardware resets like pci_bus_error_reset() or
pcie_reset_flr() which do not trigger the pci_dev_restore() wrapper.

Since reset_done is exclusively called from pci_dev_restore() during
standard function resets, does the state restoration logic belong in
.slot_reset instead to ensure it executes during an AER event?

>  };
>  EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603182415.2324=
-1-alifm@linux.ibm.com?part=3D3
