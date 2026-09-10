Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE8F3D9691
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031655; cv=none; b=sunZye1hGuOcjTMW6v9C/YV9KAWodjqdj7zX0MmLVNxijF6JJD3lK0kQoZfE9W7PkvMnnxVU5JdgDluOelpS6upPR4ahhkdLC2frzl1J/f5MeFIyi3UAFTCMojgEktqwV+xKpuwu+r+gX2kpo4Q8cex2YFlBktbtmnJGoEGv66o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031655; c=relaxed/simple;
	bh=ykFkxjjrSyaxAjxiZqcJd5zjSgg7MA57rmktIExFD2s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L8y6cTkzU4RR7Uo78Iahl4IFwd1BnDw+8Qtkn2Gak66+JWcc0K9x7oEBBze49e6cSFwJ+2vfBvcyxLPQxs0wSJk7yRVap2WwsK459klgIxSQAwdmBWYi9xoy+yCsOjesC3teHCzNzJMwA/nSS0QN9Z/qCjUYM1m9MlpXj8UcE60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K11VrlCE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K11VrlCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127391F000FF;
	Thu, 10 Sep 2026 09:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789031650;
	bh=KhOVk1R5yXBKmAaNEaPrgmZGENdKNLdVkyMUu2iD1KU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K11VrlCE8BQN63nv3O/Ws441J6fq81fvDeTymdvmKw620tX0LFKwCI/gX66RJZ/h3
	 agusq07+S4uEmfE18sAuhSy/zGYNqX7Qt8QW+tV+WguMZXOc3ZPt8xJ0licpkJy6rU
	 yyJ2pDb7+ocCLiTgu87ebWsCoDV1X/wTAkjNvQuubY7XBSoH7xjL3ktBnG7sECPtg2
	 TpE9yTIILOao3L+X53MdaP9AjhCFSSCVPls4Ml69a2Ya5zbopUqcuZ+J6Q3BkgoMTi
	 EZXyHyk6ai3QvvSYhWn2gYAPETtYDDNQrskeAtYCF99VmKexUm8ltXn16/ntg0hvzt
	 ahCQUz9m+Sh7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 4/9] rust: rename `AlwaysRefCounted` to
 `RefCounted`.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: ojeda@kernel.org, gary@garyguo.net, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260910-unique-ref-v21-4-e83257373062@kernel.org>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-4-e83257373062@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:14:09 +0000
Message-Id: <20260910091410.127391F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `ForeignOwnable` implementation for `ARef<T>` unnecessarily =
requires `T: AlwaysRefCounted` instead of `T: RefCounted`.
- [Low] Conditional compilation failure in `fwctl.rs` and `serdev.rs` due t=
o incomplete `AlwaysRefCounted` refactoring.
--

commit 6b87875ccf108a75e9bf33ac87bec77ac53590b0
Author: Oliver Mangold <oliver.mangold@pm.me>

rust: rename `AlwaysRefCounted` to `RefCounted`.

There are types where it may both be reference counted in some cases and
owned in others. In such cases, obtaining `ARef<T>` from `&T` would be
unsound as it allows creation of `ARef<T>` copy from `&Owned<T>`.

[ ... ]

[Severity: Low]
The tree-wide refactoring seems to have missed `rust/kernel/fwctl.rs` and
`rust/kernel/serdev.rs`, which still attempt to implement methods on
`AlwaysRefCounted`.

For example, in `rust/kernel/fwctl.rs`:

unsafe impl<T: Operations> AlwaysRefCounted for Device<T> {
    #[inline]
    fn inc_ref(&self) {
        // SAFETY: `self` holds a live reference.
        unsafe { bindings::fwctl_get(self.as_raw()) };
    }
    ...

Since `AlwaysRefCounted` is now an empty marker trait, will this cause
compilation failures when `CONFIG_FWCTL` or `CONFIG_SERIAL_DEV_BUS` are
enabled?

> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index 9983ee0852486..215e7eb139fac 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
[ ... ]
> @@ -188,15 +201,15 @@ fn drop(&mut self) {
> =20
>  impl<T, U> PartialEq<ARef<U>> for ARef<T>
>  where
> -    T: AlwaysRefCounted + PartialEq<U>,
> -    U: AlwaysRefCounted,
> +    T: RefCounted + PartialEq<U>,
> +    U: RefCounted,
>  {
>      #[inline]
>      fn eq(&self, other: &ARef<U>) -> bool {
>          T::eq(&**self, &**other)
>      }
>  }
> -impl<T: AlwaysRefCounted + Eq> Eq for ARef<T> {}
> +impl<T: RefCounted + Eq> Eq for ARef<T> {}
> =20
>  // SAFETY: `into_foreign` returns a pointer from `NonNull::as_ptr`, so i=
t's non-null. The
>  // `ARef` invariant guarantees that `ptr` points to a valid `T`, so it's=
 aligned to `T`.

[Severity: Medium]
This trait bound appears to have been missed during the conversion. Just be=
low
this context in `aref.rs` is:

unsafe impl<T: AlwaysRefCounted> ForeignOwnable for ARef<T> {

Does this unnecessarily limit the FFI usability of `ARef<T>` for types that
are `RefCounted` but not `AlwaysRefCounted`? Should this be updated to
`T: RefCounted` instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-unique-ref=
-v21-0-e83257373062@kernel.org?part=3D4
