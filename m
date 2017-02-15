Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 16 Feb 2017 00:20:05 +0100
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
Message-ID: <20170215232005.GA7877@amd>
References: <Pine.LNX.4.44L0.1702031415140.1794-100000@iolanthe.rowland.org>
 <20170203205129.GA3791@amd>
 <20170203211854.GA3697@amd>
 <20170214175956.GA3587@amd>
 <CA+55aFyYAztA+Onquy9ODeC9_YBL_fXAd-RgeUVUhpsjK81ZVQ@mail.gmail.com>
 <CA+55aFxU1D0hAPJuhkKaFBByi=8vpw7dJUX=FfpoqnZLWsvxig@mail.gmail.com>
 <CA+55aFwt6pbt2STzRh1yCdoo7AnCLFqnPkkrYk4_BGFuvT2VCw@mail.gmail.com>
 <CA+55aFzMiXXw9gqNCMCSc+O5HfcqWHXfqbdtbvcOmAHM9_wNig@mail.gmail.com>
 <CA+55aFxuXgsCyMgrRDHdM6BQaej68QoU8TwdM=3LYu9LMBf4fQ@mail.gmail.com>
 <20170215172303.GA15696@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
In-Reply-To: <20170215172303.GA15696@amd>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2017-02-15 18:23:03, Pavel Machek wrote:
> On Tue 2017-02-14 11:12:26, Linus Torvalds wrote:
> > On Feb 14, 2017 9:59 AM, "Pavel Machek" <pavel@ucw.cz> wrote:
> >=20
> > Hi!
> >=20
> > > >
> > > > Booting to grub, then hitting ctrl-alt-del is enough to make it wor=
k.
> > Ouch.
> > > >
> > > > It happens with current Linus' tree.
> > >
> > > v4.10-rc6-feb3 : broken
> > > v4.9 : ok
> >=20
> > I wonder if you could bisect it now that you've figured out the rules f=
or
> > when it breaks...
>=20
> I guess that's what I'll need to do. It is my main machine, so it is a
> bit painful.
>=20
> Anyway, it seems that "nosmp" makes it hang at similar place, but
> makes it hang reliably, reboot or cold poweroff. So I guess that's
> what I'll use for bisection -- should be possible to do automatically
> that way.

I was mistaken. "nosmp" does not seem to make the hang reliable.

my-4.10-r8+ broken
4.10-rc8 broken
4.10-rc4 broken
4.10-rc3 ok
4.10-rc2 ok?

I started bisect, 168 revisions to go.

								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlik4iUACgkQMOfwapXb+vKRaQCglxdv0MpfyrLHi+X6sEXcXSXM
VfcAoJc2s04Nun/BwP+zXu4x7cHlN0yL
=XOBG
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
