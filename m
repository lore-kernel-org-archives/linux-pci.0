Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49049 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752365AbdBCWnx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2017 17:43:53 -0500
Date: Fri, 3 Feb 2017 23:43:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: v4.10-rc6 boot regression on Intel desktop, does not boot after
 cold boots, boots after reboot
Message-ID: <20170203224309.GA22118@amd>
References: <20170203211854.GA3697@amd>
 <Pine.LNX.4.44L0.1702031658100.1794-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
In-Reply-To: <Pine.LNX.4.44L0.1702031658100.1794-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-02-03 16:59:05, Alan Stern wrote:
> On Fri, 3 Feb 2017, Pavel Machek wrote:
>=20
> > Hi!
> >=20
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
> All I can suggest is git bisect.  :-(  But I agree that the problem is=20
> unlikely to be in the USB layer.

Yep. I'm hoping PCI people speak up.... adding printks there should be
possibility, too.

(And I guess I should remove you and usb people from the cc-list... in
the next mails).

(I verified it happens with 32bit configuration, too, FWIW).

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliVB30ACgkQMOfwapXb+vLQfACeP4ICsvlMBAQMyG5VE3ZGdLX2
xMcAn2LRgKPNMEl7biHBRhnMPeRfLveA
=4mQ5
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
