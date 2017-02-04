Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38580 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbdBDQwy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Feb 2017 11:52:54 -0500
Date: Sat, 4 Feb 2017 17:52:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org
Subject: Re: v4.10-rc6 boot regression on Intel desktop, does not boot after
 cold boots, boots after reboot
Message-ID: <20170204165248.GA6951@amd>
References: <20170203211854.GA3697@amd>
 <Pine.LNX.4.44L0.1702031658100.1794-100000@iolanthe.rowland.org>
 <20170203224309.GA22118@amd>
 <20170204084856.GA32381@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
In-Reply-To: <20170204084856.GA32381@amd>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--XsQoSWH+UP9D9v3l
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
> v4.10-rc1 seems to work.

v4.10-rc3: ok
v4.10-rc5: bad, I get some kind of backtrace? Next boot results in
hang. It boots ok twice in between.
v4.10-rc6: ok ?!
34e00accf612bc5448ae709245c2b408edf39f46 : ok?
v4.10-rc6-feb3: ok?! (with config.ok, and with original config. Hmm?)

This machine was pretty reliable (except rowhammer), but I admit their
EC code may leave something to be desired. Sometimes it runs without
power LED lit (usually after strange crashes), sometimes _two_ long
presses are neccessary to power it off.

So... yesterday it hung on cold boot, but not on reboot. Verified 5
times or more. Today, I can't reproduce the hang. Strange :-(.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliWBuAACgkQMOfwapXb+vLtJgCfegaUKN5H+AM+gWMHDUQVuYzz
RH8AnjZmkOb5LGSHGoDTGRFHptn/QLNC
=sHUH
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
