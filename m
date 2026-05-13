Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3AE3A4509;
	Wed, 13 May 2026 05:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778649697; cv=none; b=sO/K5kFQUMSTntu4VcCLpx1ZYfZaF/Z28k5Fr8qUmf9ILxrt5tbblt1mwRuHWMAhxyeYX9D4LdVnB6TfFnWaCbZYIun+Ui2K08r+QXI6q6t8V1th3EeK0GpNyRN1ZOydBAH4gko4/tXiDNz48BX/J4Zq6TvBXKpo7ow+CAQveAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778649697; c=relaxed/simple;
	bh=LvrOMRiTy1xiaYbaN6mRTkorUA/sQQV3b5cPoBYx5g4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TfiySKEM2vonwwmWaOv1+mnMArrw+erD9YquGrNq2klcrm4vZpVIgvyeGQV9JkC8qCH1GfULfhTgA5q4K40Qtnid9BGs8N8sz4NagFvkBCrDYG66v17iN/PoAacKdsWtk2QV/GJOxIfDj1Uvkwt2Kr+pUkhTYRXi5sPT09LiSzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oytO2Ddn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oytO2Ddn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14261C4AF0B;
	Wed, 13 May 2026 05:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778649697;
	bh=LvrOMRiTy1xiaYbaN6mRTkorUA/sQQV3b5cPoBYx5g4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oytO2DdnzOuHajReHF+Q0sBveCnaKZSoqxds+KcANs3CB/NUJ8FTz9zqrgaUp60so
	 qjo9XdGWmNfm8q4D1CeD1XU3Ke8HZsZ/YYbA3A9hZFBDnCHbxDHkrUkw+ZAMkbVweG
	 07ItZ9+vi8Pp0PlMt5vO6TLGPbBarCYzQqx01xe6DmzKhGpEFaIV7wREsbYh2EJykb
	 cikYVipdwWCegue1qQ/zMu7o0Yg1YFYAXUii50oCORVci9mHkw+jLly+KK0S0aEMVE
	 MSq0LSAy15bRobrRyxev4J+z3o7uEKo5QgK5M3ftnZCV373hdkhj5//OqdAeneIYMD
	 tYRHdCP6FW5+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/23] dmaengine: sdxi: Add descriptor ring
 management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260511-sdxi-base-v2-12-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-12-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 05:21:36 +0000
Message-Id: <20260513052137.14261C4AF0B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unkillable task hang and Use-After-Free in ring reservation during=
 device removal or hardware wedge.
- [High] Potential torn reads of the shared 64-bit read index on 32-bit arc=
hitectures permanently wedge the ring.
- [Low] Macro `sdxi_ring_resv_foreach` evaluates the `resv_` argument multi=
ple times.
--

commit fb903a32d5204efe5e95d75203c430ca1c4e7e8d
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Add descriptor ring management

This commit introduces a library for managing SDXI descriptor ring state,
encapsulating free space checks, write index updates, and reservation
iteration. It provides blocking and non-blocking reservation APIs and
mechanisms to iterate over descriptors within a reservation.

> diff --git a/drivers/dma/sdxi/ring.c b/drivers/dma/sdxi/ring.c
> new file mode 100644
> index 0000000000000..91b28c7afbbf9
> --- /dev/null
> +++ b/drivers/dma/sdxi/ring.c
[ ... ]
> +static u64 sdxi_ring_state_load_ridx(struct sdxi_ring_state *rs)
> +{
> +	lockdep_assert_held(&rs->lock);
> +	return le64_to_cpu(READ_ONCE(*rs->read_index_ptr));
> +}

Can this result in a torn read on 32-bit architectures? READ_ONCE() on a
64-bit variable expands to two 32-bit load instructions on 32-bit systems.

Since the SDXI hardware updates this memory location concurrently via DMA,
the CPU might observe a torn value if the read occurs while the index
crosses a 32-bit boundary. This could produce a massively inflated read
index, causing the subsequent check in sdxi_ring_try_reserve() to
permanently return -EIO.

[ ... ]
> +/* Blocking ring reservation. Retries until success or non-transient err=
or. */
> +int sdxi_ring_reserve(struct sdxi_ring_state *rs, size_t nr,
> +		      struct sdxi_ring_resv *resv)
> +{
> +	int ret;
> +
> +	wait_event(rs->wqh,
> +		   (ret =3D sdxi_ring_try_reserve(rs, nr, resv)) !=3D -EBUSY);
> +
> +	return ret;
> +}

Does this wait_event() need to handle timeouts or signals? If the hardware
wedges or the device is hot-unplugged, the read index will never advance,
leaving tasks permanently hung in TASK_UNINTERRUPTIBLE sleep.

Furthermore, if the driver is unbound and destroys the wait queue while
tasks are still waiting here, could this result in a use-after-free and
subsequent kernel panic when the scheduler interacts with the freed wait
queue?

[ ... ]
> diff --git a/drivers/dma/sdxi/ring.h b/drivers/dma/sdxi/ring.h
> new file mode 100644
> index 0000000000000..d5682687c05cd
> --- /dev/null
> +++ b/drivers/dma/sdxi/ring.h
[ ... ]
> +#define sdxi_ring_resv_foreach(resv_, desc_)			\
> +	for (sdxi_ring_resv_reset(resv_),			\
> +	     desc_ =3D sdxi_ring_resv_next(resv_);		\
> +	     desc_;						\
> +	     desc_ =3D sdxi_ring_resv_next(resv_))

This isn't a bug, but this macro evaluates the resv_ argument multiple time=
s.
If a caller passes an expression with side effects, it could cause unintend=
ed
behavior.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D12
