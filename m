Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795004422;
	b=jjbIcp3GYaTUcItXolTca3bqh+pUopqa9OrmYg4UL98+izq1tLqoDxKe94BhbO8Nbb8T
	 3xBOwOfzQSaLZw7ap3PP9t/u1bNjT1IFBhT4J0QipxPs7o3QaSWfP3Wjn9pcE2Fh7JBzv
	 cvZseUR88KnXhpbis1QR2/2CdohJSoHM9++WFaQECIJ/Z86FfxhFOu1rCENSuVjIWhcMK
	 XPESuzvn3cKv+PK89VeKgHXcUmbwHXjaneafgE8Xn60LHmiCzVo4OLfWJ23y++0wHk+yN
	 +u2zdqsMAHGsTYaAM4Y/33bhUq38VZcGEpq2DaeYm1Z0xrE25DiQwANgEpdKSkELoWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795004422;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aGwcY3cmPZsnUI5Lx24DztCWVdX9CErSqYeL9GumSAc=;
	b=iSL1bMtyDhSPsObswqx1NQ2aASTH4gxr3Du8GVhMCOtivx9pY9NgLHhlbzc0pV/uZ9Dx
	 eodwnsbAp0PUuJUwab5g0AbW+854UOjvV8r+B90DwSTO88NogZv3za7ds5p+ddtmq/knQ
	 DVmHg4ZNyJ93ekVfVmVkWc7oWigNBO51SA+n2gBqllbBY6cxVIhmsh4QqXJ2ZJtGC/WX6
	 /W8cQrjfL0pEnBzbp1chEqecr5Da1nMxc+eM18qTlz6CIgTkO4t17OdYSNm3//SUrM9ws
	 y5UsUPQARvGm8mRM2DNl6VGFQkTs1v7H6PGbv14eMlN/Py1qkre701xp3TxeQq6HEiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDvgikGP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152E1606A31C;
	Wed, 18 Nov 2026 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDvgikGP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02E21F000C4;
	Wed, 18 Nov 2026 12:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795004421;
	bh=aGwcY3cmPZsnUI5Lx24DztCWVdX9CErSqYeL9GumSAc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TDvgikGPetbxESW4keWVqWHoezHVoVIXc9p48MY59YnlGxz7N71S7dP/0zSGv1oVD
	 bXHv4oP9HXc4gQEl9N1FLonWZ9UHSEMi1GqE4ZoEQa6oTZt530xxIPolhlj2Of7x75
	 gEoiutCgTxmfy+ZOGzx0tm0OPawwdcPif1hQItEoZp5GD77oBGZQhV6F2Hu2nCBztM
	 VwEisgqFNKQSKQtYrMeQI1wPkpHXuGycZxnAthCp4UKbDvilxQQQ6QlOaWlK5Mt4pI
	 DgRFzN9NzTqNMGDAGkShPIsfTOGezih+65pbz+Ypj9BHdlUia9qhE/H6uPtrLfXN0q
	 mU9C2nFhdX9oA==
Message-ID: <sashiko-outbox-220903@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 12/13] vfio/pci: Reset PCIe TPH state on device open
 and close
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118091238.45992-13-fengchengwen@huawei.com>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
 <20261118091238.45992-13-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 12:20:21 +0000
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
- [Medium] vfio/pci: pcie_disable_tph() after reset in
  vfio_pci_core_enable()
- [Medium] vfio/pci: unsafe TPH teardown order and cpuhp race in
  vfio_pci_core_disable()
- [Medium] vfio/pci: stale PCIe TPH state across runtime resets and
  config writes
--

commit 339ada87f2084ce58d1ead31609b94d5bab56bf3
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Reset PCIe TPH state on device open and close

This commit calls pcie_disable_tph() in vfio_pci_core_enable() and
vfio_pci_core_disable() to reset PCIe TPH state when opening and closing
a VFIO PCI device.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 049392831b35f..8d3d532cd51ab 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -606,6 +606,8 @@ int vfio_pci_core_enable(struct vfio_pci_core_device =
*vdev)
>  		goto out_disable_device;
> =20
>  	vdev->reset_works =3D !ret;
> +	/* Reset TPH state for new user session */
> +	pcie_disable_tph(vdev->pdev);
>  	pci_save_state(pdev);
>  	vdev->pci_saved_state =3D pci_store_saved_state(pdev);
>  	if (!vdev->pci_saved_state)

