Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58BF27A477
	for <linux-pci@vger.kernel.org>; Sat, 30 May 2026 23:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780184890; cv=none; b=oOfiR0PFdMr5zlP+kKMRyHD1sY48HKd+zirSiTnxiY3a43ILQhnE58M6PS0bEPVHy8fJSk93/bPd+OwTW9BSkaeYZ1sCd68O9PLCjKee59MjpMDcpfGmxenC0srAyoctk0tC1sQ+tdYcYpm92ORSr3PR6Pk3USBlCafe98i8N44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780184890; c=relaxed/simple;
	bh=9eh1Wi6tET5mOKPtyR+QJWwyYNYnNinvP3kUOz9teC4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ldMl1aLJYmPnHv4bxMGuilx9uZ6RPQHoy699kJhI1dOXIsR2DF+I0vHgqCZk7lmeV1N9Dm4MnCCMqor5Liuscz8H1rN8gdzrfUHKlqSslePtfGtdz9C7e/C8uHIQLuKTOdZrOqhufRcPaqEk2l6E9mo8++4qPYcRyO72XlGpNS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=DRpO+8sf; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="DRpO+8sf"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id DD5F0240103
	for <linux-pci@vger.kernel.org>; Sun, 31 May 2026 01:48:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1780184886; bh=h00BNJxHu9UnNH3x39/yY6xRF86uqXNPm9vyGTwudkE=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=DRpO+8sfpjGTGSKs3B+KsPFpi/e7UCzV1WVk27WUR3PWwSb8/8aelfL0Sb0VTO+Z2
	 D1wyocikPDCMN+UTaI3xI4Fa+PUEaVnPHsNOmly9s44+MZ4/X7L4MEc3jNVt7j/CP9
	 5mTDYpdHGKvmbBOCqhCahlwaLeMra3hta4ENjJ8YeN0qSZGvAhWb3lQTzRqBxVUzyy
	 SxaeER/ntCQ6CIyw0Bho3x7PHJtjqaPpd1iQnYRjYbN22LRu+g+keYCPMgpEbho1BN
	 blTPdW4of3ZmKj4lKFMt+hoe8Q1UxajmCAitmMv857pJP5pZ/ho2RfwL0JIdKx8hGi
	 CWI/OOXIBnIYA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gScNk2tcRz6twg;
	Sun, 31 May 2026 01:48:06 +0200 (CEST)
