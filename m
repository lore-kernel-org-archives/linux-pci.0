Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64389 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756656Ab2KHTOV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Nov 2012 14:14:21 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so3199325obb.19
        for <linux-pci@vger.kernel.org>; Thu, 08 Nov 2012 11:14:21 -0800 (PST)
Date: Thu, 8 Nov 2012 13:14:09 -0600
From: Linas Vepstas <linasvepstas@gmail.com>
To: linux-pci@vger.kernel.org
Cc: "Pandarathil, Vijaymohan R" <vijaymohan.pandarathil@hp.com>
Subject: PCI error recovery patch [was: Request for feedback]
Message-ID: <20121108191409.GA23458@linas.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Hi Vijay,

I no longer actively maintain the error recovery stack.  However, your patch
and explanation for it looks reasonable to me --- it was certainly never the
intent that a non-capable driver report a successful recovery.=20

I'm guessing that the bug that you are fixing was introduced when the
original pci error recovery code was integrated with AER (PCI-AER was
standardized after the original error recovery system was created, and I did
not really pay very much attention to AER at the time).

FWIW, I guess I could add a=20

Signed-off-by: Linas Vepstas <linasvepstas@gmail.com>

but I'm not sure that really means much any more :-)

-- Linas


On 7 November 2012 21:50, Pandarathil, Vijaymohan R <vijaymohan.pandarathil=
@hp.com> wrote:
> Hi Bjorn/Linas,
>=20
> I got your names from the PCI/PCI-error-recovery maintainers list. I had
> posted the following request last week.
> http://article.gmane.org/gmane.linux.kernel.pci/18465
>=20
> Being a newbie, it would be extremely helpful to get your guidance on
> these changes, specifically on any side effects it has. I am also working
> on another set of patches to improve the PCI error recovery/containment
> capabilities of KVM. But if the above change cannot be made first, I may
> have to figure out alternate approach for the second set of patches.
>=20
> Thanks
>=20
> Vijay

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJQnASBAAoJEOtqpTTgwGUcsa8P/3hGhjzvSHODgNamlyStzfQJ
ZpBtU6UmP/VUa1qi9alkpW5skVTtf1KJjGEVnv6G5jMTEZrfM12z5kyXpCkdStGJ
wJWyzjU1ZeqHzcNaoWL+2kyjjQZHxTwe6VstdMmzaygUUQ9K9WVZhC2gLfncHnUH
vnVAhDjVo/6U+iK9UQ4DwKa44OQ+3kJkCb/hurKxz9oF4BzbWcBO7Uy2gqw/W2Ks
F0r0tsC0g4IRRQFnjNtyXVLBKiR6HME/VrJBURrMLTt3HUqaAxC9z4KMtIhrm9XE
hf4JuaPmcxbnvOezHER+QcMw+n77MsLezCLE0OQ25QBAG20BX8B9/iRFhXRtYsFm
daY2rv9+FpCpzCHGs70vlK+Vhpr//64U+tvAUsXAp4/B8hh0sjYNoR31vhdy0frD
xZSOl6d2SfiZgLZLGmvdEqE+Y8ndXdNIwPWnElSJYETcqiHrwjOH3kKlL0JNLfzW
G3tyKQq0dF3epHMcaYEixBrlxVd42GPcBXUQBrcyrZB6xDBZ3FUDHVzGvAit9Emt
3zzhKak4ha/TLwlA1I9k7kN96taRnFxjBjb7EyRI03tsFL38I0fq1ZHvQTZS3Cw9
tHPxSJoUSY6NY/krQz9ivyGZIFM4zIUYnGgR6K926a1ONbVZTyRdSg+o7jxb0Htk
vj3nJ5EDcXHcV4G/tcqu
=8Oip
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
