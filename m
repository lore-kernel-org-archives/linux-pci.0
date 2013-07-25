Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:56680 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755552Ab3GYQ5J (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jul 2013 12:57:09 -0400
Received: by mail-bk0-f44.google.com with SMTP id 6so793014bkj.17
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2013 09:57:07 -0700 (PDT)
Date: Thu, 25 Jul 2013 09:57:00 -0700
From: Thierry Reding <thierry.reding@gmail.com>
To: Russell King <linux@arm.linux.org.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
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
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCHv5 08/11] ARM: pci: add ->add_bus() and ->remove_bus()
 hooks to hw_pci
Message-ID: <20130725165659.GB27802@dhcp-172-17-186-34.nvidia.com>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1373889167-27878-9-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
In-Reply-To: <1373889167-27878-9-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2013 at 01:52:44PM +0200, Thomas Petazzoni wrote:
> Some PCI drivers may need to adjust the pci_bus structure after it has
> been allocated by the Linux PCI core. The PCI core allows
> architectures to implement the pcibios_add_bus() and
> pcibios_remove_bus() for this purpose. This commit therefore extends
> the hw_pci and pci_sys_data structures of the ARM PCI core to allow
> PCI drivers to register ->add_bus() and ->remove_bus() in hw_pci,
> which will get called when a bus is added or removed from the system.
>=20
> This will be used for example by the Marvell PCIe driver to connect a
> particular PCI bus with its corresponding MSI chip to handle Message
> Signaled Interrupts.
>=20
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Reviewed-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  arch/arm/include/asm/mach/pci.h |  4 ++++
>  arch/arm/kernel/bios32.c        | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)

Hi Russell,

Can we have your Acked-by on this patch so that it can be moved to a
stable branch along with some of the other patches in this branch that
both Marvell and Tegra PCIe drivers need?

Thanks,
Thierry

>=20
> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/=
pci.h
> index a1c90d7..487155c 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -36,6 +36,8 @@ struct hw_pci {
>  					  resource_size_t start,
>  					  resource_size_t size,
>  					  resource_size_t align);
> +	void            (*add_bus)(struct pci_bus *bus);
> +	void            (*remove_bus)(struct pci_bus *bus);
>  };
> =20
>  /*
> @@ -63,6 +65,8 @@ struct pci_sys_data {
>  					  resource_size_t start,
>  					  resource_size_t size,
>  					  resource_size_t align);
> +	void            (*add_bus)(struct pci_bus *bus);
> +	void            (*remove_bus)(struct pci_bus *bus);
>  	void		*private_data;	/* platform controller private data	*/
>  };
> =20
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 261fcc8..530e59d 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -363,6 +363,20 @@ void pcibios_fixup_bus(struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL(pcibios_fixup_bus);
> =20
> +void pcibios_add_bus(struct pci_bus *bus)
> +{
> +	struct pci_sys_data *sys =3D bus->sysdata;
> +	if (sys->add_bus)
> +		sys->add_bus(bus);
> +}
> +
> +void pcibios_remove_bus(struct pci_bus *bus)
> +{
> +	struct pci_sys_data *sys =3D bus->sysdata;
> +	if (sys->remove_bus)
> +		sys->remove_bus(bus);
> +}
> +
>  /*
>   * Swizzle the device pin each time we cross a bridge.  If a platform do=
es
>   * not provide a swizzle function, we perform the standard PCI swizzling.
> @@ -464,6 +478,8 @@ static void pcibios_init_hw(struct device *parent, st=
ruct hw_pci *hw,
>  		sys->swizzle =3D hw->swizzle;
>  		sys->map_irq =3D hw->map_irq;
>  		sys->align_resource =3D hw->align_resource;
> +		sys->add_bus        =3D hw->add_bus;
> +		sys->remove_bus     =3D hw->remove_bus;
>  		INIT_LIST_HEAD(&sys->resources);
> =20
>  		if (hw->private_data)
> --=20
> 1.8.1.2
>=20

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJR8VjbAAoJEN0jrNd/PrOh7DIP/R5hP7lLh1+hNeaDLXhXs8hz
jwC/unXRBW45ots4fdI3VdOYYzICZE37hX6jaZlzS4K66Ls29P4dHhmSoWwLZcdD
G4m8oq4afLmosep8z6qeiqU6Sg613M6aGzMafoK0rGjlVCVSMTLuWWHm3EKmQIMm
d6qYpNz58XESVL+tMkLA6LrCcC377pkNhScFY/R3fEBmMZx6ZATbmmviy/M5brP2
70i9k9nXnlXwoijirLPr+LdPmeHYyfl6qC7RIw3eCfqvKurDcpA1Uf1ERtqfTbBC
WKCZ/U4QxxkH7i9ro9m8T6ylrFvBOClPdc1N6uMveaszn+rbF5COyedg8WprbjFD
e0dwJSSNUVtrPE74HV5tzWQQJ+iomj8hal6ATn5Qln4GmHExRCMoyCIRus+dKN+g
aA1l+2/kWen/67To4T3hGPpyYvK5J6lQeJoVALiNZ4/uo5pe+1Jkq2O0Oe0BdLOc
mEdNdQRuiq6P/06nmUSv+QAH3llIrOpVbI6rRUDQ+S2Uq26/cgKEP/j+PiTzFDX8
gR2YfPCi/FeRqXfHjslzHz6/1xYHe56AggpP8zjqdSyKWVsV5hoNgMOl5JWHUvyM
YTAuCEK6kW9a7rBzik0AZSSGV/CR6ddN6Z833QXrU1lcy8SQRTTDFdqSJTVOAow0
a5dd48uzlxqMe0qEIo4J
=6QJx
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
