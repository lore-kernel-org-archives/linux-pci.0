Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003393AA51F;
	Wed, 13 May 2026 21:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778708026; cv=none; b=bz6LmDY91Y8V1xiHfrs4rFSrZ3re96tRNqlIp/no+5bTp9+GE2AQ6K4CAblSvFRwtz4WQT5iKBS+ZevTIUapQRv3PzPdeuiY7pOzsg3ixYmkeeHitDzvy1HQD/lHpOuoiSeJyq3u+YHE0YOHjGZ8HLjATtFo3LvplcjYIbndoys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778708026; c=relaxed/simple;
	bh=bR0mp0ecxGbJT4NksY4PMCNuzcnckZFsd72iD3+rYYY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tWb/OookmzWHGRP9yjAnIf3Gc1s2fq6lO8ILca7FgJoYnfG3da+7JB+9hDSvjcNG6gimJtFSUlTgwFXJwzzVyIriqJktNzdYEnkVzSLejDHtxmvR7jBXKj/xtSpaAYlW2z7qGEntQgl3JJ+WFdbtyu40PjJmbXZpDTrbumvwm5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWZqYlMm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWZqYlMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D7FC19425;
	Wed, 13 May 2026 21:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778708025;
	bh=bR0mp0ecxGbJT4NksY4PMCNuzcnckZFsd72iD3+rYYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hWZqYlMm+FVvPjaFXIQhUxGEeNMqZl9/O2kFmm1TBQTFVBtKVV8aCNZPe4wJSLbt5
	 UqgAbrGs8U0KNc6RHegvqZWNCcuGGBTgULXQYXuFOsrDQWTGJJykuQb3oENN5yGqlq
	 aP+c+uvIlc0CHaZEGs1TXA5SMdNQve9aWv3LgUNq2FXgMMC3qbJJULY+KnIymOVPYS
	 la8qfH6wsfIScdd0lk00I6ya2Y8A66+mnDBXuKqf2c5oD+N0/4kJvJXUXYlYldcKwn
	 XU2nba3WlyL0FYPQBnny03AsQMIis1YgthfZMZD2Atw+36Qgu9ZF2Y8SoHvvpoTKy+
	 yif0zY51PQhJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 20/23] dmaengine: sdxi: Encode nop, copy, and
 interrupt descriptors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260511-sdxi-base-v2-20-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-20-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 21:33:44 +0000
Message-Id: <20260513213345.61D7FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] User-triggerable WARN_ON_ONCE() for data-path validation poses a=
 Denial of Service risk.
- [Medium] Integer overflow in buffer overlap calculation allows invalid co=
nfigurations to bypass validation.
- [Low] Redundant clamp_val() operation acts as dead code.
--

commit cfd7b5f9b8481ef46337c6e93c25ab0383c6dbcc
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Encode nop, copy, and interrupt descriptors

Introduce low-level support for serializing nop, copy, and interrupt
operations to the descriptor ring of a client context. Each operation
has a dedicated encoder function overlaying the generic sdxi_desc struct.

> diff --git a/drivers/dma/sdxi/descriptor.c b/drivers/dma/sdxi/descriptor.c
> index be2a9244ce194..41019e747528c 100644
> --- a/drivers/dma/sdxi/descriptor.c
> +++ b/drivers/dma/sdxi/descriptor.c

[ ... ]

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

Could this WARN_ON_ONCE() be triggered by invalid input from a client driver
or userspace?

If the system is configured with panic_on_warn, passing an invalid length
like 0 might trigger a kernel panic. Should this gracefully return -EINVAL
without the warning?

> +	size =3D clamp_val(size, 1, SZ_4G);

This isn't a bug, but is this clamp_val() necessary?

The previous if statement already returns -EINVAL if the size is outside
these bounds, so this clamping operation might be redundant.

> +	*dest =3D cpu_to_le32((u32)(size - 1));
> +	return 0;
> +}

[ ... ]

> +int sdxi_encode_copy(struct sdxi_desc *desc, const struct sdxi_copy *par=
ams)
> +{

[ ... ]

> +	/*
> +	 * Reject overlapping src and dst. "Software ... shall not
> +	 * overlap the source buffer, destination buffer, Atomic
> +	 * Return Data, or completion status block." - SDXI 1.0 5.6
> +	 * Memory Consistency Model
> +	 */
> +	if (range_overlaps(&(const struct range) {
> +				   .start =3D params->src,
> +				   .end   =3D params->src + params->len - 1,
> +			   },
> +			   &(const struct range) {
> +				   .start =3D params->dst,
> +				   .end   =3D params->dst + params->len - 1,
> +			   }))

Does this calculation overflow if an IOMMU assigns an address near U64_MAX?

If params->src + params->len wraps around, the end address could become
smaller than the start address. This might bypass the range_overlaps()
check, allowing overlapping or invalid wrapping buffers to be submitted.

> +		return -EINVAL;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D20
