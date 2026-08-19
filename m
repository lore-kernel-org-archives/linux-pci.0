Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE2A36A340
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138625; cv=none; b=KC84tLLFkJWsYegSss3xVVCf6MyQEDcEYHfZt3MN5GHh3E3IItqdhxaWFLC9Nq4uQ/p+is05FSOGqCrmDgr8WjjxgfvEyaokwThh25eoKBExTPju+w3aD0Bi227nzQCVET10H9KJJUUcRAAEzzz1BD/N1Y6dJPYUW23coCDF44U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138625; c=relaxed/simple;
	bh=IZLfntKaOzzFgpRQTHDje+KdoqmLu2kjKrHxDitEPTI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nLOn4/9qbHJfV7YnqfPlS32v92IZ6MgIQ175k4bf3/P0R5Hm5z+M4bmr9+db5l4pgBMN1eCMDKrj86G2e2rp0jnuJbPqZO2NJW3shSVLp6sULmzLSpiDHIIPiDpOJBhkVY6/jm+XE5Cps2ZIsalHDZrF872fqc9pw6kDj/aofG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaK7Ewug; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaK7Ewug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413291F000E9;
	Wed, 19 Aug 2026 11:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138624;
	bh=vz0+VE4OJdUUYiH3h+69CUS+5Mc1TwuqM8kbvKTqRdg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IaK7EwugF/w1jJrqzaYuI2nAkO1DLO9xUj0UxWaLh8DI9HrgmUtUd7qUzqnCWqRR6
	 CZbQxsdzIKVA79BE6CP5VkQKWB+zWhf1beuYXYT4M9kW/zuBZhvRe1IrzizHHz3pE6
	 oMiYoDXXucIRTwXqB2Zryc/u408SZO9kBMYrkz2OWX0qzs+DHL3lkYHUxmx8j6y8HL
	 i9RJSZVnr+G40hn9XIUAU7NvlGh0Le9MR6JfTZDHPSrwTAF9Qq5dvhEigGmosz3JFU
	 iKmvwOuFLC0sos4oH4WIpR8TDqtD5Z/KUhspuiSYEYiLamCZAif5HYwk5jUxJolDjx
	 Rqp94lcqCc4kQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/16] gpu: nova-core: convert hshub0 from relative
 register to projection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260819-typed_register-v3-13-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-13-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:23:43 +0000
Message-Id: <20260819112344.413291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Incorrect usage of `#[inline]` annotation in a driver crate.
- [Low] Imports within the `kernel::io` block are not alphabetically sorted.
--

--- Patch [13]: [PATCH v3 13/16] gpu: nova-core: convert hshub0 from relati=
ve register to projection ---
commit f28bbcca2d960a3571d5473146fa91faad20810e
Author: Gary Guo <gary@garyguo.net>
gpu: nova-core: convert hshub0 from relative register to projection

This commit converts the hshub0 relative access to use projection and a new
base, similar to previous conversions.=20

> diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-cor=
e/fb/hal/gb100.rs
> index d9e4d62ae6321..9fa0949396009 100644
> --- a/drivers/gpu/nova-core/fb/hal/gb100.rs
> +++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
> @@ -5,11 +5,10 @@
> =20
>  use kernel::{
>      io::{
> -        register::{
> -            RegisterBase,
> -            WithBase, //
> -        },
> -        Io, //
> +        io_project,
> +        register,
> +        Io,
> +        Mmio, //

[Severity: Low]
This isn't a bug, but should these imports be alphabetically sorted?=20

The kernel vertical import style usually requires sorting items alphabetica=
lly,
so Io and Mmio would typically precede the lowercase entries.

[ ... ]

> @@ -31,17 +33,26 @@
> =20
>  struct Gb100;
> =20
> -impl RegisterBase<regs::Hshub0Base> for Gb100 {
> -    const BASE: usize =3D 0x0087_0000;
> +register! {
> +    base: NovaRegisters;
> +
> +    HSHUB0: regs::Hshub0Registers @ 0x0087_0000;
> +}
> +
> +#[inline]
> +fn hshub0(bar: Bar0<'_>) -> Mmio<'_, regs::Hshub0Registers> {

[Severity: Low]
This isn't a bug, but is the #[inline] annotation needed here?=20

The Rust subsystem guidelines suggest reserving #[inline] for abstractions,
and specifically note that leaf crates like drivers are exempt from needing=
 it.

> +    io_project!(bar, build: HSHUB0)
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D13
