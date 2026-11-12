Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496255;
	b=hui9oFIihsdZzEZnqmL7pU6MVSqfchOhq1WTqzAgFANez0bRi3ir72zvjnoOhYXTbrww
	 jlwkT//Z205fIif42nTcbd0X35snqOHHbSgQVnQsWcdyTiJE7y09e5oTEXpfye5iu+S3b
	 ktTOl4Ed6YTf5wwCVxIX6Q8FwlJeMdqhYPho5G/mAAz0cLmKou7otspnMI5uy1xUwn3al
	 xtCsw+IUGvRQKMVuOiH5kbL5dIvJ3p3KIGJV1bZLOY6td3t0KkGefyAhJhr6yAksPFjN8
	 HrzNlPxGkeS0ECaoKsJUoM25NXh59zHDbYt3oBulY/mMWsaosb57aEl5tq1ZcI2yoKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496255;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oA95rbY+oBonMVDuRyweZZjzZ28nbgmghFdIVCPHtBM=;
	b=NfKxXT66El27C6QzlppwUCmB8M13BgOoYhDb7GRxV5eXe2uxAXxYoJXqSmyXWjaSwvm6
	 POki+81QOhY4r6UjNdhIfKbU5S9H2nycq9t+ZuiMGgddazM1YrVhpSg5c5J5zRcO5RRob
	 6JB1418CCZxFIwo5ysp4kyyvp9iUZqC2Un8JtYUB4tGgiRgcdYg4fkeJ8ZBxMTxmfdLMk
	 R/UfE3fka7qAuqF5XjPMXu/6ljzm7P6AFlQNMcIbRB4vZqfQB1ifnmIQGcwwBEYPisvGS
	 e6D89E3btRBSkehk9d1JoeRorx5iFSrOdxUBuylWmqsnDbGh0lmNv2IAfWWnTKuKiDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P5V3nCmK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8FA606A321;
	Thu, 12 Nov 2026 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P5V3nCmK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52601F00A09;
	Thu, 12 Nov 2026 15:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794496254;
	bh=oA95rbY+oBonMVDuRyweZZjzZ28nbgmghFdIVCPHtBM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=P5V3nCmK+s7Ld6IP2OltUzNq4JWzA3BKJmJ1XmaJ1JgxDNyIIKW0V8tluVH868Qrh
	 GMdhMCEmm75CmPLsNmi9SK/+QNg5wuw1UsRrMef1OJ+4IUKooNrT1dOsf6jhqGp1En
	 LYwEz3xf1UH6Fq9ywa28TlP4yf0kcU9ET9j4QemxmN+w5k8qmbTwAXIdRkzF8RxCUw
	 lolRSFd7M8jc+7fn7WGi7P9s8hxsgxdc44hKup1UeqBBKpYJBxrtru9krqzOdzlcgp
	 XVXaK8iiLx+tyajbu9JWuPr7de/1yGmdYIxNd8On+eKt8AdRQ5pUKo45QR6MtCkytI
	 YRGEVt5IcJwHw==
Message-ID: <sashiko-outbox-211410@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 20/20] vfio/pci: Enable recovery for supported
 native PCIe endpoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>, kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261112141632.918954-21-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
 <20261112141632.918954-21-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 15:10:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] vfio/pci: VFIO_DEVICE_GET_INFO fails with -EIO on VFs when PF
  is closed
- [Medium] vfio/pci: circular locking between access_srcu and
  access_lock on VF and PF
- [Medium] vfio/pci: false recovery in vfio_pci_supports_recovery() for
  SR-IOV VFs
--

commit 4182befeb4982c12ce357363cc414cc54cc9381b
Author: Shameer Kolothum <skolothumtho@nvidia.com>

vfio/pci: Enable recovery for supported native PCIe endpoints

This commit enables host PCI error recovery for supported generic vfio-pci
endpoints on the subordinate bus of a PCIe Root Port or Downstream Port and
updates the UAPI documentation.

> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index a5ba4bb116382..fe9b8b8deccab 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -126,10 +126,70 @@ static int vfio_pci_open_device(struct vfio_device =
*core_vdev)
>  	return 0;
>  }
> =20
> +static bool vfio_pci_supports_recovery(struct pci_dev *pdev)
> +{
> +	struct pci_dev *bridge =3D pci_upstream_bridge(pdev);
> +
> +	/*
> +	 * Looking up function zero for VPD takes pci_bus_sem inside access_src=
u.
> +	 * Recovery holds the bus read lock while waiting for these SRCU reader=
s.
> +	 * A queued bus writer can leave both paths waiting for each other.
> +	 */
> +	if (pdev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0)
> +		return false;
> +
> +	/*
> +	 * quirk_f0_vpd_link() can redirect sibling VPD accesses to these devic=
es
> +	 * without checking whether recovery has blocked function zero. Exclude
> +	 * them even if no redirecting sibling is present at probe.
> +	 */
> +	if (!PCI_FUNC(pdev->devfn) && pdev->vpd.cap &&
> +	    pdev->vendor =3D=3D PCI_VENDOR_ID_INTEL &&
> +	    (pdev->class >> 8) =3D=3D PCI_CLASS_NETWORK_ETHERNET)
> +		return false;
> +
> +	/*
> +	 * EEH and Xen PV can call recovery without the required bus locking.
> +	 * s390 recovery can omit completion callbacks.
> +	 */
> +	if (IS_ENABLED(CONFIG_S390) || IS_ENABLED(CONFIG_EEH) ||
> +	    xen_pv_domain())
> +		return false;
> +
> +	/*
> +	 * Recovery power helpers require pci_bus_sem held for reading.
> +	 * The native recovery walk holds it on a port's subordinate bus.
> +	 * Direct RCiEP recovery does not use that walk.
> +	 */
> +	if (!pci_is_pcie(pdev))
> +		return false;
> +
> +	if (pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_ENDPOINT &&
> +	    pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_LEG_END)
> +		return false;
> +
> +	if (!bridge || !pci_is_pcie(bridge))
> +		return false;
> +
> +	if (pci_pcie_type(bridge) !=3D PCI_EXP_TYPE_ROOT_PORT &&
> +	    pci_pcie_type(bridge) !=3D PCI_EXP_TYPE_DOWNSTREAM)
> +		return false;
> +
> +	if (pdev->bus !=3D bridge->subordinate)
> +		return false;

[Severity: Medium]
Does this allow SR-IOV VFs placed on the PF's bus to report a false
recovery when the PF itself does not recover?

When pci_iov_virtfn_bus() matches the PF's bus number, virtfn_add_bus()
places VFs directly on pf->bus (bridge->subordinate) rather than a
synthetic VF bus, and pci_upstream_bridge(pdev) resolves through the PF to
bridge.  vfio_pci_supports_recovery() then returns true for the VF even if
the PF is excluded from recovery (such as an Intel Ethernet function 0 PF
with VPD), closed, or has recovery disabled.

If pcie_do_recovery() performs a secondary bus reset on bridge, the PF is
reset in hardware, clearing PCI_SRIOV_CTRL_VFE and disabling all VFs.
When the PF is not participating in vfio-pci recovery,
vfio_pci_core_aer_slot_reset() returns PCI_ERS_RESULT_NONE on the PF
without calling pci_restore_state() / pci_restore_iov_state().  The
subsequent vfio_pci_core_aer_slot_reset() on the VF still succeeds because
pci_set_power_state_locked() sees current_state =3D=3D PCI_D0 and
pci_restore_state() returns void, so the VF reports
PCI_ERS_RESULT_RECOVERED and re-enables live access while VFE remains
cleared on the PF.

[Severity: Medium]
Enabling pci_recovery_supported on both a PF and an SR-IOV VF on the same
bus also triggers a lockdep circular locking splat when
VFIO_DEVICE_GET_INFO is called on the VF while the PF is open.

All vfio_pci_core_device instances share the same lockdep classes for
access_lock and access_srcu.  vfio_pci_core_block_access() runs
synchronize_srcu(&vdev->access_srcu) under vdev->access_lock (establishing
access_lock -> access_srcu), whereas vfio_pci_ioctl_get_info() on the VF
holds srcu_read_lock(&vdev->access_srcu) across
vfio_pci_access_atomic_cap(), which takes pf_vdev->access_lock and
srcu_read_lock(&pf_vdev->access_srcu):

drivers/vfio/pci/vfio_pci_core.c:vfio_pci_access_atomic_cap() {
	...
	guard(mutex)(&pf_vdev->access_lock);
	if (!pf_vdev->device_open)
		return -EIO;

	return vfio_pci_core_access(pf_vdev, vfio_pci_access_atomic_cap_target,
				    data);
}

> +
> +	/* CXL RCH recovery can omit completion callbacks. */
> +	if ((pdev->class >> 8) =3D=3D PCI_CLASS_MEMORY_CXL)
> +		return false;
> +
> +	return true;
> +}
> +
>  static int vfio_pci_init_dev(struct vfio_device *core_vdev)
>  {
>  	struct vfio_pci_core_device *vdev =3D
>  		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> +	struct pci_dev *pdev =3D to_pci_dev(core_vdev->dev);
> =20
>  	/*
>  	 * These behaviors originated in vfio-pci and moved into
> @@ -140,6 +200,7 @@ static int vfio_pci_init_dev(struct vfio_device *core=
_vdev)
>  	 */
>  	vdev->nointxmask =3D nointxmask;
>  	vdev->disable_idle_d3 =3D disable_idle_d3;
> +	vdev->pci_recovery_supported =3D vfio_pci_supports_recovery(pdev);

[Severity: High]
Does setting pci_recovery_supported on an SR-IOV PF cause
VFIO_DEVICE_GET_INFO on its VFs to fail with -EIO whenever the PF is not
open?

SR-IOV can be enabled while a vfio-pci PF is unopened, or the PF fd can be
closed after configuring a vf_token while VFs are used.  Once
pf_vdev->pci_recovery_supported is true, vfio_pci_ioctl_get_info() ->
vfio_pci_access_atomic_cap() on a VF checks pf_vdev->device_open and
returns -EIO whenever the PF is closed, even when no host recovery is
active on the PF:

drivers/vfio/pci/vfio_pci_core.c:vfio_pci_access_atomic_cap() {
	struct vfio_pci_core_device *pf_vdev =3D vdev->sriov_pf_core_dev;

	if (!pf_vdev || !pf_vdev->pci_recovery_supported)
		return vfio_pci_info_atomic_cap(vdev, data);
	...
	guard(mutex)(&pf_vdev->access_lock);
	if (!pf_vdev->device_open)
		return -EIO;
}

vfio_pci_ioctl_get_info() treats any return value other than 0 or -ENODEV
as fatal and fails the VF's VFIO_DEVICE_GET_INFO ioctl with -EIO.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141632.9189=
54-1-skolothumtho@nvidia.com?part=3D20
