Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:49965 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816Ab2HQVWN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 17:22:13 -0400
Date: Fri, 17 Aug 2012 23:22:01 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Daney <ddaney.cavm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: PCI Section mismatch error in linux-next.
Message-ID: <20120817212201.GB14842@avionic-0098.mockup.avionic-design.de>
References: <502E8115.90507@gmail.com>
 <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
 <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
 <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
 <20120817200755.GA16021@avionic-0098.adnet.avionic-design.de>
 <CAErSpo4XX7mQBmJfYWzmXCSDAt4BzZoJV6gU9__409K=fpvC6A@mail.gmail.com>
 <20120817204839.GA2017@avionic-0098.mockup.avionic-design.de>
 <CAErSpo5G=N529J9uOdp3oV66=PRTVPA+BWxraN5aZ5JAH_31JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
In-Reply-To: <CAErSpo5G=N529J9uOdp3oV66=PRTVPA+BWxraN5aZ5JAH_31JA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 17, 2012 at 03:06:42PM -0600, Bjorn Helgaas wrote:
> On Fri, Aug 17, 2012 at 2:48 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > On Fri, Aug 17, 2012 at 02:39:34PM -0600, Bjorn Helgaas wrote:
> >> On Fri, Aug 17, 2012 at 2:07 PM, Thierry Reding
> >> <thierry.reding@avionic-design.de> wrote:
> >> > On Fri, Aug 17, 2012 at 01:32:45PM -0600, Bjorn Helgaas wrote:
> >> >> On Fri, Aug 17, 2012 at 12:29 PM, Thierry Reding
> >> >> <thierry.reding@avionic-design.de> wrote:
> >> >> > On Fri, Aug 17, 2012 at 11:44:31AM -0600, Bjorn Helgaas wrote:
> >> >> >> On Fri, Aug 17, 2012 at 11:36 AM, David Daney <ddaney.cavm@gmail=
=2Ecom> wrote:
> >> >> >> > For MIPS, Thierry Reding's patch in linux-next (PCI: Keep pci_=
fixup_irqs()
> >> >> >> > around after init) causes:
> >> >> >> >
> >> >> >> > WARNING: vmlinux.o(.text+0x22c784): Section mismatch in refere=
nce from the
> >> >> >> > function pci_fixup_irqs() to the function .init.text:pcibios_u=
pdate_irq()
> >> >> >> >
> >> >> >> > The MIPS implementation of pcibios_update_irq() is __init, so =
there is
> >> >> >> > conflict with the removal of __init from pci_fixup_irqs() and
> >> >> >> > pdev_fixup_irq().
> >> >> >> >
> >> >> >> > Can you guys either remove the patch from linux-next, or impro=
ve it to also
> >> >> >> > fix up any architecture implementations of pdev_update_irq()?
> >> >> >>
> >> >> >> Crap, there are lots of arches with this issue.  I'll fix it up.
> >> >> >> Thanks for pointing it out!
> >> >> >
> >> >> > Oh wow... looks like I've opened a can of worms there. This requi=
res
> >> >> > quite a lot of other functions to have their annotations removed =
as
> >> >> > well. Bjorn, how do you want to handle this?
> >> >>
> >> >> David said "pdev_update_irq()," but I think he meant "pcibios_updat=
e_irq()."
> >> >>
> >> >> Almost all the pcibios_update_irq() implementations are identical, =
so
> >> >> I think I'll just supply a weak implementation and remove the
> >> >> redundant arch versions.
> >> >
> >> > That makes sense. However I've just tested a build with section mism=
atch
> >> > debugging enabled on ARM and there are a few more that need __init or
> >> > __devinit removed to get rid of the warnings:
> >> >
> >> >         pci_common_init()
> >> >         pcibios_init_hw()
> >> >         pcibios_init_resources()
> >> >         pcibios_swizzle()
> >> >         pcibios_update_irq()
> >> >
> >> > pci_scan_root_bus() also needs __devinit removed. I haven't checked =
the
> >> > other architectures because I'll have to build cross-compilers for t=
hem
> >> > first, but I suspect most of them will have a similar list. I'm not =
sure
> >> > how well this kind of change is going to go down with the respective
> >> > architecture maintainers, though.
> >>
> >> Hmm, yeah, this is a mess, isn't it?  Just about everything in PCI
> >> will need __devinit removed.  We've been assuming that the only way
> >> for things to show up after init is via hotplug.  But you're breaking
> >> that assumption by doing *all* enumeration after init.  There are
> >> approximately a bajillion __init and __devinit annotations just in
> >> drivers/pci, not to mention those in the architectures.
> >>
> >> Well, maybe you just need to turn on CONFIG_HOTPLUG.  How would that
> >> affect you?  I think we would still have to change some __inits to
> >> __devinit, including pcibios_update_irq(), but it might be more
> >> manageable.
> >
> > You said that depending on HOTPLUG wouldn't be enough because it would
> > exclude reenumeration at runtime if HOTPLUG wasn't defined.
>=20
> I'm suggesting that maybe we shouldn't support enumeration at runtime
> unless HOTPLUG is defined.  So if you want to enumerate after init,
> set CONFIG_HOTPLUG=3Dy.
>=20
> > Also it is
> > theoretically possible to build a kernel without HOTPLUG but have the
> > enumeration start after init because of deferred probing. Those cases
> > won't work if we keep __init or __devinit respectively, right?
>=20
> This is the situation (deferred probing with CONFIG_HOTPLUG=3Dn) that
> I'm suggesting might not need to work.  After all, hotplug essentially
> means "adding devices after init."

