Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A61B30568B
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779744053; cv=none; b=hOXa5YVshQB4DWa86DO1U85UmZqMHest5BZIAKundnUJfSbJAhx0xNrfhZ9wciMe2vwdcaED/skVE96vq+ITZqesGm8x3MdEelKV4UMgdzF/tsBL71tYY5GpHuAC2S7Iz1xnQNFNL1+3hWS3H+UiWNUwm/lXLA9glZDeWMI4B9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779744053; c=relaxed/simple;
	bh=s+1d655DwUzDmcpEwJzEi6qbOu+KedG75L05XXexNHM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d7eg0m5TKNZwnbCornLF2bty+qLCAbFnhqOtapCpb4EuiF579cTuhn3ABdRN2a4k8iPrAtmvrWKjKWEk1P7IfBnwYOzISujBr6zzWsC/LbQw6kBsVIxWshVvzPUgXzUl1EhfSFrRQS1RzMgnMn5tnZ+Cp2XfSAvcRv4gmS+n344=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8eUCMDa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8eUCMDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C091F000E9;
	Mon, 25 May 2026 21:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779744051;
	bh=3LvnyGcOcfVzDwXW+Uc9hpL8zMhgPEoAQIwmJdfTRbo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B8eUCMDad+NjkpcvkJ1Jppo/cInORvoNtRbCf2yk3zfQxhLy/Vik4CXIvgWvWilhB
	 BGTSdzPZvm85EmKQoAgBU1vctt1LOyXSJOGKwsGhSWlVZ0aPZPWdKXQK+HHFQYXJST
	 2XrDmokSsh7zx5eqQGpxopU+scd0zo5YpLIrKqKkEqzggQGu+debOyoonjHrkrv7sd
	 nRfKOUhbS4CEaiOQReZPaQAndNuYGNn4g1m1k9kgn0LBq+Y5jT5AQCZ37gTujjFBQH
	 RjEty63+w4K/3r0vuqnnjS+0V5iqzZohhB1ztI1nM50iVdzhN1w0TTsbBzNDZwzria
	 0cMaRpyv/J69g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 22/24] rust: types: add `ForLt` trait for
 higher-ranked lifetime support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260525202921.124698-23-dakr@kernel.org>
References: <20260525202921.124698-23-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 21:20:51 +0000
Message-Id: <20260525212051.64C091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Safe code can bypass the `ForLt!` macro's covariance checks and ca=
use Undefined Behavior.
- [Medium] `ForLt!` macro fails to replace lifetimes inside macro invocatio=
ns, causing E0261 undeclared lifetime errors.
- [Low] Incorrect use of `#[inline(always)]` on `cast_ref`.
- [Low] The well-formedness workaround `#ty_static` strictly bounds capture=
d generic types to `'static`.
- [Low] The rustdoc compile_fail test is ignored.
--

commit 7d554c95fb79799acb08213b598bd1324b690e69
Author: Gary Guo <gary@garyguo.net>

rust: types: add ForLt trait for higher-ranked lifetime support
   =20
This commit introduces the ForLt trait and ForLt! macro to describe types
generic over a covariant lifetime. The macro includes logic to prove
covariance and ensure well-formedness.
   =20
Link: https://docs.rs/higher-kinded-types/ [1]

> diff --git a/rust/kernel/types/for_lt.rs b/rust/kernel/types/for_lt.rs
> index 0000000000000..a54acdbfb12b8
> --- /dev/null
> +++ b/rust/kernel/types/for_lt.rs
[ ... ]
> +/// The macro will attempt to prove that the type is indeed covariant ov=
er the lifetime supplied.
> +/// When it cannot be syntactically proven, it will emit checks to ask t=
he Rust compiler to prove
> +/// it.
> +/// ```ignore,compile_fail
> +/// # use kernel::types::ForLt;
> +/// # fn expect_lt<F: ForLt>() {}
> +/// # expect_lt::<
> +/// ForLt!(fn(&u32)) // Contravariant, will fail compilation.
> +/// # >();
> +/// ```

[Severity: Low]
Is this test intentionally skipped? The rustdoc 'ignore' attribute
supersedes 'compile_fail', meaning the test is skipped entirely rather than
asserted for compilation failure. Can this be changed to just 'compile_fail'
so the covariance check is mechanically verified?

