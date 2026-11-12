Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494824;
	b=Fwb8iTiAfmLuH4HM8OYJlwSESRvZuoAWfszZiXrqin1hgrjovBw8iu/wCz+ydwXh3n13
	 F06HVNj97RM+3tW4VfIkT/PSJDLBZPJRBPQZTto9I3ennZgIzy4C43X4JgglADTEtpIc4
	 11GKQepadyGE4Z2vpMbRhA/q9IVUzE0wLeoR4XkTxcp/ezpL9rv/SugU9QTH9mdoPxGq1
	 q4uyD6nlqtbCHF3mDbKJYUNO7hUjdwHUzCltmGNzWzTQXz3uq+ETuUcOiYbWceSYac26i
	 wKOGeDVTyFiBQE3lfM6rubzlsg5p/JBvr/9rwTqVqL5NoQG3KoEDqwkqkDAsgDLVtSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494824;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/sI9ftla+VY6fpQdVbCFxddsP+aGVLAyaKEHm8V8lwY=;
	b=FT7D1vhth+fYGWalhmvA24II21OMQ+UkZ1tvA72UGuNQgyRrl+mGAW+8U5KXgFGwbIO6
	 Te73RwFpACp04DiJSVqsQ5KW+5pQdil7TcVHGrAc/Z0iYFW8d+dWsNGbdCar/TjwfVrfF
	 J6EQprBFQnd2Swz607f69tKPvgUnPnq9KvSqf73mXre8eIPAw6cr8xWzagAupeXuOvqYP
	 513lH2vEgIcsEIwEDWlzGcOwl/Vy7kTwVgeT+kwaFpKmuH8yVqwaj25q8N1nV9227RHoa
	 MF13BAINQTjLS+HhFh0vxZvG56GAT6Ah7jxqVroe9/EkrP1x+T/akAba5QQFp1OyXKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOu0IRpR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1F6606A32E;
	Thu, 12 Nov 2026 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOu0IRpR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA2B1F00A05;
	Thu, 12 Nov 2026 14:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794494824;
	bh=/sI9ftla+VY6fpQdVbCFxddsP+aGVLAyaKEHm8V8lwY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DOu0IRpRGdAldGvPPdf0bdNRpkZKUUa6sxb+7kmEG32E5QRAo3lwicDEOmyxatKqz
	 m4fJXoDhqt6m0WfQPN+f0oC7yLHgb4FIStFRhJaPVN+qozpielcBdkBRixkhBrspcz
	 n0UnGC/Y7ZzRvc9Ag39k7XASO1vRTTLNgmPfl9aEO1ce561/ozJLHY4WAo2cT3n3oe
	 sdzfZvfMH9Usoa4D9UYqWSLYvcv4jsUu98WYzpKOh0CyyVRZGn1n2L8qpNRvdOJpMl
	 f8C4KxRj3lcGstqKWVKUqNSqFdapNVoqTZfX7NYVb1RysoNPC5yQMfm088vTvSlIbV
	 UrUnXMCt9dY5g==
Message-ID: <sashiko-outbox-211378@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 11/20] vfio/pci: Use access ops for hardware
 information queries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>, kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261112141632.918954-12-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
 <20261112141632.918954-12-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:47:03 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] vfio/pci: VFIO_DEVICE_GET_INFO fails with -EIO on VF when PF is
  closed
- [Medium] vfio/pci: lockdep circular locking dependency in
  vfio_pci_access_atomic_cap()
--

commit 8a20ca42b1e7365162ac6cecdd060d990d426a4f
Author: Shameer Kolothum <skolothumtho@nvidia.com>

vfio/pci: Use access ops for hardware information queries

