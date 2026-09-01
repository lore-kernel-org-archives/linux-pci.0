Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92981316190;
	Tue,  1 Sep 2026 01:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225432; cv=none; b=NTUdOFfveO1SdFpjPJXutSpZoCjgPtbLwXGu97lIIKf7mK6W3SARqmIdvRvIu9LRCUGnGIFpr2mNB40HqMokaFWaZCL8oVwVQ6C3ubFkAIsLGyiWQDozySzkB5MiiVq09fK8Is4vbqGrITAI6KM2ifcQyW8ye2y/PwO6XJHOiuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225432; c=relaxed/simple;
	bh=oHl6gmvjROVpOO9Ag2JSqT2Ng/VLw3XnIcRP6gLljIc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sgISqiyRjdyRIJYKRiuzgv9UgTu7cAsIm+loZdE+0vfJHgT8fC6qeSr96SNiLG1+1EiI9GmW01pM9hx4HZeuMohD2FuKlOUi7F4ddMvXQlq6Dl40u+/DPVOwDeHB5Q9X/rHOudNJMuQzmGZW2un3G8BIbNeYgqcQTdSzpo3Wm2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y14eBKnB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y14eBKnB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912701F00A3E;
	Tue,  1 Sep 2026 01:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225419;
	bh=YwGFz4GBe8uqgUFcA996kplhyuQO8Rz5c6vP8HED1ho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y14eBKnBaSF4Cuh504HWhjPPh5D27PYHKOdOCB+JkPLPVQgZb6qg9D2sQC1R7UhnG
	 zspHSUgB3mPNgIshF3m2VmroHYwXRvrllPo1/6ezoLJ6kemlBpcsF0S2vxNp0A92d/
	 bR2p/ilYPTV+C+dnnImtw9p0z2QFce7dX181nQ6d+lD0/opBEyM/xCsjJopUgU5ltH
	 ehI1hFJzebxST4FmvCfKJq3MsACMGuBAy8iYFDkagCHJoFS7XPjrMrBQ8dSwwrnkOO
	 DAnR3A0TTKhsoq+6ZEVuOD9p+yIbEaLmHmUDJptxFukHXhIGDiQpl5Xjyt6Acpu0Mq
	 6MEFD1QNHPtTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/21] rust: validate: add `Validate` trait
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901010347.2614656-4-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-4-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:16:59 +0000
Message-Id: <20260901011659.912701F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The small wrapper functions `validate`, `validate_ref`, and `valida=
te_mut` in the `Untrusted` type are missing the `#[inline]` attribute, viol=
ating subsystem guidelines.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but transmuting refe=
rences between `Vec<T, A>` and `Vec<Untrusted<T>, A>` via pointer cast is U=
ndefined Behavior because `Vec` lacks a guaranteed memory layout.
--

commit 6a4bc1cc90cb4c5dd96a67a8f893828d2d0c3473
Author: Benno Lossin <lossin@kernel.org>

rust: validate: add `Validate` trait

Introduce the `Validate<Input>` trait and functions to validate
`Untrusted<T>` using said trait.

> diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
> index 2b28625c25efe..663681b633c86 100644
> --- a/rust/kernel/validate.rs
> +++ b/rust/kernel/validate.rs
> @@ -107,6 +110,30 @@ pub fn new(value: T) -> Self
>      {
>          Self(value)
>      }
> +
> +    /// Validate the underlying untrusted data.
> +    ///
> +    /// See the [`Validate`] trait for more information.
> +    pub fn validate<V: Validate<Self>>(self) -> Result<V, V::Err>
> +    where
> +        T: Sized,
> +    {
> +        V::validate(self.0)
> +    }
> +
> +    /// Validate the underlying untrusted data.
> +    ///
> +    /// See the [`Validate`] trait for more information.
> +    pub fn validate_ref<'a, V: Validate<&'a Self>>(&'a self) -> Result<V=
, V::Err> {
> +        V::validate(&self.0)
> +    }
> +
> +    /// Validate the underlying untrusted data.
> +    ///
> +    /// See the [`Validate`] trait for more information.
> +    pub fn validate_mut<'a, V: Validate<&'a mut Self>>(&'a mut self) -> =
Result<V, V::Err> {
> +        V::validate(&mut self.0)
> +    }

[Severity: Low]
Should these small wrapper functions be annotated with #[inline]?

[ ... ]

>  impl<T, A: Allocator> Deref for Untrusted<Vec<T, A>> {
>      type Target =3D Vec<Untrusted<T>, A>;
> =20
>      fn deref(&self) -> &Self::Target {
>          let ptr: *const Untrusted<Vec<T, A>> =3D self;
>          // CAST: `Untrusted<T>` transparently wraps `T`.
>          let ptr: *const Vec<Untrusted<T>, A> =3D ptr.cast();
>          // SAFETY: `ptr` is derived from the reference `self`.
>          unsafe { &*ptr }
>      }
>  }
> =20
>  impl<T, A: Allocator> DerefMut for Untrusted<Vec<T, A>> {
>      fn deref_mut(&mut self) -> &mut Self::Target {
>          let ptr: *mut Untrusted<Vec<T, A>> =3D self;
>          // CAST: `Untrusted<T>` transparently wraps `T`.
>          let ptr: *mut Vec<Untrusted<T>, A> =3D ptr.cast();
>          // SAFETY: `ptr` is derived from the reference `self`.
>          unsafe { &mut *ptr }
>      }
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does casting pointers between
Vec<T, A> and Vec<Untrusted<T>, A> cause Undefined Behavior?

Since Vec<T, A> uses the default #[repr(rust)] representation, it does not
guarantee stable field ordering. The Rust Reference explicitly states that
pointer-casting between two generic types with the default representation is
Undefined Behavior, even if their type arguments share identical memory
layouts.

If the compiler orders fields differently between Vec<T, A> and
Vec<Untrusted<T>, A>, could dereferencing the casted pointer or swapping
values corrupt memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901010347.2614=
656-1-alistair.francis@wdc.com?part=3D3
