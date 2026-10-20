Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513356;
	b=nTlcpfz+lnpdEBrK7MH/2K5JQQq/0enIry8ad4Z4Tlbpk66JvKh5M/ziWA2AoxEAGRz4
	 s8/KzciNUoJm8MIjD96Imx+gNMXsXroibMWzF92mE3O1Mmy3F9AoX0UcmzMbR4viYNe3X
	 8wAiO36/fcLLSZR5SZQMGewM3pjsYSXgZDete8WLkubU1LFjNpsCfsF8UpLez+7HWi7JF
	 5FqRdeEXmS7N5lf18v1K7hGg0+uJG9R188RmPA96aTeS8KvN9oDENKU7Je9bjL0gp373V
	 5ypTNU5ZZJlwA3RNTPZ59H9snNEPV1Iem0C5nlupz5hVH6fyxX5y4vGlOsfOz1B9R7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513356;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP;
	bh=H/vNvjrtMUqOQt9qQYr+tk8Yq6LHFR9p8potps30VmA=;
	b=uEcVVkXkWYdfe1Fe1sFWAXWA6JWxZltkj2d5xDrT6tgUexMo0Qu3WAz2OoH9igHIHPx4
	 8XWKFEIrzQ+Xy2+mBbKpfov374d51zmWgk9hISEfttdUcsc6gztEbizMmfsRkqiQHxA/y
	 2YjtKr0wfzPY2yUcXN9hcSV16V0X1U+8lPYAUPjEjF+UkOOw6JOXOZQz4UTk7Rl8Is1po
	 jYTQS06KSC1VIOzlHrPvG7svYcRn9/cypAYkFusm+7PgRM9qPDTc37KdDEvVlToV2yv5V
	 mdZS9T0JvLkkMEdI27gHeCKBA+w3EkX5Fce+6lEiiUmfBO0whEkmRf7o2bT3gniRDFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=ZuhLWjjZ;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D6C606A31E
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 16:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1D6C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=ZuhLWjjZ
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C5292240106
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 18:22:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792513353;
	bh=H/vNvjrtMUqOQt9qQYr+tk8Yq6LHFR9p8potps30VmA=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=ZuhLWjjZreDPtCadjSox0Y3JWwlqoyXmsmBA/zXxjBweRfKu85JN7o47RhQsJeQ63
	 okuqBLAJjtyaTfr4mpBOmZh/lStLXfsS8//zrrrBrA0E9svhFvzQ60NDN1CPlVkXcn
	 /pqPbI5zyfdy+chDNkmLckj9WuPVaiTa5lr0rNj2ffyyDvEMbI61CH4POQ64CInwu0
	 kxvc8wzGG+OqridbZ38v3RNogI5HiL6fQUJSSvMyk08q7PPC2r44s+gve6KUFuqtjU
	 4duGaRQcay4xUiUXyU6d0+SL2ur+zux1a2P9UPVKg0P9yQ0bCcLbBonL8qj/9jhWzB
	 kDf0XLLcP/iKg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j8HkT0032z9rxP;
	Tue, 20 Oct 2026 18:22:24 +0200 (CEST)
Message-ID: <14fd9a916dd0792a74ca01ae073e714f95a9c780.camel@posteo.de>
Subject: Re: [PATCH v27 4/4] MAINTAINERS: rust: leds: Add rust abstraction
 entry
From: Markus Probst <markus.probst@posteo.de>
To: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>,  Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Boqun Feng <boqun@kernel.org>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein	 <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=	
 <work@onurozkan.dev>, Ira Weiny <iweiny@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Tue, 20 Oct 2026 16:22:29 +0000
In-Reply-To: <20261019160407.GG2663669@google.com>
References: <20261016-rust_leds-v27-0-2c296d8a8e5b@posteo.de>
	 <20261016-rust_leds-v27-4-2c296d8a8e5b@posteo.de>
	 <20261019143818.GC2663669@google.com>
	 <236149b4c90323f412d6385c034a78908013e2d7.camel@posteo.de>
	 <20261019160407.GG2663669@google.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-RhW9kQSDmlQzQnDLToQh"
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