[ ... ]
> +pub unsafe trait ForLt {
> +    /// The type parameterized by the lifetime.
> +    type Of<'a>: 'a;
> +
> +    /// Cast a reference to a shorter lifetime.
> +    #[inline(always)]
> +    fn cast_ref<'r, 'short: 'r, 'long: 'short>(long: &'r Self::Of<'long>=
) -> &'r Self::Of<'short> {
> +        // SAFETY: This is sound as this trait guarantees covariance.
> +        unsafe { core::mem::transmute(long) }
> +    }
> +}

[Severity: Low]
This isn't a bug, but does this violate the inline annotation guidelines?
According to the rust subsystem rules, #[inline(always)] should only be
used for functions utilizing build_assert!() that depend on function
parameters. For small forwarding functions in abstractions, #[inline]
should be used instead.

[ ... ]
> +/// This is intended to be an "unsafe-to-refer-to" type.
> +///
> +/// Must only be used by the `ForLt!` macro.
> +///
> +/// `T` is the magic `dyn for<'a> WithLt<'a, TypeThatUse<'a>>` generated=
 by macro.
> +///
> +/// `WF` is a type that the macro can use to assert some specific type i=
s well-formed.
> +///
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
> +    type Of<'a> =3D <T as WithLt<'a>>::Of;
> +}

[Severity: High]
Can safe code bypass the covariance checks and cause undefined behavior her=
e?
Since UnsafeForLtImpl and WithLt are public, safe code can interact with th=
em
directly without going through the ForLt! macro.

If a user explicitly names a trait object type like:
UnsafeForLtImpl<dyn for<'a> WithLt<'a, Of =3D fn(&'a i32)>, (), 0>

The blanket unsafe impl ForLt accepts this contravariant type. Safe code
could then call the safe cast_ref method on this type, which performs an
unsafe transmute assuming covariance. This would allow converting a
long-lived reference requirement into a short-lived one.=20

Does this need additional protection to ensure safe code cannot instantiate=
=20
it directly?

> diff --git a/rust/macros/for_lt.rs b/rust/macros/for_lt.rs
> new file mode 100644
> index 0000000000000..75d0ce450bf0d
> --- /dev/null
> +++ b/rust/macros/for_lt.rs
[ ... ]
> +    fn replace_lifetime(&self, src: &Lifetime, dst: &Lifetime) -> Type {
> +        struct LifetimeReplacer<'a>(&'a Lifetime, &'a Lifetime);
> +
> +        impl VisitMut for LifetimeReplacer<'_> {
> +            fn visit_lifetime_mut(&mut self, lifetime: &mut Lifetime) {
> +                if lifetime.ident =3D=3D self.0.ident {
> +                    *lifetime =3D self.1.clone();
> +                }
> +            }
> +        }
> +
> +        let mut ret =3D self.clone();
> +        LifetimeReplacer(src, dst).visit_type_mut(&mut ret);
> +        ret
> +    }

[Severity: Medium]
Does this miss replacing lifetimes inside macro invocations? The
has_lifetime() method was updated with a visit_macro implementation to
correctly identify lifetimes inside macros, but replace_lifetime() uses
VisitMut which does not traverse opaque TokenStreams in macros.

If explicit lifetimes inside a macro invocation are not replaced with
'static, will the generated type retain the original lifetime binder but
be emitted outside the scope, causing an E0261 undeclared lifetime error?

[ ... ]
> +    // Make sure that the type is wellformed when substituting lifetime =
with `'static`.
> +    //
> +    // Currently the Rust compiler doesn't check this, see the above Pro=
veWf documentation.
> +    //
> +    // We prefer to use this way of proving WF-ness as it can work when =
generics are involved.
> +    let ty_static =3D ty.replace_lifetime(
> +        &lifetime,
> +        &Lifetime {
> +            apostrophe: Span::mixed_site(),
> +            ident: format_ident!("static"),
> +        },
> +    );

[Severity: Low]
Does this well-formedness workaround strictly bound captured generic types
to 'static? By substituting the lifetime with 'static to generate the type
here, any generic type parameters inside the macro (like ForLt!(&T)) will
be forced to satisfy a 'static bound. Does this limit the abstraction and
prevent it from being used with generic parameters bounded by shorter
lifetimes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525202921.1246=
98-1-dakr@kernel.org?part=3D22
