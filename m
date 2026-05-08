Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD062C3266
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778212346; cv=none; b=t5LLH7SbshfUjl4I73aAq8YV7EDTEl9zoQzqfkNNm6CmeekjJXw99ZDH3NR7+W2R8I19brVCgKLm4advPgDov+bPdUg0d8QZ9bV37qejmDEsrvN5cZ0dYtwZOGhnMk6o6/Vn7Egz0+/qXirN6EwlrcM64/RiP/LFKgtdavHN1kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778212346; c=relaxed/simple;
	bh=21BAkKHFtEC2SBbmi0/xyEMqLfQmNHIchfHxvegOBlQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nJmW0Ym7ggRtIH3PYhPcIbCNvm6DQybqM63Uui8WmZuKlHrHi4p+LqSBzlLhfODAesa0EVZGldOzLgxp+Or139GhxvA5ho/8u2EFV8Vf+5DQxbHjxfmHsinNUCabo4dmKKMVqaeiUxiRFKBlGIL7B7MFgygDdt1ZiGLM10sXC8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nItJzaim; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nItJzaim"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49139C2BCB0;
	Fri,  8 May 2026 03:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778212346;
	bh=21BAkKHFtEC2SBbmi0/xyEMqLfQmNHIchfHxvegOBlQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nItJzaimk/rUxcwqj00km2JdIRlLh1YgeZlIBRdbZX/Ys/skt56NdxiF7tBr0BJIS
	 35ILp1XqzLb/Swpl62BQuWkMSLjt31VH8DbzrG5plr55D4mDbfcydbWunr76KJVT1e
	 el4P9M4iLKp3qM+Y/yU0hIfx2DqWA+5jHsI8SYMo8Iu7ZBSvTPR5WptQmFqkhIRp0y
	 Ly1L2WrY5cmKDXB+esUn+OFor5PGDgeUr5vIV65oJmpFeVsDQxBuXz7nfV8I1spngD
	 jy6kX7LNwcrxyvdcf8uW9JsWFBQNZI5mwOlfH4gkCTKDBGLZhR2bl78g5tUCCPGaN/
	 dacWYfwTsoxgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/18] rust: add untrusted data abstraction
Reply-To: sashiko@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260508031710.514574-2-alistair.francis@wdc.com>
References: <20260508031710.514574-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 03:52:25 +0000
Message-Id: <20260508035226.49139C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Missing owned interface causes memory leaks for `Untrusted<MaybeUn=
init<T>>`.
- [High] Calling `.len()` after `.as_mut_ptr()` on the same slice triggers =
Undefined Behavior under Stacked Borrows.
- [Medium] Unaligned reference creation in `Validate` documentation example=
s triggers Undefined Behavior.
- [Low] Missing `#[inline]` annotations on abstraction functions.
- [Low] Nested imports violate the vertical import style guidelines.
- [Low] Incomplete sentences, wrong examples, and inaccurate safety comment=
s in documentation.
--

commit 2a47d2c142208915fc2ad9542e62ff816065513b
Author: Benno Lossin <lossin@kernel.org>

rust: add untrusted data abstraction

This commit introduces the Untrusted and Unvalidated abstractions for handl=
ing
data from userspace or hardware. It uses the Validate trait to enforce
validation before data can be safely accessed.

Message-ID: <20240925205244.873020-2-benno.lossin@proton.me>

> diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
> new file mode 100644
> index 0000000000000..ae0aa20e27b47
> --- /dev/null
> +++ b/rust/kernel/validate.rs
> @@ -0,0 +1,605 @@
> +// SPDX-License-Identifier: GPL-2.0

[ ... ]

> +use crate::prelude::Init;
> +use core::{
> +    mem::MaybeUninit,
> +    ops::{Index, IndexMut},
> +    ptr, slice,
> +};

This isn't a bug, but should ptr and slice be on separate lines to follow t=
he
vertical import style guidelines?

[ ... ]

> +impl<T: ?Sized> Untrusted<T> {
> +    /// Marks the given value as untrusted.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::validate::Untrusted;
> +    ///
> +    /// # mod bindings { pub(crate) unsafe fn read_foo_info() -> [u8; 4]=
 { todo!() } };
> +    /// fn read_foo_info() -> Untrusted<[u8; 4]> {
> +    ///     // SAFETY: just an FFI call without preconditions.
> +    ///     Untrusted::new(unsafe { bindings::read_foo_info() })
> +    /// }
> +    /// ```
> +    pub fn new(value: T) -> Self
> +    where
> +        T: Sized,
> +    {
> +        Self(Unvalidated::new(value))
> +    }

Should small abstraction functions like new(), new_ref(), new_mut(), and
validate() be annotated with #[inline] per the Rust subsystem coding
guidelines?

[ ... ]

