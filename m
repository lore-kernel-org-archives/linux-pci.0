Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976D3D5661
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433747; cv=none; b=tpf/AbJHDy7OqYWXkLFXJ8BtJ1CXtfaNOEsEd6W0YcXDMPlPGB74lxz5SeMzANtntGyrMl1wYqkhP96EQxyqaNRrBM/vAWM1WRMQm97yh7UY7uAX45Z7jLd6T7HaV3zN7MRQ7ncRNILw3IZSnIhjaauLlhAqkOnowj+EIZG5fYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433747; c=relaxed/simple;
	bh=XS2aHgm5sUBzDfQIeDhEJ1Eh27j/Cdg/yT6UNDNK1Zo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i2SzFA0VSOggMiSxteUyEHiluul9EvvIkZ27t1whZHmRZWAJcoUF++BH706wp+lhuClLhkrEDxcR2pZQzrIvM+b8OYlJYU9NOpQyzhubxmybdv8vtnzXAKkm6xiUMFjof8hKqwT9/8+LgKDJ8A/TwR7e0Vo0GTVo9l2afPXfBug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Lvy4G9mQ; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Lvy4G9mQ"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4175A240103
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 21:29:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1773433743; bh=Y+CSJSmxjqkcbaW3wd0CmAbzhYWJpcBSr+yGN8onFgE=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=Lvy4G9mQhXR3mx3S16dx0FzYZ0mvlPiZrnPAme+QFRkfjWSZgVj2DoZEWycRuMQYd
	 7oEJ6+VMpM7iUmM/jHPN9S4TpkOwQmUqU3f+AvGpCYhrwOWhKPCDlO9gnPvlSq9aEl
	 rLJ4pi1KvsNKusYoqbQrG8tN2oFG4WnJz2NMDpJV3mZUFkIk28xno4gKFaHgNhu/8n
	 Trcn6tv6L70fg0mOxuvKynZ/aqXdWQsKb1D7k+n2etK2U2oE3ogZckMgljxrMUK65W
	 pW3DKlTDpO0/VnVk4wB/yNRs8Ca60jekzIebtwTBcyVDLmmf+8CiId/ciyM+LqDYMU
	 y0KX92ebFhn6A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fXbfz6HX8z6tsf;
	Fri, 13 Mar 2026 21:28:59 +0100 (CET)
Message-ID: <6f2298f3298dc81e6e2ed34ca43424fc39ce3518.camel@posteo.de>
Subject: Re: [PATCH v3 5/7] dt-bindings: mfd: Add synology,microp device
From: Markus Probst <markus.probst@posteo.de>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron	 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, "Rafael J. Wysocki"	 <rafael@kernel.org>, Igor Korotin
 <igor.korotin.linux@gmail.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	 <kwilczynski@kernel.org>, Pavel
 Machek <pavel@kernel.org>, Len Brown	 <lenb@kernel.org>, Robert Moore
 <robert.moore@intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Date: Fri, 13 Mar 2026 20:29:01 +0000
In-Reply-To: <02e0772d-ba65-4eb8-8453-e0b3eaa4af96@kernel.org>
References: <20260313-synology_microp_initial-v3-0-ad6ac463a201@posteo.de>
	 <20260313-synology_microp_initial-v3-5-ad6ac463a201@posteo.de>
	 <02e0772d-ba65-4eb8-8453-e0b3eaa4af96@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-b8ECSF0SkKDa7tfzL8rb"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-b8ECSF0SkKDa7tfzL8rb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-03-13 at 20:37 +0100, Krzysztof Kozlowski wrote:
> On 13/03/2026 20:03, Markus Probst via B4 Relay wrote:
> > From: Markus Probst <markus.probst@posteo.de>
> >=20
> > Add the Synology Microp devicetree bindings. Those devices are
> > microcontrollers found on Synology NAS devices. They are connected to a
> > serial port on the host device.
> >=20
> > Those devices are used to control certain LEDs, fan speeds, a beeper, t=
o
> > handle buttons, fan failures and to properly shutdown and reboot the
> > device.
> >=20
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
>=20
> You keep sending the same without responding to review.
>=20
> NAK
All review comments have been resolved to my knowledge, but here a
formal reply to all of them.

> A nit, subject: drop second/last, redundant "binding for". The
> "dt-bindings" prefix is already stating that these are bindings.
Has been removed from the patch subject.

> > +description: |
> Do not need '|' unless you need to preserve formatting.
It got removed in v2.
In the current patch revision v3, it is needed because it has ":" in
the description (to ensure it does not get interpreted as property).
Thus it has been readded.

> > +properties:
> > +  compatible:
> > +    enum:
> > +      - synology,microp
> Missing blank line. Look at other bindings how to write one.
Blank line has been added.

> > +  power-led:
> > +    $ref: /schemas/leds/common.yaml
> > +    unevaluatedProperties: false
> > +  status-led:
> > +    $ref: /schemas/leds/common.yaml
> > +    unevaluatedProperties: false
> > +  alert-led:
> > +    $ref: /schemas/leds/common.yaml
> > +    unevaluatedProperties: false
> > +  usb-led:
> > +    $ref: /schemas/leds/common.yaml
> > +    unevaluatedProperties: false
> That's pretty unreadable code.
>
> ... and could be simpler with patternProperties and regex
It has been minified using patternProperties.

