Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D863A16A1
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625026; cv=none; b=oDYc1DvxAQg3ku1BX13J9ql460cecvN4beZg+eCa2GvwRjmWzJAGv/8v+CPnEbczR2IHhkmUVe3MheJUpaK5fimbA7H+NntDQhUd43dow0y6fNJ3efg2eYU0d0JYi27ZqSClIg10E+ss5mIyfUSL+DN4EryiX95WhmbL3FZTteQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625026; c=relaxed/simple;
	bh=uQEcj6PcMZGDjWJCqnfcEsl9zni6ymxoo0u78VOAB0c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MLiVsnyZjJAPa3JhnWYftPvP0OOOCbn0jsUI3+do6cBaLvjImHgEv4vrOQa/IMwUwDiKttqvsulMhdNNsvnT0mpJoicSdLASeTw2jrjhj2GZEX/Ed3RcrR39d+ZrE/tcTH0ai4fhzHRyXhYMYBgSMRdI6j6va6j0XxkmxlvifcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngpBwM+9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngpBwM+9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072B1C2BCB8;
	Tue, 12 May 2026 22:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778625026;
	bh=uQEcj6PcMZGDjWJCqnfcEsl9zni6ymxoo0u78VOAB0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ngpBwM+9UKa9ZhGF/MNzpkqzCZbs2+lj5Iz+aPVkhHm0FTGTq7XMniPhtorPFPBAX
	 wvVEPwEW9+0ussDP9XjzGAzX5iWPWKZX98vZYV0fujqh27H1GbJZYujfnKEr8sdcZa
	 Elu0K0SWNY6T7TdDXHlAm4w8ZMY5yHbaDeAdAL3AXk2ZNw1eNIaoWNzgrM4aVsBwHf
	 uKbccWMhFyaSuF6Dczacav7xEeqOynycw2hXAnrwyUbkgn4EscBJfelZugaDX4WszM
	 pMjwdovVrs2I/1DJQAWPZ/qupGL7ooqpuXW74KNAikVsJF0q70fHzTvPqmkq3WaVPW
	 bGCIcNOc9zFMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Reply-To: sashiko@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260511162408.1180069-4-zhangyu1@linux.microsoft.com>
References: <20260511162408.1180069-4-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 22:30:25 +0000
Message-Id: <20260512223026.072B1C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Sleeping in atomic context on PREEMPT_RT due to spin_lock() inside=
 local_irq_save().
- [High] Global state corruption and dangling pointer on IOMMU initializati=
on failure.
- [Medium] Undefined behavior and potential integer overflow in IOMMU geome=
try calculation.
- [Medium] IOMMU driver destructively clears generic dma_ops in release_dev=
ice.
- [Low] Missing ida_destroy() on the error cleanup path in hv_iommu_init().
--

commit d1b032eaf8fbec1a7366bf47848a4dfd4a2d21b6
Author: Yu Zhang <zhangyu1@linux.microsoft.com>
Subject: iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest

This patch adds a para-virtualized IOMMU driver for Linux guests on Hyper-V.
It implements stage-1 IO translation via hypercalls and manages x86-compati=
ble
page tables in guest memory.

> diff --git a/drivers/iommu/hyperv/iommu.c b/drivers/iommu/hyperv/iommu.c
> new file mode 100644
> index 0000000000000..e5fc625314b55
> --- /dev/null
> +++ b/drivers/iommu/hyperv/iommu.c
[ ... ]
> @@ -215,14 +230,19 @@ static void hv_iommu_detach_dev(struct iommu_domain=
 *domain, struct device *dev)
