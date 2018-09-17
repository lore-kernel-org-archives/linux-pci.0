Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726073AbeIQKx6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Sep 2018 06:53:58 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8H5OZIR048535
        for <linux-pci@vger.kernel.org>; Mon, 17 Sep 2018 01:28:13 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mj28vxqmg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Mon, 17 Sep 2018 01:28:12 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <sbobroff@linux.ibm.com>;
        Mon, 17 Sep 2018 06:28:08 +0100
Date: Mon, 17 Sep 2018 15:28:01 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux@yadro.com
Subject: Re: [PATCH RFC 1/4] PCI: hotplug: Add parameter to put devices to
 reset during rescan
References: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
 <20180914161404.4685-2-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
In-Reply-To: <20180914161404.4685-2-s.miroshnichenko@yadro.com>
Message-Id: <20180917052800.GA7315@tungsten.ozlabs.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On Fri, Sep 14, 2018 at 07:14:01PM +0300, Sergey Miroshnichenko wrote:
> Introduce a new command line option "pci=3Dpcie_movable_bars" that indica=
tes
> support of PCIe hotplug without prior reservation of memory regions by
> BIOS/bootloader.
>=20
> If a new PCIe device has been hot-plugged between two active ones, which
> have no (or not big enough) gap between their BARs, allocating new BARs
> requires to move BARs of the following working devices:
>=20
> 1)                   dev 4
>                        |
>                        v
> .. |  dev 3  |  dev 3  |  dev 5  |  dev 7  |
> .. |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 0  |
>=20
> 2)                             dev 4
>                                  |
>                                  v
> .. |  dev 3  |  dev 3  | -->           --> |  dev 5  |  dev 7  |
> .. |  BAR 0  |  BAR 1  | -->           --> |  BAR 0  |  BAR 0  |
>=20
> 3)
>=20
> .. |  dev 3  |  dev 3  |  dev 4  |  dev 4  |  dev 5  |  dev 7  |
> .. |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 0  |
>=20
> Not only BARs, but also bridge windows can be updated during a PCIe resca=
n,
> threatening all memory transactions during this procedure, so the PCI
> subsystem will instruct the drivers to pause by calling the reset_prepare=
()
> and reset_done() callbacks.
>=20
> If a device may be affected by BAR movement, the BAR changes tracking must
> be implemented in its driver.
>=20
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  6 +++
>  drivers/pci/pci.c                             |  2 +
>  drivers/pci/probe.c                           | 43 +++++++++++++++++++
>  include/linux/pci.h                           |  1 +
>  4 files changed, 52 insertions(+)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 64a3bf54b974..f8132a709061 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3311,6 +3311,12 @@
>  				bridges without forcing it upstream. Note:
>  				this removes isolation between devices and
>  				may put more devices in an IOMMU group.
> +		pcie_movable_bars	Arrange a space at runtime for BARs of
> +				hotplugged PCIe devices - usable if bootloader
> +				doesn't reserve memory regions for them. Freeing
> +				a space may require moving BARs of active devices
> +				to higher addresses, so device drivers will be
> +				paused during rescan.
> =20
>  	pcie_aspm=3D	[PCIE] Forcibly enable or disable PCIe Active State Power
>  			Management.
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 1835f3a7aa8d..5f07a59b5924 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6105,6 +6105,8 @@ static int __init pci_setup(char *str)
>  				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
>  			} else if (!strncmp(str, "disable_acs_redir=3D", 18)) {
>  				disable_acs_redir_param =3D str + 18;
> +			} else if (!strncmp(str, "pcie_movable_bars", 17)) {
> +				pci_add_flags(PCI_MOVABLE_BARS);
>  			} else {
>  				printk(KERN_ERR "PCI: Unknown option `%s'\n",
>  						str);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 201f9e5ff55c..bdaafc48dc4c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3138,6 +3138,45 @@ unsigned int pci_rescan_bus_bridge_resize(struct p=
ci_dev *bridge)
>  	return max;
>  }
> =20
> +/*
> + * Put all devices of the bus and its children to reset
> + */
> +static void pci_bus_reset_prepare(struct pci_bus *bus)
> +{
> +	struct pci_dev *dev;
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		struct pci_bus *child =3D dev->subordinate;
> +
> +		if (child) {
> +			pci_bus_reset_prepare(child);
> +		} else if (dev->driver &&
> +			   dev->driver->err_handler &&
> +			   dev->driver->err_handler->reset_prepare) {
> +			dev->driver->err_handler->reset_prepare(dev);
> +		}

What about devices with drivers that don't have reset_prepare()?  It
looks like it will just reconfigure them anyway. Is that right?

> +	}
> +}
> +
> +/*
> + * Complete the reset of all devices for the bus and its children
> + */
> +static void pci_bus_reset_done(struct pci_bus *bus)
> +{
> +	struct pci_dev *dev;
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		struct pci_bus *child =3D dev->subordinate;
> +
> +		if (child) {
> +			pci_bus_reset_done(child);
> +		} else if (dev->driver && dev->driver->err_handler &&
> +			   dev->driver->err_handler->reset_done) {
> +			dev->driver->err_handler->reset_done(dev);
> +		}
> +	}
> +}
> +
>  /**
>   * pci_rescan_bus - Scan a PCI bus for devices
>   * @bus: PCI bus to scan
> @@ -3151,8 +3190,12 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
>  {
>  	unsigned int max;
> =20
> +	if (pci_has_flag(PCI_MOVABLE_BARS))
> +		pci_bus_reset_prepare(bus);
>  	max =3D pci_scan_child_bus(bus);
>  	pci_assign_unassigned_bus_resources(bus);
> +	if (pci_has_flag(PCI_MOVABLE_BARS))
> +		pci_bus_reset_done(bus);
>  	pci_bus_add_devices(bus);
> =20
>  	return max;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 6925828f9f25..a8cb1a367c34 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -847,6 +847,7 @@ enum {
>  	PCI_ENABLE_PROC_DOMAINS	=3D 0x00000010,	/* Enable domains in /proc */
>  	PCI_COMPAT_DOMAIN_0	=3D 0x00000020,	/* ... except domain 0 */
>  	PCI_SCAN_ALL_PCIE_DEVS	=3D 0x00000040,	/* Scan all, not just dev 0 */
> +	PCI_MOVABLE_BARS	=3D 0x00000080,	/* Runtime BAR reassign after hotplug =
*/
>  };
> =20
>  /* These external functions are only available when PCI support is enabl=
ed */
> --=20
> 2.17.1
>=20

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlufO1oACgkQMX8w6AQl
/iJDxgf+N5+CVOdY2/6NZ+YUnByZ1weHi0MRv/O/B03SRdXU8njyjgf/gQb7FNpU
fohBm1InDv9de/F5kSgb1gfU8aLyQT9gL/jbiAtv6OPIZ1DdxCyi+wKlcE7hzDuK
QNNueufwRV68DUgjhnucqt5sVyQFD4TAr3o+YvZsPpPFvljiygNjfJ8UYgaIKQsQ
2VuOoAysUphM0ZSpxlUjvzVMjCme3tNjnh7YUrmnsSavN9RVNmZIN9jkut6sbyQ+
svkVsoZQijyu+GqBWCt6qqqNGMU0DCkiPRQmYU4Jk+jmxNKywz8XS9BmZK/J1Q4l
gO2ZIGb54m5CFqCJuIXBHWdhgkfaNQ==
=pnDZ
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