> > +  no-check-fan:
> Vendor prefix

> > +    type: boolean
> > +    description: |
> > +      Disable fan failure check.
>
> You described the desired Linux feature or behavior, not the actual
> hardware. The bindings are about the latter, so instead you need to
> rephrase the property and its description to match actual hardware
> capabilities/features/configuration etc.

> > +
> > +      The fan failure event is triggered on the device, even if
the fan
> > +      has been intentionally set to a low speed. This property
prevents a
> > +      hardware protection shutdown if a fan failure event is
reported.
> > +  no-check-cpu-fan:
>
> You described the desired Linux feature or behavior, not the actual
> hardware. The bindings are about the latter, so instead you need to
> rephrase the property and its description to match actual hardware
> capabilities/features/configuration etc.
The 2 properties have been removed entirely. Thus those comments are
not relevant anymore.

> > +    uart {
>
> Drop, unuesed
Has been dropped.

> > +      microp {

> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
>
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetr=
ee-basics.html#generic-names-recommendation
> If you cannot find a name matching your device, please check in
kernel
> sources for similar cases or you can grow the spec (via pull request
to
> DT spec repo).
node name has been changed to mcu.

> You we have tools which save you review time. Most important, save
> maintainers/reviewers time from giving feedback on obvious mistakes.
> You
> must use these tools, otherwise maintainers get grumpy by wasting
their
> time.

> Please run scripts/checkpatch.pl on the patches and fix reported
> warnings. After that, run also 'scripts/checkpatch.pl --strict' on
the
> patches and (probably) fix more warnings. Some warnings can be
ignored,
> especially from --strict run, but the code here looks like it needs a
> fix. Feel free to get in touch if the warning is not clear.
with the exception of
- help paragraph having less than 4 lines in Kconfig (not necessary in
this case)
- of_device_id not being const (it has to be)
- "added, moved or deleted file(s), does MAINTAINERS need updating?"
(file will be added in a following patch)
there are no warnings left.

> This is not an "MFD" device.
It now uses the MFD APIs. By the definiton of @Lee (assuming I
understood it correctly), this device should now qualify as "MFD"
device.

> > +
> > +    mcu {
>
> Please read previous comments.

You are likly trying to refer to this comment from you:
> Depending what this is. MCU is generic purpose unit where you load
your
> different FW for different purposes and you have here specific - to
> handle certain aspects of this entire machine. This looks like EC, so
> should be called embedded-controller and placed in that directory.
Synology uses Microchip PIC for this purpose. On a Synology DS215j, it
uses a "Microchip PIC16F1829". At least to me, this looks like a
general purpose microcontroller with firmware from synology flashed
onto it. Therefore it is a MCU.

If I did miss any relevant comments, let me know.
(Replies on replies on review comments have not been included here).

>=20
> Best regards,
> Krzysztof

Thanks
- Markus Probst

--=-b8ECSF0SkKDa7tfzL8rb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmm0c30bFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEDR2H/jnrUPSyREP/3+/Ri5V9Cq/3P1ORKA6
yVucNv6MQqstNnFoH/jhsPRNSqFgzVwe7TYPnZ06ZkJ7qhAnNFJ03ZcrYPcV7hUD
AQ0/oUOIsQbJffOgKnN4zTs9YBoRT7wJT/Z+FbWtXbUt/q41s6blyIRphwxu5aqo
nAbrTsll6Q6Pddd8/pIwFst0925pNW1bEjWFPlgkx1Srtk3DVWdXuV4czP830TLK
7zKOBO45koOv8GBDELjTHu4EVBxzTXJewNYaIPqXBCe48AIQMEfoYv0ePhxevyx6
VzTv94E2angFvxbOVQvD5+QJAEnhNKoAMGLCoEWla9jh8nO63m31INElYlDz7kMe
WkklT05+O9bImXJ8a5Q2LzFFHgJpTUlTCdgvh6bB0Zri6XLEC4MAoggoAlC6qOjA
7eSTEb38Sc2Az7427Z7QUsPLm2LCm+i6UmVIN3ytybf58kvc6nyp2EbDvGXraVKh
9jm29Y7Rg3GzRgfnZp1coSf0GQ28zNOtrnJHKXXYuXg1/pan+8PQbNtuPPoIPs3y
gjwYKXjM+aaL1WIrquCnehgOSsP2tXMXwaXaMH1lwJqKwpOxm6wvlZWS6vtGSkNg
ZGDZTjV4tDlt+sC3M2Zuu+786zSYPjMCN9jontNQ5/Kbepd2m7vYZrS2beEI6rfN
ZSuINDibpIYoF79wdT6AFyZ9
=sCIA
-----END PGP SIGNATURE-----

--=-b8ECSF0SkKDa7tfzL8rb--
