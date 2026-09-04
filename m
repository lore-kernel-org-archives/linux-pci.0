Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FCD4A4988
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530695; cv=none; b=G8tj5dtPdAWjJ5VvXXdgcjXjiY9B+xyVfYGKGsgaUfhs+w6lAt2/Otq6cwZdk/pXW3eyGER39KG88SC1A+32IkiSoCxlJcix3JATZC4na/iOasWhxnVco5TnQJInyhz7Rg+tIVkSxTshaY41IpNRvnR5Q/B23p5bck7kWbObJuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530695; c=relaxed/simple;
	bh=DeOOdRPNYib8Gy/FmsNEsDfL4q8uVU7RNFgmKXriwHw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M9sQqk5JvCyX+wRXkcGJGe/yRtbyNJDJxNKwJf/mr+t/UVeS34qxp9CCfWlQycxtZ3QgLV6SLmCOm+vuxytZaCSWzY/PLG4C308hgEKOXEYYwJHPTZsZhu/r35Zr1oOEXgI03pF09nVuwxSdkZBqr8xPMy4TQE4n3iFuvg6s9vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=V2b8ddpE; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="V2b8ddpE"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id A0367240103
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 16:04:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788530691;
	bh=kFwO9zRZBkjZfmI3N600UZ+vSlLPXJi/vAD3urZPNJs=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=V2b8ddpE0NUQm0m97FGcHqbssTVS6285sXO/ka2BF7T8kG5ZnlNj6QA1sTONiQSo5
	 UK+EnwLv97fN2NhXaC02l/A38x/P+HH5xfV8XwtX7mr1B4Y8qd+r3bpLEb7rSzamSP
	 g/k071n1SxD+M6k0bvFvhJ6SxO/upbvuczaz0Qj+FBNA+0jTfEquriSsHNS5U20ehq
	 Fyjq6U6FyQUTjSfBxkNr8OD7z0yhcZdayYbHfLuPRZbmEaxMf/+UgzOOXwT3H8Dnbz
	 wmS5y6dqJ6UF545tOnJNryXhNs4dD1rRCEaYNn0fXlw7zhxf0xkZ3SXrD+yJ3pJyt9
	 Y8cgns2JLanMg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hbyrv6XhMz6tvk;
	Fri,  4 Sep 2026 16:04:47 +0200 (CEST)
Message-ID: <4a3101718c7071009c9155d3819da2112277b04a.camel@posteo.de>
Subject: Re: [PATCH v24 1/4] rust: leds: add basic led classdev abstractions
From: Markus Probst <markus.probst@posteo.de>
To: Gary Guo <gary@garyguo.net>, Lee Jones <lee@kernel.org>, Pavel Machek	
 <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave
 Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Miguel Ojeda	 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki"	
 <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?=	 <kwilczynski@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Daniel Almeida	 <daniel.almeida@collabora.com>, Tamir
 Duberstein <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Ira Weiny	
 <iweiny@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Fri, 04 Sep 2026 14:04:50 +0000
In-Reply-To: <DL6KIVBHB08P.1LH0WPGN5FFVN@garyguo.net>
References: <20260903-rust_leds-v24-0-8d9e4c04db69@posteo.de>
	 <20260903-rust_leds-v24-1-8d9e4c04db69@posteo.de>
	 <DL6JWHOEG91Y.1BKBUP653Z5D@garyguo.net>
	 <612e01853459f0eb87fe78b7f5fdb73e22cd1776.camel@posteo.de>
	 <DL6KIVBHB08P.1LH0WPGN5FFVN@garyguo.net>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-7EqmRrjDvDHZjW/E3w9a"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-7EqmRrjDvDHZjW/E3w9a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-09-04 at 14:32 +0100, Gary Guo wrote:
> On Fri Sep 4, 2026 at 2:15 PM BST, Markus Probst wrote:
> > On Fri, 2026-09-04 at 14:03 +0100, Gary Guo wrote:
> > > On Thu Sep 3, 2026 at 12:01 AM BST, Markus Probst wrote:
> > > > Implement the core abstractions needed for led class devices, inclu=
ding:
> > > >=20
> > > > * `led::LedOps` - the trait for handling leds, including
> > > >   `brightness_set`, `brightness_get` and `blink_set`
> > > >=20
> > > > * `led::DeviceBuilder` - the builder for the led class device
> > > >=20
> > > > * `led::Device` - a safe wrapper around `led_classdev`
> > > >=20
> > > > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > > > ---
> > > >  rust/kernel/led.rs        | 288 ++++++++++++++++++++++++++++++++++=
++++++++++++
> > > >  rust/kernel/led/normal.rs | 230 ++++++++++++++++++++++++++++++++++=
++
> > > >  rust/kernel/lib.rs        |   1 +
> > > >  3 files changed, 519 insertions(+)
> > > >=20
> > > > [snip]
> > > >=20
> > > > +/// Trait defining the operations for a LED driver.
> > > > +///
> > > > +/// # Examples
> > > > +/// ```
> > > > +/// use kernel::{
> > > > +///      device,
> > > > +///      devres::Devres,
> > > > +///      led,
> > > > +///      macros::vtable,
> > > > +///      platform,
> > > > +///      prelude::*, //
> > > > +///  };
> > > > +///
> > > > +/// struct MyLedOps;
> > > > +///
> > > > +///
> > > > +/// #[vtable]
> > > > +/// impl led::LedOps for MyLedOps {
> > > > +///     type Bus =3D platform::Device<device::Bound>;
> > > > +///     const BLOCKING: bool =3D false;
> > > > +///     const MAX_BRIGHTNESS: u32 =3D 255;
> > > > +///
> > > > +///     fn brightness_set<'bound>(
> > > > +///         &self,
> > > > +///         _dev: &'bound platform::Device<device::Bound>,
> > > > +///         _classdev: &led::Device<'bound, Self>,
> > > > +///         _brightness: u32
> > > > +///     ) -> Result<()> {
> > > > +///         // Set the brightness for the led here
> > > > +///         Ok(())
> > > > +///     }
> > > > +/// }
> > > > +/// ```
> > > > +/// Led drivers must implement this trait in order to register and=
 handle a [`Device`].
