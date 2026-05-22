Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D52581ACA
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 00:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779409868; cv=none; b=vAOQ6rahP44N4EED07YPvwiUprht9m8TDmeA85Qs1hcf+HsFQIubXDC9E8TNaHQLzxzctb+s2XmdNaWixVig+WXLgzSmptYzIiNQGL12FN+DHJo4K0GUsVCUU6r9Ibf369FTl504r0N1dkKidRAB1D8d1Zw/z+TT3XlnaZvUxM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779409868; c=relaxed/simple;
	bh=iHmJ8Z85exptMFh9UfRpMkLog3oZ6f3MKscq8yy7Q20=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CHzlbZ7DAT6rUPMzR3Ja5Qic7CdNufpQndMeG3e40nyucIUci75SJn8NoZwhbD/euQ9T4iqe7+EQXg7aodGvG1mjSPcBKlPoDVqM2y7XVCmsAsL+47QkaFVZIQ7ADYc9dfvRn3QEIRWFGzfRn1whULpLNtpf3gZWGlhFHDp21NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7x+uLpQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7x+uLpQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235C61F000E9;
	Fri, 22 May 2026 00:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779409867;
	bh=3jFcbQj+nsXFdV7y8ggDuHSvDLQqMsLubCGT+uMFfog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A7x+uLpQUO+n1VaVoiqu26lLRYYdr6umP4d4jjdJXnNWMJALdhXK5Dkss/EgGFql1
	 Py09pReF2boSl4tCcN1vpNChYlLT9I07dOhB+77vD/HrAsRi+27SxxcNw/Fsxpovya
	 f3y3HuocsRrUVl19Jaf1UvyKNXR1ZSgb6C4uKku6GZG0aLD092nHEsJhqtW2LVYvpG
	 5gYy/kIViXF4P4vdd0rHKPPvhPMyKWZcAyABhsT+lrbOTtAfGwBEHcLDY4tDq9a2vA
	 3+ca1vREKdDJpshS1ECRN4Brf/APHC2RpYwyEqfhjQDc1ToaBRxAPCIzrrFoUOFwvH
	 jukzFCKemiDuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 21/27] rust: types: add `ForLt` trait for
 higher-ranked lifetime support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260521233501.1191842-22-dakr@kernel.org>
References: <20260521233501.1191842-22-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 00:31:06 +0000
Message-Id: <20260522003107.235C61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] The `ForLt!` macro's covariance check can be bypassed when a l=
ifetime is hidden inside a nested macro invocation, leading to unsound impl=
ementations of the `ForLt` trait.
- [Critical] The safety architecture of `ForLt` is flawed because it allows=
 safe code to bypass the macro's covariance proofs entirely, directly leadi=
ng to soundness vulnerabilities.
- [Low] Incorrect usage of `#[inline(always)]` on `cast_ref`.
- [Low] `expand_elided_lifetime` fails to replace elided lifetimes (`'_`) h=
idden inside macro invocations.
--

commit a372a3dda5030ca04860c4057bb0215647faa34b
Author: Gary Guo <gary@garyguo.net>

rust: types: add ForLt trait for higher-ranked lifetime support

This commit introduces the ForLt trait and a corresponding macro to
support types that are generic over lifetimes. The macro attempts to
syntactically prove covariance or emits compiler checks to ensure the
soundness of lifetime shortening casts.

Link: https://docs.rs/higher-kinded-types/ [1]

> diff --git a/rust/kernel/types/for_lt.rs b/rust/kernel/types/for_lt.rs
> new file mode 100644
> --- /dev/null
> +++ b/rust/kernel/types/for_lt.rs

[ ... ]

> +pub unsafe trait ForLt {
> +    /// The type parameterized by the lifetime.
> +    type Of<'a>: 'a;
> +
> +    /// Cast a reference to a shorter lifetime.
> +    #[inline(always)]
> +    fn cast_ref<'r, 'short: 'r, 'long: 'short>(long: &'r Self::Of<'long>=
) -> &'r Self::Of<'short> {

[Severity: Low]
This isn't a bug, but according to the rust subsystem coding guidelines,
#[inline(always)] should only be used for functions using build_assert!()
that depend on function parameters. Should this be changed to #[inline]?

> +        // SAFETY: This is sound as this trait guarantees covariance.
> +        unsafe { core::mem::transmute(long) }
> +    }
> +}

[ ... ]

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
> +    type Of<'a> =3D <T as WithLt<'a>>::Of;
> +}

[Severity: Critical]
Can safe downstream code implement the public WithLt trait for an
invariant type (like Cell<&'a u32>), and then name
<UnsafeForLtImpl<MyStruct, (), 0> as ForLt> to access ForLt::cast_ref?

If so, does this allow shortening lifetimes of invariant types entirely
in safe code, bypassing the macro's covariance checks and breaking
safety guarantees?

> diff --git a/rust/macros/for_lt.rs b/rust/macros/for_lt.rs
> new file mode 100644
> --- /dev/null
> +++ b/rust/macros/for_lt.rs

[ ... ]

> +    fn expand_elided_lifetime(&self, explicit_lt: &Lifetime) -> Type {
> +        struct ElidedLifetimeExpander<'a>(&'a Lifetime);
> +
> +        impl VisitMut for ElidedLifetimeExpander<'_> {
> +            fn visit_lifetime_mut(&mut self, lifetime: &mut Lifetime) {
> +                // Expand explicit `'_`
> +                if lifetime.ident =3D=3D "_" {
> +                    *lifetime =3D self.0.clone();
> +                }
> +            }
> +
> +            fn visit_type_reference_mut(&mut self, reference: &mut syn::=
TypeReference) {
> +                syn::visit_mut::visit_type_reference_mut(self, reference=
);
> +
> +                if reference.lifetime.is_none() {
> +                    reference.lifetime =3D Some(self.0.clone());
> +                }
> +            }
> +        }
> +
> +        let mut ret =3D self.clone();
> +        ElidedLifetimeExpander(explicit_lt).visit_type_mut(&mut ret);
> +        ret
> +    }

[Severity: Low]
If an elided lifetime is passed inside a macro invocation, such as
ForLt!(Wrapper<SomeMacro!(<'_>)>), does VisitMut fail to traverse the
TokenStream inside the Type::Macro?

Will this leave the elided lifetime unmodified and cause a missing
lifetime specifier compiler error?

[ ... ]

> +    fn prove(&mut self, ty: &'a Type) {
> +        match ty {

[ ... ]

> +            // Macro invocations are opaque to proc macros; conservative=
ly require
> +            // a compiler proof since we cannot determine lifetime usage.
> +            Type::Macro(_) =3D> self.1.push(ty),
> +
> +            // No mention of lifetime at all, no need to perform compile=
r check.
> +            ty if !ty.has_lifetime(self.0) =3D> (),
> +
> +            // Otherwise, we need to emit checks so that compiler can de=
termine if the types are
> +            // actually covariant.
> +            ty =3D> self.1.push(ty),
> +        }
> +    }

[Severity: Critical]
If a lifetime is hidden within a macro invocation that is nested inside
another type, for example ForLt!(for<'a> Cell<Mac!('a)>), will
has_lifetime falsely return false because it doesn't traverse into
the macro's TokenStream?

Since the Type::Macro arm only matches top-level macros, does the nested
Type::Path (Cell) fall through to the ty if !ty.has_lifetime(self.0) arm?

If so, does this bypass the compiler-assisted covariance proof and
allow unsound lifetime shortening casts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521233501.1191=
842-1-dakr@kernel.org?part=3D21
