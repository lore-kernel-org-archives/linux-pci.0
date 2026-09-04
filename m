Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEEE356772
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527750; cv=none; b=rf8wfHrKfmeoOh7B16olZn6PweNG5b9EvDS0U70WKc4s85M/PdbBUbNybEKxBmxmB9AQ7JnHwHFbacUQ7KzHKuuQ2Ykx4IjEp5/qiaPCEmcK1P9hHt0ota8Wym/qbdeLmnBDk6v2pC6fZmmVfkiuqqx2eiVdWShGjRyaye5+Ekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527750; c=relaxed/simple;
	bh=+yd2ujQF4Rxkb5XryUBuZgnM2M+Yax+7uavPjdEWkpA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EuNy59g9EbHkfgH38JZyBu3WG+k3oFiMWWadmwW9qdlU7QVF5dZ1XLz8bFLVLVNONicbS4OzjDsf/30EkQOMOh8effZApfYnMthXAP0VkaLZvCxT1PZfjWViu5uuRcBp78FndmTm+KE2M99tMCwDjle9+0HTFsOmLNH1CErHROs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=ZrP+REOS; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="ZrP+REOS"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 1B96B240104
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 15:15:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788527739;
	bh=mzw015gDpf/mVU0JJQSLVGclm1Ii2Bf9Le8LbZPWyYs=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=ZrP+REOSwS9A2d5IjvPFQGj8qGngoNHJLlHRohv3ja+0prDS4qPdAK7tI6ZMvAlqS
	 U5MgVcJTgSqf/uf+vjT5sMhy0cWaOKigGHsZagScj6+LGuDXuZRkMaM4W8tQuO/Y1u
	 Ao9tYQBzdBF7riBKsdl3ZReKP6k9WPuS6RC0gRbGcPf8D5k2+csr0BhZPFdqSW+QTs
	 Css/rZ16BlCnXE5LMsgUJUOfeKa8VFIS88jWzb3ScIBaM8OQ+jenmpzfXMIO/cE4um
	 +ZG0Vb6yOKP3gdRn3t0rLp7s88sJGfh6qOEatSJZP1gsc9h6SjM3uhqFYy86AnhC/Z
	 isyIZhb3d1fyA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hbxm71hKhz9rxF;
	Fri,  4 Sep 2026 15:15:35 +0200 (CEST)
Message-ID: <612e01853459f0eb87fe78b7f5fdb73e22cd1776.camel@posteo.de>
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
Date: Fri, 04 Sep 2026 13:15:37 +0000
In-Reply-To: <DL6JWHOEG91Y.1BKBUP653Z5D@garyguo.net>
References: <20260903-rust_leds-v24-0-8d9e4c04db69@posteo.de>
	 <20260903-rust_leds-v24-1-8d9e4c04db69@posteo.de>
	 <DL6JWHOEG91Y.1BKBUP653Z5D@garyguo.net>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-M1r+S+196cCQmWQoF0rF"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-M1r+S+196cCQmWQoF0rF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-09-04 at 14:03 +0100, Gary Guo wrote:
