Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773974C8476
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421005; cv=none; b=Zs05VCn9ZgB2lTJ09Gtr9nR7lePREBee0E8D+BdO4XzEDVNfEKbnzGL4SVL+uJmLQxys2NyW60srHyv43pSpljqtexHbKFdN4n3p4fenN+4YVi/7eG+TNj9f4Yg+p60DbT3uyWExVdNFoB+1Pt8o1NhwErRwOit90Ze/NHjdhqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421005; c=relaxed/simple;
	bh=XuAQhT27dgprpauQebxMnfPyIPPrLN2DLmbOYs4sxMM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XD1SKza7bDywZrGOroSXpz577Z1Sr40EvnEyvJvW2BV820I3Ye3LMlHszNfoekUegZhCtWfV5RF0lPoo5CWAbxzDyWm3F2fxF332uTk2xnd8EP2NZ2Bct61Jec5VVKaWU05yMJYzyJZg/TwTuUIyDM2W9aKDjf/hsrYLk68NTgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=A1JgaV+p; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="A1JgaV+p"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 853F8240027
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 16:43:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792421001;
	bh=2A9eKbg05P4THItmcWKEQ8pJe/MMiQmJQ/gzVrOiOr0=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=A1JgaV+pbA7bHR4eTlkJ67mo2FC+m1Cc4YeL4D2EvKsCpXcPI0J5dzDi1TJBrHR4q
	 jUflazlzNM/twoPr+mT8jfJWft6d0Uv26esg9lb1AhFbMrA5fQ05tq+E9tHrK/+cpB
	 rbwDPRjnJ9/DZ4TikRVsrv1h8R1YSpfOQf+AbHC8OiED+jRN5Fo3z5s04n3XWsOyIg
	 M55n/rBrbdcHAkV6sNHkMMdzhylWdPqZ1oN9vrfbDTuxKEaDKFwYBviX03JZbIyHGV
	 rVH7i2lLx6NPTWgabhrClQRy7xyFFI8esW/fadVIjxQEZAriYI1AHHiSrrQjbL+AXp
	 v2bzsxD7NCfgA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j7dZX73D3z6twP;
	Mon, 19 Oct 2026 16:43:16 +0200 (CEST)
Message-ID: <236149b4c90323f412d6385c034a78908013e2d7.camel@posteo.de>
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
Date: Mon, 19 Oct 2026 14:43:20 +0000
In-Reply-To: <20261019143818.GC2663669@google.com>
References: <20261016-rust_leds-v27-0-2c296d8a8e5b@posteo.de>
	 <20261016-rust_leds-v27-4-2c296d8a8e5b@posteo.de>
	 <20261019143818.GC2663669@google.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-wqZHFZr17D4zIZ7eLDSB"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-wqZHFZr17D4zIZ7eLDSB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-10-19 at 15:38 +0100, Lee Jones wrote:
> On Fri, 16 Oct 2026, Markus Probst via B4 Relay wrote:
>=20
> > From: Markus Probst <markus.probst@posteo.de>
> >=20
> > Add self as maintainer.
> >=20
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> >  MAINTAINERS | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f53047aa8d3c..3ae821614cd8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14791,6 +14791,15 @@ F:	drivers/leds/
> >  F:	include/dt-bindings/leds/
> >  F:	include/linux/leds.h
> > =20
> > +LED SUBSYSTEM [RUST]
> > +M:	Markus Probst <markus.probst@posteo.de>
> > +L:	linux-leds@vger.kernel.org
> > +L:	rust-for-linux@vger.kernel.org
> > +S:	Maintained
>=20
> > +F:	drivers/leds/*.rs
>=20
> -ENOENT

Yes, but why is this an issue?
It will catch future rust led drivers.

Thanks
- Markus Probst


>=20
> > +F:	rust/kernel/led.rs
> > +F:	rust/kernel/led/
> > +
> >  LEGO MINDSTORMS EV3
> >  R:	David Lechner <david@lechnology.com>
> >  S:	Maintained
> >=20
> > --=20
> > 2.55.0
> >=20
> >=20

--=-wqZHFZr17D4zIZ7eLDSB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmrWLH8bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSqQ0P/R7964DLgRe1Zmqw1Zxg
TfJ+n3tqPR/oLuObPKwv7DAEcx7KXldajgDyVBsiBcl0jCZ1e0s96ivwDmcyCFvX
Om9/SMrXaK4rN007mLBykWF6mfrTNuJr+cOUkSN5UW6GowPHGY1QxsjnCJ9RV1T0
HdTbk38RaqSpaNCtX/bcmL/UbsZhnOLMxn2Mh9b64UeZyMIObBhlfH9PTHz6DEuY
6ongibq8666j98ue7sVQoCtcBl8+aaQe61iKLP7zM9mm2C9UmITemDs4ryaSGMBa
4oTmd1pBgVrC3E1xXprvM1c1pDauU0P5AjHkWDww5H0N7I9vk/Mvr7q7efj+NOVa
feYTyql1b6xN7f/HzdNDN92zTEw6HbmiI8HT2SHvvIna45vMWUzrWo5kv6QXBvaj
SvJHWFl6fz2redEf0njOkek3JeiyDGKcAfFbA3BspZI6iMMe+zmvXEHI6HSP+JnJ
zZFi8L/6xK/ICesJUP2MFesDOqM6sPexwQBqwThVFPBQLv50yYXzubKbXLpO7KPU
x6VspScAtQ0P+cvsZErV8EMeG9et2VeLo0rzihpO9sHbr78UrVPwpiAb5ALMjv3B
/dbR10T151ERpy32RgnruRUeqvC7UJvPa+U+rYw2jC7y/JIHAx5+e2CzG+AUrHgH
PxTqWDinxpiS2AmrXlEJk/0Q
=bru9
-----END PGP SIGNATURE-----

--=-wqZHFZr17D4zIZ7eLDSB--
