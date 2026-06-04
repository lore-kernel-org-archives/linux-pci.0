Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B723D6690
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 20:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604766; cv=none; b=JK4jiTjzg5smHIvokfqKbyfHTFm441JDQ+tR2UIBgo3js9Nzz9iqJUjRAPeZuS9S+YXVQSAjrl+8N4i/1P8pyDgz+Ahv7rfKphFEuWy7Bz0qW6LROlA10Rerl1bmRw0GQvirnfjzLYWoq40hRcu3LoMZNOzdd4hexc0qWZk7QYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604766; c=relaxed/simple;
	bh=kXeW9BmquLy9PiZLjbH900yryy/ihfm4PAc4TrkpCW0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aLFNrDNE5cSsg2l+zOE0eRrGpB9RHy8OxAdovizD1n1fPgA1BAUaS6874YhSrmwwAglh015Jt18heLYZ7et0kUm2rdhSDDp2T+/b94ePWqIwcbJmpoi3xof+4WyyRGJ76mA4R7feCEHYxrIFJhcqX6tT98pltFH5PRsR4BYKws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hl6tK+JR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hl6tK+JR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51551F00893;
	Thu,  4 Jun 2026 20:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604765;
	bh=5ITOkeVkekdwi/A0DDI2o7Cw0EGGh4FSGNprGqGQYRU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hl6tK+JRaK9cqg/53BshntXCzvluaFu6hxxvDVEuzteINc8UYK5vhkTJFNv89EwPo
	 7oTXt0avxO4eeflJ37cpov+eTGvi1smixEiNsBx+3xJBuzVzvrLHNPqDLPwWu28xqM
	 A8hSW9CoTCOS5gJL9PHwsdLut4wmir3nY3KmMJ6gBe8W+YrluatSz0Oy8tWdfa/aPJ
	 zV00u3nGqgr1DR8bImMGRaq52RrA1gUGaXrRhFCLU2QD+GPp0m+Y6J09dGILZTVOCH
	 EU0zC3AxQywG8nDC6cqBtFUr0wOkud+QGlEF84gLe10CFeqM+TPRuKekfD7Y3Vp2Uo
	 soihHas3GYY4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 02/10] rust: types: Add Ownable/Owned types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260604-unique-ref-v17-2-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-2-7b4c3d2930b9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:26:04 +0000
Message-Id: <20260604202604.E51551F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] `Ownable::release` takes `&mut self` instead of a raw pointer, cau=
sing Undefined Behavior due to invalidating a live reference during dealloc=
ation and narrowing pointer provenance.
- [High] `Owned<T>` inherently pins its contents, but the safety contracts =
for `Ownable` and `from_raw` fail to enforce or document this Pin guarantee.
--

commit 14ba35325a0c0c8b1032beb4bbdfd6396842dfdc
Author: Asahi Lina <lina+kernel@asahilina.net>

    rust: types: Add Ownable/Owned types
   =20
    By analogy to AlwaysRefCounted and ARef, an Ownable type is a
    (typically C FFI) type that may be owned by Rust, but need not be. Unli=
ke
    AlwaysRefCounted, this mechanism expects the reference to be unique
    within Rust, and does not allow cloning.

    Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@=
asahilina.net/

> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
> new file mode 100644
> index 0000000000000..456e239e906ef
> --- /dev/null
> +++ b/rust/kernel/owned.rs
> @@ -0,0 +1,187 @@
> +// SPDX-License-Identifier: GPL-2.0

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

[Severity: High]
Does taking a mutable reference here instead of a raw pointer risk undefined
behavior?

If Owned::drop() creates a temporary reference and passes it to release(),
deallocating the backing memory of this live mutable reference violates
Rust's aliasing rules because the reference remains in scope during the fre=
e:

Owned::drop()
    T::release(self.ptr.as_mut())

Additionally, if T is an opaque C-allocated type (often represented as a
Zero-Sized Type), creating a mutable reference narrows the pointer's
provenance to exactly 0 bytes. Converting this back to a raw pointer and
passing it to a C deallocator would be invalid.

Would it be safer for release() to take a raw pointer (like NonNull<Self> or
*mut Self), similar to AlwaysRefCounted::dec_ref()?

[Severity: High]
Since Owned<T> guarantees that its underlying T is pinned and exposes
Pin<&mut T> via as_pin_mut(), does Ownable need to be an unsafe trait
to enforce pinning invariants?

Currently, Ownable is safe to implement, and release() provides an unpinned
mutable reference. A safe implementation of release() could potentially move
the value. When Owned::drop() is called, this would move a value that was
previously pinned, violating the pinning guarantees.

> +}

[ ... ]

> +impl<T: Ownable> Owned<T> {
> +    /// Creates a new instance of [`Owned`].
> +    ///
> +    /// This function takes over ownership of the underlying object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that:
> +    /// - `ptr` points to a valid instance of `T`.
> +    /// - Until `T::release` is called, the returned `Owned<T>` exclusiv=
ely owns the underlying `T`.
> +    #[inline]
> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {

[Severity: High]
Does the safety documentation for from_raw() need to require that the
allocation is permanently pinned?

Without this requirement, a caller could pass an unpinned allocation,
extract it later via into_raw(), and move it. This would violate the
internal pinning assumptions made by Owned<T> when calling as_pin_mut().

> +        // INVARIANT: By function safety requirement we satisfy the firs=
t invariant of `Self`.
> +        // We treat `T` as pinned from now on.
> +        Self { ptr }
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-unique-ref=
-v17-0-7b4c3d2930b9@kernel.org?part=3D2
