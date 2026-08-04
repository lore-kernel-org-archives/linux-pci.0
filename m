Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657A1DDA9;
	Tue,  4 Aug 2026 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785872792; cv=none; b=Ent3C3GMFWTbGB1AYLOanrObTPl2/7/EtAFQ+hLWys4yZ3+KTj4RNRNvPn2LOjIXdxo1WpobcyEQOLYkN8RJZFt8hY/uRvAZkE6SYUArLU6QP9pCgVU4rr2h0jcYDaphOU3ujscV/nlpVUCTjzJfaNVKN4WpyjRO7p8l+tim6OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785872792; c=relaxed/simple;
	bh=5dcAamCGWtoFox+9QQfum1yD/Fj2Cra+CZl2c5X8fHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A/JBKzDVT3BPjpcRYWc+z9tUYvkNW2mDmBZRNbOsF7FuHQ13tZb90rXmiuakq8dFEMi47ol5ak0Bi/ouDuhWnDCY/mAxIamcjep2VxwjsfkyKPzRKcLulGXwa4JJz+hJDomVIpyGwskeSOYYqBz23G8+OGKwmsECxuBiultli9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ep+B2D3/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ep+B2D3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91171F000E9;
	Tue,  4 Aug 2026 19:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785872791;
	bh=WPM6Q6OX/AqWOOo8tOJa/2NqvRjLYHNHNCu5VtvWoa0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ep+B2D3/IMGjmkoTPcNrgzq4gAT8v6ArWGvAIMhkT0uABoXXOQSWCO7jUe6zF/lmY
	 ZIdINEmm11XNIJnYPuq9MfnB7qb06xsIjtbBAeYx11zHwztFbA2nU56n4cHjJZ993o
	 +I0RfNa6td57ht7zRhWauty7vlIJ1uZfkPuT+mHGLBqv8RZno/kGfnglaLYS6t/GFJ
	 dQyOd5tnOg3L2KMnmA1xJgQZTTBwUwrIwKWPKp75GpcL3zAqTrDotUPP1jyWUAxg+z
	 +tgty7f6ygBs34EOBjq2j8zxQcHOJSBmIwmhrsashmkSx/J+hU7LSzpZxSJfTbKyp5
	 FdutM8+pt938g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 01/12] cxl: Move HDM decoder programming helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260804192958.1823952-2-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 19:46:30 +0000
Message-Id: <20260804194630.D91171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] `resource.o` is incorrectly compiled as a built-in object when `CON=
FIG_CXL_BUS` is a module, causing fatal linker errors and breaking kernel m=
odularity.
--

--- Patch [1]: [PATCH v10 01/12] cxl: Move HDM decoder programming helpers =
---
commit b0d203a772e57924b3e867594bb9a15ce55bf00c
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Move HDM decoder programming helpers

Move the low-level HDM decoder programming helpers from hdm.c into
resource.c so they can be shared by later reset restore code.

> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
[ ... ]
> @@ -243,4 +244,7 @@ config CXL_ATL
>  	depends on CXL_REGION
>  	depends on ACPI_PRMT && AMD_NB
> =20
> +config CXL_HDM
> +	bool
> +
>  endif
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) +=3D cxl_core.o
> +obj-$(CONFIG_CXL_HDM) +=3D resource.o

[Severity: Low]
When CONFIG_CXL_BUS is configured as a loadable module (m), CONFIG_CXL_HDM
evaluates to 'y' because it is defined as a bool in the Kconfig.

Does this incorrectly assign resource.o to the built-in obj-y list instead
of appending it to the cxl_core-y list?

[ ... ]
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> --- /dev/null
> +++ b/drivers/cxl/core/resource.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
> +#include <linux/delay.h>
> +#include <linux/bug.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/kernel.h>
> +
> +#include "cxl.h"
> +#include "core.h"
> +
> +struct cxl_rwsem cxl_rwsem =3D {
> +	.region =3D __RWSEM_INITIALIZER(cxl_rwsem.region),
> +	.dpa =3D __RWSEM_INITIALIZER(cxl_rwsem.dpa),
> +};
> +EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");

[Severity: Low]
Are these internal locks being unnecessarily exported to the global
symbol table as a workaround for the Makefile defect?

If resource.o is properly compiled as part of the cxl_core module, we
shouldn't need to export them here.

[ ... ]
> +void cxl_setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
> +{
> +	int id =3D cxld->id;
> +	u64 base, size;
> +	u32 ctrl;
> +
> +	/* common decoder settings */
> +	ctrl =3D readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> +	cxld_set_interleave(cxld, &ctrl);
> +	cxld_set_type(cxld, &ctrl);
> +	base =3D cxld->hpa_range.start;
> +	size =3D range_len(&cxld->hpa_range);
> +
> +	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id)=
);
> +	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id)=
);
> +	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +
> +	if (is_switch_decoder(&cxld->dev)) {

[Severity: Low]
Because resource.o may be built-in, won't this call to is_switch_decoder()
cause an undefined reference linker error when it attempts to resolve this
module-bound symbol from cxl_core.ko?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804192958.1823=
952-1-smadhavan@nvidia.com?part=3D1
