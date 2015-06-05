Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33447 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbbFEHHT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jun 2015 03:07:19 -0400
Received: by wiwd19 with SMTP id d19so11309467wiw.0
        for <linux-pci@vger.kernel.org>; Fri, 05 Jun 2015 00:07:18 -0700 (PDT)
Message-ID: <55714AA3.1070407@monstr.eu>
Date: Fri, 05 Jun 2015 09:07:15 +0200
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/7] microblaze/PCI: Remove unused declarations
References: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20150604214929.2399.85988.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150604214929.2399.85988.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="gTsS6AOsC0FdSSf1x5bWItB88aUvCenDu"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gTsS6AOsC0FdSSf1x5bWItB88aUvCenDu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/04/2015 11:49 PM, Bjorn Helgaas wrote:
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
> CC: Michal Simek <monstr@monstr.eu>
> ---
>  arch/microblaze/include/asm/pci.h |   12 ------------
>  1 file changed, 12 deletions(-)

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



--gTsS6AOsC0FdSSf1x5bWItB88aUvCenDu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAlVxSqMACgkQykllyylKDCHAzACgnDyWr5hzD/SZFf15eW6Vv8UR
nmEAnig9NCuoA68OERPBhSVObhuTrZ9J
=MMqf
-----END PGP SIGNATURE-----

--gTsS6AOsC0FdSSf1x5bWItB88aUvCenDu--
