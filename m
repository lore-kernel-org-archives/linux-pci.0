Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A081DED40
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 20:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605160; cv=none; b=VhPJ/1byWnuQ3Ii/mVrJS/PY5KPfZ+fgZfbzn5Rg1tWdNsBwLXFArYuXClBCy6G33iXD2W8eiCJpb7EUD5fFTS+LGml4zvjg71y54A+YH7xex/+Y+N5U7H7juyHnY9ooXHhxFkDV2DKLoDM7iQQvBTPXoc+2n9E/ZTE515a1dQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605160; c=relaxed/simple;
	bh=iC4PCN3EvZ3vbDafh6pppgbHo9EDczLBjmFM29+3+mE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fR0Pq5G71u4Ex3gz00GZ8DGXdPWsz9sYPHqGdWnIeVUE04nyviiLbNZMYLN1M48TJ2TiY0nbbQKTfl8dctehETyILL4euAhmAqTdzeCZNROK4JhHkVf5IkV4ss7Mst0Gu12/uYIupr+Gov2I/DcMtTo+u2sRaIQa1f2EYWAMwRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pc0KbbSv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pc0KbbSv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3A51F00893;
	Thu,  4 Jun 2026 20:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780605158;
	bh=pg4jFJrnmDg2RQyBrb+Q9dUjl+QotqBgU0tz/1DoBdE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pc0KbbSvtK2FkAqc+wQMGbBtpaiVNZWSUnJCcUtpxzAmczKRBqFf4vxXLLdjuZfPc
	 fCOC3dZ+oIVB0uHHZilT9DUlw6TIGXGFi3xhV5q3Ibf30ee4OHy2T0p6r/wZ2hu7pu
	 vVD0SkYTyCQkpWTmo2I5VQAWRwBv/xiLzYlI2djimA7V12WFpVlYP+NmxPbV9dPFlt
	 KpOJFwIri/JZ6B6gqHs2twHmWyEjPPHa2REwhHPlYGmHuMA3AxHe8EntF6VD233Epm
	 RN5Hx6r/Pwn2bcFwuRxaIdHFoV9+13jyKKpQz2RLc1diU+yOiC2rJ2k3YTGiMZKWpA
	 oTAl2ZKR+ZQOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 07/10] rust: Add missing SAFETY documentation for
 `ARef` example
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260604-unique-ref-v17-7-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-7-7b4c3d2930b9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:32:38 +0000
Message-Id: <20260604203238.8E3A51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] `ForeignOwnable` implementation for `Owned<T>` provides an incorre=
ct `FOREIGN_ALIGN`.
- [High] The `Ownable::release` trait method takes `&mut self` but is used =
to deallocate the memory backing `self`, causing Undefined Behavior.
- [Low] The return type of `Page::alloc_page` and the `Page` struct definit=
ion were changed without updating the `drivers/android/binder` caller, caus=
ing a build breakage.
--

commit b6a2c6eeac2c111155591c361b9cdb16d0cb61b7
Author: Oliver Mangold <oliver.mangold@pm.me>

rust: Add missing SAFETY documentation for ARef example

This commit fixes a missing SAFETY comment in the rustdoc example for
ARef. It replaces a TODO comment with a proper safety explanation.
The series also introduces the Ownable trait and updates
Page::alloc_page to return an Owned<Page>.

> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
> new file mode 100644
> --- /dev/null
> +++ b/rust/kernel/owned.rs
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Unique owned pointer types for objects with custom drop logic.

[ ... ]

