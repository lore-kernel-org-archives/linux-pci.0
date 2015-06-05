Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33852 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbbFEGm1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jun 2015 02:42:27 -0400
Received: by wibut5 with SMTP id ut5so10700251wib.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2015 23:42:26 -0700 (PDT)
Message-ID: <557144CF.50500@monstr.eu>
Date: Fri, 05 Jun 2015 08:42:23 +0200
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org
Subject: Re: [PATCH] microblaze/PCI: Remove unused declarations
References: <20150604195706.17951.85004.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150604195706.17951.85004.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Rv08Rem4XacV1r4k19hG8MJVL8IoJGp34"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rv08Rem4XacV1r4k19hG8MJVL8IoJGp34
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On 06/04/2015 09:57 PM, Bjorn Helgaas wrote:
> The following declarations were copied from powerpc but are unused on
> microblaze:
>=20
>   struct pci_controller *init_phb_dynamic(struct device_node *dn)
>   int remove_phb_dynamic(struct pci_controller *phb)
>   struct pci_dev *of_create_pci_dev(struct device_node *node, ...)
>   void of_scan_pci_bridge(struct device_node *node, ...)
>   void of_scan_bus(struct device_node *node, struct pci_bus *bus)
>   void of_rescan_bus(struct device_node *node, struct pci_bus *bus)
>=20
> Remove them.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/microblaze/include/asm/pci.h |   12 ------------
>  1 file changed, 12 deletions(-)
>=20
> diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/includ=
e/asm/pci.h
> index 468aca8..b6b5b3c 100644
> --- a/arch/microblaze/include/asm/pci.h
> +++ b/arch/microblaze/include/asm/pci.h
> @@ -102,18 +102,6 @@ extern void pcibios_finish_adding_to_bus(struct pc=
i_bus *bus);
> =20
>  extern void pcibios_resource_survey(void);
> =20
> -extern struct pci_controller *init_phb_dynamic(struct device_node *dn)=
;
> -extern int remove_phb_dynamic(struct pci_controller *phb);
> -
> -extern struct pci_dev *of_create_pci_dev(struct device_node *node,
> -					struct pci_bus *bus, int devfn);
> -
> -extern void of_scan_pci_bridge(struct device_node *node,
> -				struct pci_dev *dev);
> -
> -extern void of_scan_bus(struct device_node *node, struct pci_bus *bus)=
;
> -extern void of_rescan_bus(struct device_node *node, struct pci_bus *bu=
s);
> -
>  extern int pci_bus_find_capability(struct pci_bus *bus,
>  						unsigned int devfn, int cap);
> =20
>=20

I think I should ignore this because you have sent another series where
this patch is included.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--Rv08Rem4XacV1r4k19hG8MJVL8IoJGp34
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAlVxRNAACgkQykllyylKDCFC/gCfTs8xZybO5RVwHpMKdQFErpkw
Zv0AnjCNrBZ4JXCHaXM8PE+nhD8uEDMh
=h0tK
-----END PGP SIGNATURE-----

--Rv08Rem4XacV1r4k19hG8MJVL8IoJGp34--
