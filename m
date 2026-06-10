Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B6833F5AC;
	Wed, 10 Jun 2026 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105740; cv=none; b=lOdO6I34en4FCHCCzfJ23fke+WhyX9/d0joD5kL2P1kW+9Uecix2h9Kcf1y+UvfbzmYb4r2v06Thm35ri40NgkHJnp8C52qquRYRUmI4mXjF2sL8tgSpH/UgjoM3QuJTkrsmtW+C1QD+In/sf5Sj5UDM0XTZtOwKS4YxqpLxCcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105740; c=relaxed/simple;
	bh=YrreOjOiqN/xZdZO43QwMmvo1BECwDfXUdkF+isrIco=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pVHPrCdsYLDmhD9Y1czjrhp3bI/l0FL20peFF5nIicd6JDzIqaBuTUSCalxTD2lUphZBfl7y4fWAhKQUaY5bdNhlXdGvjYMGkjBrmckUOeBrLRxXPKtOz2ghR6MddsrLPmmCBPqnNauf3/xZVrYMvPXRt9TreEBgpLcgp06RQkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8+1q2v9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8+1q2v9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDAF1F00898;
	Wed, 10 Jun 2026 15:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781105738;
	bh=5nQvbfVR3ge+o8X9GC+ZEP04HzrT1Ae7mzcrfuUXhd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a8+1q2v9uWVCHl2ZnTlmosgZV0sEC3H2cbIkqkjI2P5N1SJDpgh9Y1jJ54RGYlj7f
	 ONBDgTbdycMupiOe9HVfjMRCFJ151UzWU8moyohlJ1imkf7pghose0/n974Sfq8sY8
	 u9AMIhO3EGpbLzVKNPqXDNyii0kt1/svvrJzaBl78Oc4YCKz+MQBrKgvjpN2dZcaqJ
	 JOrYpR9pGc4Do8z79emvZFVaX3TVZO9cqq4GcO/S1DKaV00vT3jsQKbRNwvGJnSpWY
	 16UJ/BrmMRzEU6Ht7PSQ3ZHZK44yJqftPMLpgfkiYjGpRgX//wW7boV/21tBePO4JR
	 E9oTeeiyF/yGw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/5] vfio/pci: Implement ZONE_DEVICE-backed P2P
 registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260610151853.3608948-3-praan@google.com>
References: <20260610151853.3608948-3-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 15:35:37 +0000
Message-Id: <20260610153538.0BDAF1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] Registering a BAR for P2P DMA does not check if the BAR contai=
ns the MSI-X table, allowing userspace to bypass VFIO MSI-X protections.
- [High] Missing synchronization in `vfio_pci_core_feature_p2p_register` al=
lows concurrent ioctls to corrupt state and leak devm memory.
- [High] Missing synchronization and state conflict between VFIO DMABUF and=
 P2P DMA pool registration.
- [High] P2P BAR registration state and devres allocations persist across V=
FIO file descriptor closures, breaking device isolation.

Pre-existing issues:
- [High] The error path in `pci_p2pdma_add_resource()` frees `p2p_pgmap` wi=
thout revoking the devres unmap action.
--

commit d5df237db4cc33de44c5c2d95b83b4fda6fa953a
Author: Pranjal Shrivastava <praan@google.com>

vfio/pci: Implement ZONE_DEVICE-backed P2P registration
   =20
Implement the VFIO_DEVICE_FEATURE_P2P_REGISTER. A bitmask is added to
track the registered regions.
   =20
