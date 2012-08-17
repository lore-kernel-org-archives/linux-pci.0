Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:58219 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100Ab2HQUsv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 16:48:51 -0400
Date: Fri, 17 Aug 2012 22:48:39 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Daney <ddaney.cavm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: PCI Section mismatch error in linux-next.
Message-ID: <20120817204839.GA2017@avionic-0098.mockup.avionic-design.de>
References: <502E8115.90507@gmail.com>
 <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
 <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
 <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
 <20120817200755.GA16021@avionic-0098.adnet.avionic-design.de>
 <CAErSpo4XX7mQBmJfYWzmXCSDAt4BzZoJV6gU9__409K=fpvC6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
In-Reply-To: <CAErSpo4XX7mQBmJfYWzmXCSDAt4BzZoJV6gU9__409K=fpvC6A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 17, 2012 at 02:39:34PM -0600, Bjorn Helgaas wrote:
> On Fri, Aug 17, 2012 at 2:07 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > On Fri, Aug 17, 2012 at 01:32:45PM -0600, Bjorn Helgaas wrote:
> >> On Fri, Aug 17, 2012 at 12:29 PM, Thierry Reding
> >> <thierry.reding@avionic-design.de> wrote:
> >> > On Fri, Aug 17, 2012 at 11:44:31AM -0600, Bjorn Helgaas wrote:
> >> >> On Fri, Aug 17, 2012 at 11:36 AM, David Daney <ddaney.cavm@gmail.co=
m> wrote:
> >> >> > For MIPS, Thierry Reding's patch in linux-next (PCI: Keep pci_fix=
up_irqs()
> >> >> > around after init) causes:
> >> >> >
> >> >> > WARNING: vmlinux.o(.text+0x22c784): Section mismatch in reference=
 from the
> >> >> > function pci_fixup_irqs() to the function .init.text:pcibios_upda=
te_irq()
> >> >> >
> >> >> > The MIPS implementation of pcibios_update_irq() is __init, so the=
re is
> >> >> > conflict with the removal of __init from pci_fixup_irqs() and
> >> >> > pdev_fixup_irq().
> >> >> >
> >> >> > Can you guys either remove the patch from linux-next, or improve =
it to also
> >> >> > fix up any architecture implementations of pdev_update_irq()?
> >> >>
> >> >> Crap, there are lots of arches with this issue.  I'll fix it up.
> >> >> Thanks for pointing it out!
> >> >
> >> > Oh wow... looks like I've opened a can of worms there. This requires
> >> > quite a lot of other functions to have their annotations removed as
> >> > well. Bjorn, how do you want to handle this?
> >>
> >> David said "pdev_update_irq()," but I think he meant "pcibios_update_i=
rq()."
> >>
> >> Almost all the pcibios_update_irq() implementations are identical, so
> >> I think I'll just supply a weak implementation and remove the
> >> redundant arch versions.
> >
> > That makes sense. However I've just tested a build with section mismatch
> > debugging enabled on ARM and there are a few more that need __init or
> > __devinit removed to get rid of the warnings:
> >
> >         pci_common_init()
> >         pcibios_init_hw()
> >         pcibios_init_resources()
> >         pcibios_swizzle()
> >         pcibios_update_irq()
> >
> > pci_scan_root_bus() also needs __devinit removed. I haven't checked the
> > other architectures because I'll have to build cross-compilers for them
> > first, but I suspect most of them will have a similar list. I'm not sure
> > how well this kind of change is going to go down with the respective
> > architecture maintainers, though.
>=20
> Hmm, yeah, this is a mess, isn't it?  Just about everything in PCI
> will need __devinit removed.  We've been assuming that the only way
> for things to show up after init is via hotplug.  But you're breaking
> that assumption by doing *all* enumeration after init.  There are
> approximately a bajillion __init and __devinit annotations just in
> drivers/pci, not to mention those in the architectures.
>=20
> Well, maybe you just need to turn on CONFIG_HOTPLUG.  How would that
> affect you?  I think we would still have to change some __inits to
> __devinit, including pcibios_update_irq(), but it might be more
> manageable.

You said that depending on HOTPLUG wouldn't be enough because it would
exclude reenumeration at runtime if HOTPLUG wasn't defined. Also it is
theoretically possible to build a kernel without HOTPLUG but have the
enumeration start after init because of deferred probing. Those cases
won't work if we keep __init or __devinit respectively, right?

> I started working on this, but it sounds like you're in a better
> position to find problems and test fixes, so how about if I just let
> you handle it? :)

I won't be able to test anything beyond Tegra because I'm lacking the
hardware. But with the section mismatch debugging enabled all issues
should be detected at compile time anyway, so it's just a problem of
getting cross-compilers for all architectures that support PCI.

Thierry

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLq4nAAoJEN0jrNd/PrOhWEsP/1WoLz4BUtifqR3+kcODi54U
jXihEkyEA6VEjnk9gc9QDDWH5CBxf5ENXUk45MPIZgDWyw7Rzl8LbHyOV+Z7PejR
tKqOX61y4OBwHUfR3lMUEiiAV3qQ/Ymt2p7rFLIgkKDSdTyELT37e/BA9iMwHktt
Rj47Gf4UCF+5YSr4Vdo1ZB5p/Lmi+jKiLloZyjMiTicoUbi6snZGS55JW+imZH5U
ztnbbmsdnT4HQTCBJ1VkzV6n1gEfkwA7IZvrxewLhKdVuE2GJF3t2LIpLD5Ifty+
u9EnHWKbMKCUV6xAY8UpoPetSRFV5m66iDHUBS74GPkSnhbjS4UBwNlpU6UVqCFa
oqNAAZDIvGe4QRbodbgTAXAMmMpW/ibykA0S6ou5ok2MpGacuPahIeIXCIwsTd0j
lJyqXYtsPE0WARSS3h6dyZEvNQNMY5sOm3ooOZBn7V+9g5lpbovHJi5mUn12YH3d
LzjGGdG36EQwb06/tO2J0tF/3+ZR5cmZirMCz3iQ2a8NDG1t5e1XULg6D2+RmwuV
prltLMcQkFVzllCLJgp1wG1qr0YW5ILfQPwOSlCLoTB1bmFG/vLeFbaX/0IyKFQm
IShZNuma254vMCJcAWWXn/HwbcAzcozhgnJp65HsN8z+vddSMEYPcI5CFoSnaDg3
arl7kARYxgKd6riaThsB
=l8ZL
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
