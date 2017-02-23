Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58602 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdBWSkS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2017 13:40:18 -0500
Date: Thu, 23 Feb 2017 19:40:13 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        torvalds@linux-foundation.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: v4.10-rc8 (-rc6) boot regression on Intel desktop, does not boot
 after cold boots, boots after reboot
Message-ID: <20170223184013.GA5177@amd>
References: <20170203190414.GA3701@amd>
 <Pine.LNX.4.44L0.1702031415140.1794-100000@iolanthe.rowland.org>
 <20170203205129.GA3791@amd>
 <20170203211854.GA3697@amd>
 <20170214175956.GA3587@amd>
 <20170214192743.GA3869@amd>
 <20170223162825.GA16646@lerouge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
In-Reply-To: <20170223162825.GA16646@lerouge>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2017-02-23 17:28:26, Frederic Weisbecker wrote:
> On Tue, Feb 14, 2017 at 08:27:43PM +0100, Pavel Machek wrote:
> > On Tue 2017-02-14 18:59:56, Pavel Machek wrote:
> > > Hi!
> > >=20
> > > > > > > Hmm. I moved keyboard between USB ports, and now 4.10-rc6 no =
longer
> > > > > > > boots. v4.6 works ok. Let me try with keyboard unplugged... n=
o, I
> > > > > > > could not get it to work. I believe v4.9 and some v4.10-rc's =
worked,
> > > > > > > but I'll have to double check.
> > > > > >=20
> > > > > > But all the kernel versions worked when the keyboard was plugge=
d into
> > > > > > its original USB port?
> > > > >=20
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
> > > Hmm. It hangs during PCI fixups, and it hangs in v4.10-rc8, too.  =20
> > >=20
> > > With debug patch below, I get
> > >=20
> > > ...1d.7: PCI fixup... pass 2
> > > ...1d.7: PCI fixup... pass 3
> > > ...1d.7: PCI fixup... pass 3 done
> > >=20
> > > ...followed by hang. So yes, it looks USB related.
> > >=20
> > > (Sometimes it hangs with some kind backtrace involving secondary CPU
> > > startup, unfortunately useful info is off screen at that point).
> >=20
> > Forgot to say, 1d.7 is EHCI controller.
> >=20
> > 00:1d.7 USB controller: Intel Corporation NM10/ICH7 Family USB2 EHCI
> > Controller (rev 01)
>=20
> Ok, I should have access soon to a EeePc 1015CX (which seem to have this =
controller).
> I hope I'll be able to reproduce the issue there. If not, I'm sorry but I=
'll have to
> burden you again :-)

Go through more mails. It is only reproducible after cold boot. .. so
I doubt it will be easy to reproduce on another machine.

Now... I do have serial port, and I even might have serial cable
somewhere, but.... Giving how sensitive it is, it is probably going to
go away with console on ttyS...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEUEARECAAYFAlivLI0ACgkQMOfwapXb+vKUhACSA98GHM4G1ATYTfPmL4mFCNjV
YQCgsUbNgUynuDi8vCRlSf4GhPk1FD4=
=94sW
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
