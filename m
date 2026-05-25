Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80025390C95
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779742072; cv=none; b=Pp4PGn2fDw85lAJko1elXVVPyevSIgaRkS5jgyLfxT9n/8oANp6y+0XjBwvy/x3W8N5xUbMRdmxF05bqM9DWWbvqSb6boN0ulb2YrDtfMgwVKUD1uMEOFRdjQs0pdOpl9FnGWhdz4NNwQM29lCDCnC/NyXgV7cg4I+8VYBeHEpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779742072; c=relaxed/simple;
	bh=M3S6CX35sAQHkqZE5JTEs3EZfZtCoB0LRXxG5SBkIIE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FvmIMEwvLJ7NkR6sA1FOJgeEzSuN7rSasNUfsOlgIcPDGpxGafHLITT42g6KBk5mp8VHBLERiosXkluyxiNca9hTZjnZKSXy26MFN1JyGrDsoJZrPHxOhKJb+dvrdi/sN6IOUZxr/3VvboBnPdUmIyL+6oloISr2VUzHdgI3nLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glYhrnGj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glYhrnGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0461F000E9;
	Mon, 25 May 2026 20:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779742071;
	bh=O7/B5WWDRey+lZK2H5u1FKiG4KAXFhYOoth5clRzOXk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=glYhrnGjSF1gDsjn+Dl2mKMX1H0ZubP4afrph65XWyBcjOC3O8ZNJ1p7qnq6uO2Kl
	 xjT6WSl6JSqaeb8ceKdhCB2qT3k6Re/g/7gzdw+h721wanuGIZpr8vJLrDeN5ofEUU
	 A6dd1PVy5Y9vQrDZD9YO8Vr/FZC2cIYXRI65+m+bZhP2RD6kOya1ZTux8yF801LhSK
	 TAN5eWmBvzJOhMh5+YUTqWldX9/KQ8ubo2iCtKHfWzN7B4FUC/h7je+Q7A/7UWgiqH
	 1/C2p/st8CsEmjdHoiCPnFtahQMYnPI3BY7RtY65etkuCg3JpJWeksDe6CIeOCFJEA
	 n9c9urdG4SA9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/24] rust: driver: decouple driver private data
 from driver type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260525202921.124698-5-dakr@kernel.org>
References: <20260525202921.124698-5-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 20:47:50 +0000
Message-Id: <20260525204750.DF0461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Mismatch between commit message and implementation regarding Dat=
a<'bound> associated type
- [Low] Incomplete updates to sample drivers and doc comments to reflect th=
e new `probe` return type
--

commit 0e6d93fa6eec846c359654d90bf3423215c84f3d
Author: Danilo Krummrich <dakr@kernel.org>

rust: driver: decouple driver private data from driver type

This commit adds a Data associated type to all bus driver traits, decoupling
the driver's bus device private data type from the driver struct itself. It
also updates existing drivers and documentation examples to set Data =3D Se=
lf
to preserve existing behavior.

> Add a type Data<'bound> associated type to all bus driver traits,
> decoupling the driver's bus device private data type from the driver
> struct itself.
>=20
> In the context of adding a 'bound lifetime, making this an associated
> type has the advantage that it allows us to avoid a driver trait global
> lifetime and it avoids the need for ForLt for bus device private data;
> both of which make the subsequent implementation by buses much simpler.

[Severity: Medium]
Is this commit message accurate for the current implementation?

The commit message explicitly claims to add a Data<'bound> associated type
to all bus driver traits to avoid the need for ForLt. However, looking at
the code changes in this patch, the user-facing bus traits only add
"type Data: Send;" without any lifetime parameter.

Could this be an outdated description from a previous iteration of the
design?

> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
> index 129bb4b39c044..e583c6b8390ad 100644
> --- a/samples/rust/rust_dma.rs
> +++ b/samples/rust/rust_dma.rs
> @@ -58,6 +58,7 @@ unsafe impl kernel::transmute::FromBytes for MyStruct {}
> =20
>  impl pci::Driver for DmaSampleDriver {
>      type IdInfo =3D ();
> +    type Data =3D Self;
>      const ID_TABLE: pci::IdTable<Self::IdInfo> =3D &PCI_TABLE;
> =20
>      fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl Pin=
Init<Self, Error> {

[Severity: Low]
Should the return type in these sample drivers and documentation examples be
updated to use impl PinInit<Self::Data, Error> instead of Self?

While this compiles correctly because the examples define type Data =3D Sel=
f,
it doesn't fully demonstrate the newly decoupled API. If someone uses this
code as a template and changes the Data type to a distinct structure, they
will likely encounter a confusing type mismatch error. There are several
other examples in this patch (like rust_driver_platform.rs and io/mem.rs)
that also still return impl PinInit<Self, Error>.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525202921.1246=
98-1-dakr@kernel.org?part=3D4
