Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A987917A30A;
	Sat,  6 Jun 2026 00:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780705176; cv=none; b=uTVUkHiqs6cMboelQMMVz6vvsZ8khtCmgYOnXmoBG7R3NUbuD3ER0yhk+tlhFW7o/Ojr2xJVWR4et6oSUjC/6edBVRvORUdaFDpt2zoudjviHwzWgwLrxaTHnkmXyrtFno3g8Yozgv4QWPDsHLTYpub2VPMCI+5pJV/3GSZDp9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780705176; c=relaxed/simple;
	bh=fGfTm9cUsF1gzMbkPPS7g7Uy455f1rJ5JwTAjdtAD2o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q7CGDKtTCVRMa+ME+C5N0kbQgupzCiXYiaw0uLBTu76YeBs6HoSNKhm7hkX/jzgH/62a7oYen82M0b8qzODxLCjgeHF2PDi/MsNyBPQex30RWUIER8WF37kjphQE7/RALRe+eGdyJpw085MZDg1zm9bchr2roExLH899z+9fi1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0IUB9Ht; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0IUB9Ht"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B061F00893;
	Sat,  6 Jun 2026 00:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780705175;
	bh=QTI3HgrgMh+aaucKaBjfFC1iJwvQ8N+OzVcIS5KHRRU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K0IUB9HtNPMo4HMDwrCL09R5mn1XmyPILsduDPlNe/drVbEvd7wCtjOuoeMWcjYjI
	 y+EqlZg4jN8ppy06+Yl6AH5F6LKzabrAQmI6FedxzsV07sXpELm64lW1inYLMWgsDH
	 HfyHpjs2dIsAqVIABjc0CTmDrOmUuNMWT2SV5p8hFJnvaVNwNLBtm9FQammzmPdDu8
	 gi5uX8AM/P5xoaV2t/v94sDXaC8+6Bu0AgBK8WhZObXV6l41ZXav/M4jkJ+CrWvqsU
	 b9WExD9+mty9gmdg+IZw092emoEIo/hSFXY+9irl//MfrAgoYRrW6E1SLsnb6YusBt
	 7w2We0TvYHhfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/23] dmaengine: sdxi: Add descriptor ring
 management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260605-sdxi-base-v3-12-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-12-4d38ca2bdffe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:19:34 +0000
Message-Id: <20260606001935.18B061F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Premature hardware index update causes a race condition (Hardw=
are TOCTOU) allowing the hardware to execute uninitialized or stale descrip=
tors.
- [Medium] Expensive 64-bit software division in the descriptor ring iterat=
or.
- [Low] The `sdxi_ring_resv_foreach` macro evaluates its `resv_` argument m=
ultiple times, creating side-effect hazards.
--

commit 6a855f532756bc29a5250d62a29d1775d0ef6013
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Add descriptor ring management

Introduce a library for managing SDXI descriptor ring state. It
encapsulates determining the next free space in the ring to deposit
descriptors and performing the update of the write index correctly, as
well as iterating over slices (reservations) of the ring without
dealing directly with ring offsets/indexes.

> diff --git a/drivers/dma/sdxi/ring.c b/drivers/dma/sdxi/ring.c
> new file mode 100644
> index 0000000000000..91b28c7afbbf9
> --- /dev/null
> +++ b/drivers/dma/sdxi/ring.c
[ ... ]
> +static void sdxi_ring_state_store_widx(struct sdxi_ring_state *rs, u64 n=
ew_widx)
> +{
> +	lockdep_assert_held(&rs->lock);
> +	rs->write_index =3D new_widx;
> +	WRITE_ONCE(*rs->write_index_ptr, cpu_to_le64(new_widx));
> +}

[Severity: Critical]
Is it safe to update the hardware-visible write index here before the
descriptors are actually populated?

In sdxi_ring_try_reserve(), this computes the new write index and immediate=
ly
writes it to the DMA memory visible to the hardware. The lock is then dropp=
ed,
and the caller populates descriptors out-of-order.

If the ring has wrapped around, the old descriptor in a reserved slot might
still have its Validity (V) bit set to 1 from the previous pass (since the
driver does not zero out descriptors upon reclamation).

If another thread concurrently reserves slots, populates them, and rings the
doorbell with its advanced index, the hardware could process all slots up to
that doorbell value. The hardware would then check the V bit on this
preempted thread's slot, find it still set to 1, and erroneously execute the
stale descriptor again, leading to memory corruption.

Can the driver decouple the reservation index from the hardware-visible
index, or clear the V bit inside the reservation lock to prevent this?

[ ... ]
> +static struct sdxi_desc *
> +sdxi_desc_ring_entry(const struct sdxi_ring_state *rs, u64 index)
> +{
> +	return &rs->entry[do_div(index, rs->entries)];
> +}

[Severity: Medium]
Does this cause performance issues on 32-bit architectures?

Using do_div() here means performing a 64-by-32-bit division on every
descriptor access, which compiles to an expensive function call (__do_div64)
on 32-bit systems.

Since descriptor rings are typically sized as powers of 2 (e.g., SZ_1K),
could a bitwise AND (index & (rs->entries - 1)) be used instead?
Alternatively, the iterator could maintain a 32-bit wrapping array index
instead of repeatedly dividing the absolute 64-bit iteration counter.

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

[Severity: Low]
Can this macro cause side-effect hazards by evaluating its resv_ argument
multiple times?

The macro passes resv_ into sdxi_ring_resv_reset() once and into
sdxi_ring_resv_next() twice during loop execution. If a caller invokes this
macro with an expression that has side effects (e.g.,
sdxi_ring_resv_foreach(&reservations[i++], desc)), the side effect will be
evaluated multiple times per loop iteration.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-sdxi-base-=
v3-0-4d38ca2bdffe@amd.com?part=3D12
