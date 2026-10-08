Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FE13EE1F8
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459147; cv=none; b=IUm8VpvBAHsP6llq7hEWyoIoqO98xgxfTbaXCdRFaFDYdJyYALPLX2bvmJXb6CsHHeDfSukGXYlJW8X4sxfStZnQrkzEd+HbC7cxxXCfmI0bKN+j+FzeCLZp8zRdnglRFpxs/E3PbiB7GVBLsGv0BjhwDquLg/X8qMTSKm9V6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459147; c=relaxed/simple;
	bh=UeuCAU/sCWyG54xqgCdm24InupWUv371orXdBtfrgk0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q9Ab/v6iAXQ91Exg6FPv2xZz8Y7GlXYQ+Q8CMuiMrL7k3o7wcNhICEcdtqGfQkiTvXrRlK8yA5O7lE64IgNLpVzZJmqIsaNNKcUHvX91hBk41BF5e2gb8ugj5yLS0/FurvHv26e8b5vdiaQQNGXJgjzcHXEDJu5YcAz4U8rr1v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=ADk8CJ6t; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="ADk8CJ6t"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 86623240105
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 13:32:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1791459142;
	bh=jiR6BVaSgY4gROjK2KwVqFQDqFXzWQiwsI2Dx12ojdc=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=ADk8CJ6tAq4ZycsZpe4vDB7HAdOsuXDoyZtChC+TmEQ4fRbJn2rZYyAorzj/1u6L9
	 SPzMV/0KxBQ7IXG3jkesLT9FfcigEIpAmU+4JqIZzaTljW4mkXJ77gsTnj2ma6akBl
	 FuGgUF/h8FcuqgHGsX4sz3gJewNHn0mr+ym5tol6ruuGxRYQ6Qs5M/CUCrN8d1zdrU
	 U/qpENORo7GfgFjfuvOCTxUSi0jDedENda6z1icutFevBwYlHN8hym8BmcMeprRQM/
	 Zm6dqSn1A3icrvtko22w1MltwudyWgEilsDiWhy53NMKtLxtKGU574p/fJrlRqjtmM
	 jbSfOKHCnm9hQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j0nsF6TRFz6txp;
	Thu,  8 Oct 2026 13:32:17 +0200 (CEST)
Message-ID: <c816c2986a4227285b83a7c76d5acce3d5eeaafd.camel@posteo.de>
Subject: Re: [PATCH v26 0/4] rust: leds: Add led classdev abstractions
From: Markus Probst <markus.probst@posteo.de>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman
 <david.m.ertman@intel.com>, Leon Romanovsky	 <leon@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor	 <alex.gaynor@gmail.com>, Gary Guo
 <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 "Rafael J. Wysocki"	 <rafael@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	
 <kwilczynski@kernel.org>, Boqun Feng <boqun@kernel.org>, Daniel Almeida	
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=
 <work@onurozkan.dev>, Ira Weiny	 <iweiny@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Thu, 08 Oct 2026 11:32:20 +0000
