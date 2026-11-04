Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761376;
	b=pTvxu8L6T6G1CXklI2TCwpia8WZFkXJ7Ex3JMt4Lw8A7V97rSFe52U7yJUbMhzndePYY
	 mN8rlpvZrfxGRz+ogyAi9yWL/f30y7hse8G/9Vd6g1gk3d4rUWjI4kSrC4//ET8dz30a8
	 BOfzQrW3B7u/fkLR/RYCkJQPrh4JGyWARyYptz2f6KFgAu4hvuVlCMokspnC+w3+NLRAo
	 AfECSvR69ClJyM3PMaG5JJzCDTYC33pTyr31zUGIO3FZiz8Mwi2DoXvQ3JHS0cTU/uPO4
	 I5q3r9zayy7M7U/+V+f2utBAZiyJ4w1Wg+luCdif8khDdgMC9v42+agAcWPCojmAO5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761376;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O6SIJl06X0hKWq006bz/Wp39eQ6GQs+lTEApu23MXDA=;
	b=v8H9sRG/pmpBw0DhYrnMk7G1zY10VVrLy4/vQXtmnLXFFBPvdVTWP4fUJaS7xGMfo2dJ
	 Vm3B2akHpsczvZ2qok7JqyKYU/d174vmM9ZKG8REIUG5JRQDBt6ObksEj5RGiixqJ/WT0
	 ritJ1dsFkub77G+RkM936rsAA+cDTlP3QaUU9M8u+Va6Mu8pxagGZFzSDoP51VmCy8Zv4
	 EFlVxHm/Huq5G1/BjdiArxch7q+tQDhr5PSbwGUzHpWe3GWutymT/gop3uJU8Dmt1nGnx
	 +Gm14KFWh2OZo9KebjQKyQRMeqehpdTlNAdb0NUDPrtL77DFqmedaJaZELLx3+8uynQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdL74kjo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF51606A31B;
	Wed,  4 Nov 2026 03:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdL74kjo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE2D1F000C1;
	Wed,  4 Nov 2026 03:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761375;
	bh=O6SIJl06X0hKWq006bz/Wp39eQ6GQs+lTEApu23MXDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LdL74kjokfnaGMw7WzeyCGWpeyL7JH+xEGDpVVdJR1xHLKtrNzewkbLRSKLVcqUE+
	 GBh6pi6Eh+vCCEzKy+/3JgsHlHpC59Hcblu99uTs3YrJ+aXB9R/7vtAdpIb9AmJlwz
	 SBnWUcqgdnA055rEVJNvIdhWaorWTRE8rG6MLL8wjk4cWTl9AGdT5x66vrKg3tyF5p
	 q1Qv1vrkP+9q+Kz/uObLRMjlbZAr4Vz2Suk6ik2zZ2NdNeiTtKCCrgiEDgB19hF7de
	 PtZ9SwI1U5PyTV3POoedffbNldVTovp9oCcGxurGzvnzxQJp2+ZefH4cpcemxDQEkQ
	 Gm3fDS0vVPNsA==
Message-ID: <sashiko-outbox-196564@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/25] dmaengine: sdxi: Add unit tests for descriptor
 ring reservations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261103-sdxi-base-v4-14-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-14-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:02:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dmaengine: sdxi: unused mock KUnit device in setup_device()
--

commit 73b5f711479c1dbab69a55b0e9eb01abd747309e
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Add unit tests for descriptor ring reservations

This commit adds hardware-independent KUnit tests for SDXI descriptor ring
reservations, covering full-ring and single-slot reservations, invalid coun=
ts,
inconsistent indices, insufficient space, and bounded reservations across r=
ing
wrap.

> diff --git a/drivers/dma/sdxi/ring_kunit.c b/drivers/dma/sdxi/ring_kunit.c
> new file mode 100644
> index 0000000000000..7df85fc5549c6
> --- /dev/null
> +++ b/drivers/dma/sdxi/ring_kunit.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SDXI descriptor ring management tests.
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +#include <kunit/device.h>
> +#include <kunit/test-bug.h>
> +#include <kunit/test.h>
> +#include <linux/container_of.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <linux/overflow.h>
> +#include <linux/packing.h>
> +#include <linux/string.h>
> +
> +#include "ring.h"
> +#include "submission.h"
> +
> +MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
> +
> +/* A submission queue backed by plain memory; no device or DMA required.=
 */
> +static struct sdxi_sq *alloc_sq(struct kunit *t, u32 count)
> +{
> +	struct sdxi_sq *sq;
> +
> +	sq =3D kunit_kmalloc(t, struct_size(sq, ring, count),
> +			   GFP_KERNEL | __GFP_ZERO);
> +	if (sq)
> +		sq->count =3D count;
> +	return sq;
> +}

[ ... ]

> +static int setup_device(struct kunit *t)
> +{
> +	struct device *dev =3D kunit_device_register(t, "sdxi-mock-device");
> +
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(t, dev);
> +	t->priv =3D dev;
> +	return 0;
> +}
> +
> +static struct kunit_suite generic_desc_ts =3D {
> +	.name =3D "SDXI descriptor ring management",
> +	.test_cases =3D testcases,
> +	.init =3D setup_device,
> +};

[Severity: Low]
As noted in the comment above alloc_sq(), the submission queue is backed by
plain memory and does not require a struct device or DMA.

However, generic_desc_ts wires up setup_device() as its .init callback, whi=
ch
registers "sdxi-mock-device" via kunit_device_register() and stores it in
t->priv before each test case (valid(), invalid(), and
bounded_reservations()), even though nothing in ring_kunit.c ever reads
t->priv.

Is setup_device() needed here, or can it (along with the unused
kunit/device.h, linux/container_of.h, linux/dma-mapping.h, linux/packing.h,
and linux/string.h includes) be dropped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D14
