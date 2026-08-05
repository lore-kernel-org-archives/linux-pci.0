Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC82A395AC7
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948217; cv=none; b=gvd0IKCi98epLFZdaqnhqzagjGphvfntwbAhuiMmwjYCofr6vCgWDitf+TyFBQqAqa3wQGc48WW4gh+rKH20GekibcezMDSQqrMHXTZ1yAS8/VkJjQlYfH19zeSmkqQQ3rU/oQzqLCcxiuOLwqH+kuoxmFxKNgIGiVGVos9gLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948217; c=relaxed/simple;
	bh=t8TYSXDACxDse+lvyLP7P5IHrKrgtq/HTnf2vwlWIf8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gp6kGnWzbMXV9Nx8fM1gJdB7hTYaf6D29qRGsgoxziwByuUb9HVLV6yuOvcJxMe+58Z9g7CamwwP/6jOwZgBlgVY9eTxtR6kRfMDVGPT7h9Qj6PStFV1wQPb9bWzNhIJCMAibboX+mKBlZjHZpyeBqoaDykuPeZ17KFHoNYY5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+l/jGzC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+l/jGzC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB891F000E9;
	Wed,  5 Aug 2026 16:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948215;
	bh=pT7l8SqlTeBmBx5G9QdpuVVAq0k+atJiOedvyyiSor8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q+l/jGzCNutidz9qKRG6q8sSJzPC8jPrk9gbsx6q+GXu+Dbqv6+LEjf/cO7pYOiG7
	 0FvDmpC2q68rtkwqU2ZZkndBEqenpPJ+J7gHwpjy/CVLkNW8mOVdMdfXum0eP1XEul
	 rIScskJK2pJ7DaJs0IzcAPl+QRJZaTbAaVgPwom6fOZCCNimMOlOZa6ffG1UxWg4g6
	 rxgFQMHOWRHZ76++16Rw0VAqnEafLMbKTZg0AAriAXnfXeOBShVqTOy9AXzJ42rYIZ
	 IY2tNUhn6rnmFLwr6JPDgwbQne4v8YGOFhxu/YATR4rVgdTkhPa9vu3i8uKk4HRmMC
	 ifn9o31TKrhMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/16] rust: io: register: allow explicit base type
 specification
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260805-typed_register-v2-6-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-6-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:43:34 +0000
Message-Id: <20260805164334.EAB891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `register!` macro fallback rule `($($rest:tt)*)` causes infi=
nite recursion on any syntax error.
--

--- Patch [6]: [PATCH v2 06/16] rust: io: register: allow explicit base typ=
e specification ---
commit f65d8a2bc4e7792b0378bf9b7d9359faf6c62680
Author: Gary Guo <gary@garyguo.net>

rust: io: register: allow explicit base type specification

This commit adds a base parameter to the register! macro to allow explicit
base type specification for I/O regions. It updates the macro definitions
to accept this parameter and adds a compatibility fallback rule for users
that have not yet been converted.

> diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
> index e4039e31b4e78..7dca2437b5516 100644
> --- a/rust/kernel/io/register.rs
> +++ b/rust/kernel/io/register.rs

[ ... ]

> @@ -962,4 +1010,12 @@ impl $crate::io::register::RegisterArray for $name {
> =20
>          impl $crate::io::register::RelativeRegisterArray for $name {}
>      };
> +
> +    // Compatibility rule when base is not specified.
> +    ($($rest:tt)*) =3D> {
> +        $crate::register!(
> +            base: $crate::io::Region;
> +            $($rest)*
> +        );
> +    }
>  }

[Severity: Medium]
Will this catch-all rule cause infinite recursion if there is a syntax
error elsewhere in the macro invocation?

If a developer makes a typo inside a register! block, the strict explicit
matching rules will fail. The token stream then falls through to this
compatibility rule, which prepends the base region and recursively invokes
the macro. Because the original syntax error is still present, the explicit
rules will fail again, triggering this fallback rule repeatedly.

Could this obfuscate the original syntax error by ultimately failing with a
compiler recursion limit error instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D6
