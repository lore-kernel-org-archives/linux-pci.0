Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:31861 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753051Ab2DIKtk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Apr 2012 06:49:40 -0400
Message-ID: <1333968563.5678.19.camel@infinity>
Subject: PCI resources above 4GB
From: Steven Newbury <steve@snewbury.org.uk>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org
Date: Mon, 09 Apr 2012 11:49:23 +0100
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-GR0nh7aZkJFPvz8ZbOn2"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-GR0nh7aZkJFPvz8ZbOn2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

like many users here:=20

https://bugs.launchpad.net/ubuntu/+source/nvidia-graphics-drivers-180/+bug/=
342926

I've hit this bug:
https://bugzilla.kernel.org/show_bug.cgi?id=3D10461

I was wondering whether an option to enable an algorithm which
allocated all 64bit capable devices above 4GB would at least allow
systems where the BIOS has not provided a sufficient PCI hole to
initialise all PCI devices?  I've been digging into the code, but I'm
not yet comfortable to seriously attempt this myself, certainly not
without guidance.

It's a shame TJ seems to have disappeared, it would have been great to
have had a look at his code, I'm sure many of these problems would have
been resolved.

Any help, workarounds, guidance or patches welcome! :)

--=-GR0nh7aZkJFPvz8ZbOn2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAk+CvrMACgkQGcb56gMuC63ZNgCcCApjYqWft7eftL/XqqH2aFSV
19wAoKPbykGpRU8e/a7elgnZfgcjpZmG
=pf3o
-----END PGP SIGNATURE-----

--=-GR0nh7aZkJFPvz8ZbOn2--

