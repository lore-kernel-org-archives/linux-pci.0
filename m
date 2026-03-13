Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C56375F88
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433950; cv=none; b=jCq4R3peJ/6CNWthgryIoV8BK8/+etTlJ7St5OQYKN2nyIvzNyO4Mh6uU30jP5EC6ndUGeYCCBuNxqXiN4bsdOQ/zczXBdQ02aaxJJiJRumP7/yYpkHVSZgWzU89Rbk9oxEa+PhGqXUhSm2Gj4b4dqHQGp3DPqeh+EjFojzgEjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433950; c=relaxed/simple;
	bh=zUKmnAJJ5iJOiT/3ZJrLs5Hjcv3qUJTQaRNVnFGFl1g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MRTFPRQ77ibx9mUyoof8OVpAhNrk5vym+YEx/X2/rcIxZJ/FXGjjZVF2ww7/XLHuC3Tvj1aG47EUU9/LHX6B5MOdWzu8Ya1vHhmg1zrM67eaiVg/ASUodQ6GOfosRipH08GCUwm39wGVdFCj5YZiK3H++5JfGd+IJNKO83DD+/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=HEQRJ33W; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="HEQRJ33W"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 43DDB240109
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 21:32:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1773433943; bh=zUKmnAJJ5iJOiT/3ZJrLs5Hjcv3qUJTQaRNVnFGFl1g=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=HEQRJ33WdiXIJ14pCtwmwL5LRPdXuKfjQnqbQB7W+RgmHBRvy+gZcSOZ461n6t5yp
	 rWjaCbYH7Z+ZRS0+Oq1iwCLaLydUhxCCuR8+Qxx5SsprYP7tNrtAPogMwAEwEvB7pj
	 Q4JBovRuh9rRxwckSrc223nKDdcgKNsexX+Y9ZpS3e/OGXkzTZ3cSp7HRplNFsOXvj
	 kEoT21qD0EgasU3zySlp5uTyjECUJkhROA9iiiIxTzUznTRmwJgnVp/XE8KYjT9u+C
	 JBwZeJ0Ll8LcTBOQsLrtpRgLZ8BoZLiv9aWIAn4LSmJlk+NH2wGMW8h7yeBi6OIdM2
	 dZAZrImPag5gA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fXbkr3PS9z6twG;
	Fri, 13 Mar 2026 21:32:20 +0100 (CET)
Message-ID: <3fa06cd43d81d9f10f65d2bcec15f67bfffb45a6.camel@posteo.de>
Subject: Re: [PATCH v3 3/7] acpi: add acpi_of_match_device_ids
From: Markus Probst <markus.probst@posteo.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman	 <gregkh@linuxfoundation.org>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng	 <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Igor
 Korotin	 <igor.korotin.linux@gmail.com>, Daniel Almeida
 <daniel.almeida@collabora.com>,  Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Pavel
 Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, Robert Moore
 <robert.moore@intel.com>, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	rust-for-linux@vger.kernel.org,
 driver-core@lists.linux.dev, 	linux-pci@vger.kernel.org,
 linux-leds@vger.kernel.org, 	linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Date: Fri, 13 Mar 2026 20:32:22 +0000
In-Reply-To: <CAJZ5v0hYcSDKid4cbz8ZVZG+vLSHvzPB2UryevEpE15W1w7G3g@mail.gmail.com>
References: <20260313-synology_microp_initial-v3-0-16941debd8a0@posteo.de>
	 <20260313-synology_microp_initial-v3-3-16941debd8a0@posteo.de>
	 <CAJZ5v0hYcSDKid4cbz8ZVZG+vLSHvzPB2UryevEpE15W1w7G3g@mail.gmail.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-new+ZnvpPewWLWV6wMQM"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-new+ZnvpPewWLWV6wMQM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-03-13 at 19:57 +0100, Rafael J. Wysocki wrote:
> On Fri, Mar 13, 2026 at 7:48=E2=80=AFPM Markus Probst <markus.probst@post=
eo.de> wrote:
> >=20
> > Add a function to match acpi devices against of_device_ids. This will b=
e
> > used in the following commit ("mfd: match acpi devices against PRP0001"=
)
> > to match mfd sub-devices against a of compatible string.
>=20
> Not until I can see how this is going to be used.
This is used directly in the following patch. Only half of the patch
series has been sent by b4, because of a limit of my email provider
(which I didn't know existed until now). I am sorry for the
inconvenience.

The patch series has been resent via the b4 relay.
You can take a look at [1] to see how it is used.

[1]
https://lore.kernel.org/rust-for-linux/20260313-synology_microp_initial-v3-=
4-ad6ac463a201@posteo.de/T/#u

Thanks
- Markus Probst

--=-new+ZnvpPewWLWV6wMQM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmm0dFEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEDR2H/jnrUPSpicQAL94zv1vs4Mj1Lj2RK8J
icVNOUN/lVB1j01acPYts0KApvQEPQQkIy3N5TzPUX3NM6iExfLrLTBiH966yJw/
HghJK37YwkvO69r46Mz5QBKzNG/CAWKsN8dvIrQCuKZrlbYBHYBYm5hRqQjIzvkg
ykqFxjgEbypVc5WuJF2YFoN/7+XfUfEqAHxWIXFIX9gCtRNedKar5fxs+OsPqWze
osjdlkRN+7sRpvcEgovulXapCwkZcJizpqiQ+74aWrju4vgyE2xhj4Tgd6OEkSJV
LinZ2DYK2Afb/tm4b+lGOcPgQCXQTLhYPBrPhi+RiotXH0wMOI/fExMir653SY9V
UQW0u2Usd5buuxybUUef/naaZ7AgibDxzGu5DdK7cxndbaq9gCvX9NW4YlAScADX
Quv96acbwB1LI92PHWArdwuj2DGIGG6J/JxXY3y6lZmhTNaMO5EE8D/PfauDL9nS
MC/4kmE8PyC3l7DvFWOg7UB95zIQLPAWI6qHaVUq/sIGEdhBvDN8M/OEyxQuK0+/
D7yFgKOJDG0ETlqThWiyKL5c9n7y9csbzij//AzDdwoPoKsOu2UytAisch/e4Ir6
Vgo2om5ZXc2y2P1S1mVrLK9BBUOcyBYKv2gyjVosDfCd/qfzlFP+nW3TQbW4sm+o
rrX5rRqhN6FwZ7274oP+97aY
=JyG6
-----END PGP SIGNATURE-----

--=-new+ZnvpPewWLWV6wMQM--