> > > > +#[vtable]
> > > > +pub trait LedOps: Send + Sync + Sized {
> > > > +    /// The bus device required by the implementation.
> > > > +    #[allow(private_bounds)]
> > > > +    type Bus: AsBusDevice<Bound>;
> > >=20
> > > Does LED class device has no private data that driver can use? This c=
an be
> > > either a private pointer or extra allocation living at the end of the=
 classdev
> > > struct.
> > On every callback `&self` is passed to the LedOps, which could be
> > considered the leds private data. It is currently stored in front of
> > the `led_classdev` struct.
>=20
> Right, I missed that. In that case I think you can just remove `Bus` comp=
letely
> from the callback?
Yes.

>=20
> Do you have a user that needs this info? BTW, it would also help to inclu=
de a
> link to a potential user in the cover letter so people can see how the AP=
I is
> supposed to be used. This is especially useful for API design reviews.
Primarily
https://lore.kernel.org/rust-for-linux/20260724-synology_microp_initial-v18=
-0-fb2f49f10e77@posteo.de/

.
But I also have another rust i2c driver, which would use the led
abstraction:

https://codeberg.org/0xIO32/linux/src/branch/synology_disk_leds

Still needs changes before it can be submitted.


>=20
> > >=20
> > > It's usually a antipattern to get the bus device directly, especially=
 that in
> > > Rust we do not allow anything other than callbacks to access data on =
bus
> > > devices.
> > >=20
> > > Instead, the class device registration should provide a data initiali=
zer, and
> > > the callbacks would receive a pointer to the data instead. In cases t=
hat a
> > > device resource has to be referenced, it should be kept inside the pr=
ivate data
> > > by the driver themselves.
> > It should be possible to store a pointer to the bus device directly on
> > this data, thus I can remove it.
> >=20
> > If I think about it, I could add a `led::Device::drvdata` function, so
> > it could be accessed from the drivers private data. Sync is a
> > requirement anyway.
>=20
> An option is to provide `Deref`. Then you could even have
> `self: &Device<'bound, Self>` in callbacks.
Didn't know we had `feature(arbitrary_self_types)` enabled.
I like this idea.

>=20
> That said, you might want to eventually support type-erased `Device` type=
s to
> support consumer of LED class devices. So I'm unsure if we want to provid=
e data
> accessors on class devices (maybe eventually device'll be split into two =
types?)
Sounds good, but I won't implement any consumer functions until they
are needed.

Thanks
- Markus Probst

>=20
> Best,
> Gary

--=-7EqmRrjDvDHZjW/E3w9a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqaz/YbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSeD8QAK4BrJc8X+YS+/oq7z3L
Xgyx0J9RAEoEoDOiou1vis66J/aRY01qEHfoICR1DSi9atV+DmHnHt/ydLCi/KPM
HX7bO+ZADGQrVUW1OKElwnbx2VjucPy8aKavMunRMuZpb1HCAhSJQUIGt2rH23Lw
3E2KWBRN5/47Y7KXR5QAdWb8PhdfeLcGhkJv7pyymZK1OqPkXG7BaVSB/RwV34g1
EhGnX1pHdZilqfbgSR2+Rnm287aSzwyz6spHNo5knlNob1lIAxo4hixt3llAU5+O
R4GrPGTkHuiVs8HKPP4qIeX2MSq8LqWC6cCED0jbGtrhjTrZWYmwRD838sXl1Zjj
BgZm7Oc3QAOzAgVS5ygxPlBVTr8dACUjOwT+qTspf4JaIP1eEMHe+/aHKZ6vpmOT
GEJ1tRtSfPmeEuZYSCTmppbUvuwZ9oLcjSjts4hqX8nNelgG+TEU6hd1klyOP15O
Jxa4Wf3mpBcd0DDANvmJl8LcSFObAGo9q0YfSCbE89wPse4yrGMal57EVGydoRzc
h4D/kXUlbTKU2YFuzTD1Bg+nMCPKPf2X87Xn9jP2XZ/hwrHp6TphjVqA3XOIU8o8
4+XarSuTw88hJnq5cmcTgpDk9uwDr0cGn3nzyMZ93V3HbKgsyMlzhsxEifp/XG7X
3zD7O6b7lqLG+5DKwl20ShqV
=Ff70
-----END PGP SIGNATURE-----

--=-7EqmRrjDvDHZjW/E3w9a--
