Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 3 Feb 2017 22:18:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: v4.10-rc6 boot regression on Intel desktop, does not boot after
 cold boots, boots after reboot
Message-ID: <20170203211854.GA3697@amd>
References: <20170203190414.GA3701@amd>
 <Pine.LNX.4.44L0.1702031415140.1794-100000@iolanthe.rowland.org>
 <20170203205129.GA3791@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
In-Reply-To: <20170203205129.GA3791@amd>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Hmm. I moved keyboard between USB ports, and now 4.10-rc6 no longer
> > > boots. v4.6 works ok. Let me try with keyboard unplugged... no, I
> > > could not get it to work. I believe v4.9 and some v4.10-rc's worked,
> > > but I'll have to double check.
> >=20
> > But all the kernel versions worked when the keyboard was plugged into
> > its original USB port?
>=20
> Aha. So it looks difference is probably in "where is keyboard plugged
> in" but in "reboot" vs. "cold boot". I did not do a cold boot in quite
> a while :-(.
>=20
> Booting to grub, then hitting ctrl-alt-del is enough to make it work. Ouc=
h.
>=20
> It happens with current Linus' tree.

v4.10-rc6-feb3 : broken
v4.9 : ok
(v4.6 : ok)

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliU874ACgkQMOfwapXb+vLWnACffepZZwJuwrFOhn+DM4DMyinb
6b4AnR4Gy9BNFwbpUxZaVZ+OWwKW9C/z
=QZht
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
