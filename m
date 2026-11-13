Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604477;
	b=RtR56yhF8NC/SeOf3AM2y2pCwk/lUWJAIn2nKUnvC2cR9lsH7foQJyMF6U4Yc+WsJnL3
	 cnWBHeCZ4pc5Wp/AzEVXIKUdswB/ualVaykugLWlPvhLv1NpFL1bXf8z10dZ7/7al/tsx
	 BGuclbz1n0tFLDjgWeGblCaavJCIAZMSvOWpoLOPsG6VhpupixD64PVpyh93RtQhA44DH
	 Gj0rbGowU3eAcCMnRNWcyKUNkGjYpX4SuEdsUTnIWe65JHqDvgxRmiDc1/yipEBw7C4c6
	 fC753q70T52f4WBMdjMrNtKG6nuRczh4Pq8pz/6s252FoFHy0GcD3fLqktlPQEaBP0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604477;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP;
	bh=bi+qbuXC7Kr0qdcc2OWqT62yrf9jqwzAVB3DjteEz/8=;
	b=BMUmK49C3j7nHIKcPd3FHVm0+bxezQnyrY7zFC3xT4qeSowrDmVWzFPp/ePqxy/pGj/h
	 zVAC84Nmk9eXPpXHnjeSQu5wvGhziGTfQ1L6vqbbOG7WDfJ+FyJTiB/Nx+tqGR0i4yb68
	 ZunxKLrnSfzyepM4p5r2fdCySwUrKk5VyeNplSctKswdbiOYSLL3fNWPC25xbRNpVA9GN
	 02ACW0zscShQHRe5urZSNra3wLj23ac9fR3oUOabCcfkMN8owX5hsX9DE4iMznc+8+Oh2
	 VY3z7Ww30TUeDtC0EUTJYvlD9wnjkJfgliAPbNZIWD3yTP+IBhnxs+9ZONOzZoqowCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b="V9uk/ydU";
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3527606A337
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 21:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3527606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=V9uk/ydU
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 027D2240109
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 22:14:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1794604467;
	bh=bi+qbuXC7Kr0qdcc2OWqT62yrf9jqwzAVB3DjteEz/8=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=V9uk/ydUGiRpCAmNs9UBqXwaoPGGUPZCYdDLs5zjvX+t2vAuT7Tt1gjbtPZaIcyeP
	 pBgqkhq2iG05NsEgEeMKQOmkRzKY+baSwBRIdVxaJqmSXdB5R75zGSsIY9MvAwbzm6
	 xtJrDjx83GXP2/yfwHabVZ1zRWa31VYRk2c5DSMG13s4l9nSeIS9X97qQp/KFMdYRc
	 DL1I4cqY9ZQbEZWwf5A8zYIXaAYZUHhb+BCLW27uVXz/hqtM2rv6/OofsSqiLgy8zF
	 qYHU0ygro2O8GED7Xfzf4evF/YLdGeR12tDRw3MGabSJTk1DLWZUwr2W0FGJK3b2EB
	 903mN7tKldShQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jR94H1xfCz9rxD;
	Fri, 13 Nov 2026 22:14:23 +0100 (CET)