> +    ///         // SAFETY: `data` returned by `foo_hardware_read` is val=
id for reads as long as the
> +    ///         // `foo_hardware` object exists. That function updated t=
he
> +    ///         let data =3D unsafe { &mut *data };
> +    ///         Ok(Untrusted::new_mut(data))
> +    ///     }
> +    /// }
> +    /// ```
> +    pub fn new_mut(value: &mut T) -> &mut Self {

This isn't a bug, but it looks like the comment sentence "That function upd=
ated
the" is incomplete.

[ ... ]

> +    /// Turns a slice of uninitialized, untrusted values into an untrust=
ed slice of uninitialized
> +    /// values.
> +    pub fn transpose_slice_uninit(
> +        slice: &[MaybeUninit<Untrusted<T>>],
> +    ) -> &Untrusted<[MaybeUninit<T>]>
> +    where
> +        T: Sized,
> +    {
> +        let ptr =3D slice.as_ptr().cast::<MaybeUninit<T>>();
> +        // SAFETY: `ptr` and `len` come from the same mutable slice refe=
rence.
> +        let slice =3D unsafe { slice::from_raw_parts(ptr, slice.len()) };

This isn't a bug, but the safety comment mentions a "mutable slice referenc=
e",
while the input slice is an immutable reference. Could this be corrected?

> +        Untrusted::new_ref(slice)
> +    }
> +
> +    /// Turns a slice of uninitialized, untrusted values into an untrust=
ed slice of uninitialized
> +    /// values.
> +    pub fn transpose_slice_uninit_mut(
> +        slice: &mut [MaybeUninit<Untrusted<T>>],
> +    ) -> &mut Untrusted<[MaybeUninit<T>]>
> +    where
> +        T: Sized,
> +    {
> +        // CAST: `MaybeUninit<T>` and `MaybeUninit<Untrusted<T>>` have t=
he same layout.
> +        let ptr =3D slice.as_mut_ptr().cast::<MaybeUninit<T>>();
> +        // SAFETY: `ptr` and `len` come from the same mutable slice refe=
rence.
> +        let slice =3D unsafe { slice::from_raw_parts_mut(ptr, slice.len(=
)) };

Could calling slice.len() after slice.as_mut_ptr() trigger undefined behavi=
or
under Stacked Borrows?

Calling slice.len() creates a shared reference that invalidates the previou=
sly
derived mutable raw pointer.

Should the length be stored in a local variable before calling
slice.as_mut_ptr()?

> +        Untrusted::new_mut(slice)
> +    }
> +}
> +
> +impl<T> Untrusted<MaybeUninit<T>> {
> +    /// Sets the underlying untrusted value.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::validate::Untrusted;
> +    ///
> +    /// let mut untrusted =3D Untrusted::new(42);
> +    /// untrusted.write(24);
> +    /// ```
> +    pub fn write_uninit<E>(&mut self, value: impl Init<T, E>) -> Result<=
&mut Untrusted<T>, E> {

This isn't a bug, but the example initializes Untrusted::new(42) instead of
using MaybeUninit, and calls write() instead of write_uninit().

Additionally, does this interface leak owned resources?

There is no assume_init() or into_inner() method to consume the Untrusted
MaybeUninit type by value and return the initialized Untrusted type.

Because MaybeUninit does not drop the inner type when it goes out of scope,
it seems any initialized resource requiring a destructor will be permanently
leaked.

[ ... ]

> +impl<T> Untrusted<[MaybeUninit<T>]> {
> +    /// Sets the underlying untrusted value.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::validate::Untrusted;
> +    ///
> +    /// let mut untrusted =3D Untrusted::new(42);
> +    /// untrusted.write(24);
> +    /// ```
> +    pub fn write_uninit_slice<E>(
> +        &mut self,
> +        value: impl Init<[T], E>,
> +    ) -> Result<&mut Untrusted<[T]>, E> {
> +        let ptr: *mut [MaybeUninit<T>] =3D &mut self.0 .0;
> +        // CAST: `MaybeUninit<T>` is `repr(transparent)`.
> +        let ptr =3D ptr as *mut [T];
> +        // SAFETY: `ptr` came from a reference and if `Err` is returned,=
 the underlying memory is
> +        // considered uninitialized.
> +        unsafe { value.__init(ptr) }.map(|()| {
> +            let this =3D self.0.raw_mut().as_mut_ptr();
> +            // CAST: `MaybeUninit<T>` is `repr(transparent)`.
> +            let this =3D this.cast::<T>();
> +            // SAFETY: `this` and `len` came from the same slice referen=
ce.
> +            let this =3D unsafe { slice::from_raw_parts_mut(this, self.0=
.len()) };

Similar to transpose_slice_uninit_mut(), does calling self.0.len()
invalidate the mutable pointer derived from self.0.raw_mut().as_mut_ptr()?

[ ... ]

> +///         let ptr =3D raw.as_ptr();
> +///         // CAST: `Data` only contains integers and has `repr(C)`.
> +///         let ptr =3D ptr.cast::<Data>();
> +///         // SAFETY: `ptr` came from a reference and the cast above is=
 valid.
> +///         Ok(unsafe { &*ptr })
> +///     }
> +/// }

Could dereferencing this pointer trigger undefined behavior due to unaligned
access?

A byte slice &[u8] only guarantees 1-byte alignment, so the resulting
pointer might not satisfy the 8-byte alignment required by the Data struct.

Should the example verify alignment before dereferencing?

[ ... ]

> +///         // version 0 and 1 only use the lower 4 bits of flags
> +///         if raw[1] & 0xf0 !=3D 0 {
> +///             return Err(EINVAL);
> +///         }
> +///         if raw[1] =3D=3D 0 {}
> +///         let ptr =3D raw.as_ptr();

This isn't a bug, but there appears to be an unused if block here.

[ ... ]

> +    fn new_ref(value: &T) -> &Self {
> +        let ptr: *const T =3D value;
> +        // CAST: `Self` is `repr(transparent)` and contains a `T`.
> +        let ptr =3D ptr as *const Self;
> +        // SAFETY: `ptr` came from a mutable reference valid for `'a`.
> +        unsafe { &*ptr }
> +    }

This isn't a bug, but the safety comment says the pointer came from a "muta=
ble
reference", yet the value is an immutable reference. Could this be fixed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508031710.5145=
74-1-alistair.francis@wdc.com?part=3D1
