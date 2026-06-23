Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023B01E7C12;
	Tue, 23 Jun 2026 05:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782191461; cv=none; b=URqZIRFXGbnDI+fRxdMTqrwSTskM7o8T+958W796JB+fpJklfuDnD7RkmPRf38cOE6u4LAza6KuDxI1Sy+xPtYcQ6toNFX7jRFGo/yhouYkjbg+tQ4GZ3lWhDhPUG8hybJBhhTcmCTZMdQSU54V0zl/cLmxGpkGZ7wWRbc+h9DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782191461; c=relaxed/simple;
	bh=jgiMYQ8+519UOoEMYJB1TcwLtALxiS6+HnYg+QIeRLA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CVCIX4pVqFTPAuW1xPvOiTLsEAHGoswgojo19jyTWrHdvOjCVc8iV2T+T5Szyk0qRYD/NjXMQ/+T96+pQsIpH8BHF39gTXawosKW3ezicHwO0gI8TuwE/tC4vkebsJOz66jNtMAy49J2D+uGgkFj9WP+8lx2Wdw2budJEaazGl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4sPiw3c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4sPiw3c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852F81F000E9;
	Tue, 23 Jun 2026 05:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782191459;
	bh=cxErgt6QGJOaXelw63rtR/PkDm8gkVP/xZCez1xaylU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b4sPiw3cYCw/bslbAuPaWPcgIE+Op2u1I+T/1rsfVtLcXTGlFpdeHqVVGkbSm7WYg
	 i6WNjPc4Jcaif7DNlDAts5bsTTOZZwG9/rKPl6e6zHqJMQuHN/6yKpHmvPZLKFL9sJ
	 SVVLPDJ1jkn/rnk2hg1YJEXYn69r7ukG/+br1xehXLSZNgdSOWPgrzZjKFlHGBH1Lr
	 LZvZxnn0da+ndPkCoJYROoUmHy0i7cRu0I3jABf059sQmd3uaPdUczVNcITrE2GXk1
	 /ez7edV4cW0mAMM1zNiJFin/uVvWDYr1s2kpOx9ifmn9sRMCgcizsH0bw3gHbbsSBD
	 JofZ1TrNsRHuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/21] rust: validate: add `Validate` trait
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260623045406.2589547-4-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-4-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 05:10:59 +0000
Message-Id: <20260623051059.852F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `Validate` trait's design makes it impossible to validate st=
ack-allocated array buffers as a single contiguous chunk.
- [Low] Small forwarding functions in a core abstraction are missing the re=
quired `#[inline]` annotation.
--

commit ffc4f142fcfe45cce3f6459e2aef3c631240714d
Author: Benno Lossin <lossin@kernel.org>

rust: validate: add Validate trait

This commit introduces the Validate trait and functions to validate
Untrusted data. It allows users to access the inner value of untrusted
data via validation functions which delegate to a user-implemented
trait. It also uses a sealed trait to restrict valid inputs.

Message-ID: <20250814124424.516191-4-lossin@kernel.org>

> diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
> index 2b28625c25efe..663681b633c86 100644
> --- a/rust/kernel/validate.rs
> +++ b/rust/kernel/validate.rs
[ ... ]
> @@ -107,6 +110,30 @@ pub fn new(value: T) -> Self
>      {
>          Self(value)
>      }
> +
> +    /// Validate the underlying untrusted data.
> +    ///
> +    /// See the [`Validate`] trait for more information.
> +    pub fn validate<V: Validate<Self>>(self) -> Result<V, V::Err>
> +    where
> +        T: Sized,
> +    {
> +        V::validate(self.0)
> +    }

[Severity: Low]
This isn't a bug, but should this small forwarding function in a core
abstraction be annotated with #[inline] per the Rust subsystem coding
guidelines?

> +
> +    /// Validate the underlying untrusted data.
> +    ///
> +    /// See the [`Validate`] trait for more information.
> +    pub fn validate_ref<'a, V: Validate<&'a Self>>(&'a self) -> Result<V=
, V::Err> {
> +        V::validate(&self.0)
> +    }

[Severity: Low]
This isn't a bug, but should this small forwarding function be annotated
with #[inline] as well?

> +
> +    /// Validate the underlying untrusted data.
> +    ///
> +    /// See the [`Validate`] trait for more information.
> +    pub fn validate_mut<'a, V: Validate<&'a mut Self>>(&'a mut self) -> =
Result<V, V::Err> {
> +        V::validate(&mut self.0)
> +    }

[Severity: Low]
This isn't a bug, but should this small forwarding function also be annotat=
ed
with #[inline]?

[ ... ]

> +/// Marks valid input for the [`Validate`] trait.
> +pub trait ValidateInput: private::Sealed {
> +    /// Type of the inner data.
> +    type Inner: ?Sized;
> +}
> +
> +impl<T: ?Sized> ValidateInput for Untrusted<T> {
> +    type Inner =3D T;
> +}
> +
> +impl<'a, T: ?Sized> ValidateInput for &'a Untrusted<T> {
> +    type Inner =3D &'a T;
> +}
> +
> +impl<'a, T: ?Sized> ValidateInput for &'a mut Untrusted<T> {
> +    type Inner =3D &'a mut T;
> +}

[Severity: Medium]
Does the current ValidateInput implementation prevent validating
stack-allocated array buffers as a single contiguous chunk?

If a user populates a stack-allocated buffer like [Untrusted<u8>; N], they
can use it as a slice &mut [Untrusted<u8>]. However, since ValidateInput
is sealed and only implements Untrusted<T> wrappers (and not slices or
arrays of wrappers), they cannot pass this slice to Validate::validate().

Since converting &mut [Untrusted<u8>] back to &mut Untrusted<[u8]> isn't
possible outside the module, this seems to force users to either validate
byte-by-byte or dynamically allocate.=20

Could ValidateInput be implemented for slices of Untrusted<T> to support
validating stack-allocated buffers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623045406.2589=
547-1-alistair.francis@wdc.com?part=3D3
