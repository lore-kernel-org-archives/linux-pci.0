Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43433 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932302AbdBPTGH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2017 14:06:07 -0500
Date: Thu, 16 Feb 2017 20:06:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>, fweisbec@gmail.com,
        wanpeng.li@hotmail.com, peterz@infradead.org, riel@redhat.com,
        tglx@linutronix.de, stable@kernel.org
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: v4.10-rc8 (-rc6) boot regression on Intel desktop, does not boot
 after cold boots, boots after reboot
Message-ID: <20170216190603.GA16029@amd>
References: <CA+55aFyYAztA+Onquy9ODeC9_YBL_fXAd-RgeUVUhpsjK81ZVQ@mail.gmail.com>
 <CA+55aFxU1D0hAPJuhkKaFBByi=8vpw7dJUX=FfpoqnZLWsvxig@mail.gmail.com>
 <CA+55aFwt6pbt2STzRh1yCdoo7AnCLFqnPkkrYk4_BGFuvT2VCw@mail.gmail.com>
 <CA+55aFzMiXXw9gqNCMCSc+O5HfcqWHXfqbdtbvcOmAHM9_wNig@mail.gmail.com>
 <CA+55aFxuXgsCyMgrRDHdM6BQaej68QoU8TwdM=3LYu9LMBf4fQ@mail.gmail.com>
 <20170215172303.GA15696@amd>
 <20170215232005.GA7877@amd>
 <CA+55aFyqsxjQPp=Y6MnvyMH_iA-TSiPrycnAHbBzw5bwQi7jjg@mail.gmail.com>
 <20170216111144.GA12377@amd>
 <20170216172535.GA7868@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
In-Reply-To: <20170216172535.GA7868@amd>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2017-02-16 18:25:35, Pavel Machek wrote:
> Hi!
>=20
> > > > 4.10-rc4 broken
> > > > 4.10-rc3 ok
> > >=20
> > > Hmm. If those actually end up being reliable, then there's not a whole
> > > lot in between them wrt PCI or USB.
> > >=20
> > > What looked like the most likely candidate seems to be xhci-specific,=
 though.
> > >=20
> > > But maybe it's something that isn't directly in drivers/{pci,usb}/ and
> > > just interacts badly.
> >=20
> > Ok. I _hope_ my tests are ok. Bisect log so far is:
>=20
> And the winner is:
>=20
> pavel@half:/data/l/linux$ git bisect bad
> 24b91e360ef521a2808771633d76ebc68bd5604b is the first bad commit
> commit 24b91e360ef521a2808771633d76ebc68bd5604b
> Author: Frederic Weisbecker <fweisbec@gmail.com>
> Date:   Wed Jan 4 15:12:04 2017 +0100
>=20
>     nohz: Fix collision between tick and other hrtimers
>    =20

I had to revert 7bdb59f1ad474bd7161adc8f923cdef10f2638d1, too,
otherwise -rc8 does not compile.

With 24b91e360ef521a28087716 and 7bdb59f1ad474 reverted, it seems to
boot ok. (I did few tries.)

Best regards,
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlil+BsACgkQMOfwapXb+vLnCwCfahN4TpnogXJR3cvgVnYk0+ZP
U6EAmwRhglB7Em8fZZq1xRg2PbtY9ZYc
=lc/N
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
