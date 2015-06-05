Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35869 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbbFEHHq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jun 2015 03:07:46 -0400
Received: by wgbgq6 with SMTP id gq6so49488062wgb.3
        for <linux-pci@vger.kernel.org>; Fri, 05 Jun 2015 00:07:45 -0700 (PDT)
Message-ID: <55714ABE.2020202@monstr.eu>
Date: Fri, 05 Jun 2015 09:07:42 +0200
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/7] microblaze/PCI: Remove unnecessary struct pci_dev
 declaration
References: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20150604214943.2399.32540.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150604214943.2399.32540.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7QNl9GBHurXLwHEUnwtDaAOgfqqDOAw3I"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7QNl9GBHurXLwHEUnwtDaAOgfqqDOAw3I
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/04/2015 11:49 PM, Bjorn Helgaas wrote:
> All users of arch/microblaze/include/asm/pci.h get it by including
> include/linux/pci.h, which in turn includes <asm/pci.h> after it declar=
es
> struct pci_dev.
>=20
> The forward declaration here is unnecessary, so remove it.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Michal Simek <monstr@monstr.eu>
> ---
>  arch/microblaze/include/asm/pci.h |    2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/includ=
e/asm/pci.h
> index 541400d..67224d3 100644
> --- a/arch/microblaze/include/asm/pci.h
> +++ b/arch/microblaze/include/asm/pci.h
> @@ -27,8 +27,6 @@
>  #define PCIBIOS_MIN_IO		0x1000
>  #define PCIBIOS_MIN_MEM		0x10000000
> =20
> -struct pci_dev;
> -
>  /* Values for the `which' argument to sys_pciconfig_iobase syscall.  *=
/
>  #define IOBASE_BRIDGE_NUMBER	0
>  #define IOBASE_MEMORY		1
>=20

Tested-by: Michal Simek <michal.simek@xilinx.com>

Bjorn: Do you want me to take this via Microblaze tree?

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--7QNl9GBHurXLwHEUnwtDaAOgfqqDOAw3I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAlVxSr8ACgkQykllyylKDCEkdwCfXnn8mpkGATYsmMiUSw3qguf/
TDIAnR6Jglf6GtRgCHmZQh5wBtCm4nRD
=xOfW
-----END PGP SIGNATURE-----

--7QNl9GBHurXLwHEUnwtDaAOgfqqDOAw3I--
