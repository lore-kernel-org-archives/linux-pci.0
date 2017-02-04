Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57792 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753785AbdBDIs7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Feb 2017 03:48:59 -0500
Date: Sat, 4 Feb 2017 09:48:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: pavel@ucw.cz
Cc: kernel list <linux-kernel@vger.kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org
Subject: Re: v4.10-rc6 boot regression on Intel desktop, does not boot after
 cold boots, boots after reboot
Message-ID: <20170204084856.GA32381@amd>
References: <20170203211854.GA3697@amd>
 <Pine.LNX.4.44L0.1702031658100.1794-100000@iolanthe.rowland.org>
 <20170203224309.GA22118@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
In-Reply-To: <20170203224309.GA22118@amd>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Fri 2017-02-03 23:43:09, Pavel Machek wrote:
> On Fri 2017-02-03 16:59:05, Alan Stern wrote:
> > On Fri, 3 Feb 2017, Pavel Machek wrote:
> >=20
> > > Hi!
> > >=20
> > > > > > Hmm. I moved keyboard between USB ports, and now 4.10-rc6 no lo=
nger
> > > > > > boots. v4.6 works ok. Let me try with keyboard unplugged... no,=
 I
> > > > > > could not get it to work. I believe v4.9 and some v4.10-rc's wo=
rked,
> > > > > > but I'll have to double check.
> > > > >=20
> > > > > But all the kernel versions worked when the keyboard was plugged =
into
> > > > > its original USB port?
> > > >=20
> > > > Aha. So it looks difference is probably in "where is keyboard plugg=
ed
> > > > in" but in "reboot" vs. "cold boot". I did not do a cold boot in qu=
ite
> > > > a while :-(.
> > > >=20
> > > > Booting to grub, then hitting ctrl-alt-del is enough to make it wor=
k. Ouch.
> > > >=20
> > > > It happens with current Linus' tree.
> > >=20
> > > v4.10-rc6-feb3 : broken
> > > v4.9 : ok
> > > (v4.6 : ok)
> >=20
> > All I can suggest is git bisect.  :-(  But I agree that the problem is=
=20
> > unlikely to be in the USB layer.
>=20
> Yep. I'm hoping PCI people speak up.... adding printks there should be
> possibility, too.
>=20
> (And I guess I should remove you and usb people from the cc-list... in
> the next mails).
>=20
> (I verified it happens with 32bit configuration, too, FWIW).

v4.10-rc1 seems to work.

								Pavel


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliVlXgACgkQMOfwapXb+vIGbgCgrTTog38v1RFejFS4Ta+g4+1n
AcQAn36AZW7Ie5p7LnMOL8G5jBQzKhnr
=Pu6x
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
