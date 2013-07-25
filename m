Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48131 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757618Ab3GYSky (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jul 2013 14:40:54 -0400
Received: by mail-bk0-f46.google.com with SMTP id na10so820459bkb.19
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2013 11:40:52 -0700 (PDT)
Date: Thu, 25 Jul 2013 11:40:44 -0700
From: Thierry Reding <thierry.reding@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCHv5 04/11] PCI: Introduce new MSI chip infrastructure
Message-ID: <20130725184043.GB18584@dhcp-172-17-186-34.nvidia.com>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1373889167-27878-5-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
In-Reply-To: <1373889167-27878-5-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2013 at 01:52:40PM +0200, Thomas Petazzoni wrote:
> From: Thierry Reding <thierry.reding@avionic-design.de>
>=20
> The new struct msi_chip is used to associated an MSI controller with a
> PCI bus. It is automatically handed down from the root to its children
> during bus enumeration.
>=20
> This patch provides default (weak) implementations for the architecture-
> specific MSI functions (arch_setup_msi_irq(), arch_teardown_msi_irq()
> and arch_msi_check_device()) which check if a PCI device's bus has an
> attached MSI chip and forward the call appropriately.
>=20
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/pci/msi.c   | 27 +++++++++++++++++++++++++--
>  drivers/pci/probe.c |  1 +
>  include/linux/msi.h | 11 +++++++++++
>  include/linux/pci.h |  1 +
>  4 files changed, 38 insertions(+), 2 deletions(-)

Bjorn,

We'll need this as part of a stable branch as well, so any chance you
could ack it?

Thierry

> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index aa2f697..d5b6378 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -32,16 +32,39 @@ static int pci_msi_enable =3D 1;
> =20
>  int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>  {
> -	return -EINVAL;
> +	struct msi_chip *chip =3D dev->bus->msi;
> +	int err;
> +
> +	if (!chip || !chip->setup_irq)
> +		return -EINVAL;
> +
> +	err =3D chip->setup_irq(chip, dev, desc);
> +	if (err < 0)
> +		return err;
> +
> +	irq_set_chip_data(desc->irq, chip);
> +
> +	return 0;
>  }
> =20
>  void __weak arch_teardown_msi_irq(unsigned int irq)
>  {
> +	struct msi_chip *chip =3D irq_get_chip_data(irq);
> +
> +	if (!chip || !chip->teardown_irq)
> +		return;
> +
> +	chip->teardown_irq(chip, irq);
>  }
> =20
>  int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
>  {
> -	return 0;
> +	struct msi_chip *chip =3D dev->bus->msi;
> +
> +	if (!chip || !chip->check_device)
> +		return 0;
> +
> +	return chip->check_device(chip, dev, nvec, type);
>  }
> =20
>  int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 46ada5c..b8eaa81 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -666,6 +666,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci=
_bus *parent,
> =20
>  	child->parent =3D parent;
>  	child->ops =3D parent->ops;
> +	child->msi =3D parent->msi;
>  	child->sysdata =3D parent->sysdata;
>  	child->bus_flags =3D parent->bus_flags;
> =20
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 18870b0..cbf5d05 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -64,4 +64,15 @@ void arch_restore_msi_irqs(struct pci_dev *dev, int ir=
q);
> =20
>  void default_teardown_msi_irqs(struct pci_dev *dev);
> =20
> +struct msi_chip {
> +	struct module *owner;
> +	struct device *dev;
> +
> +	int (*setup_irq)(struct msi_chip *chip, struct pci_dev *dev,
> +			 struct msi_desc *desc);
> +	void (*teardown_irq)(struct msi_chip *chip, unsigned int irq);
> +	int (*check_device)(struct msi_chip *chip, struct pci_dev *dev,
> +			    int nvec, int type);
> +};
> +
>  #endif /* LINUX_MSI_H */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0fd1f15..4044e3c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -433,6 +433,7 @@ struct pci_bus {
>  	struct resource busn_res;	/* bus numbers routed to this bus */
> =20
>  	struct pci_ops	*ops;		/* configuration access functions */
> +	struct msi_chip	*msi;		/* MSI controller */
>  	void		*sysdata;	/* hook for sys-specific extension */
>  	struct proc_dir_entry *procdir;	/* directory entry in /proc/bus/pci */
> =20
> --=20
> 1.8.1.2
>=20

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJR8XErAAoJEN0jrNd/PrOhok8P+wY2pEESu8yrAZzQpnnvtejE
quuCDHoqaO3ObGDtw0ZyMyiSNDLZCzOumjvJQzFj+z9QwxaX1zALg3VCAXbO3Rqd
2aDvB8jAkKF4XZeSWL6yYJwdsOzvU26HKjMgTzAWMEsgqAWpGxQ0WH9h5NdWWDoB
1jfnPn0/iQ7IMes2GjrqV61lsU/1x5u+z9JupY71GTjxyibNhz9OfS3PmUKaWEdt
HCbuP20zrT2O1XIRxkkHNP1ioJk5alBczO2+fgrksNBA6F94A6G5NVPsYK/669Jn
3bVaNrZfsRFsIjuJ68jqcgYMtyjR6IavDcxSWnXDb2OuwTAUs88EO7EvjdZdgDOF
RgIOVjFvUg6hbB9ArMcJUocdzy6IEF3EPAR7tat2PDVgsEOzeP1t+1Ci2oE0XhX1
KEs18wwInJUYzN3aqgicI25tJc7xLVaoIEnLc8hW4TRcwYeWOg8KYqFhZGZL16Tt
kAmCvNqhVw6OiCP72wq7NLfn1xYB+MEWYW9SDNWiDoCK66c70v9wMJjCegXpurk/
l/yIQxyTNstn3bDaIt3QvjDmqLAAIGGKXYDqHm0VF9rshKfCyqNeacBIVpbmbgks
FX86O06eWD6wxm6R7348CpWTeAtJrLfwUcdq7qvQHVyP0aYQYWqvJuUTw7PyY0SM
a3S/eK1j3cIiD2uSK6bS
=eVL4
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
