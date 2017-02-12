Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56017 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751137AbdBLMAe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Feb 2017 07:00:34 -0500
Date: Sun, 12 Feb 2017 13:00:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org
Subject: Re: v4.10-rc6 boot regression on Intel desktop, does not boot after
 cold boots, boots after reboot
Message-ID: <20170212120031.GA3674@amd>
References: <20170203211854.GA3697@amd>
 <Pine.LNX.4.44L0.1702031658100.1794-100000@iolanthe.rowland.org>
 <20170203224309.GA22118@amd>
 <20170204084856.GA32381@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
In-Reply-To: <20170204084856.GA32381@amd>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > > Aha. So it looks difference is probably in "where is keyboard plu=
gged
> > > > > in" but in "reboot" vs. "cold boot". I did not do a cold boot in =
quite
> > > > > a while :-(.
> > > > >=20
> > > > > Booting to grub, then hitting ctrl-alt-del is enough to make it w=
ork. Ouch.
> > > > >=20
> > > > > It happens with current Linus' tree.
> > > >=20
> > > > v4.10-rc6-feb3 : broken
> > > > v4.9 : ok
> > > > (v4.6 : ok)
> > >=20
> > > All I can suggest is git bisect.  :-(  But I agree that the problem i=
s=20
> > > unlikely to be in the USB layer.
> >=20
> > Yep. I'm hoping PCI people speak up.... adding printks there should be
> > possibility, too.
> >=20
> > (And I guess I should remove you and usb people from the cc-list... in
> > the next mails).
> >=20
> > (I verified it happens with 32bit configuration, too, FWIW).
>=20
> v4.10-rc1 seems to work.

No, it is somehow harder to test. It is only problem after some cold
boots.

Today machine was off for few hours, and then v4.10-rc7 failed to
boot. On next reboot, I waited for grub, hit ctrl-alt-del, and it
booted ok.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAligTl8ACgkQMOfwapXb+vLcKACfeO2AfQH7zbLB5cUrJYxkoHZ+
XbIAn1ixJeHrf8yoMq1qrqLaRMM7jAgI
=CoEs
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
