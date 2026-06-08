Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4493B14C6
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950015; cv=none; b=SQtlnaLm0X55n3AM6b2aMK31H9ZbcuOXZafxnORToN0WB5S8CiWky8nZ73/Hyi3DWCsD3tchd8ID211gVHkHIydJbx3BkT6+gyX2ONi/5S9JaGY7YW8m2TM97fV+wsrdChzUS95rnhWWtdgg/HDGuRqtkiPu4XkUDUebNfQrndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950015; c=relaxed/simple;
	bh=Um3KBavrgOUy4Zk8fHvu0wqfBdsgtIBFuQiHZjE/zxU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mlR2YGa6bFW852bAT7OCvh//iCOk0KSOQ/Mwi3P5J0ninseB7ltgjHxHeoxNUn5FKF14CaS/CATr3Os1zU5yNubxbb9duY2TPo/AC3k97Sg8WMr0ol3Petw4ysurJLT1lPGxx8rhsj14quX4Lm9d+bo23AJBnIV21/sj76KZUwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZie3eIW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZie3eIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CED1F00898;
	Mon,  8 Jun 2026 20:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780950013;
	bh=MmwAtCna81rOcuXdu8eTYuCozMI9I+pnq6/61h06/7Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gZie3eIWCghxtFkDYGENG3tGHKc3ssweG3XKEXnJYy8GbhrYGDwRF3Il6Ri95R2+o
	 fnZMUIAxaHgcfZAEUN18vlTF+A16jeGo4eSSl8LnxLo62m6P3aHzMKvaUo/8GmRCA/
	 aJ2x+GzM9xD26ax/Bf/6PlOoKRZISEPMqMyiExqogWIyVZ5Lr1BM/RxkgriO+F2sfo
	 LrZWmkAPMrIPhHuOKrH8km0IIIlAdISuv7Kop6A9icyYmn64SPXzE31gM566yI0nzS
	 N3911Y2owwe7K3PLrYQwl9WPAVzufIkUo1NjUIfqxYY1YXuxh+ucuRiUx2MncyicmC
	 H4ORnYoucfgZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/19] rust: io: add copying methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-io_projection-v3-18-c5cde13a5ec4@garyguo.net>
References: <20260608-io_projection-v3-18-c5cde13a5ec4@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:20:12 +0000
Message-Id: <20260608202013.34CED1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Safe `copy_from_io_slice` and `copy_to_io_slice` do not handle or =
prevent overlapping memory slices, leading to Undefined Behavior or silent =
data corruption.
- [Low] Default implementations of `copy_from_io` and `copy_to_io` use `bui=
ld_assert!()` on a function parameter but lack the `#[inline(always)]` anno=
tation.
- [Low] The imports in `samples/rust/rust_dma.rs` do not follow the kernel =
alphabetical sorting style.
--

commit 0d38b02719ddeacdde6e32f8d5c83949c35fd537
Author: Gary Guo <gary@garyguo.net>

rust: io: add copying methods

