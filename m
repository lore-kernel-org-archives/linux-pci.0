Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B20716A395
	for <linux-pci@vger.kernel.org>; Sat, 30 May 2026 23:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780185088; cv=none; b=nYiWKKG7cGrpboLVF3SfE8+D9ZgUUBAiq6Vu1gI1fzUzT5k78dOik5l5TUkzY7wrOE8i6Ae0oFImACkj1OGl4taBSTUw61uDmSTbuytoO/jlqbdSNd4F4bV9pGLoD+SccnGPTXmMNBD9C6xOxhQm6ouST+f3YgsW7KYxBq69dmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780185088; c=relaxed/simple;
	bh=on3A6yOOUkh2qwleViBd4ntf9mTBdiv6phEjhWAvnFw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ADNNl0AC1oRJzERB9HvJGk4H8ilzwQgmkfCKcj+mr2DOMVVFWkkAz1WZ7E50ROEE2T5cwlpq6pyCjZKiuMsblecoNOpPOjlJaI9I5pz6TTme+U+46mHVy1a09xEeE2dvJe2+kg4Rhk0O2NTpPxqN8Hjw+fdHz4bhq5nU+sVY3aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=UUGAiu6l; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="UUGAiu6l"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 383E9240101
	for <linux-pci@vger.kernel.org>; Sun, 31 May 2026 01:51:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1780185085; bh=hrSTrVXaIpaL00zdLlTVRkky6t8GukL15LtQSVysnfw=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=UUGAiu6l1CQrXssfF6mzMczReYl6uhWb5/mFGftdQQUa74UkR/2zQ5jXfUKTNlwxi
	 CM1h02TvUjzOSKX7qD4UPmsm8xcmBAEUR4MMWV86Li0JPHysaQB+dJNud1DXHZqI0a
	 NyeQ/D39TVTlSqULWf4KtpPfVWmN7YIB8s/OGCerfESKW56jrXXrItuwKW5yXKG96j
	 3QqzhpW7kK4VHkgatJH0okLsgPSqAU0f8ciKOGkTriaNvIe9HWDpqmQMbh8iPA6aU1
	 b8hZStEY7X6iEvBQfx9KPWoOQnKCAl1NqiP+rOnGX2BBspdH8aZXbRWT8YulOqQEiY
	 I+HqBVkM6rs+w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gScSX5NgWz9rxB;
	Sun, 31 May 2026 01:51:24 +0200 (CEST)
Message-ID: <b5aa72ec227e4bb32f19242993a14aa8303d46bf.camel@posteo.de>
Subject: Re: [PATCH v18 2/3] rust: leds: add Mode trait
From: Markus Probst <markus.probst@posteo.de>
To: sashiko-reviews@lists.linux.dev
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
Date: Sat, 30 May 2026 23:51:25 +0000
In-Reply-To: <20260530231708.98DBE1F00893@smtp.kernel.org>
References: <20260531-rust_leds-v18-2-d07102ba5170@posteo.de>
	 <20260530231708.98DBE1F00893@smtp.kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-ie334kY1rf8E5q7LT2A6"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-ie334kY1rf8E5q7LT2A6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-05-30 at 23:17 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Flawed fwnode reference count management in `led::Device` leads =
