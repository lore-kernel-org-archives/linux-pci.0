Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 14 Feb 2017 20:27:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>,
        torvalds@linux-foundation.org
Cc: kernel list <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: v4.10-rc8 (-rc6) boot regression on Intel desktop, does not boot
 after cold boots, boots after reboot
Message-ID: <20170214192743.GA3869@amd>
References: <20170203190414.GA3701@amd>
 <Pine.LNX.4.44L0.1702031415140.1794-100000@iolanthe.rowland.org>
 <20170203205129.GA3791@amd>
 <20170203211854.GA3697@amd>
 <20170214175956.GA3587@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
In-Reply-To: <20170214175956.GA3587@amd>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2017-02-14 18:59:56, Pavel Machek wrote:
> Hi!
>=20
> > > > > Hmm. I moved keyboard between USB ports, and now 4.10-rc6 no long=
er
> > > > > boots. v4.6 works ok. Let me try with keyboard unplugged... no, I
> > > > > could not get it to work. I believe v4.9 and some v4.10-rc's work=
ed,
> > > > > but I'll have to double check.
> > > >=20
> > > > But all the kernel versions worked when the keyboard was plugged in=
to
> > > > its original USB port?
> > >=20
> > > Aha. So it looks difference is probably in "where is keyboard plugged
> > > in" but in "reboot" vs. "cold boot". I did not do a cold boot in quite
> > > a while :-(.
> > >=20
> > > Booting to grub, then hitting ctrl-alt-del is enough to make it work.=
 Ouch.
> > >=20
> > > It happens with current Linus' tree.
> >=20
> > v4.10-rc6-feb3 : broken
> > v4.9 : ok
> > (v4.6 : ok)
>=20
> Hmm. It hangs during PCI fixups, and it hangs in v4.10-rc8, too.  =20
>=20
> With debug patch below, I get
>=20
> ...1d.7: PCI fixup... pass 2
> ...1d.7: PCI fixup... pass 3
> ...1d.7: PCI fixup... pass 3 done
>=20
> ...followed by hang. So yes, it looks USB related.
>=20
> (Sometimes it hangs with some kind backtrace involving secondary CPU
> startup, unfortunately useful info is off screen at that point).

Forgot to say, 1d.7 is EHCI controller.

00:1d.7 USB controller: Intel Corporation NM10/ICH7 Family USB2 EHCI
Controller (rev 01)

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlijWi8ACgkQMOfwapXb+vI4JQCgl8uaLPSJK+LIH9DNpb6M7ssx
Nm8AnA3r2tQKlwyH0en4XYokKoQSVEXg
=RNt3
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
