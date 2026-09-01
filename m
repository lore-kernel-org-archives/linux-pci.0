Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0184B480DF5
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281784; cv=none; b=EkCiZznM23D8NWbkK8liBoMgR3nbgiqS4FIy9/yN9vuMTpRdNgdaYNkVXrE5yaY1wtqJ17zLcYFIYQN8URcX5RMSiSIiS09kd1TW71bTDbuyHFpUOmBQ+H4tDVPeCcxhXzRdkExlbUftX3O8wb96XM9rPr/6fqvU4u0YKGanZ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281784; c=relaxed/simple;
	bh=1K2gyxZiyo/i8ApqWjkq42A1zXqIjCgjdXH8puAb9ho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fVQ/OQ1D3kZ0yITuZ7FUH0GR0FfqRJ6FOCSb3hqaO4wI3tkUFl/EUn8sX+g7LDEmpv+E+JTENHnVLCMbBVD7P9YapiZ/aFKDZXXts2Yf6QhW8/+y3m+Giw2env5wE72gLQXwMiKFiKpXVpdXty1bdC3opsS02I3CwTWvprDWbVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ci4WEBFz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ci4WEBFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394171F000E9;
	Tue,  1 Sep 2026 16:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788281782;
	bh=fjC24Xc9+ru8TCAv8m05nVLM5835Ya2wrX1VK8SgJPA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ci4WEBFzeKIx3Pr4X/kswDeH4U9H9kWmCgmo+y4rUv+vnnBtom2qLtvCqOSiP4MWW
	 7xN2aEFUxG+oUJ1RxCp7wte4Nh5xniny8xcjLpWckevy2e0EDcKjS1/NVQyOccUb/u
	 YohQk3fyLYO/TaxiUdfAymyWXMw3k6T9+Sf2/Wj/PYJ41AgOqkWq2IF5I/zuuMM1qz
	 4WCFCYp0WW7qnZ8iPrd7BhulofpEGp7BJyyqtPfkutax00soqglvcArd7bALx+8kvk
	 SKg1qbQECYRB6xYYcE0Hn+6TnqlztUiBpunBqOVQoZ8YOL2GwOWLf+pWGm4ojPCPAx
	 GRL5aQOgfm9dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/16] rust: io: perform conversions using `AsRepr`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260901-typed_register-v4-4-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-4-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:56:21 +0000
Message-Id: <20260901165622.394171F000E9@smtp.kernel.org>
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
> otherwise available with `io_read!`, `io_write!`. Support this by
> performing conversions to I/O primitives via the `AsRepr`/`AsReprMut`
> trait.
>=20
> This makes the `IoLoc::IoType` and `Register::Storage` redundant; thus
> remove them; also convert register methods to use the `read_val` and
> `write_val` instead.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D4

