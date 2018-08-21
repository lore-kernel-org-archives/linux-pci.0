Return-Path: <linux-kernel-owner@vger.kernel.org>
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH] microblaze/PCI: Remove stale pcibios_align_resource()
 comment
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>
References: <20180820094729.362-1-lorenzo.pieralisi@arm.com>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <90363c9d-4084-dd2f-9956-42de2841bfc6@monstr.eu>
Date: Tue, 21 Aug 2018 08:24:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180820094729.362-1-lorenzo.pieralisi@arm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="d8Es5vfkPIxYq7uszv67lK9J3s4ZutWir"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d8Es5vfkPIxYq7uszv67lK9J3s4ZutWir
Content-Type: multipart/mixed; boundary="HAg1AB6g4t3iNbjQvkTTAZOSi4gvEug0y";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Bharat Kumar Gogada <bharatku@xilinx.com>
Message-ID: <90363c9d-4084-dd2f-9956-42de2841bfc6@monstr.eu>
Subject: Re: [PATCH] microblaze/PCI: Remove stale pcibios_align_resource()
 comment
References: <20180820094729.362-1-lorenzo.pieralisi@arm.com>
In-Reply-To: <20180820094729.362-1-lorenzo.pieralisi@arm.com>

--HAg1AB6g4t3iNbjQvkTTAZOSi4gvEug0y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.8.2018 11:47, Lorenzo Pieralisi wrote:
> commit 01cf9d524ff0 ("microblaze/PCI: Support generic Xilinx AXI PCIe H=
ost
> Bridge IP driver")
>=20
> and
>=20
> commit ecf677c8dcaa ("PCI: Add a generic weak pcibios_align_resource()"=
)
>=20
> first patched then removed pcibios_align_resource() from the microblaze=

> architecture code but failed to remove the comment that was added to
> it.
>=20
> Remove it since it has now become stale and it is quite confusing.
>=20
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Bharat Kumar Gogada <bharatku@xilinx.com>
> Cc: Michal Simek <monstr@monstr.eu>
> ---
>  arch/microblaze/pci/pci-common.c | 13 -------------
>  1 file changed, 13 deletions(-)
>=20
> diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci=
-common.c
> index f34346d56095..2ffd171af8b6 100644
> --- a/arch/microblaze/pci/pci-common.c
> +++ b/arch/microblaze/pci/pci-common.c
> @@ -597,19 +597,6 @@ static void pcibios_fixup_resources(struct pci_dev=
 *dev)
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pcibios_fixup_resourc=
es);
> =20
> -/*
> - * We need to avoid collisions with `mirrored' VGA ports
> - * and other strange ISA hardware, so we always want the
> - * addresses to be allocated in the 0x000-0x0ff region
> - * modulo 0x400.
> - *
> - * Why? Because some silly external IO cards only decode
> - * the low 10 bits of the IO address. The 0x00-0xff region
> - * is reserved for motherboard devices that decode all 16
> - * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
> - * but we want to try to avoid allocating at 0x2900-0x2bff
> - * which might have be mirrored at 0x0100-0x03ff..
> - */
>  int pcibios_add_device(struct pci_dev *dev)
>  {
>  	dev->irq =3D of_irq_parse_and_map_pci(dev, 0, 0);
>=20

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--HAg1AB6g4t3iNbjQvkTTAZOSi4gvEug0y--

--d8Es5vfkPIxYq7uszv67lK9J3s4ZutWir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlt7sDgACgkQykllyylKDCGhjgCeKjqyZmbyVEnAFglymMYC5F1p
jDQAoIIaUQs+8cz/04gx/FH4FfZBE4RI
=x0Ui
-----END PGP SIGNATURE-----

--d8Es5vfkPIxYq7uszv67lK9J3s4ZutWir--