Yes, I guess that would be appropriate. However I don't see how this
could be expressed in Kconfig unless the deferred probing itself is
conditionalized on HOTPLUG. Even in that case it would still be possible
to build a PCIe controller driver as a module and load it at runtime
after init.

> > I won't be able to test anything beyond Tegra because I'm lacking the
> > hardware. But with the section mismatch debugging enabled all issues
> > should be detected at compile time anyway, so it's just a problem of
> > getting cross-compilers for all architectures that support PCI.
>=20
> I have cross-compilers for many of the architectures (relatively
> painless to build with
> http://git.infradead.org/users/segher/buildall.git), but this is
> starting to look like it will take more time than I have right now.

I have my own set of scripts and I already have toolchains for ARM,
MIPS, x86 and PowerPC. I've started a build for SPARC and will look
at some of the more exotic ones after that.

This also looks a little daunting to me, but I'll give it a shot. I
don't have plenty of time either so it may take a while.

Thierry

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLrX5AAoJEN0jrNd/PrOhmOwP/0AfKexs5qeKMbISoKIdlNEL
h2e167FHk94/+M3cx+qUWIjGP0fGyKhe8Ic4QltiAfegfRt/K43NSOlIALEHScOn
ilY4lCPSdrbPcvi6j5AEfM5wwsaV6Jz0gFzgwJetNg5aCFyJdgHrdgfpyf7Cyl1Y
zq0zFnusV+OqWn5FVrUboyZbL5fRwa9zl1nA6o5bedEMUwUuRuLPi1Jv86/SzYKT
7YsCa87ERrNnSRPhhLeu7DhhDhK4ejBfxQcFQhFz81l7n4YE1AiBvpbvaguB5O8u
n3+NtfrrWXJ304fIOyodPJX5rfxmaccgSVo0PaqyUjkksrgVJLA/F9aV7Wj1hPnf
JIlKhbVdHa6TOTwcT6msJw+r3gE6bQZaUc+18M7jKZB2rPtVfkWLsccVmG2XzFZf
oGA4n5g3KPHxSams997mhqb0XB8t+aMs9VLDQpp4Gru76dN014cKlqSES7UDZcZT
4BDX0Jun90wojPN5FTvSCqLGqZ9wWE89vgM50To+uvgvVT4bgO01NqSBVtuyeSbA
luAFDPUtBK74jU77Xf0JZH5cnxI6Tf46ARhjLCB77XFODqM0t5usAK2T4AgoJram
xRaArSS2s8UY2E2mfTMGwLHPXKz89O7ivMM8pFwTyg0Ge+/2BB6sr0xD6IKpRehx
YJkAL9wBHBGRxsLhQARC
=Sk5a
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
