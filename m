Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495986;
	b=jzTRmc+WmHRD7OAKv24nsOZG/TTgY2QDDFv74X0wxNXJf65StEOXa8B0lCiwPr2eUXNm
	 k1VS0oljmJbUBZV3U7kj6oKXh7XZ5c2z+l13Eq37D59DX2vd7vfnbTJTiw10cYcdYsUfN
	 IW+j+27iSVjwE6nfqBEH0xCNuizZyKnnXGLTday2BzRs6WKRiHI+iKA6xFWKE025sn929
	 hYwX31kDCbleXTXjcyJyWvdxnHq2MMrEaKWByEan9Ma75IbjrqeoKc3I1xbBMO7UC87P8
	 XmZDfKby5QpODucgiK8EOdIiBkdmD5kFbgR4nJqLXL0ZzlYA6JtykMN0hdJmzdFOruA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495986;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hyy1pqhW3yzD62HRZTzYsRoU0HqVbeNhJp8+kBt+TII=;
	b=MXpKkx6G/CaVcG8GquR1yde2Xcqi9mFs5ZdhZlXuHkcN/xF/yERmKemMsnSuH2X36vJX
	 tMFhP8yuVuESnyWHEKOVzQ9xTd+6QKcKZJQwu5XzkXikx+0Q05lLwHIAA5HnF4f3Cihww
	 dVxoiUESy3w07Cs0V1oQZOlmipy3Xy3AnPF0ViI0odZ/gBPQQP6nMHNy5bWdBpZOCHFbx
	 OPeJxdjh8FtoJSBjgkX32iXXCW4Lvs+DhRvVi+IP+c8QUSKSOF/mB9l7otChW/TU4dYIJ
	 pGguItZEZn+oAyDErXBPykXDO5EK8+jXCKx2+Ik8/ULTM4p93AjFaVQlQ2ppW24FzYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+Yk2l9N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6C2606A327;
	Thu, 12 Nov 2026 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+Yk2l9N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AB61F00A05;
	Thu, 12 Nov 2026 15:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794495985;
	bh=hyy1pqhW3yzD62HRZTzYsRoU0HqVbeNhJp8+kBt+TII=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=j+Yk2l9N2kbXXwPSJZLmtrg+CQQON9vy/h1NoFF4kkcthz6Ei8nykI8W2aXjD23wM
	 A+qgNvds2e+9Qx+hpqQ8otllITWcli+pwp/CdSB5JQgVBrstGfdgFFxO4rA1luHCfT
	 GwVz6luULmj3e+l+8U4YhMQm/sGrNAnJ2kxeTWVMrImOdYsRDVyE2YaIXlRKSiEfQI
	 yDbvYlcC+mXEDTf+fnyeehnZDJm5Tj4yJKs7LMkAbqYNKJzBX7PmU1w355uflMutD5
	 xaheXkyLKWFetMSHi92B271OLMU++77TG2UpADTovvIReQTyK/Tag/e9ynqzotB80J
	 mozAtg/4u24/g==
Message-ID: <sashiko-outbox-211399@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 18/20] vfio/pci: Block device access during host
 recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>, kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261112141632.918954-19-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
 <20261112141632.918954-19-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 15:06:25 +0000
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
- [High] vfio/pci: unrestored BARs after bus reset when recovery fails
  in err_detected()
- [Medium] vfio/pci: TOCTOU race on pci_recovery_host_active during
  device open
- [Medium] vfio/pci: close during host recovery races with bus reset and
  loses saved state
- [Medium] vfio/pci: close clears device_open before blocking PM config
  restore
- [Low] vfio/pci: dead !device_open check in
  vfio_pci_core_aer_err_detected()
--

commit f9997001c74d4f1e906c8a9ec79cb059867865ef
Author: Shameer Kolothum <skolothumtho@nvidia.com>

vfio/pci: Block device access during host recovery

This commit blocks userspace and asynchronous VFIO device access during
host PCI error recovery in vfio_pci_core_aer_err_detected(), coordinates
blocked power-state and INTx handling with memory_lock and irqlock, and
rejects device open while host recovery is active.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 09923a48a5470..5e9451e082630 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c

[ ... ]

> @@ -410,10 +414,17 @@ static void vfio_pci_core_block_access(struct vfio_=
pci_core_device *vdev)
>  	unsigned long flags;
> =20
>  	lockdep_assert_held(&vdev->access_lock);
> +	/*
> +	 * Finish live PM restoration before blocked INTx handlers can mask the
> +	 * device. Otherwise an old restore can undo their hardware mask.
> +	 */
> +	down_write(&vdev->memory_lock);
>  	spin_lock_irqsave(&vdev->irqlock, flags);
>  	rcu_assign_pointer(vdev->access_ops, &vfio_pci_blocked_ops);
>  	spin_unlock_irqrestore(&vdev->irqlock, flags);
> +	up_write(&vdev->memory_lock);
> =20
> +	/* SRCU readers may need memory_lock to finish. */
>  	synchronize_srcu(&vdev->access_srcu);
>  }

