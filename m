Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38581 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750719AbdBORXF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2017 12:23:05 -0500
Date: Wed, 15 Feb 2017 18:23:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: v4.10-rc8 (-rc6) boot regression on Intel desktop, does not boot
 after cold boots, boots after reboot
Message-ID: <20170215172303.GA15696@amd>
References: <20170203190414.GA3701@amd>
 <Pine.LNX.4.44L0.1702031415140.1794-100000@iolanthe.rowland.org>
 <20170203205129.GA3791@amd>
 <20170203211854.GA3697@amd>
 <20170214175956.GA3587@amd>
 <CA+55aFyYAztA+Onquy9ODeC9_YBL_fXAd-RgeUVUhpsjK81ZVQ@mail.gmail.com>
 <CA+55aFxU1D0hAPJuhkKaFBByi=8vpw7dJUX=FfpoqnZLWsvxig@mail.gmail.com>
 <CA+55aFwt6pbt2STzRh1yCdoo7AnCLFqnPkkrYk4_BGFuvT2VCw@mail.gmail.com>
 <CA+55aFzMiXXw9gqNCMCSc+O5HfcqWHXfqbdtbvcOmAHM9_wNig@mail.gmail.com>
 <CA+55aFxuXgsCyMgrRDHdM6BQaej68QoU8TwdM=3LYu9LMBf4fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
In-Reply-To: <CA+55aFxuXgsCyMgrRDHdM6BQaej68QoU8TwdM=3LYu9LMBf4fQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2017-02-14 11:12:26, Linus Torvalds wrote:
> On Feb 14, 2017 9:59 AM, "Pavel Machek" <pavel@ucw.cz> wrote:
>=20
> Hi!
>=20
> > >
> > > Booting to grub, then hitting ctrl-alt-del is enough to make it work.
> Ouch.
> > >
> > > It happens with current Linus' tree.
> >
> > v4.10-rc6-feb3 : broken
> > v4.9 : ok
>=20
> I wonder if you could bisect it now that you've figured out the rules for
> when it breaks...

I guess that's what I'll need to do. It is my main machine, so it is a
bit painful.

Anyway, it seems that "nosmp" makes it hang at similar place, but
makes it hang reliably, reboot or cold poweroff. So I guess that's
what I'll use for bisection -- should be possible to do automatically
that way.

> I don't think I've seen any similar reports, so we don't have a lot of
> clues to go by otherwise, I think.

:-(.
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlikjnYACgkQMOfwapXb+vIwVACgnuyWAIcVWlDtDuuLy6eH3jMY
XZYAoLLYeN4dyPv724rePu4HwrZdUOZx
=btv0
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
