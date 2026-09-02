Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522B7368D4A
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 23:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788392137; cv=none; b=mQpNuVGYzxC6eVnGVIm/2HsRQ2KhCHt3hvdJwwdY6g74n2DBqWgOb0HBkKezlVor+0tjQ+OpvekafE2CYXPmUSlcRUtLMeftXJJqAGYZ+85hPF8BVoIU4hd+5xLjQ76pTx4g0ZOf82LMip5ncV0ibNS8yLrSMGh/GyoUsy8W9ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788392137; c=relaxed/simple;
	bh=k7GfVBlRb5bcgQ9UooQpUkhXfI+GUfPy4e0VTkhwWbc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=htRn7JNW0OmtTnqh6Hj8oiNpm8wIE9cpSirF5hSWIK2nD2BksU0HNxsXoxchSD9Lyz/DzHmaKPu95eddEz5Oz4fOVD0+gSsgt/ZBSJm/8ju5CR0hiiw8FEcvqM19t8HbiJ6yEgV81bRNjtd+01NOmjYnfcyF3+Hw3lzNnF5L8h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=YXEiw460; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="YXEiw460"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 553C1240107
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 01:35:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788392130;
	bh=k7GfVBlRb5bcgQ9UooQpUkhXfI+GUfPy4e0VTkhwWbc=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=YXEiw460Aoed4qTIiS0ck9JTaICCtHZWSAULPOgNLnRiiyifMxrSIs1PFKEBi1Wgv
	 e64LLAC9WTLa5RtDbuYMOxHhAR5MkH/WrYoO2erdkgNxjkTmDhjMNql4e2q/GBgPC3
	 C3jaS0jl97iANrw4y0UeUDk3Ti6c71vkltnYi9FYO+/jT7K2QT17MCmM/rLMy4o05w
	 jkau0Vlbj6x+3+PPVwpYcwfijOWn3WpUK2Ioi0Qpm8uvA0ZaHgn2kUMjHeg8XTzs+3
	 5FpPGpYifo5ma8Cn0Bp+Ktlvji29Wghke8l2Bhsk3lwLAse6k2dFvP7aONa4a7mjpo
	 FRG0SE7FnUypw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hZzcG5WPSz6tsb;
	Thu,  3 Sep 2026 01:35:26 +0200 (CEST)
Message-ID: <6c57e08a5f4aa9096711d14d82ece19fb68c893f.camel@posteo.de>
Subject: Re: [PATCH v24 0/4] rust: leds: add led classdev abstractions
From: Markus Probst <markus.probst@posteo.de>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman	
 <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, Miguel Ojeda
	 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo	
 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 "Rafael J. Wysocki"	 <rafael@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	
 <kwilczynski@kernel.org>, Boqun Feng <boqun@kernel.org>, Daniel Almeida	
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=
 <work@onurozkan.dev>, Ira Weiny	 <iweiny@kernel.org>,
 rust-for-linux@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 02 Sep 2026 23:35:29 +0000
In-Reply-To: <20260903-rust_leds-v24-0-8d9e4c04db69@posteo.de>
References: <20260903-rust_leds-v24-0-8d9e4c04db69@posteo.de>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-t8sgIOQhMX0s1O7FUGUm"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-t8sgIOQhMX0s1O7FUGUm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


@Lee, @Pavel:

Hi,

Regarding the leds rust abstraction patch series.

Lee already mentioned he will take Rust patches into his tree if
"quality Rust-specific Reviewed-by" trailers are present [1].
Will this also apply for any subsequent patches (e.g. bug fixes)?

Secondly, there hasn't been a comment on me taking the maintainer role
for the Rust abstraction yet. If thats fine with you, I kindly ask you
to ACK the patch adding the MAINTAINERS file entry [2].

I was told there have been cases in the past of maintainers leaving the
kernel directly after code has been merged. To take away any fears that
might exist, I can assure you I will take care of the Rust code.

If there is a patch with breaking API changes on the C side, simply add
me to Cc and I will fix the Rust side.

The missing ACK on the patch adding the MAINTAINERS file entry [2] and
the missing Reviewed-By Rust trailers should be the only blockers of
this patch series.

Thanks
- Markus Probst

[1]
https://lore.kernel.org/linux-leds/20251110134058.GC1949330@google.com/

[2]
https://lore.kernel.org/linux-leds/20260903-rust_leds-v24-4-8d9e4c04db69@po=
steo.de/

--=-t8sgIOQhMX0s1O7FUGUm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqYsqUbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSqHkP/j1kDahD+bNy7zGi5bmk
SwUCP3ax+M+wDLyPKgwJzttQDnoG4SRRAJ1/A4oXODqgU4xWJmo6NrzvW892+uwC
hjqySEvrFtHiDK2HmjmkomEqm3dsvbACt8pN2mjKo3GT/6Oemr2Ty2TahpYxyU0x
hcUdGYsJXXIErP9PDVZVqaBUuP9YlqnI2e7qZzOfMvVk2bTa7A1mm+JprpRgA1fZ
bgmu3Gfnnv93snsYM7fCs/bfT8eFkRDJxk6FGLX86Wb2dNPV3h7lvfY/nmdBD4Lh
6a/XbhoQbAU6JPbaES62NymOr/pBR/CF5BOOuJub+t8cphxVOlUgv5XVuT3pxDcJ
PxmY5mLgDNfzJpB6U5ig0N8m1lg07TYbk568EbVmf0qfznmAdsshiFD0Wlay9mv1
y0VxgzAreKx05v4gGTIyAMSXfLMouCVWUoQ6Q3S3vjGmoJiCe720ZfE/iEFYrK7k
1ttAKeCCoEA1yII6EeMTpo2ML8dfyk7TOn5b1R3IJOM2woPsdjOzZGsAsTQ2dPtw
8wtMPIZQujXLwdpBSoOLo1nHYdX97HgeVhHoCksW6DHx1SIjj3xMJY6wRY8Y5uY6
mDAwb6tWsgC589yCFCn/seDy29JxjokKurmCf3eSff4JUqCWkqVTx9ob7WKNQbLk
G1lLV7NUD+0ilfz0PXXsyyKD
=qODc
-----END PGP SIGNATURE-----

--=-t8sgIOQhMX0s1O7FUGUm--