[Severity: Medium]
Does clearing vdev->device_open before calling vfio_pci_core_block_access()
in vfio_pci_core_close_device() defeat this protection against PM config
restoration unmasking INTx?

In __vfio_pci_set_power_state(), D3hot-to-D0 restoration bypasses
access_ops->restore_config() as soon as vdev->device_open is false:

drivers/vfio/pci/vfio_pci_core.c:__vfio_pci_set_power_state() {
    ...
		} else if (needs_restore) {
			pci_load_and_free_saved_state(pdev, &vdev->pm_save);
			/* Open and close restore state without reopening access. */
			if (!READ_ONCE(vdev->device_open))
				pci_restore_state(pdev);
			else
				vfio_pci_access_ops(vdev)->restore_config(vdev);
		}
    ...
}

If a NoSoftRst- PCI 2.3 device entered D3hot while INTx was unmasked
(saving unmasked PCI_COMMAND in vdev->pm_save) and then had INTx masked by
recovery, both an in-flight runtime PM transition holding memory_lock when
vfio_pci_core_close_device() clears vdev->device_open and the subsequent
vfio_pci_set_power_state(vdev, PCI_D0) at the start of
vfio_pci_core_disable() take the pci_restore_state(pdev) branch.  That
restores the unmasked PCI_COMMAND in hardware while ctx->masked is still
true and the IRQ handler is still registered, so a level-triggered INTx
assertion before vfio_pci_set_irqs_ioctl() runs sees ctx->masked =3D=3D tru=
e in
vfio_pci_intx_mask_for_recovery() and returns IRQ_NONE without masking the
shared interrupt line.

> @@ -756,6 +767,16 @@ int vfio_pci_core_enable(struct vfio_pci_core_device=
 *vdev)
>  	u16 cmd;
>  	u8 msix_pos;
> =20
> +	if (vdev->pci_recovery_supported) {
> +		if (pci_dev_is_disconnected(pdev))
> +			return -ENODEV;
> +		mutex_lock(&vdev->access_lock);
> +		ret =3D vdev->pci_recovery_host_active ? -EBUSY : 0;
> +		mutex_unlock(&vdev->access_lock);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (!vdev->disable_idle_d3) {

[Severity: Medium]
Can host recovery start after vfio_pci_core_enable() drops
vdev->access_lock and still allow vfio_pci_core_finish_enable() to publish
live access?

CPU0                                    CPU1
vfio_pci_core_enable()
  mutex_lock(&vdev->access_lock)
  /* pci_recovery_host_active is false */
  mutex_unlock(&vdev->access_lock)
                                        pcie_do_recovery()
                                          vfio_pci_core_aer_err_detected()
                                            mutex_lock(&vdev->access_lock)
                                            vdev->pci_recovery_host_active =
=3D true
                                            /* !pci_recovery_enabled */
                                            mutex_unlock(&vdev->access_lock)
                                          reset_subordinates()
  pci_save_state(pdev)
  vfio_config_init(vdev)
vfio_pci_core_finish_enable()
  mutex_lock(&vdev->access_lock)
  WRITE_ONCE(vdev->device_open, true)
  rcu_assign_pointer(vdev->access_ops,
                     &vfio_pci_live_ops) <-- live access while recovery runs

Because vfio_pci_core_enable() runs without device_lock(&pdev->dev) held
across enablement and vfio_pci_core_finish_enable() does not re-check
vdev->pci_recovery_host_active or pci_dev_is_disconnected(pdev), the open
succeeds while host recovery is active, vdev->pci_saved_state and
vdev->rbar[] can capture corrupted or post-reset BAR values, and
vfio_pci_core_aer_slot_reset() skips state restoration because
VFIO_PCI_RECOVERY_IN_PROGRESS was never set.

> @@ -999,6 +1020,10 @@ void vfio_pci_core_close_device(struct vfio_device =
*core_vdev)
>  			WRITE_ONCE(vdev->device_open, false);
>  			vfio_pci_core_block_access(vdev);
>  			WRITE_ONCE(vdev->pci_recovery_flags, 0);
> +			/* Discard pending D0 before the next open. */
> +			down_write(&vdev->memory_lock);
> +			vdev->power_up_pending =3D false;
> +			up_write(&vdev->memory_lock);
>  		}
>  	}

[Severity: Medium]
What happens if userspace closes the device after
vfio_pci_core_aer_err_detected() signals err_trigger, while
pcie_do_recovery() is resetting the bus?

