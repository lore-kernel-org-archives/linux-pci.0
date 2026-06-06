Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC433BB4A;
	Sat,  6 Jun 2026 00:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780705240; cv=none; b=uIPTRRMUKf3QS8dLVOFEu5jwJYQqWRrSdrXLLvTTMFU/QNIXm6lamzlO3h9RVnsHwueKR+Uh26MBRz5F1qHoJrXU66swfDlwojJ2RsQZ+p5l5Todu3cfA+H6iDwPgeR7txmSt81K98LKnwX1qFeqnSC6VkdPN45Ze3OMglWgJ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780705240; c=relaxed/simple;
	bh=GmwpaXntuFULSz70gEdcEIe/DXcA455nmyDJATnbwgE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qu/GXLqvpni/5cTj3gwbvq3tPtwL5ypHm4Lq7gH6FpzJdoNxQOSRIicVyEPDWzOFy5LXDNNaXffB2LdAVXGviEXHsa+9cFCfRqLvmh1pWxdlUTtguKl5177kXtOL21ZClvjUI0uAVpZwk1Tv4AC6yO6Bp21aUlzfEgKIQV1Z8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ierKsVEH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ierKsVEH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7594D1F00893;
	Sat,  6 Jun 2026 00:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780705239;
	bh=6h27/jJZuKC/ucShwNwbROrMLJdcZOaMxuylIy4Yhj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ierKsVEHOhce54fdy0UXz88mVpM7MEXEdfXEah3U2+4kzOhz68n9ghPm69Fz822Yd
	 9MaxKHu/ZnAQgByqY5zcdgvAOwAkqXXPbQbBAC4la4jefZijVOZ3u0/IZip8LDLMtX
	 QAP3y2ztajf18Zvj6jRpgpBjQI3+gH1prQMt9rO9aytw9V82YVzqRlvFKDeaGreGk/
	 B+4uU7oIix964gwPVwRAbq2ADs6HGuAz6SHuJtCudEs87RZh8Y+7IWuoKcrOPptDSt
	 A7Ie1CsbSfAFjDfO8ThdN/+UEeXP+18khVqrzeIdX4vcbEsKYByNVEDFyJWolhDYvw
	 79xoIPW45dYJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 20/23] dmaengine: sdxi: Encode nop, copy, and
 interrupt descriptors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260605-sdxi-base-v3-20-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-20-4d38ca2bdffe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:20:39 +0000
Message-Id: <20260606002039.7594D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Use of WARN_ON_ONCE() for normal input validation leading to pot=
ential DoS, and subsequent dead clamp_val() code.
--

commit 7911601fb1520af0d6b7d063a371eaff05507d92
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Encode nop, copy, and interrupt descriptors

This commit introduces low-level support for serializing nop, copy, and
interrupt operations to the descriptor ring of an SDXI client context.

> diff --git a/drivers/dma/sdxi/descriptor.c b/drivers/dma/sdxi/descriptor.c
> --- a/drivers/dma/sdxi/descriptor.c
> +++ b/drivers/dma/sdxi/descriptor.c
[ ... ]
> @@ -7,12 +7,119 @@
> =20
>  #include <kunit/visibility.h>
>  #include <linux/bitfield.h>
> +#include <linux/bug.h>
> +#include <linux/range.h>
> +#include <linux/sizes.h>
>  #include <linux/types.h>
>  #include <asm/byteorder.h>
> =20
>  #include "hw.h"
>  #include "descriptor.h"
> =20
> +VISIBLE_IF_KUNIT int __must_check sdxi_encode_size32(u64 size, __le32 *d=
est)
> +{
> +	/*
> +	 * sizes are encoded as value - 1:
> +	 * value    encoding
> +	 *     1           0
> +	 *     2           1
> +	 *   ...
> +	 *    4G  0xffffffff
> +	 */
> +	if (WARN_ON_ONCE(size > SZ_4G) ||
> +	    WARN_ON_ONCE(size =3D=3D 0))
> +		return -EINVAL;

[Severity: Medium]
Is WARN_ON_ONCE() appropriate for input validation here?

Since dmaengine_prep_dma_memcpy() doesn't filter out 0 or sizes greater
than 4GB before calling the driver, requesting an unsupported transfer size
will trigger a stack dump, and potentially a system crash if panic_on_warn
is enabled.

> +	size =3D clamp_val(size, 1, SZ_4G);

Also, since the condition above returns -EINVAL for out-of-bounds sizes,
is this clamp_val() call unreachable dead code?

> +	*dest =3D cpu_to_le32((u32)(size - 1));
> +	return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_size32);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-sdxi-base-=
v3-0-4d38ca2bdffe@amd.com?part=3D20
