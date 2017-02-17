Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 17 Feb 2017 18:05:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20170217170508.GA20884@amd>
References: <20170215232005.GA7877@amd>
 <CA+55aFyqsxjQPp=Y6MnvyMH_iA-TSiPrycnAHbBzw5bwQi7jjg@mail.gmail.com>
 <20170216111144.GA12377@amd>
 <20170216172535.GA7868@amd>
 <20170216181353.GB4357@lerouge>
 <CA+55aFwhzMWR8QPGEK+8O8r0sFpHjn4XXraQ9K0Hq4VQi8Ru-w@mail.gmail.com>
 <20170216183421.GC4357@lerouge>
 <alpine.DEB.2.20.1702162033200.4049@nanos>
 <20170217140449.GA4521@lerouge>
 <alpine.DEB.2.20.1702171737020.3536@nanos>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
In-Reply-To: <alpine.DEB.2.20.1702171737020.3536@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-02-17 17:37:47, Thomas Gleixner wrote:
> On Fri, 17 Feb 2017, Frederic Weisbecker wrote:
> > On Thu, Feb 16, 2017 at 08:34:45PM +0100, Thomas Gleixner wrote:
> > > On Thu, 16 Feb 2017, Frederic Weisbecker wrote:
> > > > On Thu, Feb 16, 2017 at 10:20:14AM -0800, Linus Torvalds wrote:
> > > > > On Thu, Feb 16, 2017 at 10:13 AM, Frederic Weisbecker
> > > > > <fweisbec@gmail.com> wrote:
> > > > > >
> > > > > > I haven't followed the discussion but this patch has a known is=
sue which is fixed
> > > > > > with:
> > > > > >     7bdb59f1ad474bd7161adc8f923cdef10f2638d1
> > > > > >     "tick/nohz: Fix possible missing clock reprog after tick so=
ft restart"
> > > > > >
> > > > > > I hope this fixes your issue.
> > > > >=20
> > > > > No, Pavel saw the problem with rc8 too, which already has that fi=
x.
> > > > >=20
> > > > > So I think we'll just need to revert that original patch (and that
> > > > > means that we have to revert the commit you point to as well, sin=
ce
> > > > > that ->next_tick field was added by the original commit).
> > > >=20
> > > > Aw too bad, but indeed that late we don't have the choice.
> > >=20
> > > Hint: Look for CPU hotplug interaction of these patches. I bet someth=
ing
> > > becomes stale when the CPU goes down and does not get reset when it c=
omes
> > > back online.
> >=20
> > Indeed I should check that. But Pavel is seeing this on boot, where the
>=20
> I don't think so. He observed it on suspend resume and by doing hotplug
> operations in a loop. But I might be wrong as usual.

These are different bugs.

On x60, I see failures doing hotplug/unplug in a loop, or lot of
suspends. Someone seen it in v4.8-stable etc. Old bug. Rare to hit.

Desktop machine was failing to boot, and had some fun with
suspend/resume too. Boot hang was reproducible with right
procedure. (Hard poweroff, cold boot.). That one was introduced in
4.10-rc cycle.


									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlinLUQACgkQMOfwapXb+vLyZACfd/3P/zgPSQoo5wdRIJHbcUe2
lPUAniMnY/fy7jjaHgxRBpIyuePdExQV
=0T7k
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
