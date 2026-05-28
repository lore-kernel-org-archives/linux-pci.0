Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670C63612D8;
	Thu, 28 May 2026 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779963736; cv=none; b=eiNzv9OaP/XUT3cudfQmSbhqo6D+NJGYCK8WO+VRUz2MpYYrK3Vk53F+vGa+jzb2vpA+H9L7duV4nmUBqiC2X14FW1F2hVm5dcnqmWxl3aw+rjYqjXrmSNBK8NTXf2Zt/VTngBEFx4+YC8B/C+foewFYxSOxmj5zUE9KhlroNDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779963736; c=relaxed/simple;
	bh=hXn7ZvPzhthx+OdAaHDKUl2queVc/bnAHoooLyWA5ZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IramauJVyOhlg0zfk1YOTtqzylTi+7hUQdJLw4flkozc/b8H4seT7Tkg+eYqLWnbNBxz+H+z98QdiBIPyaEBxQ6VvzNwhuKYACsb3OsQOkSSQ5l7Xapvyj6aUd0y4sbz6DwHM/KFJsQWZaKBuNTq1hyzko+sOhyRZ55QjzCyD3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/ewSVdp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/ewSVdp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D221F000E9;
	Thu, 28 May 2026 10:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779963735;
	bh=0sv7qFHe7C9PU5aBfxhtmDXPIWcf4oqJAJXq2oF5Msc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e/ewSVdpEsM227NTwG2WmGM5kv3KGc7bqRy/NcP0naRdGo+p4gh6OGEhAg4/pOmY9
	 howEz0CwT0fR0AYd2JMrr5V8TDvKiPDWA5FFn9DJDSDZym0G/L9eu98mdiDjE7b9Ow
	 7srq6wfzEVtxfrtwU+hmO01v8s0aewjG+m+S4MusYmYCO5TzCYkmLTV5Kn09LNzn80
	 yRznyZ5uUlMPuNfh0OCOyVMJCYStFfRjvdoxO3O4xfRaiwliL3ZiusywUjXsuTClvu
	 Y3Px0Z4qB0vBhLUiLrQG4u8r9b4F/cpiVGsJOwYagkwbr3XcsBsKigc08C+sCOoW88
	 NW8PEDbLTWelg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankit Agrawal" <ankita@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260528093840.4018-1-ankita@nvidia.com>
References: <20260528093840.4018-1-ankita@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 10:22:14 +0000
Message-Id: <20260528102214.D2D221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] TOCTOU race in lockless device readiness checks causes unexpected =
-EAGAIN or VM_FAULT_SIGBUS errors instead of waiting for the device.
- [High] The 256-second device readiness polling uses uninterruptible `msle=
ep()` loops, which can trigger hung task panics and renders user tasks unki=
llable.
--

commit a85819b2171b67b275d15e9b87eb7447b4dd63a4
Author: Ankit Agrawal <ankita@nvidia.com>

vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness check via CXL DVSEC

Adds a CXL DVSEC-based readiness check for Blackwell-Next GPUs in addition
to the existing legacy BAR0 polling. The device readiness is determined by
polling the Memory_Active bit outside the memory lock for up to 256 seconds.

> diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgra=
ce-gpu/main.c
> index fa056b69f899a..04fcc0d088f54 100644
> --- a/drivers/vfio/pci/nvgrace-gpu/main.c
> +++ b/drivers/vfio/pci/nvgrace-gpu/main.c

[ ... ]

> +static int nvgrace_gpu_wait_device_ready_cxl(struct nvgrace_gpu_pci_core=
_device *nvdev)
> +{
> +	unsigned long deadline =3D jiffies + msecs_to_jiffies(POLL_QUANTUM_MS);
> +	bool active_phase =3D false;
> +	u32 status;
> +	int ret;
> +
> +	for (;;) {

[ ... ]

> +		if (time_after(jiffies, deadline))
> +			return -ETIME;
> +
> +		msleep(POLL_QUANTUM_MS);
> +	}
> +}

[Severity: High]
Will this uninterruptible sleep trigger hung task panics?

Since the CXL device readiness can take up to 256 seconds and msleep() plac=
es
the task in the TASK_UNINTERRUPTIBLE state, processes accessing the device
during a reset will become unresponsive and immune to signals (including
SIGKILL) for up to 4 minutes.

With the default Linux hung_task_timeout_secs at 120 seconds, blocking here
is highly likely to trigger the hung task detector and cause a kernel panic
on systems with hung_task_panic enabled. Would it be better to use an
interruptible sleep and abort on pending fatal signals?

[ ... ]

> @@ -313,6 +399,21 @@ static vm_fault_t nvgrace_gpu_vfio_pci_huge_fault(st=
ruct vm_fault *vmf,
>  	pfn =3D PHYS_PFN(memregion->memphys) + addr_to_pgoff(vma, addr);
> =20
>  	if (is_aligned_for_order(vma, addr, pfn, order)) {
> +		/*
> +		 * Exit early under memory_lock to avoid a potentially lengthy
> +		 * device readiness wait on a runtime-suspended device. Any
> +		 * race after the lock is dropped is benign as the re-check
> +		 * inside the scoped guard below catches it.
> +		 */
> +		scoped_guard(rwsem_read, &vdev->memory_lock) {
> +			if (vdev->pm_runtime_engaged)
> +				return VM_FAULT_SIGBUS;
> +		}
> +
> +		if (nvdev->cxl_dvsec && READ_ONCE(nvdev->reset_done) &&
> +		    nvgrace_gpu_wait_device_ready_cxl(nvdev))
> +			return VM_FAULT_SIGBUS;

[Severity: High]
Can this lockless check race with a concurrent device reset and bypass the
intended polling mechanism?

If a concurrent device reset finishes and sets reset_done =3D true right af=
ter
this lockless check evaluates to false, the thread proceeds without polling
and blocks waiting for memory_lock.

Once the lock is acquired, the thread calls nvgrace_gpu_check_device_ready()
which observes reset_done =3D=3D true and invokes the fallback
nvgrace_gpu_test_device_ready_cxl() under the lock. Because this CXL test is
non-blocking, it immediately returns -EAGAIN, causing
nvgrace_gpu_vfio_pci_huge_fault() to return VM_FAULT_SIGBUS and crash user
applications instead of waiting.

> +
>  		scoped_guard(rwsem_read, &vdev->memory_lock) {
>  			if (vdev->pm_runtime_engaged ||
>  			    nvgrace_gpu_check_device_ready(nvdev))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528093840.4018=
-1-ankita@nvidia.com?part=3D1
