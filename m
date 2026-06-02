Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140EF311C32;
	Tue,  2 Jun 2026 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412393; cv=none; b=IcKLOPRDqhAGCWoOeRD5dRCgQH039s0FL1Umz5rB5U6GXgNK9x+wM929K7YhtytKaVMvGsY0EmLeoqImhTYJAVJApX10LQy++0cv70ZcUqQEbX2/G24xfUWLnHvrEddFVBsQukjVe2iaEpVIbSyndo4oU8OlAzioL8CMksVH9kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412393; c=relaxed/simple;
	bh=CysDP+xA0VNMRJptiUeLmw6UvHZ9oc15DIzt4HdnTsQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LF0QArVr2lHGKnft2zx83Xzdu+9ThU6VZrt4e0u24o4tWJpJWVHD2nF/K9XlDyJ2Hq7z4oXRBbKlvRmubZtrI0eJC1MRW5Vr8FaH++Et+hYlm/fgp0q3mwv1oB8M+giAQ87Fwd++yIxo8JtcvkHJp/VNE/yeiQjbGETRUlEz2Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ON7y1ksJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ON7y1ksJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9662F1F00893;
	Tue,  2 Jun 2026 14:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780412391;
	bh=XRWknaaE93HtnsFs7RAOkIEWAoABaJwcrnKqp1jCTM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ON7y1ksJyh6bQqva3pdjIbga/A67E2dx0bqo2EV0w6JLZWvuZY9PUPhd/ddhBrHRT
	 KCXgimbK4avPZopg/iNow+H2ywl/MR2vzGtXkPukLzLwLU8ORXFWuI0iEWMKSPdJW1
	 yjYZJ3xawI8MTusSxrhwLx2xuPZ0DhgREWsVs+TV9LNdp04rUiidzX1mK2H2SUmUC/
	 stH31cW6qmwI1V9pIQPIy6yDGDGQRuQk35cwavXitATRQRevP4AsE0rWER18gh9co0
	 Y3ziLuf86UeViy/iqFMtFlkxQ3iE2BQ76lWKXW6pjb2T78x6zm+zWyn6RfyrXVqekY
	 P89xJWR48IP1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 08/10] vfio/pci: Add
 VFIO_DEVICE_FEATURE_TPH_ST_CONFIG for PCIe TPH ST configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260602144023.25254-9-fengchengwen@huawei.com>
References: <20260602144023.25254-9-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 14:59:50 +0000
Message-Id: <20260602145951.9662F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Direct PCI power state transition circumvents runtime PM framework=
, desynchronizing state and permanently pinning the device in D0.
--

commit 5cde11824ca121c81daa6babe1b10dd11a812286
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST_CONFIG for PCIe TPH ST configurati=
on

This commit introduces a new VFIO device feature to configure PCIe TPH
Steering Tag table entries. It implements a shadow ST table to cache entries
protected by a per-device mutex, and adds an enable_unsafe_tph module
parameter to gate the feature.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> +static int vfio_pci_core_feature_tph_st_config(
> +			struct vfio_pci_core_device *vdev,
> +			u32 flags,
> +			struct vfio_device_feature_tph_st_config __user *arg,
> +			size_t argsz)
> +{
[ ... ]
> +	uptr =3D u64_to_user_ptr(config.data_uptr);
> +	sts =3D memdup_array_user(uptr, config.count, sizeof(u16));
> +	sz =3D config.count * sizeof(u16);
> +	if (IS_ERR(sts))
> +		return PTR_ERR(sts);
> +
> +	down_write(&vdev->memory_lock);
> +	ret =3D vfio_pci_set_power_state(vdev, PCI_D0);
> +	if (ret)
> +		goto out_unlock_memory;

[Severity: High]
Does this direct power state transition circumvent the runtime PM framework?

By calling vfio_pci_set_power_state() directly instead of using
pm_runtime_resume_and_get(), it looks like this might fail to wake up
upstream bridges. If the device was previously placed in a low power state
and the parent bridge is asleep, accessing the device's configuration space
or MSI-X table during pcie_tph_set_st_entry() could cause a bus error.

Additionally, this bypasses the runtime PM usage counter, leaving the PM
core unaware that the device is active. Since there is no corresponding log=
ic
to restore the previous power state on exit, will this leave the device
permanently pinned in D0 and break idle power savings?

> +
> +	mutex_lock(&vdev->tph_lock);
> +
> +	if (pcie_tph_enabled_req_type(pdev) =3D=3D PCI_TPH_REQ_DISABLE)
> +		goto update_shadow;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602144023.2525=
4-1-fengchengwen@huawei.com?part=3D8
