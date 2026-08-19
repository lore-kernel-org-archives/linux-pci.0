Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3605645C6E9
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138804; cv=none; b=Wf5PQ/Q+WcImLzQbodBfgeL5XJqbU911N0HxWNJO2hbKinh9M9OZl6HRx56nVMXxZjeW3Ue/Iz1O8985j9q8xfuwKKZHRmLQd2CDYRif0swmfM8Z8uIsYKotznU6IzcCrPfbyXgZnVNf0nS1LRRwDKCIduhguZn1PaXQ8vyp5S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138804; c=relaxed/simple;
	bh=QQ+kfC2Wk1Utded5nkJg2hYSczHXoaxqO8t3gce8L+A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LZZSJmfF/RQvHAmyYQZzuXytRjCm/cnO8T2McpWlL/U6pL823MEIkt2x1MOPUo4XJWlKi/pwmorscQXLFTLigiOh6CDXL9TvlOZXyKBKnCl1NJTw9JGoVni7YSZp7QDMU3OZC1yIEuDq4eSLfuthrRPRVsLh82icXv6U5wbEONg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3bkZaYG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3bkZaYG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842651F000E9;
	Wed, 19 Aug 2026 11:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138801;
	bh=70rYFpNpEVuBJS/kcWm3ASQjiKWfReH5YKltd/e91dg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D3bkZaYG0l95mX+oMMxu80YL6J45IgANNiHVUVuyL81T2wa8LrkNL8tbbNou1viZI
	 5Ev2ISss27y4XeGdFeJMUtgEj4XJQyyXwhwbaiiH4qtHN3wTniMp4uHVRRUmq+S53D
	 swPohH+6eU2Z3++wGley0fx6rEzjsqMNGL8d2QT+w8najDP3RPu0ypZqGuy6RguHSw
	 XK6cK4MyuoDS7x3fXrGiqx6++TxQ1qSKKVJZghar4r3U3XCY8RdkjlyJAov4aVEk8B
	 CgRGuweF4iHrH2TNfWKrcoje3JU9geqVzEDUusYG41+A/l/k0EVY79bU3EMf7CHIOY
	 hogzE0MP0p+gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/16] rust: io: register: unify handling of register
 with/without bitfields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260819-typed_register-v3-16-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-16-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:26:41 +0000
Message-Id: <20260819112641.842651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `#[unique]` attribute allows implementing `FixedIoLoc` for s=
tandard primitive types (like `u32`), which silently binds all implicit typ=
e-based writes in a Base to a single specific register.
- [Low] The `register!` macro incorrectly uses the `unique` flag instead of=
 checking for an inline bitfield to validate array registers, allowing `#[u=
nique]` on non-bitfield arrays to bypass validation and generate invalid Ru=
st code.
--

--- Patch [16]: [PATCH v3 16/16] rust: io: register: unify handling of regi=
ster with/without bitfields ---
commit 154a352ba1f637b66e6182a851b9260fee49b4d6
Author: Gary Guo <gary@garyguo.net>

rust: io: register: unify handling of register with/without bitfields

This commit moves the FixedRegister to become a property of the type by
introducing a new FixedIoLoc trait. It exposes this to registers without
inline bitfield definitions via the #[unique] attribute.

> diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
> index e0bba6b71ebc1..84be1a5939596 100644
> --- a/rust/macros/io/register.rs
> +++ b/rust/macros/io/register.rs
[ ... ]
> @@ -217,27 +230,30 @@ pub(crate) fn register(def: RegDef) -> Result<Token=
Stream> {
>          }
> =20
>          match array {
> -            None if bitfield.is_none() =3D> outputs.extend(quote!(
> -                #(#attrs)* #vis const #name: ::kernel::io::register::Off=
setLoc<#base, #ty> =3D
> -                    ::kernel::io::register::OffsetLoc::new(#offset);
> -            )),
> -
> -            _ if bitfield.is_none() =3D> Err(Error::new_spanned(
> -                ty,
> -                "defining without bitfield is not yet supported for this=
 type of register",
> -            ))?,
> -
> -            None =3D> outputs.extend(quote_spanned!(span =3D>
> -                impl ::kernel::io::register::FixedRegister for #name {
> -                    type Base =3D #base;
> -                    const OFFSET: usize =3D #offset;
> +            None =3D> {
> +                if unique {
> +                    outputs.extend(quote!(
> +                        impl ::kernel::io::register::FixedIoLoc<#base> f=
or #ty {
> +                            type Location =3D ::kernel::io::register::Of=
fsetLoc<#base, #ty>;
> +                            const LOCATION: Self::Location =3D #name;
> +                        }
> +                    ))
>                  }

[Severity: Medium]
Does this allow implementing FixedIoLoc for standard primitive types like u=
32?

If a register is defined with a standard primitive type and #[unique] is
applied (e.g., pub REG: #[unique] u32 @ 0x100;), this generates
impl FixedIoLoc<Base> for u32. This would silently bind all implicit
type-based writes in that Base to a single specific register.

If someone accidentally types io.write_reg(val) intending to write to anoth=
er
register, and val is a u32, the compiler might silently accept it and write=
 to
REG, bypassing the intended type-safety.

Is it possible to restrict this behavior to ensure it doesn't apply to shar=
ed
primitive types?

> =20
> -                #(#attrs)* #vis const #name: ::kernel::io::register::Fix=
edRegisterLoc<#name> =3D
> -                    ::kernel::io::register::FixedRegisterLoc::<#name>::n=
ew();
> -            )),
> +                outputs.extend(quote_spanned!(span =3D>
> +                    #(#attrs)* #vis const #name: ::kernel::io::register:=
:OffsetLoc<#base, #ty> =3D
> +                        ::kernel::io::register::OffsetLoc::new(#offset);
> +                ));
> +            }
> =20
>              Some(def) =3D> {
> +                if !unique {
> +                    Err(Error::new_spanned(
> +                        &ty,
> +                        "defining without bitfield is not yet supported =
for this type of register",
> +                    ))?
> +                }

[Severity: Low]
Does this incorrectly check for the unique flag instead of an inline bitfie=
ld
to validate array registers?

For array registers, the macro must ensure a type named #name exists so it =
can
implement the Array trait on it. If a user defines an array register withou=
t a
bitfield but explicitly adds the #[unique] attribute, unique becomes true,
which bypasses the macro's validation check.

This would then generate impl ::kernel::io::register::Array for #name {}
without actually defining #name as a type or constant, resulting in a confu=
sing
"cannot find type" compiler error rather than the intended descriptive macro
error.

Should this check be based on whether a bitfield is present?

> +
>                  let size =3D &def.size;
>                  let stride =3D if let Some(stride) =3D &def.stride {
>                      outputs.extend(quote_spanned!(stride.span().resolved=
_at(span) =3D>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D16
