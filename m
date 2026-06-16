Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9850C3624D4;
	Tue, 16 Jun 2026 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607938; cv=none; b=EQgOwaiZrUnzfYV7ap29gYJlvwF743ygZUxBY74884itBC3c66r0DcNoFanhs3pKsAt8IHLb7EGA+hWaMmzOcFUfXeAkLYXFaH3/KTjWyLnZE4ySXNV7VeZB61OJnqJ5m9fTnfMccaUT4gLaY1/YtOQyACS5DqvPpmEPF7ly0K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607938; c=relaxed/simple;
	bh=N6NC9jpZ6Ze8vB+w+RHsaMDK6hfXmyAo9X1gtpfmksA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gGGXdM+F8HOv9XmZyGMghPRIaTb//uw2spzBTY3J8VfwOV2YTDlBjVatgOjHNgMHAYbQ1ctZajIvCAvqBiav0kfLEnKQ9QKMUDkfZpgEiMMJSQlNSREhQaoExhXH64xJvhaJ5wwEWnGhbGhXLxAZzU/VvLV3RmWn+z1wnGeuayU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIXpTEKa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIXpTEKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FF31F000E9;
	Tue, 16 Jun 2026 11:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781607936;
	bh=tfwXy717mn8upErheQgD1DpJRN3OfRCXMVW3Nl0mAMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HIXpTEKaILa6tkDkvOPqAinjsSWaam9dmyf8QkgH9GUJNP6qmLSeVQe1B19Pb+hv/
	 GJk+LNMgNNmy1qlljMIlzHnq+oKuoZ3ITfXtJzMWVEw2pIy14UKrGqpRU4dV3bh+CK
	 GE0ARQ5msqDXo3yDDrvmeNCqDDD3HfSnPwmVR162HngKm1bQ0sGcWjI8+QPglLGGmW
	 f4a+tlQ8LiaU+neTjzI9/ZKo1a6JtgskDM5qWddOZP3rRBu28+uYga4UNK6NiCTb5E
	 /iChA3xN1qmzA7m+twFMA7TAYNRaQog58ElAYJcN35OrvDWOywx09guIZvIlS024mV
	 DqDp2l/7G4Xeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 11/12] vfio/pci: Add TPH_ST_CONFIG for PCIe TPH ST
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260616104621.41915-12-fengchengwen@huawei.com>
References: <20260616104621.41915-12-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 11:05:35 +0000
Message-Id: <20260616110536.12FF31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Improper PM Runtime handling and missing dmabuf restoration in TPH=
 ST configuration ioctl.
- [Medium] Missing __GFP_ACCOUNT in tph_st_shadow allocation.
- [Medium] The `tph_permit` flag is leaked across VFIO user sessions.
- [Medium] Feature PROBE for `TPH_ST_CONFIG` is broken due to an early dyna=
mic permission check.
- [Medium] The TPH ST shadow table is not cleared when the VFIO device is r=
eset, leading to stale data restoration.
--

commit b8ec8f816e02c6def8f7cc759648796f130131e0
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add TPH_ST_CONFIG for PCIe TPH ST configuration

This commit adds a new VFIO device feature VFIO_DEVICE_FEATURE_TPH_ST_CONFIG
to allow userspace to configure PCIe TPH Steering Tag table entries. It
implements a shadow ST table to cache entries, paired with a per-device mut=
ex
for concurrent access protection.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index ae05343701f76..cf8f6de025c9a 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c

[ ... ]

