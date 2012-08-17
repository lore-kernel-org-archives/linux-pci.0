Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:63141 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263Ab2HQUIG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 16:08:06 -0400
Date: Fri, 17 Aug 2012 22:07:55 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Daney <ddaney.cavm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: PCI Section mismatch error in linux-next.
Message-ID: <20120817200755.GA16021@avionic-0098.adnet.avionic-design.de>
References: <502E8115.90507@gmail.com>
 <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
 <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
 <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
In-Reply-To: <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 17, 2012 at 01:32:45PM -0600, Bjorn Helgaas wrote:
> On Fri, Aug 17, 2012 at 12:29 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > On Fri, Aug 17, 2012 at 11:44:31AM -0600, Bjorn Helgaas wrote:
> >> On Fri, Aug 17, 2012 at 11:36 AM, David Daney <ddaney.cavm@gmail.com> =
wrote:
> >> > For MIPS, Thierry Reding's patch in linux-next (PCI: Keep pci_fixup_=
irqs()
> >> > around after init) causes:
> >> >
> >> > WARNING: vmlinux.o(.text+0x22c784): Section mismatch in reference fr=
om the
> >> > function pci_fixup_irqs() to the function .init.text:pcibios_update_=
irq()
> >> >
> >> > The MIPS implementation of pcibios_update_irq() is __init, so there =
is
> >> > conflict with the removal of __init from pci_fixup_irqs() and
> >> > pdev_fixup_irq().
> >> >
> >> > Can you guys either remove the patch from linux-next, or improve it =
to also
> >> > fix up any architecture implementations of pdev_update_irq()?
> >>
> >> Crap, there are lots of arches with this issue.  I'll fix it up.
> >> Thanks for pointing it out!
> >
> > Oh wow... looks like I've opened a can of worms there. This requires
> > quite a lot of other functions to have their annotations removed as
> > well. Bjorn, how do you want to handle this?
>=20
> David said "pdev_update_irq()," but I think he meant "pcibios_update_irq(=
)."
>=20
> Almost all the pcibios_update_irq() implementations are identical, so
> I think I'll just supply a weak implementation and remove the
> redundant arch versions.

That makes sense. However I've just tested a build with section mismatch
debugging enabled on ARM and there are a few more that need __init or
__devinit removed to get rid of the warnings:

	pci_common_init()
	pcibios_init_hw()
	pcibios_init_resources()
	pcibios_swizzle()
	pcibios_update_irq()

pci_scan_root_bus() also needs __devinit removed. I haven't checked the
other architectures because I'll have to build cross-compilers for them
first, but I suspect most of them will have a similar list. I'm not sure
how well this kind of change is going to go down with the respective
architecture maintainers, though.

> This is just about the only thing in my "next" branch, so I'll clear
> it out for now, until we get this resolved.

Agreed. Do you want me to take a look at this or would you rather tackle
it yourself?

Thierry

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLqSbAAoJEN0jrNd/PrOhM5IQAMIvWP5vgHNoZAYFTtFxCUBB
whTwMx8eqiboWHXvP4rP0VkK7RYs0xrgpnGHHu78d1KxBLe6Bj9jC/UrsZheLBP4
81OxPvwrcSeGnpA8vy6jnt//4mMZkhs1IQC+GGYI72Wi3oFBIVOTtZnvLb+QOpmY
jVODrdGiEpsobb/zNP8poRfbMziJHIciV+vhqOb6vH9Q9YcnAi3UJg+qHFPGaMuc
jG7hjlxhMieFnD84yabKetwiZpfg7kVs9T6LD+KZQ5wIFGSxSZjSxTvUSoKmibk9
IEj8cC9Q0+wByEcprZ/ViUslBqSI8O9yo+zkjLfw15xvu8y08kxyjVllEYhMjMn7
dUEkL20VLc/na1hJ2kaWppEDdVmP4FiY29LeA5KSNyjIN+7lFcLPV13iNd8n5hOd
EwwyDbADTJjy+TLmqnaZdJknL9iEkbzkRzvoVazqIrEcXQPvwmF+rXDHBxUY5zbA
3R3mPQIqGYTP4YSNWaO223+kXBlbUePTho5Rxi7Bj6Y1pHwe3MYS9spjfJ7dTWKZ
cg4UDfSa/lmNJJTHJRXYbDKoz9OzKOYyV2KHKFbDWL0qPcqGccX2tKJEPCtIqqGU
TAegcORisZsqXwNEi/5L5yaLQlUNZUPF5TC4CdLswmdNlQG9b69r18mQROABRDtS
nlck9r/PYhVVpBlVfubH
=9dM8
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