[ ... ]
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id =3D HV_PARTITION_ID_SELF;
> +	if (hv_iommu_lookup_logical_dev_id(pdev, &input->device_id.as_uint64)) {

Could this cause a sleeping in atomic context BUG on PREEMPT_RT kernels?

When hardware interrupts are disabled via local_irq_save(), this code calls
hv_iommu_lookup_logical_dev_id(), which does:

    spin_lock(&hv_iommu_pci_bus_lock);

On PREEMPT_RT, spinlock_t maps to an rt_mutex which can sleep. Acquiring a
sleepable lock while hardware interrupts are disabled will cause a crash.

Would it be safer to hoist the ID lookup outside the local_irq_save() block,
since it does not appear to rely on the per-CPU input page state? Similar
logic is also present in hv_iommu_attach_dev() and
hv_iommu_get_logical_device_property().

[ ... ]
> +static void hv_iommu_release_device(struct device *dev)
> +{
> +	struct hv_iommu_endpoint *vdev =3D dev_iommu_priv_get(dev);
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +
> +	if (pdev->ats_enabled)
> +		pci_disable_ats(pdev);
> +
> +	dev_iommu_priv_set(dev, NULL);
> +	set_dma_ops(dev, NULL);

Is it safe to explicitly clear the generic dma_ops here?

Device DMA operations are typically managed by the core DMA mapping subsyst=
em.
Clearing them directly strips the device of fallback operations like SWIOTLB
during device teardown or unbind.

If there are outstanding DMA mappings, could this cause subsequent unmap
calls to execute without valid operations, potentially leaking bounce buffe=
rs?

[ ... ]
> +static void __init hv_init_iommu_device(struct hv_iommu_dev *hv_iommu,
> +			struct hv_output_get_iommu_capabilities *hv_iommu_cap)
> +{
> +	ida_init(&hv_iommu->domain_ids);
[ ... ]
> +	hv_iommu->geometry =3D (struct iommu_domain_geometry) {
> +		.aperture_start =3D 0,
> +		.aperture_end =3D (((u64)1) << hv_iommu->max_iova_width) - 1,

Can this shift result in undefined behavior if the hypervisor returns
a max_iova_width of 64 or greater?

If 5-level paging is supported, there doesn't appear to be an upper
bound validation on max_iova_width. On x86, shifting by 64 or more
will be masked modulo 64, making 1ULL << 64 evaluate to 1, and
resulting in an aperture_end of 0.

Would it be better to cap max_iova_width at a safe maximum before
performing this calculation?

[ ... ]
> +int __init hv_iommu_init(void)
> +{
[ ... ]
> +	iommu_detected =3D 1;
> +	pci_request_acs();
> +
> +	hv_iommu =3D kzalloc_obj(*hv_iommu, GFP_KERNEL);
> +	if (!hv_iommu)
> +		return -ENOMEM;
> +
> +	hv_init_iommu_device(hv_iommu, &hv_iommu_cap);
> +
> +	ret =3D hv_initialize_static_domains();
> +	if (ret) {
> +		pr_err("static domains init failed: %d\n", ret);
> +		goto err_free;
> +	}
[ ... ]
> +err_sysfs_remove:
> +	iommu_device_sysfs_remove(&hv_iommu->iommu);
> +err_delete_static_domains:
> +	hv_delete_device_domain(&hv_blocking_domain);
> +	hv_delete_device_domain(&hv_identity_domain);
> +err_free:
> +	kfree(hv_iommu);
> +	return ret;
> +}

If initialization fails and we jump to err_free, does this leave global sta=
te
corrupted?

The global pointer hv_iommu_device is assigned to hv_iommu during
hv_init_iommu_device(), and iommu_detected is set to 1. When hv_iommu is
freed, these globals aren't cleared.

Could this leave a dangling pointer and trick the core architecture into
believing a hardware IOMMU is functional, potentially skipping fallback
mechanisms like SWIOTLB?

Also, should there be a call to ida_destroy(&hv_iommu->domain_ids) in this
cleanup path to prevent leaking internal XArray nodes allocated by ida_init=
()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511162408.1180=
069-1-zhangyu1@linux.microsoft.com?part=3D3
