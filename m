Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:34788 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbbFEHHc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jun 2015 03:07:32 -0400
Received: by wgv5 with SMTP id 5so49517067wgv.1
        for <linux-pci@vger.kernel.org>; Fri, 05 Jun 2015 00:07:31 -0700 (PDT)
Message-ID: <55714AB1.9050306@monstr.eu>
Date: Fri, 05 Jun 2015 09:07:29 +0200
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/7] microblaze/PCI: Remove unnecessary pci_bus_find_capability()
 declaration
References: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20150604214936.2399.94190.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150604214936.2399.94190.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="wa6DEjNB307lh7uLImNFHe97Vg0fjqwTe"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wa6DEjNB307lh7uLImNFHe97Vg0fjqwTe
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/04/2015 11:49 PM, Bjorn Helgaas wrote:
> pci_bus_find_capability() is declared in include/linux/pci.h.
>=20
> Remove the pci_bus_find_capability() declaration from
> arch/microblaze/include/asm/pci.h.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Michal Simek <monstr@monstr.eu>
> ---
>  arch/microblaze/include/asm/pci.h |    3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/includ=
e/asm/pci.h
> index b6b5b3c..541400d 100644
> --- a/arch/microblaze/include/asm/pci.h
> +++ b/arch/microblaze/include/asm/pci.h
> @@ -102,9 +102,6 @@ extern void pcibios_finish_adding_to_bus(struct pci=
_bus *bus);
> =20
>  extern void pcibios_resource_survey(void);
> =20
> -extern int pci_bus_find_capability(struct pci_bus *bus,
> -						unsigned int devfn, int cap);
> -
>  struct file;
>  extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
>  					 unsigned long pfn,
>=20


Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Bjorn: Do you want me to take this via Microblaze tree?

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--wa6DEjNB307lh7uLImNFHe97Vg0fjqwTe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAlVxSrEACgkQykllyylKDCH8FgCfRsVeXyetlnxbZblxCOFbkSdX
Bj4AnjcK7SoHU8tJyXYZZbDHGFPeriI9
=cGGd
-----END PGP SIGNATURE-----

--wa6DEjNB307lh7uLImNFHe97Vg0fjqwTe--
