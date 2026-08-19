Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D544E647
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138370; cv=none; b=RQAcVjUDWr3oNWRca6P+jrJGuRLmnf5Q5zfeSMwxEgPDDmma1njNrWsopmhYl2PJXhcxAdD5cwyjVM2Qq6/gQ/XVOURK65Z5L8kydSctYhmF36pfZhxo8S0RHirgm2qRXTOo15cQyLEtUrCPotfxLOZx7I32Fx1MpEuKz2zvfXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138370; c=relaxed/simple;
	bh=2uJR3y9CL3+IvDUGoKVw9Y9HUAh5jNDR1Qvk1hJVg+s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ptN74HdTrNWX5u4YgO8u/Caf0bqbkCZZOimIcLcEw/7dUxTew/b+huvixSYz9UZbs+OWWPT/B5D5FF25HBBLDt7BjVuXFVZw+fghgZ/O6rbKtDmHGmGwwpjse9PNHY7FUlQONWKRvCBj98xR30/ZZtz7TFCnsdHjiMtue/+cvRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/OMyP/M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/OMyP/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959791F000E9;
	Wed, 19 Aug 2026 11:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138368;
	bh=NEwB5P8E3bJckGKg+azupxgPzftFyqZf7DbXSnaRsks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V/OMyP/Mq+rZL+8hSl9J66Fofe0rQFFk2+8cvmY6J9p4bRE3hqS64q564bMDu2IXj
	 +QuMCk/Bip1VHVwVqW57Qovwa5s8iFUgtUsHaOPw4N1zHx88ihQnhrEGnwYJjsENP/
	 NLaeTchbpEtA37U42yP8qm9SwCs8ZtOaKRECex1FoZuSyO6eOZqUFuCVjFsRoQ0gWo
	 J7U/L4iU2UGD8BJqzqBBcfq63t6C+4KpITIx+Bamy/yWjM6NLnOtDRFSR7IVklmqRJ
	 99WUL7xJAw2b2WjYdNiwFZVKhiC48P/GjFnax1aMUG/lbHX80SSGvPQHKUi2lUh6KW
	 Hk0f3NGQPvr8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/16] rust: mem: add `AsRepr` and `AsReprMut`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260819-typed_register-v3-3-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-3-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:19:28 +0000
Message-Id: <20260819111928.959791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Incorrect use of `#[inline(always)]` instead of `#[inline]` for abs=
traction trait methods.
- [Low] The commit message asserts that 'all repr types are normalized to u=
nsigned integers', but pointer types use `*const c_void` as their represent=
ation.
--

--- Patch [3]: [PATCH v3 03/16] rust: mem: add `AsRepr` and `AsReprMut` ---
commit 0638c4f7e52f9eb87681654296d18ff15c916f15
Author: Gary Guo <gary@garyguo.net>

rust: mem: add AsRepr and AsReprMut

This commit adds AsRepr and AsReprMut traits to indicate that a type
can be turned into a primitive for operations like atomics and I/O. It
also provides implementations for booleans, pointers, and integers.

> To avoid duplicating implementation, all repr types are normalized to
> unsigned integers.

[Severity: Low]
This isn't a bug, but the commit message states that all repr types are
normalized to unsigned integers. However, the implementations for *mut T
and *const T use *const c_void as their representation instead of an
unsigned integer. Should the commit message or the pointer implementations
be updated to match?

> diff --git a/rust/kernel/mem.rs b/rust/kernel/mem.rs
> index a0901cbe1b2d6..5bce381d88952 100644
> --- a/rust/kernel/mem.rs
> +++ b/rust/kernel/mem.rs
[ ... ]
> +pub unsafe trait AsRepr: Sized {
> +    /// Primitive representation of this type.
> +    type Repr;
> +
> +    /// Convert from [`AsRepr::Repr`] to `Self`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `repr` must be a valid bit patern of `Self`. If `repr` is previo=
usly obtained using
> +    /// [`AsRepr::into_repr`], then it will always be safe.
> +    #[inline(always)]
> +    unsafe fn from_repr_unchecked(repr: Self::Repr) -> Self {

[Severity: Low]
This isn't a bug, but is #[inline(always)] the intended attribute here?
The Rust subsystem guidelines state that functions for abstractions should
be annotated with #[inline] unless they use build_assert!() dependent on
function parameters.

> +        // SAFETY: Per safety requirement of the trait.
> +        unsafe { transmute_unchecked(repr) }
> +    }
> +
> +    /// Convert from `Self` to [`AsRepr::Repr`].
> +    #[inline(always)]
> +    fn into_repr(this: Self) -> Self::Repr {

[Severity: Low]
This isn't a bug, but this method might also need to use #[inline] rather
than #[inline(always)] for the same reason.

> +        // SAFETY: Per safety requirement of the trait.
> +        unsafe { transmute_unchecked(this) }
> +    }
> +}
> +
> +/// Type that is bi-directionally transmutable with a primitive represen=
tation.
> +///
> +/// # Safety
> +///
> +/// - [`Self`] must be [transmutable] from [`Self::Repr`].
> +/// - Note that [`Self::Repr`] must be [transmutable] from `Self` as wel=
l, however that is a
> +///   requirement of the [`AsRepr`] super trait already.
> +///
> +/// [`transmutable`]: core::mem::transmute
> +pub unsafe trait AsReprMut: AsRepr {
> +    /// Convert from [`AsRepr::Repr`] to `Self`.
> +    #[inline(always)]
> +    fn from_repr(repr: Self::Repr) -> Self {

[Severity: Low]
This isn't a bug, but would it be better to use #[inline] here to follow
the abstraction guidelines?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D3
