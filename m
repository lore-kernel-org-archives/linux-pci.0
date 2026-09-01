Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0C2367B73;
	Tue,  1 Sep 2026 01:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225590; cv=none; b=KTRuqsuSQAnTP0DpTYWx9kwy+ni0Rpmyb3iYYiIXsPKKK84PdDcbI9U2IK4dw3CLPn5nkwURYhyxO49l54tMgnp6Ucz3mR6ypU/MuKA93Rph2KcToMWvnV3tncVLT8INmF3vJ9xLluL7sLwuLS4EWKrYQbZyD1+3bxSPlVOyE44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225590; c=relaxed/simple;
	bh=duupv1wYfktbZT2ZA/b9RrIjJjfKDGDQBDMYUQeCgcM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fuRsI5h5RuePy4TJ4EQlz2SJkKgehwi47ic6I9+baKLMY7Wz0XKaVs0ZzIu0iz+8wMZS4ipxE53L/EoAiGW3qyPG9V+XaLahjumS8NdzflbwA9M/cYcZ9/2UxPq+/xN+XRWpyAPuplO7SGQyjcqv7h0L2SA0SUd2zx/e9urNBf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NikD9Jop; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NikD9Jop"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3171F000E9;
	Tue,  1 Sep 2026 01:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225588;
	bh=xgUkwwAEsYlKwGBcQH3xK7FVHFqBDNR+P5qeZvwTDXA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NikD9Jop2lShTUEsxo7pV8tb9TOPX91H0twvGVUW0BVGEEGpRQDWczpQ2WWTOes1A
	 0udbMEjT9xM7VkD6QuhqGSAGTdqNRgBSuCSsKQpWmf85LfF4L72C3nyJbRtSj+Ofvo
	 67iarfKa/GP7hGhtzBxmBYdtvTH8ZMVOYQiXELjJLgaen36rjY0xrPO7QULNJK8hux
	 LtlCZofHriuNkEXMRVXFYQWsf7Iwzvli8YptQRcl+tQStEAl9xoFyRTsHQrcQC244z
	 ivpFK2J5oDGnuI/xGdy6gpRr5uGdZZX5u+tJusPtSvIdly6loiCb3KJ8HbTZTOA+DI
	 QJh+d+uB5SJuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/21] rust: create basic untrusted data API
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260901010347.2614656-3-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:19:47 +0000
Message-Id: <20260901011948.6C3171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Undefined Behavior due to missing layout guarantees when transmuti=
ng `Vec<T, A>` to `Vec<Untrusted<T>, A>`.
- [Low] Small abstraction functions in the `kernel` crate are missing `#[in=
line]` annotations.
--

commit a2ef24201e92da02db41c39bbc750b20f5e2ce5b
Author: Benno Lossin <lossin@kernel.org>

rust: create basic untrusted data API

This commit introduces an Untrusted<T> wrapper type to explicitly mark
and validate external data before use. The API provides Deref and DerefMut
implementations to allow working with untrusted slices and vectors.

> diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
> new file mode 100644
> index 0000000000000..2b28625c25efe
> --- /dev/null
> +++ b/rust/kernel/validate.rs

[ ... ]

> +impl<T: ?Sized> Untrusted<T> {

[ ... ]

> +    pub fn new(value: T) -> Self
> +    where
> +        T: Sized,
> +    {
> +        Self(value)
> +    }

[Severity: Low]
Could this small abstraction function be annotated with #[inline]?

The Rust Subsystem coding guidelines suggest that small functions in
abstractions like the kernel crate should be marked as inline to ensure
optimal code generation.

> +}
> +
> +impl<T> Deref for Untrusted<[T]> {
> +    type Target =3D [Untrusted<T>];
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: `Untrusted<T>` transparently wraps `T`.
> +        unsafe { cast_slice(&self.0) }
> +    }
> +}

[Severity: Low]
Should this small trait method also have an #[inline] annotation?

> +
> +impl<T> DerefMut for Untrusted<[T]> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY: `Untrusted<T>` transparently wraps `T`.
> +        unsafe { cast_slice_mut(&mut self.0) }
> +    }
> +}

[Severity: Low]
Would an #[inline] annotation be appropriate for this deref_mut implementat=
ion
as well?

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
> +    }
> +}

[Severity: High]
Is it possible to add an #[inline] annotation here?

Additionally, does this pointer cast rely on layout guarantees that the
compiler does not provide?

Vec is a #[repr(Rust)] type, which does not guarantee stable or identical
layouts across different generic monomorphizations. Even though Untrusted<T>
is #[repr(transparent)] over T, Vec<T, A> and Vec<Untrusted<T>, A> are
distinct monomorphizations.

If the compiler orders the internal fields differently, transmuting between
these types could lead to memory corruption. The standard way to soundly
convert a vector's element type is by deconstructing it via into_raw_parts
and reconstructing it with from_raw_parts, but this cannot be done for
references.

Are there alternative ways to expose this untrusted vector data safely?

> +
> +impl<T, A: Allocator> DerefMut for Untrusted<Vec<T, A>> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        let ptr: *mut Untrusted<Vec<T, A>> =3D self;
> +        // CAST: `Untrusted<T>` transparently wraps `T`.
> +        let ptr: *mut Vec<Untrusted<T>, A> =3D ptr.cast();
> +        // SAFETY: `ptr` is derived from the reference `self`.
> +        unsafe { &mut *ptr }
> +    }
> +}

[Severity: High]
Could this method be annotated with #[inline] as well?

Similar to the deref implementation above, can this pointer cast invoke
undefined behavior by transmuting between two distinct #[repr(Rust)] types?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901010347.2614=
656-1-alistair.francis@wdc.com?part=3D2