to refcount underflow or memory leaks.
> - [High] Inverted lifetime bound `'bound: 'a` in `DeviceBuilder::build` a=
llows the `Device` to outlive its name string, causing a Use-After-Free.
> --
>=20
> commit 79f921a7fb31b3f89538463530e40a222e664817
> Author: Markus Probst <markus.probst@posteo.de>
>=20
> rust: leds: add Mode trait
>    =20
> Add the led::Mode trait to allow for other types of led class devices
> in led::LedOps.
>=20
> > diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
> > index 09244133f14c8..2ffe65bb9dc2c 100644
> > --- a/rust/kernel/led/normal.rs
> > +++ b/rust/kernel/led/normal.rs
>=20
> [ ... ]
>=20
> > @@ -20,7 +28,7 @@ pub struct Device<'bound, T: LedOps + 'bound> {
> > =20
> >  impl<'a, S: DeviceBuilderState> DeviceBuilder<'a, S> {
> >      /// Registers a new [`Device`].
> > -    pub fn build<'bound: 'a, T: LedOps + 'bound>(
> > +    pub fn build<'bound: 'a, T: LedOps<Mode =3D Normal> + 'bound>(
>=20
> [Severity: High]
> Does this inverted lifetime bound ('bound: 'a) allow the device to outliv=
e its
> name string?
>=20
> It appears that a caller can safely initialize a long-lived device (e.g.
> 'static) using a short-lived local string, because the returned PinInit d=
oes
> not capture 'a.
>=20
> Since the short-lived name pointer is assigned to the persistent C struct=
:
>=20
>     name: self.name.map_or(core::ptr::null(), CStrExt::as_char_ptr),
>=20
> Does dropping the local string leave a dangling pointer in the C struct,
> causing a use-after-free when the LED subsystem accesses led_cdev->name?
>=20
> [Severity: High]
> Can the fwnode reference count management here lead to underflows or memo=
ry
> leaks?
>=20
> In DeviceBuilder::build(), if self.fwnode is Some, its ARef is leaked:
>=20
>     core::mem::forget(self.fwnode); // keep the reference count increment=
ed
>=20
> But if it was None, no reference is leaked.
>=20
> >          self,
> >          parent: &'bound T::Bus,
> >          ops: impl PinInit<T, Error> + 'a,
>=20
> [ ... ]
>=20
> > @@ -209,7 +217,7 @@ impl<T: LedOps> Adapter<T> {
> >  }
> > =20
> >  #[pinned_drop]
> > -impl<'bound, T: LedOps + 'bound> PinnedDrop for Device<'bound, T> {
> > +impl<'bound, T: LedOps<Mode =3D Normal> + 'bound> PinnedDrop for Devic=
e<'bound, T> {
>=20
> [Severity: High]
> When <Device as PinnedDrop>::drop attempts to recover the fwnode referenc=
e from
> the mutable C field dev->fwnode:
>=20
>     let _fwnode =3D dev
>         .fwnode()
>         .map(|fwnode| unsafe { ARef::from_raw(NonNull::from(fwnode)) });
>=20
> If self.fwnode was None, but the C core populates dev->fwnode (e.g. devic=
e_add
> sets it to parent->fwnode), will PinnedDrop steal and drop a reference it=
 does
> not own, causing a refcount underflow?
>=20
> Conversely, if self.fwnode was Some, but dev->fwnode is later cleared or
> overwritten by C code, will the ARef never be dropped, causing a memory l=
eak?
The fwnode shouldn't change, but we could make this safer via devres.
>=20
> >      fn drop(self: Pin<&mut Self>) {
> >          let raw =3D self.classdev.get();
> >          // SAFETY: The existence of self guarantees that self.classdev=
.get() is a pointer to a

--=-ie334kY1rf8E5q7LT2A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmobd/wbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSZFsQAJG6tIstKxRnrkdhhHAU
29IsLAwTAqFQSR0N6jzbAJWsYAbE0sKzhFVZuhOwpX+CuSdyc0aYh1Y9xOuAoGxv
j6iziIHnTfe689Me4LUK+T7sws87nODkEG/Z6KOFr0t+t9oX5ZwlygDrpSM9Asbu
jI2yqC81lh6gS6+oRhEpVhMzi+V5zVImSoWc/3rNWNlwidLPSPrIXCeYgZ70THre
zlhKsCGBdd44ZFZFvsB2lyz2t8xA/hL0XshO0hCYeycFxd+a1rfREd5VkapCNTsU
YLFTt/88P3+knm87yn+VOt1Sm1X0kWPEa/cu0/twIUqqrjPNYb9on2hQtpecVmb2
u80oVKptw7B99vG5V3f4zmNi4ntM6lEZWYYxDrOQjVAPH/fpUXBvkJU5/JcgiPv7
CpTihK/dAi7tytbWbyVLC+67S7D+0YnwcRztb7LQkTfedgdxD5QAP0muV436aTrI
1ltjF72NjvRgL4aJZsDvkYzkKlPoEOZHOBNnkaKHm75SutR3LHpALahxmH3KltI2
BLSX9lL+rzasC9/3yKmSm/lnlkJesRd9ua01RRjZZ9mFlKFR9yw0kgTuxn4J1fPZ
DSUkhI4zAiimASnbsh+Nsmw625AXr2OYECGdBObaFpCcKCSfKbHB3k33mkpkMhj6
pm2g64Tavoj0je7u2KR0/nws
=//X8
-----END PGP SIGNATURE-----

--=-ie334kY1rf8E5q7LT2A6--
