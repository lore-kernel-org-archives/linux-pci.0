Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794529582;
	b=QnMrDk3JGL1R7aYDCqMcq2EFi+8V66WI89LZiSx5ibccI3M/Bn3F6YtqZWyWCuUSbLoE
	 7bd0VVzeLWJDw+0dOD0HrKgKNVgfP8HYKDpZjKn6gPggd66/bbFoqvo+cnV5mx/Ea5NgR
	 zre+q9toZWWgk+Xtwx1bDOPvVgo4w3to73QN4tMSUx7kOpWkn/L7m1S4SxRoIC81c0cuU
	 hspt9FtALGq0ZklSK87MMBaBC4p4Ql1d31gWdJTzmU+imgRUv6mlnAPbemA5xv1YyKLjn
	 u3jttWb6L/G7TvA5Bt/ZE94deBtKWP0xxPbbJZkR4I90HkhbJidnFDvCP+4U8LzY7cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794529582;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xB0wHtJLho/hI1TK4pgDO/Y/7cPOsuXpf5q0g5awPCY=;
	b=okCGn2XO5BcOMJswl4YWyTiHC1pRXikWCzDDaIQ/+cL2QKuEudHxWiXu97uGIe3O0Fum
	 L7QPJlYS6ZwyBUSK1EsveF08oCP2SigwDpUY8aXAAmB6JUOBCBgaIPkf9VtKp9e6gpGsG
	 8Skb8MhrSR6dBi+heIWabRIgGyf0a4+moCbeIwGp6QMHfKVgV9eM5l915kmuZZf+Qv0KR
	 PyTq+2cde+73sThpENBBOt7pdaa5pk1RR/0VnOkXGxQ7nziS1gRqFCln1h4xRHH9zxiI+
	 9yeSGbat2qDKp1MLNN+xfmLE4JA1i8YkEKeZFR6373ZpVJv1i7qcQng85M8y3zF83Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C7o6XSnt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F1D606A32A;
	Fri, 13 Nov 2026 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C7o6XSnt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1231F000C4;
	Fri, 13 Nov 2026 00:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794529581;
	bh=xB0wHtJLho/hI1TK4pgDO/Y/7cPOsuXpf5q0g5awPCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C7o6XSntRT4ASi0P0XxS023aAgW0lyzpzZwyNJFt13D6giiGlX4Mfx0woIMu/TM+Q
	 fSx0VolJpyy9H8xl9DRkqwnXeR406Q7VBLeojN8vpbqQrl2tunjTDpv4FLJh+ciVDq
	 NqsDs7ZWtBsJcM4vYKVlwJEco5FfGY6BFA5T8p1js+DdMwat6WYnFWQ04vgi37YJ76
	 6NvDmtyA2DsFzQy0AgdM7A7vyrkFhQH4FvPEAoe5H7jXf0uBByHqAojMqy6J0jKoN1
	 2qDa1RB6zZg34GwTjI9XhutXMPmp9BnAumS5oxJYTMskrRa0YsLdrM3mO3EoSYfqlM
	 qDGlWgn8n5qaA==
Message-ID: <sashiko-outbox-211997@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vfio/pci: Only lock the upstream bridge if the reset
 may need it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samiullah Khawaja" <skhawaja@google.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261112235700.2029562-1-skhawaja@google.com>
References: <20261112235700.2029562-1-skhawaja@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 00:26:21 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] PCI: pci_reset_needs_bridge_lock() is true for VFs behind CXL
  ports
- [Medium] PCI: pci_reset_needs_bridge_lock() is true for VFs on hotplug
  slots
It also noticed 2 related pre-existing issues this patch does not
introduce:
- [Medium] PCI: incomplete sibling check in cxl_reset_bus_function() [1]
- [Critical] vfio/pci: double free in vfio_pci_set_power_state() [2]
--

commit 5344c77aa429b69701e7ba84d963f4e63e1dda8b
Author: Samiullah Khawaja <skhawaja@google.com>

vfio/pci: Only lock the upstream bridge if the reset may need it