--=-RhW9kQSDmlQzQnDLToQh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-10-19 at 17:04 +0100, Lee Jones wrote:
> On Mon, 19 Oct 2026, Markus Probst wrote:
>=20
> > On Mon, 2026-10-19 at 15:38 +0100, Lee Jones wrote:
> > > On Fri, 16 Oct 2026, Markus Probst via B4 Relay wrote:
> > >=20
> > > > From: Markus Probst <markus.probst@posteo.de>
> > > >=20
> > > > Add self as maintainer.
> > > >=20
> > > > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > > > ---
> > > >  MAINTAINERS | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >=20
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index f53047aa8d3c..3ae821614cd8 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -14791,6 +14791,15 @@ F:	drivers/leds/
> > > >  F:	include/dt-bindings/leds/
> > > >  F:	include/linux/leds.h
> > > > =20
> > > > +LED SUBSYSTEM [RUST]
> > > > +M:	Markus Probst <markus.probst@posteo.de>
> > > > +L:	linux-leds@vger.kernel.org
> > > > +L:	rust-for-linux@vger.kernel.org
> > > > +S:	Maintained
> > >=20
> > > > +F:	drivers/leds/*.rs
> > >=20
> > > -ENOENT
> >=20
> > Yes, but why is this an issue?
> > It will catch future rust led drivers.
>=20
> Is this where drivers will go then?
Yes.

Rust led drivers go into drivers/leds/ .

>=20
> I assumed the Rust parts would be self contained.
Generally,

drivers/ includes rust drivers. (e.g. drivers/pwm/pwm_th1520.rs)
rust/ is only for the rust abstractions (the layer between the C api
and the rust drivers).

>=20
> No worries either way.  Just setting expectations.

Thanks
- Markus Probst

--=-RhW9kQSDmlQzQnDLToQh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmrXlTsbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSZtAQAJ5ir+O8N0ajOVPE7xyC
6kk7jLTude8WkuAYtiSJEgWw7rGRIZ85hBAKRnQxO+ZwanZlCjONOczc3Z0M+OdK
aQJ//bdwtaDc0rS6JuMcgr5tQl++Phta9f06yP0hZMOKSqIqgz9Hou+xw0lvkxzL
+h2CV8KwUUaVqubA/ayBeh/xtEe7Io1V1g/bInE1qJ4fJRXB89mQ25hE77d9EHOt
AoGFm94WWqentJTGSXBbNK1e/rV1OrGi+Y48i3PoQGwnCgEDqkI/bEU/5nehNmCR
eLfB+Q9qcmlnlo1QIeBg9xyo9nLDKcVyfDIdEvtBFBQWFM9vMyHSu3ztQtBMVWgn
W4BvFeDG7d1Hn2h6mW7TKg4izK/WUdD7w6H+oSGPRcScQv0qx5WSQt1zjXMdzJhj
2CeOuM0q1rSkpdo+AqEdSyvLnFk0RvBGy7KDbMP3D9nYRhOoBzd8u0hsluGSLKaI
0ERNJ8pfcit9JaLxaU0HnPjR/2DhYQ1WmFcz5zftN1CZqxb5LDUD/QtHSIYW7xLA
rZ9qCYwxsgE+SchoNZeYYx25MdxAUV28COkAInlgDs8nEfRkypJFaXE72HHc62gM
s0ZqdxiG/rGp3q7sISX/Ajb2upfTis/DbDydv3vIJx5R7WTaM297u4EWKHqZTCOO
VgGlfzFTJI7PagntrNadkTuH
=Yjx2
-----END PGP SIGNATURE-----

--=-RhW9kQSDmlQzQnDLToQh--
