Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA1E3D811C
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948395; cv=none; b=H5GxUelTMRLxnOfGcne2SaIuxrGSiV2eAu6hGaygHlFoKVIBNwSdfMuPXc8udyQEbTnS41ThMEHlk+xD7eTFfJedAiLt/piA1NWZyLJPTW80/2kEOcU9rlU6rpv6Rkk2P9Rop+1cFZNgziT3P/NMTBQfnIOIQsZGC6HfTvLCDbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948395; c=relaxed/simple;
	bh=dMLFwHWFkscoUZcvM7hlN/+iUsvQFnP1dDN6XHn6y+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i5XhTiwJ5ybDLqj3vbLq7ocDMz/Hthos16jbNoX0pObeYGBVYu5XJ+NHoHGt+HSJ1ZHkN7WPULVcP35uit9KnxQFsqzIupybfXPKhdJiuGzw+BYKz5ap5R177q5fySPiS5mMiOcdaZ0/YPDQ5+Sc038ICDYmz9OpNXngcaNbyPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHe7l6RA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHe7l6RA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E0E1F000E9;
	Wed,  5 Aug 2026 16:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948393;
	bh=985jZjDz+qUwEBNpXS944ilYWn0u8gi9bGWcYoeb0EE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CHe7l6RACkx6cU4og0Kjv28R4BViODHV4HQMMQG73pslqCE9Hp6aEq9RKdMBZ0j/C
	 GlPfjqBFSbGeHGO3FPn07rODp2V7eCTw48h8ANIGNs56TyhdLrMCzONN/+W8ULitXC
	 IBJHTNA3AFz9hGn7M78jWKXAq4rEzfNZTZ56uwHgx5+Uc4OWxq3rCObihHYYOeI8Y7
	 xGDmInyTsNcFWm9Gyi+X+uCLCBIDuVsvGKG53vTjKwV554TWar7v9shi0p2XvZ3yEk
	 Er1tqfSKXHskGQYCgv4uDm8SCI7gfrnUPgeDs1mTIs6TWY+f+z1upDuf4F+q4y2Q1A
	 SJJmI7nmohxLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/16] rust: io: add `IoRepr` trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260805-typed_register-v2-2-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-2-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:46:32 +0000
Message-Id: <20260805164633.84E0E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> For types that are layout-compatible with an I/O capable type, we would
> want the ability to use them directly for I/O operations. E.g.
>=20
>     bitfield! {
>         pub struct Foo(u32) {
>             ...
>         }
>     }
>=20
>     #[repr(C)]
>     struct Bar {
>         foo: Foo,
>     }
>=20
>     let mmio: Mmio<'_, Bar> =3D ...;
>     io_read!(mmio, .foo)
>=20
> Currently this feature is available from `register!()` macro but not
> otherwise available with `io_read!`, `io_write!`. Support this by adding a
> `IoRepr` type to denote the underlying I/O type to use for a specific typ=
e.
>=20
> This makes the `IoLoc::IoType` and `Register::Storage` redundant; thus
> remove them; also convert register methods to use the `read_val` and
> `write_val` instead.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D2