Message-ID: <efb819ae72e3298aa6a14fc7f880631a837be455.camel@posteo.de>
Subject: Re: [PATCH v18 1/3] rust: leds: add basic led classdev abstractions
From: Markus Probst <markus.probst@posteo.de>
To: sashiko-reviews@lists.linux.dev
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
Date: Sat, 30 May 2026 23:48:06 +0000
In-Reply-To: <20260530230537.893561F00893@smtp.kernel.org>
References: <20260531-rust_leds-v18-1-d07102ba5170@posteo.de>
	 <20260530230537.893561F00893@smtp.kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-/1HCwH1hJfyq2QwBCz58"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-/1HCwH1hJfyq2QwBCz58
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-05-30 at 23:05 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] The `Device` abstraction drops the `'a` lifetime of the `name` r=
eference, leading to a potential use-after-free of the LED name.
> --
>=20
> commit bc77118736b867c88c1854d7a5c4eb57818535fd
> Author: Markus Probst <markus.probst@posteo.de>
>=20
> rust: leds: add basic led classdev abstractions
>=20
> Implement the core abstractions needed for led class devices, including
> LedOps, DeviceBuilder, and Device.
>=20
> > diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
> > new file mode 100644
> > index 0000000000000..09244133f14c8
> > --- /dev/null
> > +++ b/rust/kernel/led/normal.rs
>=20
> [ ... ]
>=20
> > +impl<'a, S: DeviceBuilderState> DeviceBuilder<'a, S> {
> > +    /// Registers a new [`Device`].
> > +    pub fn build<'bound: 'a, T: LedOps + 'bound>(
> > +        self,
> > +        parent: &'bound T::Bus,
> > +        ops: impl PinInit<T, Error> + 'a,
> > +    ) -> impl PinInit<Device<'bound, T>, Error> + 'a {
> > +        const_assert!(T::MAX_BRIGHTNESS <=3D i32::MAX.unsigned_abs() |=
| !T::HAS_BRIGHTNESS_GET);
> > +
> > +        try_pin_init!(Device {
> > +            ops <- ops,
> > +            classdev <- Opaque::try_ffi_init(|ptr: *mut bindings::led_=
classdev| {
> > +                // SAFETY: `try_ffi_init` guarantees that `ptr` is val=
id for write.
> > +                // `led_classdev` gets fully initialized in-place by
> > +                // `led_classdev_register_ext` including `mutex` and `=
list_head`.
> > +                unsafe {
> > +                    ptr.write(bindings::led_classdev {
> > +                        brightness_set: (!T::BLOCKING)
> > +                            .then_some(Adapter::<T>::brightness_set_ca=
llback),
> > +                        brightness_set_blocking: T::BLOCKING
> > +                            .then_some(Adapter::<T>::brightness_set_bl=
ocking_callback),
> > +                        brightness_get: T::HAS_BRIGHTNESS_GET
> > +                            .then_some(Adapter::<T>::brightness_get_ca=
llback),
> > +                        blink_set: T::HAS_BLINK_SET.then_some(Adapter:=
:<T>::blink_set_callback),
> > +                        max_brightness: T::MAX_BRIGHTNESS,
> > +                        brightness: self.initial_brightness,
> > +                        color: self.color as u32,
> > +                        name: self.name.map_or(core::ptr::null(), CStr=
Ext::as_char_ptr),
>=20
> [Severity: High]
> Does this erase the lifetime of the name string and risk a use-after-free=
?
>=20
> In DeviceBuilder::build, the builder takes a string reference tied to the=
 'a
> lifetime, but the returned Device struct does not capture this lifetime. =
The
> raw pointer from the name is then written directly into the long-lived
> led_classdev struct.
>=20
> If the name string is dropped immediately after the Device is initialized
> (for example, if a dynamically allocated CString was used in the driver p=
robe
> function), the led_classdev struct registered with the C subsystem will
> contain a dangling pointer.
>=20
> Could this lead to memory corruption if C code inspects the global leds_l=
ist
> and dereferences the dangling name pointer?
false positive. The string gets copied in registration and doesn't have
to outlive the device.

>=20
> > +                        ..bindings::led_classdev::default()
> > +                    })
> > +                };
>=20
> [ ... ]

--=-/1HCwH1hJfyq2QwBCz58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmobdzUbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPS9bwQAKCqSNPN7T8dSI/Hal0h
bQM2DbTVIghNaopbOdYcA2JdouCAFKKSLsUDF2GNzxjgHvMa/v3JGSylQrQWgTdz
5jAOMzzv7cMyvqmQcPmXGlR8LmE1bpLJRsG2Fr2NJAEaa3i9Yt6tHP1vWfyiWuuP
bUDwF0Qv5ox1j8c2lDy2htuXq0LqXZAGNKMAzvQGeVvftOpQHO3bE5tud2MjnbNG
Vny/0nl0RBkd2URTvPmvU0x4NfreS8Lra950cmq63bsl5295K8l6OpKQdI0z/YwB
Zcms3m8m7yZtPsPO07+RO0roU3CNQQaLrGLBfuwtIJHpyW8JwULR3fod44FiPSJC
ZnFDtoeKeXy9D1rrN6MgrhpREBum3EwtdXH8f+Gnz4rVbUNJoKyp64S6owREs9zP
fYQEg41mY1Qmz6ZhI2nOwK501+UhH6mjBG8GiiKy27GoxCL3hazUrKb4bac255IG
ZvEeWBXGKSyVUqor2Wn7beGGutiyx6qMQ1FbSaadSSGcHNRE0XYMgHmKhtFReVfa
ia3xj/mXIbC8yr/Fh5TFAHU46haoxGRk9yEgaHeMi9oX7AhjXeC8Y8Eg0zFbkxpB
tf7SQqyfcWdzIui0gvFu0sAU5wgxSJy88KJrWDgLRgJdvMapcarWfqqW65ww/VsD
Hr+yMXAPnWKBguTqfGqjQ5Tv
=vxti
-----END PGP SIGNATURE-----

--=-/1HCwH1hJfyq2QwBCz58--
