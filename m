Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375A6395AC7
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948223; cv=none; b=GSAZ6thMuG47sxGENZ606rbh3Zg7Eyl0mLjAnCUr/pApD2YpIAuJIxDxZOkPUOnlzQIhkcBbnT3qgWhpY4+WoPx5JKBnZg3+3YQHJwFWGhWHQ9GoixC/y3AP8z0UZaB6O8FPugip3SsJaEIKmF4QLWsMCjh5QivGO75rL4H97Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948223; c=relaxed/simple;
	bh=kZeCf2DdjgcMWPaVJf8LEoVPxVDpohdYQCuaMLrdrag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q6xPxJuU3IZNHR8PiUgId8oYlPKnblMqTcNKLVvdeMBVknXRSGA4mLzrejS6NqLpA0Ed1kuyAi9wG6pBw9ZEoO7U1xdF4QCWV2sbHkIZ9LW2MldMvY3tWiELiCpQj+80cWxQasvGMRSB9h2lPZqTa7tep4S8xYa2hZxgEYp2gbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJX+rkKX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJX+rkKX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2511F000E9;
	Wed,  5 Aug 2026 16:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948221;
	bh=MvzRydyz06HIj9hgvBQ5xnNg7QdfpNlyKvTAIoy0cbg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IJX+rkKXccakWbAuXRy+dYvsSllaCXRDGFuDPzT4C52lPTPiu6JMx3qRbkBuPJbs+
	 KPFw9VrbeKz5s5T28NWVEW7wZo3lt+a/V5/Sg5SDKcjV39whfYN+AGWvF+sLEwQ5aP
	 WJlnIIOwV/YY+62Mppe+9+46fBF34DKr+2Pqf8dP0zSNEzmQ8ygm6sZDaiKw0dW3kO
	 +mi99TF8iBx5z0vCC71gPAu10b2O2X3x4hKMLr0bJaX+E6rZsNS4lWVrdGFRmOX81r
	 10JPQL7eLI4s68JZmQICptINN2w5GIpOBDlnwb9Myhf+pCUQCSGqurfiTneTtN81v/
	 peqSCdvVvQl9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/16] rust: io: register: handle one register at a
 time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260805-typed_register-v2-4-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-4-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:43:40 +0000
Message-Id: <20260805164341.7E2511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The refactored `register!` macro uses a tail-recursive TT-muncher p=
attern, which increases macro recursion depth linearly with the number of r=
egisters defined. This can cause compilation failures (reaching rustc's rec=
ursion limit) for macro blocks defining a large number of registers.
--

--- Patch [4]: [PATCH v2 04/16] rust: io: register: handle one register at =
a time ---
commit 8ec2a5aa6d4bcb8811ecb0ce6d13218a169b562d
Author: Gary Guo <gary@garyguo.net>

rust: io: register: handle one register at a time

This commit refactors the register! macro to match and handle one register
definition at a time using a recursive pattern. It aims to simplify the rule
definitions by avoiding a single catch-all repetition rule.

> diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
> index d898b2b46d521..91804c1ca117d 100644
> --- a/rust/kernel/io/register.rs
> +++ b/rust/kernel/io/register.rs
[ ... ]
> @@ -786,44 +786,25 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
>  /// ```
>  #[macro_export]
>  macro_rules! register {
[ ... ]
> -    // All the rules below are private helpers.
> +    () =3D> {};
> =20
>      // Creates a register at a fixed offset of the MMIO space.
>      (
> -        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $off=
set:literal
> +        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $offset:l=
iteral
>              { $($fields:tt)* }
> +        $($rest:tt)*
>      ) =3D> {
>          $crate::register!(@bitfield $(#[$attr])* $vis struct $name($stor=
age) { $($fields)* });
>          $crate::register!(@io_base $name @ $offset);
>          $crate::register!(@io_fixed $(#[$attr])* $vis $name);
> +        $crate::register!($($rest)*);

[Severity: Low]
Does this recursive pattern increase the macro recursion depth linearly with
the number of registers defined?

If a single register! block contains a large number of registers, this tail
recursion might exceed rustc's default recursion limit and cause compilation
failures. While this can be worked around by splitting the definitions into
multiple register! invocations, it is a regression compared to the previous
repetition pattern.

>      };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D4