> +pub trait Ownable {
> +    /// Tear down this `Ownable`.
> +    ///
> +    /// Implementers of `Ownable` can use this function to clean up the =
use of `Self`. This can
> +    /// include freeing the underlying object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the caller has exclusive ownership of `=
T`, and this ownership can
> +    /// be transferred to the `release` method.
> +    unsafe fn release(&mut self);
> +}

[Severity: High]
Does taking a mutable reference here lead to undefined behavior when
deallocating the memory backing it?

In Rust's memory model, a reference must point to valid memory for its
entire lifetime, which extends until the method returns.

Deallocating the memory backing &mut self while the reference is still
active in the function is a strict aliasing violation.

For instance, Page implements this by calling bindings::__free_pages
on the memory backing self.

Could this method take a raw pointer (like NonNull<Self>) or pass
ownership of the wrapper instead to avoid this issue?

[ ... ]

> +// SAFETY: We derive the pointer to `T` from a valid `T`, so the returned
> +// pointer satisfy alignment requirements of `T`.
> +unsafe impl<T: Ownable + 'static> ForeignOwnable for Owned<T> {
> +    const FOREIGN_ALIGN: usize =3D core::mem::align_of::<Owned<T>>();

[Severity: High]
Is it possible this alignment is incorrect for the underlying type?

The ForeignOwnable trait guarantees that the pointer returned by
into_foreign has a minimum alignment of FOREIGN_ALIGN. Here,
into_foreign extracts and returns a raw pointer to the underlying T.

However, FOREIGN_ALIGN is defined as the alignment of the wrapper
Owned<T> (typically an 8-byte pointer), rather than the alignment of T.

If T is an Ownable type with a smaller alignment requirement, the
returned pointer might not be 8-byte aligned. This would violate the
trait's safety contract and potentially cause undefined behavior when
passed to subsystems like XArray.

Should this use core::mem::align_of::<T>() instead?

> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index adecb200c6549..844c75e541345 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs

[ ... ]

> @@ -177,19 +192,20 @@ impl Page {
>      /// # Ok::<(), kernel::alloc::AllocError>(())
>      /// ```
>      #[inline]
> -    pub fn alloc_page(flags: Flags) -> Result<Self, AllocError> {
> +    pub fn alloc_page(flags: Flags) -> Result<Owned<Self>, AllocError> {
>          // SAFETY: Depending on the value of `gfp_flags`, this call may =
sleep. Other than that, it
>          // is always safe to call this method.
>          let page =3D unsafe { bindings::alloc_pages(flags.as_raw(), 0) };
>          let page =3D NonNull::new(page).ok_or(AllocError)?;
> -        // INVARIANT: We just successfully allocated a page, so we now h=
ave ownership of the newly
> -        // allocated page. We transfer that ownership to the new `Page` =
object.
> -        Ok(Self { page })
> +        // SAFETY: We just successfully allocated a page, so we now have=
 ownership of the newly
> +        // allocated page. We transfer that ownership to the new `Owned<=
Page>` object.
> +        // Since `Page` is transparent, we can cast the pointer directly.
> +        Ok(unsafe { Owned::from_raw(page.cast()) })
>      }

[Severity: Low]
Does this change in return type break existing callers?

The return type of Page::alloc_page was changed to return
Result<Owned<Page>, AllocError> and Page was converted to an
Ownable opaque wrapper.

However, ShrinkablePageRange::use_page_slow in
drivers/android/binder/page_range.rs still expects Page::alloc_page
to return a Page by value.

It attempts to pass the Owned<Page> to PageInfo::set_page(page: Page),
which causes a type mismatch and breaks the build.

Could the caller in drivers/android/binder be updated to handle
the new Owned<Page> return type?

[ ... ]

> @@ -364,10 +380,12 @@ pub unsafe fn copy_from_user_slice_raw(
>      }
>  }
> =20
> -impl Drop for Page {
> +impl Ownable for Page {
>      #[inline]
> -    fn drop(&mut self) {
> -        // SAFETY: By the type invariants, we have ownership of the page=
 and can free it.
> -        unsafe { bindings::__free_pages(self.page.as_ptr(), 0) };
> +    unsafe fn release(&mut self) {
> +        let ptr: *mut Self =3D self;
> +        // SAFETY: By the function safety requirements, we have ownershi=
p of the page and can free
> +        // it. Since Page is transparent, we can cast the raw pointer di=
rectly.
> +        unsafe { bindings::__free_pages(ptr.cast(), 0) };
>      }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-unique-ref=
-v17-0-7b4c3d2930b9@kernel.org?part=3D7
