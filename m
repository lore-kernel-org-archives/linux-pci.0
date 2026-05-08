Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79F165192
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778211789; cv=none; b=V7CGlPMxdbvS/T0SycUoIGO49F5KhQpzN4Y6+IAEdptMseUUWcMBEs/Qp1/NWq/NCjum7vQ0MG7GxmzLk61PviZfQ/A8L3dX2t87mYxchbRNmvTozX1WKZqaHowcIV8RGbT1peQbd93bTnrvuaYMKCo3i9DIt2VkPh7P01W/+iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778211789; c=relaxed/simple;
	bh=e648FWE7GOnQcDzOwhFweU4Cuje+PbzlCVNdyxsRpds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KVOf5ezenM6l+nW9CByWfN8gONu/Uasgrqqh6MCpqjewavODb2qnl1HW5CIAAMF+33MQ63C/yYRhQkGnqdEGko6oNiWMGJIfgrMNAZBO3t0UPB434I95WWSXw8BgnazwumSR7MEXYXn6hJQwrWMx5Km6QH5pSdtg2oJ/qPBBO2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHv5SGGl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHv5SGGl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D6DC2BCB0;
	Fri,  8 May 2026 03:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778211789;
	bh=e648FWE7GOnQcDzOwhFweU4Cuje+PbzlCVNdyxsRpds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nHv5SGGlobC1+OcSWXc1wVCOJhfUgaXsFICvYy16eX43mOfaWuBXYYfhdLRuS+0Ax
	 Ivd4TkYozqrGnEfdGhfnTRhWoMcXQyUt+JZc3pO2s1adfS+pk7vd8/RFFF+XSzJ4uQ
	 GqxAMU9H1wJ90BkcxExzpMfXyVmHEJA9T1pxvad1ky5lXjoXD35AtHDp9b6brlvoHr
	 xxjg/bOz32QpmjqavOgZu0ctz+uNe4JUdbJcRxJ1dzvR5E1dpQa6AOu0YCNHz8ONS6
	 tU6dgxFpias40+fUU01DSq47TKG0tfkwYmXNKYh2yiMYpOfrkgKPpZ+ctbMOIFWfo9
	 X/3UV3Gn8vOqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/18] rust: add bindings for hash.h
Reply-To: sashiko@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260508031710.514574-6-alistair.francis@wdc.com>
References: <20260508031710.514574-6-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 03:43:08 +0000
Message-Id: <20260508034309.58D6DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Unintended exposure of <linux/hash.h> to Rust bindings.
- [Low] Alphabetical sorting rules are violated in bindings_helper.h and he=
lpers.c.
--

commit d4762d094c0da15881ab9c843fc2316ba4792255
Author: Alistair Francis <alistair.francis@wdc.com>

rust: add bindings for hash.h

This commit exposes crypto_shash_descsize(), crypto_shash_digestsize(),
and crypto_free_shash() to Rust by adding them to the C helpers and
updating the bindings include lists.

> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 446dbeaf08668..d73142078240f 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -30,6 +30,7 @@
> =20
>  #include <linux/acpi.h>
>  #include <linux/gpu_buddy.h>
> +#include <crypto/hash.h>
>  #include <drm/drm_device.h>
>  #include <drm/drm_drv.h>

This isn't a bug, but does this addition break the alphabetical sorting of
the includes?  It looks like <crypto/hash.h> is being inserted between
<linux/gpu_buddy.h> and <drm/drm_device.h>.

[ ... ]

> @@ -60,6 +61,7 @@
>  #include <linux/file.h>
>  #include <linux/firmware.h>
>  #include <linux/fs.h>
> +#include <linux/hash.h>
>  #include <linux/i2c.h>

The commit message mentions adding bindings for crypto/hash.h.  Is the
addition of linux/hash.h intended here?

It doesn't appear that utilities from linux/hash.h are being used, which
could unnecessarily increase bindgen execution time and pollute the
Rust namespace.

> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 625921e27dfbc..6372e14f8419c 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -60,6 +60,7 @@
>  #include "dma-resv.c"
>  #include "drm.c"
>  #include "err.c"
> +#include "hash.c"
>  #include "irq.c"
>  #include "fs.c"
>  #include "gpu.c"

This isn't a bug, but does inserting hash.c here also bypass alphabetical
sorting?

While it is placed before irq.c, both fs.c and gpu.c appear further down in
the existing list, so placing hash.c after gpu.c might keep this block more
properly ordered.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508031710.5145=
74-1-alistair.francis@wdc.com?part=3D5
