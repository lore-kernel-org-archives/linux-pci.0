Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 18 Feb 2017 09:55:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        wanpeng.li@hotmail.com, Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>,
        "# .39.x" <stable@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: v4.10-rc8 (-rc6) boot regression on Intel desktop, does not boot
 after cold boots, boots after reboot
Message-ID: <20170218085513.GA8937@amd>
References: <20170215232005.GA7877@amd>
 <CA+55aFyqsxjQPp=Y6MnvyMH_iA-TSiPrycnAHbBzw5bwQi7jjg@mail.gmail.com>
 <20170216111144.GA12377@amd>
 <20170216172535.GA7868@amd>
 <20170216181353.GB4357@lerouge>
 <CA+55aFwhzMWR8QPGEK+8O8r0sFpHjn4XXraQ9K0Hq4VQi8Ru-w@mail.gmail.com>
 <20170216183421.GC4357@lerouge>
 <alpine.DEB.2.20.1702162033200.4049@nanos>
 <20170216200624.GA4274@amd>
 <CA+55aFz9bEfwMFUgj2zX+X9Cy_Rv0994AWX4DW+YmqdK8wCa1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
In-Reply-To: <CA+55aFz9bEfwMFUgj2zX+X9Cy_Rv0994AWX4DW+YmqdK8wCa1Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2017-02-16 12:21:13, Linus Torvalds wrote:
> On Thu, Feb 16, 2017 at 12:06 PM, Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Hmm, that would explain problems at boot _and_ problems during
> > suspend/resume.
>=20
> I've committed the revert, and I'm just assuming that the revert also
> fixed your suspend/resume issues, but I wanted to just double-check
> that since it's only implied, no staed explicitly..

So boot issue is fixed, but it hung on resume, again. v4.9 worked
ok. Display is restored when it hangs on resume, but mouse is dead; I
guess that means there should be some chance to get debugging messages
during the resume.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlioC/EACgkQMOfwapXb+vJAUwCeNb86wi1xXQMe33k297EQuX4/
uEgAnirLnvoH9gPvXyzmIHqDWgeIzZL5
=oER6
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
