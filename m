Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92EF3A872C;
	Tue,  2 Jun 2026 06:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780383061; cv=none; b=RX9D8mqx+wzQK6U4c6hGrBLPS33d93qDDgvE1WSL9pfTGUwFyX/1SL2q9MPG5buuc4EaycPQ6j8l/1NrGjxrwbWdjlAcTIRd+T3btUEJuuP4mbaO48san+gS+Ai/xZ2WCreg493nYXVI6Y5xEFUFqapgErDm2+mKYF2nV0NDO6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780383061; c=relaxed/simple;
	bh=BPUjXRR1bjf8yPuJCH6k/2X6z93uVwuROQNG2AYfkqQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WvT1kEFpeDqcywbSdUf9UBUt7VYjjs9nNHQ5T4YDN0n0mMVLcurcS1Nwbqhri+rEo0l7Foj08JkzLcPYe8HtVl1X5fQapdfmOL6Li8SmwhqzGRTVmJUPsUIaY40YHNEXlXP1vCnqkVDTYFHEz2y0Wwn7EwKK5A1dTYOXeI3u1qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFlXXVBI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFlXXVBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B2D1F00893;
	Tue,  2 Jun 2026 06:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780383060;
	bh=FnBF3iZSw3yGYJu7l1ffXAiHjYeAa9z1qOBNyIMOnCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nFlXXVBITTdt5mtpFNgbvsXWmTZ5XwcUau7SWHJznosL86825WoUoZssH5bp+8QOp
	 h7eYmUXlJzE4tQKCs6r03a4MLDEczEmTa+nPNZdy5hPk4eAfZifQUGbEQjbD+g7XB3
	 jSBWufEnVjtZIIlkPWS1A7NSM1Hg7ZIRuYufqcq0WhDasw3UZDlx+Ar+pS7iElPaVF
	 IAvjMaUozpT4CqytruyJsH5nasBjdKETl5zT2LpFkDva5PrKtB2BPpPza+woIDJVuv
	 38RzqJWo9aEVL6vXqQPbfezCGwoSlCZZodMpug+nHE34kCsquqkCXL/6lJVjMkaRKw
	 bDzoFeRFEfBUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankit Agrawal" <ankita@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260602063015.3915-1-ankita@nvidia.com>
References: <20260602063015.3915-1-ankita@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 06:50:59 +0000
Message-Id: <20260602065100.48B2D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Read and write operations spuriously fail with -EAGAIN if they rac=
e with a device reset due to missing retry logic.
--

commit 2aea957cd945c5158a2106e110886e0b017eeb9a
Author: Ankit Agrawal <ankita@nvidia.com>

    vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness check via CXL DVSEC

This commit introduces a CXL DVSEC-based readiness check for Blackwell-Next
GPUs. It adds lockless polling followed by an in-lock non-blocking check,
and updates the probe, fault, read, and write paths to use the new flow.

> diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgra=
ce-gpu/main.c
> index fa056b69f899a..4829ae29cff04 100644
> --- a/drivers/vfio/pci/nvgrace-gpu/main.c
> +++ b/drivers/vfio/pci/nvgrace-gpu/main.c
[ ... ]
> @@ -712,6 +825,12 @@ nvgrace_gpu_read_mem(struct nvgrace_gpu_pci_core_dev=
ice *nvdev,
>  	else
>  		mem_count =3D min(count, memregion->memlength - (size_t)offset);
> =20
> +	if (nvdev->cxl_dvsec && READ_ONCE(nvdev->reset_done)) {
> +		ret =3D nvgrace_gpu_wait_device_ready_cxl(nvdev);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	scoped_guard(rwsem_read, &vdev->memory_lock) {
>  		ret =3D nvgrace_gpu_check_device_ready(nvdev);
>  		if (ret)

[Severity: High]
If a reset races between the lockless wait and the in-lock check, could this
code return -EAGAIN to userspace?

The page fault handler was updated with a retry loop to handle the -EAGAIN
returned by nvgrace_gpu_check_device_ready() when a concurrent reset happen=
s.
However, in nvgrace_gpu_read_mem(), if nvgrace_gpu_check_device_ready()
returns -EAGAIN, that error will be directly propagated to the caller.=20

Returning a spurious -EAGAIN on a standard blocking file descriptor violates
POSIX semantics and may cause unexpected application failures.

Should nvgrace_gpu_read_mem() include the same retry loop around the wait
and lock acquisition as the fault handler?

>  			return ret;
[ ... ]
> @@ -846,6 +965,12 @@ nvgrace_gpu_write_mem(struct nvgrace_gpu_pci_core_de=
vice *nvdev,
>  	 */
>  	mem_count =3D min(count, memregion->memlength - (size_t)offset);
> =20
> +	if (nvdev->cxl_dvsec && READ_ONCE(nvdev->reset_done)) {
> +		ret =3D nvgrace_gpu_wait_device_ready_cxl(nvdev);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	scoped_guard(rwsem_read, &vdev->memory_lock) {
>  		ret =3D nvgrace_gpu_check_device_ready(nvdev);
>  		if (ret)

[Severity: High]
Does nvgrace_gpu_write_mem() have the same missing retry logic?

Similar to the read path, a racing reset could cause this to return a
spurious -EAGAIN to userspace.

>  			return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602063015.3915=
-1-ankita@nvidia.com?part=3D1
