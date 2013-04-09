Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55872 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754240Ab3DIITA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Apr 2013 04:19:00 -0400
Date: Tue, 9 Apr 2013 10:18:50 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: Re: [RFCv1 08/11] PCI: Introduce new MSI chip infrastructure
Message-ID: <20130409081850.GB27255@avionic-0098.mockup.avionic-design.de>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364316746-8702-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo42AFdKH2RKTxOaeJgCPrYD5KYkOs3UEBez8x8Bjmun5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
In-Reply-To: <CAErSpo42AFdKH2RKTxOaeJgCPrYD5KYkOs3UEBez8x8Bjmun5w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2013 at 04:28:58PM -0600, Bjorn Helgaas wrote:
> On Tue, Mar 26, 2013 at 10:52 AM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > From: Thierry Reding <thierry.reding@avionic-design.de>
> >
> > The new struct msi_chip is used to associated an MSI controller with a
> > PCI bus. It is automatically handed down from the root to its children
> > during bus enumeration.
> >
> > This patch provides default (weak) implementations for the architecture-
> > specific MSI functions (arch_setup_msi_irq(), arch_teardown_msi_irq()
> > and arch_msi_check_device()) which check if a PCI device's bus has an
> > attached MSI chip and forward the call appropriately.
> >
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > ---
> >  drivers/pci/msi.c   |   35 +++++++++++++++++++++++++++++++----
> >  drivers/pci/probe.c |    1 +
> >  include/linux/msi.h |   10 ++++++++++
> >  include/linux/pci.h |    1 +
> >  4 files changed, 43 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > index 00cc78c..fce3549 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -26,14 +26,41 @@
> >
> >  static int pci_msi_enable =3D 1;
> >
> > -/* Arch hooks */
> > +int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *de=
sc)
> > +{
> > +       struct msi_chip *chip =3D dev->bus->msi;
> > +
> > +       if (chip && chip->setup_irq) {
> > +               int err;
> > +
> > +               err =3D chip->setup_irq(chip, dev, desc);
> > +               if (err < 0)
> > +                       return err;
> > +
> > +               irq_set_chip_data(desc->irq, chip);
> > +               return err;
> > +       }
> > +
> > +       return -EINVAL;
> > +}
> >
> > -#ifndef arch_msi_check_device
> > -int arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
> > +void __weak arch_teardown_msi_irq(unsigned int irq)
> >  {
> > +       struct msi_chip *chip =3D irq_get_chip_data(irq);
> > +
> > +       if (chip && chip->teardown_irq)
> > +               chip->teardown_irq(chip, irq);
> > +}
> > +
> > +int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int ty=
pe)
>=20
> I like the replacement of "#ifndef arch_msi_check_device()" with a
> weak implementation here, but this only does half the job -- shouldn't
> we remove the powerpc "#define arch_msi_check_device
> arch_msi_check_device" at the same time?

Yes, there are a few things that can be done to cleanup the "mess"
around this subsequently. For instance I have a local patch which
completely removes the ARCH_SUPPORTS_MSI symbol because it isn't
useful after making the symbols weak. One other obvious item is to
convert more architectures to implement an MSI chip.

> And since we're touching all the check_device() implementations, maybe
> we could come up with a better name.  "check_device()" conveys
> absolutely no information about what we're checking or what the sense
> of the result is.  arch_msi_supported()?  pcibios_msi_supported()?  I
> guess it should be consistent with the other arch interfaces, so
> arch_*() is probably better.

At least on PowerPC the arch_msi_check_device() hook also refuses to
setup multiple MSI per device because it isn't supported. I can't think
of a better alternative than arch_msi_supported(), though so that's fine
with me.

Perhaps pcibios_msi_supported() wouldn't be so bad either. Other
architecture-specific functions already use that prefix (see the OF
support functions) and it might be good to settle on one convention for
consistency.

That said, the goal is to eventually get rid of all the arch_msi_*()
functions. The only reason they are still there is because I didn't want
to convert everything in one go. So I wanted to put the infrastructure
in place that we need to support multi-platform on ARM (which is given
by this generic MSI chip infrastructure). Later the remaining PCI
architectures can be converted to provide an msi_chip as well, at which
point the now weak implementations can become non-weak and be renamed to
something like pci_{setup,teardown,check}_msi() to make it more obvious
that they are generic.

> Maybe the ugly #ifdef-ery around arch_setup_msi_irqs,
> arch_teardown_msi_irqs, and arch_restore_msi_irqs could be cleaned up
> similarly?  Somebody worked pretty hard to obfuscate all that,
> probably before weak functions were available.

I think Andrew or Jason at one point commented whether they should be
allowed to be implemented by an MSI chip. If so we could use the same
approach as for the other functions.

> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index b494066..9307550 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -634,6 +634,7 @@ static struct pci_bus *pci_alloc_child_bus(struct p=
ci_bus *parent,
> >
> >         child->parent =3D parent;
> >         child->ops =3D parent->ops;
> > +       child->msi =3D parent->msi;
> >         child->sysdata =3D parent->sysdata;
> >         child->bus_flags =3D parent->bus_flags;
> >
> > diff --git a/include/linux/msi.h b/include/linux/msi.h
> > index ce93a34..ea4a5be 100644
> > --- a/include/linux/msi.h
> > +++ b/include/linux/msi.h
> > @@ -58,5 +58,15 @@ extern int arch_setup_msi_irqs(struct pci_dev *dev, =
int nvec, int type);
> >  extern void arch_teardown_msi_irqs(struct pci_dev *dev);
> >  extern int arch_msi_check_device(struct pci_dev* dev, int nvec, int ty=
pe);
> >
> > +struct msi_chip {
> > +       struct module *owner;
> > +       struct device *dev;
> > +
> > +       int (*setup_irq)(struct msi_chip *chip, struct pci_dev *dev,
> > +                        struct msi_desc *desc);
> > +       void (*teardown_irq)(struct msi_chip *chip, unsigned int irq);
> > +       int (*check_device)(struct msi_chip *chip, struct pci_dev *dev,
> > +                           int nvec, int type);
>=20
> If we do end up adding interfaces like this (I'm not sure it will work
> -- see below), I think it would be better to pass just the pci_dev,
> not the "msi_chip, pci_dev" pair.  Passing both pointers avoids a
> cheap lookup in the caller, but it adds a way that two inseparable
> things can get out of sync.

Yes, that's a good idea and we can easily do that.

> > +};
> >
> >  #endif /* LINUX_MSI_H */
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 2461033a..6aca43ea 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -416,6 +416,7 @@ struct pci_bus {
> >         struct resource busn_res;       /* bus numbers routed to this b=
us */
> >
> >         struct pci_ops  *ops;           /* configuration access functio=
ns */
> > +       struct msi_chip *msi;           /* MSI controller */
>=20
> "msi" seems like a too-generic name here; it suggests an interrupt or
> IRQ, not a controller.

It's short and to the point. The bus abstraction doesn't really have any
interrupt functionality, has it? Even for PCI devices the MSI interrupt
number is actually stored in the .irq field, so I don't think it's too
generic. But if you insist I'll think of another name.

> I'm not sure this is the correct place for it.  Having it in the
> struct pci_bus means you need arch code to fill it in, e.g., you added
> it in mvebu_pcie_scan_bus() in patch 09/11.  There's no good way to do
> that for arches that use pci_scan_root_bus(), which is the direction
> I'd like to go.

We could add an argument to pci_scan_root_bus() to pass this information
in. It's a bit ugly but see below...

> I think it probably should go in sysdata instead.  That would mean you
> can't really do generic weak setup/tear-down functions, because they
> wouldn't know how to pull the MSI controller info out of the
> arch-specific sysdata.  But there are so many levels of weak-ness
> going on there, maybe it would be a good thing to get rid of one :)

Isn't putting more data into sysdata a step in the opposite direction of
where we want to go? I seem to remember some discussion about wanting to
consolidate the various architecture-specific implementations and move
more common code into the PCI core. If we handle the whole MSI business
in architecture-specific code we gain little to nothing compared to the
current situation.

Thierry

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRY87qAAoJEN0jrNd/PrOh/60QAJe1sbSomRZbmc5skbH0WzLO
VoiwhMPqlZVGp/lRT8JxMAMVoZUI5FBJ07MURE0BRZPegPRoLYLbXRc6vJDm14fb
/ucnRsdxisZpV8PRaZkqIoRfV1hFV/7wOdzKSB3h1ocWZf0XzNpd3b5NLzLMyATb
zWhUtynNDSVmppAgsKezlhAnFWPoh1HkEHa5Pi82FOfAzSrUztUe9KPokh4yDp98
Tf4+EaJypvLxiNuvYYwFWQaXRIYYa6snWKPJH1KXVZjD/Ka8SHWfATNCyPu7AKkN
Sge3kPrZPVsooXdrfaw2q+Y1udcw70XTex8jk5/1OLiffItYMvhonLjEXqOnoHxG
KAxnDnNCQjUCHJr3fdTNKGwwDCflIYk85ei8rJqJJdpODwvwNoeLXRZPsvE++dPi
O0ONVMkx3+F9j/MXR6FXiqd80RJ5qXuvuRrof9S8B7u9meF52iBV2tF45NarNSK2
tzkcK470kfnBlDzoT8ajqOeuVfHK4AH9wkNxsl9JD4g+cEk1Wdq5+ACkgRYsZE1l
99HYtRZrFdn5zZUYbpiYQF84S7Lc0PIIfc+bi7mCpicmrphIPROPEYmHE1bCLdjl
A4EN/5rwYLXrcDaLL8CYfmukyIUxnrGFD6/suZQya4Vhe70MSuXg6/P2DB0gkq2G
7Y8I5tWJcdOShA3qDAJ2
=/8ec
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
