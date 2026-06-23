Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082F830D3E7;
	Tue, 23 Jun 2026 05:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782191110; cv=none; b=RoMpULFT2rKke2JwzcdhaNgFmh17lVw3JjJIj/xVTVSyB8SChZf9y5hv3y2s40lqvm1u4IpZOqjDjMkHxkeIbbfxfH4iYSK9k7N2vvYnV1Oqy2SNPhI+HnUzG6akLdZ2eDLy9859iVBJyM+BSwbBeIR9cytxDevL1Oy55TFjVnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782191110; c=relaxed/simple;
	bh=OufA8jzHnOCPb9fO2I2S1GCsPhmCyYAnRmzDQl/uwXo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WQecrUa03cX5zu5mc5MW/qIXety3fm00LA3sCPM3ZU92LzuI1RG4eOcTCWwi2xxBsAvig38+aYPDtr5Dn+b3hbRlSxoX+nWCYjLvQTr4MOUSTiMUi6ZQS2wAhe1XgGm2YhIoqT2IKz/73ezZqWk9esCxyZK447jI1FIBWPuIkLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpM97JN/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpM97JN/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4091F000E9;
	Tue, 23 Jun 2026 05:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782191108;
	bh=v3WYKj8FKJMT9A5x7/RRJ7XeD1TET3RCnqYv9+mhCYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OpM97JN//xVFmzxolz6KtzMwxdIveQ4tYeQtYWvDwXGoHYbVqHrWKqsUAWv/puJ5a
	 EFUrkmXAeVupboRKz6+er/V/cZItnCA3sl+YGc8ZAdLsRE6qMEDwBmLbrQyB6SuNgt
	 LqmyUjF4IIJHlkKdb6K2d3CH5zlZCfKlWdMcudfHHVsXORqLpYEicvroqsQvjkA6rJ
	 3Jwh4hv8G37vUvFzeQxjx8BclhDy27Kz/IiK7lUAwLIizPaSSOmYgK4YAks2DyNs5T
	 1DshtKkEtEsJZr/QAjJGG0BMAod8V1tHYV2qyrcC4+WbSJ7o4gLtRtIskos54EorHe
	 uCYp0702WUlCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/21] rust: transmute: add `cast_slice[_mut]`
 functions
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260623045406.2589547-2-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 05:05:07 +0000
Message-Id: <20260623050508.5A4091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `# Safety` sections for `cast_slice` and `cast_slice_mut` are =
incomplete and unsound, omitting requirements for validity invariants, inte=
rior mutability, and mutable write-back.
- [Low] Missing `#[inline]` attribute on the `cast_slice` and `cast_slice_m=
ut` abstraction functions.
--

commit 81ab9367137984ee8a82555d066400739962f02f
Author: Benno Lossin <lossin@kernel.org>

rust: transmute: add cast_slice[_mut] functions

Add functions to make casting slices only one unsafe block.

Message-ID: <20250814124424.516191-2-lossin@kernel.org>

> diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
> --- a/rust/kernel/transmute.rs
> +++ b/rust/kernel/transmute.rs
[ ... ]
> +/// # Safety
> +///
> +/// - `T` and `U` must have the same layout.
> +pub unsafe fn cast_slice<T, U>(slice: &[T]) -> &[U] {

[Severity: High]
Are the safety requirements here complete? It seems we also need to ensure
that any bit pattern valid for T is also valid for U, and that the cast
doesn't introduce interior mutability.

[Severity: Low]
This isn't a bug, but should this have an #[inline] attribute since it is a
small forwarding function in an abstraction crate?

> +    // CAST: by the safety requirements, `T` and `U` have the same layou=
t.
> +    let ptr =3D slice.as_ptr().cast::<U>();
> +    // SAFETY: `ptr` and `len` come from the same slice reference.
> +    unsafe { slice::from_raw_parts(ptr, slice.len()) }
> +}
[ ... ]
> +/// # Safety
> +///
> +/// - `T` and `U` must have the same layout.
> +pub unsafe fn cast_slice_mut<T, U>(slice: &mut [T]) -> &mut [U] {

[Severity: High]
Are the safety preconditions here sufficient to prevent undefined behavior?
In addition to layout equivalence, any value of U written to the slice must
also be a valid T, and the cast shouldn't introduce interior mutability.

[Severity: Low]
This isn't a bug, but should this also be marked with #[inline] according to
the Rust subsystem coding guidelines for abstraction functions?

> +    // CAST: by the safety requirements, `T` and `U` have the same layou=
t.
> +    let ptr =3D slice.as_mut_ptr().cast::<U>();
> +    // SAFETY: `ptr` and `len` come from the same slice reference.
> +    unsafe { slice::from_raw_parts_mut(ptr, slice.len()) }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623045406.2589=
547-1-alistair.francis@wdc.com?part=3D1
