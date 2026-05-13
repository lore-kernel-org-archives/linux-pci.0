Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DC2385D72
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778706771; cv=none; b=Bhjz5RofXgdxY+kUGBODrvUVLDEDlgttuIH8eJTOI3nbbMjsKQbEG95rHHpH5+v1Ksjhl0fYrRjGFwvJ4K0ncGvYDEVrv1I6Zzb7gBynDT6tuEgPwvqrYzIElGVBOS7i3GGhMjZSF3riSAsoYlLIi8ApwqPOX+jtG+7Rv4TEhiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778706771; c=relaxed/simple;
	bh=2unqWykgfHgjydLg8gQ/WlLIyZfE+woLrUNg6m1VJ2I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aEVLs6oO3UVGsD5wryms9Zss8Z5Sv4qIrKSUzO14slXRPZrv+DDdG0F1tynQG+kya70xmqMkYltbO7Lxo2XMCAynsMM6eSrmpyroSKko+9YiiJS6nsDtSYUnKnjuxsxuMkb0o3a2KK/FTsGDabBe/d+fZRNo0HBcK3VIuUzR0B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hA41h300; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hA41h300"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258CAC19425;
	Wed, 13 May 2026 21:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778706771;
	bh=2unqWykgfHgjydLg8gQ/WlLIyZfE+woLrUNg6m1VJ2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hA41h300cmlt2oSa6ac7rgUNksNwTlznzL0eXxMFXMKWJXeEa9BuPxaVXip2PaWRv
	 p9cYp3Y3M9npSH6XwjHL1plXR0WsrOd+k9kGDz0hY2Zg1O6VQW3w6EEhSBoORth3BW
	 MRLuM6mbeNhPWhERV8Kcsa716Tikmcuxyg2s4rFQIKIv10FuVkiuO+/YUoelptpmRf
	 g/wxSHIYSuB92Ma/6f16O4zLZsT2iJoOC/UMEY9Gi7qwo0CAUbDgwgMK8Id6aW6FQq
	 plYcvGg8ZOASK2SLzbCJEgj9KXRp/QoIgd2nXe3+vfvY9NNP+c8JPTpPffkEWZjLto
	 cCzUmL6STDbkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/16] vfio: selftests: Add
 vfio_pci_liveupdate_uapi_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vipin Sharma" <vipinsh@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260511234802.2280368-10-vipinsh@google.com>
References: <20260511234802.2280368-10-vipinsh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 21:12:50 +0000
Message-Id: <20260513211251.258CAC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] FIXTURE_TEARDOWN unconditionally dereferences NULL pointers and =
closes stdin if FIXTURE_SETUP fails.
- [Low] The test file fails to build due to missing dependencies, headers, =
and undefined functions.
--

commit 483a2948059fa012eaf9d233845cda79f05f7acb
Author: David Matlack <dmatlack@google.com>

vfio: selftests: Add vfio_pci_liveupdate_uapi_test

Add a selftest to exercise preserving a various VFIO files through
/dev/liveupdate. Ensure that VFIO cdev device files can be preserved and
everything else (group-based device files, group files, and container
files) all fail.

> diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c=
 b/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c
> new file mode 100644
> index 0000000000000..1d89b08ab0a4a
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <libliveupdate.h>

Are there missing files or dependencies in this commit? This test fails to
build because <libliveupdate.h> does not exist anywhere in the source tree.

Also, luo_session_preserve_fd() has no userspace implementation available (=
it
only exists as an internal static kernel function).

Additionally, the vfio selftest Makefile depends on
../liveupdate/lib/libliveupdate.mk (introduced by a missing commit), which
is completely missing from the tree. This results in immediate compilation
and linker failures.

[ ... ]

> +FIXTURE_SETUP(vfio_pci_liveupdate_uapi_test)
> +{
> +	self->luo_fd =3D luo_open_device();
> +	ASSERT_GE(self->luo_fd, 0);
> +
> +	self->session_fd =3D luo_create_session(self->luo_fd, "session");
> +	ASSERT_GE(self->session_fd, 0);
> +
> +	self->iommu =3D iommu_init(variant->iommu_mode);
> +	self->device =3D vfio_pci_device_init(device_bdf, self->iommu);
> +}
> +
> +FIXTURE_TEARDOWN(vfio_pci_liveupdate_uapi_test)
> +{
> +	vfio_pci_device_cleanup(self->device);
> +	iommu_cleanup(self->iommu);
> +	close(self->session_fd);
> +	close(self->luo_fd);

Will this cause a segmentation fault if an assertion fails during setup?

In the kselftest framework, the fixture state (self) is zero-initialized via
mmap. If an assertion in FIXTURE_SETUP fails (for example,
ASSERT_GE(self->luo_fd, 0)), the framework aborts setup and immediately cal=
ls
FIXTURE_TEARDOWN.

Since self->device and self->iommu would be unassigned and thus NULL in this
scenario, vfio_pci_device_cleanup() and iommu_cleanup() will dereference
NULL pointers.

Additionally, since self->session_fd would be 0, close(self->session_fd) wi=
ll
inadvertently close stdin.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511234802.2280=
368-1-vipinsh@google.com?part=3D9
