Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8AE474267;
	Tue,  1 Sep 2026 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256105; cv=none; b=ehjDz7xv0rIxFZtSJ2zmfqmrQzHRTuk7dIb6wBB5JrY4ZApG+/LBfsD+q7KWgd/+n3rw5Q1VTxj50wQG17KBzI7UG5L5vJfq+zhd7XHiIub4OeaVxX5vmyoa8b8Q6dMIzxeAVw79xHqApZG1Oz5/iAtxxWVXVrxzh9h1DsvGZzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256105; c=relaxed/simple;
	bh=Wgdy5Zxm9dUoEas0iUUchcWNPxG+/HKGjpt7VQhYtMQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jk2NbDXH5Gy5RYf3HmGGhulCtsa/7d0ColGHepOVmzS2hehdKlQfNPzjVlmRKxTSVr6WLeTjvYvBjxGpLr3IPRojeczXKeXC0p+26mVcHwMDyzILntjWTOYfIBk3z3JPRztLlg8EKl1yAuC7JighrZBfJvF27OlDhp4ikz5HLKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrYm771C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrYm771C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4DB1F000E9;
	Tue,  1 Sep 2026 09:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788256102;
	bh=nemcfCXwSQLXWvOg8qJNZTFjpVq1VfSIgsjVScww4M0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LrYm771Czst7nRElZpjZHYsFR96IyJUAH7Has9z+muULFHtPFzFWlM4fprRH7ofdj
	 nZOsUIIdCLSCRG/Pj+7bxReUk3ghcaZTFw69PGGJuDWDC/CIha7+78ZCBVIhkFvYP1
	 yaPBaTMOFxZ44aJcs1UZyRa7ux2tCdDuCfx4tu+1F/4i5MRM4by+XmkCNaw7OXJXE0
	 PH48QSQ5IWmENvUwAuXPjBBgNnKZe4l/NCoxeeZGD2M74Xiv/BLLCZrezKPGZk92Nb
	 3x3GAWK7SNLMc3oE6eTPUQlvIJLHZWqX8JIGEMnPEXap+/bAaUUeTmjTebt+m24q6O
	 3SxD4ET9d959Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 12/19] vfio/pci: Serialize physical device
 information queries with recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901093217.8539-13-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-13-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:48:21 +0000
Message-Id: <20260901094822.1E4DB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] VFIO_DEVICE_GET_INFO fails completely during device recovery, cont=
radicting the commit message's intent.

Pre-existing issues:
- [High] Concurrent read-modify-write race on the Physical Function's PCI_E=
XP_DEVCTL2 register when enabling AtomicOps.
--

commit 7eea0a295d5111634553157702a7e697ec8e62ec
Author: Shameer Kolothum <skolothumtho@nvidia.com>

vfio/pci: Serialize physical device information queries with recovery

This commit wraps the AtomicOps capability discovery in VFIO_DEVICE_GET_INFO
with recovery_lock. The lock ensures we do not attempt to read the physical
device configuration space while a PCI recovery is in progress.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1179,7 +1179,13 @@ static int vfio_pci_ioctl_get_info(struct vfio_pci=
_core_device *vdev,
>  		return ret;
>  	}
> =20
> +	ret =3D vfio_pci_core_access_begin(vdev);
> +	if (ret) {
> +		kfree(caps.buf);
> +		return ret;

[Severity: High]
Does this break the availability of the cached information mentioned in the
commit message?

The commit message states:
"The rest of what VFIO_DEVICE_GET_INFO and VFIO_DEVICE_GET_REGION_INFO repo=
rt
is cached or software only, and remains available without taking recovery_l=
ock."

However, if vfio_pci_core_access_begin() fails here (for example, returning
-EIO when a recovery is in progress and access is blocked), we abort the
entire ioctl. Doesn't this deprive userspace of the other cached information
that was supposed to remain available?

Could we skip gathering the atomic capability on access failure rather than
aborting the entire ioctl?

> +	}
>  	ret =3D vfio_pci_info_atomic_cap(vdev, &caps);

[Severity: High]
This isn't a bug introduced by this patch, but can concurrent ioctls on
multiple Virtual Functions trigger a lockless read-modify-write race on the
shared Physical Function hardware register?

In vfio_pci_info_atomic_cap(), we call pci_enable_atomic_ops_to_root() on t=
he
Physical Function device (retrieved via pci_physfn()). That function modifi=
es
the PF's config space:

pci_enable_atomic_ops_to_root()
    pcie_capability_set_word(dev, PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_ATOMIC_R=
EQ);

This performs a lockless read-modify-write sequence on the shared PF hardwa=
re
register. Because down_read(&vdev->recovery_lock) only acquires a read lock
on the local VF's rw_semaphore, it provides no mutual exclusion across
different VFs.

If userspace concurrently issues VFIO_DEVICE_GET_INFO ioctls on multiple VFs
of the same PF, could this clobber concurrent configuration updates like ARI
or LTR toggles on the PF?

> +	vfio_pci_core_access_end(vdev);
>  	if (ret && ret !=3D -ENODEV) {
>  		pci_warn(vdev->pdev,
>  			 "Failed to setup AtomicOps info capability\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901093217.8539=
-1-skolothumtho@nvidia.com?part=3D12