> @@ -495,6 +496,50 @@ static const struct dev_pm_ops vfio_pci_core_pm_ops =
=3D {

[ ... ]

> +static int vfio_pci_tph_init(struct vfio_pci_core_device *vdev)
> +{
> +	vdev->tph_st_entries =3D 0;
> +	vdev->tph_st_shadow =3D NULL;
> +
> +	if (!enable_unsafe_tph)
> +		return 0;
> +
> +	vdev->tph_st_entries =3D vfio_pci_tph_st_shadow_size(vdev);
> +	if (vdev->tph_st_entries) {
> +		vdev->tph_st_shadow =3D kcalloc(vdev->tph_st_entries, sizeof(u16),
> +					      GFP_KERNEL);

[Severity: Medium]
Since this per-device allocation is triggered by a userspace container
session, should it use GFP_KERNEL_ACCOUNT instead of GFP_KERNEL? Omitting
the account flag might allow a container to allocate unaccounted kernel
memory and bypass its memory cgroup limits.

> +		if (!vdev->tph_st_shadow)
> +			return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void vfio_pci_tph_deinit(struct vfio_pci_core_device *vdev)
> +{
> +	kfree(vdev->tph_st_shadow);
> +	vdev->tph_st_shadow =3D NULL;
> +	vdev->tph_st_entries =3D 0;

[Severity: Medium]
Should vdev->tph_permit be reset to 0 here during session exit?

Because vdev persists across open/close cycles until unbound from the drive=
r,
a subsequent user session might inherit the tph_permit =3D=3D 1 state,
bypassing the API requirement to explicitly enable TPH.

> +}

[ ... ]

> @@ -1535,6 +1587,74 @@ static int vfio_pci_core_feature_tph_enable(struct=
 vfio_pci_core_device *vdev,

[ ... ]

> +static int vfio_pci_core_feature_tph_st_config(
> +			struct vfio_pci_core_device *vdev,
> +			u32 flags,
> +			struct vfio_device_feature_tph_st_config __user *arg,
> +			size_t argsz)
> +{
> +	struct vfio_device_feature_tph_st_config config;
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	void __user *uptr;
> +	int i, idx, ret;
> +	size_t sz;
> +	u16 *sts;
> +
> +	if (!vdev->tph_permit || !vdev->tph_st_shadow)
> +		return -EOPNOTSUPP;

[Severity: Medium]
Will this early check break feature discovery?

VFIO allows discovering supported features using the
VFIO_DEVICE_FEATURE_PROBE flag. By checking !vdev->tph_permit before
calling vfio_check_feature(), any early capability PROBE request returns
-EOPNOTSUPP. This might make userspace incorrectly assume the kernel does
not support configuring the feature.

> +
> +	ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> +				 sizeof(config));
> +	if (ret <=3D 0)
> +		return ret;

[ ... ]

> +	uptr =3D u64_to_user_ptr(config.data_uptr);
> +	sts =3D memdup_array_user(uptr, config.count, sizeof(u16));
> +	sz =3D config.count * sizeof(u16);
> +	if (IS_ERR(sts))
> +		return PTR_ERR(sts);
> +
> +	down_write(&vdev->memory_lock);
> +	ret =3D vfio_pci_set_power_state(vdev, PCI_D0);

[Severity: High]
Does this bypass the driver core's power management and miss dmabuf
restoration?

If the parent bridge is in a suspended state (e.g., D3cold), calling
vfio_pci_set_power_state() without first calling pm_runtime_resume_and_get()
can lead to bus errors (Unsupported Request) or system crashes.

Additionally, if the device was previously in a suspended state, does this
path also need to call vfio_pci_dma_buf_move(vdev, false) to restore dmabufs
and prevent permanently breaking dmabuf tracking?

> +	if (ret)
> +		goto out_unlock_memory;
> +
> +	if (pcie_tph_enabled_req_type(pdev) =3D=3D PCI_TPH_REQ_DISABLE)
> +		goto update_shadow;

[ ... ]

> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 0b411d2136ed5..d5c6f73747ad9 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -143,6 +143,8 @@ struct vfio_pci_core_device {
>  	struct notifier_block	nb;
>  	struct rw_semaphore	memory_lock;
>  	struct list_head	dmabufs;
> +	u16			*tph_st_shadow;

[Severity: Medium]
When a VFIO device is reset (e.g., via the VFIO_DEVICE_RESET ioctl or FLR),
its hardware ST table typically reverts to its default (zeroed) state.

Should the reset path (vfio_pci_ioctl_reset()) clear vdev->tph_st_shadow?

If not, a subsequent partial ST_CONFIG write or TPH enablement via config
space might incorrectly program the hardware with stale, pre-reset ST values
cached in the shadow table.

> +	u16			tph_st_entries;
>  };
> =20
>  enum vfio_pci_io_width {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616104621.4191=
5-1-fengchengwen@huawei.com?part=3D11
