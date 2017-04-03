Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 3 Apr 2017 20:20:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        torvalds@linux-foundation.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: v4.10-rc8 (-rc6) boot regression on Intel desktop, does not boot
 after cold boots, boots after reboot
Message-ID: <20170403182050.GA6555@amd>
References: <20170203190414.GA3701@amd>
 <Pine.LNX.4.44L0.1702031415140.1794-100000@iolanthe.rowland.org>
 <20170203205129.GA3791@amd>
 <20170203211854.GA3697@amd>
 <20170214175956.GA3587@amd>
 <20170214192743.GA3869@amd>
 <20170223162825.GA16646@lerouge>
 <20170223184013.GA5177@amd>
 <20170403153850.GA4418@lerouge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
In-Reply-To: <20170403153850.GA4418@lerouge>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > > > ...1d.7: PCI fixup... pass 2
> > > > > ...1d.7: PCI fixup... pass 3
> > > > > ...1d.7: PCI fixup... pass 3 done
> > > > >=20
> > > > > ...followed by hang. So yes, it looks USB related.
> > > > >=20
> > > > > (Sometimes it hangs with some kind backtrace involving secondary =
CPU
> > > > > startup, unfortunately useful info is off screen at that point).
> > > >=20
> > > > Forgot to say, 1d.7 is EHCI controller.
> > > >=20
> > > > 00:1d.7 USB controller: Intel Corporation NM10/ICH7 Family USB2 EHCI
> > > > Controller (rev 01)
> > >=20
> > > Ok, I should have access soon to a EeePc 1015CX (which seem to have t=
his controller).
> > > I hope I'll be able to reproduce the issue there. If not, I'm sorry b=
ut I'll have to
> > > burden you again :-)
> >=20
> > Go through more mails. It is only reproducible after cold boot. .. so
> > I doubt it will be easy to reproduce on another machine.
> >=20
> > Now... I do have serial port, and I even might have serial cable
> > somewhere, but.... Giving how sensitive it is, it is probably going to
> > go away with console on ttyS...
>=20
> I also tried on an eeepc (which has ICH7/NM10 as well), with your config.
> I even plugged a usb keyboard but even then I have been unable to
> reproduce either :-(

Ok, give me some time. I'm no longer using the affected machine, so no
promises.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljikoEACgkQMOfwapXb+vLFMwCfRDq06rnq8FjqYiNji7GwifZ3
Qq0An0L9O5S1GN42MM2lbCNJhmAd0hHx
=+8Ok
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
