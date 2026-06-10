Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2703E9C1F;
	Wed, 10 Jun 2026 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106011; cv=none; b=NQmB2oMMxdVpb2Ez77bHV2gYgXrmYFWmPx8AgYu8EA+tFIS5h8xrJzEbJV7i+GhQ/kvYW3ibD8t8gEjjtBgbSeTTQ4ipFGwObV8UtV33opuA/Yu9jRQKGeJzl8vU3bJChUblsv+yf4Yl5Pfru0SmdB3qT2dOxOI2SZikwo6qJlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106011; c=relaxed/simple;
	bh=alrLfy5fk/KyG+e0pFkWzJ52xmU6csfMmgQCHTQ7qNI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nFEtcOD/0rlTnnwGnU98RxjtUfJf18oRsWNnti/Gz1/fhQmJ32cyB7JH84VIkHVBG2FTvdYP3+6fUbelIJbAwamLu8WG7dWW3J2aBUtbjXWITd/i2nkpmkhOvYnU7ylsgUyY6DDU9Gin+ReTfb7yg8zU5dSbuWPyw2mH3AwEzG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idFbMdRL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idFbMdRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAFA1F00893;
	Wed, 10 Jun 2026 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106010;
	bh=3+9avbs7wvye8/aHMeteesLyjn/TSyU5cjQohl0BwVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=idFbMdRLZRlbP/BTggmRGulFFaMJwvXJ8RMOUJEi5q5z70zPCmK55LXTLx3F5nf0j
	 X2Fu5rENxkzZce9kxvkjJHkLWF8pW/4J2MLWrhYMeorv5Eq1BtvTtrpRY0ZBJIg3Th
	 /mGZIWSw03fsrcyjBiBwilQZ5qv5S+nRnxo64hSzF9PreQS+mM86fs9CUMRY9xG4uH
	 exucEiMiCLIkMCalcThGeI6XdGR6MLCA39KVgY6OQ7g4iA7JQWOjrv8bYflF+uW6BK
	 9MO7clY4fwH9tsz5OzJ/QfIx1AMHMzrpADNKUTv6NftDy0lQl6kdgdB6W420AiyOTx
	 1QC9DGFSZcheg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/5] vfio/pci: Block mmap & dmabuf export for
 ZONE_DEVICE-registered BARs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260610151853.3608948-4-praan@google.com>
References: <20260610151853.3608948-4-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 15:40:09 +0000
Message-Id: <20260610154010.0BAFA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Mutual exclusivity between P2P registration and userspace mapping =
is only enforced in one direction, allowing trivial bypass.
- [High] Unsynchronized read-modify-write of the `p2p_registered_bars` bitm=
ask can lead to lost updates, bypassing mutual exclusivity.
- [High] Time-Of-Check to Time-Of-Use (TOCTOU) race condition between P2P r=
egistration and mmap/dmabuf export.
- [Medium] Un-ratelimited `pci_warn()` calls can be triggered by unprivileg=
ed users to flood the kernel log.
--

commit 34d8b3426f32368f81ae51a26bcaccb5ac86b1c0
Author: Pranjal Shrivastava <praan@google.com>

vfio/pci: Block mmap & dmabuf export for ZONE_DEVICE-registered BARs

Update vfio_pci_core_mmap() &  vfio_pci_core_feature_dma_buf() to
enforce mutual exclusivity with ZONE_DEVICE P2P registration.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 1e922e3aaeb3a..9cf494b765e72 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1828,6 +1828,13 @@ int vfio_pci_core_mmap(struct vfio_device *core_vd=
ev, struct vm_area_struct *vma
>  	if (!vdev->bar_mmap_supported[index])
>  		return -EINVAL;
> =20
> +	if (vdev->p2p_registered_bars & (1 << index)) {

[Severity: High]
Does this check adequately enforce mutual exclusivity if the user performs
operations in the reverse order?

While this prevents mmap() after P2P registration, if a user calls mmap()
first and then issues the VFIO_DEVICE_FEATURE_P2P_REGISTER ioctl, it appears
they can have both active simultaneously. Looking at
vfio_pci_core_feature_p2p_register(), there is a check for dmabufs but it
lacks a check for active mmaps.

[Severity: High]
Is this check susceptible to a time-of-check to time-of-use race?

This check of vdev->p2p_registered_bars is performed locklessly. A concurre=
nt
thread could potentially call VFIO_DEVICE_FEATURE_P2P_REGISTER immediately
after this check succeeds, but before the mapping is fully established.

[Severity: High]
Are updates to vdev->p2p_registered_bars synchronized to prevent lost updat=
es?

Looking at vfio_pci_core_feature_p2p_register(), the bitmask is updated usi=
ng
a non-atomic read-modify-write operation:

    vdev->p2p_registered_bars |=3D (1 << bar_index);

If multiple threads register different BARs concurrently without locks, cou=
ld
this cause a lost update? A lost update would leave the bit clear, allowing
subsequent mmaps to incorrectly bypass this mutual exclusivity check.

> +		pci_warn(vdev->pdev,
> +			 "BAR %d registered for P2P. Use sysfs to allocate\n",
> +			 index);

[Severity: Medium]
Could this un-ratelimited warning allow an unprivileged user to flood the
kernel log?

Since this is triggered directly by the mmap() syscall, a user with access
to the VFIO device could repeatedly call mmap() in a loop, displacing
legitimate logs. Would it be better to use pci_warn_ratelimited() here?

> +		return -EBUSY;
> +	}
> +
>  	phys_len =3D PAGE_ALIGN(pci_resource_len(pdev, index));
>  	req_len =3D vma->vm_end - vma->vm_start;
>  	pgoff =3D vma->vm_pgoff &
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
> index c16f460c01d68..6635a86812918 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -251,6 +251,12 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_co=
re_device *vdev, u32 flags,
>  	    IS_ERR(vfio_pci_core_get_iomap(vdev, get_dma_buf.region_index)))
>  		return -ENODEV;
> =20
> +	if (vdev->p2p_registered_bars & (1 << get_dma_buf.region_index)) {

[Severity: High]
Could a concurrent thread bypass mutual exclusivity here due to a lack of
synchronization?

This check happens before acquiring vdev->memory_lock. If another thread
concurrently registers the BAR for P2P after this check passes but before
the dmabuf export completes, could both operations succeed concurrently?

> +		pci_warn(vdev->pdev, "BAR %d registered for native P2P. Use sysfs for =
allocation.\n",

[Severity: Medium]
Similarly to the mmap() path, could this un-ratelimited warning be
triggered in a loop by userspace calling the VFIO_DEVICE_FEATURE ioctl?

> +			 get_dma_buf.region_index);
> +		return -EBUSY;
> +	}
> +
>  	dma_ranges =3D memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_range=
s,
>  				       sizeof(*dma_ranges));
>  	if (IS_ERR(dma_ranges))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610151853.3608=
948-1-praan@google.com?part=3D3