This commit routes AtomicOps and ROM region hardware information queries
through VFIO PCI access ops so they participate in device error recovery.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index fc6b2673be88c..da7166669dc75 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1178,6 +1178,33 @@ static int vfio_pci_info_atomic_cap(struct vfio_pc=
i_core_device *vdev,
>  	return vfio_info_add_capability(caps, &cap.header, sizeof(cap));
>  }
> =20
> +static long vfio_pci_access_atomic_cap_target(struct vfio_pci_core_devic=
e *vdev,
> +					      void *data)
> +{
> +	return vfio_pci_info_atomic_cap(vdev, data);
> +}
> +
> +static long vfio_pci_access_atomic_cap(struct vfio_pci_core_device *vdev,
> +				       void *data)
> +{
> +	struct vfio_pci_core_device *pf_vdev =3D vdev->sriov_pf_core_dev;
> +
> +	if (!pf_vdev || !pf_vdev->pci_recovery_supported)
> +		return vfio_pci_info_atomic_cap(vdev, data);
> +
> +	/*
> +	 * VF AtomicOps queries read the PF's configuration. The PF association
> +	 * lasts until VF removal, but its SRCU instance exists only while
> +	 * the PF is open.
> +	 */
> +	guard(mutex)(&pf_vdev->access_lock);

[Severity: Medium]
Can locking pf_vdev->access_lock here trigger a lockdep circular locking
warning?

vfio_pci_ioctl_get_info() calls vfio_pci_core_access() on the VF, which
takes srcu_read_lock(&vdev->access_srcu) before entering
vfio_pci_access_atomic_cap() and acquiring pf_vdev->access_lock.  Because
every struct vfio_pci_core_device initializes access_lock and access_srcu
at the same mutex_init() and init_srcu_struct() call sites, the VF and PF
share lockdep classes.

Meanwhile, vfio_pci_core_close_device() holds vdev->access_lock while
vfio_pci_core_block_access() calls synchronize_srcu(&vdev->access_srcu),
establishing the opposite access_lock -> access_srcu class order:

CPU0                              CPU1
----                              ----
lock(&vdev->access_lock)
                                  srcu_read_lock(&vdev->access_srcu)
                                  lock(&pf_vdev->access_lock)
synchronize_srcu(&vdev->access_srcu)

 *** DEADLOCK ***

CPU0: vfio_pci_core_close_device() -> vfio_pci_core_block_access()
CPU1: vfio_pci_ioctl_get_info() -> vfio_pci_core_access() ->
      vfio_pci_access_atomic_cap()

> +	if (!pf_vdev->device_open)
> +		return -EIO;
> +
> +	return vfio_pci_core_access(pf_vdev, vfio_pci_access_atomic_cap_target,
> +				    data);
> +}
> +
>  static int vfio_pci_ioctl_get_info(struct vfio_pci_core_device *vdev,
>  				   struct vfio_device_info __user *arg)
>  {
> @@ -1209,10 +1236,12 @@ static int vfio_pci_ioctl_get_info(struct vfio_pc=
i_core_device *vdev,
>  		return ret;
>  	}
> =20
> -	ret =3D vfio_pci_info_atomic_cap(vdev, &caps);
> +	ret =3D vfio_pci_core_access(vdev, vfio_pci_access_atomic_cap, &caps);
>  	if (ret && ret !=3D -ENODEV) {
> -		pci_warn(vdev->pdev,
> -			 "Failed to setup AtomicOps info capability\n");
> +		if (ret !=3D -EIO)
> +			pci_warn(vdev->pdev,
> +				 "Failed to setup AtomicOps info capability\n");
> +		kfree(caps.buf);
>  		return ret;
>  	}

[Severity: High]
Does this cause VFIO_DEVICE_GET_INFO on a VF to fail with -EIO whenever its
recovery-capable vfio-pci PF is not currently open in userspace?

A PF bound to vfio-pci does not need to stay open while its VFs are in use;
for example, userspace can open the PF only long enough to configure
vf_token and then close the PF fd before opening VFs, while
vfio_pci_core_sriov_configure() keeps the PF in PCI_D0.  When
pf_vdev->device_open is false, vfio_pci_access_atomic_cap() returns -EIO
and vfio_pci_ioctl_get_info() aborts the entire ioctl, breaking
VFIO_DEVICE_GET_INFO on healthy VFs even if AtomicOps are not supported.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141632.9189=
54-1-skolothumtho@nvidia.com?part=3D11
