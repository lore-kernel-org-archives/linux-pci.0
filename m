Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:44090 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932206Ab3FUKQp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2013 06:16:45 -0400
Received: by mail-bk0-f52.google.com with SMTP id d7so3298240bkh.11
        for <linux-pci@vger.kernel.org>; Fri, 21 Jun 2013 03:16:44 -0700 (PDT)
Date: Fri, 21 Jun 2013 12:16:41 +0200
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
	Lior Amsalem <alior@marvell.com>
Subject: Re: [PATCHv3 04/11] of: pci: add registry of MSI chips
Message-ID: <20130621101640.GD12441@manwe>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-5-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
In-Reply-To: <1371660979-21588-5-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2013 at 06:56:12PM +0200, Thomas Petazzoni wrote:
> This commit adds a very basic registry of msi_chip structures, so that
> an IRQ controller driver can register an msi_chip, and a PCIe host
> controller can find it, based on a 'struct device_node'.
>=20
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/of/of_pci.c    | 22 ++++++++++++++++++++++
>  include/linux/msi.h    |  2 ++
>  include/linux/of_pci.h |  4 ++++
>  3 files changed, 28 insertions(+)
>=20
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 42c687a..ca12db8 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -89,3 +89,25 @@ int of_pci_parse_bus_range(struct device_node *node, s=
truct resource *res)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_parse_bus_range);
> +
> +static LIST_HEAD(msi_chip_list);
> +static DEFINE_MUTEX(msi_chip_mutex);

Should all of this code perhaps be conditionalized by an #ifdef PCI_MSI?

> +
> +void of_msi_chip_add(struct msi_chip *chip)
> +{
> +	mutex_lock(&msi_chip_mutex);
> +	list_add(&chip->link, &msi_chip_list);
> +	mutex_unlock(&msi_chip_mutex);
> +}

Since eventually we may want to use these functions from modules, maybe
they should be exported?

Also isn't this missing an of_msi_chip_remove() counterpart?

> +struct msi_chip *of_msi_chip_find_by_node(struct device_node *of_node)

Most other functions of this type are named of_find_*_by_node(), so for
consistency it'd be better to call this of_find_msi_chip_by_node().

> +{
> +	struct msi_chip *c;
> +	list_for_each_entry(c, &msi_chip_list, link) {
> +		if (c->of_node =3D=3D of_node &&
> +		    of_property_read_bool(c->of_node, "msi-controller"))

Perhaps it would be more efficient to put this check within the
of_msi_chip_add() function?

> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index e3a137d..8b930c3 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -74,6 +74,8 @@ void default_restore_msi_irqs(struct pci_dev *dev, int =
irq);
>  struct msi_chip {
>  	struct module *owner;
>  	struct device *dev;
> +	struct device_node *of_node;

I know there's no easier way to do this, but I think we need to find a
way to clean this up at some point. There's no point in storing the OF
node in two places.

> +	struct list_head link;

I'd prefer this to be named "list" for consistency.

> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 7a04826..6e88189 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -2,6 +2,7 @@
>  #define __OF_PCI_H
> =20
>  #include <linux/pci.h>
> +#include <linux/msi.h>
> =20
>  struct pci_dev;
>  struct of_irq;
> @@ -13,4 +14,7 @@ struct device_node *of_pci_find_child_device(struct dev=
ice_node *parent,
>  int of_pci_get_devfn(struct device_node *np);
>  int of_pci_parse_bus_range(struct device_node *node, struct resource *re=
s);
> =20
> +void of_msi_chip_add(struct msi_chip *chip);
> +struct msi_chip *of_msi_chip_find_by_node(struct device_node *of_node);

Since these will be exported and conditionalized on PCI_MSI as suggested
above, maybe they should get a dummy implementation if (!OF || !PCI_MSI)
so that drivers don't have to conditionally call them?

Thierry

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRxCgIAAoJEN0jrNd/PrOh+IIQALmSCXRmIp4gadA6ZOK6PGGF
LE4+rJdpHe6lYjd0aTwhckXe1e2Ww9/BiTpAJM3OzQJXZeV8zzWzm9VuSIjOb0tg
mYG63oXEAJR9B7/0FU5UkqtVMH3CeL9c9Z//DGbzNl/uaIRmwzoaxZL9lICv4L9N
giUmAwnRxF2ocWvrJtr5znAmSkn7yd18sYyIAbdqDoMJgv5VxJHBE9YK+pGEyV/o
eWc5utXxVvT7Z+0BovqIRMsL9xe6YYgJJSZ5bGzsrlDBvJAZX8K576k1TqgbNWc3
hAx/9zOzCktTNL3qXYH+xVY5gITAYoUzXTacpuu4cwGmRDjMAuwklgiZEgEBx61o
oeWT4JQrXAVRi0D5rDAqll1TMxdnZ/fd9vzhrsJdZLr/k99chu4EoVjChsefSZIs
IpQQbHwqQTLj49GNal4MA9P392dDYdqK6TGkhtYPviVVt6NXUwqZEgzy90FBrLdd
0LmrBG7y/nrzz6rea4UJCM2IcdRTQwQzv/BCiDr6qK012YFsk+5HvQC7yXfBsmi9
WiG98zGfVP8S5VsQDmH8lx20i7iiO9Aek2hVNdrfNZCdkUZYsrh5hflitXPDsdVx
OfR9bFFIVMCHWU70lfsQ1Htv7bWyCQGbloUIBXSTogCQfT0ycov6k3C3KbWLqdzz
UZqZMHj7c3obdWV//lxn
=Z+V0
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
