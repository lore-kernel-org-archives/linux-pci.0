Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44874 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932740AbdBPUG2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2017 15:06:28 -0500
Date: Thu, 16 Feb 2017 21:06:24 +0100
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
Message-ID: <20170216200624.GA4274@amd>
References: <CA+55aFxuXgsCyMgrRDHdM6BQaej68QoU8TwdM=3LYu9LMBf4fQ@mail.gmail.com>
 <20170215172303.GA15696@amd>
 <20170215232005.GA7877@amd>
 <CA+55aFyqsxjQPp=Y6MnvyMH_iA-TSiPrycnAHbBzw5bwQi7jjg@mail.gmail.com>
 <20170216111144.GA12377@amd>
 <20170216172535.GA7868@amd>
 <20170216181353.GB4357@lerouge>
 <CA+55aFwhzMWR8QPGEK+8O8r0sFpHjn4XXraQ9K0Hq4VQi8Ru-w@mail.gmail.com>
 <20170216183421.GC4357@lerouge>
 <alpine.DEB.2.20.1702162033200.4049@nanos>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
In-Reply-To: <alpine.DEB.2.20.1702162033200.4049@nanos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2017-02-16 20:34:45, Thomas Gleixner wrote:
> On Thu, 16 Feb 2017, Frederic Weisbecker wrote:
> > On Thu, Feb 16, 2017 at 10:20:14AM -0800, Linus Torvalds wrote:
> > > On Thu, Feb 16, 2017 at 10:13 AM, Frederic Weisbecker
> > > <fweisbec@gmail.com> wrote:
> > > >
> > > > I haven't followed the discussion but this patch has a known issue =
which is fixed
> > > > with:
> > > >     7bdb59f1ad474bd7161adc8f923cdef10f2638d1
> > > >     "tick/nohz: Fix possible missing clock reprog after tick soft r=
estart"
> > > >
> > > > I hope this fixes your issue.
> > >=20
> > > No, Pavel saw the problem with rc8 too, which already has that fix.
> > >=20
> > > So I think we'll just need to revert that original patch (and that
> > > means that we have to revert the commit you point to as well, since
> > > that ->next_tick field was added by the original commit).

(I already said that elsewhere, but yes, revert of 7bdb59f1ad474b and
24b91e360ef5 fixes boot problems for me. Hmm, and 24b9 was marked for
stable... I don't know how to contact all the stable maintainers, but
probably it should not go to stable just yet...)=20

> > Aw too bad, but indeed that late we don't have the choice.
>=20
> Hint: Look for CPU hotplug interaction of these patches. I bet something
> becomes stale when the CPU goes down and does not get reset when it comes
> back online.

Hmm, that would explain problems at boot _and_ problems during
suspend/resume.

Note that this can be used to test the hotplug...

 cd /sys/devices/system/cpu/cpu1
 while true; do echo 0 > online; echo 1 > online; done

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlimBkAACgkQMOfwapXb+vK/3QCaApu8lknsLqlHtEImXiHHb3m4
954AnRP3kQupO/U+6EEgHDProxGsV3iQ
=9zlT
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