> On Thu Sep 3, 2026 at 12:01 AM BST, Markus Probst wrote:
> > Implement the core abstractions needed for led class devices, including=
:
> >=20
> > * `led::LedOps` - the trait for handling leds, including
> >   `brightness_set`, `brightness_get` and `blink_set`
> >=20
> > * `led::DeviceBuilder` - the builder for the led class device
> >=20
> > * `led::Device` - a safe wrapper around `led_classdev`
> >=20
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> >  rust/kernel/led.rs        | 288 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  rust/kernel/led/normal.rs | 230 ++++++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs        |   1 +
> >  3 files changed, 519 insertions(+)
> >=20
> > [snip]
> >=20
> > +/// Trait defining the operations for a LED driver.
> > +///
> > +/// # Examples
> > +/// ```
> > +/// use kernel::{
> > +///      device,
> > +///      devres::Devres,
> > +///      led,
> > +///      macros::vtable,
> > +///      platform,
> > +///      prelude::*, //
> > +///  };
> > +///
> > +/// struct MyLedOps;
> > +///
> > +///
> > +/// #[vtable]
> > +/// impl led::LedOps for MyLedOps {
> > +///     type Bus =3D platform::Device<device::Bound>;
> > +///     const BLOCKING: bool =3D false;
> > +///     const MAX_BRIGHTNESS: u32 =3D 255;
> > +///
> > +///     fn brightness_set<'bound>(
> > +///         &self,
> > +///         _dev: &'bound platform::Device<device::Bound>,
> > +///         _classdev: &led::Device<'bound, Self>,
> > +///         _brightness: u32
> > +///     ) -> Result<()> {
> > +///         // Set the brightness for the led here
> > +///         Ok(())
> > +///     }
> > +/// }
> > +/// ```
> > +/// Led drivers must implement this trait in order to register and han=
dle a [`Device`].
> > +#[vtable]
> > +pub trait LedOps: Send + Sync + Sized {
> > +    /// The bus device required by the implementation.
> > +    #[allow(private_bounds)]
> > +    type Bus: AsBusDevice<Bound>;
>=20
> Does LED class device has no private data that driver can use? This can b=
e
> either a private pointer or extra allocation living at the end of the cla=
ssdev
> struct.
On every callback `&self` is passed to the LedOps, which could be
considered the leds private data. It is currently stored in front of
the `led_classdev` struct.
>=20
> It's usually a antipattern to get the bus device directly, especially tha=
t in
> Rust we do not allow anything other than callbacks to access data on bus
> devices.
>=20
> Instead, the class device registration should provide a data initializer,=
 and
> the callbacks would receive a pointer to the data instead. In cases that =
a
> device resource has to be referenced, it should be kept inside the privat=
e data
> by the driver themselves.
It should be possible to store a pointer to the bus device directly on
this data, thus I can remove it.

If I think about it, I could add a `led::Device::drvdata` function, so
it could be accessed from the drivers private data. Sync is a
requirement anyway.

Thanks
- Markus Probst

>=20
> Best,
> Gary
>=20
> > +
> > +    /// If set true, [`LedOps::brightness_set`] and [`LedOps::blink_se=
t`] must perform the
> > +    /// operation immediately. If set false, they must not sleep.
> > +    const BLOCKING: bool;
> > +    /// The max brightness level.
> > +    const MAX_BRIGHTNESS: u32;
> > +
> > +    /// Sets the brightness level.
> > +    ///
> > +    /// See also [`LedOps::BLOCKING`].
> > +    fn brightness_set<'bound>(
> > +        &self,
> > +        dev: &'bound Self::Bus,
> > +        classdev: &Device<'bound, Self>,
> > +        brightness: u32,
> > +    ) -> Result<()>;
> > +
> > +    /// Gets the current brightness level.
> > +    fn brightness_get<'bound>(
> > +        &self,
> > +        dev: &'bound Self::Bus,
> > +        classdev: &Device<'bound, Self>,
> > +    ) -> Result<u32> {
> > +        let _ =3D (dev, classdev);
> > +        build_error!(VTABLE_DEFAULT_ERROR)
> > +    }
> > +
> > +    /// Activates hardware accelerated blinking.
> > +    ///
> > +    /// delays are in milliseconds. If both are zero, a sensible defau=
lt should be chosen.
> > +    /// The caller should adjust the timings in that case and if it ca=
n't match the values
> > +    /// specified exactly. Setting the brightness to 0 will disable th=
e hardware accelerated
> > +    /// blinking.
> > +    ///
> > +    /// See also [`LedOps::BLOCKING`].
> > +    fn blink_set<'bound>(
> > +        &self,
> > +        dev: &'bound Self::Bus,
> > +        classdev: &Device<'bound, Self>,
> > +        delay_on: &mut usize,
> > +        delay_off: &mut usize,
> > +    ) -> Result<()> {
> > +        let _ =3D (dev, classdev, delay_on, delay_off);
> > +        build_error!(VTABLE_DEFAULT_ERROR)
> > +    }
> > +}

--=-M1r+S+196cCQmWQoF0rF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqaxFcbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSjv8QAJ58emavjkwU2mAkS/Sc
sFEBYf5+ihxHxkQEZExP3oJtbaTQgPxwCxSDvRd82xcgMOzKcqje2S01vssjcQIc
CmBmGum7TTJyytxd5u2hHPIeqhLZrGuAQKOMBYHl/MIfQedIAkkMyDJ2vhEL6flg
zBCHmHkmKtCR2aNEL0MNy9ay6HYFUTEnj9qRFdfXd003KsB24Aqd4T2FscYU9sgq
WSWZr+5jQIHXxITZFBvH85f1lQqspCCMRUy16Lk1jrTzb1B8fIbTZkw1xNLJfD88
88TIKw4aCYTEjz4kXn8/AE0DXAwCAjFylC9eVbr7qVV7K92ksKUrPDbpiDRofbVk
/QdnEssk3LZvT6/7BBmHSpTYclFiPseIFJFe249Ca9tGQJMZAS8fluJcvxG85znW
noCoMiED9QT1ieUXn5TanT/vvwa4nThpntoOM2u+JJEF3DLnVHS4q1OqzUQECeWg
9lvS4mBd9LHYJgTH20GWybZyZGMaL5sFzNfeYKFFTYLqV1Jya+dxl0LbOikFz+wY
BFEABkgNo5cjLhiGT9bWVR6q6Q3RZMb9LxPjfID2wnjV6oQn8iJVRov1svtdB3uG
JYLO6+N/cVaFi/v49xflGKa7Y49seKGhpj+jc0wdWVoM+a+mg8mDKR7cEKhrcMfW
zJY0QoT/QPyskzKt6xBiL4Pb
=Dm4Y
-----END PGP SIGNATURE-----

--=-M1r+S+196cCQmWQoF0rF--