Post-registration, the BAR is added to the device's P2P pool and is
available to be used with standard page-based APIs.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index a28f1e99362c1..1e922e3aaeb3a 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1554,6 +1554,43 @@ static int vfio_pci_core_feature_token(struct vfio=
_pci_core_device *vdev,
>  	return 0;
>  }
> =20
> +static int vfio_pci_core_feature_p2p_register(struct vfio_pci_core_devic=
e *vdev,
> +					      u32 flags, u32 __user *arg,
> +					      size_t argsz)
> +{
> +	u32 bar_index;
> +	int ret;
> +
> +	ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> +				 sizeof(bar_index));
> +	if (ret !=3D 1)
> +		return ret;
> +
> +	if (copy_from_user(&bar_index, arg, sizeof(bar_index)))
> +		return -EFAULT;
> +
> +	if (bar_index >=3D PCI_STD_NUM_BARS)
> +		return -EINVAL;
> +
> +	if (!(pci_resource_flags(vdev->pdev, bar_index) & IORESOURCE_MEM))
> +		return -EINVAL;

[Severity: Critical]
Does this code allow userspace to bypass VFIO MSI-X protections?

If the requested BAR contains the device's MSI-X table (bar_index =3D=3D
vdev->msix_bar), passing the entire BAR to pci_p2pdma_add_resource() exposes
the whole physical memory range to the global P2P DMA pool.

A malicious guest or userspace process could instruct another device to
perform P2P DMA writes directly to the MSI-X table, completely bypassing
VFIO's software protections and allowing arbitrary host interrupt injection.

> +
> +	/* Already registered */
> +	if (vdev->p2p_registered_bars & (1 << bar_index))
> +		return 0;

[Severity: High]
Does this code have a missing synchronization issue that allows concurrent
ioctls to corrupt state and leak devm memory?

The ioctl handler modifies vdev->p2p_registered_bars and calls
pci_p2pdma_add_resource() without holding any serialization lock (such as
vdev->igate or vdev->memory_lock).

Since ioctls can be invoked concurrently on the same file descriptor, multi=
ple
threads can bypass the unregistered check simultaneously, leading to
overlapping duplicate devres allocations in pci_p2pdma_add_resource(), sysfs
duplicate name errors, and bitmask corruption.

[Severity: High]
Is there a missing synchronization and state conflict between VFIO DMABUF a=
nd
P2P DMA pool registration?

If vfio_pci_bar_is_dmabuf(vdev, bar_index) is called here to check the DMAB=
UF
state, it is invoked without holding vdev->memory_lock. Because
vfio_pci_bar_is_dmabuf() explicitly uses
lockdep_assert_held(&vdev->memory_lock), executing this unprotected ioctl
will immediately trigger a lockdep kernel splat. Additionally, without the
lock, the state validation is racy and allows conflicting mappings.

> +
> +	ret =3D pci_p2pdma_add_resource(vdev->pdev, bar_index, 0, 0);

[Severity: High]
This is a pre-existing issue, but does the error path in
pci_p2pdma_add_resource() free p2p_pgmap without revoking the devres unmap
action?

In pci_p2pdma_add_resource(), if gen_pool_add_owner() fails, the code jumps
to pages_free and calls devm_kfree(&pdev->dev, p2p_pgmap). However, it fails
to call devm_remove_action() for the earlier successfully added
pci_p2pdma_unmap_mappings action.

When the device is later detached, devres will execute the unmap action on a
freed p2p_pgmap pointer, causing a Use-After-Free.

> +	if (ret && ret !=3D -EEXIST)
> +		return ret;
> +
> +	vdev->p2p_registered_bars |=3D (1 << bar_index);

[Severity: High]
Do the P2P BAR registration state and devres allocations persist across VFIO
file descriptor closures, breaking device isolation?

The pci_p2pdma_add_resource() function ties memory allocations and sysfs
entries to the underlying PCI device (&pdev->dev) using devres. However, wh=
en
a user closes the VFIO file descriptor, vfio_pci_core_close_device() does n=
ot
invoke vfio_pci_zap_bars() to revoke the P2P memory resources or clear
vdev->p2p_registered_bars.

Thus, the P2P sysfs allocations leak across VM sessions until the VFIO driv=
er
unbinds, and subsequent users inherit a polluted, already-registered state.

> +
> +	pci_info(vdev->pdev, "BAR %d registered for ZONE_DEVICE P2P\n",
> +		 bar_index);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610151853.3608=
948-1-praan@google.com?part=3D2