This commit introduces copying methods for I/O memory in Rust, replacing the
older DMA read/write macros for larger structs. It adds `copy_read`,
`copy_write`, and slice copying methods for various backends, optimizing to
`memcpy` where possible or using a stack buffer fallback.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 72f3acc0f50d1..2b238b6256728 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -229,6 +230,63 @@ pub trait IoCapable<T>: IoBackend {
>      fn io_write<'a>(view: Self::View<'a, T>, value: T);
>  }
> =20
> +/// Trait indicating that an I/O backend supports memory copy operations.
> +///
> +/// # Safety
> +///
> +/// If [`Self::is_mapped`] is overridden, it must be correct per documen=
tation.
> +pub unsafe trait IoCopyable: IoBackend {
> +    /// Whether the pointers for this I/O backend are in the CPU address=
 space, and are coherently
> +    /// mapped.
> +    ///
> +    /// When this returns true, `Self::as_ptr(view)` must return a valid=
 and aligned pointer. The
> +    /// pointer may be accessed with byte-wise atomic memory copy or vol=
atile read/write.
> +    ///
> +    /// This is not an associated constants to support backends where th=
e view may be conditionally
> +    /// mapped. This method should be marked as `#[inline(always)]` if i=
t always returns true, so
> +    /// `build_assert!()` in `copy_{from,to}io` can see it.
> +    #[inline]
> +    fn is_mapped<T: ?Sized + KnownSize>(_view: Self::View<'_, T>) -> boo=
l {
> +        false
> +    }
> +
> +    /// Copy contents of `view` to `buffer`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `buffer` is valid for volatile write for `view.size()` bytes.
> +    #[inline]
> +    unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {

[Severity: Low]
This isn't a bug, but the Rust subsystem guidelines mandate that functions =
using
`build_assert!()` that depend on function parameters need to be annotated w=
ith
`#[inline(always)]`.

Could these default implementations result in spurious compilation failures=
 if
the compiler chooses not to inline them and attempts to evaluate the assert=
ion
at link-time?

> +        build_assert!(Self::is_mapped(view));
> +
> +        let ptr =3D Self::as_ptr(view);
> +
> +        // Use `bindings::memcpy` instead of copy_nonoverlapping for vol=
atile.
> +        // SAFETY:
> +        // - `is_mapped` guarantees `ptr` is in CPU address space and va=
lid for read.
> +        // - `buffer` is valid for write for `view.size()` bytes which i=
s equal to `ptr.len()`.
> +        unsafe { bindings::memcpy(buffer.cast(), ptr.cast(), ptr.len()) =
};
> +    }
> +
> +    /// Copy `size` bytes from `buffer` to `address`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `buffer` is valid for volatile read for `view.size()` bytes.
> +    #[inline]
> +    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {

[Severity: Low]
This isn't a bug, but the Rust subsystem guidelines mandate that functions =
using
`build_assert!()` that depend on function parameters need to be annotated w=
ith
`#[inline(always)]`.

Could these default implementations result in spurious compilation failures=
 if
the compiler chooses not to inline them and attempts to evaluate the assert=
ion
at link-time?

> +        build_assert!(Self::is_mapped(view));
> +
> +        let ptr =3D Self::as_ptr(view);
> +
> +        // Use `bindings::memcpy` instead of copy_nonoverlapping for vol=
atile.
> +        // SAFETY:
> +        // - `is_mapped` guarantees `ptr` is in CPU address space and va=
lid for write.
> +        // - `buffer` is valid for read for `view.size()` bytes which is=
 equal to `ptr.len()`.
> +        unsafe { bindings::memcpy(ptr.cast(), buffer.cast(), ptr.len()) =
};
> +    }
> +}

[ ... ]

> +    fn copy_from_io_slice<'b, T>(self, data: T)
> +    where
> +        Self::Backend: IoCopyable,
> +        Self: Io<'a, Target =3D [u8]>,
> +        T: Io<'b, Target =3D [u8], Backend: IoCopyable>,
> +    {
> +        fn copy_from_io_slice_via_buffer<
> +            'a,
> +            'b,
> +            T: Io<'a, Target =3D [u8], Backend: IoCopyable>,
> +            U: Io<'b, Target =3D [u8], Backend: IoCopyable>,
> +        >(
> +            dest: T,
> +            src: U,
> +        ) {
> +            let mut buf =3D MaybeUninit::<[u8; 256]>::uninit();
> +
> +            let mut offset =3D 0;
> +            let mut len =3D dest.len();
> +
> +            while len !=3D 0 {
> +                let copy_len =3D core::cmp::min(len, 256);
> +
> +                // SAFETY: `buf.as_mut_ptr()` is valid for write for `co=
py_len` bytes as `copy_len
> +                // <=3D 256`.
> +                unsafe {
> +                    U::Backend::copy_from_io(
> +                        io_project!(src, [panic: offset..][panic: ..copy=
_len]),
> +                        buf.as_mut_ptr().cast(),
> +                    )
> +                };
> +
> +                // SAFETY: `buf.as_ptr()` is valid for read for `copy_le=
n` bytes as `copy_len <=3D
> +                // 256`.
> +                unsafe {
> +                    T::Backend::copy_to_io(
> +                        io_project!(dest, [panic: offset..][panic: ..cop=
y_len]),
> +                        buf.as_ptr().cast(),
> +                    )
> +                };
> +
> +                offset +=3D copy_len;
> +                len -=3D copy_len;
> +            }
> +        }

[Severity: High]
Since `copy_from_io_slice` is a safe function, what prevents a user from
passing overlapping I/O views?

`Io` views implement `Copy` and wrap raw pointers, so a user could safely c=
reate
overlapping views of the same memory region and pass them here.

If the backends are CPU-mapped, this eventually delegates to C's
`bindings::memcpy()`. Calling `memcpy` with overlapping pointers is Undefin=
ed
Behavior and can trigger crashes under fortified implementations.

For unmapped backends, it falls back to `copy_from_io_slice_via_buffer()` w=
hich
processes the copy sequentially forward in 256-byte chunks. If the destinat=
ion
overlaps and sits ahead of the source, wouldn't an earlier chunk's write
overwrite data that a later chunk's read is supposed to copy, causing silent
data corruption?

Should this method explicitly detect pointer overlap and panic (like
`[T]::copy_from_slice`), or dynamically choose the copy direction?

> +
> +        assert_eq!(self.len(), data.len());
> +
> +        let dst_view =3D self.as_view();
> +        let src_view =3D data.as_view();
> +
> +        if T::Backend::is_mapped(src_view) {
> +            // SAFETY: `T::Backend::as_ptr(src_view)` is valid for read =
for `data.len()`
> +            // bytes.
> +            unsafe {
> +                Self::Backend::copy_to_io(self.as_view(), T::Backend::as=
_ptr(src_view).cast())
> +            }
> +        } else if Self::Backend::is_mapped(dst_view) {
> +            // SAFETY: `Self::Backend::as_ptr(dst_view)` is valid for wr=
ite for `data.len()`
> +            // bytes.
> +            unsafe {
> +                T::Backend::copy_from_io(data.as_view(), Self::Backend::=
as_ptr(dst_view).cast())
> +            }
> +        } else {
> +            copy_from_io_slice_via_buffer(dst_view, src_view)
> +        }
> +    }

[ ... ]

> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
> index 6727c441658aa..0f2597798ff5b 100644
> --- a/samples/rust/rust_dma.rs
> +++ b/samples/rust/rust_dma.rs
> @@ -12,7 +12,11 @@
>          Device,
>          DmaMask, //
>      },
> -    io::io_read,
> +    io::{
> +        io_project,
> +        io_read,
> +        Io, //
> +    },

[Severity: Low]
This isn't a bug, but the imports do not seem to follow the alphabetical so=
rting
style expected by the kernel vertical import guidelines. Since uppercase le=
tters
precede lowercase ones in ASCII, shouldn't `Io` be sorted before `io_projec=
t`
and `io_read`?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-io_project=
ion-v3-0-c5cde13a5ec4@garyguo.net?part=3D18