[Severity: Medium]
Should pcie_disable_tph() run before pci_try_reset_function() instead of
after it?

If pdev->tph_enabled is still set when entering vfio_pci_core_enable(),
pci_try_reset_function() calls pci_save_tph_state() before the reset and
pci_restore_tph_state() after it, writing the stale PCI_TPH_CTRL and
capability-located Steering Tag table entries back into hardware.
pcie_disable_tph() then clears only PCI_TPH_CTRL and sets
pdev->tph_enabled =3D 0, leaving the restored ST table entries in hardware.
Because pdev->tph_enabled is now 0, the following pci_save_state() ->
pci_save_tph_state() returns early without updating the saved buffer, so
vdev->pci_saved_state retains the stale pre-disable TPH state.

> @@ -762,6 +764,9 @@ void vfio_pci_core_disable(struct vfio_pci_core_devic=
e *vdev)
> =20
>  	vfio_pci_zdev_close_device(vdev);
> =20
> +	/* Reset TPH state on user session exit */
> +	pcie_disable_tph(vdev->pdev);
> +
>  	/*
>  	 * If we have saved state, restore it.  If we can reset the device,
>  	 * even better.  Resetting with current state seems better than

[Severity: Medium]
Is calling pcie_disable_tph() this late in vfio_pci_core_disable() safe
against MSI-X teardown and CPU hotplug?

vfio_pci_set_irqs_ioctl() disables MSI-X and vfio_pci_tph_dev_deinit()
runs before pcie_disable_tph() is reached here.  Meanwhile,
vfio_pci_tph_dev_deinit() frees vdev->tph_st_cpu without vdev->tph_lock
before removing the cpuhp instance:

CPU0                                  CPU1
vfio_pci_core_disable()               vfio_pci_tph_cpuhp_offline()
  vfio_pci_set_irqs_ioctl()
  ...
  vfio_pci_tph_dev_deinit()
                                        if (vdev->tph_st_cpu =3D=3D NULL)
    kfree(vdev->tph_st_cpu);
    vdev->tph_st_cpu =3D NULL;
                                        mutex_lock(&vdev->tph_lock);
                                        vdev->tph_st_cpu[i]
                                          <-- use-after-free / NULL deref
    cpuhp_state_remove_instance_nocalls()

In addition, if a CPU goes offline after vfio_pci_set_irqs_ioctl()
disables MSI-X on a PCI_TPH_LOC_MSIX device while pdev->tph_enabled is
still 1, vfio_pci_tph_cpuhp_offline() -> pcie_tph_set_st_entry() ->
pci_msix_write_tph_tag() fails with -ENXIO and logs a pci_err().
vfio_pci_tph_dev_init() similarly registers vdev->tph_cpuhp_node before
allocating and initializing vdev->tph_st_cpu to -1, and
vfio_pci_tph_cpuhp_offline() calls pcie_tph_set_st_entry() without
vfio_pci_memory_lock_and_enable().

[Severity: Medium]
What happens to pdev->tph_enabled across runtime resets during an active
user session?

This patch disables TPH on open and close, but runtime reset paths
(vfio_pci_ioctl_reset(), vfio_pci_dev_set_hot_reset(), and PCIe/AF FLR in
vfio_exp_config_write() and vfio_af_config_write()) do not call
pcie_disable_tph() or reset vdev->tph_st_cpu.  When pdev->tph_enabled is
1 across pci_try_reset_function() or pci_reset_bus(), pci_save_tph_state()
and pci_restore_tph_state() restore PCI_TPH_CTRL after the reset, leaving
TPH enabled with wiped device-specific ST tables and causing subsequent
guest writes to PCI_TPH_CTRL in vfio_tph_config_write() to either drop
ST mode changes when req =3D=3D org_req or fail in pcie_enable_tph_ext() wi=
th
-EBUSY.  If a reset clears hardware PCI_TPH_CTRL to 0 without restoring
it while pdev->tph_enabled remains 1, vfio_tph_config_write() reads
org_req =3D=3D 0 from hardware, so enabling TPH fails with -EBUSY in
pcie_enable_tph_ext() while writing PCI_TPH_REQ_DISABLE exits early at
req =3D=3D org_req without calling pcie_disable_tph().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118091238.4599=
2-1-fengchengwen@huawei.com?part=3D12
