Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F10C4F68BC
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791575948; cv=none; b=tXFxzFmZA7EcWabxhdbGcWSiV9au8k/CRdHIIt42ZfDw3AKSPpBYARXlV/3XpQTSe3sMq3cM+8eoa87IcYAIHnaWBV8yCszRbunX1kto88hYyykdYn/kPJ0f86vxxafUbIibDaAmK0bNk+mcvm0OBWwyKn9t9QrqdmKkoD9ev2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791575948; c=relaxed/simple;
	bh=D8XXtcbxrjhlWGiM5pugWs4SSbJhBiobkt6W11mNugI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aet3iCb3FEjAALEnBV0O6mi/5fzXuHnKygZLiZD/5QtlqmWSHfpUvmqBBCDt3J5xkAWkFVQJUxUb1pmqklbZe+r9TD5B8Ekmg2oqImD0X3S+CwfzhTXWPBCjHZtnEl4IZxF0FcWaV28GxJGdJQHk9Wag1k7VRJUIUGleIDK5d14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=T0UfY/y2; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="T0UfY/y2"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4A8A5240105
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 21:59:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1791575943;
	bh=lycUKGdrKj6RfAC1KxRMzURr/IWi8y/EZPEBqvJtbXI=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=T0UfY/y2BQwUEhCZ7FkSa3k3XySHThkNe5mruj6hbRkfOalrnVYYuEavb3pFEMPSk
	 szhPk9yGgzcM0+BXDSO+HR6bN8oS1PFGbqwp4cgQlmyha/MU3C/VU8SniYhZvFWXB+
	 3o3rDOYv7vpFKEVYN1CBZBsOBn8vu5SNqJYbB0EJVhoWImELergaUvlYmSZGwDj2LL
	 tpJNDdhZ3f/TnIUZjZCk5dyTZ2fgKFNKFDjtf+O4KN25tRYiOyCCtfpWthB94+fqyN
	 fEu7gaRd0S2nXaOg9pTuwfuE6/I0enjcxbCjLKOMhJ/2exDqAWcB9GnOXoyxsmthY+
	 /82BZKoYhMH8A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j1d3R3XFsz6v0X;
	Fri,  9 Oct 2026 21:58:59 +0200 (CEST)
Message-ID: <7174e1f95dcbeb8802d9e9c9715afa32784f0c20.camel@posteo.de>
Subject: Re: [PATCH v26 3/4] rust: leds: Add multicolor classdev abstractions
From: Markus Probst <markus.probst@posteo.de>
To: Boqun Feng <boqun@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman
 <david.m.ertman@intel.com>, Leon Romanovsky	 <leon@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor	 <alex.gaynor@gmail.com>, Gary Guo
 <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 "Rafael J. Wysocki"	 <rafael@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?ISO-8859-1?Q?Wilczy=B4nski?=	
 <kwilczynski@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein	 <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=	 <work@onurozkan.dev>,
 Ira Weiny <iweiny@kernel.org>, 	rust-for-linux@vger.kernel.org,
 linux-leds@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Date: Fri, 09 Oct 2026 19:59:02 +0000
In-Reply-To: <aslB3lFUKpMEWOiM@tardis.local>
References: <20260930-rust_leds-v26-0-83837331020e@posteo.de>
	 <20260930-rust_leds-v26-3-83837331020e@posteo.de>
	 <ask31EX01lSL9QJ9@tardis.local>
	 <81e1aa92ebc389468eb6f493393a1c58a79373e7.camel@posteo.de>
	 <aslB3lFUKpMEWOiM@tardis.local>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-AeY1xDGOXdiB/ZsOFAdo"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-AeY1xDGOXdiB/ZsOFAdo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-10-09 at 12:34 -0700, Boqun Feng wrote:
> On Fri, Oct 09, 2026 at 07:18:16PM +0000, Markus Probst wrote:
> > On Fri, 2026-10-09 at 11:52 -0700, Boqun Feng wrote:
> > > On Wed, Sep 30, 2026 at 01:05:32PM +0000, Markus Probst wrote:
> > > > Implement the abstractions needed for multicolor led class devices,
> > > > including:
> > > >=20
> > > > * `led::MultiColor` - the led mode implementation
> > > >=20
> > > > * `MultiColorSubLed` - a safe wrapper arround `mc_subled`
> > > >=20
> > > > * `led::MultiColorDevice` - a safe wrapper around `led_classdev_mc`
> > > >=20
> > > > * `led::DeviceBuilder::build_multicolor` - a function to register a=
 new
> > > >   multicolor led class device
> > > >=20
> > > > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > > > ---
> > > >  rust/bindings/bindings_helper.h |   1 +
> > > >  rust/kernel/led.rs              |  34 ++-
> > > >  rust/kernel/led/multicolor.rs   | 445 ++++++++++++++++++++++++++++=
++++++++++++
> > > >  3 files changed, 479 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindin=
gs_helper.h
> > > > index 4b31aa7f432f..81a03985322a 100644
> > > > --- a/rust/bindings/bindings_helper.h
> > > > +++ b/rust/bindings/bindings_helper.h
> > > > @@ -69,6 +69,7 @@
> > > >  #include <linux/iosys-map.h>
> > > >  #include <linux/jiffies.h>
> > > >  #include <linux/jump_label.h>
> > > > +#include <linux/led-class-multicolor.h>
> > > >  #include <linux/mdio.h>
> > > >  #include <linux/mm.h>
> > > >  #include <linux/miscdevice.h>
> > > > diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
> > > > index c17f8ef75006..4b66fe41a80c 100644
> > > > --- a/rust/kernel/led.rs
> > > > +++ b/rust/kernel/led.rs
> > > > @@ -30,8 +30,16 @@
> > > >      types::Opaque, //
> > > >  };
> > > > =20
> > > > +#[cfg(CONFIG_LEDS_CLASS_MULTICOLOR)]
> > > > +mod multicolor;
> > > >  mod normal;
> > > > =20
> > > > +#[cfg(CONFIG_LEDS_CLASS_MULTICOLOR)]
> > > > +pub use multicolor::{
> > > > +    MultiColor,
> > > > +    MultiColorDevice,
> > > > +    MultiColorSubLed, //
> > > > +};
> > > >  pub use normal::{
> > > >      Device,
> > > >      Normal, //
> > > > @@ -233,7 +241,24 @@ pub enum Color {
> > > >      Violet =3D bindings::LED_COLOR_ID_VIOLET,
> > > >      Yellow =3D bindings::LED_COLOR_ID_YELLOW,
> > > >      Ir =3D bindings::LED_COLOR_ID_IR,
> > > > +    #[cfg_attr(
> > > > +        CONFIG_LEDS_CLASS_MULTICOLOR,
> > > > +        doc =3D "Use this color for a [`MultiColor`] led."
> > > > +    )]
> > > > +    #[cfg_attr(
> > > > +        not(CONFIG_LEDS_CLASS_MULTICOLOR),
> > > > +        doc =3D "Use this color for a `MultiColor` led."
> > > > +    )]
> > > > +    /// If the led supports RGB, use [`Color::Rgb`] instead.
> > > >      Multi =3D bindings::LED_COLOR_ID_MULTI,
> > > > +    #[cfg_attr(
> > > > +        CONFIG_LEDS_CLASS_MULTICOLOR,
> > > > +        doc =3D "Use this color for a [`MultiColor`] led with rgb =
support."
> > > > +    )]
> > > > +    #[cfg_attr(
> > > > +        not(CONFIG_LEDS_CLASS_MULTICOLOR),
> > > > +        doc =3D "Use this color for a `MultiColor` led with rgb su=
pport."
> > > > +    )]
> > > >      Rgb =3D bindings::LED_COLOR_ID_RGB,
> > > >      Purple =3D bindings::LED_COLOR_ID_PURPLE,
> > > >      Orange =3D bindings::LED_COLOR_ID_ORANGE,
> > > > @@ -274,7 +299,14 @@ fn try_from(value: u32) -> core::result::Resul=
t<Self, Self::Error> {
> > > >  ///
> > > >  /// Each led mode has its own led class device type with different=
 capabilities.
> > > >  ///
> > > > -/// See [`Normal`].
> > > > +#[cfg_attr(
> > > > +    CONFIG_LEDS_CLASS_MULTICOLOR,
> > > > +    doc =3D "See [`Normal`] and [`MultiColor`]."
> > > > +)]
> > > > +#[cfg_attr(
> > > > +    not(CONFIG_LEDS_CLASS_MULTICOLOR),
> > > > +    doc =3D "See [`Normal`] and `MultiColor`."
> > > > +)]
> > > >  pub trait Mode: private::Sealed {
> > > >      /// The class device for the led mode.
> > > >      type Device<'bound, T: LedOps<Mode =3D Self> + 'bound>: Deref<=
Target =3D T>;
> > > > diff --git a/rust/kernel/led/multicolor.rs b/rust/kernel/led/multic=
olor.rs
> > > > new file mode 100644
> > > > index 000000000000..309487bdf38a
> > > > --- /dev/null
> > > > +++ b/rust/kernel/led/multicolor.rs
> > > > @@ -0,0 +1,445 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +//! Led mode for the `struct led_classdev_mc`.
> > > > +//!
> > > > +//! C header: [`include/linux/led-class-multicolor.h`](srctree/inc=
lude/linux/led-class-multicolor.h)
> > > > +
> > > > +use core::{
> > > > +    cell::UnsafeCell,
> > > > +    num::NonZero,
> > > > +    ptr, //
> > > > +};
> > > > +
> > > > +use crate::types::ScopeGuard;
> > > > +
> > > > +use super::*;
> > > > +
> > > > +/// The led mode for the `struct led_classdev_mc`. Leds with this =
mode can have multiple colors.
> > > > +pub enum MultiColor {}
> > > > +impl Mode for MultiColor {
> > > > +    type Device<'bound, T: LedOps<Mode =3D Self> + 'bound> =3D Mul=
tiColorDevice<'bound, T>;
> > > > +}
> > > > +impl private::Sealed for MultiColor {}
> > > > +
> > > > +/// The multicolor sub led info representation.
> > > > +///
> > > > +/// This structure represents the Rust abstraction for a C `struct=
 mc_subled`.
> > > > +#[repr(C)]
> > > > +#[derive(Debug)]
> > > > +#[non_exhaustive]
> > > > +pub struct MultiColorSubLed {
> > > > +    /// The color of the sub led
> > > > +    pub color: Color,
> > > > +    brightness: UnsafeCell<u32>,
> > > > +    intensity: UnsafeCell<u32>,
> > >=20
> > > These should be `Atomic<u32>`, or am I missing something here? Using
> > > `Atomic<u32>` should resolve sashiko's comment on this patch.
> > Snippet of the `Atomic::from_ptr` rustdoc:
> >=20
> > "
> > For the duration of 'a, other accesses to *ptr must not cause data
> > races (defined by LKMM) against atomic operations on the returned
> > reference. Note that if all other accesses are atomic, then this safety
> > requirement is trivially fulfilled.
> > "
> >=20
> > This safety requirement is likely not met if I see this correctly,
> > because the led subsystem does not use atomic accesses.
> >=20
>=20
> Then the C side has a data race that needs some fix (or they use
> READ_ONCE() or WRITE_ONCE() which are *atomic* to avoid the data race).
They don't use READ_ONCE or WRITE_ONCE.

Writes to "intensity" can happen at anytime by `multi_intensity_store`.
It does lock the `led_access` mutex on write. It is not locked on read
and `grep "READ_ONCE" -r drivers/leds/` has no matches in drivers
either.

Writes to "brightness" are on the C-side handled by the driver by
calling `led_mc_calc_color_components`. This rust abstraction always
calles it in `brightness_set_callback`. So on the C-side, this at least
is less of an issue, as writes and reads are controlled by the C
driver.

>=20
> The general rule is: if C side has a data race, they should fix it, if C
> side doesn't care ("the compiler should not data race on this code"),
> then the Rust side treat it as atomic operations. This is the only way
> to better code regarding data races.
It probably should use WRITE_ONCE and READ_ONCE, but it also shouldn't
create any issues if its not used. There is no load tearing on a 32-bit
integer and memory ordering is not required. Not sure if its worth the
trouble changing every existing multicolor led driver.

>=20
> > Ofc, this function won't be used, but I think given that the same
> > struct is also accessed by the C-side, it should also apply here.
> >=20
> > Like Sashiko suggests, "core::ptr::read_volatile()" might be a better
> > option to prevent certain compiler optimizations.
> >=20
>=20
> No, please don't over-use read_volatile(). The reason that READ_ONCE()
> and WRITE_ONCE() are safe to use for synchronization is because
> semantics-wise they are atomic on certain types (if aligned), and the
> them being volatile is just an implementation detail.
Ok.

I will need to make .get_mut() const for this.

>=20
> Regards,
> Boqun

Thanks
- Markus Probst

>=20
> > Thanks
> > - Markus Probst
> >=20
> > >=20
> > > Regards,
> > > Boqun
> > >=20
> > > > +    /// The maximum supported intensity value.
> > > > +    ///
> > > > +    /// If None the maximum intensity equals to [`LedOps::MAX_BRIG=
HTNESS`].
> > > > +    pub max_intensity: Option<NonZero<u32>>,
> > > > +    /// Arbitrary data for the driver to store.
> > > > +    pub channel: u32,
> > > > +}
> > > > +
> > > [...]
>=20

--=-AeY1xDGOXdiB/ZsOFAdo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmrJR3wbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSqdEP/iMYgOqxBz+JR+7SqJuE
j5gz8uAORCLpoV+oq3oqXY0U5TSVjuv8kWK1r2vMhgqHe3nnfBJuEbp8zNhYpKM8
+Z9cnysMGg8qUv4zE7tWKqyPqfxE/PLcipEW63W+gV3djTwkXU9P3YR0rBagFyDH
k1bmRe3BuKrb9+WT4ymdrfXhM0TLXbZl2qMZFsoXtfcppO3o0MFAXpfcF5zsWsTs
t6AWJ/DsAcLz+vKlZfGwJC6aEYQsRZC6Lk3kCoqrtYFySba0W/RV8OLNV9KKGoaR
YXKiYIz/BRIwiYEqiN60/arTQKo2kYccO7J3MzNWwmkmUO26AEICGtGL2WQcz3Fe
nYB4LLhCFSlohFc0v0i10pbBmzBFhSuAW3zOn8Rh/JEqOx7Lf2WcoPuyPiE8kgZb
QuzC07zub61r0iaSAfv6cW4HrFucWTVtYE+f6p7fWsa4Rub7hYZovQsQNT70UFhr
lguMaK/hXLzmpvhb2X0qB+scTolalrIzaxUKEsM+5zIQ3PqnraMVt30S87bSfBV5
ozpAJawRRRWWL92twHHlbjhd/XJr9TqNlzpYD41tMOEMrVKoe4Wkipt6G9auL+LM
CmcAbfA/ZeJCY0yl3RR+v/Ci1CuagJ0FKedcDOlNvrTpLIGJhoYvafhxKyq0bVi6
dGuG/x3vcK2kxQxvVZbGRDcV
=RblI
-----END PGP SIGNATURE-----

--=-AeY1xDGOXdiB/ZsOFAdo--