This commit adds pci_reset_needs_bridge_lock() to check whether a device has
a bus reset method enabled, and updates vfio_pci_core_disable() to only lock
the upstream bridge when a bus reset may be used.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c6f2aba81443..c44e4d4d87743 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5256,6 +5256,34 @@ int __pci_reset_function_locked(struct pci_dev *de=
v)
>  }
>  EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
> =20
> +/**
> + * pci_reset_needs_bridge_lock - check whether a reset of @dev may need =
the
> + * upstream bridge to be locked
> + * @dev: PCI device to check
> + *
> + * A bus reset of @dev is done through its upstream bridge, so the calle=
r must
> + * hold the bridge lock. The other reset methods only access @dev itself.
> + *
> + * Return: true if any of the reset methods enabled for @dev is a bus re=
set.
> + */
> +bool pci_reset_needs_bridge_lock(struct pci_dev *dev)
> +{
> +	int i, m;
> +
> +	for (i =3D 0; i < PCI_NUM_RESET_METHODS; i++) {
> +		m =3D dev->reset_methods[i];
> +		if (!m)
> +			break;
> +
> +		if (pci_reset_fn_methods[m].reset_fn =3D=3D pci_reset_bus_function ||

[Severity: Medium]
Does pci_reset_needs_bridge_lock() still return true for VFs on hotplug
slots, leaving concurrent VF resets broken on hotplug-capable ports?

When pci_iov_add_virtfn() creates a VF on a bus with a hotplug slot (such as
pciehp with PCI_SLOT_ALL_DEVICES), pci_setup_device() assigns virtfn->slot
and virtfn->multifunction is cleared to 0 before pci_init_reset_methods()
runs.  During probing, pci_reset_bus_function() calls
pci_dev_reset_slot_function() before pci_parent_bus_reset():

drivers/pci/pci.c:pci_dev_reset_slot_function() {
	if (dev->subordinate || !dev->slot ||
	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
	    (dev->multifunction && !dev->slot->per_func_slot))
		return -ENOTTY;

	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
}

Because pci_dev_reset_slot_function() returns 0, pci_reset_bus_function is
recorded in virtfn->reset_methods[] behind pcie_reset_flr (and similarly for
a single-function PF probed before VFs are enabled).  Checking all entries
in dev->reset_methods[] causes pci_reset_needs_bridge_lock() to return true
even though __pci_reset_function_locked() will use pcie_reset_flr first, so
concurrent vfio_pci_core_disable() calls still contend on the bridge trylock
and skip the FLR.

> +		    pci_reset_fn_methods[m].reset_fn =3D=3D cxl_reset_bus_function)

[Severity: Medium]
This problem wasn't introduced by this patch, but cxl_reset_bus_function()
[1] returns 0 on probe without checking whether sibling devices on the
bus prevent a bus reset:

drivers/pci/pci.c:cxl_reset_bus_function() {
	...
	dvsec =3D cxl_port_dvsec(bridge);
	if (!dvsec)
		return -ENOTTY;

	if (probe)
		return 0;
	...
	rc =3D pci_reset_bus_function(dev, probe);
}

During probing, returning 0 before calling pci_reset_bus_function() bypasses
the sibling checks in pci_dev_reset_slot_function() and
pci_parent_bus_reset().  For a CXL VF or a device sharing a bus, the PCI
core records cxl_reset_bus_function as supported, but when the reset is
later executed with probe =3D=3D false, pci_reset_bus_function() fails with
-ENOTTY.

> +			return true;
> +	}

[Severity: Medium]
Will pci_reset_needs_bridge_lock() also always return true for VFs behind a
CXL-capable upstream port?

In cxl_reset_bus_function(), pci_upstream_bridge() resolves a VF to its PF's
upstream bridge via pci_physfn(), and if that bridge has a CXL Port DVSEC,
the probe path immediately returns 0.  Every VF behind such a port therefore
has cxl_reset_bus_function in dev->reset_methods[] (behind pcie_reset_flr),
so pci_reset_needs_bridge_lock() returns true and concurrent
vfio_pci_core_disable() calls on those VFs still fail pci_dev_trylock() on
the shared bridge and skip the reset.

[ ... ]

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index fcbb2da860e2a..ba3dfdadae399 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -777,7 +777,8 @@ void vfio_pci_core_disable(struct vfio_pci_core_devic=
e *vdev)
>  	 * overwrite the previously restored configuration information.
>  	 */
>  	if (vdev->reset_works) {
> -		bridge =3D pci_upstream_bridge(pdev);
> +		bridge =3D pci_reset_needs_bridge_lock(pdev) ?
> +			 pci_upstream_bridge(pdev) : NULL;
>  		if (bridge && !pci_dev_trylock(bridge))
>  			goto out_restore_state;
>  		if (pci_dev_trylock(pdev)) {

[Severity: Critical]
This problem wasn't introduced by this patch, but vfio_pci_core_disable()
[2] calls vfio_pci_set_power_state(vdev, PCI_D0) without holding
vdev->memory_lock, which can race with another path transitioning the device
to D0 and cause a use-after-free and double free of vdev->pm_save:

CPU0                                  CPU1
vfio_pci_core_iotcl() / config write  vfio_pci_core_disable()
  down_write(&vdev->memory_lock)
  vfio_pci_set_power_state(..., D0)
                                        vfio_pci_set_power_state(..., D0)
    needs_restore =3D true
                                          needs_restore =3D true
    pci_set_power_state()
                                          pci_set_power_state()
    pci_load_and_free_saved_state(
      &vdev->pm_save)
                                          pci_load_and_free_saved_state(
                                            &vdev->pm_save)
                                            <-- use-after-free / double free

When the device is in D3hot, both threads see pdev->current_state >=3D
PCI_D3hot before the state is updated, so both set needs_restore =3D true a=
nd
call pci_load_and_free_saved_state(&vdev->pm_save) concurrently.

[1] https://sashiko.dev/#/bug/linux-f16fb8bb-75c3-4e2c-af09-9d033af32bc8
[2] https://sashiko.dev/#/bug/linux-d67caf72-8141-4778-be9b-75a34618f8f7

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112235700.2029=
562-1-skhawaja@google.com?part=3D1
