Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B42435534
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791573502; cv=none; b=Q235foaS6VMy2IZrva0lIALb5CemZrzcQ23W0vb9syIcqLUUuJuhCByp0LTG0RDayDtWhiGKAFQs12fj5oWAruLhTf3OlKpDrKZSVbyEpKX6xAWCopzWyIlzJm1KBSP+kC/tKAVo+Ujfsi3JpFTEZ7wGYNCDm3t2wMqbEorGYgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791573502; c=relaxed/simple;
	bh=QJNnLTWbPIc0IRk3LBCKNNqgIK8CqMpv7T7NZvSxuks=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q6CPZkLYSi4QQPv4DlxHwLjj0xCsXK8mo6Hkfxh2/7CKVEk65wTeGpASljTaOFqE83PokPjXaRrc7U0A+shKSWNDhEviooBxZkHJ3ujYUi/ll5v9p3BivPXKbaluUH/BK61ZRVQxmE1JhB2Wy6lmMK7lOPDEoWVocXdypVy6aAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=nm7Ex7gY; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="nm7Ex7gY"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id DC422240107
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 21:18:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1791573497;
	bh=FNjC8CQdezjbjbIN10GIqhnKvMIJQ0qM8m+UWFEtdXg=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=nm7Ex7gYZOsJ42vAFuqWTGKoOBuqVmc0zIQ4TygFWzCP6QGveqzs17CKAKbcOauIk
	 FVc2wJryW1hgPoki8WkDtxJ6ZxthDdZyZd3cghvObzGxvT13WYfVQOkvHnKfa8H4uW
	 bb06VdVNTnFTL7onBTF2WIF/GH4OFhmgBE4yIlM6lPmCdDNMv7jULuaCWnBQ3L4j5d
	 MHs56Sm4aVkN3pbqzRA7gYDDgMvPuPClm6ihbYM2oC19JxDjmh6AY2Dl+lypVL0R+n
	 2bMRMefAer1Uj0O2o5SeVTwa5I1aZoK5glsBUw6e9Q61kw2OsAzFpIOOYmTym1vlgo
	 n4V2lvdvIozlw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j1c8Q0hVrz9rxD;
	Fri,  9 Oct 2026 21:18:13 +0200 (CEST)
Message-ID: <81e1aa92ebc389468eb6f493393a1c58a79373e7.camel@posteo.de>
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
Date: Fri, 09 Oct 2026 19:18:16 +0000
In-Reply-To: <ask31EX01lSL9QJ9@tardis.local>
References: <20260930-rust_leds-v26-0-83837331020e@posteo.de>
	 <20260930-rust_leds-v26-3-83837331020e@posteo.de>
	 <ask31EX01lSL9QJ9@tardis.local>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-y8/PBsqchvqDf6iK4n7Q"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-y8/PBsqchvqDf6iK4n7Q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-10-09 at 11:52 -0700, Boqun Feng wrote:
