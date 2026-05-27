Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA421389107
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910495; cv=none; b=Y24mK0FWSp7dtftfdpMOZK+S2FrGwDvR2c5YUe7ijUEM4HuLJ1MoPndAexDTDHPuHe8KhgwjQek/PVSu2XeeJsf1qiMscYMUFQW/qNKcPZ6ZLUPfILPZaBrbjbziIisDi/eEHywFN17Lbfccq3aBTW3vALSAgbRsB8If/wxPI3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910495; c=relaxed/simple;
	bh=MvsH5smzuNUer2UWEdYz1V89kf/txOlN+sciyYSwOkY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GbdRsuKNmrzKT1Q/89d9kftio4t4oL+EIXvmyhQg6+ORya9ogJVAJrCawDL6SQph4L5+XoXHMFvqQpbuW/2col2ns7F+dMFJjzthCGSHtFejgkfSNe3J/NhUDuFzFF5eIVWc/sMiUzqZZmDlH+UxjNCJHWruP6h1Qel+A5H3294=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B62i6LW+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B62i6LW+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37FA1F000E9;
	Wed, 27 May 2026 19:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779910479;
	bh=THKsxDyess097JzzayVASytXNP6IJRmumVcbK5jAvDI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B62i6LW++xSPZCeLLXawPgW6EbStbw8QO5sKEfLsmuAYZses6zx3atT9VG7hzpMLX
	 kWDcWIOnCM8WZ9gzLeLummnpxPFAJqp51BziniRrU3eyzrah4guKrtOwbCQmEpJTIg
	 /yuspLlmEoHOb9+meF2oVGMR4yt+rdfl5sRxtE4nRxcF9/4Fpzo6/7co/WZ66Nn4R8
	 F5fEfYjkEl0JndOfqOjZVAlcvVfSaEW+4aEjJpC86YsefLkIzaHY7z1rF0I7C2wGxV
	 A7zrFctMDjQhy0ETj9Os1YBconWZBmrNr2L296PL5X8c1b0nTQG1FIks/92zLEcdlw
	 L3SBT70sG4aHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] ppc/pnv: Add null checks for OpenCapi PHBs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Gupta" <adityag@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260527180816.2749186-2-adityag@linux.ibm.com>
References: <20260527180816.2749186-2-adityag@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 19:34:38 +0000
Message-Id: <20260527193438.F37FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing NULL pointer dereference in the error path of `pnv_ph=
p_alloc_slot()` due to an uninitialized bus pointer.
- [High] Unbalanced `pci_enable_device()` refcount leak during setup failur=
es and normal teardown.
- [High] Concurrent accesses to `pnv_php_enable_slot` and `pnv_php_disable_=
slot` can cause double-frees due to lack of state locking.
- [Medium] Improper error code in `pnv_php_reset_slot()` prematurely aborts=
 PCI reset method discovery.
--

commit 534a90517227ad6163f935501ac2f0ed9cf60b83
Author: Aditya Gupta <adityag@linux.ibm.com>

ppc/pnv: Add null checks for OpenCapi PHBs

This patch adds null checks for php_slot->pdev across several PCI hotplug
operations in pnv_php.c. It prevents NULL pointer dereferences for OpenCAPI
PHB direct slots where the bus has no self device, fixing kernel crashes
observed during boot and hotplug events.

Cc: stable@vger.kernel.org
Fixes: 80f9fc236279 ("PCI: pnv_php: Work around switches with broken presen=
ce detection")

> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index ff92a5c301b81..d0f5e8ad1f716 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -47,6 +47,9 @@ static void pnv_php_disable_irq(struct pnv_php_slot *ph=
p_slot,
>  	struct pci_dev *pdev =3D php_slot->pdev;
>  	u16 ctrl;
> =20
> +	if (!pdev)
> +		return;
> +
>  	if (php_slot->irq > 0) {
>  		pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &ctrl);
>  		ctrl &=3D ~(PCI_EXP_SLTCTL_HPIE |
>  			  PCI_EXP_SLTCTL_PDCE |
>  			  PCI_EXP_SLTCTL_DLLSCE);
>  		pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, ctrl);
> =20
>  		free_irq(php_slot->irq, php_slot);

[Severity: High]
This is a pre-existing issue, but can concurrent accesses to the slot
operations cause a double-free here?

If pnv_php_disable_slot() is called concurrently by two threads (for exampl=
e,
via sysfs writes to the power attribute racing with the workqueue event
handler), both threads can bypass the state check because php_slot->state is
not locked.

They could both execute pnv_php_disable_all_downstream_irqs() and reach
this point. Since both would see php_slot->irq > 0, they would both call
free_irq(php_slot->irq, php_slot).

Should there be some synchronization around the state transitions?

[ ... ]

> @@ -1093,6 +1107,9 @@ static void pnv_php_enable_irq(struct pnv_php_slot =
*php_slot)
>  	struct pci_dev *pdev =3D php_slot->pdev;
>  	int irq, ret;
> =20
> +	if (!pdev)
> +		return;
> +
>  	/*
>  	 * The MSI/MSIx interrupt might have been occupied by other
>  	 * drivers. Don't populate the surprise hotplug capability
>  	 * in that case.
>  	 */
>  	if (pci_dev_msi_enabled(pdev))
>  		return;
> =20
>  	ret =3D pci_enable_device(pdev);
>  	if (ret) {
>  		SLOT_WARN(php_slot, "Error %d enabling device\n", ret);
>  		return;
>  	}

[Severity: High]
This is a pre-existing issue, but does this leak the enable_cnt refcount?

pci_enable_device(pdev) increments the device's enable count. If the
subsequent IRQ initialization steps fail, this function returns without
calling pci_disable_device().

Additionally, during normal slot teardown, pnv_php_disable_irq() is called
with disable_device =3D false, meaning pci_disable_device() is skipped duri=
ng
hot-unplug. This would permanently prevent the device from entering low-pow=
er
states and block clean driver unbinding.

Is there a missing pci_disable_device() in the error paths and unplug flow?

While reviewing this code, I also noticed a few other pre-existing issues in
this file:

drivers/pci/hotplug/pnv_php.c:pnv_php_reset_slot() {
    ...
	/*
	 * The CAPI folks want pnv_php to drive OpenCAPI slots
	 * which don't have a bridge. Only claim to support
	 * reset_slot() if we have a bridge device (for now...)
	 */
	if (probe)
		return !bridge;
    ...
}

[Severity: Medium]
This is a pre-existing issue, but does returning 1 here abort the PCI reset
method discovery loop prematurely?

The PCI core's __pci_reset_function_locked() expects -ENOTTY to indicate a
reset method is unsupported. When !bridge evaluates to 1, the PCI core sees
rc !=3D -ENOTTY and aborts the entire loop, which prevents falling back to
other reset methods like FLR or PM reset.

---

drivers/pci/hotplug/pnv_php.c:pnv_php_alloc_slot() {
    ...
	if (!php_slot->wq) {
		SLOT_WARN(php_slot, "Cannot alloc workqueue\n");
		goto free_id;
	}
    ...
}

[Severity: High]
This is a pre-existing issue, but could this SLOT_WARN cause a NULL pointer
dereference?

The php_slot structure is zero-initialized on allocation. If
alloc_workqueue() fails, SLOT_WARN evaluates php_slot->pdev (which is NULL)
and takes the false branch to use &php_slot->bus->dev.

However, php_slot->bus has not been assigned yet. Computing &(NULL)->dev
yields an invalid pointer offset that is passed to the underlying dev_warn()
function, which will crash when it attempts to dereference it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527180816.2749=
186-1-adityag@linux.ibm.com?part=3D1
