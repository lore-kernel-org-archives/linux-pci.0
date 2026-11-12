Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494943;
	b=ZCbnEldZVvhA8qbPnGLzqsSEf0QbfpudycqVXdyp9iAUYEO1qHx0okmpZkTw/ibI9ps7
	 3Bv6ZBdoAPjhUHZIAljD56AarkHTLdJzvutWd1PIi647qP83gOPNreR8G/c5wXDmUZfkL
	 6Z+eT64GZFs3t0t3dAFBdp9e9sBjW2wzm8OyTqeQ4Llx7yI13IhH+yOAl/gvSvvG26PWC
	 55nGkRERMI4zpk6C7n+5eLIS68RG5B2SsC73qa3Qo1jfQ8u2T7kCT8407QjGRqZVHO6kf
	 4xE7gB5+i97wdbhxQLC3h2LNb7yKSY8L8aQ6o5hRsSEzj+iUPzaySQNYeqH+43GsDkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494943;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RacFN0e12PpneLZ1/9MApL+kZA3sKGzZRj/JYTodZBg=;
	b=g3MQNIrfp+CMLfXgof172YcObuDsUn3AuDMF4bpLxYY2e1XJQOR40VLra/mCYRfv8VuY
	 i1NvYRnjKIl9KA6mku+tXS2kwiG62Pc9vXu4Fvf9zbepY1DfFvYwiOJqrW34EwOl+VgRJ
	 QKlzcM09dplCL1BYouczcsC7fb2OR71fxayCavv4/Xp6CDfY+A2L47cEF7TzIR8R+RG/U
	 XK1TA7XTHAWnnsMztapNQH2Mf6N79zZ9IeBZQDwZ+LrGF4Hvu8mSIZZlekAJXRbCnSKJg
	 9vAOhDHrrem1Gj2KjQxJv6Y42oNdBitZzfX22egI65YJsCJhLEI/lP5jxsdVkmlWcMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0lzvtz6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58A1606A331;
	Thu, 12 Nov 2026 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0lzvtz6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF4F1F00A05;
	Thu, 12 Nov 2026 14:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794494943;
	bh=RacFN0e12PpneLZ1/9MApL+kZA3sKGzZRj/JYTodZBg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=B0lzvtz6kJwX6ojafwii/hKZ6QNB2bc9WWyAOq9mS+ss32ix8k2smh5p+jmeAcl96
	 8qLHxSJueB6Ka+XmHdytZsyPvkqrQ7ZzPeDfmvb8IpQBPUIni7e0bN1oetoc+z7Y6W
	 ZUmo/6VOQsBJ/ax3a+ULamTfAeAAB7mRwugoR9QE9KHRW9uSYdYFQUAwYwzcO03G2H
	 pIpqrlYlCLVow6og74p7yZfjWzJS/cqZQkj9e4FVXnmsoEoCSXU5zGxUuaXhHG/ntT
	 DH17dwoOaxPYsFXvrFRNc+PmufE1hbl3ES2TVzMZeqfMIgwnZotrcu5umNcSv7fXZw
	 1rQcsRgxK64Zg==
Message-ID: <sashiko-outbox-211384@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 15/20] vfio/pci: Use access ops for SR-IOV
 configuration and shared reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>, kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261112141632.918954-16-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
 <20261112141632.918954-16-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:49:02 +0000
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
- [Medium] vfio/pci: vfio_pci_dev_set_hot_reset() calls D0 helper on
  failed devices
- [Medium] vfio/pci: vfio_pci_prepare_hot_reset_blocked() misses host
  recovery and caller checks
- [Medium] vfio/pci: unsynchronized open and recovery state in
  vfio_pci_core_sriov_configure()
--

commit abe74651d949fa43ae45614261ad8c3282ae7603
Author: Shameer Kolothum <skolothumtho@nvidia.com>

vfio/pci: Use access ops for SR-IOV configuration and shared reset

This commit routes SR-IOV configuration and shared hot-reset preparation
through vfio_pci_access_ops so that recovering open devices are rejected
while unopened or failed devices remain allowed.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 89cebe2522ba0..0ef51810254ea 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -334,10 +339,21 @@ static void vfio_pci_restore_dmabufs_blocked(struct=
 vfio_pci_core_device *vdev)
>  {
>  }
> =20
> +static int vfio_pci_sriov_configure_blocked(struct vfio_pci_core_device =
*vdev,
> +					    int nr_virtfn)
> +{
> +	/* SR-IOV can be configured without an open VFIO device. */
> +	if (!READ_ONCE(vdev->device_open))
> +		return vfio_pci_sriov_configure_live(vdev, nr_virtfn);
> +	return -EIO;
> +}

[Severity: Medium]
Can vfio_pci_core_sriov_configure() race with device open, close, or host
PCI recovery because neither vdev->access_ops nor vdev->device_open is
serialized by device_lock(&vdev->pdev->dev)?