> On Wed, Sep 30, 2026 at 01:05:32PM +0000, Markus Probst wrote:
> > Implement the abstractions needed for multicolor led class devices,
> > including:
> >=20
> > * `led::MultiColor` - the led mode implementation
> >=20
> > * `MultiColorSubLed` - a safe wrapper arround `mc_subled`
> >=20
> > * `led::MultiColorDevice` - a safe wrapper around `led_classdev_mc`
> >=20
> > * `led::DeviceBuilder::build_multicolor` - a function to register a new
> >   multicolor led class device
> >=20
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> >  rust/bindings/bindings_helper.h |   1 +
> >  rust/kernel/led.rs              |  34 ++-
> >  rust/kernel/led/multicolor.rs   | 445 ++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 479 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_h=
elper.h
> > index 4b31aa7f432f..81a03985322a 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -69,6 +69,7 @@
> >  #include <linux/iosys-map.h>
> >  #include <linux/jiffies.h>
> >  #include <linux/jump_label.h>
> > +#include <linux/led-class-multicolor.h>
> >  #include <linux/mdio.h>
> >  #include <linux/mm.h>
> >  #include <linux/miscdevice.h>
> > diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
> > index c17f8ef75006..4b66fe41a80c 100644
> > --- a/rust/kernel/led.rs
> > +++ b/rust/kernel/led.rs
> > @@ -30,8 +30,16 @@
> >      types::Opaque, //
> >  };
> > =20
> > +#[cfg(CONFIG_LEDS_CLASS_MULTICOLOR)]
> > +mod multicolor;
> >  mod normal;
> > =20
> > +#[cfg(CONFIG_LEDS_CLASS_MULTICOLOR)]
> > +pub use multicolor::{
> > +    MultiColor,
> > +    MultiColorDevice,
> > +    MultiColorSubLed, //
> > +};
> >  pub use normal::{
> >      Device,
> >      Normal, //
> > @@ -233,7 +241,24 @@ pub enum Color {
> >      Violet =3D bindings::LED_COLOR_ID_VIOLET,
> >      Yellow =3D bindings::LED_COLOR_ID_YELLOW,
> >      Ir =3D bindings::LED_COLOR_ID_IR,
> > +    #[cfg_attr(
> > +        CONFIG_LEDS_CLASS_MULTICOLOR,
> > +        doc =3D "Use this color for a [`MultiColor`] led."
> > +    )]
> > +    #[cfg_attr(
> > +        not(CONFIG_LEDS_CLASS_MULTICOLOR),
> > +        doc =3D "Use this color for a `MultiColor` led."
> > +    )]
> > +    /// If the led supports RGB, use [`Color::Rgb`] instead.
> >      Multi =3D bindings::LED_COLOR_ID_MULTI,
> > +    #[cfg_attr(
> > +        CONFIG_LEDS_CLASS_MULTICOLOR,
> > +        doc =3D "Use this color for a [`MultiColor`] led with rgb supp=
ort."
> > +    )]
> > +    #[cfg_attr(
> > +        not(CONFIG_LEDS_CLASS_MULTICOLOR),
> > +        doc =3D "Use this color for a `MultiColor` led with rgb suppor=
t."
> > +    )]
> >      Rgb =3D bindings::LED_COLOR_ID_RGB,
> >      Purple =3D bindings::LED_COLOR_ID_PURPLE,
> >      Orange =3D bindings::LED_COLOR_ID_ORANGE,
> > @@ -274,7 +299,14 @@ fn try_from(value: u32) -> core::result::Result<Se=
lf, Self::Error> {
> >  ///
> >  /// Each led mode has its own led class device type with different cap=
abilities.
> >  ///
> > -/// See [`Normal`].
> > +#[cfg_attr(
> > +    CONFIG_LEDS_CLASS_MULTICOLOR,
> > +    doc =3D "See [`Normal`] and [`MultiColor`]."
> > +)]
> > +#[cfg_attr(
> > +    not(CONFIG_LEDS_CLASS_MULTICOLOR),
> > +    doc =3D "See [`Normal`] and `MultiColor`."
> > +)]
> >  pub trait Mode: private::Sealed {
> >      /// The class device for the led mode.
> >      type Device<'bound, T: LedOps<Mode =3D Self> + 'bound>: Deref<Targ=
et =3D T>;
> > diff --git a/rust/kernel/led/multicolor.rs b/rust/kernel/led/multicolor=
.rs
> > new file mode 100644
> > index 000000000000..309487bdf38a
> > --- /dev/null
> > +++ b/rust/kernel/led/multicolor.rs
> > @@ -0,0 +1,445 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Led mode for the `struct led_classdev_mc`.
> > +//!
> > +//! C header: [`include/linux/led-class-multicolor.h`](srctree/include=
/linux/led-class-multicolor.h)
> > +
> > +use core::{
> > +    cell::UnsafeCell,
> > +    num::NonZero,
> > +    ptr, //
> > +};
> > +
> > +use crate::types::ScopeGuard;
> > +
> > +use super::*;
> > +
> > +/// The led mode for the `struct led_classdev_mc`. Leds with this mode=
 can have multiple colors.
