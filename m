Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EC3377A9A;
	Tue,  1 Sep 2026 01:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225120; cv=none; b=CI1fBG04NlCJz49zbiQdJ6qOpTLiMGM5BiCSGCS8u15ktzk60QLmOVz6/3/j7SiT2VkmIvSfa7Oi/rG0QWF9VCEZsr06uAiNeTlho9JbVAsWczZ/VrXmWcm9VBdm7UEUgM7WX61wxVCNYj3EJtqW4GQ/u1DJsBI+4Hqycs/NhYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225120; c=relaxed/simple;
	bh=Q39UCGyWuHXdh4e88ldKf+Ol7g+Z/c8KJrlRuuauTN8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j2yOMeQEq4jiErr6LXQcWoCGojEKkLzxqpiuQRMMilZJCx5ANO3L/V5J4ch6/xrThD/q9Jr1V+g+uwu/DyWEyX4YK6lT5KOp/pY73NiWFQ0yfp9IQCO/Sn22y4cGBE9f54zofkPYnWusesOiHO2h7r2BEJHfOUBbwsxqqXQkL/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hs/a4+HS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hs/a4+HS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF091F000E9;
	Tue,  1 Sep 2026 01:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225118;
	bh=Wk7/wp2papSwx2stCHqvRJYzIxsPklfVoqfJxYWDeG4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hs/a4+HS6c/Tl2ju2/ZYGQAeDzJAbSHSI65z7uN1lbBsznrcLmJ2xx6rSzvRsOaSQ
	 dhcnqAuWpx3JcCcGq7Pc50H1gT2pybuBKnA+DmFjMja5J5ZB1il/apRCuRB08WlGt6
	 r9kTOX6G5tV29Bzj0X6UFt8XBbNRNYUhFHwRo2OnXss/XNOXKAL/XsqqRxu/TD0qWn
	 6Jw9OFz0tKvU6P17cS/lEpGpFla7DFQatjhiIQ2Wr2ZAU8qo4ukVnKHH37P61SjdDX
	 n3LfkeUDGMj2HiPIo34Wyk+MkJR289mkVtNWZM5TtOMJlk7v2QU3EDWEyOS5IimGML
	 yAEqk6+QWLMdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/21] rust: transmute: add `cast_slice[_mut]`
 functions
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901010347.2614656-2-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:11:57 +0000
Message-Id: <20260901011158.4DF091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The `# Safety` contract for `cast_slice` and `cast_slice_mut` is i=
ncomplete, omitting critical requirements regarding bit-pattern validity an=
d interior mutability.
- [Low] The small abstraction functions `cast_slice` and `cast_slice_mut` a=
re missing `#[inline]` attributes.
- [Low] Import formatting does not follow the kernel vertical import style.
--

commit d8c311b266bb9a64cb5ebd99f708e41b6412ae21
Author: Benno Lossin <lossin@kernel.org>

rust: transmute: add cast_slice[_mut] functions

This commit introduces functions to enable casting slices with only a single
unsafe block.

Message-ID: <20250814124424.516191-2-lossin@kernel.org>

> diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
> index 654b5ede2fe29..c1282fcc9e651 100644
> --- a/rust/kernel/transmute.rs
> +++ b/rust/kernel/transmute.rs
> @@ -3,6 +3,7 @@
>  //! Traits for transmuting types.
> =20
>  use core::mem::size_of;
> +use core::slice;

[Severity: Low]
Is this import formatting intentional? The subsystem coding guidelines
specify following the kernel vertical import style, which would group this
with the existing core import as use core::{mem::size_of, slice};.

[ ... ]

> +/// # Safety
> +///
> +/// - T and U must have the same layout.

[Severity: High]
Is this safety contract complete? It appears to omit requirements regarding
bit-pattern validity and interior mutability. For example, if a caller uses
types where values of T are not valid bit-patterns for U, could this lead
to undefined behavior despite adhering to the stated layout constraint?

> +pub unsafe fn cast_slice<T, U>(slice: &[T]) -> &[U] {

[Severity: Low]
Does this function need an inline attribute? As a small abstraction wrapper
forwarding to standard library slice functions within the kernel crate, the
guidelines indicate it should be annotated with #[inline] to ensure optimal
code generation across crate boundaries.

[ ... ]

> +/// # Safety
> +///
> +/// - T and U must have the same layout.

[Severity: High]
Does the mutable variant's safety contract also need to specify bit-pattern
validity in both directions? If a caller writes a valid U that is an
invalid bit-pattern for T, it seems this could cause undefined behavior
when the slice reverts to a mutable slice of T. Should it also explicitly
forbid introducing interior mutability?

> +pub unsafe fn cast_slice_mut<T, U>(slice: &mut [T]) -> &mut [U] {

[Severity: Low]
As with cast_slice, should this thin abstraction wrapper also include the
#[inline] attribute?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901010347.2614=
656-1-alistair.francis@wdc.com?part=3D1
