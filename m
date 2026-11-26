Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795683172;
	b=kFBeP2Scd0u2SiaM129NI8LZ2Y4Ts+QqDLD5N5XgGhey+qrALBEXDoUJ7UaquHiTSofu
	 Td/Y//mR6F1YkPkWGXtF5xpE6xsWHwUXMpt6A+mHuzOlvAcuuL0uxAGbrZpZVqJkh4cic
	 PpclxcmTkr0Y45juaM8y1vyzc29THC43SRPVEGPX/HA/2vBVea/2Ib1+uN8yn+YNUtv6h
	 Nmb+piZYnlKFcWAvwXMhjZ3mEuSNrGo2m8QnbQIWqpO/u2tEtbw0rpXxHHb54sfdkh9pw
	 e/cKbUp+Mxk9R3oEUnsV3XY1cH5xrb3eP0f9fBf3+zV0wUtPDcf9gQj5mKdXEr40m6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683172;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G8xdJVOXWIjBcn5B/KjyQFUEoa5+bVKjFieT26OhAJU=;
	b=N4AeNyo6HlAZ/xkKbdkjQ7PiyAzaX8YGJ4DyP60PHNdOS4LNHsI3ODxF8U3Swe+H2yH9
	 7EeeQt6bI1dbwGXEsbE/ox/FEFQqeqz96hR+c0HIpD0jadQmQlke97BIWJM8+7jTgX1NQ
	 tkryQb7jBxiZMQe2l7hx9ienvj8rImHQ3Qf6UUMTei380tBUTNh/hdnoOEm6Wbr2Zad07
	 vZf61heW7M2iz1urI5DqTPm9p7xYHjWpbpEp1i3TmZcHllMABHMgWftGstqw+sKgCOeK7
	 AnotflEKiDcK9Z0d+kpefc0OeszF0vpHcMc+KTiVgEkIqRXsesgcvC2zsZhg/HA6VLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=naa7mDAD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA10606A31E
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=naa7mDAD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BB11F000C0;
	Thu, 26 Nov 2026 08:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795683172;
	bh=G8xdJVOXWIjBcn5B/KjyQFUEoa5+bVKjFieT26OhAJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=naa7mDADin+ET6TAcdq4QyROyho74SayIl0s6onjUjQ6Xr3lQnLUB2krjwzAMwqtJ
	 kifEPVNAPbfeLw0wKIbscrXD3BQ6MZ83K1bKpXCpWIQFzGA6P2LIP/Ex0dOwx68zix
	 MR43Tg/vyCuwwrG6TRFucvlXqoF5ZIq4KzGO8VgK+HNkSbmhvTA4sv3sxM9ZG0PQBF
	 oy8DjUFgjROwikTa7WkZsD/HWfQr8ET+JswVPr6OrcJ3OYpwLPWXXaETLAU3XuAsSQ
	 kfpNKjuj4YcEF4khScvbmhF+raDmzcZ77iM6Un3ajT4ZOZZ/z2w8cfmdKqkEdYcR7u
	 tuTC2XkalfvcQ==
Message-ID: <sashiko-outbox-235061@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2] PCI: pciehp: Fix AB-BA deadlocks between
 reset_lock, pci_rescan_remove_lock and pci_slot_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiang Yu" <qiang.yu@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261126-fix_deadlock_1126-v2-1-c0ed50bc7b04@oss.qualcomm.com>
References: <20261126-fix_deadlock_1126-v2-1-c0ed50bc7b04@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 08:52:51 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] PCI: self-deadlock on pci_rescan_remove_lock in
  pci_reset_bridge() on EEH
- [High] PCI: self-deadlock in pci_reset_bus() from pci_fixup_final GPU
  reset quirk
- [High] PCI: deadlock between pci_reset_bus() and VFIO dev_set->lock or
  device close
- [High] PCI: AB-BA deadlocks in r8169 and mlx5 from blocking lock in
  pci_reset_bus()
- [Medium] PCI: AB-BA lock inversion between sysfs kn->active and
  pci_rescan_remove_lock
--

commit 7491161cc2c0678f53562522b13cdb8a3d4bfd7d
Author: Qiang Yu <qiang.yu@oss.qualcomm.com>

PCI: pciehp: Fix AB-BA deadlocks between reset_lock, pci_rescan_remove_lock=
 and pci_slot_mutex