In-Reply-To: <20260930-rust_leds-v26-0-83837331020e@posteo.de>
References: <20260930-rust_leds-v26-0-83837331020e@posteo.de>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-yrJNECpr2bBA+Pk+f9+3"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-yrJNECpr2bBA+Pk+f9+3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-09-30 at 13:05 +0000, Markus Probst wrote:
> The abstraction is used by
> https://lore.kernel.org/rust-for-linux/20260724-synology_microp_initial-v=
18-0-fb2f49f10e77@posteo.de/
> .
>=20
> The following changes were made:
> * add basic led classdev abstractions to register and unregister leds
>=20
> * add basic led classdev abstractions to register and unregister
>   multicolor leds
>=20
> Changes since v25:
> * fix issues reported by Sashiko:
>   * fix vertical import
> * add drivers/leds/*.rs to MAINTAINERS file (Kari)
> * s/add/Add/ in commit message
>=20
> Changes since v24:
> * remove `LedOps::Bus` (Gary)
> * support type-erased `Device` and `MultiColorDevice` types (Gary)
> * use `Device` and `MultiColorDevice` as arbitrary self types in
>   callbacks. Remove separate `classdev` argument (Gary)
> * remove unnecessary imports in doc example
>=20
> Changes since v23:
> * add separate patch for MAINTAINERS file update
>=20
> Changes since v22:
> * readded CStrExt import, because it is imported with `as _` in prelude.
>   A `# CONFIG_RUST is not set` sneaked into my .config while
>   development, so the compile error was unnoticed.
>=20
> Changes since v21:
> * use 'init for lifetime that is only alive during initialization
> * remove unnecessary CStrExt import
>=20
> Changes since v20:
> * resolve Sashiko regressions:
>   * fix typo
>   * fix fwnode refcount decremented too early
>=20
> Changes since v19:
> * rebase on v7.2-rc1:
>   * Add `max_intensity` to `MultiColorSubLed`
> * use safer `KBox::pin_slice` instead of `KVec`
>   (len might not equal capacity)
> * explicitly call `FwNode::dec_ref` instead of dropping a reconstructed
>   `ARef<FwNode>`.
> * remove direct access to `intensity` and `brightness` fields,
>   which may get mutated concurrently by the C side
> * fix safety comments pointing to functions from previous revisions
>=20
> Changes since v18:
> * add inlines
> * fix invalid documentation
> * improve led color duplicate checking
>=20
> Changes since v17:
> * use lifetimes instead of Devres
>=20
> Changes since v16:
> * use for loops for duplicate checking
>=20
> Changes since v15:
> * fix issues reported by Sashiko bot:
>   * fix returning error not possible on `brightness_get` callback
>=20
> Changes since v14:
> * fix issues reported by Sashiko bot:
>   * add missing inlines
>   * add missing Sync trait bound
>   * fix vertical import layout for public export of private types
>   * fix potential memory leak, if a multicolor led device with over
>     `u32::MAX` subleds is registered
> * remove default_trigger option
> * fix missing CAST doc
>=20
> Changes since v13:
> * rebased onto v7.1-rc1
>=20
> Changes since v12:
> * add `led::DeviceBuilder::name()` and `DeviceBuilderState'
> * add `led::Color::as_c_str`
>=20
> Changes since v11:
> * use `led::DeviceBuilder` instead of `led::InitData`
> * use static_assert instead of const { assert!(...) }
> * restructured patches to avoid moving `led::Device` from
>   rust/kernel/led.rs to rust/kernel/led/normal.rs in the 2. patch
>=20
> Changes since v10:
> * allow in-place initialization of `LedOps`
> * run rustfmt for code inside `try_pin_init!`
>=20
> Changes since v9:
> * add missing periods in documentation
> * duplicate `led::Device` and `led::Adapter` instead of using a complex
>   trait
> * fix imports not using prelude
> * adapt to CStr change
> * documented `led::Color::Multi` and `led::Color::Rgb`
>=20
> Changes since v8:
> * accept `Option<ARef<Fwnode>>` in `led::InitData::fwnode()`
> * make functions in `MultiColorSubLed` const
> * drop the "rust: Add trait to convert a device reference to a bus
>   device reference" patch, as it has been picked into driver-core
>=20
> Changes since v7:
> * adjusted import style
> * added classdev parameter to callback functions in `LedOps`
> * implement `led::Color`
> * extend `led::InitData` with
>   - initial_brightness
>   - default_trigger
>   - default_color
> * split generic and normal led classdev abstractions up (see patch 3/4)
> * add multicolor led class device abstractions (see patch 4/4)
> * added MAINTAINERS entry
>=20
> Changes since v6:
> * fixed typos
> * improved documentation
>=20
> Changes since v5:
> * rename `IntoBusDevice` trait into `AsBusDevice`
> * fix documentation about `LedOps::BLOCKING`
> * removed dependency on i2c bindings
> * added `AsBusDevice` implementation for `platform::Device`
> * removed `device::Device` fallback implementation
> * document that `AsBusDevice` must not be used by drivers and is
>   intended for bus and class device abstractions only.
>=20
> Changes since v4:
> * add abstraction to convert a device reference to a bus device
>   reference
> * require the bus device as parent device and provide it in class device
>   callbacks
> * remove Pin<Vec<_>> abstraction (as not relevant for the led
>   abstractions)
> * fixed formatting in `led::Device::new`
> * fixed `LedOps::BLOCKING` did the inverse effect
>=20
> Changes since v3:
> * fixed kunit tests failing because of example in documentation
>=20
> Changes since v2:
> * return `Devres` on `led::Device` creation
> * replace KBox<T> with T in struct definition
> * increment and decrement reference-count of fwnode
> * make a device parent mandatory for led classdev creation
> * rename `led::Handler` to `led::LedOps`
> * add optional `brightness_get` function to `led::LedOps`
> * use `#[vtable]` instead of `const BLINK: bool`
> * use `Opaque::cast_from` instead of casting a pointer
> * improve documentation
> * improve support for older rust versions
> * use `&Device<Bound>` for parent
>=20
> Changes since v1:
> * fixed typos noticed by Onur =C3=96zkan
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
> Markus Probst (4):
>       rust: leds: Add basic led classdev abstractions
>       rust: leds: Add Mode trait
>       rust: leds: Add multicolor classdev abstractions
>       MAINTAINERS: rust: leds: Add rust abstraction entry
>=20
>  MAINTAINERS                     |   9 +
>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/led.rs              | 317 ++++++++++++++++++++++++++++
>  rust/kernel/led/multicolor.rs   | 445 ++++++++++++++++++++++++++++++++++=
++++++
>  rust/kernel/led/normal.rs       | 230 +++++++++++++++++++++
>  rust/kernel/lib.rs              |   1 +
>  6 files changed, 1003 insertions(+)
> ---
> base-commit: 5a956dde5526a634dca7ccad27c051ebcc306089
> change-id: 20251114-rust_leds-a959f7c2f7f9

Today is the 1st Year Anniversary of this patch series.

That's a fairly long time.
I hope it gets merged before there is a 2nd one.

Thanks
- Markus Probst



--=-yrJNECpr2bBA+Pk+f9+3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmrHfzwbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPS0YoP/0sawsXX+ilKVdvoOCK5
LNeTE1zcH0nj8Ye/fn3AhVarxycbG7IXo6jsqzRwYgtZmRg9GQkokFwUnePOx1zr
jxay9LhoQ2Wqq0c/LppNPDcKycB56D2n8w9utGH9+ZQ+z7rPE6uRuMaKrVmHWaAA
6rn+ejJZGd4502p0npjaNNtwgC3/1v5BVphIBD8p73UTe3LZOqbMp80VA2Ac04p6
aKSfxs3Y8+mAnjp6J+xbHjiMDaDRMyqV2ZCPGR7+rguWDUhWSJCsJbJsIGach8Z8
6PiD01CduIFfX38x4NGBDQOGiPmVYErJ5VAddaepj4/GSrJmACUK3D3os7768ASR
asGK5pUSey9fu+UkFKRUeSu/Ts99PVuEVisG9YD1eIbiFu28JFN1VYJHC7CHaBHW
n6T8TNmiU+qceTnebDu8/F1UbY5qrMrggpo+Sf7QqFgR95aXlsDAIqG8a5aNTi4G
RXy59bGg1uDu680C9NjZYEemJUXGGZXrcl9zsYHHB/3w6sgCNmOA02R/TA5Trb84
uAENaanPaSYSy9TqGcGpBU6AM2jQWQO3Dt/KIVC5bKKeTzTyq/cKsGfixFHr38C3
9v2CGsOzwUfK6V0Pa+9PfuxNV198bHlv21wdIDPxJCkR4Qa+Y2ugIV5mJLsrQWq5
Ap7Nba0S5i9v/FJTFykqhrE2
=uWp8
-----END PGP SIGNATURE-----

--=-yrJNECpr2bBA+Pk+f9+3--
