Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E2E472062;
	Tue,  1 Sep 2026 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256704; cv=none; b=n/O9kbcrpX9RHpO9osc97noXG7wBUUG0Vfr4XrWwvJtkH/VbYkBmZtNyezGKMXvTo8Ow+YPB76e55uHZMLdpk9xxN1ULav94VxYk8AYEL05b5Etnc9iVhQYfnTzuq/OeN4d7GLE04nNCsVnBhuPdMP2PeD02SzLQ0YTcLJLkU70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256704; c=relaxed/simple;
	bh=BA5uRRL6FhmXPeP592alX20OYSFMr1gHt9KvHtVCXhY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SJDMehzrtAFZ6D8K/SN5Poax9e2Fy6X/c5w/s3qNoj7NF1M4tn/Rr63FD6iN6LdrZWjrTonXdUWztoknpf2qcR09fUbnsgdk0mifU6BRHq5RBlA2+jS80eKeissEYgYMo/YfbAtF6lR5yiyhZhCbuxNcskZrJ6Dl/1hUoq6jm3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bX8muoo9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bX8muoo9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173F81F00A3D;
	Tue,  1 Sep 2026 09:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788256702;
	bh=uH66L1CFFRuRMcRyQlRGAqL3rqo32Gk3s3FKWF5KV+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bX8muoo9wF793DMXwsn3ovZ4hy2bDffPXLdmk+C+vZp7erEZI90FLG7wQlWCAnaUE
	 boLS2vvPM5KkMDfv3xSfKeWN7TDeQwcdopQqNka44xy6VDgxgte8eyInMEZOdKhCDW
	 +src22u764Yb44SAMhxs0AwscIfixTnaGEXwv/aukd+IAeaitOHV8IBE3pgs/HZDiQ
	 C/rA/cBSY2ImQh8PNLzG2pF0lvnQmhdXLVC1efdKrSQywkEpJr0dD/x6iZsSbt2aLA
	 sbuHEoGc+FuupOSgcpH/8AlXIluaU35ZGP/kVI+yNWvBPhQ0553qBBDJpi4SzfvLfZ
	 O0zwPME2cfKOg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 10/19] vfio/pci: Serialize hot reset with recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260901093217.8539-11-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-11-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:58:21 +0000
Message-Id: <20260901095822.173F81F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] AB-BA R-W-R deadlock between memory_lock and pci_bus_sem during ho=
t reset and AER recovery.
- [High] A race condition allows a user-initiated hot reset to bypass the `=
pci_recovery_access_blocked` check, leading to a bus reset during an ongoin=
g AER recovery.
--

commit 4d5ab3d1277c9d84f74fe886437d56a38b34b2c4
Author: Shameer Kolothum <skolothumtho@nvidia.com>

vfio/pci: Serialize hot reset with recovery

This patch attempts to serialize user-initiated hot resets with hardware
error recovery by refusing hot resets when recovery blocks access to
the device. It introduces a lockless check of the access_blocked flag
instead of taking recovery_lock to avoid lock inversions.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 876ff51d6987a..bd3d79d28f27a 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2937,6 +2937,27 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_=
device_set *dev_set,
>  			break;
>  		}
> =20
> +		/*
> +		 * Between the AER callbacks memory_lock is not held, so refuse
> +		 * the reset on access_blocked as well. Read it rather than
> +		 * take recovery_lock, which would have to be released before
> +		 * pci_reset_bus() anyway since that reaches pci_bus_sem.
> +		 *
> +		 * Let a device which has failed for good through. Nothing is
> +		 * running on its behalf, and this reset covers the whole set,
> +		 * so refusing there would stop a healthy sibling from being
> +		 * reset because an unrelated device errored. The failed one
> +		 * stays blocked, since the reset does not unblock a device
> +		 * with FAILED set.
> +		 */
> +		if (vdev->pci_recovery_supported &&
> +		    READ_ONCE(vdev->pci_recovery_access_blocked) &&
> +		    !(READ_ONCE(vdev->pci_recovery_flags) &
> +		      VFIO_PCI_RECOVERY_FAILED)) {
> +			ret =3D -EBUSY;
> +			break;
> +		}
> +

[Severity: High]
Does this lockless check of pci_recovery_access_blocked create a race
window before memory_lock is acquired?

If the hot reset thread checks this flag and sees it as false, it can be
preempted. If the AER handler then runs and sets access_blocked to true:

vfio_pci_core_aer_err_detected()
    WRITE_ONCE(vdev->pci_recovery_access_blocked, true);
    ...
    vfio_pci_zap_and_down_write_memory_lock(vdev);
    ...
    up_write(&vdev->memory_lock);

Could the hot reset thread subsequently wake up, successfully acquire
memory_lock in the down_write_trylock() below, and call pci_reset_bus() whi=
le
the AER process is in the middle of recovery (e.g., between error_detected =
and
slot_reset)?=20

This could bypass the intended protection and corrupt the recovery state.

>  		/*
>  		 * Take the memory write lock for each device and zap BAR
>  		 * mappings to prevent the user accessing the device while in
>  		 * reset.  Locking multiple devices is prone to deadlock,
>  		 * runaway and unwind if we hit contention.
>  		 */
>  		if (!down_write_trylock(&vdev->memory_lock)) {
>  			ret =3D -EBUSY;
>  			break;
>  		}

[ ... ]

>  	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list)
>  		vfio_pci_set_power_state(vdev, PCI_D0);
> =20
>  	ret =3D pci_reset_bus(pdev);

[Severity: High]
Can this sequence lead to an AB-BA R-W-R deadlock between memory_lock and
pci_bus_sem?

In this path, the user-initiated hot reset acquires memory_lock for write, =
and
then pci_reset_bus() acquires pci_bus_sem for read via
pci_bridge_wait_for_secondary_bus().

However, during AER recovery, pci_walk_bridge() holds pci_bus_sem for read,
and then calls into vfio_pci_core_aer_err_detected() which waits for
memory_lock for write:

vfio_pci_core_aer_err_detected()
    vfio_pci_zap_and_down_write_memory_lock(vdev)
        down_write(&vdev->memory_lock);

If a third thread (e.g., sysfs rescan) requests pci_bus_sem for write, it
blocks new readers (the hot reset thread) to prevent starvation, while wait=
ing
on existing readers (the AER thread).

This creates an unresolvable cycle:
- Hot reset thread holds memory_lock (W), waits for pci_bus_sem (R)
- Third thread waits for pci_bus_sem (W), blocks new readers
- AER thread holds pci_bus_sem (R), waits for memory_lock (W)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901093217.8539=
-1-skolothumtho@nvidia.com?part=3D10
