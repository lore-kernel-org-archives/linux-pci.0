Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F12E33ADB3
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787035960; cv=none; b=IzJHck9nzYyh4cn+wElglghTT6ktUwiwEY5xWmGyhVZl5lgtHIeWlqyUcMOSNnV1Tzkrz84GJIcfsiIngmSeTnpd+jXWpSMDA8pru5et4gKSIHOlsc6X9bCfvxo0szWuIrWYnSDDIB1ZfCLFq8c+dVJytzWx6iaYKEbXLoWXD0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787035960; c=relaxed/simple;
	bh=ba3dnO9aRlmMBCCfENFoBitnA4QkYrQpzi1sDIl5BkY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QndlOQ+qeIcIgwlMRIsHAAbhFvEkGDod44cLK1HjDoWbL8iW9XGWP7vOW7YShMiMjI/4lJjLxmo6VpM/gvn8JYdjSyWuPw1hejaUAiofozNE0I8p4e2Mb19LNzZ9Mcw3bs3WKQ0j0cYdq30bC80W1TAvWAvbyWX6bezfZTfeRQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fL5TSYKI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fL5TSYKI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7739B1F000E9;
	Tue, 18 Aug 2026 06:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787035958;
	bh=lRfXJ4XNibRDZSrVtl7paAkXbvkHS/82wU+X60zvfo4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fL5TSYKI1s5rcb+wEd9e1PCuyhwt+aSiFSVAn5fuXVmk+D6+2ln/4+FlXmjL8dtO5
	 FzAHZa4tVF1CN6oRzGimWKzhMWOaFTjQRS9lNPPGfKTF2RxQc+YFYEWIExxvmWOrJK
	 o42FGwLfeVN/zRzqZA/ix/fhGTcRprM0dLafisWQ/TEMa6bN/CJc8b4FCApYmjP3M1
	 hqKQ9JFU1rcMEWYEQZLBWxrt5aKdnhmjeoqIBv7KuDZ65LX90b/6ccQ0qbb2VUgjUl
	 AZB+4bZ05kphlLg5k9OFMDw2BH6/UDnzI1twFFCIOU9vOAKosEY5ijftBcIhVEXaQI
	 tKwoLM8gqsZVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] PCI: pciehp: Fix AB-BA deadlocks between
 reset_lock, pci_rescan_remove_lock and pci_slot_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiang Yu" <qiang.yu@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260817-ab-ba-deadlock-v1-1-e619fd07d1fd@oss.qualcomm.com>
References: <20260817-ab-ba-deadlock-v1-1-e619fd07d1fd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 06:52:37 +0000
Message-Id: <20260818065238.7739B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Self-deadlock in `pci_reset_bus()` due to unconditionally acquirin=
g `pci_rescan_remove_lock` during device enumeration.
- [High] AB-BA deadlock between `pci_rescan_remove_lock` and VFIO's `dev_se=
t->lock`.
--

--- Patch [1]: [PATCH RFC] PCI: pciehp: Fix AB-BA deadlocks between reset_l=
ock, pci_rescan_remove_lock and pci_slot_mutex ---
commit 0ee14af4875a74717aa4b029ffaaeebbfbfc90a8
Author: Qiang Yu <qiang.yu@oss.qualcomm.com>

PCI: pciehp: Fix AB-BA deadlocks between reset_lock, pci_rescan_remove_lock=
 and pci_slot_mutex

The commit attempts to fix deadlocks involving reset_lock and device_lock
during PCIe hotplug operations by releasing reset_lock across the rescan
and remove sections. It also modifies pci_reset_bridge() and pci_reset_bus()
to serialize with pci_rescan_remove_lock, while introducing an unlocked
variant pci_reset_bus_unlocked() for specific paths.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f80..9010741d032f7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> @@ -5759,19 +5770,62 @@ int pci_probe_reset_bus(struct pci_bus *bus)
>  int pci_reset_bus(struct pci_dev *pdev)
>  {
> -	return (!pci_probe_reset_slot(pdev->slot)) ?
> -	    pci_try_reset_slot(pdev->slot) : pci_try_reset_bus(pdev->bus);
> +	int rc;
> +
> +	/*
> +	 * pci_try_reset_slot()/pci_try_reset_bus() below may issue a
> +	 * Secondary Bus Reset, which races with concurrent bus scanning.
> +	 * Serialize against that via pci_rescan_remove_lock, taken before
> +	 * the slot's/bus's device locks to match the lock order used by
> +	 * pciehp.
> +	 */
> +	pci_lock_rescan_remove();

[Severity: High]
Does unconditionally acquiring pci_rescan_remove_lock here introduce a
self-deadlock during device enumeration?

pci_bus_add_devices() is called with pci_rescan_remove_lock held from paths
like pciehp_configure_device() or acpi_pci_root_add(). It synchronously
invokes pci_fixup_device(pci_fixup_final, dev) and driver probes.

If a newly added device triggers a final quirk (like
quirk_reset_lenovo_thinkpad_p50_nvgpu) or a driver probe that calls
pci_reset_bus(), it will attempt to acquire the non-recursive
pci_rescan_remove_lock again:

Thread 1
pciehp_configure_device()
  pci_lock_rescan_remove()
  pci_bus_add_devices()
    pci_bus_add_device()
      pci_fixup_device(pci_fixup_final, dev)
        quirk_reset_lenovo_thinkpad_p50_nvgpu()
          pci_reset_bus()
            pci_lock_rescan_remove() <--- Deadlock

[Severity: High]
Can this introduce an AB-BA deadlock between pci_rescan_remove_lock and VFI=
O's
dev_set->lock?

If a VFIO hot reset runs concurrently with a PCI hotplug event or driver bi=
nd:

Thread 1 (VFIO hot reset ioctl)
vfio_pci_dev_set_hot_reset()
  mutex_lock(&dev_set->lock)
  pci_reset_bus()
    pci_lock_rescan_remove() <--- Blocked on Thread 2

Thread 2 (PCI hotplug)
pciehp_configure_device()
  pci_lock_rescan_remove()
  pci_bus_add_devices()
    driver probe (vfio_pci_core_register_device)
      vfio_assign_device_set()
        mutex_lock(&dev_set->lock) <--- Blocked on Thread 1

> +
> +	rc =3D __pci_reset_bus(pdev);
> +
> +	pci_unlock_rescan_remove();
> +
> +	return rc;
>  }
>  EXPORT_SYMBOL_GPL(pci_reset_bus);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-ab-ba-dead=
lock-v1-1-e619fd07d1fd@oss.qualcomm.com?part=3D1
