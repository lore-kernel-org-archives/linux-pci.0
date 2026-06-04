Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D3D3C76B9
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 20:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604615; cv=none; b=Ht+g1TzJ26uSDnQ+bhgnU1WoCtRWWwNA2y6fKR9n+zZxD9L/9cBoVSDUcDL9072LpxFAzpwLsJzPzoaIToto5Q1l69482QbirECnH591Qc1jIfcZQn/smyhdJ9TriKlJT/4V8MClF4xdGTPmBeg18EObP4lbG0jLvr2zQt5q8Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604615; c=relaxed/simple;
	bh=YgqZbCQnSYJdwV2VAZQWVB49itFC3XpKUaqKzCRkOxg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Slq7/bd7QzZUDQY5h3XYKk2ruirzKJHIv4ejsiaEl/c9IhJa8inuhaA1+MzzuHHGgAvIsLFvx0Qe0AEbfGl+jRPZ+WEd5coJ5UBgJ8WRRv0XH6/EJH1BiAEwhFiX5+AL1Q2V/1fqpGx8MFXSYxsXRP1/6lx/yr9v4w98AY45qMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPAk5dbP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPAk5dbP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AB11F00893;
	Thu,  4 Jun 2026 20:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604613;
	bh=9ZapocUyvwmCbzJ737qw9fhwPN1lL/Oo/9fxm6AZ+P0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GPAk5dbPrq8ympgdca6zln4OqRcmI5Xbl+0YDE1nhgIC2yccsUuTPOIwRGobeS5+R
	 OdSnuWcbdDSC9L2ZWGPRuH+2g86BJrL3Ak8ny3XB6tdUqmjSmJrUTzZTOKz2zXrmFH
	 fEaxdqc0qDLTReJH5zjb8+zVMko0T/7dYepDhun5UYMkc5rVaTdouhY4hTTuEB3KjC
	 GtZjW0PvnDtMA8nfZqICEMvvNDIU3BIsmSzfssts+P3c7m5WMDleXWDAdXTWWr53Z2
	 M0LsqF/IJwavLv7uWdthMbKnNQuHicRknVEozvm6lLmDOZHujND5pJLchzMioWBxhj
	 38lvsIGPrv9BA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 03/10] rust: implement `ForeignOwnable` for `Owned`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260604-unique-ref-v17-3-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-3-7b4c3d2930b9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:23:33 +0000
Message-Id: <20260604202333.77AB11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] `FOREIGN_ALIGN` is incorrectly set to `align_of::<Owned<T>>()` ins=
tead of `align_of::<T>()`, violating the `ForeignOwnable` safety contract a=
nd risking pointer corruption when used with `XArray`.
- [Low] Missing `// INVARIANT:` comment when constructing `Owned<T>` in `fr=
om_foreign()`.
--

commit 65031e6cc93134c76e2f6b85f3d269f18d531a88
Author: Andreas Hindborg <a.hindborg@kernel.org>
rust: implement ForeignOwnable for Owned

This commit implements the ForeignOwnable trait for Owned<T>. This enables
the use of Owned<T> in collections like XArray.

> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
> index 456e239e906ef..5eacdf327d121 100644
> --- a/rust/kernel/owned.rs
> +++ b/rust/kernel/owned.rs
[ ... ]
> @@ -185,3 +188,46 @@ fn drop(&mut self) {
>          unsafe { T::release(self.ptr.as_mut()) };
>      }
>  }
> +
> +// SAFETY: We derive the pointer to `T` from a valid `T`, so the returned
> +// pointer satisfy alignment requirements of `T`.
> +unsafe impl<T: Ownable + 'static> ForeignOwnable for Owned<T> {
> +    const FOREIGN_ALIGN: usize =3D core::mem::align_of::<Owned<T>>();

[Severity: High]
Does this alignment calculation break the ForeignOwnable contract if T has a
smaller alignment than Owned<T>?

The ForeignOwnable trait guarantees that pointers returned by into_foreign()
will have a minimum alignment of FOREIGN_ALIGN. However, into_foreign()
returns a raw pointer to the underlying T, while FOREIGN_ALIGN is hardcoded
to the alignment of Owned<T> (which evaluates to the alignment of NonNull<T=
>,
typically 8 bytes).

If T is a type with a smaller alignment requirement (such as 1 or 4 bytes),
into_foreign() might return a pointer that is not 8-byte aligned, yet
FOREIGN_ALIGN will falsely claim it is. XArray relies on this alignment
to use the lower bits for internal tagging. Could this lead to pointer
corruption when inserting an Owned<T> holding an underaligned T into an
XArray?

> +
> +    type Borrowed<'a> =3D &'a T;
> +    type BorrowedMut<'a> =3D Pin<&'a mut T>;
> +
> +    #[inline]
> +    fn into_foreign(self) -> *mut kernel::ffi::c_void {
> +        let ptr =3D self.ptr.as_ptr().cast();
> +        core::mem::forget(self);
> +        ptr
> +    }
> +
> +    #[inline]
> +    unsafe fn from_foreign(ptr: *mut kernel::ffi::c_void) -> Self {
> +        Self {

[Severity: Low]
This isn't a bug, but is this missing an invariant comment for the Owned<T>
struct construction?

According to the Rust subsystem guidelines, when a struct with an
Invariants documentation section is constructed, the code should have an
// INVARIANT: comment explaining why the invariants are satisfied. The
from_foreign() implementation constructs Self { ptr: ... } without this
mandatory comment explaining how reconstructing the struct maintains the
ownership and pinning invariants.

> +            // SAFETY: By function safety contract, `ptr` came from
> +            // `into_foreign` and cannot be null.
> +            ptr: unsafe { NonNull::new_unchecked(ptr.cast()) },
> +        }
> +    }
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-unique-ref=
-v17-0-7b4c3d2930b9@kernel.org?part=3D3
