Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A52B375F7C;
	Wed, 13 May 2026 03:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778644472; cv=none; b=VVrkpfAcFiOYgf+0qUfK3teHiCzZg1sFrlKqGAhaF7Ym9hr9floeYaoCz5C2CJF28gGa88rSZYCh6QCXTP3CO0bT6pKMFueikqwKsHRBgwyw0ZSqBCFcQn1Tch9W1yYc7RoKVDMp/yKjfTo8DuQbM1qISQBYoLAm5S7w4hZBuDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778644472; c=relaxed/simple;
	bh=p4u93eZYM7ImmEMVxoOiAAqCgTpTSRI042sRxK1qoek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d+hvmhxLfntk+WbmY/7aD0VknEDwsdA4V0xTG9Ca/+Y5swrqIyA8mrVB5SroHFNZZNfEDSnQXM/tmpZhE9xrhD0ujqzzXMk5mz1OY3Yla0u++CywdbReZ3OVakxjFYUcdEA9PZd1LqEt4mH69rt1xgC3PO84bUKPiAXOkrQ6H/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLOY+Hp/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLOY+Hp/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FEFC2BCC7;
	Wed, 13 May 2026 03:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778644471;
	bh=p4u93eZYM7ImmEMVxoOiAAqCgTpTSRI042sRxK1qoek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=FLOY+Hp/LYnNHfJh86CHnyGWTG0G8wwrWyPrCavpinVbn2kYpTPxKC3gvXgh/CqdU
	 qRb4tpfvd/KXzloBIzYfWaacxcg7Xbe4C6mzmsRIXYjOFc16PU2wK9ViOAAL6WYWzd
	 SCCnhoVSg+DgPehJBUSU6g7cTWMzTuI02RkyyP9iqIChuklRhJd7J6T69X9eePXgJO
	 626du6/d1rMV0x6QtWBnXQyCtXafAY8e0ge24Ns6Wv10miwfuvHudoqFzfbYG1B/sv
	 2z1vKLPKic3j1PVuXz+OdjzCoR7vzrCTCcx6woCLnW5jrxAwOoSBrVoMZeCGNo+DP7
	 fAeil9AVNnhMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/23] dmaengine: sdxi: Complete administrative
 context jump start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260511-sdxi-base-v2-10-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-10-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 03:54:30 +0000
Message-Id: <20260513035431.41FEFC2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Using a non-atomic 64-bit fallback for a hardware doorbell registe=
r causes torn writes and device state corruption on 32-bit architectures.
--

commit 1c8a47b1b7cac23ca82b3d7ffe7b54c6cf98827e
Author: Nathan Lynch <nathan.lynch@amd.com>
dmaengine: sdxi: Complete administrative context jump start

This commit completes the SDXI administrative context initialization by
writing to its doorbell once the function is placed in the active state.
It introduces a new helper function for pushing the doorbell, which will
be used across all descriptor submission paths.

> diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
> index 65b773446ba31..8dd6beb7a6424 100644
> --- a/drivers/dma/sdxi/context.h
> +++ b/drivers/dma/sdxi/context.h
> @@ -7,6 +7,7 @@
>  #define DMA_SDXI_CONTEXT_H
> =20
>  #include <linux/dma-mapping.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>

Does including linux/io-64-nonatomic-lo-hi.h in a shared header risk
polluting the compilation unit? It appears this might blindly convert all
missing 64-bit I/O operations into non-atomic fallbacks for any file that
includes context.h.

>  #include <linux/types.h>
> =20
>  #include "hw.h"

[ ... ]

> @@ -58,4 +59,9 @@ struct sdxi_cxt {
> =20
>  int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
> =20
> +static inline void sdxi_cxt_push_doorbell(struct sdxi_cxt *cxt, u64 inde=
x)
> +{
> +	iowrite64(index, cxt->db);

On 32-bit architectures without native 64-bit I/O, the non-atomic fallback
splits this 64-bit write into two 32-bit writes (lower 32 bits, then upper
32 bits).

Since this is a doorbell register that triggers hardware actions, could a t=
orn
write expose a transient, invalid index to the device before the upper bits
are written?

For example, if the index crosses a 32-bit boundary, the hardware might
observe a corrupted index and begin processing an invalid ring state.

Should the driver depend on CONFIG_64BIT if atomic 64-bit writes are
mandatory, or use a safe, hardware-specific 32-bit doorbell mechanism
instead?

> +}
> +
>  #endif /* DMA_SDXI_CONTEXT_H */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D10
