Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C64754774;
	Tue, 23 Jun 2026 05:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782191634; cv=none; b=FnaRhOCIwXgW8m9ySx2CZ3uIGYaCIVP3rq1SrNh+U91m7E9TOLiLDY4SCM5Rf5TIK027aNKCU0Qx0oYDWaBeQeJJ83ZoQFCSulBhZBN66Li16K/pB4JwHcCsWY3svZGf2um7AWHjfrd5FP2uG+LMEoFnTnxbTjkafTrqWI2DnTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782191634; c=relaxed/simple;
	bh=8NfuWiA6L9i2iUUzuYSFb6zvI8FHDFVhrNrfKlIQT8E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BhJxkNj/tzn8pOaVrIlHJlhRs6GnKzgzfMdTKm6n7eoUbCzLxVVQAPOYm3NGvD+m8aldoO6uH8Hg/+28AXK2Zo/mdPWk48iTZ6375EXD9gk4vYu2/ikgqJKRfrKRH8nIu2QTXSKVQN7KVSvE5Qwl/mhK72z2kmANGqRl2vS12uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFZCF4M2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFZCF4M2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33051F000E9;
	Tue, 23 Jun 2026 05:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782191633;
	bh=q1ZjqTq47xg/OND37Aoj/m5PbgNtKKQ7wZsgwUrwYNg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AFZCF4M2GEjSQfnCsU2HbpUGIN5jYzcSGqY/wktVhyVDcTje55RnPtwL5bf75YGWB
	 5csa3d9+oS7Wvny9UuWqU2hewiULeBoPdOiwAtRMC2PB3k3BFH4dJ2ADX+oSar/r79
	 oZQxsflZt0jLEtLOdFZDK2JlQOmpjTilzY7yZekQ5/ZTjoIBwEd1XtWiiaoNFA/tTW
	 +JoyH9tBAxMO1GCpV98zl4ly9DNtAmzgHQj811zA+Ir/u+2AmYHI1lsmlgPcYuNVP7
	 F30NCfDK6SZppti0dvDqEqNWamJmHuykUQ2uE/VtrlCvFzdDt+Aux2USEJZD+ORdkg
	 4iSWCuPg8yUBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 20/21] rust: allow extracting the buffer from a
 CString
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260623045406.2589547-21-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-21-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 05:13:52 +0000
Message-Id: <20260623051352.E33051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `into_vec` method diverges from Rust's standard library `CSt=
ring` naming conventions, obscuring the presence of the NUL terminator and =
creating a dangerous API trap.
- [Low] Typo in the commit message: 'aroud' instead of 'around'.
--

commit a1ef2ecd44b6df9c9b3d012bdcb8952ab17a0f53
Author: Alistair Francis <alistair@alistair23.me>

rust: allow extracting the buffer from a CString

This patch introduces a method to consume a CString and return its
underlying KVec buffer. It allows users to create a CString and then
extract the internal byte vector for further use.

> The kernel CString is a wrapper aroud a KVec. This patch allows

[Severity: Low]
This isn't a bug, but there is a typo in the commit message: "aroud"
should be "around".

> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -870,6 +870,12 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Res=
ult<Self, Error> {
>          // exist in the buffer.
>          Ok(Self { buf })
>      }
> +
> +    /// Return the internal buffer while consuming the original [`CStrin=
g`]
> +    #[inline]
> +    pub fn into_vec(self) -> KVec<u8> {
> +        self.buf
> +    }

[Severity: Medium]
Does this naming diverge from standard Rust library conventions and obscure
the presence of the NUL terminator?

In the standard library, extracting the underlying buffer from a CString
typically strips the NUL byte with a method like into_bytes(), while the
method that keeps it is explicitly named into_bytes_with_nul().=20

Calling this into_vec() might mislead callers into assuming the NUL byte is
already stripped, which could cause developers to unintentionally include a
NUL byte in buffers or calculate incorrect offsets.

Could this be renamed to into_bytes_with_nul() to match standard
conventions and clarify the buffer's contents?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623045406.2589=
547-1-alistair.francis@wdc.com?part=3D20
