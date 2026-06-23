Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE5054774;
	Tue, 23 Jun 2026 05:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782191399; cv=none; b=RfTQcMN/HlqPlQcMGrbnxxFMikTLhCuniVrphBAUZ6p2wQB6uV/ybTGe/W3Pl2OXLpvDyC4rjoeid36NP6CAgNPEyDJIWJvLI7qVlOOpYlLnVrO3mLqAW307HbiQDafNBoXPU1sF8vqDu+NAaZ5o8ida1drI19BIwWqP1+YgZmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782191399; c=relaxed/simple;
	bh=kowYzW7oz6eNDc9K5Cj/hMy8gFuXMQsNfWhCTyWF70k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MQlAxWTJY2SUmmAfyvts2Zo34/hs96fxu+sH6VK4lWHKAeU5aHxlBmVkgki23azgCx8oDg9YBi9Mrim/cadnPebqWF8BE/MTG0EiUgA6jZ1gQRgJPtCmwk/wa5LBNeSHheDAjPIdurKIBRX0eHRutMVMoa9L3D9KKHDCAKJXlcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUptJT4N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUptJT4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07F91F000E9;
	Tue, 23 Jun 2026 05:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782191397;
	bh=y0n/wxp21HDN7BsblU1n6PYJwUsVl+P43g4f891xhio=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JUptJT4NfUb05Wjn8pBCfc9Qj96xbY89beDJDXyS4LD/k40uwAISNtXK4u97u3tP/
	 wAw+4kKGP4da3AIPS0Ma1/+/Vg9FqH72nFw6kgH/5TWrt2m10s86XvI+okZfgTX3gW
	 U+4m5xNkC6hB0i28RL+34OL2UVuBeF1csQFUmlnbckIfSwpvAZjy3IhNEf6MoO0WBe
	 tU/1fI1kLJJP/GiJzVAqvz35sK18tKwmDTjMtOcsXFZ+rIyiZQHFArkFsNjfQSYeUl
	 CEbjB7XcLW6WptCiRmJGdz2ZFDy5Wsv/kd7YYey3gYHGbsf2hdm6p9Wjasc5qJygRl
	 egreJ64txYdBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/21] rust: create basic untrusted data API
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260623045406.2589547-3-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 05:09:57 +0000
Message-Id: <20260623050957.B07F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Invalid pointer cast between `Vec<T, A>` and `Vec<Untrusted<T>, A>=
` in `Deref` and `DerefMut` implementations leads to undefined behavior, me=
mory corruption, and Use-After-Free.
- [Low] Missing `#[inline]` annotations on small forwarding functions in an=
 abstraction.
- [Low] Incorrect import formatting: `use core::ops::{Deref, DerefMut};` do=
es not follow the vertical import style.
--

commit 5d58092058655501597b482a4a94d2d50da29fc6
Author: Benno Lossin <lossin@kernel.org>

rust: create basic untrusted data API

This commit introduces the `Untrusted<T>` wrapper type to explicitly mark a=
nd
validate untrusted external data. It prevents direct usage of untrusted data
in logic decisions while allowing it to be copied back to userspace.

Message-ID: <20250814124424.516191-3-lossin@kernel.org>

diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
new file mode 100644
index 0000000000000..2b28625c25efe
--- /dev/null
+++ b/rust/kernel/validate.rs
[ ... ]
> +use core::ops::{Deref, DerefMut};

[Severity: Low]
This isn't a bug, but the kernel Rust coding guidelines require vertical im=
port
formatting (one import per line). Should this be spread across multiple lin=
es?

> +
> +use crate::{
[ ... ]
> +impl<T: ?Sized> Untrusted<T> {
[ ... ]
> +    pub fn new(value: T) -> Self

[Severity: Low]
This isn't a bug, but the kernel Rust coding guidelines require small or
forwarding functions in abstractions to be annotated with `#[inline]`. Shou=
ld
we add the annotation here?

> +    where
> +        T: Sized,
> +    {
> +        Self(value)
> +    }
> +}
> +
> +impl<T> Deref for Untrusted<[T]> {
> +    type Target =3D [Untrusted<T>];
> +
> +    fn deref(&self) -> &Self::Target {

[Severity: Low]
Similar to `new()`, should this small forwarding function be annotated with
`#[inline]` to match the guidelines?

> +        // SAFETY: `Untrusted<T>` transparently wraps `T`.
> +        unsafe { cast_slice(&self.0) }
> +    }
> +}
> +
> +impl<T> DerefMut for Untrusted<[T]> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {

[Severity: Low]
Should this small forwarding function also be annotated with `#[inline]`?

> +        // SAFETY: `Untrusted<T>` transparently wraps `T`.
> +        unsafe { cast_slice_mut(&mut self.0) }
> +    }
> +}
> +
> +impl<T, A: Allocator> Deref for Untrusted<Vec<T, A>> {
> +    type Target =3D Vec<Untrusted<T>, A>;
> +
> +    fn deref(&self) -> &Self::Target {
> +        let ptr: *const Untrusted<Vec<T, A>> =3D self;
> +        // CAST: `Untrusted<T>` transparently wraps `T`.
> +        let ptr: *const Vec<Untrusted<T>, A> =3D ptr.cast();
> +        // SAFETY: `ptr` is derived from the reference `self`.
> +        unsafe { &*ptr }

[Severity: High]
Does this pointer cast invoke undefined behavior?

Since `Vec` has `#[repr(Rust)]`, the compiler provides no guarantee that the
field orderings of `Vec<T>` and `Vec<Untrusted<T>>` match. If the layout
differs between these two monomorphizations, could casting the reference re=
sult
in memory corruption when accessing the `ptr`, `len`, and `layout` fields?

> +    }
> +}
> +
> +impl<T, A: Allocator> DerefMut for Untrusted<Vec<T, A>> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        let ptr: *mut Untrusted<Vec<T, A>> =3D self;
> +        // CAST: `Untrusted<T>` transparently wraps `T`.
> +        let ptr: *mut Vec<Untrusted<T>, A> =3D ptr.cast();
> +        // SAFETY: `ptr` is derived from the reference `self`.
> +        unsafe { &mut *ptr }

[Severity: High]
Similar to `deref()`, does casting a mutable reference between different
instantiations of a `#[repr(Rust)]` type risk memory corruption?

Safe code could call `deref_mut` to obtain `&mut Vec<Untrusted<T>, A>`, ext=
ract
ownership via `core::mem::take` (since `Vec` implements `Default`), and then
mutate or drop it. This could process the fields from mismatched offsets and
pass garbage pointers to the allocator.

> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623045406.2589=
547-1-alistair.francis@wdc.com?part=3D2