Message-ID: <3e4aafb4c2dab636e9f113199d4cb95e0af9c6bb.camel@posteo.de>
Subject: Re: [PATCH 4/7] rust: serdev: remove the unbind() callback
From: Markus Probst <markus.probst@posteo.de>
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, 
	rafael@kernel.org, johan@kernel.org, david.m.ertman@intel.com,
 iweiny@kernel.org, 	leon@kernel.org, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, 	bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, 	aliceryhl@google.com, tmgross@umich.edu,
 daniel.almeida@collabora.com, 	tamird@kernel.org, acourbot@nvidia.com,
 work@onurozkan.dev, igor.korotin@linux.dev, 	bhelgaas@google.com,
 kwilczynski@kernel.org
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Date: Fri, 13 Nov 2026 21:14:25 +0000
In-Reply-To: <20261112005455.1224352-5-dakr@kernel.org>
References: <20261112005455.1224352-1-dakr@kernel.org>
	 <20261112005455.1224352-5-dakr@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-EDAa2rzL4vfrR9iRkevA"
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-EDAa2rzL4vfrR9iRkevA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-11-12 at 01:52 +0100, Danilo Krummrich wrote:
> The driver model uses native Rust lifetimes to let driver data retain
> device resources and a Device<Bound> reference for the duration of the
> binding. Both remain accessible from the destructor, so a separate
> unbind() callback is no longer needed.
>=20
> Remove serdev::Driver::unbind() and the adapter's remove callback and
> document that device teardown belongs in Drop or PinnedDrop.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/serdev.rs | 41 ++++-------------------------------------
>  1 file changed, 4 insertions(+), 37 deletions(-)
>=20
> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index 17ca504b7f8d..fd998b68b74f 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs
> @@ -81,7 +81,6 @@ unsafe fn register(
>          unsafe {
>              (*sdrv.get()).driver.name =3D name.as_char_ptr();
>              (*sdrv.get()).probe =3D Some(Self::probe_callback);
> -            (*sdrv.get()).remove =3D Some(Self::remove_callback);
>              (*sdrv.get()).driver.of_match_table =3D of_table;
>              (*sdrv.get()).driver.acpi_match_table =3D acpi_table;
>          }
> @@ -210,29 +209,6 @@ extern "C" fn probe_callback(sdev: *mut bindings::se=
rdev_device) -> kernel::ffi:
>          })
>      }
> =20
> -    extern "C" fn remove_callback(sdev: *mut bindings::serdev_device) {
> -        // SAFETY: The serial device bus only ever calls the remove call=
back with a valid pointer
> -        // to a `struct serdev_device`.
> -        //
> -        // INVARIANT: `sdev` is valid for the duration of `remove_callba=
ck()`.
> -        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInternal<=
'_>>>() };
> -
> -        // SAFETY: `remove_callback` is only ever called after a success=
ful call to
> -        // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
> -        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
> -        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<Pri=
vateData<'_, T>>() };
> -
> -        // SAFETY: No one has exclusive access to `private_data.driver`.
> -        let data =3D unsafe { &*private_data.driver.get() };
> -        // SAFETY:
> -        // - `private_data.driver` is pinned.
> -        // - `remove_callback` is only ever called after a successful ca=
ll to `probe_callback`,
> -        //   hence it's guaranteed that `private_data.driver` was initia=
lized.
> -        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_init=
_ref()) };
> -
> -        T::unbind(sdev, data_pinned);
> -    }
> -
>      extern "C" fn receive_buf_callback(
>          sdev: *mut bindings::serdev_device,
>          buf: *const u8,
> @@ -365,6 +341,10 @@ pub trait Driver {
>      type IdInfo: 'static;
> =20
>      /// The type of the driver's bus device private data.
> +    ///
> +    /// Device teardown should be performed in [`Drop`] or [`PinnedDrop`=
](pin_init::PinnedDrop)
> +    /// for this type. The `'bound` lifetime allows the data to retain d=
evice resources and a
> +    /// [`Device<device::Bound>`] reference for use during teardown.
>      type Data<'bound>: Send + Sync + 'bound;
> =20
>      /// The table of OF device ids supported by the driver.
> @@ -382,19 +362,6 @@ fn probe<'bound>(
>          id_info: Option<&'bound Self::IdInfo>,
>      ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
> =20
> -    /// Serial device bus device driver unbind.
> -    ///
> -    /// Called when a [`Device`] is unbound from its bound [`Driver`]. I=
mplementing this callback
> -    /// is optional.
> -    ///
> -    /// This callback serves as a place for drivers to perform teardown =
operations that require a
> -    /// `&Device<Core>` or `&Device<Bound>` reference. For instance.
> -    ///
> -    /// Otherwise, release operations for driver resources should be per=
formed in `Drop`.
> -    fn unbind<'bound>(sdev: &'bound Device<device::Core<'_>>, this: Pin<=
&Self::Data<'bound>>) {
> -        let _ =3D (sdev, this);
> -    }
> -
>      /// Serial device bus device data receive callback.
>      ///
>      /// Called when data got received from device.

Reviewed-by: Markus Probst <markus.probst@posteo.de>

Thanks
- Markus Probst


--=-EDAa2rzL4vfrR9iRkevA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmr3fakbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPS9NAQAJz35dn34vwO1cHY+moo
kIjIgv5XKwFm73AdFdW7aqUO9XCW9TQqd4JCG8Sg8++Jq6vkXd+GnrO4jHcuhoAU
n6+/uv0aG5iH2FF2UbfA7BA0VY5ZTL1wI5WFrpXpsJGPoe2E4NCeNvhkF3PvkDqy
CSKx5R3xkGoA2v/HB1nEcmkh1s9/qa3gTS6f+vaE/M5XXogmYcX424ktnA42jUdR
joohrncC/wHKQhShQWNjOhYJh8oPHPZLKJhXq3rtiT1GNNmiijrnK/RhJZbCWwBT
tVTIkVfmaZxdQ8weTr0FB8OhOyao0NMmrNZvAhv4xuTGx1KHCb267y/35iR7Mg6i
Fjy9YWiOEboK+fBTIAOtGuAm2XrLtT54KV1u+0R8CoMwsUgcBjZ7F+1hPBiEpkME
PJhRPSXwYA913kusT3+m8HWlbuObBNyD8kOTyVD44bxYB3C5y6yOxfp+P+J/Ax5x
qWLXbLRuOGOTzgj6cyluHPbjcsoDewsAFUkvBbk5huHHTGom8LjhAEiHqnajmm4k
m7ItRvbrxPl+sy6/JTXu/45vZh2xblT7AC8rGvRNZHoErdeY56KVEEio9td08FJE
qPlLHfuuo/Jy52qpiIlM7ue5VkA/tkGZri/I0krHiTkvRMfTgIoP8ZMt8JOkPqdE
Zxou2D0rXcA8KBONQi+Nwbxv
=mwoh
-----END PGP SIGNATURE-----

--=-EDAa2rzL4vfrR9iRkevA--
