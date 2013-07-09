Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172]:44258 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab3GIFFW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jul 2013 01:05:22 -0400
Received: by mail-ea0-f172.google.com with SMTP id q10so3365809eaj.17
        for <linux-pci@vger.kernel.org>; Mon, 08 Jul 2013 22:05:20 -0700 (PDT)
Date: Tue, 9 Jul 2013 07:05:13 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: [PATCHv4 04/11] PCI: Introduce new MSI chip infrastructure
Message-ID: <20130709050511.GB16232@mithrandir>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo4aodspFnC0uR87yYAgswQQdmU48uoX5NA43UZjbCpOuw@mail.gmail.com>
 <20130708165149.55499b8e@skate>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
In-Reply-To: <20130708165149.55499b8e@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2013 at 04:51:49PM +0200, Thomas Petazzoni wrote:
> Dear Bjorn Helgaas,

Sorry for chiming in so late, I've had bad internet connectivity and
email access for a few days.

> On Fri, 5 Jul 2013 15:51:10 -0600, Bjorn Helgaas wrote:
>
> > >  int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *=
desc)
> > >  {
> > > +       struct msi_chip *chip =3D dev->bus->msi;
> > > +
> > > +       if (chip && chip->setup_irq) {
> > > +               int err;
> > > +
> > > +               err =3D chip->setup_irq(chip, dev, desc);
> > > +               if (err < 0)
> > > +                       return err;
> > > +
> > > +               irq_set_chip_data(desc->irq, chip);
> > > +               return err;
> > > +       }
> > > +
> > >         return -EINVAL;
> >=20
> > It's sub-optimal to indent the whole body of a function like this.  I
> > think this is a bit more readable:
> >=20
> >     if (!chip || !chip->setup_irq)
> >         return -EINVAL
> >=20
> >     err =3D chip->setup_irq(...);
> >     ...
> >     return err;
> >=20
> > The return value of ->setup_irq() (and hence of arch_setup_msi_irq())
> > is a bit unclear.  Apparently it can return negative values (errors)
> > or positive values (not sure what they mean), or zero (again, not
> > sure).  A comment would clear this up.
>
> I've changed ->setup_irq() to simply return 0 on success, and a
> negative error code on failure.
>
> Apparently, according to the default implementation
> of arch_msi_setup_irqs(), the arch_msi_setup_irq() hook is supposed to
> return:
>  * A negative value on error, the value being an error code that is
>    propagated to the caller.
>  * A positive value on some other errors, in which case the -ENOSPC
>    error value is returned. To me, it doesn't make a lot of sense, as
>    arch_msi_setup_irq() could just as well return -ENOSPC directly.
>  * A 0 value on success.

Yes, I think that'd be much more straightforward. Having > 0 as a
special case isn't useful here.

> > It might even be worth introducing a no-op chip with pointers to no-op
> > functions so we don't have to do these checks ("if (chip &&
> > chip->xxx)" everywhere.  I'm not sure if there's a Linux consensus on
> > that -- certainly there are many examples of code that *does* make
> > these checks everywhere -- so I'll ack it either way.
>
> The problem with this is that I'm not sure where in the PCI code this
> association to the default implementation should be done. And there are
> also two levels to take into account here:
>
>  * The PCI driver may not specify any msi_chip structure for a
>    particular pci_bus. This would have to be detected by the PCI core
>    when the bus is registered, and bus->msi would be set to the special
>    no-op msi_chip.

You could check if bus->msi was set after the call to pcibios_bus_add()
but that's a bit wonky because it may break once the first architecture
appears that assigns it in a different place.

>  * The PCI driver may specify an msi_chip structure, but without
>    necessarily implementation all the methods. This could be solved by
>    offering a pci_msi_chip_assign(struct pci_bus *, struct msi_chip *)
>    function to be used by PCI drivers to assign their msi_chip to a
>    given pci_bus, and this function would fill in the missing msi_chip
>    operations with the default implementation.
>
> I am not sure it is really worth doing at this point, but I'm open to
> suggestions on this.

I think these extra calls aren't that bad given how other alternatives
are much easier to break things. Perhaps checking for the methods could
be dropped, therefore making them mandatory (by crashing if they're not
implemented).

> > >  int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int =
type)
> > >  {
> > > +       struct msi_chip *chip =3D dev->bus->msi;
> > > +
> > > +       if (chip && chip->check_device)
> > > +               return chip->check_device(chip, dev, nvec, type);
> > > +
> >=20
> > These functions are poorly named.  They give no clue what
> > "check_device" means.  Are we checking that it exists, that it
> > supports some property, that it's enabled, ... ?
>
> Well the naming clearly doesn't come from this commit. The
> arch_msi_check_device() hook was around before this commit, and the
> reason the operation is named ->check_device() is just because it used
> the same terminology as the existing arch_msi_check_device() call.
>
> This hook is only used in one place, the PowerPC architecture, in
> arch/powerpc/kernel/msi.c, to actually check whether the given device
> supports MSI.
>
> I can rename if to arch_msi_device_supports_msi() and
> ->device_supports_msi(), or arch_msi_device_has_msi() and
> ->device_has_msi(), but that a change that relatively unrelated to this
> commit, I'd say.
>
> Here as well, I'm open to suggestions,

I don't think *_check_device() is all that bad. Some of the
implementations in PowerPC only use it to output a debug message, others
do some more checking. Some of the checks look generic enough to move
them into the core.

If you rename it to *_has_msi() or *_supports_msi() then I'd expect it
to return a boolean and you loose the advantage of being able to return
a more meaningful value. Although I'm not sure how useful that error
code really is. It is passed all the way up to the caller of
pci_enable_msi(), so a driver could use it to construct a better error
message based on the error code. From a quick glance a few of them seem
to do that.

Thierry

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR25oHAAoJEN0jrNd/PrOh8ZYP/R8qxlN5zD5+SEGmMN/zgGWJ
SJ4f+EimYaQhG133Ls6W70bF2mict2N21dLjX5BfZUh132M+veMz45B0PgmGS93g
iEG+BIaSsK+Wsr704Dakbdq5Q0FfOqHHWhaOIJBQkpoOimpa65gQ5MukwxrzSaaB
Udzod1Vv3YjFciQBJ+TxmSR8NC11yClQQyKT7ldssj9rTmO0fWQN7uteljM1cgIq
ivA0oS5m0cWI1Y0Nvt7cB1U9cY/RnOJjKKRJ0sVr5rMQD8CllTPMV5j4mPkZiknZ
qJIijUnY0bcNpZ9HM6aeTqrB1ubZQW7GKK6Uf26S/PJCLXFQAzoD1aH9D2OjxSk8
PCS9WQWzt2EAy4XV8x+6/HT8ka9aDGYDSHbsDQQdBMOMMQ6wRuSC3XHeBmwpDi/i
cGylFOv+Y9t8OJ2JH2tJchcd30MbwVqG6ecPnZiJ6yMM39LeNb72pKNw6OSXDpX2
rBZ9Ip9QKRnaRkAHSA9fE7arxGfr08G/SHF28mXNGgQoaF1vQValIuDkdGuFbxgC
PYsH1nWExP3P09R9ha98pVqomCNyLXNQ0QSxHxWzng3PVO/1cog8HpOQcoa4S/zp
1ltxLIDV77MOptOEN/T/XZ+yJo3MXSERncTK6XykZjsfjx1IuX/AOvkQEEUBk79O
FcheG/q90hb/ZfpsUzfK
=uPA7
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