vfio_pci_core_finish_enable() and vfio_pci_core_close_device() update
vdev->device_open and vdev->access_ops under vdev->access_lock without
holding device_lock(&vdev->pdev->dev):

CPU0                                    CPU1
vfio_pci_core_finish_enable()
  WRITE_ONCE(vdev->device_open, true)
                                        vfio_pci_core_sriov_configure()
                                          vfio_pci_access_ops(vdev)
                                            /* sees blocked_ops */
                                          vfio_pci_sriov_configure_blocked()
                                            READ_ONCE(vdev->device_open)
                                            --> returns -EIO
  rcu_assign_pointer(vdev->access_ops,
                     &vfio_pci_live_ops)

In the reverse direction, vfio_pci_core_close_device() sets
vdev->device_open =3D false before vfio_pci_core_disable() finishes tearing
down the PF, and pcie_do_recovery() drops device_lock(&pdev->dev) between
recovery callbacks while vdev->pci_recovery_host_active is true.  Because
vfio_pci_sriov_configure_blocked() only checks !READ_ONCE(vdev->device_open)
without taking vdev->access_lock or checking vdev->pci_recovery_host_active,
sysfs sriov_numvfs can run vfio_pci_sriov_configure_live() while close
teardown or host recovery is in progress.

[ ... ]

> @@ -2776,6 +2801,23 @@ static int vfio_pci_dev_set_pm_runtime_get(struct =
vfio_device_set *dev_set)
>  	return ret;
>  }
> =20
> +static int vfio_pci_prepare_hot_reset(struct vfio_pci_core_device *vdev)
> +{
> +	lockdep_assert_held_write(&vdev->memory_lock);
> +	vfio_pci_dma_buf_move(vdev, true);
> +	vfio_pci_zap_bars(vdev);
> +	return 0;
> +}
> +
> +static int vfio_pci_prepare_hot_reset_blocked(struct vfio_pci_core_devic=
e *vdev)
> +{
> +	/* Unopened and failed devices must not prevent a shared reset. */
> +	if (READ_ONCE(vdev->device_open) &&
> +	    !(READ_ONCE(vdev->pci_recovery_flags) & VFIO_PCI_RECOVERY_FAILED))
> +		return -EBUSY;
> +	return vfio_pci_prepare_hot_reset(vdev);
> +}

[Severity: Medium]
Can vfio_pci_prepare_hot_reset_blocked() allow pci_reset_bus() to run
while host PCI recovery is active or when VFIO_DEVICE_PCI_HOT_RESET is
called directly on a failed device FD?

When host recovery is running on an unopened sibling, or on a sibling that
was closed during recovery (where vfio_pci_core_close_device() clears
device_open and pci_recovery_flags while keeping pci_recovery_host_active
set), vfio_pci_prepare_hot_reset_blocked() sees !vdev->device_open and
allows userspace to trigger pci_reset_bus() concurrently with host
recovery.  In addition, unlike vfio_pci_ioctl_reset(),
vfio_pci_ioctl_pci_hot_reset() does not check whether the calling device FD
itself has blocked access, so invoking VFIO_DEVICE_PCI_HOT_RESET on a
device with VFIO_PCI_RECOVERY_FAILED succeeds and resets the bus.

>  static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
>  				      struct vfio_pci_group_info *groups,
>  				      struct iommufd_ctx *iommufd_ctx)
> @@ -2849,8 +2891,11 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_=
device_set *dev_set,
>  			break;
>  		}
> =20
> -		vfio_pci_dma_buf_move(vdev, true);
> -		vfio_pci_zap_bars(vdev);
> +		ret =3D vfio_pci_access_ops(vdev)->prepare_hot_reset(vdev);
> +		if (ret) {
> +			up_write(&vdev->memory_lock);
> +			break;
> +		}
>  	}

[Severity: Medium]
When a failed sibling passes vfio_pci_prepare_hot_reset_blocked(), does the
subsequent loop in vfio_pci_dev_set_hot_reset() still call
vfio_pci_try_set_power_state(vdev, PCI_D0) directly on that failed device?

drivers/vfio/pci/vfio_pci_core.c:vfio_pci_dev_set_hot_reset() {
    ...
	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list) {
		ret =3D vfio_pci_try_set_power_state(vdev, PCI_D0);
		if (ret)
			goto out_unlock_memory;
	}

If an open sibling in VFIO_PCI_RECOVERY_FAILED is in a non-D0 state and
inaccessible, vfio_pci_try_set_power_state() fails with -EIO and aborts
the shared reset for the healthy siblings.  If the failed sibling was in
PCI_D3hot with vdev->needs_pm_restore set and responds to the transition,
__vfio_pci_set_power_state() loads vdev->pm_save and calls
pci_restore_state(), re-enabling the pre-failure PCI_COMMAND (including
bus mastering and memory decoding) on the failed device before
pci_reset_bus() saves and restores config space.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141632.9189=
54-1-skolothumtho@nvidia.com?part=3D15
