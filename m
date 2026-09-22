Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6ED568555
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790094571; cv=none; b=h/OUH+fmhHad2N/uFoepsVU3uS27VLYiXyvZJXioTuN8E/KUzyPI6wUYzV8b1ZTd0HRgmkApEcvGGID62xGXbtMDS1408FA50gIoHhE5PNRaYw7cBWFBuqXBVozcOr/om24xIEZCuz75JPWMuhgErG7ygqwBTEmPxRy9quG4F0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790094571; c=relaxed/simple;
	bh=VB3WnbRvt2J9LKmcdb7uv8dSEpH5QKJ7IXLu9KgM7d8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tEbCizAA6vQ4vEwHkW8pwai/q4fIgRsFYTKQUn4csC9u2ePU+cynhxCeaBvwPl4KZ8rqCM1h6fHgcjbciagNzxDIIb+RwzNCXlD42R9TknGlT7Jms9NrF41324/58BS4R3SGKAbAjGw6zYVjNLg3dVfab3RSS52SUet9WCncPHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=cvSvI+SE; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="cvSvI+SE"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id C83E5240027
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 18:29:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1790094561;
	bh=VB3WnbRvt2J9LKmcdb7uv8dSEpH5QKJ7IXLu9KgM7d8=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=cvSvI+SE1xWq0cMXMfLUtoI0wSf1mGoXpE5fgwj9mmB/2kTtcRsktOrS7zgntEygI
	 ot/bmwlshR+guiXMZep1kfPnMUmXAP9skW+yXgrOFi8fTBgpdZ4mlsmVPSIUwkWhy1
	 WhLf0RRoC1A39IDvhRYg54RnN5ndQDO3546qdTqyiBADv4YyNIM02iE0rJD22wpfpd
	 ybWgUWtMupLLvUWuVvzH8cYbAzsOjg1FWNMHJGRarsKSam0yNHTjxWTBMe7A8ovWs1
	 JFPLzE2plZUe0TPapxmajzoLKyFhvBj40sk31fFbCOjZ/8RfZm1uokZ8z1PszQ6Hep
	 0wdZovSOmoKKA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hq5CK5Y70z6txf;
	Tue, 22 Sep 2026 18:29:17 +0200 (CEST)
Message-ID: <0b51e27e1b2e16ac5bf5776c7c1704ca90857ec5.camel@posteo.de>
Subject: To Lee, Pavel: Re: [PATCH v25 0/4] rust: leds: add led classdev
 abstractions
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
Date: Tue, 22 Sep 2026 16:29:20 +0000
In-Reply-To: <20260913-rust_leds-v25-0-1a10371d78c3@posteo.de>
References: <20260913-rust_leds-v25-0-1a10371d78c3@posteo.de>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-hrTAX/W6mLo7sKDNm8zH"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-hrTAX/W6mLo7sKDNm8zH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

@Lee, @Pavel:

Hi,

This message has already been posted once [1] and no reply has been
sent. So I added your names to the subject line, so this message will
hopefully make a difference.

--- The contents of the original message:

Regarding the leds rust abstraction patch series.

Lee already mentioned he will take Rust patches into his tree if
"quality Rust-specific Reviewed-by" trailers are present [2].
Will this also apply for any subsequent patches (e.g. bug fixes)?

Secondly, there hasn't been a comment on me taking the maintainer role
for the Rust abstraction yet. If thats fine with you, I kindly ask you
to ACK the patch adding the MAINTAINERS file entry [3].

I was told there have been cases in the past of maintainers leaving the
kernel directly after code has been merged. To take away any fears that
might exist, I can assure you I will take care of the Rust code.

If there is a patch with breaking API changes on the C side, simply add
me to Cc and I will fix the Rust side.

The missing ACK on the patch adding the MAINTAINERS file entry [3] and
the missing Reviewed-By Rust trailers should be the only blockers of
this patch series.

Thanks
- Markus Probst

[1]
https://lore.kernel.org/rust-for-linux/6c57e08a5f4aa9096711d14d82ece19fb68c=
893f.camel@posteo.de/

[2]
https://lore.kernel.org/linux-leds/20251110134058.GC1949330@google.com/

[3]
https://lore.kernel.org/linux-leds/20260903-rust_leds-v24-4-8d9e4c04db69@po=
steo.de/

--=-hrTAX/W6mLo7sKDNm8zH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqyrNQbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSJa4P/3iq5hDp/fMSRneXBm4/
Qt2omZIzS+m3e8Ds4MkTm+g8+38aL/JArAnGSdxrhiGqkzcP2QPr4B5pN+uhlnHU
guCBb0ifat9OXljaBitpPOUIlgt/YAhLJIedLJtVAh8Roc0Byz2dDMc0E14ZfGNC
7DKxSycz7qr7Rm6C0c2emM2wqlpS1i2ouYbALkgcCbF6BoqTcMxTP/8QcdksnrpI
VUuDV6y1rZbPuxzEsacwf2UWWlqp6ZsqEDlbmT8V8QZbv/DVl9n+Uz24iXzU6Ks7
N6vP5ZLAJniDBBRSj2jeIGIvCg+itBSjWtYarVE/iUxkrLtaRMUTtCUytYNNkTkp
FMwXSn9XrMdSSprl8EUlddyvWZXJeiry3qCc3QaAEBugpjUAQJYXQRqS2Qfk+TC+
5jzizYQ7F+KFZzTcHD1JzqoXujJfK4eZTxCmBk4sBgcrTX9iMekuaVqHPSUFIpNu
cdmm0lbkEG92P4RFXyuD3ZbSIIgVYPDzgWYH1C9hFzf+mP6TtpkHGindygzGvhmg
FVL73qxVTXoph2uaGEZdGAZbhQAnoZxCm5jjjWAfAgpDZRSLL8RPdnIvmSNICxcR
N7uG28EeJ2Kn7qt5DGKuzLNcIU/1sOrhcqhADiLBb8qWU1vMCR6AEwRQzc59t1OO
cZ7EcoHIvs8V7Fe9hCFLYZN+
=JywU
-----END PGP SIGNATURE-----

--=-hrTAX/W6mLo7sKDNm8zH--
