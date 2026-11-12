Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494521;
	b=5jjXy983Yoj3RdgXzSkvmPY77xmIiiZisxHPKXVG4ahVtw2ydSTwF2m9ccXgOHbaIghE
	 Vj8LDyEOZwWlDuYWXi/3p1czw+BdizD0fvZrgoeDtDsaHbsrU2OuitkZjDiZCQOxLx9TK
	 rMifOwXReWJ6vzOo0PW4WSLz7zcrA+LgQOnBu8z2+3qch5Jg7qM0EgxRWmQ3rhrsVE+x4
	 UUafPoDpEYaXzOGcKNXr0PkcB13lQ+mvVvXBgpijww6EOF6RjbuvoAoVDtSgi8bQwMg0R
	 F+Fr2ospp7nvcgqJp6527sBrw7wvXYw0xmdSD5rYgwcjMs7bQsbUXpBvu9l4kSfQ08w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494521;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hVx7Dj2VllEMGVnE2iIOn3J/Pbm59VYk/0/n8Y/LNnY=;
	b=ntODuKZBJs2cGRsMlXRUprWj2dR+cxP0uM7AAQT8Nx37N86N/cZ1n+kvml7O7AqR7lB2
	 b1mngv6BPr6ZyIpoedhD3k3lf8Jn0knbvZd1jbBcmIylqMIWBGEvPTSAGHASASnwtYMtd
	 wz2TuO9ziPx9lDAVKzO9cOVftZTovl7vo/X9OR5OpDstGZC8+5Lj82Xtf2CjzffVR1fNs
	 D/G5WYSsN03XhxSgXbVdni5k8ONY/W4iR/dfJW7PPn3YhNBdn/RB8NuWihPh4QmYcTrGb
	 91nEECdDHQj5zhoh+VoxLHECMyeIe/b6S3I+z/oD8Uh6zM2xgVKmzlTCa/8NV9cK5EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TgO046Fa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1764F606A321;
	Thu, 12 Nov 2026 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TgO046Fa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8061F00A05;
	Thu, 12 Nov 2026 14:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794494520;
	bh=hVx7Dj2VllEMGVnE2iIOn3J/Pbm59VYk/0/n8Y/LNnY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TgO046Fa1jJEr6/jYfcb5YkWX8UxKjlU+HpmE9r3I8V7+cgXLKpuO+RRqJSf8ArE7
	 +nMuSwBFcqwQQ6zZIdVz0TWTSQiz8j0TTl3jYSCNNn3UHIM4jrhWVaXKEMvYkUueLy
	 MYFiLCKU1NnlvMhGwQlPSChF8XX3D8RTvuucXVeWgKB8OoFJF1IigayvEUv4o8NU5j
	 GvLzR+4hTb0lxEpuFlfALgCRRf09dpivXHrSyIPQKRZiMItlz2GVS7itgvToXliEZX
	 37DnAbKCXSLW/9J1+xW3/MHzotGZUKNKFRZXglEh/9tZDZqoHpgw6RzObqHBQqqxJi
	 5TxPDqOw9MafQ==
Message-ID: <sashiko-outbox-211365@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 04/20] vfio/pci: Use access ops for config-space
 accesses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>, kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261112141632.918954-5-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
 <20261112141632.918954-5-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:41:58 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] vfio/pci: pci_bus_sem lock inversion in config-space FLR under
  access_srcu
--

commit 07dee5e58e5bbc760b7e991d4fc5ab36537fd5e0
Author: Shameer Kolothum <skolothumtho@nvidia.com>

vfio/pci: Use access ops for config-space accesses

This commit runs PCI config-space accesses through vfio_pci_core_access(),
routes power-state transitions through vfio_pci_access_ops, and defers
PCI_PM_CTRL D0 transitions until after leaving access_srcu.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index 9914f3ac69aef..1e54e2e8b2ef8 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c

[ ... ]

> @@ -1957,11 +2017,21 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci=
_core_device *vdev,
>  		if (copy_from_user(&val, buf, count))
>  			return -EFAULT;
> =20
> -		ret =3D perm->writefn(vdev, *ppos, count, perm, offset, val);
> +		access.val =3D val;
> +		ret =3D vfio_pci_core_access(vdev, vfio_pci_access_config, &access);
> +		if (ret < 0)
> +			return ret;
> +		if (access.power_up) {
> +			int err =3D vfio_lock_and_set_power_state(vdev, PCI_D0);
> +
> +			if (err)
> +				return err;
> +		}

[Severity: High]
Can a config-space FLR write in vfio_exp_config_write() or
vfio_af_config_write() invert the lock order between access_srcu and
pci_bus_sem when the device is in a low-power state?

vfio_pm_config_write() defers D0 transitions outside access_srcu so that
pcie_aspm_pm_state_change() does not block on pci_bus_sem while AER waits
for access_srcu readers.  However, if userspace puts the device into
D1-D3hot via PCI_PM_CTRL and then writes PCI_EXP_DEVCTL_BCR_FLR or
PCI_AF_CTRL_FLR, vfio_pci_core_access() runs the handler inside
access_srcu, where it takes vdev->memory_lock and calls
pci_try_reset_function():

drivers/pci/pci.c:pci_dev_save_and_disable() {
    ...
	pci_set_power_state(dev, PCI_D0);
    ...
}

pci_set_power_state() calls pci_set_full_power_state(dev, false) ->
pcie_aspm_pm_state_change() -> down_read(&pci_bus_sem) while holding both
access_srcu and vdev->memory_lock:

CPU0                              CPU1 (AER recovery)
----                              -------------------
                                  down_read(&pci_bus_sem)
vfio_pci_config_rw_single()
  vfio_pci_core_access()
    srcu_read_lock(&access_srcu)
    ...
    vfio_exp_config_write()
      down_write(&memory_lock)
      pci_try_reset_function()
        ...
        down_read(&pci_bus_sem)
                                  synchronize_srcu(&access_srcu)

 *** DEADLOCK ***

(if a writer is queued on pci_bus_sem, or against any path nesting
pci_bus_sem -> access_srcu / memory_lock)

In addition, letting pci_dev_save_and_disable() perform the D3hot -> D0
transition directly bypasses vfio_pci_try_set_power_state() and skips
restoring vdev->pm_save on NoSoftRst- devices.

Calling vfio_pci_try_set_power_state(vdev, PCI_D0) before
pci_try_reset_function() in vfio_exp_config_write() and
vfio_af_config_write() (as commit 358432f8bbe9 ("vfio/pci: Avoid waiting
for the bus lock when preparing D0") did for vfio_pci_ioctl_reset()), or
deferring the FLR outside access_srcu, would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141632.9189=
54-1-skolothumtho@nvidia.com?part=3D4