> > +pub enum MultiColor {}
> > +impl Mode for MultiColor {
> > +    type Device<'bound, T: LedOps<Mode =3D Self> + 'bound> =3D MultiCo=
lorDevice<'bound, T>;
> > +}
> > +impl private::Sealed for MultiColor {}
> > +
> > +/// The multicolor sub led info representation.
> > +///
> > +/// This structure represents the Rust abstraction for a C `struct mc_=
subled`.
> > +#[repr(C)]
> > +#[derive(Debug)]
> > +#[non_exhaustive]
> > +pub struct MultiColorSubLed {
> > +    /// The color of the sub led
> > +    pub color: Color,
> > +    brightness: UnsafeCell<u32>,
> > +    intensity: UnsafeCell<u32>,
>=20
> These should be `Atomic<u32>`, or am I missing something here? Using
> `Atomic<u32>` should resolve sashiko's comment on this patch.
Snippet of the `Atomic::from_ptr` rustdoc:

"
For the duration of 'a, other accesses to *ptr must not cause data
races (defined by LKMM) against atomic operations on the returned
reference. Note that if all other accesses are atomic, then this safety
requirement is trivially fulfilled.
"

This safety requirement is likely not met if I see this correctly,
because the led subsystem does not use atomic accesses.

Ofc, this function won't be used, but I think given that the same
struct is also accessed by the C-side, it should also apply here.

Like Sashiko suggests, "core::ptr::read_volatile()" might be a better
option to prevent certain compiler optimizations.

Thanks
- Markus Probst

>=20
> Regards,
> Boqun
>=20
> > +    /// The maximum supported intensity value.
> > +    ///
> > +    /// If None the maximum intensity equals to [`LedOps::MAX_BRIGHTNE=
SS`].
> > +    pub max_intensity: Option<NonZero<u32>>,
> > +    /// Arbitrary data for the driver to store.
> > +    pub channel: u32,
> > +}
> > +
> [...]

--=-y8/PBsqchvqDf6iK4n7Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmrJPe8bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPS4aUP/R/DLeYIdqUXlPuo2jqy
kuQ7hx8WN9Y1iTNTOAn/GE8vuViEUL1fsEsNG3Uz1JzPQ5kCeWpyX1JXs229Bygt
yWmwE+AAg35U/pAzAfOzFcFScgRuczxfMH3DynPqSoh3AhKg1XHHJJFnBk8KytO0
GWIsw7ygpwxDAMqirniroLCpFmjyIccZ/dKKunVlFXLw9M3JAOyXIK++JTnNtWtH
ai88NG3GoX6AQoO30hmntuV88bTmPkupGAnOtOeaDNPiFiqdqmG4GcKAoCepiwsu
/DMYos3IYBJuiFx1tg+ou/3FiCp4yoHMoXKjHW588GR3HBlescX3EpQACDyxi2HS
sQWA8sEp2I5FfZO0oes4WbdOqCW9e1p24I8a5Rnc0BmoX9z4+RUlgpOK/xqRupTY
JYBc46VWOakXHXpMgrS0Um6m8oDSsR9DmfqYuIpUAgM5Ex/bUUFWooeXqAPLAGWg
mBVrYSJpSsRz2ojkPSOKmv26/UZPDEDl67Cyccc2ioOCOlq7LwCjYZn9BT7aqJRg
6t+WLiSvA7OjAhGJyPgb1iFBTtWOAKxnJ9T5ydFDkEiH3LLaqXvredIm4WuoI8AY
7WuEpfR2P4QOxKzOQCVeItEYzDwX8CnLiCCQ1WFe0ygs6RBPY3wghAWZXAXLIFva
Y9kc1CNmAR+Rj1eFm+r51kOt
=CPoW
-----END PGP SIGNATURE-----

--=-y8/PBsqchvqDf6iK4n7Q--
