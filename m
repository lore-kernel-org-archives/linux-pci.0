Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2C93655F5
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 23:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715217; cv=none; b=IbXkrbAzNT4jSrxr87H27+LB/1UK0DHvxuy0a60LAa0iTsVGrEBngDzFvidkNwUwhUoL80iYoYnvfFDORekPsW8+RJarU2QAciTPYg2g9Hn8rHcL50C5pN8FNDWh+p/VZQisdSooz3fTDA93xNtHQpvmCdBerz5oGehH+5KWZrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715217; c=relaxed/simple;
	bh=xx3LRBwjbmGKH3r+lt9z4nQIENtnvZbU6PYI+tSxCbQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RIILKrKA9OBvXRJOR8WEHEy9INKRDI9ObdRwfkOq2eSHHAhrINEXXKp0Ujwp3xUSrIG81gqubbdZsGGp82x6a34MK4Y6/cQWdJo+Nbuy2KF30/CH7H9H3MhoYYXMMfry0YAb2XSCjhjtX9GDUY9CPJK4OxxmrLiunt3lTiR8s10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrVV9cmp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrVV9cmp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51CDC19425;
	Wed, 13 May 2026 23:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778715217;
	bh=xx3LRBwjbmGKH3r+lt9z4nQIENtnvZbU6PYI+tSxCbQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MrVV9cmpWZm4YFIrDr5gUUjIQ/HvYZWUfZyy6SQgy2tBlWt8WVs/1phSa8cmQgjEa
	 xMeyK6hgkoGtTfc2iC94ioOgXdgLPTV15koqZH3PJLD4A6yqlFj4NA87iBtZDdJD8/
	 cMUKw0Ga2i4dKVG1ucsgaE19ifZ6P3vl8hyrtH6rZvwIhyNbHzQKFFuTLy0NnvEDlo
	 5cWqzPuVVTYu8/Hx9J1K8k2AM3MbcLmFN1ZiemdLs2gKopGDbNF8ulnYtx8CF7Pu6o
	 TQFM74qv5gus0+zTsshlA4ydJWwy7NxJ8RWUeFzEG5CvWiPpDle5zSejRxw3cFUg7b
	 lG+Vsa1avswcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/16] vfio: selftests: Verify that opening VFIO
 device fails during Live Update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vipin Sharma" <vipinsh@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260511234802.2280368-16-vipinsh@google.com>
References: <20260511234802.2280368-16-vipinsh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 23:33:36 +0000
Message-Id: <20260513233336.D51CDC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unconditionally testing all legacy IOMMU modes will cause the se=
lftest to crash on kernels lacking legacy VFIO support.
--

commit 15d06d7e17051c89eae8198f7b5a759b9968ab87
Author: David Matlack <dmatlack@google.com>

vfio: selftests: Verify that opening VFIO device fails during Live Update

Verify that opening a VFIO device through its cdev file and via
VFIO_GROUP_GET_DEVICE_FD both fail with -EBUSY if the device was
preserved across a Live Update.

> diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.=
c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
> index 15b3e3af91d1e..65c48196e44e7 100644
> --- a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
> +++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c

[ ... ]

> @@ -36,6 +36,42 @@ static void before_kexec(int luo_fd)
>  	daemonize_and_wait();
>  }
> =20
> +static void check_open_vfio_device_fails(void)
> +{

[ ... ]

> +	for (i =3D 0; i < nr_iommu_modes; i++) {
> +		if (!iommu_modes[i].container_path)
> +			continue;
> +
> +		iommu =3D iommu_init(iommu_modes[i].name);

Does this introduce a regression on kernels lacking legacy VFIO support?

If the kernel is compiled without legacy VFIO support (CONFIG_VFIO_GROUP=3D=
n),
calling iommu_init() on a legacy container path like /dev/vfio/vfio will
fail.

This causes iommu_init() to fail its internal assertion, calling
VFIO_LOG_AND_EXIT() and aborting the process. Because this standalone test
program does not use kselftest_harness process isolation, crashing here
prevents it from verifying the core live update functionality.

Could we verify the container path is accessible before calling iommu_init()
so unsupported modes can be gracefully skipped?

> +
> +		device =3D vfio_pci_device_alloc(device_bdf, iommu);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511234802.2280=
368-1-vipinsh@google.com?part=3D15