This commit drops ctrl->reset_lock across device enumeration and removal in
pciehp and serializes secondary bus resets in pci_reset_bridge() and
pci_reset_bus() with pci_rescan_remove_lock.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c6f2aba81443..211808f7bd1f6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5750,6 +5750,13 @@ static int pci_reset_bridge(struct pci_dev *bridge=
, bool restore)
>  	if (!bus)
>  		return -ENOTTY;
> =20
> +	/*
> +	 * The reset below may issue a Secondary Bus Reset, which races with
> +	 * pciehp enumerating a newly inserted device. Serialize via
> +	 * pci_rescan_remove_lock; callers must not already hold it.
> +	 */
> +	lockdep_assert_not_held(&pci_rescan_remove_lock);
> +	pci_lock_rescan_remove();
>  	mutex_lock(&pci_slot_mutex);
>  	if (list_empty(&bus->slots))
>  		goto bus_reset;

[Severity: High]
Does taking pci_rescan_remove_lock in pci_reset_bridge() self-deadlock
during PowerPC EEH error recovery?

eeh_handle_normal_event() acquires pci_lock_rescan_remove() at entry and
holds it while resetting the frozen PE:

  eeh_handle_normal_event()
    pci_lock_rescan_remove()
    eeh_reset_device()
      eeh_pe_reset_full()
        eeh_pe_reset()
          pnv_eeh_reset()
            pci_bus_error_reset()
              pci_reset_bridge()
                lockdep_assert_not_held(&pci_rescan_remove_lock)
                pci_lock_rescan_remove()  <-- self-deadlock

When a non-PHB, non-VF PE on a non-root bus undergoes a hot reset on
PowerNV, the EEH recovery thread wedges permanently on
pci_rescan_remove_lock and blocks all subsequent PCI hotplug, rescan and
removal operations.

[Severity: Medium]
Does acquiring pci_rescan_remove_lock in pci_reset_bridge() also invert the
lock order against the sysfs active reference (kn->active) for
reset_subordinate?

Writing to a bridge's reset_subordinate sysfs attribute runs
reset_subordinate_store() without calling sysfs_break_active_protection(),
while concurrent removal of that bridge or an ancestor holds
pci_rescan_remove_lock and waits for the attribute's kn->active to drain:

CPU0                              CPU1
----                              ----
                                  pciehp_unconfigure_device()
                                    pci_lock_rescan_remove()
reset_subordinate_store()           ...
  /* holds kn->active */              device_del(&pdev->dev)
  pci_try_reset_bridge()                ...
    pci_reset_bridge()                    kernfs_drain()
      pci_lock_rescan_remove()              /* waits for kn->active */

 *** DEADLOCK ***

The same kn->active -> pci_rescan_remove_lock inversion occurs in
lpfc_board_mode_store() -> lpfc_reset_pci_bus() -> pci_reset_bus().

[ ... ]

> @@ -5805,19 +5816,62 @@ int pci_probe_reset_bus(struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
> =20
> +/*
> + * Core of pci_reset_bus(), run with pci_rescan_remove_lock already held=
 or
> + * known not to be needed.  See pci_reset_bus_unlocked() for the latter =
case.
> + */
> +static int __pci_reset_bus(struct pci_dev *pdev)
> +{
> +	return (!pci_probe_reset_slot(pdev->slot)) ?
> +	    pci_try_reset_slot(pdev->slot) : pci_try_reset_bus(pdev->bus);
> +}
> +
>  /**
>   * pci_reset_bus - Try to reset a PCI bus
>   * @pdev: top level PCI device to reset via slot/bus
>   *
> - * Same as above except return -EAGAIN if the bus cannot be locked
> + * Same as above except this blocks until pci_rescan_remove_lock can be
> + * acquired, and still returns -EAGAIN if the underlying slot/bus device
> + * lock cannot be taken.
>   */
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
> +
> +	rc =3D __pci_reset_bus(pdev);
> +
> +	pci_unlock_rescan_remove();
> +
> +	return rc;
>  }
>  EXPORT_SYMBOL_GPL(pci_reset_bus);

[Severity: High]
Can pci_reset_bus() self-deadlock when called from
quirk_reset_lenovo_thinkpad_p50_nvgpu()?

quirk_reset_lenovo_thinkpad_p50_nvgpu() is a DECLARE_PCI_FIXUP_CLASS_FINAL
quirk that calls pci_reset_bus(pdev):

