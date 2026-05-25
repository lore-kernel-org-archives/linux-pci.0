Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2509C25392C
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779743666; cv=none; b=KT1NSuSomqaTNcc/idwcFUrUEfnMb3shsj6hQgxfP3FaVM8XEyDy9Pwh2GfIv6aIJi/VUhEjSYFRcmDTEb6Zm5Ud7Bc7v5PAFoigl52WpcdzLuITyWaVTDr0Q60+g6djgoOclyTmTx0fgWM0wA0qHgO/PeNJ92gZcPYcGxN8D8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779743666; c=relaxed/simple;
	bh=3VI1f4nIKxdsLd4Hevc3cIQjzTpgC5ho3PrbtvzECa8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q2jrpzR9wI9rTmeNmfEmmVN55Qx4JaUTMGt77UjGI9ARnWWKWcAYNuFa9cblMx4E/Dyi6SzBZ11Ulxeuan10UQ1pgfu9Yaw/+bUzHv+gm98S0WNmsqyVprAFpHdTUjDh5QKv/xzjBHxm1nSHKURhUMHVBk5J2H2WgXhfavI8N/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmreI4uo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmreI4uo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991271F000E9;
	Mon, 25 May 2026 21:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779743664;
	bh=RdgS6gnlqZdP6JrizF79Rm26Ll/ytYzuc8aVvg51++o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KmreI4uoAJclRKG9xN0M+TZz4Ev3hX+1Mo/3+9wPzlbI+yxRFtRZUNhknvl0d6RrU
	 9wACuehL4f4hf2AGCBeT1qixxFPC7gMQdQB6Y3D+cfIxekGhVPr+Mg13xnT129sb5E
	 oApBeX7cSpSgwp/K3lQl0Up7+wYwGw4zqZcrLimZY46cvYHDMviStrq4hOwm8Cpqv6
	 M9x+TbvHkK15Cmdm/Lw0CGprP30yjelbioxcCqhpuyAsiiLH2PrLmtGqLYPhxenWBZ
	 mZGMiA/wn6julTagcdjB6wcfUNez0HDWyBp/ytosWLnUNfjxhRCVS5wXlmsRUwhXUX
	 5zZXrhjBFy5nQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/24] rust: usb: make Driver trait
 lifetime-parameterized
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260525202921.124698-16-dakr@kernel.org>
References: <20260525202921.124698-16-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 21:14:24 +0000
Message-Id: <20260525211424.991271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Lifetime transmute in `drvdata_borrow` and `drvdata_obtain` violat=
es `ForeignOwnable` safety invariants.
--

commit 7eabedf806aa3828a851211d08e32adafe52e9bb
Author: Danilo Krummrich <dakr@kernel.org>

rust: usb: make Driver trait lifetime-parameterized

This commit adds a 'bound lifetime to the associated Data type in the USB
Driver trait. This allows driver data to capture the device bound lifetime
and store device resources directly by reference without requiring Devres.

> diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
> index 1dbb8387b4636..7aff0c82d0afc 100644
> --- a/rust/kernel/usb.rs
> +++ b/rust/kernel/usb.rs

[ ... ]

> @@ -109,8 +109,8 @@ extern "C" fn disconnect_callback(intf: *mut bindings=
::usb_interface) {
> =20
>          // SAFETY: disconnect_callback is only ever called after a succe=
ssful call to
>          // probe_callback, hence it's guaranteed that Device::set_drvdat=
a() has been called
> -        // and stored a Pin<KBox<T::Data>>.
> -        let data =3D unsafe { dev.drvdata_borrow::<T::Data>() };
> +        // and stored a Pin<KBox<T::Data<'_>>>.
> +        let data =3D unsafe { dev.drvdata_borrow::<T::Data<'_>>() };

[Severity: High]
Does this lifetime transmute in drvdata_borrow violate the ForeignOwnable
safety invariants?

The safety documentation for drvdata_borrow and drvdata_obtain requires
that the type T must match the exact type of the ForeignOwnable previously
stored. Because the probe callback stores the data with its local lifetime
and the disconnect callback retrieves it with a different local lifetime,
T::Data<'probe> and T::Data<'_> represent distinct types in Rust. Passing
a different type to these unsafe functions violates their documented
preconditions.

Additionally, since the Data<'bound> associated type does not guarantee
covariance, could a driver implement an invariant type (for example, using
Cell<&'bound Device>)?

While an immediate use-after-free might be hard to trigger because the C
pointer remains valid, bypassing the borrow checker and casting lifetimes
via raw pointers without covariance bounds appears to be structurally unsou=
nd.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525202921.1246=
98-1-dakr@kernel.org?part=3D15
