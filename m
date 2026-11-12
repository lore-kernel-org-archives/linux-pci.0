Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446351;
	b=rmQ8tIqnGxfD3r1/DxUFT1yaFRlcrJR+q1cRaokRCmZap2fHxpW4yXv85AUMfDlhPhGX
	 h703oltY/zan9XjMlyk5cb3NAn+NbXsXFWKMenpab8OgRSND7KX79nvyPFqt84dlawohv
	 aF/TYdntFnyfLxBbE7RKCOC5wnB5AwEsGkvz/h7vdouOZuirhmh7Chi7h9ejk4MLpz7+E
	 8sZPUMTYzjGckRzHvyD78P0tFgi/sv3aSnx4i4Lq9Z1ttVSyP6xMck/sgeB8qLkHFuBDU
	 UbMjXDE7op1FmrzdTFBxWWUK2pDLxmL8Je6f3guV+UiH1NfH5GKEH4OZlK6XGPxrjjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446351;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=x/m+FxTK+v2+uvJFFGxvxs5swQOHEOI0Nc4RpLvhMV8=;
	b=cc7/DByvWXRuY9J4RlOBaKyCp14RleaCufyPSF31qLzt7fsl5gea2GvlkWPziJIe6qXb
	 /8e3pMvM7JGZUKPoMd83bEh7bhKZ5y2NllHg2RrIF6pVql7kBCB8WKmiLJSM5rztbDUJc
	 QyE/vdZaxAYrjEBipH5DNvuZ87A8y8WDP+vvS4+U1D/8rruVGNVXQNsVgp425+pVToFtI
	 OLKWWMw9WL4c4uKTRhnshggJROlnJ0Ny0i2rued0CuIWngeqfkc3ZoTffJkDCttVwfc7g
	 /6Nzf0CzUYcSPMeyhnj47p3xzqUqEpnwaKs7JOB2r/Pzv230D3eYARJTz2yycMWCprQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kxv10VZu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8FE606A31C;
	Thu, 12 Nov 2026 01:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kxv10VZu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831371F00A06;
	Thu, 12 Nov 2026 01:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446350;
	bh=x/m+FxTK+v2+uvJFFGxvxs5swQOHEOI0Nc4RpLvhMV8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kxv10VZu1Feq+mqoJACCu/piNBDJ0WliKbqZjWU5GY5P5AhVE/41d3ui/IxJLOxRa
	 BzMyN9n90RTeBhbDN2ahWDKijkCDcXsXbVVCZPyvfHpCCikh/ybV7Vd0p+shBby2Z7
	 oBGKx4+lUaBTNOVAQq3ynOnhhr8uXBienLa9ll/v5lv/tSs7gA+FEc+9bJOXfwMKc0
	 E1M8LIwUxDDBEMr0mYrUplV2gQ9is4fTajV2K63Wt6i6ihloMzszFt18d6XEB9bFMc
	 pobM4RvU+1u610TXmT1FHi4ParHT5shG76HmLq1vX0OLis42k7mOyFZ0ljZTiwnWj/
	 2iGCPT4A+lycw==
Message-ID: <sashiko-outbox-210060@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] rust: i2c: remove the unbind() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261112005455.1224352-6-dakr@kernel.org>
References: <20261112005455.1224352-1-dakr@kernel.org>
 <20261112005455.1224352-6-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:19:10 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] rust: i2c: dropping Driver::Data in post_unbind_rust runs after
  devres release
- [Medium] rust: i2c: missing Sync impl for I2cClient<device::Bound>
--

commit 5a5ad706d767f7788672a5c38d2627a235e83cd2
Author: Danilo Krummrich <dakr@kernel.org>

rust: i2c: remove the unbind() callback

This commit removes i2c::Driver::unbind() and the adapter's remove
callback, documenting that I2C driver teardown should be performed in
Drop or PinnedDrop of Driver::Data.

> diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
> index b4ff25c830fc0..b15e73bf827ab 100644
> --- a/rust/kernel/i2c.rs
> +++ b/rust/kernel/i2c.rs
> @@ -123,7 +123,6 @@ unsafe fn register(
>          unsafe {
>              (*idrv.get()).driver.name =3D name.as_char_ptr();
>              (*idrv.get()).probe =3D Some(Self::probe_callback);
> -            (*idrv.get()).remove =3D Some(Self::remove_callback);
>              (*idrv.get()).shutdown =3D Some(Self::shutdown_callback);
>              (*idrv.get()).id_table =3D i2c_table;
>              (*idrv.get()).driver.of_match_table =3D of_table;
> @@ -161,18 +160,6 @@ extern "C" fn probe_callback(idev: *mut bindings::i2=
c_client) -> kernel::ffi::c_
>          })
>      }
> =20
> -    extern "C" fn remove_callback(idev: *mut bindings::i2c_client) {
> -        // SAFETY: `idev` is a valid pointer to a `struct i2c_client`.
> -        let idev =3D unsafe { &*idev.cast::<I2cClient<device::CoreIntern=
al<'_>>>() };
> -
> -        // SAFETY: `remove_callback` is only ever called after a success=
ful call to
> -        // `probe_callback`, hence it's guaranteed that `I2cClient::set_=
drvdata()` has been called
> -        // and stored a `Pin<KBox<T::Data<'_>>>`.
> -        let data =3D unsafe { idev.as_ref().drvdata_borrow::<T::Data<'_>=
>() };
> -
> -        T::unbind(idev, data);
> -    }
> -
>      extern "C" fn shutdown_callback(idev: *mut bindings::i2c_client) {
>          // SAFETY: `shutdown_callback` is only ever called for a valid `=
idev`
>          let idev =3D unsafe { &*idev.cast::<I2cClient<device::CoreIntern=
al<'_>>>() };

[Severity: High]
Does moving I2C driver teardown from remove_callback() to the Drop or
PinnedDrop destructor of Driver::Data cause driver teardown to run after
the client's devres resources have already been released?

i2c_device_probe() opens an unclosed devres group on client->dev before
calling driver->probe(), so devres entries registered for the client land
in client->devres_group_id.  On unbind, __device_release_driver() calls
device_remove() -> i2c_device_remove() before device_unbind_cleanup() ->
post_unbind_rust():

drivers/i2c/i2c-core-base.c:i2c_device_remove() {
	...
	if (driver->remove) {
		...
		driver->remove(client);
	}

	debugfs_remove_recursive(client->debugfs);

	devres_release_group(&client->dev, client->devres_group_id);
	...
}

Because post_unbind_rust() drops Driver::Data in device_unbind_cleanup()
after i2c_device_remove() has already released client->devres_group_id,
all devres resources on the client are already revoked and dropped before
Driver::Data::drop() runs.  If Driver::Data retains a &'bound reference
from Devres::access() or calls Devres::access() with a retained &'bound
Device<Bound> in its destructor, Devres::access() skips the Revocable
availability check and causes a use-after-free in safe Rust.

> @@ -312,6 +299,10 @@ pub trait Driver {
>      type IdInfo: 'static;
> =20
>      /// The type of the driver's bus device private data.
> +    ///
> +    /// Device teardown should be performed in [`Drop`] or [`PinnedDrop`=
](pin_init::PinnedDrop)
> +    /// for this type. The `'bound` lifetime allows the data to retain d=
evice resources and a
> +    /// [`I2cClient<device::Bound>`] reference for use during teardown.
>      type Data<'bound>: Send + 'bound;

[Severity: Medium]
Can a driver actually store &'bound I2cClient<device::Bound> in
Driver::Data<'bound> as documented here?

Driver::Data<'bound> requires Send, so &'bound I2cClient<device::Bound>
is only Send if I2cClient<device::Bound> implements Sync.  However, Sync
is only implemented for the default context parameter I2cClient
(I2cClient<device::Normal>), not for I2cClient<Ctx> or
I2cClient<device::Bound>, so storing &'bound I2cClient<device::Bound> in
Driver::Data<'bound> fails to compile.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112005455.1224=
352-1-dakr@kernel.org?part=3D5
