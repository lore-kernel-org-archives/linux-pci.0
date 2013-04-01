Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:54546 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752969Ab3DAUUq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 1 Apr 2013 16:20:46 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Martin Mares <mj@ucw.cz>
Subject: Re: [PCIUTILS] Re: [PATCH] update-pciids: fix PCI_COMPRESSED_IDS value when zlib is disabled
Date: Mon, 1 Apr 2013 16:20:55 -0400
Cc: linux-pci@vger.kernel.org
References: <1328025411-8281-1-git-send-email-vapier@gentoo.org> <mj+md-20130401.195202.10741.albireo@ucw.cz>
In-Reply-To: <mj+md-20130401.195202.10741.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1665534.WG5yYqqhdG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201304011620.56252.vapier@gentoo.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--nextPart1665534.WG5yYqqhdG
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 01 April 2013 15:52:28 Martin Mares wrote:
> > If you build with zlib disabled, then PCI_COMPRESSED_IDS is not defined,
> >=20
> > which generates the line in the update script:
> > 	PCI_COMPRESSED_IDS=3D
> >=20
> > which in turn causes the update script to warn:
> > 	bash: [: : integer expression expected
> >=20
> > So default it to 0 to avoid that logic.
>=20
> I hope that this is already fixed in the current tree, could you please
> check?

yeah, i think this commit addressed this in a different way:

commit 4339115006b225c8e33b7427cf5dba6b3831a625
Author: Ville Skytt=E4 <ville.skytta@iki.fi>
Date:   Mon May 21 00:35:19 2012 +0300

    Fix syntax error when PCI_COMPRESSED_IDS is empty.
=2Dmike

--nextPart1665534.WG5yYqqhdG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRWewoAAoJEEFjO5/oN/WB4FYP/2JrAo+xzKGpjZw9VY3fkOok
i7g1eKxex1saqntyAg4FZgh1xxLyEd1THlKOLLqpjGgE5BII1vnWcXgnCGgLkM7E
X8bxWLW2ir1JgS/ab/s8GB+eNQSuWYIpBFH6ZMrnJG+yHw+nlS9Blr+3yK3xLwRC
wczai3lX2I8gSXGG+r7Ro9wArrkP4+bUDWfDiL99VQPFD0K3CU65+s9WZS3dCtiO
yLez9ZCXeMHxHjmFk8sSOcpes2lBGi3GqJ1cM7DMHr3dY8b+Zb/PkmVNjRal+BVv
iEt1r9Qp7KXkhs2aNVndqHjfaZSUMSh/WN9bokumm8uO8MbSVzIe9rBD9Dns4rGk
1yTCT8zyXYYg5YUTDoWmdkcAvAUVQ3ILjcyy3WF5YOo6ThPPqEhgIfaEXMbv7KtL
SLlCefmUYmF9+g/eUBEgpOmD91kJXzEkbOCcGb58mfT7zrOfJhaXFqMjx6ugXaHU
rAtPj+9O1cN4ijhh52CL6fzRtSD3cohcFGeuVQHTMXBoWZhE0V2w1lgiZIMvHnSD
jxmyTuYdKpxLTYvJmP+c48bz3DWJsV2NMqr+9ABLVkHqzqCQG3QochPwtn/kLfFk
SesADPXO2uo6qPGCLnLqUwFaBPE3p1fUoOCevVzCQ3zmmrqdH/kZfeuhQHfT9Ape
Hd8d0SavWsTLdQZBZukU
=HG2o
-----END PGP SIGNATURE-----

--nextPart1665534.WG5yYqqhdG--
