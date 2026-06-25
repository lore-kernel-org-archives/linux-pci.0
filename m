Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C63D1715
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383204; cv=none; b=eoF2ihHei+tQAGGyNOC0JwP6venNfSk3LEwnGiTbF+xReM7ct/uPq3sVal9lJoqXqpD5DNAYu5CaiaY//twXHyjxWn007AlO5ZrZ2PTEVfbs081c0faji171uA35HvmBxHACvaTtgeXE8GkLGVsuZTwyM4HD4ZTHubs5m+kPgkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383204; c=relaxed/simple;
	bh=bk9Qi7qEEMxzNiOCUDGO2tyKX6o4Tcj+XCkwgSsl1s0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K5yYZaOKS0f3LVmmaOVfSgExTDjD9FYCUPpUQC6geRIMAMHY9RZSx0RXuVBCXpgSSCscsZzxld9pqMKMTB0WLgQHwh28wlvSH0oDP1sdplAeXBEJlcDfWDUf7g0u0yXI/WcW2ojGXWI0HxpQ1W21JGr4fp1l9hn98T8fyfTWVbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVE0n8zz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVE0n8zz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB9D1F000E9;
	Thu, 25 Jun 2026 10:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782383202;
	bh=cVmAAd3PPJq+H5j2lwVJ5eWd7apr2rFjOH/tjr/magY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RVE0n8zzQYvrnahGprbeXBj4vqVi7dGCx3/kREU6vmKA0lLKNaZJ6L8dI+Mlvynjh
	 oA9LaoYWR4WSpBqPJLwum/2JyDStsfijANrPIzNxW2uUrO5rdpCL9mTK+dqVyZ4M6t
	 VD9cKrt0IDJfuMnRfPNYKAFTIA3r1St2+xoU5tY4Ud7Bhd1JqatfOekp/NkRsFEfd5
	 G2UtbKbJ1jjZ+gCBa1RukIz/797vn9tASwR8tqHAQidVwa4v3dsa7xZnbOI45A3Clc
	 N7gk9pX4FdZ/Y6fyDJopTudxL67RHSXW6Z8EZLSOIjrJWpFFEI9SugjeYtFLiX9OU6
	 JOaKVLY2GOU4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 7/8] rust: Add `OwnableRefCounted`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260625-unique-ref-v18-7-4e06b5896d47@kernel.org>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
 <20260625-unique-ref-v18-7-4e06b5896d47@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:26:41 +0000
Message-Id: <20260625102641.EDB9D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `OwnableRefCounted` trait is a safe trait but its default `int=
o_shared` method contains an `unsafe` block relying on unenforced invariant=
s, violating Rust's soundness rules.
- [Low] Incorrect documentation link for `ARef<Self>` in `aref.rs`.
--

commit b7dc8070575155be9312b255a20879f2e905b00f
Author: Oliver Mangold <oliver.mangold@pm.me>

rust: Add `OwnableRefCounted`
   =20
Types implementing one of these traits can safely convert between an
`ARef<T>` and an `Owned<T>`.

> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
> index e79936c00002c..bb4223c0f725a 100644
> --- a/rust/kernel/owned.rs
> +++ b/rust/kernel/owned.rs

[ ... ]

> +pub trait OwnableRefCounted: RefCounted + Ownable + Sized {
> +    /// Checks if the [`ARef`] is unique and converts it to an [`Owned`]=
 if that is the case.
> +    /// Otherwise it returns again an [`ARef`] to the same underlying ob=
ject.
> +    fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARef<Sel=
f>>;
> +
> +    /// Converts the [`Owned`] into an [`ARef`].
> +    #[inline]
> +    fn into_shared(this: Owned<Self>) -> ARef<Self> {
> +        // SAFETY: `Owned::into_raw` returns a pointer to a valid `Self`=
, and the `Owned` owned the
> +        // reference count that we now transfer to the new `ARef`.
> +        unsafe { ARef::from_raw(Owned::into_raw(this)) }
> +    }
> +}

[Severity: High]
Does this trait need to be marked unsafe?

The OwnableRefCounted trait is currently safe to implement, but the default
into_shared() method contains an unsafe block that assumes the Owned<Self>
implicitly holds a reference count of 1.

If a developer implements this safe trait for a type whose Owned<Self>
does not account for one RefCounted increment, calling into_shared() will
pass a pointer to ARef::from_raw() without a corresponding reference
increment.

When the resulting ARef is dropped, it will blindly call dec_ref(), which
could lead to a reference count underflow, double-free, or use-after-free.

Should OwnableRefCounted be an unsafe trait so that implementers are
required to guarantee the reference count invariant?

> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index d0865aeb9371b..77eb390139079 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs

[ ... ]

> @@ -35,7 +39,10 @@
>  /// Note: Implementing this trait allows types to be wrapped in an [`ARe=
f<Self>`]. It requires an
>  /// internal reference count and provides only shared references. If uni=
que references are required
>  /// [`Ownable`](crate::types::Ownable) should be implemented which allow=
s types to be wrapped in an
> -/// [`Owned<Self>`](crate::types::Owned).
> +/// [`Owned<Self>`](crate::types::Owned). Implementing the trait
> +/// [`OwnableRefCounted`] allows to convert between unique and
> +/// shared references (i.e. [`Owned<Self>`](crate::types::Owned) and
> +/// [`ARef<Self>`](crate::types::Owned)).

[Severity: Low]
This isn't a bug, but there appears to be a copy-paste typo in the rustdoc
link.

The documentation for ARef<Self> points to crate::types::Owned instead
of ARef.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-unique-ref=
-v18-0-4e06b5896d47@kernel.org?part=3D7
