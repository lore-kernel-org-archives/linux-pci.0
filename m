Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 16 Feb 2017 12:11:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: v4.10-rc8 (-rc6) boot regression on Intel desktop, does not boot
 after cold boots, boots after reboot
Message-ID: <20170216111144.GA12377@amd>
References: <20170203211854.GA3697@amd>
 <20170214175956.GA3587@amd>
 <CA+55aFyYAztA+Onquy9ODeC9_YBL_fXAd-RgeUVUhpsjK81ZVQ@mail.gmail.com>
 <CA+55aFxU1D0hAPJuhkKaFBByi=8vpw7dJUX=FfpoqnZLWsvxig@mail.gmail.com>
 <CA+55aFwt6pbt2STzRh1yCdoo7AnCLFqnPkkrYk4_BGFuvT2VCw@mail.gmail.com>
 <CA+55aFzMiXXw9gqNCMCSc+O5HfcqWHXfqbdtbvcOmAHM9_wNig@mail.gmail.com>
 <CA+55aFxuXgsCyMgrRDHdM6BQaej68QoU8TwdM=3LYu9LMBf4fQ@mail.gmail.com>
 <20170215172303.GA15696@amd>
 <20170215232005.GA7877@amd>
 <CA+55aFyqsxjQPp=Y6MnvyMH_iA-TSiPrycnAHbBzw5bwQi7jjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
In-Reply-To: <CA+55aFyqsxjQPp=Y6MnvyMH_iA-TSiPrycnAHbBzw5bwQi7jjg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed 2017-02-15 15:34:27, Linus Torvalds wrote:
> On Wed, Feb 15, 2017 at 3:20 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > 4.10-rc4 broken
> > 4.10-rc3 ok
>=20
> Hmm. If those actually end up being reliable, then there's not a whole
> lot in between them wrt PCI or USB.
>=20
> What looked like the most likely candidate seems to be xhci-specific, tho=
ugh.
>=20
> But maybe it's something that isn't directly in drivers/{pci,usb}/ and
> just interacts badly.

Ok. I _hope_ my tests are ok. Bisect log so far is:

pavel@half:/data/l/linux$ git bisect log
# bad: [49def1853334396f948dcb4cedb9347abb318df5] Linux 4.10-rc4
# good: [a121103c922847ba5010819a3f250f1f7fc84ab8] Linux 4.10-rc3
git bisect start 'v4.10-rc4' 'v4.10-rc3'
# good: [557ed56cc75e0a33c15ba438734a280bac23bd32] Merge tag
'sound-4.10-rc4' of
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good 557ed56cc75e0a33c15ba438734a280bac23bd32
# good: [f4d3935e4f4884ba80561db5549394afb8eef8f7] Merge branch
'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect good f4d3935e4f4884ba80561db5549394afb8eef8f7
# bad: [83346fbc07d267de777e2597552f785174ad0373] Merge branch
'x86-urgent-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 83346fbc07d267de777e2597552f785174ad0373
# good: [18e7a45af91acdde99d3aa1372cc40e1f8142f7b] perf/x86: Reject
non sampling events with precise_ip
git bisect good 18e7a45af91acdde99d3aa1372cc40e1f8142f7b
# good: [84936118bdf37bda513d4a361c38181a216427e0] x86/unwind: Disable
KASAN checks for non-current tasks
git bisect good 84936118bdf37bda513d4a361c38181a216427e0
# good: [79078c53baabee12dfefb0cfe00ca94cb2c35570] Merge branch
'perf-urgent-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 79078c53baabee12dfefb0cfe00ca94cb2c35570
# good: [695085b4bc7603551db0b3da897b8bf9893ca218] x86/tsc: Add the
Intel Denverton Processor to native_calibrate_tsc()
git bisect good 695085b4bc7603551db0b3da897b8bf9893ca218

I should go now, but I should be able to finish it today.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliliPAACgkQMOfwapXb+vKiJQCgpa0sIYVHInPE242g0eoOaR7p
1jYAnRBNnSoFYCwZqwyedvoypwZG/v62
=GBg8
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
