Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:65068 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360Ab2HAGyp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Aug 2012 02:54:45 -0400
Date: Wed, 1 Aug 2012 08:54:37 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Rob Herring <robherring2@gmail.com>
Cc: linux-tegra@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Colin Cross <ccross@android.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 09/10] of: Add of_pci_parse_ranges()
Message-ID: <20120801065437.GB26791@avionic-0098.adnet.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-10-git-send-email-thierry.reding@avionic-design.de>
 <50183B03.2090809@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
In-Reply-To: <50183B03.2090809@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2012 at 03:07:31PM -0500, Rob Herring wrote:
> On 07/26/2012 02:55 PM, Thierry Reding wrote:
> > This new function parses the ranges property of PCI device nodes into
> > an array of struct resource elements. It is useful in multiple-port PCI
> > host controller drivers to collect information about the ranges that it
> > needs to forward to the respective ports.
>=20
> It seems to me that some of the DT PCI code in arch/powerpc/kernel/pci*
> like pci_process_bridge_OF_ranges() should apply for ARM as well.
>=20
> Each arch defining their own pci controller structs complicates this,
> but I would think at least the DT parsing can be common.

Yes, there's quite a lot of room for refactoring. When I first started
work on this there had been some discussion about whether it would make
sense to move PCI controller drivers into a common location to make it
easier to refactor but the consensus at the time was that this should
not be done.

I still think this might be worthwhile, but I have other things that I
need to finish first.

> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > ---
> > Changes in v3:
> > - new patch
> >=20
> >  drivers/of/of_pci.c    | 84 ++++++++++++++++++++++++++++++++++++++++++=
+++++++-
> >  include/linux/of_pci.h |  2 ++
> >  2 files changed, 85 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> > index 13e37e2..bcff301 100644
> > --- a/drivers/of/of_pci.c
> > +++ b/drivers/of/of_pci.c
> > @@ -1,7 +1,8 @@
> >  #include <linux/kernel.h>
> >  #include <linux/export.h>
> > -#include <linux/of.h>
> > +#include <linux/of_address.h>
> >  #include <linux/of_pci.h>
> > +#include <linux/slab.h>
> >  #include <asm/prom.h>
> > =20
> >  static inline int __of_pci_pci_compare(struct device_node *node,
> > @@ -40,3 +41,84 @@ struct device_node *of_pci_find_child_device(struct =
device_node *parent,
> >  	return NULL;
> >  }
> >  EXPORT_SYMBOL_GPL(of_pci_find_child_device);
> > +
> > +struct resource *of_pci_parse_ranges(struct device_node *node,
> > +				     unsigned int *countp)
> > +{
> > +	unsigned int count, i =3D 0;
> > +	struct resource *ranges;
>=20
> I think res or pci_res would be clearer than ranges that this is a
> struct resource.

"range" is the term used by the PCI specifications to denote these
regions. I don't see what's wrong with using it as a variable name.

Thierry

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQGNKtAAoJEN0jrNd/PrOh1IIP/04wyxMUrXfPzYMwNaIJOFpD
NvXK508GfgkG/r4KqpUxZ3EIZxJvPuGZWVcd+YS1KQw47BpLSCjTRqKRwX/T98kM
zEA34DLi99TNTMDF8CNfF1FkjaZ1hhr1Sto5OKWTjp4vXZpDUWskbfIWLjVPNjZ7
VzGby5gbDI+GDiXS0xIEWc54j4oYm3xpbIGUgRGH1DG4G70bGEhW7OnZ1XUq6X3B
u0MXz3RZ9FU2lAoA7/GXnuTjyiZJ03AMHQjs3AEzUrkWRWqeniK7kIE2iJ9TG/8k
9xAAFz7pyjoNbYnjyHNpUbasDQF2qty+WCx7DQx0+7rj0vwN28cqrn2ct4/1xG22
OHIrALGTxAjYKOjD0vDo/hQpfOe05cdv53iv9Klsje5ZpndVDdNdFoHNTBWet5ip
HXLcJI/4D6G32bx4cosO4qZ/MClh4e//nu1FtEVryGSpanmP7dHEUG/eR67HPhDZ
HzrzX+al2rYZteodoBAs+bDiIoFPKkQf+Eiae4D8bRiiBTkR6vGGQyb7YLwqX9Pu
UGLkGXcdNm8dxpqOhDq/gN8uyzRiYtqR2cpXjGAGOLV0Exj6l4zdht/jihgMmg65
DsHnX1hxAAThLXN4a0xEgCSsHQa8JFQLdjiY1W+h3VbOBrrgL2xKA9Bia5kNpGdm
WEUFAp0CiYVQ7/pkg2GI
=e139
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
