Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51A61DBB3A;
	Tue, 26 May 2026 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779775765; cv=none; b=kV5UEblZsfiIzVIN8Ut4j2Awcx4nyjvAz4qdDhKZXyHWncthSlST/fyfEKYW8ShxnnUv9PfiWMOvJcsEZ992pFFhQg/1RNPA1yb7RgSitrzwfGzrTnitPITIXoMOjRNWU0DL//jA6pDTaJuqn+RvYvl2v4a4nLq+OiX7IjHWLGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779775765; c=relaxed/simple;
	bh=U322n/qX24WfW4XoPi3jiVoFQsdKe4rjCXM0VoA8UAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hyzvvDMnORGtk2A4OsXpVWFEpU9LtLJUvfQLJBE73cXoq+Sxo7Qaq6S7mdvAUAOoU4yjRzim8eEEn7jWiKCsdE8ujb9VPkTVGrlC6OT7RTUs0T4h+zCCm+5FSy+LwYi1YV/iSMa6R9js7YjFGME2kHj5VE3fO0mGhJhfbz/7j8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAUzbUJ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAUzbUJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F8B1F000E9;
	Tue, 26 May 2026 06:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779775763;
	bh=PQAoBHyGvx1uYfDXigDRWV5iHFLDA1yCWhVIGyAiJws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YAUzbUJ60VVfwaxgNHXYBA+JaIicPKOSBxay8bM0MF4HoEijYTzGfI8NE8brGGSim
	 06fN06Yw5DyLtQpB9QOpgeKbIWCp/KpYbOuEI0X2SfJijS/jdDmRlak6xXS80bM3UC
	 5jGzRmlVea4Iynw0DA9MEsvMa87EkTjpvsFrpoiHAwX8p1NGA1qxfSdXBH496aWXsx
	 PuxxW52On1f/H6yejgfbQke03TuJEOJdbXukB4iYUyIEFSAXNlgII6DCAdt96YVU2x
	 q6ayMvNlXveQHodUElSEwZ2xuTLX87wd+KXThmREspE+7RcAxrHjL5sKlHktJkrG9E
	 TqnD6dg9aURVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 5/6] vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST for
 PCIe TPH steering tag management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260526040830.52854-6-fengchengwen@huawei.com>
References: <20260526040830.52854-6-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 06:09:22 +0000
Message-Id: <20260526060923.30F8B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The return value of `copy_to_user()` is mishandled in `vfio_pci_tp=
h_op_cpu_query()`, resulting in a positive return value to userspace on mem=
ory faults.
- [High] Hardware modifications to the ST table via MSI-X MMIO occur withou=
t ensuring the PCI device is in an active power state (e.g., D0), risking P=
CIe errors.
- [Low] Unconditional memory allocation for the TPH ST shadow table during =
device initialization, even when the TPH feature is globally disabled.
--

commit 467d413fb2d015dba9001b9372af0200c578a4c6
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST for PCIe TPH steering tag manageme=
nt

Add new userspace device feature to access and maintain PCIe TPH Steering
Tag table entries, supporting two mutually exclusive operation modes:
raw table read/write and CPU ID lookup.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 3f8d093aacf8a..8cf341689a478 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -1516,6 +1518,159 @@ static int vfio_pci_core_feature_token(struct vfi=
o_pci_core_device *vdev,
[ ... ]
> +static int vfio_pci_tph_op_cpu_query(struct vfio_pci_core_device *vdev,
> +				     struct vfio_device_feature_tph_st *arg)
> +{
[ ... ]
> +	for (i =3D 0; i < arg->count; i++) {
> +		ret =3D pcie_tph_get_cpu_st(pdev, mtype, cpus[i], &st);
> +		if (ret)
> +			goto out;
> +		cpus[i] =3D st;
> +	}
> +
> +	ret =3D copy_to_user(uptr, cpus, arg->count * sizeof(u32));
> +out:
> +	kfree(cpus);
> +	return ret;

[Severity: High]
Does this return a positive value to userspace if the copy fails?=20
copy_to_user() returns the number of bytes that failed to copy, so returnin=
g=20
it directly here instead of a negative error code like -EFAULT might break=
=20
the ioctl ABI, as userspace typically checks for negative error codes.

> +}
> +
> +static int vfio_pci_core_feature_tph_st(struct vfio_pci_core_device *vde=
v,
> +					u32 flags,
> +					struct vfio_device_feature_tph_st __user *arg,
> +					size_t argsz)
> +{
[ ... ]
> +	switch (op_type) {
> +	case VFIO_TPH_ST_OP_RAW_TABLE:
> +		if (is_set && is_get)
> +			return -EINVAL;
> +		return vfio_pci_tph_op_raw_table(vdev, is_get, &tph_st);

[Severity: High]
Is it possible for the device to be in a suspended power state (e.g., D3hot=
)=20
when this ioctl is called?=20

If userspace triggers this while suspended, the subsequent call to=20
pcie_tph_set_st_entry() might perform direct MMIO writes to the MSI-X table.
Accessing MMIO on a suspended device can cause PCIe Unsupported Request (UR)
errors or Target Aborts.=20

Should there be a pm_runtime_resume_and_get() or similar power state check=
=20
before accessing hardware registers?

> +	case VFIO_TPH_ST_OP_CPU_QUERY:
> +		if (is_set)
> +			return -EOPNOTSUPP;
> +		return vfio_pci_tph_op_cpu_query(vdev, &tph_st);
> +	default:
> +		return -EINVAL;
> +	}
> +}
[ ... ]
> @@ -2097,12 +2254,23 @@ int vfio_pci_core_init_dev(struct vfio_device *co=
re_vdev)
>  	mutex_init(&vdev->igate);
>  	spin_lock_init(&vdev->irqlock);
>  	mutex_init(&vdev->ioeventfds_lock);
> +	mutex_init(&vdev->tph_lock);
> +	vdev->tph_st_entries =3D vfio_pci_tph_st_shadow_size(vdev);
> +	vdev->tph_st_shadow =3D NULL;
> +	if (vdev->tph_st_entries) {
> +		vdev->tph_st_shadow =3D kcalloc(vdev->tph_st_entries, sizeof(u16),
> +					      GFP_KERNEL);

[Severity: Low]
Does this code unconditionally allocate memory for the shadow table even wh=
en=20
the enable_unsafe_tph module parameter is false?=20

While the allocation is relatively small, operations will be rejected with=
=20
-EOPNOTSUPP anyway if the feature is disabled globally. Perhaps this=20
allocation can be avoided entirely in that case to save kernel memory.

> +		if (!vdev->tph_st_shadow)
> +			return -ENOMEM;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526040830.5285=
4-1-fengchengwen@huawei.com?part=3D5