drivers/pci/quirks.c:quirk_reset_lenovo_thinkpad_p50_nvgpu() {
    ...
	if (ioread32(map + 0x2240c) & 0x2) {
		pci_info(pdev, FW_BUG "GPU left initialized by EFI, resetting\n");
		ret =3D pci_reset_bus(pdev);
    ...
}

After boot, pci_bus_add_devices() -> pci_bus_add_device() runs final fixups
while callers such as pci_rescan_bus() or pciehp_configure_device() already
hold pci_rescan_remove_lock:

  pci_rescan_bus()
    pci_lock_rescan_remove()
    pci_bus_add_devices()
      pci_bus_add_device()
        pci_fixup_device(pci_fixup_final, dev)
          quirk_reset_lenovo_thinkpad_p50_nvgpu()
            pci_reset_bus()
              pci_lock_rescan_remove()  <-- self-deadlock

Should quirk_reset_lenovo_thinkpad_p50_nvgpu() call
pci_reset_bus_unlocked(pdev) like vmd_enable_domain()?

[Severity: High]
Does blocking on pci_rescan_remove_lock in pci_reset_bus() deadlock when an
open VFIO PCI device is hot-unplugged or removed via sysfs?

Previously, pci_reset_bus() only attempted non-blocking
pci_slot_trylock()/pci_bus_trylock() calls and returned -EAGAIN if a removal
thread held device_lock(&pdev->dev).  When a VFIO device is removed while
still open, vfio_unregister_group_dev() holds pci_rescan_remove_lock and
device_lock(&pdev->dev) while waiting for userspace to close the device fd
and complete device->comp.  Closing the fd runs vfio_pci_core_disable(),
where pci_dev_trylock(pdev) fails and falls back to
vfio_pci_dev_set_try_reset() -> pci_reset_bus(pdev) before device->comp is
signaled:

CPU0                                CPU1
----                                ----
pciehp_unconfigure_device()
  pci_lock_rescan_remove()
  pci_stop_and_remove_bus_device()
    ...
      device_lock(&pdev->dev)
      vfio_pci_remove()
        ...
          vfio_unregister_group_dev()
            /* waits on device->comp */
                                    vfio_device_fops_release()
                                      ...
                                        vfio_pci_core_disable()
                                          /* pci_dev_trylock() fails */
                                          vfio_pci_dev_set_try_reset()
                                            pci_reset_bus()
                                              pci_lock_rescan_remove()

 *** DEADLOCK ***

In addition, both vfio_pci_dev_set_try_reset() and
vfio_pci_dev_set_hot_reset() call pci_reset_bus() under dev_set->lock
(dev_set->lock -> pci_rescan_remove_lock), inverting the
pci_rescan_remove_lock -> dev_set->lock order taken by vfio_pci_probe() ->
vfio_assign_device_set() and vfio_pci_remove() -> vfio_release_device_set().

[Severity: High]
Does blocking on pci_rescan_remove_lock in pci_reset_bus() also deadlock
against workqueue flushing during device removal in r8169 and mlx5?

In r8169, when MMIO reads all-ones (such as on surprise removal), rtl_task()
calls pci_reset_bus(tp->pci_dev).  Meanwhile, hot-unplug or sysfs removal
holds pci_rescan_remove_lock and device_lock(&pdev->dev) and calls
rtl_remove_one(), waiting for rtl_task() to finish:

CPU0                                CPU1 (kworker)
----                                --------------
pciehp_unconfigure_device()
  pci_lock_rescan_remove()
  pci_stop_and_remove_bus_device()
    ...
      rtl_remove_one()
        disable_work_sync(&tp->wk.work)
                                    rtl_task()
                                      pci_reset_bus()
                                        pci_lock_rescan_remove()

 *** DEADLOCK ***

Before this change, pci_reset_bus() saw device_lock(&pdev->dev) held by
rtl_remove_one() and returned -EAGAIN immediately.  The same deadlock occurs
in mlx5 between remove_one() -> mlx5_drain_fw_reset() ( holding
pci_rescan_remove_lock) and the firmware reset work items calling
mlx5_pci_reset_bus() -> pci_reset_bus(), as well as an ABBA lock inversion
between devl_lock(devlink) in mlx5_devlink_reload_fw_activate() ->
mlx5_pci_reset_bus() and probe_one()/remove_one() acquiring
devl_lock(devlink) under pci_rescan_remove_lock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-fix_deadlo=
ck_1126-v2-1-c0ed50bc7b04@oss.qualcomm.com?part=3D1
