Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33E1194AE6
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 00:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778978373; cv=none; b=jKEr7jHEkkjyClOTdsUvAk+sErZmKboAka64mwDh9PiKd1Ogxh/DJq3QaxEuQNer6FZwISMpr3kXi8pNBrfuA9UpIStM5c75z7lsBbp0VaLskobmVxPQLSjhHATEAayN6gQzQH/4yXQWDVsLzbG/KN92MvYqS8M0OcqwfF7yl3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778978373; c=relaxed/simple;
	bh=jdMPKJnDx4XtKgJ52GOXu0IRlshi3D1cyvcb42J1j7g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=If0nTk/vSWxtPIcFdYMKfm0XHl1uAwJ1tY4zUMwqM85UGj0Vb/BDsa7+9W/Yo2xkXWWFvDmxs0ZlMhWCM/o9tN2gMYfj/6hAopFIlt+RiC/6LBEayR2/XRpqHr4+JE41BX1fxbFCCtkTMMAs1n4i0g6SZS+9fjBsQkR/OJw82lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SA3j5WG2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SA3j5WG2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DDBC19425;
	Sun, 17 May 2026 00:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778978372;
	bh=jdMPKJnDx4XtKgJ52GOXu0IRlshi3D1cyvcb42J1j7g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SA3j5WG2E9b/52E3bjjkMqtVwc1AmukmeLx5FN9PkotO22gUqhDzfrEw8lAx18t6N
	 tIyhzXnY7xF4ytPXtHLxs3OhISlaUei52rW0wXsS7DhQ+ErRPFeTcVI42MXVS0890j
	 ch1JAHOW69KE/XxB3xjvEkBe8G4TYUw6a1Fap4Tki7vIiER1iyRp5AZbKMMI4tP0mh
	 9v6AgMY+wua76ZKroyiVg7Rh6LoChXbLpumqGxyET+3wDbs42O0fCdd+eLcxjmQmsv
	 j9fidcw8kOf5t4PD2PgRMx8HUGcCSPmZ4NKEFwujvWE2lKBxQMaa8rIdWgDuKyPnhD
	 luLc7WjvIBYTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/27] rust: i2c: make Driver trait
 lifetime-parameterized
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260517000149.3226762-15-dakr@kernel.org>
References: <20260517000149.3226762-15-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 00:39:31 +0000
Message-Id: <20260517003932.68DDBC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Use-After-Free due to I2C devres and subsystem teardown runnin=
g before driver Data Drop.
- [High] Soundness hole allowing safe code to trigger UB via unchecked life=
time variance in GAT.
- [Low] Documentation mismatch in SAFETY comment for `drvdata_borrow`.
--

commit acb687d5f7c058a48caf341d55413d5a1b7e20ee
Author: Danilo Krummrich <dakr@kernel.org>

rust: i2c: make Driver trait lifetime-parameterized

This commit adds a 'bound lifetime parameter to the associated Data type
in the Driver trait. This allows driver implementations to capture the
device bound lifetime, enabling the storage of device resources by reference
rather than requiring Devres.

> diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
> index 5a4014f379d5b..7b92d42a2b98c 100644
> --- a/rust/kernel/i2c.rs
> +++ b/rust/kernel/i2c.rs
[ ... ]
> @@ -177,7 +177,7 @@ extern "C" fn remove_callback(idev: *mut bindings::i2=
c_client) {
>          // SAFETY: `remove_callback` is only ever called after a success=
ful call to
>          // `probe_callback`, hence it's guaranteed that `I2cClient::set_=
drvdata()` has been called
>          // and stored a `Pin<KBox<T::Data>>`.

This isn't a bug, but the SAFETY comment still says Pin<KBox<T::Data>>
instead of T::Data<'_>.

> -        let data =3D unsafe { idev.as_ref().drvdata_borrow::<T::Data>() =
};
> +        let data =3D unsafe { idev.as_ref().drvdata_borrow::<T::Data<'_>=
>() };

Does retrieving the data via drvdata_borrow::<T::Data<'_>>() bypass
lifetime checking and introduce a soundness regression?

Because the Driver::Data associated type is not constrained to be
covariant, a driver could define an invariant Data type (for example,
containing a Cell<Option<&'bound I2cClient>>).

During unbind(), the driver could write a short-lived reference into the
Data struct. When remove_callback returns, this reference expires,
leaving a dangling pointer.

If that pointer is accessed in Drop, could it violate Rust's aliasing
rules and trigger undefined behavior?

[ ... ]
> @@ -189,7 +189,7 @@ extern "C" fn shutdown_callback(idev: *mut bindings::=
i2c_client) {
>          // SAFETY: `shutdown_callback` is only ever called after a succe=
ssful call to
>          // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
>          // and stored a `Pin<KBox<T::Data>>`.

This isn't a bug, but the SAFETY comment here also refers to
Pin<KBox<T::Data>> instead of reflecting the new 'bound lifetime.

> -        let data =3D unsafe { idev.as_ref().drvdata_borrow::<T::Data>() =
};
> +        let data =3D unsafe { idev.as_ref().drvdata_borrow::<T::Data<'_>=
>() };
[ ... ]
> @@ -320,7 +323,7 @@ pub trait Driver: Send {
>      type IdInfo: 'static;
> =20
>      /// The type of the driver's bus device private data.
> -    type Data;
> +    type Data<'bound>: 'bound;

If a driver uses the 'bound lifetime to hold references to devres-managed
resources or I2C subsystem resources (like debugfs entries), will this lead
to a use-after-free regression?

In the I2C subsystem, i2c_device_remove() explicitly calls
devres_release_group() and cleans up subsystem state after the driver's
remove callback completes. The driver's Data is dropped later when the
driver core calls post_unbind_rust via device_unbind_cleanup().

By the time Drop is called on Data, wouldn't all devres resources already
be freed, causing a use-after-free if they are accessed during Drop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517000149.3226=
762-1-dakr@kernel.org?part=3D14
