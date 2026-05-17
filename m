Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA71810F2
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778977414; cv=none; b=oUZoPUZq/J6v9Dub34RFsdqUbLF2jR3s7+zROaZROJp9Z1kpqvlhxD57OjjNL8lFUDspMD2jFUn0tWR36gZ8eilz28UP5g51IKy6UOrKflslrKwLbPq49Fc7T56H1Qo49JQ7ThaAme5YHsuMRlthHuozlPcLoircJJ5Urs6RleQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778977414; c=relaxed/simple;
	bh=G5a5IXWuPSxfCfEZV90mZ3MhTxCgFaA/10gqH0coI9k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Twot3vrDp7Kvwo8iMa9JfLfnGO6OBxcTWgPsPXYv4jC1iFm+t8fQVnNdc1i0Q4Riw+lL9OSbnn9JEonQv8XnyULToA97AdlRBSSq3MwusX4/i4c84Kmr6cUSCbrP5Lg5N6Fr9Nkv+JyS+nTAJjchD/GyDICIC1uNAR2AsbSQZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scchZxTt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scchZxTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62343C19425;
	Sun, 17 May 2026 00:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778977413;
	bh=G5a5IXWuPSxfCfEZV90mZ3MhTxCgFaA/10gqH0coI9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=scchZxTt9DgyxSQH4xa2cgZ1V1khSuYmrjiA4ZXFFlPpYa+e9f4216SAmhuf9dDeV
	 dnfBTHkQkccPgdCWnaK/2in8OOE7eJPelj9aZ0bpMkL5zy5026YS5vWjRMlAMv1puZ
	 q2VJxdStq+8rMhGKErCARSJvzWr7aHcgqD3W6xX9bof0IXCz0/NBMpdWTVqzdmJU9n
	 kAeN77vDQlZM/Uin0D8ZtG/OksaJMMkJYiFDZebJ+LkY0jlByF6XaPQbceH3EbfL9f
	 2a170m2k+AeuEd2z16aQBEYum05BXBn1t8fsSrxbj7Cftv/Xw3vaEcT03ab69ZItm5
	 OcjqkaOmpQ1ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/27] rust: types: add `ForLt` trait for
 higher-ranked lifetime support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260517000149.3226762-17-dakr@kernel.org>
References: <20260517000149.3226762-17-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 00:23:32 +0000
Message-Id: <20260517002333.62343C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Safe Rust code can directly name and use `UnsafeForLtImpl` to bypa=
ss covariance proofs, leading to use-after-free.
- [High] The `ForLt!` macro fails to check covariance for types wrapped in =
macro invocations.
- [Low] The `cast_ref` function is incorrectly annotated with `#[inline(alw=
ays)]`.
--

commit 2088fc9ea2c7348deada4ab3dfcc55a6783dcf27
Author: Gary Guo <gary@garyguo.net>

rust: types: add ForLt trait for higher-ranked lifetime support

This commit adds a ForLt trait and macro to support types that are generic
over a lifetime, ensuring covariance for safe lifetime shortening. It
provides a way to represent types that are themselves generic over
lifetimes, which is useful for cross-referencing data.

Link: https://docs.rs/higher-kinded-types/ [1]

> diff --git a/rust/kernel/types/for_lt.rs b/rust/kernel/types/for_lt.rs
> new file mode 100644
> index 0000000000000..22b4518a115b3
> --- /dev/null
> +++ b/rust/kernel/types/for_lt.rs
[ ... ]
> +    /// Cast a reference to a shorter lifetime.
> +    #[inline(always)]
> +    fn cast_ref<'r, 'short: 'r, 'long: 'short>(long: &'r Self::Of<'long>=
) -> &'r Self::Of<'short> {
> +        // SAFETY: This is sound as this trait guarantees covariance.
> +        unsafe { core::mem::transmute(long) }
> +    }
> +}

Should this function use #[inline] instead of #[inline(always)]?

According to the Rust coding guidelines, #[inline(always)] is reserved for
functions using build_assert!() that depend on function parameters. For sma=
ll
forwarding abstractions like this, #[inline] should be used.

[ ... ]
> +/// `N` is to provide the macro a place to emit arbitrary items, in case=
 it needs to prove
> +/// additional properties.
> +#[doc(hidden)]
> +pub struct UnsafeForLtImpl<T: ?Sized, WF, const N: usize>(PhantomData<(W=
F, T)>);
> +
> +// This is a helper trait for implementation `ForLt` to be able to use H=
RTB.
> +#[doc(hidden)]
> +pub trait WithLt<'a> {
> +    type Of: 'a;
> +}
> +
> +// SAFETY: In `ForLt!` macro, a covariance proof is generated when namin=
g `UnsafeForLtImpl`
> +// and it will fail to evaluate if the type is not covariant.
> +unsafe impl<T: ?Sized + for<'a> WithLt<'a>, WF> ForLt for UnsafeForLtImp=
l<T, WF, 0> {

Does this allow safe Rust code to bypass covariance proofs?

Because UnsafeForLtImpl is a public type, it appears safe code can name it
directly to safely obtain a ForLt implementation for a contravariant or
invariant type. For example:

    UnsafeForLtImpl<dyn for<'a> WithLt<'a, Of =3D fn(&'a ())>, fn(&'static =
()), 0>

This would bypass the compiler variance checks generated by the macro's
anonymous const block, potentially enabling use-after-free vulnerabilities
from safe code via cast_ref.

> diff --git a/rust/macros/for_lt.rs b/rust/macros/for_lt.rs
> new file mode 100644
> index 0000000000000..df2027789713a
> --- /dev/null
> +++ b/rust/macros/for_lt.rs
[ ... ]
> +            // `&[mut] T` is covariant over lifetime.
> +            // In case we have `&[mut] NoLifetime`, we don't need to do =
additional checks.
> +            Type::Reference(ty) if !ty.elem.has_lifetime(self.0) =3D> (),
> +
> +            // No mention of lifetime at all, no need to perform compile=
r check.
> +            ty if !ty.has_lifetime(self.0) =3D> (),

Can this logic fail to check covariance for types wrapped in macro invocati=
ons?

The syntactic prover uses has_lifetime to determine if a type depends on the
generic lifetime binder. However, the underlying syn visitor does not trave=
rse
into the unparsed TokenStream of a macro invocation.

If a user provides a type wrapped in a macro, such as
ForLt!(for<'a> SomeMacro!(fn(&'a u32))), has_lifetime will return false.

This would cause the macro to silently skip generating the prove_covariant
safety checks, which might allow unsound lifetime downcasting on contravari=
ant
types.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517000149.3226=
762-1-dakr@kernel.org?part=3D16
