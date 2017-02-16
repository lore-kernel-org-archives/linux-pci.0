Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40888 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932193AbdBPRZj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2017 12:25:39 -0500
Date: Thu, 16 Feb 2017 18:25:35 +0100
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
Message-ID: <20170216172535.GA7868@amd>
References: <20170214175956.GA3587@amd>
 <CA+55aFyYAztA+Onquy9ODeC9_YBL_fXAd-RgeUVUhpsjK81ZVQ@mail.gmail.com>
 <CA+55aFxU1D0hAPJuhkKaFBByi=8vpw7dJUX=FfpoqnZLWsvxig@mail.gmail.com>
 <CA+55aFwt6pbt2STzRh1yCdoo7AnCLFqnPkkrYk4_BGFuvT2VCw@mail.gmail.com>
 <CA+55aFzMiXXw9gqNCMCSc+O5HfcqWHXfqbdtbvcOmAHM9_wNig@mail.gmail.com>
 <CA+55aFxuXgsCyMgrRDHdM6BQaej68QoU8TwdM=3LYu9LMBf4fQ@mail.gmail.com>
 <20170215172303.GA15696@amd>
 <20170215232005.GA7877@amd>
 <CA+55aFyqsxjQPp=Y6MnvyMH_iA-TSiPrycnAHbBzw5bwQi7jjg@mail.gmail.com>
 <20170216111144.GA12377@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
In-Reply-To: <20170216111144.GA12377@amd>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > 4.10-rc4 broken
> > > 4.10-rc3 ok
> >=20
> > Hmm. If those actually end up being reliable, then there's not a whole
> > lot in between them wrt PCI or USB.
> >=20
> > What looked like the most likely candidate seems to be xhci-specific, t=
hough.
> >=20
> > But maybe it's something that isn't directly in drivers/{pci,usb}/ and
> > just interacts badly.
>=20
> Ok. I _hope_ my tests are ok. Bisect log so far is:

And the winner is:

pavel@half:/data/l/linux$ git bisect bad
24b91e360ef521a2808771633d76ebc68bd5604b is the first bad commit
commit 24b91e360ef521a2808771633d76ebc68bd5604b
Author: Frederic Weisbecker <fweisbec@gmail.com>
Date:   Wed Jan 4 15:12:04 2017 +0100

    nohz: Fix collision between tick and other hrtimers
   =20

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlil4I8ACgkQMOfwapXb+vI88ACeNX5cd3amVJSw8eb77kXaB4nS
H4QAoJczL6EuSQDSMj8DsOpoFGi3b42k
=z9cm
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