CPU0                                    CPU1
pcie_do_recovery()
  vfio_pci_core_aer_err_detected()
    /* returns NEED_RESET */
                                        vfio_pci_core_close_device()
                                          WRITE_ONCE(vdev->device_open, fal=
se)
                                          WRITE_ONCE(vdev->pci_recovery_fla=
gs, 0)
                                          vfio_pci_core_disable()
                                            pci_load_and_free_saved_state(
                                                pdev, &vdev->pci_saved_stat=
e)
                                            pci_restore_state(pdev)
  reset_subordinates()
    /* resets bus, wiping BARs */
  vfio_pci_core_aer_slot_reset()
    /* !device_open -> returns NONE */  <-- BARs left zeroed in hardware

pcie_do_recovery() drops device_lock(&pdev->dev) between error_detected()
and slot_reset().  If vfio_pci_core_disable() consumes and frees
vdev->pci_saved_state before reset_subordinates() finishes resetting the
secondary bus without restoring config space, vfio_pci_core_aer_slot_reset()
sees !vdev->device_open and returns early, leaving the hardware BARs zeroed
for the next open.  If close instead runs just after reset_subordinates()
wipes the BARs, vfio_pci_core_disable() tears down MSI-X in
vfio_pci_set_irqs_ioctl() before restoring vdev->pci_saved_state.

> @@ -2660,17 +2685,142 @@ void vfio_pci_core_unregister_device(struct vfio=
_pci_core_device *vdev)

[ ... ]

> +	mutex_lock(&vdev->access_lock);
> +	/*
> +	 * Track host recovery even without userspace opt-in so open can reject
> +	 * attempts while recovery is running.
> +	 */
> +	vdev->pci_recovery_host_active =3D
> +		state !=3D pci_channel_io_perm_failure;
> +	if (!vdev->pci_recovery_enabled)
> +		goto out_unlock;
> +
> +	/* Keep failed devices blocked until close. */
> +	if (vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_FAILED) {
> +		result =3D PCI_ERS_RESULT_NONE;
> +		goto out_unlock;
> +	}
> +
> +	if (!vdev->device_open) {
> +		result =3D PCI_ERS_RESULT_NONE;
> +		goto out_unlock;
> +	}

[Severity: Low]
Can the !vdev->device_open check ever be reached here?

Under vdev->access_lock, vdev->pci_recovery_enabled is only set when
vdev->device_open is true and is cleared alongside vdev->device_open in
vfio_pci_core_close_device(), so !vdev->pci_recovery_enabled always
branches to out_unlock first (returning PCI_ERS_RESULT_CAN_RECOVER rather
than PCI_ERS_RESULT_NONE when the device is closed).

> +
> +	vfio_pci_core_block_access(vdev);

[ ... ]

> +	if (!ret && !vdev->pci_2_3 && !nested)
> +		ret =3D vfio_pci_recovery_save_and_clear_master(vdev, 0);
> =20
> +	if (ret) {
> +		flags |=3D VFIO_PCI_RECOVERY_FAILED;
> +		flags &=3D ~VFIO_PCI_RECOVERY_IN_PROGRESS;
> +		result =3D PCI_ERS_RESULT_NONE;
> +	} else {
> +		flags |=3D VFIO_PCI_RECOVERY_IN_PROGRESS;
> +	}
> +	WRITE_ONCE(vdev->pci_recovery_flags, flags);

[Severity: High]
If recovery fails in vfio_pci_core_aer_err_detected() (or
VFIO_PCI_RECOVERY_FAILED is already set on a subsequent frozen-channel
error) and pcie_do_recovery() still resets the subordinate bus, will the
device's BARs be left zeroed when vfio_pci_core_disable() later tears down
MSI-X?

Clearing VFIO_PCI_RECOVERY_IN_PROGRESS and returning PCI_ERS_RESULT_NONE
allows pcie_do_recovery() to proceed with reset_subordinates() when a
sibling device requests PCI_ERS_RESULT_NEED_RESET or when state is
pci_channel_io_frozen, wiping this device's BARs in hardware.  Because
VFIO_PCI_RECOVERY_IN_PROGRESS is not set, vfio_pci_core_aer_slot_reset()
returns early without calling vfio_pci_recovery_restore_state() or tearing
down IRQs:

drivers/vfio/pci/vfio_pci_core.c:vfio_pci_core_aer_slot_reset() {
	mutex_lock(&vdev->access_lock);
	if (!(vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_IN_PROGRESS) ||
	    !vdev->device_open) {
		mutex_unlock(&vdev->access_lock);
		return PCI_ERS_RESULT_NONE;
	}
    ...
}

When userspace later closes the device, vfio_pci_core_disable() calls
vfio_pci_set_irqs_ioctl() -> vfio_msi_disable() before loading
vdev->pci_saved_state, which enables PCI_COMMAND_MEMORY via
vfio_pci_memory_lock_and_enable() and writes to the MSI-X table while the
hardware BARs are still 0x00000000.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141632.9189=
54-1-skolothumtho@nvidia.com?part=3D18
